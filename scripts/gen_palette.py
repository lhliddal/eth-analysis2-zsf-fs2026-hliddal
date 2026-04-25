def hsl_to_hex(h, s, l):
    import colorsys
    r, g, b = colorsys.hls_to_rgb(h/360, l, s)
    return f"{int(r*255):02X}{int(g*255):02X}{int(b*255):02X}"

print("Base colors:")
for i in range(20):
    h = (i * 360 / 20)
    # Give them slightly alternating lightness and saturation to distribute perception
    print(f"\\definecolor{{ChapterColor{i}}}{{HTML}}{{{hsl_to_hex(h, 0.8, 0.35)}}}")

print("\nLight colors:")
for i in range(20):
    h = (i * 360 / 20)
    print(f"\\definecolor{{ChapterColor{i}Light}}{{HTML}}{{{hsl_to_hex(h, 0.5, 0.88)}}}")
