#!/usr/bin/env python

import os
from subprocess import check_output

welcome_page_path = "/workspace/BioDynaMo-welcome.md"
script_dir = os.path.dirname(os.path.realpath(__file__))

def read(path):
    with open(path, 'r') as file:
        return file.read()

main = read('{}/main.md'.format(script_dir))

nb_env = os.getenv("BDM_TRY_NOTEBOOK")
demo_env = os.getenv("BDM_TRY_DEMO")

action_instructions = ""
if nb_env is not None:
    notebook = read('{}/try-notebook.md'.format(script_dir))
    url = check_output(["notebook-url", nb_env]).decode('utf8')
    action_instructions = notebook.format(nb_env, url)
elif demo_env is not None:
    demo = read('{}/try-demo.md'.format(script_dir))
    action_instructions = demo.format(demo_env)

url = check_output(["notebook-url"]).decode('utf8')
main = main.format(action_instructions, url)

with open(welcome_page_path, 'w') as file:
    file.write(main)
