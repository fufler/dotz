#!/usr/bin/env python3

import asyncio
import subprocess
import os
import sys
import json
import os.path
from dbus_next.aio import MessageBus
from dbus_next import Message, BusType


async def handle_dbus_events():
    bus = await MessageBus(bus_type=BusType.SESSION).connect()

    def message_handler(msg):
        subprocess.run(["pkill", "-SIGRTMIN+1", "waybar"])

    await bus.call(
        Message(
            destination="org.freedesktop.DBus",
            path="/org/freedesktop/DBus",
            member="AddMatch",
            signature="s",
            body=["interface='org.freedesktop.portal.NetworkMonitor'"],
        )
    )

    bus.add_message_handler(message_handler)

    await asyncio.get_event_loop().create_future()


async def handle_hypr_events():
    xdg_runtime_dir = os.environ["XDG_RUNTIME_DIR"]
    his = os.environ["HYPRLAND_INSTANCE_SIGNATURE"]

    socket_path = os.path.join(xdg_runtime_dir, "hypr", his, ".socket2.sock")

    reader, _ = await asyncio.open_unix_connection(path=socket_path)

    while True:
        data = await reader.readline()

        if not data:
            sys.exit(1)

        event = data.decode().split(">>")[0]

        if event not in ["openwindow", "closewindow", "movewindow"]:
            pass

        clients = json.loads(subprocess.check_output(["hyprctl", "clients", "-j"]))
        workspaces = json.loads(
            subprocess.check_output(["hyprctl", "workspaces", "-j"])
        )

        workspaces_names = {}

        for workspace in workspaces:
            workspaces_names[workspace["id"]] = workspace["name"]

        workspaces_with_overlay = set()

        for client in clients:
            workspace_name = client["workspace"]["name"]

            if not workspace_name.startswith("special:overlay-"):
                continue

            workspaces_with_overlay.add(int(workspace_name.split("-")[1]))

        for workspace_id in range(1, 13):
            workspace_name = workspaces_names[workspace_id]

            new_workspace_name = (
                workspace_name[:-1] if workspace_name[-1] == "*" else workspace_name
            )

            new_workspace_name += "*" if workspace_id in workspaces_with_overlay else ""

            if new_workspace_name != workspace_name:
                subprocess.check_output(
                    [
                        "hyprctl",
                        "dispatch",
                        "renameworkspace",
                        str(workspace_id),
                        new_workspace_name,
                    ]
                )


async def handle_acpi_events():
    reader, _ = await asyncio.open_unix_connection(path="/var/run/acpid.socket")

    LID = "-lid-"

    while True:
        data = await reader.readline()

        if not data:
            sys.exit(1)

        event = data.decode().split()

        if event[0] != "button/lid":
            continue

        try:
            active_profile = (
                subprocess.check_output(["kanshictl", "status"])
                .decode()
                .split("\n")[0]
                .split(":")[-1]
                .strip()
            )
        except Exception:
            continue

        if "-lid-" not in active_profile:
            continue

        new_profile = active_profile[: active_profile.index(LID) + len(LID)]

        if "close" in event:
            new_profile += "closed"
        else:
            new_profile += "open"

        subprocess.call(["kanshictl", "switch", new_profile])


async def main():
    tasks = [handle_dbus_events(), handle_hypr_events(), handle_acpi_events()]

    await asyncio.gather(*tasks)


asyncio.run(main())
