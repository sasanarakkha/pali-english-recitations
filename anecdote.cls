% I have a LaTeX document which I would like to add detailed comments to so that future maintainers and editors can have an easy time understanding what each command and code means. Can you help me with this? I will input snippets for my formatting and styling and would like you to respond with a detailed explanation of what the code means. Add the comment above the code. To start the comment use %

% A memoir-based documentclass with a contemporary style for books with a lighter content.

% (c) Gambhiro Bhikkhu, 2017
% gambhiro.bhikkhu.85@gmail.com

% (c) Pāladhammika Bhikkhu, 2022
% paladhammika@protonmail.com

% LPPL LaTeX Public Project Licence


% Use LaTeX2e format
\NeedsTeXFormat{LaTeX2e}

% Define the document class named "anecdote"
\ProvidesClass{anecdote}[2017/08/19 v0.11 A memoir-based documentclass with a contemporary style for books.]



% Define a conditional for the digital version
\newif\ifdigitalversion
\digitalversionfalse

% Define a conditional for the A5 version formatting
\newif\ifafiveversion
\afiveversionfalse

% Define a conditional for the A6 version formatting
\newif\ifasixversion
\asixversionfalse

% Define a conditional for the B6 version formatting
\newif\ifbsixversion
\bsixversionfalse



% Load the pgfopts package, which provides a key-value interface for package options
\RequirePackage{pgfopts}

% Load the calc package, which provides advanced arithmetic operations for LaTeX
\RequirePackage{calc}

% Define pgfkeys for BOOK settings
\pgfkeys{
  /BOOK/.cd,
  % Default value for babelLanguage is 'british'
  babelLanguage/.default=british,
  % Store the value of babelLanguage in \BOOK@babelLanguage
  babelLanguage/.store in=\BOOK@babelLanguage,
  % Set digitalVersion to true if specified in options
  digitalVersion/.code=\digitalversiontrue,
  % Set A5 Version to true if specified in options
  afiveVersion/.code=\asixversiontrue,
  % Set A6 Version to true if specified in options
  asixVersion/.code=\asixversiontrue,
  % Set B6 Version to true if specified in options
  bsixVersion/.code=\bsixversiontrue,
}

% Pass all unknown options to the memoir class
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}
}

% Process pgfkeys options under /BOOK
\ProcessPgfOptions{/BOOK}

% Process other package options
\ProcessOptions\relax



% Load the digital version
\ifdigitalversion
  % Using 11pt font size, single-sided printing, and the use of old font commands
  \LoadClass[11pt,oneside,oldfontcommands]{memoir}
\else
  % Otherwise format with 11pt font size, double-sided printing, and the use of old font commands.
  \LoadClass[11pt,twoside,oldfontcommands]{memoir}
\fi

% \raggedbottom stops these warnings:
%
% Underfull \vbox (badness 10000) has occurred while \output is active
%
% by not streching the glue in vertical spaces, such as before and after chapter
% and section headings. The bottom of the pages will be uneven.
%
% Default is \flushbottom. The small streches are good because an even page
% bottom is better. When it causes large streches, it is better to put in
% a \clearpage manually.
%
% NOTE use the 'bottom' footmisc option when using \raggedbottom.

% NOTE Using \raggedbottom in this book. There are many quotes and the pages
% frequently have to break early anyway.
\raggedbottom

% \raggedbottomsection only affects pages where the section header was moved to
% the next page.
\raggedbottomsection



% Load the silence package, which provides a way to suppress LaTeX warnings
% \RequirePackage{silence}
% Turn off warnings using the \WarningsOff command from the silence package
% \WarningsOff

% Load the babel package with the language specified by \BOOK@babelLanguage
\RequirePackage[\BOOK@babelLanguage]{babel}
% Load the nag package to warn about the usage of outdated LaTeX constructs
\RequirePackage{nag}
% Load the xparse package for defining document commands with complex arguments
\RequirePackage{xparse}
% Load the soul package for letter spacing, underlining, and highlighting text
\RequirePackage{soul}
% Load the ifsym package for additional symbols
\RequirePackage[geometry]{ifsym}
% Load the STIX font package
\RequirePackage{stix}
% Load the xcolor package for color support
\RequirePackage{xcolor}
% Load the xcoffins package for creating complex layouts
\RequirePackage{xcoffins}
% Load the graphicx package for including graphics
\RequirePackage{graphicx}
% Load the eso-pic package for adding pictures to every page
\RequirePackage{eso-pic}
% Load the ccicons package for Creative Commons icons
\RequirePackage{ccicons}
% Load the multicol package for multi-column layout
\RequirePackage{multicol}
% Load the multirow package for multi-row table cells
\RequirePackage{multirow}
% Load the footnote package for footnotes
\RequirePackage{footnote}
% Load the hyphenat package for more control over hyphenation
\RequirePackage{hyphenat}
% Load the ifthen package for conditional statements
\RequirePackage{ifthen}
% Load the titletoc package for controlling the format of table of contents entries
\RequirePackage{titletoc}
% Load the enumitem package for customizing lists
\RequirePackage{enumitem}
% Load the longtable package for tables that span multiple pages
\RequirePackage{longtable}
% Load the environ package for defining environments with body manipulations
\RequirePackage{environ}
% Load the pageslts package for access to page labels
\RequirePackage{pageslts}
% Load the array package for more flexible column formatting in tables
\RequirePackage{array}
% Load the ragged2e package for improved ragged text alignment
\RequirePackage{ragged2e}
% Load the tipa package for IPA (International Phonetic Alphabet) symbols
\RequirePackage{tipa}
% Load the float package for improved control over floating environments
\RequirePackage{float}
% Load the TikZ package for creating graphics programmatically
\RequirePackage{tikz}
% Load specific TikZ libraries
\usetikzlibrary{arrows.meta,bending,chains,positioning}
% Load the pgfornament package for drawing decorative ornaments
\RequirePackage[object=vectorian]{pgfornament}
% Load the rotating package for rotating elements, such as tables and figures
\RequirePackage{rotating}
% Load the makecell package for formatting cells in tables
\RequirePackage{makecell}
% Set the width of rotated column headings in tables
\settowidth\rotheadsize{{\small Compound}}
% Define a command for "Not Applicable" in tables
\newcommand{\NA}{---}
% Load the tabularray package for flexible tables
\RequirePackage{tabularray}
% Load the ninecolors package for defining color schemes
\RequirePackage{ninecolors}
%
\RequirePackage{import}



% Define the color for the main body text.
\definecolor{textbody}{gray}{0}% 100% for maximum contrast.
% Define the color for the rule separating footnotes.
\definecolor{footnoterule}{gray}{0.5}
% Define the color for headers.
\definecolor{header}{gray}{0}
% Define the color for footers.
\definecolor{footer}{gray}{0}
% Define the color for chapter numbers.
\definecolor{chapternum}{gray}{0.2}
% Define the color for chapter titles.
\definecolor{chaptertitle}{gray}{0.1}
% Define the color for chapter title footnotes.
\definecolor{chaptertitlefootnote}{gray}{0.4}
% Define the color for chapter authors.
\definecolor{chapterauthor}{gray}{0.3}
% Define the color for chapter notes.
\definecolor{chapternote}{gray}{0.3}
% Define the color for section headings.
\definecolor{section}{gray}{0.05}
% Define the color for the left side of the table of contents.
\definecolor{tocleftside}{gray}{0.5}
% Define the color for the left side of the table of contents for parts.
\definecolor{tocleftsidepart}{gray}{0.2}
% Define the color for the border of links.
\definecolor{linkborder}{rgb}{0.4,0.4,1}% light blue
% Define the color for links.
\definecolor{link}{rgb}{0.2,0.2,1}% not so light blue
% Define the color for instructional text or comments.
\definecolor{instruction}{gray}{0.3}



