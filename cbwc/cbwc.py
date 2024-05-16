# CBWC: ClipBoard Word Count
# ==========================
# Counts the number of words in the text that is currently copied in
# the clipboard.

import subprocess


def cbwc():
    clipboard_text = subprocess.Popen(
            ["xclip", "-o"],
            stdout=subprocess.PIPE
    ).communicate()[0]

    print(len(clipboard_text.split()))


if __name__ == "__main__":
    cbwc()

