"""Strip an HTML page to comparable plain text for the monitor Action.

stdlib only (runs on a bare GitHub runner). Drops script/style/noscript,
collapses whitespace, one text block per line, so diffs reflect content
changes rather than markup noise. Markdown/plain inputs pass through with
the same whitespace normalization.

Usage: python3 html_to_text.py <input-file> <output-file>
"""
import sys
from html.parser import HTMLParser


class TextExtractor(HTMLParser):
    SKIP = {"script", "style", "noscript", "template"}

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.parts = []
        self.skip_depth = 0

    def handle_starttag(self, tag, attrs):
        if tag in self.SKIP:
            self.skip_depth += 1

    def handle_endtag(self, tag):
        if tag in self.SKIP and self.skip_depth > 0:
            self.skip_depth -= 1

    def handle_data(self, data):
        if self.skip_depth == 0:
            text = " ".join(data.split())
            if text:
                self.parts.append(text)


def main():
    src, dst = sys.argv[1], sys.argv[2]
    with open(src, encoding="utf-8", errors="replace") as f:
        raw = f.read()

    if "<html" in raw[:2000].lower() or "<!doctype" in raw[:200].lower():
        parser = TextExtractor()
        parser.feed(raw)
        lines = parser.parts
    else:
        lines = [" ".join(line.split()) for line in raw.splitlines() if line.strip()]

    with open(dst, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")


if __name__ == "__main__":
    main()