% Load the fontspec package for font handling in XeLaTeX or LuaLaTeX.
\RequirePackage{fontspec}

% Set default font features including ligatures and specify the font path.
\defaultfontfeatures{ Ligatures={TeX}, Path = {./assets/fonts/}, }

% If ligatures such as emdash and endash don't work for your font, use Renderer = Basic.
% Source: http://tex.stackexchange.com/questions/20580/how-to-enable-ligatures-for-emdash-endash-in-luatex

% Set the main font for the document.
\setmainfont[
  ItalicFont = LibertinusSerif-Italic.otf,
  BoldFont = LibertinusSerifX-Bold.ttf,
  BoldItalicFont = LibertinusSerif-BoldItalic.otf,
]{LibertinusSerifX-Regular.ttf}

% Define a new font family named 'libertinusFont'.
\newfontfamily\libertinusFont[
  ItalicFont = LibertinusSerif-Italic.otf,
  BoldFont = LibertinusSerifX-Bold.ttf,
  BoldItalicFont = LibertinusSerif-BoldItalic.otf,
]{LibertinusSerifX-Regular.ttf}

% Define a new font family named 'sbsFont'.
% Provides the font of the titlepage
\newfontfamily\sbsFont[
  ItalicFont = palisbs.ttf,
  BoldFont = palisbs.ttf,
  BoldItalicFont = palisbs.ttf,
]{palisbs.ttf}



% Define commands to set font styles for headers, footers, and page numbers.
\newcommand\headerFont\libertinusFont
\newcommand\footerFont\headerFont
\newcommand\pageNumFont\headerFont

% Define font styles for chapter and section headings.

% Part
\newcommand\partNameFont\libertinusFont
\newcommand\partTitleFont\libertinusFont

% Chapter
\newcommand\chapterNameFont\libertinusFont
\newcommand\chapterTitleFont\libertinusFont
\newcommand\chapterNumberFont\libertinusFont
\newcommand\chapterAuthorFont\libertinusFont
\newcommand\chapterNoteFont\libertinusFont

% Section
\newcommand\sectionFont\libertinusFont
\newcommand\subSectionFont\libertinusFont

% Font style for instructional text or comments.
\newcommand\instructionFont\libertinusFont

% Define font style for the side rule in quotes.
\newcommand\sideruleQuoteFont\libertinusFont

% Define font styles for the Table of Contents.

% Font for the main Table of Contents entries.
\newcommand\tocFont\libertinusFont

% Font for the old page numbers in the Table of Contents.
\newcommand\tocFontOldNum\libertinusFont


% Define font sizes for different elements in the document.

% Chapter name size
\newcommand{\chapterNameSize}{\@setfontsize          \chapterNameSize          {22}{24}}
% Chapter number size
\newcommand{\chapterNumberSize}{\@setfontsize        \chapterNumberSize        {20}{20}}
% Chapter title size
\newcommand{\chapterTitleSize}{\@setfontsize         \chapterTitleSize         {19}{19}}
% Chapter title footnote size
\newcommand{\chapterTitleFootnoteSize}{\@setfontsize \chapterTitleFootnoteSize {16}{30}}
% Chapter author size
\newcommand{\chapterAuthorSize}{\@setfontsize        \chapterAuthorSize        {12}{14}}
% Chapter note size
\newcommand{\chapterNoteSize}{\@setfontsize          \chapterNoteSize          {13}{15}}
% Footer size
\newcommand{\footerSize}{\@setfontsize               \footerSize               {11}{8}}
% Header size
\newcommand{\headerSize}{\@setfontsize               \headerSize               {11}{2}}
% Table of Contents size
\newcommand{\tocSize}{\@setfontsize                  \tocSize                  {19}{14}}
% Section/Chapter font size in Table of Contents
% e.g. 'Dedication of Offerings'
\newcommand{\tocSectionSize}{\@setfontsize           \tocSectionSize           {12.5}{15}}
% Subsection/Subchapter font size in Table of Contents
% e.g. 'Undertaking the Three Refuges'
\newcommand{\tocSubsectionSize}{\@setfontsize        \tocSubsectionSize        {11}{11}}

% Define a command to make text smaller.
\newcommand{\smaller}{\@setfontsize\smaller{9}{11}}

% Define font size for copyright notice.
\newcommand{\copyrightsize}{\@setfontsize\copyrightsize{9}{11}}

% Redefine footnote size to be smaller.
\renewcommand{\footnotesize}{%
   \@setfontsize\footnotesize{9}{11}%
   \abovedisplayskip 8\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 4\p@ \@plus2\p@ \@minus2\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep
%%               \itemindent\z@
              }%
   \belowdisplayskip \abovedisplayskip
}



% Load microtype package with options for final output and support for babel
\RequirePackage[final,babel=true]{microtype}

% Set tracking for uppercase section headings using LibertinusSerif-Regular font
\SetTracking[spacing={400,100,}]{encoding=*, family={LibertinusSerif-Regular.otf}}{20}

% Load hyperref package for hyperlinks and hyperxmp for XMP metadata
\RequirePackage{hyperref}
\RequirePackage{hyperxmp}

% Configure hyperref package settings
\hypersetup{
  unicode=true,                 % Use Unicode encoded PDF strings
  bookmarksopen=true,           % Open bookmarks
  bookmarksopenlevel=3,         % Set depth of opened bookmarks
  hypertexnames=false,          % Prevent duplicate destination names
  linktoc=all,                  % Set links in table of contents
  plainpages=false,             % Use PDF anchors with correct page numbers
  raiselinks=true,              % Raise up link boxes
  breaklinks                    % Allow line breaks in hyperlinks
}

% Conditional statement based on a variable 'digitalversion'
\ifdigitalversion
  % If digital version, set link colors to custom brown
  \hypersetup{
    colorlinks=true,
    linkcolor=sbs-brown,
    citecolor=sbs-brown,
    filecolor=sbs-brown,
    urlcolor=sbs-brown,
  }
\else
  % If print version, set link colors to text color
  \hypersetup{
    colorlinks=true,
    linkcolor=textbody,
    citecolor=textbody,
    filecolor=textbody,
    urlcolor=textbody,
  }
\fi

% Load bookmark package with options to create bookmarks
\RequirePackage[
  open,             % Bookmarks will be shown
  openlevel=2       % Initial level of bookmarks
]{bookmark}

% Color used for links and headers
\definecolor{sbs-brown}{HTML}{60291F}
% Color used for subtitle
\definecolor{sbs-brown2}{HTML}{573005}
% Color used for dividers
\definecolor{sbs-gold}{HTML}{aa6a1f}

% Fix for endnotes two-way link aiming too low
% Source: https://tex.stackexchange.com/questions/17057/hypertarget-seems-to-aim-a-line-too-low



% Memoir's more allowing penalies; allow some sloppiness in line breaking to avoid overly strict spacing
\midsloppy

% Set hyphenation parameters for British English
\renewcommand\britishhyphenmins{{3}{3}}

% Set penalties for hyphenation and line breaking
\hyphenpenalty=700         % Penalty for breaking lines at hyphens
\exhyphenpenalty=50        % Penalty for breaking lines after explicit hyphens
\doublehyphendemerits=900  % Demerits for consecutive line hyphens

% It is more effective to \mbox{...} the words to avoid hyphenation.
\brokenpenalty=5000 % penalty for page break after a hyphenated line

% NOTE: This package is best for prose text. Here it creates unexpected page breaks,
% and complicates the endnotes formatting.
% \RequirePackage[defaultlines=2,all]{nowidow}

% \hyphenation{season wisdom develop-ment respon-sible pheno-mena philo-sophical munindo amaravati thai-land}

