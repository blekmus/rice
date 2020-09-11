import os
from sys import argv


def which_option(argv, options):
    for key, val in options.items():
        if argv[1] in val:
            option = key
            break

    try:
        option
    except UnboundLocalError:
        return False
    else:
        return option


def delete(argv):
    with open('todo', 'r') as file:
        filedata = file.readlines()

    try:
        argv[2]
    except IndexError:
        dline = int(input('Enter task number to delete\n> '))

        if dline == '':
            print('todo: Input cannot be empty')
            return

        edited_data = []
        for line in filedata:
            if not line == filedata[dline - 1]:
                edited_data.append(line)

        with open('todo', 'w') as file:
            file.writelines(edited_data)
    else:
        dline = int(argv[2])

        edited_data = []
        for line in filedata:
            if not line == filedata[dline - 1]:
                edited_data.append(line)

        with open('todo', 'w') as file:
            file.writelines(edited_data)


def add(argv):
    try:
        argv[2]
    except IndexError:
        nline = input('Enter new task\n> ')

        if nline == '':
            print('todo: Input cannot be empty')
            return

        with open('todo', 'a') as file:
            file.write(nline)
    else:
        dline = argv[2]

        with open('todo', 'a') as file:
            file.write(dline)


def edit(script_dir):
    os.system(f'micro {script_dir}/todo')
    print('todo: File updated')


def helper():
    help_text = """usage: todo [options] [values]*

options:
    [] - list current tasks
    [-h, --help] - shows this
    [-d, --delete] - deletes a task
    [-e, --edit] - opens todo file in editor
    [-a, --add] - adds new task

* if no value is given, input is taken interactively"""
    return help_text


def main(argv):
    options = {
        '1': ['-d', '--delete'],
        '2': ['-a', '--add'],
        '3': ['-e', '--edit'],
        '4': ['-h', '--help']
    }

    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)

    if len(argv) > 3:
        return "todo: Invalid arguments were given"
    elif len(argv) == 1:
        with open('todo') as file:
            filedata = file.readlines()

        for num, line in enumerate(filedata):
            print(str(num + 1) + ' - ' + line.strip('\n'))

        return True

    option = which_option(argv, options)

    if not option:
        print('todo: Invalid arguments were given\n')
        return helper()
    elif option == '1':
        delete(argv)
    elif option == '2':
        add(argv)
    elif option == '3':
        edit(script_dir)
    elif option == '4':
        print(helper())

    return True


out = main(argv)
if out is not True:
    print(out)
