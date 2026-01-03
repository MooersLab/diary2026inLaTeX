![Version](https://img.shields.io/static/v1?label=diary2026inLaTeX&message=0.1&color=brightcolor)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)


# Diary for 2026 in LaTeX

## Purpose 

Compile a 365-page diary for 2026, one page per day.
Each month is a chapter, and each day is a section in a chapter.

## Compile locally with texlive

This document can accommodate at least 1500 pages and 1.5 million words and can be compiled on your local machine using TeXLive.

## Compile locally with Emacs

The master or main document is main.tex.
Open this file and run C-c C-c.
This triggers a list of options.
Select XeLaTeX + Makeindex + BibTeX.
The preamble in main.tex is configured to use XeLaTeX to enable the minted package for code listings.
Adjust the preamble to use another compiler.

You may have to compile twice the first time to generate the table of contents.

## Glossaries

Support for acronyms, glossaries, and symbols is provided.
Comment out the corresponding make commands in 0AAAcontent.tex if you do not want these.

## Related repos

- [2024 Diary](https://github.com/MooersLab/diary2024inLaTeX)

## Directory Structure

The top level has the main.tex file, the style files, class files, and the glossaries.
The `./Content` folder has the heart of the diary.
The 0AAAcontents.tex file controls the PDF assembly order.
The month subfolder contains the daily files and a month file that controls the order of the daily pages.

```bash
├── Content
│   ├── 0AAAcontents.tex
│   ├── April
│   ├── August
│   ├── December
│   ├── February
│   ├── January
│   ├── July
│   ├── June
│   ├── March
│   ├── May
│   ├── November
│   ├── October
│   ├── Preface.tex
│   └── September
├── epipart.sty
├── latexmarkdn.sty
├── latexmkrc
├── main-acronyms.tex
├── main-constants.tex
├── main-epigraphs.tex
├── main-glossary.tex
├── main-symbols.tex
├── main.tex
├── README.md
├── spbasic.bst
└── svmono.cls
```

## Update history

|Version      | Changes                                                                                                                                    | Date                 |
|:-----------:|:------------------------------------------------------------------------------------------------------------------------------------------:|:--------------------:|
| Version 0.1 |  Added funding  and update table. Extensive edits of the README.md.                                                                        | 2026 January 3           |

## Funding
- NIH: R01 CA242845, R01 AI088011
- NIH: P30 CA225520 (PI: R. Mannel); P30GM145423 (PI: A. West)

