
import sys
import subprocess
from urllib.parse import urlparse, unquote
import os


def fix_mojibake(text):
    """
    Исправляет UTF-8, ошибочно прочитанный как Windows-1251.

    Например:
        РЁРјРѕС‚РєРё
    ->
        Шмотки
    """

    if not text:
        return text

    try:
        return text.encode("cp1251").decode("utf-8")
    except (UnicodeEncodeError, UnicodeDecodeError):
        return text


def main():
    if len(sys.argv) < 2:
        return

    url = sys.argv[1]

    print("=" * 60)
    print("HNG HANDLER")
    print("=" * 60)

    print("URL:", repr(url))

    parsed = urlparse(url)

    print("scheme:", repr(parsed.scheme))
    print("netloc:", repr(parsed.netloc))
    print("path:", repr(parsed.path))

    if parsed.scheme.lower() != "hng":
        return

    if parsed.netloc.lower() != "notepad":
        return

    # URL decode
    file_path = unquote(parsed.path)

    print()
    print("После URL decode:", repr(file_path))

    # /D:/Byster/... -> D:/Byster/...
    if len(file_path) >= 3 and file_path[0] == "/" and file_path[2] == ":":
        file_path = file_path[1:]

    # Исправляем испорченный UTF-8
    file_path = fix_mojibake(file_path)

    # URL path -> Windows path
    file_path = file_path.replace("/", "\\")

    # Нормализация пути
    file_path = os.path.normpath(file_path)

    print()
    print("Итоговый путь:", repr(file_path))
    print("Существует:", os.path.exists(file_path))

    # Если файла нет — создаём
    if not os.path.exists(file_path):
        print()
        print("ФАЙЛ НЕ НАЙДЕН — СОЗДАЮ...")

        try:
            # Создаём все отсутствующие папки
            parent_dir = os.path.dirname(file_path)

            if parent_dir:
                os.makedirs(parent_dir, exist_ok=True)

            # Создаём пустой файл
            with open(file_path, "w", encoding="utf-8"):
                pass

            print("Файл создан:", repr(file_path))

        except Exception as e:
            print()
            print("!!! ОШИБКА СОЗДАНИЯ ФАЙЛА !!!")
            print(type(e).__name__ + ":", str(e))
            input("Нажми Enter для закрытия...")
            return

    # Открываем Notepad
    print()
    print("Открываю файл...")

    subprocess.Popen([
        r"C:\Windows\System32\notepad.exe",
        file_path
    ])


if __name__ == "__main__":
    main()

