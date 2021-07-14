\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{confpaper}[2019/03/07 Conference Paper LaTeX Class]
\def\@classname{confpaper}

\RequirePackage{xkeyval}

% TODO Reproducible Builds
% TODO Balancing

% Class Options
% =============

% Paper Format
% ------------
\def\confpaper@papersize{}
\DeclareOptionX{a4paper}{\def\confpaper@papersize{\CurrentOption}}
\DeclareOptionX{letterpaper}{\def\confpaper@papersize{\CurrentOption}}

\def\confpaper@columns{}
\DeclareOptionX{onecolumn}{\def\confpaper@columns{\CurrentOption}}
\DeclareOptionX{twocolumn}{\def\confpaper@columns{\CurrentOption}}

% General Settings
% ----------------
\define@boolkey{confpaper.cls}[confpaper@]{anonymous}[true]{}
\define@boolkey{confpaper.cls}[confpaper@]{comments}[true]{}
\define@boolkey{confpaper.cls}[confpaper@]{pagenumbers}[true]{}
\define@boolkey{confpaper.cls}[confpaper@]{savespace}[true]{}

\DeclareOptionX{submission}{%
  \presetkeys{confpaper.cls}{anonymous=true,
                             comments=false,
                             pagenumbers=true}{}}
\DeclareOptionX{camera-ready}{%
  \presetkeys{confpaper.cls}{anonymous=false,
                             commetns=false,
                             pagenumbers=false}{}}
\DeclareOptionX{final}{%
  \setkeys{confpaper.cls}{comments=false}}

% Font
% ----
\define@choicekey*+{confpaper.cls}{rmfont}
  [\confpaper@rmfont\confpaper@rmfont@nr]{times,cmr,libertine}{}{%
    \ClassError{\@classname}{The rmfont option must be Times, CMR, or Libertine (not \CurrentOption).}}

\define@choicekey*+{confpaper.cls}{sffont}
  [\confpaper@sffont\confpaper@sffont@nr]{helvetica,libertine}{}{%
    \ClassError{\@classname}{The sffont option must be Helvetica.}}

\define@choicekey*+{confpaper.cls}{ttfont}
  [\confpaper@ttfont\confpaper@ttfont@nr]{nimbus,inconsolata}{}{%
    \ClassError{\@classname}{The ttfont option must be Inconsolata, or Nimbus.}}

% Font Size
% ---------
\def\confpaper@fontsize{}
\DeclareOptionX{9pt}{\def\confpaper@fontsize{\CurrentOption}}
\DeclareOptionX{10pt}{\def\confpaper@fontsize{\CurrentOption}}
\DeclareOptionX{11pt}{\def\confpaper@fontsize{\CurrentOption}}
\DeclareOptionX{12pt}{\def\confpaper@fontsize{\CurrentOption}}

% Conferences
% -----------
% Not all settings can be changed here.
\define@choicekey*+{confpaper.cls}{conference}
  [\confpaper@conference\confpaper@conference@nr]
  {acm,ieee,imc,usenix}{%
    \ifcase\confpaper@conference@nr\relax
      \ClassInfo{\@classname}{Conference format is ACM.}
      \presetkeys{confpaper.cls}{rmfont=libertine,
                                 sffont=libertine,
                                 ttfont=inconsolata}{}
      % TODO geometry
    \or
      \ClassInfo{\@classname}{Conference format is IEEE.}
      \presetkeys{confpaper.cls}{rmfont=times,
                                 sffont=helvetica,
                                 ttfont=inconsolata}{}
      % TODO geometry
    \or
      \ClassInfo{\@classname}{Conference format is IMC.}
      % via IMC 2019 website:
      % - Full papers: up to 13 pages for technical content (including
      %   appendices) + unlimited pages for references
      % - Short papers: up to 6 pages for technical content (including
      %   appendices) + unlimited pages for references
      % - 10-point font for main text; font used in other places (e.g.,
      %   figures) should be no smaller than 9 point
      % - two-column format, with the size of each column being at most 3.33 x
      %   9.25 inches and the space between columns being at least 0.33 inches
      %   letter page size (8.5 x 11 inches)
      % - include names and affiliations of all authors on the title page (no
      %   anonymization)
      \presetkeys{confpaper.cls}{rmfont=libertine,
                                 sffont=helvetica,
                                 ttfont=inconsolata,
                                 anonymous=false}{}
      \def\confpaper@columns{twocolumn}
      \def\confpaper@fontsize{10pt}
      \def\confpaper@papersize{letterpaper}
    \or
      \ClassInfo{\@classname}{Conference format is USENIX.}
      \presetkeys{confpaper.cls}{rmfont=times,
                                 sffont=helvetica,
                                 ttfont=nimbus}{}
      \def\confpaper@columns{twocolumn}
      \def\confpaper@fontsize{10pt}
      \def\confpaper@papersize{letterpaper}
    \fi
  }{%
    \ClassError{\@classname}{The conference option must be ACM, IMC, IEEE, or USENIX.}}

