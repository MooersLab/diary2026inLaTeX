![Version](https://img.shields.io/static/v1?label=diary2026inLaTeX&message=0.1&color=brightcolor)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)


# Diary for 2026 in LaTeX

## Purpose 
Provide a ready to use diary template for 2026.
Each month is a chapter, and each day is a section in a chapter.

## Features
- a hyperlinked table of contents for fast navigation in the PDF
- auto generated subject index
- glossary of terms
- list of acronyms
- mathematical symbols
- support for code listings with the minted package
- support for including images
- support for tables using booktabs package
- support for using BibTeX to insert citations it is a literature-cited section
- support for a compact page layout that saves paper (single spacing within paragraphs but blank lines between paragraphs for easier reading and half inch borders to support up to a thousand words per page).
- The preamble has been streamlined compared to prior years. It can be augmented with additional packages for further customization.

## Compile locally with texlive

This document can be compiled on your local machine using TeXLive.

## Compile locally from inside a text editor

These files should work with LaTeX editors like TexMaker.
These files should also work with many leading general purpose text editors like VS Code, Sublime Text, TextMate, Vim, Pulsar, and NeoVim.

The following works with Emacs, the world's most extensible text editor.
The master or main document is main.tex.
Open this file and run `C-c C-c`.
This is shorthand for press down the control key while hitting the `c` key twice.
What appears to be four keystrokes are actually three.
Emacs keybindings are much easier to use than at first glance.

This triggers a list of options.
Select `XeLaTeX + Makeindex + BibTeX` if you want all the features in this template.
The preamble in `main.tex` is configured to use XeLaTeX to enable the use of the popular `minted` package for code listings.
Adjust the preamble to use another compiler.

You may have to compile twice the first time to generate the table of contents.

## Compile on Overleaf

Create a zip file of the contents of this repository and upload this zip file when creating a new project on Overleaf.
For a project name, I use 2026words.
This is also the name of the directory in my home directory where I store the git cloned repository from Overleaf.

To run on Overleaf, you may need to change the bottom of the main.tex file to the following:

```latex
%%% Local Variables:
%%% mode: XeLaTeX
%%% TeX-command-extra-options: "--jobname=main"
%%% TeX-master: t
%%% End:
```

You may also need to compile twice to get the table contents to appear in the second edition of the PDF.

## Glossaries

Support for acronyms, glossaries, and symbols is provided.
Comment out the corresponding make commands in `0AAAcontent.tex` if you do not want these.

## Limits

The main limit will be available RAM.
When RAM is limited, you might have to comment out certain blocks a month to free up memory.
The generation of labels, reference cited sections, lists of various types, and index entries consumes a lot of RAM.
You may not be able to utilize all of these features.

The limits are unknown to me in terms of the size of the PDF file that can be generated.
I have generated PDFs that contain over 1500 pages and 1.5 million words.
The resulting file can be scrolled easily in Adobe Reader, Preview, or Skim.


## Debugging

The file `0AAAcontent.tex` controls the order with which the months are imported.
You can comment out entries for entire months when you are trucking down bugs in your LaTeX code.

## Related repos

- [2024 Diary](https://github.com/MooersLab/diary2024inLaTeX)

## Directory Structure

The top level has the main.tex file, the style files, class files, and the glossaries.
The `./Content` folder has the heart of the diary.
The `0AAAcontents.tex` file controls the PDF assembly order.
The month subfolder contains the daily files and a month file that controls the order of the daily pages.
This enables the `0AAAcontents.tex` file to import the month file only in order to activate the importing of the daily pages.
This nested approach saves space in the `0AAAcontents.tex` file.

## Inclusion of additional documents for periodic review

You can add additional documents that you might want to have near your daily entries because their proximity may trigger updating these documents.
These documents could be added as separate chapters in the main body of the document or they can be added to the appendix.
If they are added to the appendix, they will be enumerated with letters rather than numbers.
Examples of such auxiliary files that are related to the events that occur throughout the year are as follows:

- new year's resolutions
- annual goals
- semester goals
- upcoming deadlines
- dates of annual meetings
- narrative sections of your annual report
- drafts of annual grant reports
- the current draft of your promotion dossier
- current drafts of your summary statement for your different research programs
- current CV or biosketch.

## Use as a planning document

The inclusion of goals and deadlines falls under the category of planning.
I do a lot of planning in my daily entries, but I try to manage the to-do lists and record of accomplishments in a separate org-mode log file.
Org-mode is a very powerful markup language like Markdown but much more powerful.
It has fantastic support for the interactive building of tables, which are painful to build in Markdown as well as in LaTeX.
Of course you could always build your tables in org-mode, and then export them to LaTeX when they are finished.

I have tried using this org-mode planning document for the past year. 
I have not been very good at updating the org-mode log file with my list of to-do items that I have enumerated in my daily writing entry.
I tend to have that daily writing entry open all day, and I check off those items that I finish as I go along.
It is pretty obvious that the friction of copying pasting such lists from the daily writing log file to the org-mode file has been a problem for me.
This is a good example where context switching is a problem.

I was trying to do weekly planning inside of the org-mode file.
This planning document is a single file for the year.
In principle, it could span multiple years and some people do that.
Having all the to-do list in a single file eases moving unfinished items from one week to the next.
In principle, you can turn these to-dos into TODO items that appear in org-agenda.
Most people have too many to-dos and get too bogged down in managing these in org-agenda.
I was hoping to use org-agenda in the past year, but I failed to use it much.

There is no reason why you cannot store the weekly plans in a LaTeX file.
This weekly planning file could be included in the appendix.
You can write functions that would read through your daily entries of the past week and extract all the unfinished to-do items and insert them into the beginning of the weekly plan for the current week so that you could review them.

If you spend a lot of time reading the PDF that is generated, then you might want to have the weekly plan interleaved with your daily entries.
This can be done by editing the month chapter document that imports the daily entry files.

I will not guarantee that the inclusion of such documents that should be reviewed periodically in this diary will necessarily lead to them being reviewed periodically.
Although this document can reduce the friction of such periodic reviews, you have to provide the discipline to do those reviews.

## Directory structure to second level

The individual daily pages are at the third level.
This balkanization eases the locating of bugs.

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

## Binding

I have no experience with trying to bind the hard copy of a year's entries.
I fantasize about being able to page through a bound copy.
There might be something tactilely satisfying about being able to do so.
However, it is quite likely that I would never use it.
The features available in the PDF are so much more convenient.

If the margins are too narrow for proper binding, you can reset the geometry parameter at the top of the preamble.
There are ways to make it asymmetric so that the edge that is bound as a wider margin than the outer edge.

I have been inhibited from binding my year's writing because I have not yet edited those entries.
Part of the dilemma is that some of the entries are first drafts that wind up being carried over into the final destination document.
The entries in the final destination documents are further edited, so there may be no longer correspondence between the two versions.

In my fantasy world, I would spend my Christmas break doing this activity.
I usually have too many professional obligations still impinging upon me during my Christmas break to get this done.
With a task this large, it is best to break it up into smaller parts.

## Editing the daily entries

It is best to deal with grammar errors and spelling errors on the same day the entry is generated.
Do not worry about these errors during the heat of generating the words.
The generation of the words involves a different part of the brain than the editing of the words.
It is best not to mix the two activities: it is better to keep them separated temporally.
You will find this division of labor to leave you with more energy.

Deal with these errors after you are finished with your generative writing session.
This tedious editing process is greatly eased by software tools like Grammarly and LanguageTool.
You can probably clean up an entry of 2500 words in about 15 minutes.
You just have to make the time to incorporate this editing phase into your daily workflow.

There may be larger structural changes that you want to make to the writing at a later point in time.
Such larger changes could be done during a weekly planning session that is initiated by reviewing the week's prior entries to see what was accomplished and what was left unfinished.
The break of several days from when you generated the text may provide new perspective.
You may also identify passages that are redundant and that you may want to delete because their attention is of little value.

If you do not gather up what was unfinished, there is the risk that these to-dos will be left behind. 
This also can reduce the time spent on regenerating those unfinished to-do items.

## Use of AI and RAG

It is useful to think of a LaTeX document as a computer program.
After all, you do use a LaTeX compiler to convert it into a PDF.

Overleaf and Emacs provide strong support for finding bugs.
However, sometimes the error messages are cryptic.
LLMs are great at debugging computer code.
If you cannot figure out what is wrong with your current \LaTeX document, you can load up the error messages and your current document to an LLM and have it returned suggestions as to how you can correct your document.

You can also use LLMs to generate customized functions to ease the use of LaTeX in your favorite text editor.
Most text editors can be extended with plugins that you can have the LLM generate for you.

In principle, you could feed your PDF into a LLM via RAG to facilitate the retrieval of information through semantic searches that you cannot do with acrobat reader.
Most LLMs currently do not have the capacity to read such a large document as what I generate in a year.
They may be able to handle a few months.
Their ability to handle large documents increases every year.
Of course you want to do this locally so that your private thoughts are not incorporated into the next LLM.


## Status

These files compile in Overleaf with the above admendment, and they compile in Emacs by calling texlive on a Mac.


## Update history

|Version      | Changes                                                                                                                                    | Date                 |
|:-----------:|:------------------------------------------------------------------------------------------------------------------------------------------:|:--------------------:|
| Version 0.1 |  Added funding  and update table. Extensive edits of the README.md.                                                                        | 2026 January 3           |

## Funding
- NIH: R01 CA242845, R01 AI088011
- NIH: P30 CA225520 (PI: R. Mannel); P30GM145423 (PI: A. West)

