import sys
import json

import requests


def main():
    hostname = sys.argv[-1]
    base_url = "http://{0}:8092/default/_design/".format(hostname)
    for id, ddoc_name in enumerate(("A", "B", "C")):
        url = base_url + ddoc_name
        payload = {
            "views": {
                "A": {
                    "map": "function (doc, meta) {{ emit(doc.field{0}, null); }}".format(3 * id)
                },
                "B": {
                    "map": "function (doc, meta) {{ emit(doc.field{0}, null); }}".format(1 + 3 * id)
                },
                "C": {
                    "map": "function (doc, meta) {{ emit(doc.field{0}, null); }}".format(2 + 3 * id)
                }
            }
        }
        headers = {'Content-Type': 'application/json'}

        r = requests.put(url, data=json.dumps(payload), headers=headers)
        print r.status_code


if __name__ == '__main__':
    main()
