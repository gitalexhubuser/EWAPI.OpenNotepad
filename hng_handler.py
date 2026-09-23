import sys
import subprocess
from urllib.parse import urlparse, unquote


def main():
    if len(sys.argv) < 2:
        return

    url = sys.argv[1]

    print("HNG URL:", url)

    parsed = urlparse(url)

    if parsed.scheme.lower() != "hng":
        return

    if parsed.netloc.lower() != "notepad":
        return

    # hng://notepad/C:/test.txt
    file_path = unquote(parsed.path)

    if file_path.startswith("/"):
        file_path = file_path[1:]

    print("Открываю:", file_path)

    subprocess.Popen(["notepad.exe", file_path])


if __name__ == "__main__":
    main()