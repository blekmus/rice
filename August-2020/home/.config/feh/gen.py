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
    print("wall: Updating i3 config")
    os.chdir(os.path.join(os.path.dirname(script_dir), 'i3'))

    with open('config', 'r') as file:
        filedata = file.read()

    if f'wall.{old_suffix}' in filedata:
        filedata = filedata.replace(f'wall.{old_suffix}', f'wall.{new_suffix}')
    else:
        filedata = filedata + "# start feh to display background\n" + f"exec_always feh --bg-fill ~/.config/feh/wall.{new_suffix}\n"

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
        if not (line.strip("\n").startswith("exec_always feh") or line.strip("\n").startswith("# start feh")):
            filedata.append(line)

    filedata.append("\n# start feh to display background\n")
    filedata.append(f"exec_always feh --bg-fill ~/.config/feh/wall.{new_suffix}\n")

    with open("config", "w") as file:
        file.writelines(filedata)


def main(argv):
    if len(argv) != 2:
        return "wall: Invalid arguments were given"

    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)

    if check_current_wall():
        old_suffix, new_suffix = update_current_wall(argv[1])
        update_wm_config(old_suffix, new_suffix, script_dir)
        return "wall: Wall successfully changed"
    else:
        new_suffix = add_new_wall(argv[1])
        append_wm_config(script_dir, new_suffix)
        return "wall: Wall added successfully"


print(main(argv))
