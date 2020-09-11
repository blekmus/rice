from shutil import copyfile, move
from sys import argv
import os
from datetime import datetime


def check_current_wall():
    print('wall: Checking for existing walls')
    with os.scandir() as dirs:
        for entry in dirs:
            if entry.name.startswith('wall'):
                return True

    print('wall: No existing wall found')
    return False


def update_current_wall(argv):
    print('wall: Updating current wall')
    with os.scandir() as dirs:
        for entry in dirs:
            if entry.name.startswith('wall'):
                old_wall_suffix = entry.name.split('.')[1]

    old_wall_name = f"until_{datetime.now().strftime('%Y_%m_%d')}.{old_wall_suffix}"
    move(f'wall.{old_wall_suffix}', old_wall_name)

    new_wall_suffix = argv.split('.')[-1]
    copyfile(argv, f'./wall.{new_wall_suffix}')

    return old_wall_suffix, new_wall_suffix


def update_wm_config(old_suffix, new_suffix, script_dir):
    prnit("wall: Updating i3 config")
    os.chdir(os.path.join(os.path.dirname(script_dir), 'i3'))

    with open('config', 'r') as file:
        filedata = file.read()

    filedata = filedata.replace(f'wall.{old_suffix}', f'wall.{new_suffix}')

    with open('config', 'w') as file:
        file.write(filedata)


def add_new_wall(argv):
    print("wall: Adding new wall")
    new_wall_suffix = argv.split('.')[-1]
    copyfile(argv, f'./wall.{new_wall_suffix}')

    return new_wall_suffix


def append_wm_config(script_dir, new_suffix):
    print("wall: Appending wall to i3 config")
    os.chdir(os.path.join(os.path.dirname(script_dir), 'i3'))

    with open("config", "r") as file:
        lines = file.readlines()

    filedata = []
    for line in lines:
        if not line.strip("\n").startswith("exec_always feh") or not line.strip("\n").startswith("# start feh to"):
            filedata.append(line)

    filedata.append(f"# start feh to display background")
    filedata.append(f"exec_always feh --bg-fill ~/.config/feh/wall.{new_suffix}")

    with open("config", "w") as file:
        file.write(filedata)


def main(argv):
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)

    if check_current_wall():
        old_suffix, new_suffix = update_current_wall(argv)
        update_wm_config(old_suffix, new_suffix, script_dir)
        return "wall: Wall successfully changed"
    else:
        new_suffix = add_new_wall(argv)
        append_wm_config(script_dir, new_suffix)
        return "wall: Wall added successfully"


print(main(argv))
