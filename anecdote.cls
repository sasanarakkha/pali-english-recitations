%%%%%%%%%%%%%%%% Anecdote Class %%%%%%%%%%%%%%%%

% A memoir-based documentclass with a contemporary style for books with a lighter content.

% (c) Gambhiro Bhikkhu, 2017
% gambhiro.bhikkhu.85@gmail.com

% (c) Pāladhammika Bhikkhu, 2022
% paladhammika@protonmail.com.com

% LPPL LaTeX Public Project Licence

% TODO: document interfaces
% TODO: test document to compile

%%%%%%%%%%%%%%%% Identification %%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{anecdote}[2017/08/19 v0.11 A memoir-based documentclass with a contemporary style for books.]

%%%%%%%%%%% Preliminary Declarations %%%%%%%%%%%

\newif\ifdesktopversion
\desktopversionfalse

\newif\ifoverleaf
\overleaffalse

%%%%%%%%%%%%%%%%%%% Options %%%%%%%%%%%%%%%%%%%%

\RequirePackage{pgfopts}
\RequirePackage{calc}

\pgfkeys{
  /BOOK/.cd,
  babelLanguage/.default=british,
  babelLanguage/.store in=\BOOK@babelLanguage,
  desktopVersion/.code=\desktopversiontrue,
  overleaf/.code=\overleaftrue,
}

% Pass all unknown options to memoir
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}
}

\ProcessPgfOptions{/BOOK}
\ProcessOptions\relax


%%%%%%%%%%%% All Other Declarations %%%%%%%%%%%%

% One side of desktop version
\ifdesktopversion
\LoadClass[11pt,oneside,oldfontcommands]{memoir}
\else
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

% === Color Profile ===

% Embed a color profile in the PDF for correctly interpreting CMYK images.

% \ifoverleaf\relax
% \else
% 
% \immediate\pdfobj stream attr{/N 4} file{assets/other/UncoatedFOGRA29.icc}
% \pdfcatalog{%
%   /OutputIntents [ <<
%   /Type /OutputIntent
%   /S/GTS_PDFX
%   /DestOutputProfile \the\pdflastobj\space 0 R
%   /OutputConditionIdentifier (Uncoated FOGRA29 (ISO 12647-2:2004))
%   /Info(Uncoated FOGRA29 (ISO 12647-2:2004))
%   /RegistryName (http://www.color.org/)
%   >> ]
% }
% 
% \fi

%%%%%%%%%%%%%%%%%% Book Class %%%%%%%%%%%%%%%%%%

%\RequirePackage{silence}
%\WarningsOff

\RequirePackage[\BOOK@babelLanguage]{babel}
\RequirePackage{nag}
\RequirePackage{xparse}
\RequirePackage{soul}
\RequirePackage[geometry]{ifsym}
\RequirePackage{stix}
% Don't use the [cmyk] option. Specify the color model in the color definitions.
\RequirePackage{xcolor}
\RequirePackage{xcoffins}
\RequirePackage{graphicx}
% Add your \graphicspath declaration to your local style.
\RequirePackage{eso-pic}
\RequirePackage{ccicons}
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{footnote}
\RequirePackage{hyphenat}
\RequirePackage{ifthen}
\RequirePackage{titletoc}
\RequirePackage{enumitem}
\RequirePackage{longtable}
\RequirePackage{environ}
\RequirePackage{pageslts}
\RequirePackage{array}
\RequirePackage{ragged2e}
\RequirePackage{tipa}
\RequirePackage{float}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,bending,chains,positioning}
\RequirePackage[object=vectorian]{pgfornament}

% Packages for pali table
\RequirePackage{rotating}
\RequirePackage{makecell}
\settowidth\rotheadsize{{\small Compound}}
\newcommand{\NA}{---}
%% These two are sourced locally in ~/.texmf
\RequirePackage{tabularray}
\RequirePackage{ninecolors}

%%%%%%%%%%%%%%%%% Define Colors %%%%%%%%%%%%%%%%

% Define text colors as Gray color values.
\definecolor{textbody}{gray}{0}% 100% for maximum contrast.
\definecolor{footnoterule}{gray}{0.5}
\definecolor{header}{gray}{0}
\definecolor{footer}{gray}{0}
\definecolor{chapternum}{gray}{0.2}
\definecolor{chaptertitle}{gray}{0.1}
\definecolor{chaptertitlefootnote}{gray}{0.4}
\definecolor{chapterauthor}{gray}{0.3}
\definecolor{chapternote}{gray}{0.3}
\definecolor{section}{gray}{0.05}
\definecolor{tocleftside}{gray}{0.5}
\definecolor{tocleftsidepart}{gray}{0.2}
\definecolor{linkborder}{rgb}{0.4,0.4,1}% light blue
\definecolor{link}{rgb}{0.2,0.2,1}% not so light blue

\definecolor{instruction}{gray}{0.3}

%%%%%%%%%%%%%%%%%% Load Fonts %%%%%%%%%%%%%%%%%%

\RequirePackage{fontspec}
\defaultfontfeatures{ Ligatures={TeX}, Path = {./assets/fonts/}, }

% If -- dashes don't work for your font, try
% Renderer = Basic
% http://tex.stackexchange.com/questions/20580/how-to-enable-ligatures-for-emdash-endash-in-luatex

\setmainfont[
  ItalicFont = LibertinusSerif-Italic.otf,
  BoldFont = LibertinusSerifX-Bold.ttf,
  BoldItalicFont = LibertinusSerif-BoldItalic.otf,
]{LibertinusSerifX-Regular.ttf}

\newfontfamily\libertinusFont[
  ItalicFont = LibertinusSerif-Italic.otf,
  BoldFont = LibertinusSerifX-Bold.ttf,
  BoldItalicFont = LibertinusSerif-BoldItalic.otf,
]{LibertinusSerifX-Regular.ttf}