% Define a new series of emphasis commands using the sodef package
\sodef\soTocChapter{}{.1em}{.5em plus.1em}{.1em plus.1em minus.1em}
\sodef\soSection{}{.07em}{.4em plus.1em}{.1em plus.1em minus.1em}



% Source: https://tex.stackexchange.com/questions/4839/raggedleft-paragraph-in-a-table

% Define new column types for left-aligned and right-aligned columns in tables
% Usage: \begin{tabular}{L{30mm}R{30mm}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}

% Define a command to insert a divider rule in tables
\newcommand\dividerRule{%
{\centering\bigskip
{\color[gray]{0.6}\rule{0.6\linewidth}{0.2pt}}
\par\bigskip}%
}

% Define commands to insert empty pages
\newcommand\emptysheet{%
  \cleardoublepage
  \thispagestyle{empty}\mbox{}\newpage
  \thispagestyle{empty}\mbox{}\newpage
}

% Alias for \emptysheet
\newcommand\emptydoublepage\emptysheet

% Define a command to insert a single empty page
\newcommand\emptypage{%
  \clearpage
  \thispagestyle{empty}\mbox{}\newpage
}

% Define a command to insert empty pages until the current page count is even
\newcommand{\emptyUntilEven}{%
  \ifodd\thepage%
  \clearpage\thispagestyle{empty}\null%
  \fi%
}

% Define counters for page number manipulation
\newcounter{pageRem}
\newcounter{origPage}

% Add empty pages to achieve a total page count divisible by 8 without remainder
\newcommand{\emptyUntilModEight}{%
  \setcounter{origPage}{\theCurrentPage}%
  \setcounter{pageRem}{1 + 8 - ( \theCurrentPage - ( ( \theCurrentPage / 8 ) * 8) )}%
  %\typeout{hey: \theCurrentPage, \theorigPage, \thepageRem}% NOTE only for debugging
  \loop%
    \addtocounter{pageRem}{-1}%
  \ifnum\thepageRem>0%
    \clearpage%
    \thispagestyle{empty}\mbox{}%
    %hey \theorigPage \space \thepageRem% NOTE only for debugging
  \repeat%
}



