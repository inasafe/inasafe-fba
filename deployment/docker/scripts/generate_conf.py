#!/usr/bin/env python3
import sys
import os
from jinja2 import Environment, FileSystemLoader


if __name__ == '__main__':
    search_path = sys.argv[1]
    template_name = sys.argv[2]
    output_path = sys.argv[3]
    env = Environment(loader=FileSystemLoader(search_path))
    template = env.get_template(template_name)
    output = template.render(os.environ)

    with open(output_path, 'w') as f:
        f.write(output)
