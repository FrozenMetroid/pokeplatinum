from pathlib import Path

INPUT = Path("include/data/map_headers.h")
OUTPUT = Path("include/data/map_headers_expanded.h")

def process(lines):
    out = []

    for line in lines:
        stripped = line.strip()

        out.append(line)

        # Insert followMode  after isflyAllowed
        if stripped.startswith(".isFlyAllowed"):
            indent = 
            out.append(f"{indent}.followMode = MAP_FOLLOWMODE_ALLOW,\n")
            out.append(f"{indent}.padding = 0,\n")

    return out

def main():
    lines = INPUT.read_text(encoding="utf-8").splitlines(keepends=True)
    new_lines = process(lines)
    OUTPUT.write_text("".join(new_lines), encoding="utf-8")
    print("Done.")

if __name__ == "__main__":
    main()