% Define commands for document metadata
\newcommand*{\subtitle}[1]{\def\@thesubtitle{#1}}
\newcommand*{\editionInfo}[1]{\def\@theEditionInfo{#1}}
\newcommand*{\printedByInfo}[1]{\def\@thePrintedByInfo{#1}}
\newcommand*{\publisher}[1]{\def\@thePublisher{#1}}
\newcommand*{\ISBN}[1]{\def\@theISBN{#1}}

% Define commands to access document metadata
\newcommand\thesubtitle{\@thesubtitle}
\newcommand\theEditionInfo{\@theEditionInfo}
\newcommand\thePrintedByInfo{\@thePrintedByInfo}
\newcommand\thePublisher{\@thePublisher}
\newcommand\theISBN{\@theISBN}

% Define a savebox for quotepage environment
\newsavebox{\quotepagebox}
\newenvironment{quotepage}[1]
  {\begin{lrbox}{\quotepagebox}\begin{minipage}{#1}
   \setlength{\parskip}{0.6\baselineskip}
   \setlength{\parindent}{0pt}}
  {\end{minipage}\end{lrbox}%
   \begin{tikzpicture}[remember picture,overlay]
   \node at (current page.center) {\usebox{\quotepagebox}};
   \end{tikzpicture}}

% Define custom environments with compact itemize and enumerate
\newenvironment{packeditemize}%
{\begin{itemize}[
  itemindent=0pt,
  leftmargin=15pt,
  rightmargin=0pt,
  itemsep=4pt,
  topsep=0pt,
  parsep=0pt,
  partopsep=0pt,
]%
}{\end{itemize}}

\newenvironment{packedenumerate}%
{\begin{enumerate}[
  itemindent=0pt,
  leftmargin=15pt,
  rightmargin=0pt,
  itemsep=4pt,
  topsep=0pt,
  parsep=0pt,
  partopsep=0pt,
]%
}{\end{enumerate}}

% Define a command for speaker name with small caps and color
% TODO needed?
\newcommand\speakerName[1]{%
  {\color[gray]{0.25}\libertinusFont\scshape\MakeLowercase{#1}}\quad}

% Define length for question indent
\newlength\qw
\setlength\qw{17pt}

% Define commands for questions and answers
\newcommand{\question}[1]{%
  \smallskip%
  \par\noindent\hangindent=\qw%
  \ifthenelse{\equal{#1}{}}{\textit{Q:}\space}{\textit{#1:}\space}%
}

\newcommand{\questionBi}[2]{%
  \smallskip%
  \par\noindent\hangindent=\qw%
  \textit{Q: #1}
  \smallskip%
  \par\noindent\hangindent=\qw%
  \textit{Q: #2}
}

\newcommand{\answer}[1]{%
  \smallskip%
  \par\noindent%
  \ifthenelse{\equal{#1}{}}{\textit{A:}\space}{\textit{#1:}\space}%
}

% If class option digitalVersion is used, show content in a paper sized
% minipage, empty page otherwise.
% Redefine \color{digitalcoverbg} to change page background color.
\newcommand\digitalCover[1]{%
\thispagestyle{empty}\mbox{}
\ifdigitalversion
\AddToShipoutPictureFG*{\put(0,0){%
\begin{minipage}[b][\paperheight][c]{\paperwidth}%
#1
\end{minipage}}}
\fi
\clearpage
}



% Define lengths for document layout
\newlength{\titleLength} % Length for the title
\newlength{\xheight}     % Length for the x-height of the font

%%%%%%%%%%%%%%%% Quotes %%%%%%%%%%%%%%%%

% Define a length for the margin of block quotes
\newlength{\quoteMargin}
% Set the value of the quoteMargin length to 18 points
\setlength{\quoteMargin}{18pt}

% FIXME is this even broken?
%\setlength{\footnotemargin}{\quoteMargin}

% Define a new environment for opening verses
\newenvironment{openingVerse}%
{%
  \cleartoverso % Clears the page and starts the verse on a verso page
  \thispagestyle{empty} % Suppresses page number for the opening verse page
  \mbox{}\vfill % Adds vertical space, centering the verse vertically
  \begin{verse} % Begins the verse environment
}%
{%
  \par\end{verse} % Ends the verse environment
  \vfill\mbox{} % Adds vertical space, centering the verse vertically
}

% Redefine the verse environment for sutta verses and other short stanzas
\renewenvironment{verse}
{\begin{centering} % Begins centering environment for verse
    \itshape % Sets verse in italics
}%
{\par\end{centering}} % Ends centering environment for verse

% Define a command for verse references
\newcommand{\verseRef}[1]{%
  {\centering\itshape\footnotesize #1\par} % Centers and formats verse reference
}

% Define a command for sutta references
\newcommand{\suttaRef}[1]{%
  \vspace{-6pt} % Adjusts vertical spacing for sutta references
  \hfill {\fontsize{8}{16}\selectfont #1\par} % Sets sutta reference in smaller font size
}

% Redefine the quote environment for longer sutta and book quotes
\renewenvironment{quote} %
{\list{}{ % Begins a list for the quote environment
    \itshape % Sets quote in italics
    \listparindent 0pt % Sets paragraph indentation within the list
    \itemindent    \listparindent % Sets item indentation within the list
    \leftmargin    \quoteMargin % Sets left margin for the quote
    \rightmargin   \quoteMargin % Sets right margin for the quote
    \parsep        8pt % Sets paragraph separation within the list
    \topsep        0pt % Sets spacing above the list
    \partopsep     0pt} % Sets additional spacing above the list
\item[]}%
{\endlist} % Ends the list for the quote environment

% Define a command for quote titles
\newcommand{\quoteTitle}[1]{%
  {%
    \centering\upshape\itshape % Centers and formats quote title
    \fontsize{26}{10}\selectfont % Sets font size for quote title
    \color{section} % Sets color for quote title
    #1 % Prints the quote title
    % \par % Optional line break after quote title
  }%
\itshape % Sets the quote title in italics
}



% Define a command for formatting a reference or citation in a quote
\newcommand{\quoteRef}[1]{%
  {\centering\itshape\footnotesize #1\par}%
}

% Define a command for formatting an inline reference or citation in a quote
\newcommand{\quoteRefInline}[1]{%
  {\hfill\itshape\footnotesize #1}%
}

% Define a custom environment for formatting speaker's dialogue
\newenvironment{speaker}%
{\list{}{%
    \listparindent 0pt
    \itemindent    \listparindent
    \leftmargin    \quoteMargin  % Adjust left margin
    \rightmargin   \quoteMargin  % Adjust right margin
    \parsep        8pt
    \topsep        0pt
    \partopsep     0pt}%
\item[]}%
{\endlist}

% Define custom lengths for quote formatting
\newlength{\quoteRuleWidth}
\newlength{\quoteTopBotSep}
\newlength{\quoteHeight}

% Set the top and bottom separation for quotes
\setlength{\quoteTopBotSep}{15pt}

% Define a command for formatting quotes with a side rule
\newcommand{\sideruleQuoteFmt}[1]{%
  \begin{minipage}{\linewidth - 40pt}%
    \sideruleQuoteFont\Large\color[gray]{0.2}%
    #1%
  \end{minipage}%
}

% Define colors for quote rule
\definecolor{quoteRuleFill}{gray}{0.95}
\definecolor{quoteRule}{gray}{0.7}

% Define a custom environment for quotes with a side rule
% #1: quote rule width
\NewEnviron{siderule-quote}[1][8pt]%
{%
  \setlength{\quoteRuleWidth}{#1}%
  \settototalheight{\quoteHeight}{\sideruleQuoteFmt{\BODY}}%
  \begin{tikzpicture}%
    \node (box) [draw=none, rectangle,
    minimum width={\linewidth - \quoteRuleWidth},
    minimum height={\quoteHeight + 2\quoteTopBotSep},
    inner sep=0pt, fill=quoteRuleFill] {};
    %
    \node (a) [above left=0pt and 0pt of box.north west] {};
    \node (b) [below left=0pt and 0pt of box.south west] {};
    %
    \draw [line width=\quoteRuleWidth, draw=quoteRule] (a) -- (b);
    %
    \node (quote) [below right=\quoteTopBotSep and {20pt - 0.5\quoteRuleWidth} of box.north west,
                   anchor=north west, draw=none, inner sep=0pt] {%
      \sideruleQuoteFmt{\BODY}%
    };
  \end{tikzpicture}%
}

% Define commands for including photos with full bleed
\newcommand\photoFullBleed[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \includegraphics[height={\paperheight + 6mm}]{#1}%
    }%
  }%
}

% Define a command to set the graphics for a chapter opening page
\newcommand{\thechaptergraphics}{}

% Define a command to set the graphics for a chapter opening page
% #1: photo
\newcommand{\chapterOpeningPage}[1]{%
  \renewcommand{\thechaptergraphics}{#1}
}

% Define a command for creating a section break
\newcommand\sectionBreak{%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
  \par%
  {%
    \centering%
    \libertinusFont%
    \fontsize{20}{20}\selectfont%
    \color[gray]{0.7}%
    *\quad*\quad*%
  \par}%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
}

% Breath mark is U+1D112. This character is often not included in typefaces.
% Since it's identical to a right single quote mark (U+2019), we'll use that.
% To distinguish it from a quote mark, we raise it higher, above the riser stems (such as d' or l').
\newcommand\breathmark{%
  \raisebox{-0.10\baselineskip}{\fontsize{18}{18}\bfseries\symbol{"2019}}%
 }

% Same character as above but lowered for better diplay in abbreviations chapter.
\newcommand\abbrbreathmark{%
  \raisebox{-0.65em}{\fontsize{24}{8}\bfseries\symbol{"2019}}%
 }

 % Left angle bracket used for indicating the solo parts for the recitation leader.
\newcommand\anglebracketleft{%
  \raisebox{0.0\baselineskip}{\Large\symbol{"2329}}%
 }

 % Right angle bracket used for indicating the solo parts for the recitation leader.
\newcommand\anglebracketright{%
  \raisebox{0.0\baselineskip}{\Large\symbol{"232A}}%
 }

% Define a command for generating a bottom navigation section
% #1: The label for the next section
\newcommand\bottomNav[1]{%
  \vfill % Fill the vertical space
  \ifdigitalversion % Check if the digital version is active
  \begin{minipage}{\linewidth}%
    % Hyperlink to the "schedule" section
    \hyperref[schedule]{%
      \textbf{\raggedright\textsc{\fontsize{13}{0}\textls*{Schedule}}}}
    \hfill % Fill the space between elements
    % Hyperlink to the next section specified by the argument
    \hyperref[#1]{%
      \textbf{\raggedleft\textsc{\fontsize{13}{0}\textls*{Next}}}}%
  \end{minipage}%
  \fi
}



% Define commands for storing color specifications
\newcommand\modelTmp{} % Temporary storage for color model
\newcommand\specTextbody{} % Store color specifications for text body
\newcommand\specChaptertitle{} % Store color specifications for chapter titles
\newcommand\specSection{} % Store color specifications for sections
\newcommand\specFootnote{} % Store color specifications for footnotes
\newcommand\specFooter{} % Store color specifications for footers

% Define a command to extract color specifications
\newcommand\extractSpecs{%
  \extractcolorspecs{textbody}{\modelTmp}{\specTextbody}%
  \extractcolorspecs{chaptertitle}{\modelTmp}{\specChaptertitle}%
  \extractcolorspecs{section}{\modelTmp}{\specSection}%
  \extractcolorspecs{footnote}{\modelTmp}{\specFootnote}%
  \extractcolorspecs{footer}{\modelTmp}{\specFooter}%
}

% Define a command to print color specifications
% #1: Description title of specs, such as 'variation A, base colors'
\newcommand{\printSpecs}[1]{%
  \cleartoverso % Start a new page
  \mbox{}\vfill % Fill the vertical space
  \thispagestyle{empty} % Remove page numbering and headers/footers
  \extractSpecs % Extract color specifications

  #1 % Print the description title

  % Create a table to display color specifications
  \begin{tabular}{@{} l l}
    Chapter title & \specChaptertitle \\
    Text body & \specTextbody \\
    Section & \specSection \\
    Footnote & \specFootnote \\
    Footer & \specFooter \\
  \end{tabular}%
  \vfill\mbox{}% Fill the remaining vertical space
}



% Define commands to be executed when entering different parts of the document

% Append code to be executed when entering \mainmatter
\addtodef{\mainmatter}{}{%
  % \addtocontents{toc}{\addvspace{5pt}}%
  % \setcounter{chapter}{0}%
}

\addtodef{\appendix}{}{%
  % Not adding vspace here because it interferes with the closing '.' of the
  % section list. The vertical space is added in \titlecontents{appendix}.
  \bookmarksetup{startatroot}%
}

% Append code to be executed when entering \backmatter
\addtodef{\backmatter}{}{%
  \bookmarksetup{startatroot}%
}

% Define a command for formatting a reference in a quote
\newcommand\quoteref[1]{%
\par % Start a new paragraph
{\footnotesize #1} % Set the reference in footnotesize font
\par % End the paragraph
}

% adapted from base/latex.ltx
\def\footnoterule{%
  \kern-3\p@
  {\color{footnoterule}\rule{\columnwidth}{0.25pt}}%
  \vspace*{7pt}%
  \kern 2.6\p@}

% Redefine the name for the notes section
\renewcommand*{\notesname}{Notes}

% Redefine the title format for the notes section
\renewcommand*{\notedivision}{\chapter{\notesname}}

% Redefine the format for subheadings in page notes
\renewcommand*{\pagenotesubhead}[3]{}

% Redefine the format for note numbers in text
\renewcommand*{\notenumintext}[1]{\textsuperscript{\thinspace #1}}

% Redefine the format for the pre-note in notes
\renewcommand{\prenoteinnotes}{\par\noindent\hangindent=17pt}

%% http://tex.stackexchange.com/questions/36894/underline-omitting-the-descenders
%% http://tex.stackexchange.com/a/75406

% Load required packages and define a custom command for underlining with a colored outline
\RequirePackage[outline]{contour} % Load contour package with outline option
\RequirePackage[normalem]{ulem} % Load ulem package

% Define a command for underlining text with a colored outline
\newcommand\prul[1]{%
  \begingroup % Start a group
  \renewcommand{\ULdepth}{1.8pt} % Set depth of underline
  \renewcommand{\ULthickness}{0.5pt} % Set thickness of underline
  \contourlength{0.5pt} % Set contour length
  \uline{\phantom{#1}}\llap{\contour{white}{#1}} % Underline text with colored outline
  \endgroup % End the group
}

%%%%%%%%%%%%%%%% Page Styles %%%%%%%%%%%%%%%%

% Disable automatic capitalization of headers
\nouppercaseheads

% Define a command for drawing a separator line
\newcommand{\sepline}{%
  \hspace{6pt}% Horizontal space
  \raisebox{-0.3\baselineskip}{\rule{0.2pt}{1.2\baselineskip}}% Rule for the line
  \hspace{6pt}% Horizontal space
}

% Define a page style named "toponerow"
\makepagestyle{toponerow}
% Define header and footer for even pages
\makeevenhead{toponerow}{\headerFont\headerSize\color{header}\thepage}{}{\headerFont\headerSize\color{header}\textls*{\textsc{\leftmark}}}
\makeevenfoot{toponerow}{}{}{}
% Define header and footer for odd pages
\makeoddhead{toponerow}{\headerFont\headerSize\color{header}\textls*{\textsc{\leftmark}}}{}{\headerFont\headerSize\color{header}\thepage}
\makeoddfoot{toponerow}{}{}{}
% Set page marks for "toponerow"
\makepsmarks{toponerow}{%
  \nouppercaseheads % Prevent uppercase conversion of headers
  % Create marks for various document elements
  \createmark{chapter}{left}{nonumber}{}{}
  \createmark{section}{right}{nonumber}{}{}
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}
}

% Define a page style named "toponerow-frontmatter" for front matter pages
\makepagestyle{toponerow-frontmatter}
% Define header and footer for even pages
\makeevenhead{toponerow-frontmatter}{\headerFont\headerSize\color{header}\thepage}{}{\headerFont\headerSize\color{header}\textls*{\textsc{\leftmark}}}
\makeevenfoot{toponerow-frontmatter}{}{}{}
% Define header and footer for odd pages
\makeoddhead{toponerow-frontmatter}{\headerFont\headerSize\color{header}\textls*{\textsc{\leftmark}}}{}{\headerFont\headerSize\color{header}\thepage}
\makeoddfoot{toponerow-frontmatter}{}{}{}
% Set page marks for "toponerow-frontmatter"
\makepsmarks{toponerow-frontmatter}{%
  \nouppercaseheads % Prevent uppercase conversion of headers
  % Create marks for various document elements
  \createmark{chapter}{left}{nonumber}{}{}
  \createmark{section}{right}{nonumber}{}{}
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}
}

% Define a page style named "bottomcorner" for pages with page numbers in the bottom corner
\makepagestyle{bottomcorner}
% Define header and footer for even pages
\makeevenhead{bottomcorner}{}{}{}
\makeevenfoot{bottomcorner}{%
  \footerFont\footerSize%
  \color{footer}%
  \thepage\hspace*{1em}$\cdot$\hspace*{1em}\textit{\thetitle}%
}{}{}
% Define header and footer for odd pages
\makeoddhead{bottomcorner}{}{}{}
\makeoddfoot{bottomcorner}{}{}{%
  \footerFont\footerSize%
  \color{footer}%
  \textit{\leftmark}\hspace*{1em}$\cdot$\hspace*{1em}\thepage%
}

% Define a page style named "bottomcenter" for pages with page numbers centered at the bottom
\makepagestyle{bottomcenter}
% Define header and footer for even pages
\makeevenhead{bottomcenter}{}{}{}
\makeevenfoot{bottomcenter}{}{%
  \footerFont\footerSize%
  \color{footer}%
  \thepage%
}{}
% Define header and footer for odd pages
\makeoddhead{bottomcenter}{}{}{}
\makeoddfoot{bottomcenter}{}{%
  \footerFont\footerSize%
  \color{footer}%
  \thepage%
}{}

% Alias the page styles into semantic names, indicating where they are used

% Alias the "toponerow" page style as "normalpage" for normal pages
\aliaspagestyle{normalpage}{toponerow}
% Alias the "bottomcenter" page style as "chapter" for chapter pages
\aliaspagestyle{chapter}{bottomcenter}
% Alias the "empty" page style for book parts and afterparts
\aliaspagestyle{book}{empty}
\aliaspagestyle{part}{empty}
\aliaspagestyle{afterpart}{empty}

% Set the default page style to "normalpage"
\pagestyle{normalpage}



% Set the maximum depth of the table of contents to include subsubsections
\maxtocdepth{subsubsection}

% Set the right margin for the table of contents
\contentsmargin{-5pt}

% Define the width of the left margin in the table of contents
\newlength\tocLeftWidth
\setlength\tocLeftWidth{0pt}

% Define commands to handle chapter and part numbering in the table of contents
\renewcommand\chapternumberline[1]{\numberline{#1}}
\renewcommand\partnumberline[1]{\numberline{#1}}

\let\ttll@appendix\ttll@chapter % Fixes undefined control sequence error

\newcommand*\l@chapternote{\@nodottedtocline{0}{\tocLeftWidth}{1pc}{1pc}}

\def\@nodottedtocline#1#2#3#4#5#6{%
  \ifnum #1>\c@tocdepth \else
    \vspace*{3pt}%
    {\fontsize{11}{15}\itshape\tocFont\selectfont
     \leftskip #2\relax
     \rightskip \@tocrmarg
     \advance\rightskip #3\relax
     \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #4\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#5}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{\,}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalsize\normalfont}%
     \par}%
    \vspace*{5pt}%
  \fi}

% Define a command to add chapter notes to the table of contents
\def\tocChapterNote#1{%
  \addcontentsline{toc}{chapternote}{%
  \noexpand\numberline{}#1}%
}

% Define the format for English titles in the table of contents
\newcommand{\tocEnglishTitleFmt}[1]{%
  {%
    \libertinusFont\tocSectionSize\itshape\selectfont%
    \hspace*{\tocLeftWidth}\hspace*{5em}%
    #1%
    \par
  }%
}

% Define the English title in the table of contents
\def\tocEnglishTitle#1{%
  \addtocontents{toc}{\protect\tocEnglishTitleFmt{#1}}%
}

% FIXME: the first Part heading in the TOC will also add that 20pt
% vspace. How to add it only before a Part that follows a Chapter?

\newlength\tocPageWidth

\newlength\tocThreeDigits
\setlength{\tocThreeDigits}{\widthof{\tocFont\tocSize 999}}

% Changes 'Pāli-English Recitations' in the ToC
\titlecontents{part}[\tocLeftWidth]
{\addvspace{15pt}%
\tocFont\bfseries\fontsize{14}{5}\selectfont}%
{%
  \contentsmargin{0pt}%
  \textls*{PART \thecontentslabel.}\space%
  \hspace*{0.5em}%
  \MakeUppercase
}
{\contentsmargin{0pt}}
{}

% Change the appearance of chapter entries in the table of contents
\titlecontents{chapter}[\tocLeftWidth]
{\addvspace{15pt}%
\tocFont\bfseries\scshape\fontsize{14}{15}\selectfont}%
{%
  \contentsmargin{0pt}%
  \thecontentslabel.\space%
  \hspace*{0.5em}%
  \MakeUppercase%
}
{\contentsmargin{0pt}%
}
% Changes the size of the page number for chapter headings in ToC
{\hfill\tocFont\fontsize{14}{15}\selectfont\thecontentspage}
[\addvspace{1pt}]

% Changes section/chant formatting in ToC e.g. 'Dedication of Offerings'
\titlecontents{section}[0.5em]
{\addvspace{4pt}%
  \libertinusFont\tocSectionSize}%
{%
  \contentsmargin{0pt}%
  \thecontentslabel\space%
  \hspace*{0.8em}%
}
{\contentsmargin{0pt}%
  \itshape}
{\hfill\libertinusFont\tocSectionSize\thecontentspage}

% Change the appearance of subsection entries in the table of contents
\titlecontents{subsection}[1em]
{\addvspace{4pt}%
\libertinusFont\tocSubsectionSize}%
{%
  \contentsmargin{0pt}%
  \thecontentslabel\space%
  \hspace*{2em}%
}
{\contentsmargin{0pt}%
  \itshape}
{\hfill\libertinusFont\tocSubsectionSize\thecontentspage}

% Change the appearance of subsubsection entries in the table of contents
\titlecontents{subsubsection}[\tocLeftWidth]
{\libertinusFont\itshape\tocSectionSize}%
{%
  \contentsmargin{0pt}%
  \hspace*{5em}%
}
{%
  \contentsmargin{0pt}%
  \hspace*{5em}%
  \itshape%
}%
{\hfill\libertinusFont\tocSectionSize\upshape\selectfont\thecontentspage}

% Change the appearance of appendix entries in the table of contents
\titlecontents{appendix}[\tocLeftWidth]
{\addvspace{15pt}%
\tocFont\bfseries\fontsize{11}{15}\selectfont}%
{%
  \contentsmargin{0pt}%
  \thecontentslabel.\space%
  \hspace*{0.5em}%
  \MakeUppercase%
}
{\contentsmargin{0pt}%
\itshape}
{\hfill\tocFont\fontsize{11}{15}\selectfont\thecontentspage}
[\addvspace{5pt}]



% Define a conditional variable to track if a part has a title
\newif\ifthisparthastitle
\thisparthastitletrue

% Define a conditional variable to track if a part has a note
\newif\ifthisparthasnote
\thisparthasnotefalse

% Define a command to store the content of the part note
\newcommand*{\thePartNote}{}
% Define a command to set the content of the part note
\newcommand*{\partNote}[1]{%
  \thisparthasnotetrue%
  \renewcommand*\thePartNote{#1}%
}

% Redefine the font style for the part name
\renewcommand{\partnamefont}{\fontsize{12}{12}\selectfont\partTitleFont\color[gray]{0.1}}
% Redefine the font style for the part title
\renewcommand{\parttitlefont}{\fontsize{18}{18}\selectfont\partTitleFont\color[gray]{0.1}}

% Define a command to print the formatted part name and number
\newcommand\printpart{\textls*{\partnamefont\MakeUppercase{\partname \space \thepart}}}
% Redefine the command responsible for printing the formatted part title
\renewcommand{\printparttitle}[1]{\textls*{\parttitlefont\MakeUppercase{#1}}}

% Redefine the spacing between parts
\renewcommand*{\midpartskip}{\par\vskip 15pt}%

% FIXME: Currently, if there isn't a part title, we have to do
% \part{\space} to still create the part line in the TOC and the
% bookmark index.
%
% It would be better if the index had ``Part One'', and the TOC would
% handle it better too.

% Redefine the internal LaTeX command for printing parts
\long\def\@part[#1]#2{%
  \M@gettitle{#1} % Extract the title of the part
  \phantomsection % Ensure correct hyperlinks in PDFs
  \ifnum \c@secnumdepth >-2\relax % Check if part numbering is enabled
    \refstepcounter{part} % Increment the part counter
    \addcontentsline{toc}{part} % Add part to the table of contents
    {\protect\partnumberline{\thepart}#1} % Print part number and title in TOC
    \mempartinfo{\thepart}{#1}{#2} % Store part information
  \else
    \addcontentsline{toc}{part}{#1} % Add part without number to TOC
    \mempartinfo{}{#1}{#2} % Store part information
  \fi
  \partmark{#1} % Set part mark
  {% Begin part content
    \raggedright % Align part content to the left
    \hspace*{17pt} % Indentation for part content
    \begin{minipage}{\linewidth - 17pt} % Use a minipage to limit width of part content
      \raggedright % Align part content to the left
      \interlinepenalty \@M % Penalty for page breaks between lines
      \parskip\z@ % No extra space between paragraphs
      \ifthisparthasnote % Check if part has a note
        \thePartNote % Print part note
        \par % Start a new paragraph
        \global\thisparthasnotefalse % Reset note flag
        \midpartskip % Add space after note
      \fi
      \normalfont % Use normal font for part content
      \ifnum \c@secnumdepth >-2\relax % Check if part numbering is enabled
        {\printpart} % Print part name and number
        \par\vskip 20pt % Add space after part name and number
      \fi
      \ifthisparthastitle % Check if part has a title
        \printparttitle{#2} % Print part title
      \else
        \global\thisparthastitletrue % Reset title flag
      \fi
      \par % End part content
    \end{minipage} % End minipage
    \par % Start new paragraph after part content
  } % End part content
\@endpart} % End internal part command



\setsecnumdepth{none}

% TODO uncertain if these should be removed; commented out for now.
% \newif\ifchapterauthor
% \chapterauthorfalse

% \newcommand*{\theChapterAuthor}{}
% \newcommand*{\chapterAuthor}[1]{%
%   \chapterauthortrue%
%   \renewcommand*{\theChapterAuthor}{#1}%
% }

% \newcommand\chapterAuthorFmt[1]{%
%   \chapterAuthorFont\chapterAuthorSize\color{chapterauthor}%
%   #1%
% }

% \newif\ifchapternote
% \chapternotefalse

% \newcommand\chapterNoteFmt[1]{%
%   \chapterNoteFont\chapterNoteSize\color{chapternote}%
%   \itshape #1%
% }

% \newcommand{\theChapterNote}{}
% \newcommand{\chapterNote}[1]{%
%   \chapternotetrue%
%   \renewcommand*\theChapterNote{#1}%
% }

% \newif\ifchapterfootnote
% \chapterfootnotefalse

% \newcommand*{\theChapterFootnoteMark}{}
% \newcommand*{\theChapterFootnoteText}{}
% \newcommand*{\chapterFootnote}[2][\footnotemark]{%
%   \chapterfootnotetrue%
%   \renewcommand*\theChapterFootnoteMark{#1}%
%   \renewcommand*\theChapterFootnoteText{\footnotetext{#2}}%
% }

\makechapterstyle{adrasteia}{
  \chapterstyle{default}
  \setlength{\beforechapskip}{-20pt}
  \renewcommand\printchaptername{}
  \renewcommand\chapternamenum{}
  \renewcommand\chapnumfont{\chapterNumberFont\chapterNumberSize}
  \renewcommand\printchapternum{}
  \renewcommand\afterchapternum{}
  \renewcommand\printchapternonum{}
  \renewcommand\chaptitlefont{\chapterTitleFont\chapterTitleSize}
  \renewcommand*\printchaptertitle[1]{%
  % \thispagestyle{empty}\null%
  \photoFullBleed{\thechaptergraphics}%
    {%
      \centering%
      {\chapnumfont\color{chapternum}\bfseries\scshape}%
      \chaptitlefont%
      \vspace*{12pt}%
      \par
      \textbf{\textsc{\textls*{##1}}}%
      \par%
    }%
  }
  \setlength{\afterchapskip}{2.5\onelineskip}
  \renewcommand\afterchaptertitle{\par\nobreak\vskip \afterchapskip}%
}


\makechapterstyle{adrasteia-frontmatter}{
  \chapterstyle{adrasteia}
  \renewcommand*\printchaptertitle[1]{%
    {%
      \centering%
      \chaptitlefont%
      \textbf{\textsc{\textls*{##1}}}%
      \par%
    }%
  }
  \setlength{\afterchapskip}{\onelineskip}
}

\makechapterstyle{adrasteia-toc}{
  \chapterstyle{adrasteia-frontmatter}
  \renewcommand*\printchaptertitle[1]{%
    {%
      \centering%
      \chaptitlefont%
      \textbf{\textsc{\textls*{##1}}}%
      % \label{contents}%
      \par%
    }%
  }
}

\makechapterstyle{adrasteia-appendix}{
  \chapterstyle{adrasteia}
  \renewcommand*\printchaptertitle[1]{%
  \photoFullBleed{\thechaptergraphics}%
    {%
      \centering%
      {\chapnumfont\fontsize{10}{10}\selectfont\textls*{Appendix}}%
      \chaptitlefont\fontsize{13}{18}\selectfont%
      \vspace*{12pt}%
      \par
      \textbf{\textsc{\textls*{##1}}}%
      \par%
    }%
  }
}

\makechapterstyle{adrasteia-backmatter}{
  \chapterstyle{adrasteia-frontmatter}
}

% Commands to assign the chapter styles to book parts. Use \renewcommand to adjust.


% Create a mark for the left side of the header for chapters without numbering
% \createmark{chapter}{left}{nonumber}{}{}

% Define a command to set the chapter style for the front matter
\newcommand\frontmatterChapterStyle{\chapterstyle{adrasteia-frontmatter}}
% Define a command to set the chapter style for the main matter
\newcommand\mainmatterChapterStyle{\chapterstyle{adrasteia}}
% Define a command to set the chapter style for the appendix
\newcommand\appendixChapterStyle{\chapterstyle{adrasteia-appendix}}
% Define a command to set the chapter style for the back matter
\newcommand\backmatterChapterStyle{\chapterstyle{adrasteia-backmatter}}

% Append the front matter chapter style to the \frontmatter macro
\addtodef{\frontmatter}{}{\frontmatterChapterStyle}
% Append the main matter chapter style to the \mainmatter macro
\addtodef{\mainmatter}{}{\mainmatterChapterStyle}
% Append the appendix chapter style to the \appendix macro
\addtodef{\appendix}{}{\appendixChapterStyle}
% Append the back matter chapter style to the \backmatter macro
\addtodef{\backmatter}{}{\backmatterChapterStyle}



% No glue after section headers. It is better to break the page early. With
% glue, (eg \setaftersecskip{2.3ex \@plus .2ex}), when nowidow moves some lines
% to the next page, the space after the section header will strech a lot to shift
% the bottom lines to the bottom of the text block.

% With no glue, the space will be at the bottom of the text block instead.


% TODO need or not?
% \setsechook{%
%   % New page for each section.
%   \clearpage%
%   % Empty the default section number printing, so that we can handle it.
%   \setsecnumformat{}%
% }

% Set the vertical space before sections
\setbeforesecskip{10pt}

% Alters space after subsections
\setaftersubsecskip{2ex \@plus -.5ex \@minus -.2ex}

% Alters space before and after subsections
\setbeforesubsecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersubsecskip{0.1ex \@plus -.5ex \@minus -.2ex}

% Alters space before and after subsubsections
\setbeforesubsubsecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersubsubsecskip{1ex}

% Roman numerals for section numbering.
%\renewcommand*{\thesection}{\roman{section}}

\newlength\sectionTitleLength

% Section title formatting (e.g. 'Homage to the Buddha')
\newcommand\sectionFmt[1]{%
  % A box with contains the entire ruled title
  % \begin{minipage}{\linewidth}%
    \centering%
    \sectionFont\fontsize{15}{15}\selectfont%
    % \setlength{\parskip}{2pt}%
    %
    % Top rule
    % \rule{\linewidth}{0.4pt}%
    % \linebreak%
    % Measure the length of the section title at the current point size
    \setlength{\sectionTitleLength}{\widthof{\mbox{\textbf{\textls*{\textsc{#1}}}}}}%
    %
    % Box for the section number
    % \begin{minipage}[t]{0.001\linewidth}% padding for the title
      % Only print the section number in the mainmatter,
      % but the empty box is necessary for horizontal spacing.
      % \if@mainmatter%
      %   \raggedright%
      %   \textbf{\textls*{\textsc{\thesection}}}%
      % \else%
      %   \mbox{}%
      % \fi%
      % No section number, but minipage needs content (an empty box).
      % \mbox{}%
    % \end{minipage}%
    %
    % Box for the section title text
    % TODO: hyperef wrap is disorienting the remainder of brackets
    \hyperref[schedule]{%
      \begin{minipage}[t]{\linewidth}%
        \centering%
        % To hyperlink the text only, put \hyperref around the below
        \textbf{\textls*{\textsc{#1}}}%
      \end{minipage}}%
    %
    % Box for the arrow link back to the schedule.
    % Uncomment below to end to regain arrow and box
    % \begin{minipage}[t]{0.1\linewidth}%
    %   % Only print content in the mainmatter.
    %   \if@mainmatter%
    %     \raggedleft%
    %     \hyperref[schedule]{$\Leftarrow$}%
    %   \else%
    %     \mbox{}%
    %   \fi%
    % \end{minipage}%
    %
    % New paragraph.
    \par%
    \ifsectionsubtitle%
      % If there is a subtitle, and the title is more than one line, adjust the spacing.
    \ifdimcomp{\sectionTitleLength}{>}{\linewidth}{%
      \vspace*{0.3\baselineskip}%
      \vspace*{1pt}%
      \par%
    }{}
      %
      % Print the subtitle if it has been set with \sectionSubTitle, then reset
      % it so following sections don't use the same value.
      \vspace*{-4pt}%
      \parbox{\linewidth}{%
        \centering%
        % font size for subTitle
        \color{black}
        \fontsize{12}{14}\selectfont
        \@secSubTitle%
        \sectionSubTitleClear%
      }%
      %
      % Adjust the spacing before the bottom rule.
      \vspace*{-0.8\baselineskip}%
      \par%
    \else%
      %
      % If there is no subtitle, and the title is a single line, adjust the spacing.
      \ifdimcomp{\sectionTitleLength}{<}{\linewidth}{%
        \vspace*{-0.5\baselineskip}%
        \vspace*{-4pt}%
        \par%
      }{}%
      % If there is no subtitle, and the title is more than a single line, adjust the spacing.
      \ifdimcomp{\sectionTitleLength}{>}{\linewidth}{%
        \vspace*{-0.5\baselineskip}%
        % \vspace*{-2pt}%
        \par%
      }{}%
    \fi%
    %
    % Bottom rule
    % \rule{\linewidth}{0.4pt}%
    % \vspace*{10pt}
    % Bars are from numbers 80-89. | 88 for thiner, simpler bar, 84 for dhamma wheel bar, 4 is just the dhamma wheel
    % Create a minipage for the decorative ornament
  \begin{minipage}{\linewidth}%
    % Center the ornament
    \centering%
    % Insert the ornament
    \pgfornament[color=black,width=7cm,scale=1,ydelta=24pt,symmetry=c]{88}%
  \end{minipage}%
  % Something is causing this bracket unbalance but it doesn't break the build.
  % Starting at the title hyperref above
}

% Subsection title formatting (e.g. the 'Historical Background' found in the Purpose and Benefit section)
\newcommand\subsectionFmt[1]{%
  {%
    \subSectionFont\fontsize{14}{18}\selectfont%
    \scshape\bfseries%
    \centering
    \hyperref[schedule]{%
      \begin{minipage}[t]{\linewidth}%
        \centering%
        % To hyperlink the text only, put \hyperref around the below
        \textbf{\textls*{\textsc{#1}}}%
      \end{minipage}}%
    % \vspace*{-7.2pt}% what is the needed for? commented removes gap in anumodana-paritta section
    % #1%
  }%
}

% Formatting for subsubsection titles (currently unused)
\newcommand\subsubsectionFmt[1]{%
  {%
    \subSectionFont\fontsize{11}{17}\selectfont%
    \itshape%
    \memRTLraggedright%
    \prul{#1}%
  }%
}

% These allow section titles to present themselves with the formatting of another section. (e.g. sections can have the formatting of a subsection as in the Protective Recitations)
\setsecheadstyle{\sectionFmt}
\setsubsecheadstyle{\subsectionFmt}
\setsubsubsecheadstyle{\subsubsectionFmt}

% % MARKED FOR DELETION!!!
% \newcommand\englishTitle[1]{%
%   \vspace*{-1ex}%
%   \tocEnglishTitle{#1}%
%   {%
%     \subSectionFont\fontsize{11}{17}\selectfont%
%     \itshape\color{section}%
%     \memRTLraggedright%
%     #1%
%   }%
%   \vspace*{2ex \@plus -.5ex \@minus -.2ex}%
% }

% \newcommand\subTitle[1]{%
%   \vspace*{-1ex}%
%   \tocEnglishTitle{#1}%
%   {%
%     \subSectionFont\fontsize{11}{17}\selectfont%
%     \itshape\color{section}%
%     \memRTLraggedright%
%     #1%
%   }%
%   \vspace*{2ex \@plus -.5ex \@minus -.2ex}%
% }

\newif\ifsectionsubtitle
\sectionsubtitlefalse

\newcommand*\@secSubTitle{}

% Formatting for the Sub subtitle which resides below the English section tile.
\newcommand\sectionSubTitle[1]{%
  % \fontsize{8}{8}\selectfont #1\par
  \renewcommand*\@secSubTitle{#1}%
  \global\sectionsubtitletrue%
}

\newcommand\sectionSubTitleClear{%
  \renewcommand*\@secSubTitle{}%
  \global\sectionsubtitlefalse%
}

%%%%%%%%%%%%%%%% Page Geometry and Layout %%%%%%%%%%%%%%%%

% Symbols used:
% P = page proportion (h/w)
% T = textblock proportion (d/m)
% w = paper width
% h = paper height
% m = text width
% d = text height

\newlength\BOOK@paperHeight
\newlength\BOOK@paperWidth

\def\BOOK@fontSizePt{}
\def\BOOK@lineHeightPt{}

% Set font size and line height for normalsize text

\def\BOOK@fontSizePt{12.5}
\def\BOOK@lineHeightPt{19}

% Redefine the \normalsize command to set font size and line height
\renewcommand{\normalsize}{%
  \@setfontsize\normalsize\BOOK@fontSizePt\BOOK@lineHeightPt
  % Set spacing above and below displayed equations
  \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  % Set text color to 'textbody'
  \color{textbody}
  % Set list item style
  \let\@listi\@listI}
% Apply the \normalsize command
\normalsize


\setlength{\vgap}{1.5em}
\setlength{\vindent}{\vgap}
\setlength{\vleftmargin}{2em}

\setlength{\parskip}{8pt}
\setlength{\parindent}{0pt}

%%%%%%%%%%%%%%%% Setup Page Layout %%%%%%%%%%%%%%%%

% A5 page size
\setlength{\BOOK@paperHeight}{210mm}
\setlength{\BOOK@paperWidth}{148mm}

\ifshowtrims
  \stockaiv% use A4 paper size to show trims
  \setlength{\paperheight}{\BOOK@paperHeight}
  \setlength{\paperwidth}{\BOOK@paperWidth}
  \trimXmarks
  \trimLmarks
  \quarkmarks
  \settrims{0.5\stockheight - 0.5\paperheight}{0.5\stockwidth - 0.5\paperwidth}
  \settrimmedsize{\BOOK@paperHeight}{\BOOK@paperWidth}{*}
\else\relax
  \setstocksize{\BOOK@paperHeight}{\BOOK@paperWidth}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}
\fi

% Page Margins
\settypeblocksize{27\baselineskip + \topskip}{120mm}{*}
\setlrmargins{15mm}{*}{*}
\setulmargins{*}{10mm}{1}
\setmarginnotes{8pt}{14pt}{6pt}

\setlength{\footskip}{16pt}

% Adjust spacing to avoid warning
% Class memoir Warning: The material used in the headers is too large (18.0pt) for the given head height (15.6pt),
\addtolength{\headheight}{6pt}
\addtolength{\headsep}{-5pt}

% Increase overfull and underfull tolerance to avoid too many warnings such as
% Overfull \vbox (1.4pt too high) has occurred while \output is active
% Underfull \hbox (badness 10000) in paragraph at lines 150--151
\vfuzz=5pt
\hfuzz=5pt
\hbadness=10000

% Set the margin for side paragraphs to the left side
\sideparmargin{left}

% This will also typeout values in pt (default)
\checkandfixthelayout
% It is useful to see layout values in mm too.
\settypeoutlayoutunit{mm}
\typeoutlayout

% Set the font style for side paragraphs to a custom format defined as \instrFmt
\renewcommand\sideparfont{\instrFmt}

% Define the format for side paragraphs
\renewcommand*\sideparform{%
  \vspace*{-7.2pt}% Adjust the vertical spacing
  % Set the alignment of side paragraphs based on the condition:
  % If memtortm is true, set to ragged right; otherwise, set to ragged left
  \ifmemtortm\raggedright\else\raggedleft\fi
}

% Define math sizes for superscript sizes
\DeclareMathSizes{12.5}{12.5}{7}{7}

% Load the footmisc package with various options:
% - perpage: Restart footnotes numbering on each page
% - symbol*: Use symbols instead of numbers for footnotes
% - bottom: Place footnotes at the bottom of the page
% - norule: Remove the rule above footnotes
% - multiple: Allow multiple footnotes separated by commas
\RequirePackage[perpage,symbol*,bottom,norule,multiple]{footmisc}

% NOTE if you have a quote margin, the \footnotemargin can be set equal to that in your local.sty
% Set the margin for footnotes
\setlength{\footnotemargin}{2em}

% Define the layout for footnotes
\renewcommand{\footnotelayout}{\hangpara{\footnotemargin}{1}}

% Asterisks for the first three footnotes, then numbers produced by the 'symbol*' option.
% Define symbols for the first three footnotes, then use numbers produced by the 'symbol*' option
\DefineFNsymbols{anecdote}{*{**}{***}}
\setfnsymbol{anecdote}

% Attempts to fix problematic endnote links which jump below the target.
\makeatletter
 \newcommand{\linkdest}[1]{\Hy@raisedlink{\hypertarget{#1}{}}}
\makeatother

