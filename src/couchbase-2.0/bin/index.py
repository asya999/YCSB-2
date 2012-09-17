import sys
import json

import requests


def main():
    hostname = sys.argv[-1]
    base_url = "http://{0}:8092/default/_design/".format(hostname)
    for ddoc_name in ["A", "B", "C"]:
        url = base_url + ddoc_name
        payload = {
            "views": {
                "A": {
                    "map": "function (doc) { emit(doc.id, null); }"
                },
                "B": {
                    "map": "function (doc) { emit(doc.id, null); }"
                },
                "C": {
                    "map": "function (doc) { emit(doc.id, null); }"
                }
            }
        }
        headers = {'Content-Type': 'application/json'}

        r = requests.put(url, data=json.dumps(payload), headers=headers)
        print r.status_code


if __name__ == '__main__':
    main()
