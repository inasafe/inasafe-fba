#!/usr/bin/env python3
from utils import GeoServerRESTRunner

if __name__ == '__main__':

    runner = GeoServerRESTRunner()
    with runner.session() as s:
        response = runner.assert_get(s, '/workspaces/kartoza')

        if response.ok:
            print('Resource exists.')
            print()
            exit(0)

        # Create workspace
        data = {
            'workspace': {
                'name': 'kartoza'
            }
        }

        response = runner.assert_post(
            s,
            '/workspaces',
            json=data,
            validate=True
        )

        runner.print_response(response)

        exit(not response.ok)