\newfontfamily\sbsFont[
  ItalicFont = palisbs.ttf,
  BoldFont = palisbs.ttf,
  BoldItalicFont = palisbs.ttf,
]{palisbs.ttf}

%%%%%%%%%%%%%%%% SBS Font %%%%%%%%%%%%%%%%

% \newfontfamily\sbsFont{palisbs.ttf}

% \newcommand*\sbs[1]{{\sbsFont #1}}

%%%%%%%%%%%%%%%% Header & Footer %%%%%%%%%%%%%%%%

\newcommand\headerFont\libertinusFont
\newcommand\footerFont\headerFont
\newcommand\pageNumFont\headerFont

%%%%%%%%%%%%%%%% Chapter & Section %%%%%%%%%%%%%%%%

\newcommand\partNameFont\libertinusFont
\newcommand\partTitleFont\libertinusFont

\newcommand\chapterNameFont\libertinusFont
\newcommand\chapterTitleFont\libertinusFont
\newcommand\chapterNumberFont\libertinusFont
\newcommand\chapterAuthorFont\libertinusFont
\newcommand\chapterNoteFont\libertinusFont

\newcommand\sectionFont\libertinusFont
\newcommand\subSectionFont\libertinusFont

\newcommand\instructionFont\libertinusFont

%%%%%%%%%%%%%%%%%%%%%% Quote %%%%%%%%%%%%%%%%%%%%%%

\newcommand\sideruleQuoteFont\libertinusFont

%%%%%%%%%%%%%%%% Table of Contents %%%%%%%%%%%%%%%%

\newcommand\tocFont\libertinusFont
\newcommand\tocFontOldNum\libertinusFont

% Some default font sizes, use \renewcommand to adjust

\newcommand{\chapterNameSize}{\@setfontsize          \chapterNameSize          {22}{24}}
\newcommand{\chapterNumberSize}{\@setfontsize        \chapterNumberSize        {20}{20}}
\newcommand{\chapterTitleSize}{\@setfontsize         \chapterTitleSize         {19}{19}}
\newcommand{\chapterTitleFootnoteSize}{\@setfontsize \chapterTitleFootnoteSize {16}{30}}
\newcommand{\chapterAuthorSize}{\@setfontsize        \chapterAuthorSize        {12}{14}}
\newcommand{\chapterNoteSize}{\@setfontsize          \chapterNoteSize          {13}{15}}
\newcommand{\footerSize}{\@setfontsize               \footerSize               {11}{8}}
% Changes header at the top of the page indication section and page number
\newcommand{\headerSize}{\@setfontsize               \headerSize               {11}{2}}
\newcommand{\tocSize}{\@setfontsize                  \tocSize                  {19}{14}}
% Changes section/chant font size in ToC e.g. 'Dedication of Offerings'
\newcommand{\tocSectionSize}{\@setfontsize           \tocSectionSize           {12.5}{15}}
% Changes subsection/chant font size in ToC e.g. 'Undertaking the Three Refuges'
\newcommand{\tocSubsectionSize}{\@setfontsize        \tocSubsectionSize        {11}{11}}

\newcommand{\smaller}{\@setfontsize\smaller{9}{11}}

\newcommand{\copyrightsize}{\@setfontsize\copyrightsize{9}{11}}

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

%%%%%%%%%%%%%%%% Foregin Languuge Wrappers %%%%%%%%%%%%%%%%

\newfontfamily\thaiFont{Kinnari.ttf}

\newcommand*\thai[1]{{\thaiFont #1}}

\newcommand{\instrFmt}{%
  \color{instruction}\instructionFont\upshape\fontsize{10}{13}\selectfont%
}

\newcommand\pointerMark{\vspace*{-1pt}\blackpointerright}

%%%%%%%%%%%%%%%%%%%%%% Microtype %%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[final,babel=true]{microtype}

% Tracking for uppercase section heading
\SetTracking[spacing={400,100,}]{encoding=*, family={LibertinusSerif-Regular.otf}}{20}

%%%%%%%%%%%%%%%%%%%%%%% Hyperref %%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{hyperxmp}
\RequirePackage{hyperref}

\hypersetup{
  unicode=true,
  bookmarksopen=true,
  bookmarksopenlevel=3,
  hypertexnames=false,
  linktoc=all,
  plainpages=false,
  raiselinks=true,
  breaklinks
}

\ifdesktopversion
% Colors: in the desktop version, use colored link text
\hypersetup{
  colorlinks=true,
  linkcolor=sbs-brown,
  citecolor=sbs-brown,
  filecolor=sbs-brown,
  urlcolor=sbs-brown,
}
\else
% Colors: in the print version, set link colors to text color, so that it doesn't interfere with printing
\hypersetup{
  colorlinks=true,
  linkcolor=textbody,
  citecolor=textbody,
  filecolor=textbody,
  urlcolor=textbody,
}
\fi

\RequirePackage[
  open,
  openlevel=2
]{bookmark}

% Color used for links and headers
\definecolor{sbs-brown}{HTML}{60291F}
% Color used for subtitle
\definecolor{sbs-brown2}{HTML}{573005}
% Color used for dividers
\definecolor{sbs-gold}{HTML}{aa6a1f}

% Fixes endnotes two-way link that aim too low
% https://tex.stackexchange.com/questions/17057/hypertarget-seems-to-aim-a-line-too-low


%%%%%%%%%%%%%%%% Penalties & Hyphenation %%%%%%%%%%%%%%%%

% memoir's more allowing penalties
\midsloppy

\ifthenelse{\equal{\BOOK@babelLanguage}{british}}{
  \renewcommand\britishhyphenmins{{3}{3}}
}{}
\ifthenelse{\equal{\BOOK@babelLanguage}{italian}}{
  \renewcommand\italianhyphenmins{{3}{3}}
}{}
\ifthenelse{\equal{\BOOK@babelLanguage}{portuguese}}{
  \renewcommand\portuguesehyphenmins{{3}{3}}
  % If using babel, captions names have to be renamed like this
  \addto\captionsportuguese{
    \renewcommand{\contentsnam}{Índice}
    \renewcommand{\bibname}{Referências}
  }
  % Portuguese repeats hyphen
  % http://tex.stackexchange.com/a/247298/831
  % generates a hyphen that will repeat on a new line
  \defineshorthand{"-}{\babelhyphen{repeat}}
}{}

\hyphenpenalty=700
\exhyphenpenalty=50
\doublehyphendemerits=900
%\finalhyphendemerits=5000 % default is 5000

% It is more effective to \mbox{...} the words to avoid hyphenation.
\brokenpenalty=5000 % penalty for page break after a hyphenated line

% NOTE: This package is best for prose text. Here it creates unexpected page breaks,
% and complicates the endnotes formatting.
% \RequirePackage[defaultlines=2,all]{nowidow}

% === common hyphenation exceptions and corrections ===
%%%%%%%%%%%%%%%% Anecdote Class %%%%%%%%%%%%%%%%

\hyphenation{season wisdom develop-ment respon-sible pheno-mena
philo-sophical munindo amaravati thai-land}

%\hyphenation{accur-ately argu-men-ta-tive attach Ayu-dhaya becomes
%ben-e-fi-cial capa-bil-ity car-ry car-ry-ing cere-monies cere-mony
%ces-sa-tion chal-lenge chal-leng-ing clas-si-fi-ca-tion
%clas-si-fi-ca-tions clas-si-fied com-mu-nity con-di-tion
%con-di-tioned con-struc-tions con-tem-plate con-tem-plat-ing
%con-tem-pla-tion cul-ti-vate cul-ti-vates cul-ti-vat-ing
%cul-ti-vation def-i-ni-tion de-ter-mine de-ter-mined dhamma dhammas
%dis-cern-ment dis-con-tent dis-cur-sive dying em-pha-size
%enlight-ened equa-nim-ity es-pe-cial-ly estab-lish exist-ence
%ex-pe-ri-ence hap-pen-ing having ig-no-rance immedi-ately
%im-per-ma-nent in-nu-mer-a-ble in-se-cu-ri-ty in-spir-ing
%in-struct-ed in-ves-ti-gate in-ves-ti-ga-tion iso-late iso-lat-ed
%Keuan lay-peo-ple ma-te-ri-al mat-u-ra-tion medi-tate medi-ta-tion
%medi-ta-tive mental mon-as-teries mon-as-tery Nana-chat or-dain
%or-dain-ed or-di-na-tion orig-inate oth-er-wise pene-trat-ing
%per-son-al per-son-al-ity phe-nom-e-na phe-nom-e-non po-si-tion
%pow-er pow-ers pre-vi-ous pro-lif-er-ate pro-lif-er-ating
%pro-lif-er-a-tions puthu-jjana quest-ion rec-i-ta-tion
%sat-is-fac-tory sen-sa-tion sen-sa-tions sim-i-lar suf-fer-ing
%sup-po-si-tion syn-on-y-mous tem-per-a-ment tem-per-a-ments tong-rat
%tran-scend tran-scend-ent tran-scends un-con-di-tioned under-stand
%under-stood un-hap-pi-ness un-sat-is-fac-tori-ness un-sat-is-fac-tory
%ven-er-able wea-ri-ness what-ev-er when-ever wher-ever whole-hearted
%whole-heart-edly wrong-do-ing}

%%%%%%%%%%%%%%%% Soul Settings %%%%%%%%%%%%%%%%

\sodef\soTocChapter{}{.1em}{.5em plus.1em}{.1em plus.1em minus.1em}
\sodef\soSection{}{.07em}{.4em plus.1em}{.1em plus.1em minus.1em}

% Use \textls letterspacing (for uppercase chapter titles for example)
% with microtype instead, because soul swallows
% accented characters at the end of words.

%%%%%%%%%%%%%%%% Custom Commands & Environments %%%%%%%%%%%%%%%%

% https://tex.stackexchange.com/questions/4839/raggedleft-paragraph-in-a-table

% Use with: \begin{tabular}{L{30mm}R{30mm}}

\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}

% Allows hyphenation:
% \newcolumntype{L}[1]{>{\RaggedRight\hspace{0pt}}p{#1}}
% \newcolumntype{R}[1]{>{\RaggedLeft\hspace{0pt}}p{#1}}

\newcommand\dividerRule{%
{\centering\bigskip
{\color[gray]{0.6}\rule{0.6\linewidth}{0.2pt}}
\par\bigskip}%
}

\newcommand\emptysheet{%
  \cleardoublepage
  \thispagestyle{empty}\mbox{}\newpage
  \thispagestyle{empty}\mbox{}\newpage
}

\newcommand\emptydoublepage\emptysheet

\newcommand\emptypage{%
  \clearpage
  \thispagestyle{empty}\mbox{}\newpage
}

\newcommand{\emptyUntilEven}{%
  \ifodd\thepage%
  \clearpage\thispagestyle{empty}\null%
  \fi%
}

\newcounter{pageRem}
\newcounter{origPage}

% Add empty pages for a total page count divisible by 8 without remainder.
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

\newcommand*{\subtitle}[1]{\def\@thesubtitle{#1}}
\newcommand*{\editionInfo}[1]{\def\@theEditionInfo{#1}}
\newcommand*{\printedByInfo}[1]{\def\@thePrintedByInfo{#1}}
\newcommand*{\publisher}[1]{\def\@thePublisher{#1}}
\newcommand*{\ISBN}[1]{\def\@theISBN{#1}}

\newcommand\thesubtitle{\@thesubtitle}
\newcommand\theEditionInfo{\@theEditionInfo}
\newcommand\thePrintedByInfo{\@thePrintedByInfo}
\newcommand\thePublisher{\@thePublisher}
\newcommand\theISBN{\@theISBN}

\newsavebox{\quotepagebox}
\newenvironment{quotepage}[1]
  {\begin{lrbox}{\quotepagebox}\begin{minipage}{#1}
   \setlength{\parskip}{0.6\baselineskip}
   \setlength{\parindent}{0pt}}
  {\end{minipage}\end{lrbox}%
   \begin{tikzpicture}[remember picture,overlay]
   \node at (current page.center) {\usebox{\quotepagebox}};
   \end{tikzpicture}}

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

\newcommand\speakerName[1]{%
  % The hangindent only works with alternating speakers.
  %\par\hangindent=1pc%
  {\color[gray]{0.25}\libertinusFont\scshape\MakeLowercase{#1}}\quad}

\newlength\qw
\setlength\qw{17pt}% same as parindent for smallpage

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

% If class option desktopVersion is used, show content in a paper sized
% minipage, empty page otherwise.
% Redefine \color{desktopcoverbg} to change page background color.
\newcommand\desktopCover[1]{%
\thispagestyle{empty}\mbox{}
\ifdesktopversion
\AddToShipoutPictureFG*{\put(0,0){%
\begin{minipage}[b][\paperheight][c]{\paperwidth}%
#1
\end{minipage}}}
\fi
\clearpage
}

%%%%%%%%%%%%%%%% Titlepage %%%%%%%%%%%%%%%%

\newlength{\titleLength}
\newlength{\xheight}

%%%%%%%%%%%%%%%% Quotes %%%%%%%%%%%%%%%%

\newlength{\quoteMargin}
\setlength{\quoteMargin}{18pt}

% FIXME
%\setlength{\footnotemargin}{\quoteMargin}

\newenvironment{openingVerse}%
{%
  \cleartoverso%
  \thispagestyle{empty}%
  \mbox{}\vfill%
  \begin{verse}%
}%
{%
  \par\end{verse}%
  \vfill\mbox{}%
}

% for sutta verses and other short stanzas
\renewenvironment{verse}
{\begin{centering}%
    \itshape}%
{\par\end{centering}}

\newcommand{\verseRef}[1]{%
  {\centering\itshape\footnotesize #1\par}%
}

\newcommand{\suttaRef}[1]{%
  % \vspace{-12pt \@plus 5pt \@minus 0pt}%
  \vspace{-6pt}%
  \hfill {\fontsize{8}{16}\selectfont #1\par}%
}

% for longer sutta and book quotes
\renewenvironment{quote}%
{\list{}{%
    \itshape
    \listparindent 0pt
    \itemindent    \listparindent
    \leftmargin    \quoteMargin
    \rightmargin   \quoteMargin
    \parsep        8pt
    \topsep        0pt
    \partopsep     0pt}%
\item[]}%
{\endlist}

\newcommand{\quoteTitle}[1]{%
  {%
    \centering\upshape\itshape%
    \fontsize{26}{10}\selectfont%
    \color{section}%
    #1%
    % \par%
  }%
\itshape%
}

\newcommand{\quoteRef}[1]{%
  {\centering\itshape\footnotesize #1\par}%
}

\newcommand{\quoteRefInline}[1]{%
  {\hfill\itshape\footnotesize #1}%
}

\newenvironment{speaker}%
{\list{}{%
    \listparindent 0pt
    \itemindent    \listparindent
    \leftmargin    \quoteMargin
    \rightmargin   \quoteMargin
    \parsep        8pt
    \topsep        0pt
    \partopsep     0pt}%
\item[]}%
{\endlist}

\newlength{\quoteRuleWidth}
\newlength{\quoteTopBotSep}
\newlength{\quoteHeight}

\setlength{\quoteTopBotSep}{15pt}

\newcommand{\sideruleQuoteFmt}[1]{%
  \begin{minipage}{\linewidth - 40pt}%
    \sideruleQuoteFont\Large\color[gray]{0.2}%
    #1%
  \end{minipage}%
}

\definecolor{quoteRuleFill}{gray}{0.95}
\definecolor{quoteRule}{gray}{0.7}

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

\newlength{\diaItemIndent}
\setlength{\diaItemIndent}{-\quoteMargin}
\newlength{\diaLeftMargin}
\setlength{\diaLeftMargin}{2\quoteMargin}

\newenvironment{dialogue}%
{\list{}{%
    \listparindent 0pt
    \itemindent    \diaItemIndent
    \leftmargin    \diaLeftMargin
    \rightmargin   0pt
    \parsep        4pt
    \topsep        0pt
    \partopsep     0pt}%
\relax}%
{\endlist}

\newcommand\photoFullBleed[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \includegraphics[height={\paperheight + 6mm}]{#1}%
    }%
  }%
}

\newcommand\photoSideBleed[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{0mm}){%
      \begin{minipage}[b][\paperheight][c]{\paperwidth + 6mm}%
        \includegraphics[width={\paperwidth + 6mm}]{#1}%
      \end{minipage}%
    }%
  }%
}

\newcommand\photoSideBleedPlaceholder[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{0mm}){%
      \begin{minipage}[b][\paperheight][c]{\paperwidth + 6mm}%
        \color[gray]{0.8}%
        \rule{\paperwidth + 6mm}{0.5\paperheight}%
      \end{minipage}%
    }%
  }%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{0mm}){%
      \begin{minipage}[b][\paperheight][c]{\paperwidth + 6mm}%
        \HUGE\centering
        \color{white}%
        #1%
      \end{minipage}%
    }%
  }%
}

\newcommand\photoFullBleedPlaceholder[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \color[gray]{0.8}%
      \rule{\paperwidth + 6mm}{\paperheight + 6mm}%
    }%
  }%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \begin{minipage}[b][\paperheight + 6mm][c]{\paperwidth + 6mm}%
        \HUGE\centering
        \color{white}%
        #1%
      \end{minipage}%
    }%
  }%
}

% #1: photo
\newcommand{\chapterPhotoPagePortrait}[1]{%
  \clearpage%
  \mbox{}\vfill%
  {\centering%
    \includegraphics[width=100mm]{#1}%
  \par}%
  \vfill\mbox{}%
  \clearpage%
}

% #1: width
% #2: photo
\newcommand{\chapterPhotoInlinePortrait}[2]{%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
  {\centering%
    \includegraphics[width=#1]{#2}%
  \par}%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
}

% #1: photo
\newcommand{\chapterPhotoPageLandscape}[1]{%
  \clearpage%
  \mbox{}\vfill%
  {\centering%
    \includegraphics[width=\linewidth]{#1}%
  \par}%
  \vfill\mbox{}%
  \clearpage%
}

% The width only makes sense at \linewidth. Copy the macro inline and add trim
% and clip option on the photo if necessary.
%
% #1: photo
\newcommand{\chapterPhotoInlineLandscape}[1]{%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
  {\centering%
    \includegraphics[width=\linewidth]{#1}%
  \par}%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
}

\newcommand{\thechaptergraphics}{}

\newcommand{\chapterOpeningPage}[1]{%
  \renewcommand{\thechaptergraphics}{#1}
}

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

\newcommand\quoteBreak{%
  \vspace{0pt \@plus 5pt \@minus 0pt}%
  \par%
  {%
    \centering%
    \fontsize{8}{8}\selectfont%
    \color[gray]{0.4}%
    \FilledDiamondshape%
  \par}%
  \vspace{0pt \@plus 5pt \@minus 0pt}%
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

% A mark indicating a pause, using the middle dot (U+00B7).

\newcommand\pausemark{%
  \raisebox{-1pt}{\fontsize{20}{20}\bfseries\symbol{"00B7}}%
}

\newcommand\anglebracketleft{%
  \raisebox{0.0\baselineskip}{\Large\symbol{"2329}}%
 }

\newcommand\anglebracketright{%
  \raisebox{0.0\baselineskip}{\Large\symbol{"232A}}%
 }

% Original bottomNav
% Navigation links at the bottom of the page
% Places a link to the Recitation Schedule, and a link to the next chant in the schedule.
%
% #1 : label to the next chant
% \newcommand\bottomNav[1]{%
%   \vfill
%   \begin{minipage}{\linewidth}%
%     \centering
%     % \hyperref[contents]{$\Leftarrow$}\hspace*{1em}%
%     \hyperref[contents]{
%     \textbf{\textsc{\textls*{contents}}}}\hspace*{0.1em}%
%     \hspace*{0.2em} \textbf{--} \hspace*{0.2em}%
%     % \hyperref[#1]{$\Rightarrow$}%
%     \hyperref[contents]{%
%     \textbf{\textsc{\textls*{next}}}}\hspace*{0.1em}%
%   \end{minipage}%
% }

\newcommand\bottomNav[1]{%
  \vfill
  \ifdesktopversion
  \begin{minipage}{\linewidth}%
    % \centering
    \hyperref[schedule]{%
      \textbf{\raggedright\textsc{\fontsize{10}{0}\textls*{Schedule}}}}
    % \hspace*{0.05em} \pgfornament[color=brown,width=5mm,scale=0,ydelta=-3.5pt,symmetry=c]{4} \hspace*{0.05em}%
    \hfill
    \hyperref[#1]{%
      \textbf{\raggedleft\textsc{\fontsize{10}{0}\textls*{Next}}}}%
  \end{minipage}%
  \fi
}

\newenvironment{glossarydescription}%
{\list{}{%
    \labelwidth\z@ \itemindent-\leftmargin
    \labelsep 2pt
    \let\makelabel\glossaryDescriptionlabel}}%
{\endlist}

\newcommand*{\glossaryDescriptionlabel}[1]{%
  \normalfont\textbf{#1}%
  \hspace*{\labelsep}%
}

%%%%%%%%%%%%%%%% Color Specs %%%%%%%%%%%%%%%%

\newcommand\modelTmp{}
\newcommand\specTextbody{}
\newcommand\specChaptertitle{}
\newcommand\specSection{}
\newcommand\specFootnote{}
\newcommand\specFooter{}

\newcommand\extractSpecs{%
  \extractcolorspecs{textbody}{\modelTmp}{\specTextbody}%
  \extractcolorspecs{chaptertitle}{\modelTmp}{\specChaptertitle}%
  \extractcolorspecs{section}{\modelTmp}{\specSection}%
  \extractcolorspecs{footnote}{\modelTmp}{\specFootnote}%
  \extractcolorspecs{footer}{\modelTmp}{\specFooter}%
}

% #1: description title of specs, such as 'variation A, base colors'
\newcommand{\printSpecs}[1]{%
  \cleartoverso%
  \mbox{}\vfill
  \thispagestyle{empty}%
  \extractSpecs%

  #1

  \begin{tabular}{@{} l l}
    Chapter title & \specChaptertitle \\
    Text body & \specTextbody \\
    Section & \specSection \\
    Footnote & \specFootnote \\
    Footer & \specFooter \\
  \end{tabular}%
  \vfill\mbox{}%
}

%%%%%%%%%%%%%%%% Renewing Package Macros %%%%%%%%%%%%%%%%

\addtodef{\mainmatter}{}{%
  % \addtocontents{toc}{\addvspace{5pt}}%
  % \setcounter{chapter}{0}%
}

\addtodef{\appendix}{}{%
  % Not adding vspace here because it interferes with the closing '.' of the
  % section list. The vertical space is added in \titlecontents{appendix}.
  \bookmarksetup{startatroot}%
}

\addtodef{\backmatter}{}{%
  \bookmarksetup{startatroot}%
}

\newcommand\quoteref[1]{%
\par
{\footnotesize #1}
\par
}

% adapted from base/latex.ltx
\def\footnoterule{%
  \kern-3\p@
  {\color{footnoterule}\rule{\columnwidth}{0.25pt}}%
  \vspace*{7pt}%
  \kern 2.6\p@}

\renewcommand*{\notesname}{Notes}
\renewcommand*{\notedivision}{\chapter{\notesname}}
\renewcommand*{\pagenotesubhead}[3]{}
\renewcommand*{\notenumintext}[1]{\textsuperscript{\thinspace #1}}
\renewcommand{\prenoteinnotes}{\par\noindent\hangindent=17pt}
\renewcommand{\postnoteinnotes}{\par\vspace*{0.5\baselineskip}}

%% http://tex.stackexchange.com/questions/36894/underline-omitting-the-descenders
%% http://tex.stackexchange.com/a/75406

\RequirePackage[outline]{contour}
\RequirePackage[normalem]{ulem}

\newcommand\prul[1]{%
  \begingroup%
  \renewcommand{\ULdepth}{1.8pt}%
  \renewcommand{\ULthickness}{0.5pt}%
  \contourlength{0.5pt}%
  \uline{\phantom{#1}}\llap{\contour{white}{#1}}%
  \endgroup%
}

%%%%%%%%%%%%%%%% Page Styles %%%%%%%%%%%%%%%%

\nouppercaseheads

% define page styles with names about "what it does"

\newcommand{\sepline}{%
  \hspace{6pt}%
  \raisebox{-0.3\baselineskip}{\rule{0.2pt}{1.2\baselineskip}}%
  \hspace{6pt}%
}

\makepagestyle{toponerow}
\makeevenhead{toponerow}{\headerFont\headerSize\color{header}\thepage}{}{\headerFont\headerSize\color{header}\textls*{\textsc{\leftmark}}}
\makeevenfoot{toponerow}{}{}{}
\makeoddhead{toponerow}{\headerFont\headerSize\color{header}\textls*{\textsc{\leftmark}}}{}{\headerFont\headerSize\color{header}\thepage}
\makeoddfoot{toponerow}{}{}{}
\makepsmarks{toponerow}{%
  \nouppercaseheads
  \createmark{chapter}{left}{nonumber}{}{}
  \createmark{section}{right}{nonumber}{}{}
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}
}

\makepagestyle{toponerow-frontmatter}
\makeevenhead{toponerow-frontmatter}{\headerFont\headerSize\color{header}\thepage}{}{\headerFont\headerSize\color{header}\textls*{\textsc{\leftmark}}}
\makeevenfoot{toponerow-frontmatter}{}{}{}
\makeoddhead{toponerow-frontmatter}{\headerFont\headerSize\color{header}\textls*{\textsc{\leftmark}}}{}{\headerFont\headerSize\color{header}\thepage}
\makeoddfoot{toponerow-frontmatter}{}{}{}
\makepsmarks{toponerow-frontmatter}{%
  \nouppercaseheads
  \createmark{chapter}{left}{nonumber}{}{}
  \createmark{section}{right}{nonumber}{}{}
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}
}

\makepagestyle{bottomcorner}
\makeevenhead{bottomcorner}{}{}{}
\makeevenfoot{bottomcorner}{%
  \footerFont\footerSize%
  \color{footer}%
  \thepage\hspace*{1em}$\cdot$\hspace*{1em}\textit{\thetitle}%
}{}{}
\makeoddhead{bottomcorner}{}{}{}
\makeoddfoot{bottomcorner}{}{}{%
  \footerFont\footerSize%
  \color{footer}%
  \textit{\leftmark}\hspace*{1em}$\cdot$\hspace*{1em}\thepage%
}

\makepagestyle{bottomcenter}
\makeevenhead{bottomcenter}{}{}{}
\makeevenfoot{bottomcenter}{}{%
  \footerFont\footerSize%
  \color{footer}%
  \thepage%
}{}
\makeoddhead{bottomcenter}{}{}{}
\makeoddfoot{bottomcenter}{}{%
  \footerFont\footerSize%
  \color{footer}%
  \thepage%
}{}

% alias the pagestyles into semantic names, "where it is used"

\aliaspagestyle{normalpage}{toponerow}
\aliaspagestyle{chapter}{bottomcenter}
\aliaspagestyle{book}{empty}
\aliaspagestyle{part}{empty}
\aliaspagestyle{afterpart}{empty}

\pagestyle{normalpage}

%%%%%%%%%%%%%%%% Table of Contents Settings %%%%%%%%%%%%%%%%

\maxtocdepth{subsubsection}

% the right TOC margin
\contentsmargin{-5pt}

\newlength\tocLeftWidth
\setlength\tocLeftWidth{0pt}

% Roman numerals in the chapter title TOC chapter entries.
%\renewcommand\thechapter{\Roman{chapter}}

% Fixes Undefined control sequence error for \@chapapp@head
\renewcommand\chapternumberline[1]{\numberline{#1}}
\renewcommand\partnumberline[1]{\numberline{#1}}

% Fixes Missing number error when chapter number is not numeric, as in
% Appendix A
\let\ttll@appendix\ttll@chapter

\newcommand*\l@chapternote{\@nodottedtocline{0}{\tocLeftWidth}{1pc}{1pc}}

\def\@nodottedtocline#1#2#3#4#5#6{%
  \ifnum #1>\c@tocdepth \else
    %\vskip \z@ \@plus.2\p@
    \vspace*{3pt}
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

\def\tocChapterNote#1{%
  \addcontentsline{toc}{chapternote}{%
  \noexpand\numberline{}#1}%
}

\newcommand{\tocEnglishTitleFmt}[1]{%
  {%
    \libertinusFont\tocSectionSize\itshape\selectfont%
    \hspace*{\tocLeftWidth}\hspace*{5em}%
    #1%
    \par
  }%
}

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

% Changes chapter headings in ToC e.g. 'Schedule, Abbreviations, etc.'
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

%%%%%%%%%%%%%%%% Book Styles %%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% Part Styles %%%%%%%%%%%%%%%%

\newif\ifthisparthastitle
\thisparthastitletrue

\newif\ifthisparthasnote
\thisparthasnotefalse

\newcommand*{\thePartNote}{}
\newcommand*{\partNote}[1]{%
  \thisparthasnotetrue%
  \renewcommand*\thePartNote{#1}%
}

\renewcommand{\partnamefont}{\fontsize{12}{12}\selectfont\partTitleFont\color[gray]{0.1}}
\renewcommand{\parttitlefont}{\fontsize{18}{18}\selectfont\partTitleFont\color[gray]{0.1}}

%\renewcommand{\printpartname}{\partnamefont \partname}
%\renewcommand{\partnamenum}{\space}
%\renewcommand{\printpartnum}{\partnumfont \thepart}

\newcommand\printpart{\textls*{\partnamefont\MakeUppercase{\partname \space \thepart}}}
\renewcommand{\printparttitle}[1]{\textls*{\parttitlefont\MakeUppercase{#1}}}

\renewcommand*{\midpartskip}{\par\vskip 15pt}%

% FIXME: Currently, if there isn't a part title, we have to do
% \part{\space} to still create the part line in the TOC and the
% bookmark index.
%
% It would be better if the index had ``Part One'', and the TOC would
% handle it better too.

\long\def\@part[#1]#2{%
  \M@gettitle{#1}%
  \phantomsection
  \ifnum \c@secnumdepth >-2\relax
  \refstepcounter{part}%
  \addcontentsline{toc}{part}%
  {\protect\partnumberline{\thepart}#1}%
  \mempartinfo{\thepart}{#1}{#2}%
  \else
  \addcontentsline{toc}{part}{#1}%
  \mempartinfo{}{#1}{#2}%
  \fi
  \partmark{#1}%
  {%
    \raggedright
    \hspace*{17pt}%
    \begin{minipage}{\linewidth - 17pt}
      \raggedright
      \interlinepenalty \@M
      \parskip\z@
      \ifthisparthasnote
        \thePartNote
        \par
        \global\thisparthasnotefalse
        \midpartskip
      \fi
      \normalfont
      \ifnum \c@secnumdepth >-2\relax
        {\printpart}%
        \par\vskip 20pt
      \fi
      \ifthisparthastitle
        \printparttitle{#2}
      \else
        \global\thisparthastitletrue
      \fi
      \par%
    \end{minipage}%
    \par%
  }%
\@endpart}

%%%%%%%%%%%%%%%% Chapter Styles %%%%%%%%%%%%%%%%

% NOTE: Sub-section ref. numbers are used in the vinaya notes, such as:
%
% 'If more than one article is to be shared substitute the plural form as in
% sec. 10.4.1 above.'
%
% Sub-sub-section is only used in the Sri Lankan chants chapter, but it helps
% the content separation to still number them.

\setsecnumdepth{none}

% define chapter styles with "fantasy" names

\newif\ifchapterauthor
\chapterauthorfalse

\newcommand*{\theChapterAuthor}{}
\newcommand*{\chapterAuthor}[1]{%
  \chapterauthortrue%
  \renewcommand*{\theChapterAuthor}{#1}%
}

\newcommand\chapterAuthorFmt[1]{%
  \chapterAuthorFont\chapterAuthorSize\color{chapterauthor}%
  #1%
}

\newif\ifchapternote
\chapternotefalse

\newcommand\chapterNoteFmt[1]{%
  \chapterNoteFont\chapterNoteSize\color{chapternote}%
  \itshape #1%
}

\newcommand{\theChapterNote}{}
\newcommand{\chapterNote}[1]{%
  \chapternotetrue%
  \renewcommand*\theChapterNote{#1}%
}

\newif\ifchapterfootnote
\chapterfootnotefalse

\newcommand*{\theChapterFootnoteMark}{}
\newcommand*{\theChapterFootnoteText}{}
\newcommand*{\chapterFootnote}[2][\footnotemark]{%
  \chapterfootnotetrue%
  \renewcommand*\theChapterFootnoteMark{#1}%
  \renewcommand*\theChapterFootnoteText{\footnotetext{#2}}%
}

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

% Commands to assign the chapter styles to book parts. Use \renewcommand
% to adjust.

% No numbers in chapter mark
%\createmark{chapter}{left}{nonumber}{}{}

\newcommand\frontmatterChapterStyle{\chapterstyle{adrasteia-frontmatter}}
\newcommand\mainmatterChapterStyle{\chapterstyle{adrasteia}}
\newcommand\appendixChapterStyle{\chapterstyle{adrasteia-appendix}}
\newcommand\backmatterChapterStyle{\chapterstyle{adrasteia-backmatter}}

% append them to the macros
\addtodef{\frontmatter}{}{\frontmatterChapterStyle}
\addtodef{\mainmatter}{}{\mainmatterChapterStyle}
\addtodef{\appendix}{}{\appendixChapterStyle}
\addtodef{\backmatter}{}{\backmatterChapterStyle}

%%%%%%%%%%%%%%%% Section Styles %%%%%%%%%%%%%%%%

% TODO: could use \makeheadstyles to keep bundle different chapter and
% section style together. See memoir manual '6.9 Predefined heading
% styles'.

% No glue after section headers. It is better to break the page early. With
% glue, (eg \setaftersecskip{2.3ex \@plus .2ex}), when nowidow moves some lines
% to the next page, the space after the section header will strech a lot to shift
% the bottom lines to the bottom of the text block.
%
% With no glue, the space will be at the bottom of the text block instead.

\setbeforesecskip{10pt}

% \setsechook{%
%   % New page for each section.
%   \clearpage%
%   % Empty the default section number printing, so that we can handle it.
%   \setsecnumformat{}%
% }

% Alters space before and after subtitles
\setaftersubsecskip{2ex \@plus -.5ex \@minus -.2ex}

\setbeforesubsecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersubsecskip{0.1ex \@plus -.5ex \@minus -.2ex}

\setbeforesubsubsecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersubsubsecskip{1ex}


% Roman numerals for section numbering.
%\renewcommand*{\thesection}{\roman{section}}

\newlength\sectionTitleLength

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
      % Print the subtitle if it has been set with \sectionPaliTitle, then reset
      % it so following sections don't use the same value.
      \vspace*{-4pt}%
      \parbox{\linewidth}{%
        \centering%
        % font size for paliTitle
        \color{black}
        \fontsize{12}{14}\selectfont
        \@secSubTitle%
        \sectionPaliTitleClear%
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
  \begin{minipage}{\linewidth}%
    \centering%
    \pgfornament[color=black,width=7cm,scale=1,ydelta=24pt,symmetry=c]{88}%
  \end{minipage}%
  % Something is causing this bracket unbalance but it doesn't break the build.
  % Starting at the title hyperref above
}

\newcommand\subsectionFmt[1]{%
  {%
    \subSectionFont\fontsize{14}{18}\selectfont%
    \scshape\bfseries%
    \centering
    % \vspace*{-7.2pt}% what is the needed for? commented removes gap in anumodana-paritta section
    #1%
  }%
}

\newcommand\subsubsectionFmt[1]{%
  {%
    \subSectionFont\fontsize{11}{17}\selectfont%
    \itshape%
    \memRTLraggedright%
    \prul{#1}%
  }%
}

\setsecheadstyle{\sectionFmt}
\setsubsecheadstyle{\subsectionFmt}
\setsubsubsecheadstyle{\subsubsectionFmt}

\newcommand\englishTitle[1]{%
  \vspace*{-1ex}%
  \tocEnglishTitle{#1}%
  {%
    \subSectionFont\fontsize{11}{17}\selectfont%
    \itshape\color{section}%
    \memRTLraggedright%
    #1%
  }%
  \vspace*{2ex \@plus -.5ex \@minus -.2ex}%
}

\newcommand\paliTitle[1]{%
  \vspace*{-1ex}%
  \tocEnglishTitle{#1}%
  {%
    \subSectionFont\fontsize{11}{17}\selectfont%
    \itshape\color{section}%
    \memRTLraggedright%
    #1%
  }%
  \vspace*{2ex \@plus -.5ex \@minus -.2ex}%
}

\newif\ifsectionsubtitle
\sectionsubtitlefalse

\newcommand*\@secSubTitle{}

\newcommand\sectionPaliTitle[1]{%
  % \fontsize{8}{8}\selectfont #1\par
  \renewcommand*\@secSubTitle{#1}%
  \global\sectionsubtitletrue%
}

\newcommand\sectionPaliTitleClear{%
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

%%%%%%%%%%%%%%%% Normalsize %%%%%%%%%%%%%%%%

\def\BOOK@fontSizePt{12.5}
\def\BOOK@lineHeightPt{19}

\renewcommand{\normalsize}{%
  \@setfontsize\normalsize\BOOK@fontSizePt\BOOK@lineHeightPt
  \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \color{textbody}
  \let\@listi\@listI}
\normalsize

%%%%%%%%%%%%%%%% Indentations %%%%%%%%%%%%%%%%

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

%\marginparmargin{outer}
\sideparmargin{left}

% This will also typeout values in pt (default)
\checkandfixthelayout
% It is useful to see layout values in mm too.
\settypeoutlayoutunit{mm}
\typeoutlayout

\renewcommand\sideparfont{\instrFmt}

\renewcommand*\sideparform{%
  \vspace*{-7.2pt}%
  \ifmemtortm\raggedright\else\raggedleft\fi
}

% Math sizes for superscript sizes
\DeclareMathSizes{12.5}{12.5}{7}{7}

%%%%%%%%%%%%%%%% Packages To Be Loaded LAST %%%%%%%%%%%%%%%%

% NOTE use the 'bottom' footmisc option when using \raggedbottom.

\RequirePackage[perpage,symbol*,bottom,norule,multiple]{footmisc}

% NOTE if you have a quote margin, the \footnotemargin can be set equal to that
% in your local.sty
\setlength{\footnotemargin}{2em}

\renewcommand{\footnotelayout}{\hangpara{\footnotemargin}{1}}

% Asterisks for the first three footnotes, then numbers produced by the
% 'symbol*' option.
\DefineFNsymbols{anecdote}{*{**}{***}}
\setfnsymbol{anecdote}

\makeatletter
 \newcommand{\linkdest}[1]{\Hy@raisedlink{\hypertarget{#1}{}}}
\makeatother