% TODO: ACM License Modes

% Processing
% ----------
% We need to process options in a specific order because they can overwrite
% each other. For example, we want submission/camera-ready to be processed
% first, which then gets overwritten by conference, and then we process all
% the options individually.
\ProcessOptionsX<confpaper.cls>[rmfont,ttfont,sffont,anonymous,comments,pagenumbers,savespace,conference]
\ProcessOptionsX<confpaper.cls>[rmfont,ttfont,sffont,anonymous,comments,pagenumbers,savespace]
\ProcessOptionsX<confpaper.cls>
\LoadClass[\confpaper@papersize,
           \confpaper@columns,
           \confpaper@fontsize]{extarticle}


% via amsart
% ==========
\newcommand{\xandlist}[4]{\@andlista{{#1}{#2}{#3}}#4\and\and}
\def\@andlista#1#2\and#3\and{\@andlistc{#2}\@ifnotempty{#3}{%
  \@andlistb#1{#3}}}
\def\@andlistb#1#2#3#4#5\and{%
  \@ifempty{#5}{%
    \@andlistc{#2#4}%
  }{%
    \@andlistc{#1#4}\@andlistb{#1}{#3}{#3}{#5}%
  }}
\let\@andlistc\@iden
\newcommand{\nxandlist}[4]{%
  \def\@andlistc##1{\toks@\@xp{\the\toks@##1}}%
  \toks@{\toks@\@emptytoks \@andlista{{#1}{#2}{#3}}}%
  \the\@xp\toks@#4\and\and
  \edef#4{\the\toks@}%
  \let\@andlistc\@iden}

\def\@@and{and}
\def\confpaper@andify{\nxandlist{\unskip, }{\unskip{} \@@and~}{\unskip, \@@and~}}
\def\confpaper@andifycomma{\nxandlist{\unskip, }{\unskip, }{\unskip, }}
\def\and{\unskip{ }\@@and{ }\ignorespaces}

% Custom Commands
% ===============
\newenvironment{acknowledgements}{\section*{Acknowledgements}}{}
\def\submission#1{\def\confpaper@submission{#1}}
\renewcommand\abstract[1]{\def\confpaper@abstract{#1}}
\def\subtitle#1{\def\confpaper@subtitle{#1}}
\def\confpaper@subtitle{}

\gdef\confpaper@authors{}
\newcount\confpaper@authors@nr
\confpaper@authors@nr=0\relax
\def\author#1{
  \global\advance\confpaper@authors@nr by 1\relax
  \ifx\confpaper@authors\@empty
    \gdef\confpaper@authors{#1}%
  \else
    \g@addto@macro\confpaper@authors{\and#1}
  \fi
}

\gdef\confpaper@emails{}
\newcount\confpaper@emails@nr
\confpaper@emails@nr=0\relax
\def\email#1{
  \global\advance\confpaper@emails@nr by 1\relax
  \ifx\confpaper@emails\@empty
    \gdef\confpaper@emails{#1}%
  \else
    \g@addto@macro\confpaper@emails{\and#1}
  \fi
}

\gdef\confpaper@affiliations{}
\newcount\confpaper@affiliations@nr
\confpaper@affiliations@nr=0\relax
\def\affiliation#1{
  \global\advance\confpaper@affiliations@nr by 1\relax
  \ifx\confpaper@affiliations\@empty
    \ifcase\confpaper@conference@nr\relax
        % ACM
        \gdef\confpaper@affiliations{\par #1}%
        \global\let\and\confpaper@acm@typeset@author@bx%
      \or
        \gdef\confpaper@affiliations{#1}%
      \or
        % IMC
        \gdef\confpaper@affiliations{\par#1}%
        \global\let\and\confpaper@acm@typeset@author@bx%
      \or
        \gdef\confpaper@affiliations{#1}%
    \fi
  \else
    \ifcase\confpaper@conference@nr\relax
        % ACM
        \g@addto@macro\confpaper@affiliations{\par#1}
        \global\let\and\confpaper@acm@typeset@author@bx%
      \or
        \g@addto@macro\confpaper@affiliations{\and#1}
      \or
        % IMC
        \g@addto@macro\confpaper@affiliations{\par#1}
        \global\let\and\confpaper@acm@typeset@author@bx%
      \or
        \g@addto@macro\confpaper@affiliations{\and#1}
    \fi
  \fi
}

%\authornote{Both authors contributed equally to this research.}
%\authornotemark[1]
%\affiliation{%
%  \institution{Institute for Clarity in Documentation}
%  \streetaddress{P.O. Box 1212}
%  \city{Dublin}
%  \state{Ohio}
%  \postcode{43017-6221}
%}


% General Formatting
% ==================
\RequirePackage{ifxetex}
\RequirePackage{balance}


% Fonts
% -----
\ifxetex
  \RequirePackage{csquotes}
  \RequirePackage{polyglossia}
  \setdefaultlanguage{english}
  \RequirePackage{fontspec}
  \RequirePackage{xunicode}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[english]{babel}
\fi

\RequirePackage{textcomp}
\RequirePackage{soul}
\RequirePackage{microtype}

% URLs
% ----
\RequirePackage[hyphens]{url}

% Bibliography
% ------------
\RequirePackage[sorting=anyt,%
                maxbibnames=99,%
                citestyle=numeric-comp,%
                natbib=true,%
                backend=biber,
                mincrossrefs=1000]{biblatex}
\setcounter{biburlnumpenalty}{9000}
\setcounter{biburlucpenalty}{9000}
\setcounter{biburllcpenalty}{9000}

\ifconfpaper@savespace
  % You might want to redefine
  \AtEveryBibitem{% Clean up the bibliography rather than editing it
    \clearfield{pages}
    \clearfield{eprint}
    \ifentrytype{book}{}{
      \ifentrytype{inbook}{}{% Remove publisher, editor, ISBN and ISSN except for books
        \clearlist{publisher}
        \clearname{editor}
        \clearfield{isbn}
        \clearfield{issn}
    }}
    \ifentrytype{inproceedings}{
      \clearfield{series}
      \clearfield{volume}
      \clearfield{edition}
    }{}
    \clearlist{location}
    \clearlist{address}
  }
\fi

% Captions
% --------
\RequirePackage{subcaption}

% Colors
% ------
\RequirePackage{color}
\RequirePackage[table]{xcolor}
\definecolor{lightgray}{gray}{0.95}

% Comments
% --------
\newcommand{\comment}[2]{%
  \ifconfpaper@comments
    \textcolor{#1}{#2}
  \fi}
\newcommand{\xxx}[1]{\comment{red}{#1}}
\newcommand{\todo}[1]{\comment{red}{\bf #1}}

% Figures
% -------
\RequirePackage{graphicx}
\graphicspath{{figures/}{./}}
\RequirePackage{tikz}
\usetikzlibrary{arrows}

% Headers and Footers
% -------------------
\RequirePackage{fancyhdr}

\ifconfpaper@pagenumbers
  \pagestyle{plain}
\else
  \pagestyle{empty}
\fi

% Listings
% --------
\RequirePackage{listings}

% Lists
% -----
\RequirePackage[inline]{enumitem}

% Math-mode
% ---------
\RequirePackage{amsthm}
\RequirePackage{amssymb}

% Misceallenous
% -------------
\RequirePackage{xspace}
\def\input@path{{sections/}{./}}

% Penalties
% ---------
% Allow break in URLs
\renewcommand{\UrlNoBreaks}{}
\renewcommand{\UrlBigBreaks}{\do\/\do\-\do\r\do\i}
\mathchardef\UrlBreakPenalty=0
\mathchardef\UrlBigBreakPenalty=0

% Orphans and Widows
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

% Split footnotes
\interfootnotelinepenalty=10000

% PDF Setup
% ---------
\RequirePackage[breaklinks=true,
                filecolor=black,
                citecolor=black,
                urlcolor=black,
                linkcolor=black,
                colorlinks,
                pdfpagelabels,
                pdfpagelayout=SinglePage]{hyperref}
\ifconfpaper@anonymous\else
  \hypersetup{%
    pdfcreator = {LaTeX with confpaper.cls \csname ver@confpaper.cls\endcsname\space and hyperref \csname ver@hyperref.sty\endcsname},
    pdfauthor = {\confpaper@authors},
    pdftitle = {\@title},
    bookmarksopen = {true}}
\fi
% pdfsubject  = {\@concepts},
% pdfkeywords = {\@keywords},

% References
% ----------
\RequirePackage[plain]{fancyref}

% Sections
% --------
\RequirePackage{titlesec} % Options and style occurs per conference

% Symbols
% -------
\RequirePackage{pifont}
\newcommand{\cmark}{\ding{51}}
\newcommand{\xmark}{\ding{55}}

% Tables
% ------
\RequirePackage{tabularx}
\RequirePackage{tabulary}
\RequirePackage{booktabs}
\RequirePackage{colortbl}
\RequirePackage{multirow}


% Fonts
% =====
\ifcase\confpaper@rmfont@nr\relax
  \RequirePackage{tgtermes}
  \RequirePackage{newtxmath}
\or
  \RequirePackage{lmodern}
\or
  \ifxetex
    \RequirePackage[tt=false]{libertine}
  \else
    \RequirePackage[tt=false, type1=true]{libertine}
  \fi
  %\RequirePackage[libertine]{newtxmath}
\fi

\ifcase\confpaper@sffont@nr\relax
  \RequirePackage[scaled=0.92]{helvet}
\or
  % Libertine?
\fi

\ifcase\confpaper@ttfont@nr\relax
  \ifxetex
    \setmonofont[Scale=0.85]{zcoN}
  \else
    \RequirePackage{nimbusmononarrow}
  \fi
\or
  \ifxetex
    \setmonofont[Scale=0.9]{inconsolata}
  \else
    \RequirePackage[scaled=0.9,varqu]{zi4}
  \fi
\fi

% Conferences
% ===========

% also used by IMC
\def\confpaper@acm@copyrightowner{%
  \ifcase\confpaper@acm@copyrightmode\relax % none
  \or % acmlicensed
  Copyright held by the owner/author(s). Publication rights licensed to
  ACM\@.
  \or % rightsretained
  Copyright held by the owner/author(s).
  \or % usgov
  \or % cagov
  Crown in Right of Canada.
  \or %licensedusgovmixed
  Copyright held by the owner/author(s). Publication rights licensed to
  ACM\@.
  \or % licensedcagov
  Crown in Right of Canada. Publication rights licensed to
  ACM\@.
  \or %licensedcagovmixed
  Copyright held by the owner/author(s). Publication rights licensed to
  ACM\@.
  \or % licensedothergov
  Copyright held by the owner/author(s). Publication rights licensed to
  ACM\@.
  \or % ic2w3www
  IW3C2 (International World Wide Web Conference Committee), published
  under Creative Commons CC-BY~4.0 License.
  \or % ic2w3wwwgoogle
  IW3C2 (International World Wide Web Conference Committee), published
  under Creative Commons CC-BY-NC-ND~4.0 License.
  \fi}

\def\confpaper@acm@copyrightpermission{%
  \ifcase\confpaper@acm@copyrightmode\relax % none
  \or % acmlicensed
   Permission to make digital or hard copies of all or part of this
   work for personal or classroom use is granted without fee provided
   that copies are not made or distributed for profit or commercial
   advantage and that copies bear this notice and the full citation on
   the first page. Copyrights for components of this work owned by
   others than the author(s) must be honored. Abstracting with credit
   is permitted.  To copy otherwise, or republish, to post on servers
   or to  redistribute to lists, requires prior specific permission
   and\hspace*{.5pt}/or  a fee. Request permissions from
   permissions@acm.org.
  \or % rightsretained
   Permission to make digital or hard copies of part or all of this work
   for personal or classroom use is granted without fee provided that
   copies are not made or distributed for profit or commercial advantage
   and that copies bear this notice and the full citation on the first
   page. Copyrights for third-party components of this work must be
   honored. For all other uses, contact the
   owner\hspace*{.5pt}/author(s).
  \or % usgov
   This paper is authored by an employee(s) of the United States
   Government and is in the public domain. Non-exclusive copying or
   redistribution is allowed, provided that the article citation is
   given and the authors and agency are clearly identified as its
   source.
  \or % cagov
   This article was authored by employees of the Government of Canada.
   As such, the Canadian government retains all interest in the
   copyright to this work and grants to ACM a nonexclusive,
   royalty-free right to publish or reproduce this article, or to allow
   others to do so, provided that clear attribution is given both to
   the authors and the Canadian government agency employing them.
   Permission to make digital or hard copies for personal or classroom
   use is granted. Copies must bear this notice and the full citation
   on the first page.  Copyrights for components of this work owned by
   others than the Canadian Government must be honored. To copy
   otherwise, distribute, republish, or post, requires prior specific
   permission and\hspace*{.5pt}/or a fee. Request permissions from
   permissions@acm.org.
  \or % licensedusgovmixed
   Publication rights licensed to ACM\@. ACM acknowledges that this
   contribution was authored or co-authored by an employee, contractor
   or affiliate of the United States government. As such, the
   Government retains a nonexclusive, royalty-free right to publish or
   reproduce this article, or to allow others to do so, for Government
   purposes only.
  \or % licensedcagov
   This article was authored by employees of the Government of Canada.
   As such, the Canadian government retains all interest in the
   copyright to this work and grants to ACM a nonexclusive,
   royalty-free right to publish or reproduce this article, or to allow
   others to do so, provided that clear attribution is given both to
   the authors and the Canadian government agency employing them.
   Permission to make digital or hard copies for personal or classroom
   use is granted. Copies must bear this notice and the full citation
   on the first page.  Copyrights for components of this work owned by
   others than the Canadian Government must be honored. To copy
   otherwise, distribute, republish, or post, requires prior specific
   permission and\hspace*{.5pt}/or a fee. Request permissions from
   permissions@acm.org.
  \or % licensedcagovmixed
   Publication rights licensed to ACM\@. ACM acknowledges that this
   contribution was authored or co-authored by an employee, contractor
   or affiliate of the national government of Canada. As such, the
   Government retains a nonexclusive, royalty-free right to publish or
   reproduce this article, or to allow others to do so, for Government
   purposes only.
  \or % licensedothergov
   Publication rights licensed to ACM\@. ACM acknowledges that this
   contribution was authored or co-authored by an employee, contractor
   or affiliate of a national government. As such, the Government
   retains a nonexclusive, royalty-free right to publish or reproduce
   this article, or to allow others to do so, for Government purposes
   only.
 \or % iw3c2w3
   This paper is published under the Creative Commons Attribution~4.0
   International (CC-BY~4.0) license. Authors reserve their rights to
   disseminate the work on their personal and corporate Web sites with
   the appropriate attribution.
 \or % iw3c2w3g
   This paper is published under the Creative Commons
   Attribution-NonCommercial-NoDerivs~4.0 International
   (CC-BY-NC-ND~4.0) license. Authors reserve their rights to
   disseminate the work on their personal and corporate Web sites with
   the appropriate attribution.
 \fi}

\def\confpaper@acm@typeset@author@bx{\bgroup\hsize=\author@bx@wd\def\and{\par}%
    \global\setbox\author@bx=\vtop{\centering
      \@authorfont\@currentauthors\par
      \@affiliationfont\@currentaffiliation}\egroup
    \box\author@bx\hspace{\author@bx@sep}%
    \gdef\@currentauthors{}%
    \gdef\@currentaffiliation{}}

\def\confpaper@acm@maketitle{%
  % This is a stripped down version from the new ACM template:
  % - We do not support journals.
  % - We do not support assigning the copyright to ACM.
  \begingroup
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \hsize=\textwidth
  \def\@makefnmark{\hbox{\@textsuperscript{\@thefnmark}}}%

  \newbox\mktitle@bx
  \hsize=\textwidth
  \setbox\mktitle@bx=\vbox{%
    % Badge support removed
    \parbox[t]{\hsize}{\huge\sffamily\bfseries\centering
      \@title
      \ifx\confpaper@subtitle\@empty\else
        \par\noindent{\LARGE\mdseries\confpaper@subtitle}
      \fi%
    \vskip.5\baselineskip
    \large\mdseries\centering
      \ifx\confpaper@authors\@empty\else
        \par\noindent{\confpaper@authors}
      \fi
      \ifx\confpaper@affiliations\@empty\else
        \vskip.25\baselineskip
        \par\noindent{\confpaper@affiliations}
      \fi
      \ifx\confpaper@emails\@empty\else
        \vskip.25\baselineskip
        \par\noindent{\tt\confpaper@emails}
      \fi
    }%
    \par\smallskip}

  \newcount\@ACM@authorsperrow
  \@ACM@authorsperrow=0\relax
  \newbox\author@bx
  \newdimen\author@bx@wd
  \newskip\author@bx@sep
  \author@bx@sep=1pc\relax
  \def\@authorfont{\LARGE}
  \def\@affiliationfont{\large}
    \author@bx@wd=\textwidth\relax
  \advance\author@bx@wd by -\author@bx@sep\relax
  \ifnum\@ACM@authorsperrow>0\relax
    \divide\author@bx@wd by \@ACM@authorsperrow\relax
  \else
    \ifcase\confpaper@authors@nr
    \relax % 0?
    \or  % 1=one author per row
    \or  % 2=two authors per row
        \divide\author@bx@wd by \confpaper@authors@nr\relax
    \or  % 3=three authors per row
        \divide\author@bx@wd by \confpaper@authors@nr\relax
    \or  % 4=two authors per row (!)
        \divide\author@bx@wd by 2\relax
    \else % three authors per row
        \divide\author@bx@wd by 3\relax
    \fi
  \fi
  \advance\author@bx@wd by -\author@bx@sep\relax

  \gdef\@currentauthors{}%
  \gdef\@currentaffiliation{}%
  \def\@author##1{\ifx\@currentauthors\@empty
    \gdef\@currentauthors{\par##1}%
  \else
    \g@addto@macro\@currentauthors{\par##1}%
  \fi
  \gdef\and{}}%
  \def\email##1{\ifx\@currentaffiliation\@empty
    \gdef\@currentaffiliation{\bgroup
      \mathchardef\UrlBreakPenalty=10000\nolinkurl{##1}\egroup}%
  \else
    \g@addto@macro\@currentaffiliation{\par\bgroup
      \mathchardef\UrlBreakPenalty=10000\nolinkurl{##1}\egroup}%
  \fi}%
  \def\affiliation##1{\ifx\@currentaffiliation\@empty
      \gdef\@currentaffiliation{##1}%
    \else
      \g@addto@macro\@currentaffiliation{\par##1}
    \fi
  \global\let\and\@typeset@author@bx}%
  % iterate over list here

  \hsize=\textwidth
  \global\setbox\mktitle@bx=\vbox{\noindent
    \box\mktitle@bx\par\medskip\leavevmode
    \lineskip=1pc\relax\centering\hspace*{-1em}%
    \let\and\confpaper@acm@typeset@author@bx\and\par\bigskip}

  \twocolumn[\box\mktitle@bx]%

  %\@printtopmatter
  %\setcounter{footnote}{0}%
  %\def\@makefnmark{\hbox{\@textsuperscript{\normalfont\@thefnmark}}}%
  %\@titlenotes
  %\@subtitlenotes
  %\@authornotes
  %\let\@makefnmark\relax
  %\let\@thefnmark\relax
  %\let\@makefntext\noindent
  %\ifx\@empty\thankses\else
  %  \footnotetextauthorsaddresses{%
  %    \def\par{\let\par\@par}\parindent\z@\@setthanks}%
  %\fi
  %\footnotetextcopyrightpermission{%
  %  \ifconfpaper@draft
  %      \raisebox{-2ex}[\z@][\z@]{\makebox[0pt][l]{\large\bfseries Unpublished working draft. Not for distribution.}}%
  %     \color[gray]{0.9}%
  %  \fi
  %  \parindent\z@\parskip0.1\baselineskip
  %  \if@ACM@authorversion\else
  %    \if@printpermission\@copyrightpermission\par\fi
  %  \fi
  %  \ifconfpaper@printcopyright
  %    \copyright\ \confpaper@acm@copyrightyear\ \confpaper@acm@copyrightowner\\
  %  \else
  %    \@copyrightyear.\
  %  \fi
  %  \ifx\@acmISBN\@empty\else ACM~ISBN~\@acmISBN
  %  \ifx\@acmPrice\@empty.\else\dots\$\@acmPrice\fi\\\fi
  %  \ifx\@acmDOI\@empty\else\@formatdoi{\@acmDOI}\fi%}
  \endgroup
  %\setcounter{footnote}{0}%
  \begingroup
    \section*{Abstract}
    \confpaper@abstract
  \endgroup
  %\if@ACM@printccs
  %  \ifx\@concepts\@empty\else\bgroup
  %    {\@specialsection{CCS Concepts}%
  %       \@concepts\par}\egroup
  %   \fi
  % \fi
  % \ifx\@keywords\@empty\else\bgroup
  %    {\if@ACM@journal
  %       \@specialsection{Additional Key Words and Phrases}%
  %     \else
  %       \@specialsection{Keywords}%
  %     \fi
  %       \@keywords}\par\egroup
  % \fi
  %\confpaper@andify\confpaper@authors
  %\andify\shortauthors
  %\global\let\authors=\authors
  %\global\let\shortauthors=\shortauthors
  %\if@ACM@printacmref
  %   \@mkbibcitation
  %\fi
  %\global\@topnum\z@ % this prevents floats from falling
  %                   % at the top of page 1
  %\global\@botnum\z@ % we do not want them to be on the bottom either
  \par\bigskip
  \@afterindentfalse
  \@afterheading
}

\ifcase\confpaper@conference@nr\relax
  % ACM
  % ---
   \RequirePackage[twoside=true,
                   head=13pt,
                   paperwidth=8.5in,
                   paperheight=11in,
                   includeheadfoot,
                   columnsep=2pc,
                   top=57pt,
                   bottom=73pt,
                   inner=54pt,
                   outer=54pt,
                   marginparwidth=2pc,
                   heightrounded]{geometry}
  \def\maketitle{\confpaper@acm@maketitle}

  % TODO acknowledgements
  % TODO section headers
\or
  % IEEE
  % ----
  % TODO title
  % TODO abstract
  % TODO acknowledgements
  % TODO section headers
\or
  % IMC
  % ---
  \RequirePackage[top=0.875in,
                  bottom=0.875in,
                  left=0.75in,
                  right=0.75in,
                  columnsep=0.33in]{geometry}
  \def\maketitle{\confpaper@acm@maketitle}
\or
  % USENIX
  % ------
  \RequirePackage[top=1in,
                  bottom=1in,
                  left=0.75in,
                  right=0.75in,
                  columnsep=0.33in]{geometry}

  % Titlepage
  % ~~~~~~~~~
  \def\maketitle{\par
    \begingroup
      \renewcommand\thefootnote{\fnsymbol{footnote}}%
      \def\@makefnmark{\hbox to\z@{$\m@th^{\@thefnmark}$\hss}}%
        \long\def\@makefntext##1{\parindent 1em\noindent
        \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}##1}%
      \if@twocolumn
        \twocolumn[\@maketitle]%
        \else \newpage
        \global\@topnum\z@
        \@maketitle \fi\@thanks
    \endgroup
    \begin{center}%
      {\large\bf \abstractname\vspace{-.5em}\vspace{\z@}}%
    \end{center}
    \confpaper@abstract
    \setcounter{footnote}{0}%
    \let\maketitle\relax
    \let\@maketitle\relax
    \let\confpaper@abstract\relax
    \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\thanks\relax}

  \def\@maketitle{\newpage
   \ifconfpaper@savespace
     \vbox to 1.5in
   \else
     \vbox to 2.5in
   \fi{
   \vspace*{\fill}
   \vskip 2em
   \begin{center}%
    {\Large\bf \@title \par}%
    \vskip 0.375in minus 0.300in
    {\large
     \lineskip .5em
     \begin{tabular}[t]{c}%
      \ifconfpaper@anonymous
        Submission \#\confpaper@submission
      \else
        \confpaper@andifycomma\confpaper@authors\confpaper@authors\\
        {\it\confpaper@andifycomma\confpaper@affiliations\confpaper@affiliations}\\
        {\tt\confpaper@andifycomma\confpaper@emails\confpaper@emails}
      \fi
     \end{tabular}\par}%
   \end{center}%
   \par
   \vspace*{\fill}
  % \vskip 1.5em
   }
  }

  % Captions
  % ~~~~~~~~
  \RequirePackage[font=small,format=plain,labelfont=bf,textfont=it]{caption}

  % Section Headers
  % ~~~~~~~~~~~~~~~
  \def\section{\@startsection {section}{1}{\z@}{-3.5ex plus-1ex minus
    -.2ex}{2.3ex plus.2ex}{\reset@font\large\bf}}
\fi

\endinput

%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  %%%
%  %%%  To appear/appeared in text on title page
%  %%%
%  \RequirePackage[absolute]{textpos}
%  \newcommand{\ToAppear}{%
%  \begin{textblock*}{\textwidth}(0.95in,0.4in)
%  \begin{flushright}
%      %\noindent{\fbox{\textsf{Under submission---please do not redistribute.}}}
%      %  --OR--
%      \noindent{\small To appear in \textit{Proceedings of the XYZ}\\
%      \noindent{\small \textit{Conference (XYZ'08)}, City, State, Month 2008}}
%      %  --OR--
%      %\noindent{\small In \textit{Proceedings of the XYZ}\\
%      %\noindent{\small \textit{Conference (XYZ'08)}, City, State, Month 2008}}
%  \end{flushright}
%  \end{textblock*}
%  }
%
%  %%%
%  %%%  Sample ACM Copyright Block
%  %%%
%  \floatstyle{plain}
%  \newfloat{acmcr}{b}{acmcr}
%  \newcommand{\AcmCopyright}{%
%  \begin{acmcr}
%  \parbox[b]{20pc}{%
%  \footnotesize
%  Permission to make digital or hard copies of all or part of this work
%  for personal or classroom use is granted without fee provided that
%  copies are not made or distributed for profit or commercial advantage
%  and that copies bear this notice and the full citation on the first
%  page.  To copy otherwise, to republish, to post on servers or to
%  redistribute to lists, requires prior specific permission and/or a fee.
%
%  {\em Conference}, Month Date--Date, Year, Location\\
%  Copyright 200X ACM X-XXXXX-XX-X/XX/XX ...\$5.00}
%  \end{acmcr}}
%
%  %%%
%  %%%  Theorems
%  %%%
%  \newtheoremstyle{tighter}
%      {3pt}        % Space above
%      {3pt}        % Space below
%      {\em}        % Body font
%      {}           % Indentation
%      {\bfseries}  % Head font
%      {:}          % Head punctuation
%      {.5em}       % Head space
%      {}           % Custom head spec
%  \theoremstyle{tighter}
%  \newtheorem{lesson}{Lesson}
%  \newtheorem{constraint}{Constraint}
%  %\newcommand{\lesson}[1]{\vspace{1em}{\centering\fbox{\parbox{0.95\columnwidth}{\centering\bf Lesson: #1}}}\vspace{1em}}
