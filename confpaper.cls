\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{confpaper}[2014/6/17 conference paper latex class]

%%% Opitons
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}

%%% Process given options
\ProcessOptions\relax

%%%
%%%  Load base
%%%
\LoadClass[pdftex,letterpaper]{extarticle}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%
%%%  Custom variables to be set appropriately.
%%%
\newcommand{\AUTHORS}{Authors}
\newcommand{\TITLE}{Title}
\newcommand{\KEYWORDS}{Keywords}
\newcommand{\CONFERENCE}{Conference}
\newcommand{\PAGENUMBERS}{yes} % "yes" or "no"
\newcommand{\COLOR}{yes}
\newcommand{\showComments}{yes}
\newcommand{\comment}[1]{}
\newcommand{\onlyAbstract}{no}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%
%%%  ACM Fonts.
%%%
\newfont{\secfnt}{ptmb8t at 12pt}
\newfont{\secit}{ptmbi8t at 12pt}     %13 Jan 00 gkmt
\newfont{\subsecfnt}{ptmri8t at 11pt}
\newfont{\subsecit}{ptmbi8t at 11pt}  % 
\newfont{\ttlfnt}{phvb8t at 18pt}
\newfont{\ttlit}{phvbo8t at 18pt}     % GM 2/4/2000
\newfont{\subttlfnt}{phvr8t at 14pt}
\newfont{\subttlit}{phvro8t at 14pt}  % GM 2/4/2000
\newfont{\subttlbf}{phvb8t at 14pt}   % 13 Jan 00 gkmt
\newfont{\aufnt}{phvr8t at 12pt}
\newfont{\auit}{phvro8t at 12pt}      % GM 2/4/2000
\newfont{\affaddr}{phvr8t at 10pt}
\newfont{\affaddrit}{phvro8t at 10pt} % GM 2/4/2000
\newfont{\eaddfnt}{phvr8t at 12pt}
\newfont{\ixpt}{ptmr8t at 9pt}
\newfont{\confname}{ptmri8t at 8pt}
\newfont{\crnotice}{ptmr8t at 8pt}
\newfont{\ninept}{ptmr8t at 9pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% IEEE Formatting - Uncomment to get IEEE-Style Section headings
%%%

%
% \renewcommand{\thesection}{\Roman{section}} 
% \renewcommand{\thesubsection}{\thesection.\Alph{subsection}}
%
% \titleformat{\section}%                     % IEEE/ACM: caps + period
%   {\centering\sc}{\roman{section}.\quad}{0pt}{}
%
% \titleformat{\subsection}%                     % IEEE/ACM: caps + period
%   {\flushleft\it}{\Alph{subsection}.\quad}{0pt}{}
%
% \titleformat{\subsubsection}%                     % IEEE/ACM: caps + period
%   {\flushleft\it}{\Alph{subsection}.\arabic{subsubsection}.\quad}{0pt}{}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%
%%%  Page Setup
%%%
\RequirePackage{balance}
\RequirePackage{tabulary}
\RequirePackage{url}
\RequirePackage{ifthen}

\special{papersize=8.5in,11in}
\setlength{\pdfpagewidth}{8.5in}
\setlength{\pdfpageheight}{11in}

\ifthenelse{\equal{\PAGENUMBERS}{yes}}{%
\RequirePackage[nohead,
% SIGCOMM/ACM
    left=0.75in,right=0.75in,top=0.75in, bottom=1in,
    columnsep=0.33in
% USENIX
%    left=1.0in,right=1.0in,top=1.0in,
%    footskip=0.5in,bottom=1.0in,   % Room for page numbers
%    columnsep=0.25in
% IEEE
%            left=0.75in,right=0.75in,top=0.75in, bottom=1in,
%            columnsep=0.2in
% Custom
%    left=1.5in,right=1.5in,top=1.0in,
%    footskip=0.5in,bottom=1.0in,   % Room for page numbers
%    columnsep=0.25in
  ]{geometry}
}{%
\RequirePackage[noheadfoot,left=0.75in,right=0.75in,top=0.75in,
    footskip=0.5in,bottom=1in,
    columnsep=0.33in
  ]{geometry}
}

%%%
%%%  Renew "itemize" environment
%%%
\renewenvironment{itemize}
{\begin{list}{$\bullet$}{
    \setlength{\labelsep}{4pt}
    \setlength{\labelwidth}{3pt}
    \setlength{\rightmargin}{0pt}
    \setlength{\leftmargin}{0pt}
    \addtolength{\leftmargin}{\labelwidth}
    \addtolength{\leftmargin}{\labelsep}
}}{\end{list}}

%%%
%%%  Captions
%%%
%\RequirePackage[font=bf]{caption}
\RequirePackage[font=small,format=plain,labelfont=bf,textfont=it]{caption}
\RequirePackage{subcaption}
%% Space between figure and caption (assuming caption
%% is below figure)
%\RequirePackage[font=bf,aboveskip=0pt]{caption} % SPACE
%% Space between caption and body text of document
\addtolength{\textfloatsep}{-7pt} % SPACE

%%%
%%%  Section headings
%%%
%\RequirePackage{titlesec}
%\titlespacing{\paragraph}{0pt}{*1}{*1} % SPACE
\RequirePackage[compact]{titlesec}  % SPACE
%\titleformat{\section}%  % IEEE/ACM: caps + period
% {\bf\large\uppercase}{\thesection.\quad}{0pt}{}
\titleformat{\section}{\bf\large}{\thesection}{8pt}{} % USENIX


%%%
%%%  Lists
%%%
\RequirePackage{paralist}
\RequirePackage{enumitem}
\setlist{itemsep=0pt,parsep=0pt}  % more compact lists

\renewcommand{\paragraph}[1]{\vspace*{0.03in}\noindent{\bf #1}}

%%%
%%%  Custom Environments
%%%
\RequirePackage{pifont}
\newcommand{\cmark}{\ding{51}}%
\newcommand{\xmark}{\ding{55}}%

%%%
%%%  Header / Footer
%%%
\RequirePackage{fancyhdr}
\renewcommand{\headrulewidth}{0pt}

\ifthenelse{\equal{\PAGENUMBERS}{yes}}{%
  \pagestyle{plain}
}{%
  \pagestyle{empty}
}

%%%
%%%  Bibliography
%%%
%\RequirePackage[numbers]{natbib}
\RequirePackage{cite}

%%%
%%%  Footnotes / Endnotes
%%%
\interfootnotelinepenalty=10000  % Split footnotes are annoying

%% If you want endnodes, uncomment:
%\RequirePackage{endnotes}
%\RequirePackage{drafthead}
%\let\footnote=\endnote

%%%
%%%  Tables
%%%
\RequirePackage{booktabs}
\RequirePackage{color}
\RequirePackage{colortbl}
\RequirePackage{float}  % Must appear before hyperref to
                        % avoid weird PDF compile issues

%%%
%%%  Fonts
%%%
\RequirePackage{mathptmx} % Times/Times-like math symbols
\RequirePackage{courier}
\RequirePackage[scaled=0.92]{helvet}

%%%
%%%  PDF setup
%%%
\RequirePackage[breaklinks=true,pagebackref,filecolor=black,citecolor=blue,urlcolor=black,linkcolor=blue,colorlinks,pdfpagelabels,pdfpagelayout=SinglePage]{hyperref}

\renewcommand*{\backref}[1]{}
\renewcommand*{\backrefalt}[4]{
  \ifcase #1 %
    (Not cited.) %
  \or
    {\small (Cited on page~#2.)}%
  \else
    {\small (Cited on pages~#2.)}%
  \fi
}
\renewcommand*{\backrefsep}{, }
\renewcommand*{\backreftwosep}{ and~}
\renewcommand*{\backreflastsep}{ and~}

\hypersetup{%
pdfauthor = {\AUTHORS},
pdfsubject = {\CONFERENCE},
pdfkeywords = {\KEYWORDS},
bookmarksopen = {true}
}

%%
%%  Figure placeholder macros
%%
\definecolor{placeholderbg}{rgb}{0.85,0.85,0.85}
\newcommand{\placeholder}[1]{%
\fcolorbox{black}{placeholderbg}{\parbox[top][1.5in][c]{0.95\columnwidth}{#1}}}

%%%
%%%  Misc
%%%
\RequirePackage[pdftex]{graphicx}
\RequirePackage{soul}
\RequirePackage{subcaption}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{listings}
\RequirePackage{tikz}
\usetikzlibrary{arrows}

%\setlength{\parindent}{0pt}
%\setlength{\parskip}{\baselineskip}

\clubpenalty=10000  % Don't allow orphans
\widowpenalty=10000 % Don't allow widows

%%%
%%%  To appear/appeared in text on title page
%%%
\RequirePackage[absolute]{textpos}
\newcommand{\ToAppear}{%
\begin{textblock*}{\textwidth}(0.95in,0.4in)
\begin{flushright}
    %\noindent{\fbox{\textsf{Under submission---please do not redistribute.}}}
    %  --OR--
    \noindent{\small To appear in \textit{Proceedings of the XYZ}\\
    \noindent{\small \textit{Conference (XYZ'08)}, City, State, Month 2008}}
    %  --OR--
    %\noindent{\small In \textit{Proceedings of the XYZ}\\
    %\noindent{\small \textit{Conference (XYZ'08)}, City, State, Month 2008}}
\end{flushright}
\end{textblock*}
}

%%%
%%%  Sample ACM Copyright Block
%%%
\newfloat{acmcr}{b}{acmcr}
\newcommand{\AcmCopyright}{%
\begin{acmcr}
\parbox[b]{20pc}{%
\footnotesize
Permission to make digital or hard copies of all or part of this work
for personal or classroom use is granted without fee provided that
copies are not made or distributed for profit or commercial advantage
and that copies bear this notice and the full citation on the first
page.  To copy otherwise, to republish, to post on servers or to
redistribute to lists, requires prior specific permission and/or a fee.

{\em Conference}, Month Date--Date, Year, Location\\
Copyright 200X ACM X-XXXXX-XX-X/XX/XX ...\$5.00}
\end{acmcr}}

%%%
%%%  Comments
%%%
\newcommand{\note}[2]{
    \ifthenelse{\equal{\showComments}{yes}}{\textcolor{#1}{#2}}{}
}

\newcommand{\xxx}[1]{\note{red}{#1}}
\newcommand{\todo}[1]{\note{red}{\bf #1}}

%%%
%%%  Abbreviations
%%%
\newcommand{\ie}{{\em i.e.}}
\newcommand{\eg}{{\em e.g.}}
\newcommand{\ea}{{\em et al.}}
\newcommand{\fp}{\vspace*{0.05in}\noindent}
\newcommand{\name}{NAME\xspace}

%%%
%%%  Theorems
%%%
\newtheoremstyle{tighter}
    {3pt}        % Space above
    {3pt}        % Space below
    {\em}        % Body font
    {}           % Indentation
    {\bfseries}  % Head font
    {:}          % Head punctuation
    {.5em}       % Head space
    {}           % Custom head spec
\theoremstyle{tighter}
\newtheorem{lesson}{Lesson}
\newtheorem{constraint}{Constraint}
%\newcommand{\lesson}[1]{\vspace{1em}{\centering\fbox{\parbox{0.95\columnwidth}{\centering\bf Lesson: #1}}}\vspace{1em}}

% This needs to be the last thing before \begin{document}
\RequirePackage{microtype}  % SPACE

%%%
%%% Additional Packages
%%%

\usepackage{multirow}
\usepackage{xspace}

\endinput
