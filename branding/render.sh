#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
python3 - << 'PY'
import cairosvg, io
from PIL import Image
png = cairosvg.svg2png(url='lyra-splash.svg', output_width=640, output_height=480)
img = Image.open(io.BytesIO(png)).convert('RGBA')
bg = Image.new('RGB', img.size, (0, 0, 0))
bg.paste(img, mask=img.split()[3])
bg.save('../iso/syslinux/splash.png', 'PNG')
print('-> iso/syslinux/splash.png')
PY
