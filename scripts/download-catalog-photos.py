"""Download pinned CC0 source photos for catalog curation (original bytes)."""
import concurrent.futures
import json
from pathlib import Path
import urllib.request

ROOT = Path(__file__).resolve().parents[1]
tree = json.loads((ROOT / 'scripts/clothing-source-tree.json').read_text())
DEST = ROOT / '.catalog-work'
DEST.mkdir(exist_ok=True)
files = [x['path'] for x in tree['tree'] if x['path'].endswith('.jpg')]

def download(path):
    target = DEST / path
    target.parent.mkdir(exist_ok=True)
    if not target.exists():
        url = f"https://raw.githubusercontent.com/lightly-ai/dataset_clothing_images/{tree['sha']}/{path}"
        target.write_bytes(urllib.request.urlopen(url, timeout=60).read())
    return path

if __name__ == '__main__':
    with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:
        print('Downloaded', len(list(pool.map(download, files))), 'original photos')
