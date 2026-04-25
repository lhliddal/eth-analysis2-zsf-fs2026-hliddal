import re

with open('styles/40_colors_structure.tex', 'r') as f:
    text = f.read()

def hsl_to_hex(h, s, l):
    import colorsys
    r, g, b = colorsys.hls_to_rgb(h/360, l, s)
    return f"{int(r*255):02X}{int(g*255):02X}{int(b*255):02X}"

colors_str = ""
for i in range(20):
    h = (i * 360 / 20)
    l = 0.35 if i % 2 == 0 else 0.45
    s = 0.85
    colors_str += f"\\definecolor{{ChapterColor{i}}}{{HTML}}{{{hsl_to_hex(h, s, l)}}}\n"
    colors_str += f"\\definecolor{{ChapterColor{i}Light}}{{HTML}}{{{hsl_to_hex(h, 0.45, 0.88)}}}\n"

# In old_colors_regex, grab from ChapterColor0 up to the end of ChapterColor11Light
start_idx = text.find('\\definecolor{ChapterColor0}')
end_idx = text.find('\\definecolor{ETHRot}')
if start_idx != -1 and end_idx != -1:
    text = text[:start_idx] + colors_str + text[end_idx:]

text = text.replace('\\newcommand{\\ZSFchapterPaletteSize}{12}', '\\newcommand{\\ZSFchapterPaletteSize}{20}')

ifcase_str = "\\newcommand{\\ZSFSetChapterPaletteByIndex}[1]{%\n  \\ifcase#1\n"
ifcase_str += "    \\renewcommand{\\chaptercolor}{ChapterColor0}%\n    \\renewcommand{\\chaptercolorlight}{ChapterColor0Light}%\n"
for i in range(1, 20):
    ifcase_str += f"  \\or\n    \\renewcommand{{\\chaptercolor}}{{ChapterColor{i}}}%\n    \\renewcommand{{\\chaptercolorlight}}{{ChapterColor{i}Light}}%\n"
ifcase_str += "  \\else\n    \\renewcommand{\\chaptercolor}{ChapterColor0}%\n    \\renewcommand{\\chaptercolorlight}{ChapterColor0Light}%\n  \\fi\n}"

# Replace the ifcase macro
start_ifcase = text.find('\\newcommand{\\ZSFSetChapterPaletteByIndex}')
end_ifcase = text.find('\\newcommand{\\SetChapterPaletteByNumber}')
if start_ifcase != -1 and end_ifcase != -1:
    text = text[:start_ifcase] + ifcase_str + "\n\n" + text[end_ifcase:]

with open('styles/40_colors_structure.tex', 'w') as f:
    f.write(text)
