% Intro Options
\ProvidesClass{deedy-resume-openfont}[2014/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% Package Imports
\usepackage[hmargin=2.3cm, vmargin=2.3cm]{geometry}
\usepackage[hidelinks]{hyperref}
\usepackage[usenames,dvipsnames]{xcolor}
\usepackage{titlesec}
\usepackage[absolute]{textpos}
\usepackage{fontspec,xltxtra,xunicode}

% Publications
\usepackage{cite}
\renewcommand\refname{\vskip -1.5cm}

% Color definitions
\usepackage[usenames,dvipsnames]{xcolor} 
\definecolor{date}{HTML}{666666} 
\definecolor{primary}{HTML}{2b2b2b} 
\definecolor{headings}{HTML}{6A6A6A}
\definecolor{subheadings}{HTML}{333333}

% Set main fonts
% NOTE: The original template bundled Lato/Raleway OTF files (OpenFonts/fonts/)
% from an old webfont kit. Raleway (in that build AND in the current official
% release) is missing glyphs for Vietnamese tone-marked vowels (e.g. e with
% circumflex+grave, u with horn+dot below), which silently drops letters when
% writing Vietnamese-language cover letters. Lato's current release does cover
% Vietnamese, so it has been refreshed (see OpenFonts/fonts/lato/) and paired
% with Be Vietnam Pro (OpenFonts/fonts/bevietnampro/) as the body font in place
% of Raleway - Be Vietnam Pro is designed specifically for Vietnamese+Latin and
% has a similar geometric-sans feel. Both are bundled TTF files (not OS fonts),
% so this keeps the template portable across Windows/macOS/Linux/CI - unlike
% Times New Roman/Arial, which are Windows-only and would break the Linux CI
% container that compiles cover_example.tex.
\usepackage{fontspec}
\setmainfont[Color=primary, Path = OpenFonts/fonts/lato/, BoldFont=Lato-Bold, ItalicFont=Lato-Italic, BoldItalicFont=Lato-BoldItalic]{Lato-Regular}
\setsansfont[Scale=MatchLowercase,Mapping=tex-text, Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-Regular}

% Date command
\usepackage[absolute]{textpos}
% \usepackage[UKenglish]{isodate}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\newcommand{\lastupdated}{\begin{textblock}{60}(155,5)
\color{date}\fontspec[Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-ExtraLight}\fontsize{8pt}{10pt}\selectfont
Last Updated on \today
\end{textblock}}

% Name command
\newcommand{\namesection}[3]{
\centering{
\fontsize{40pt}{60pt}
\fontspec[Path = OpenFonts/fonts/lato/]{Lato-Bold}\selectfont #1
\fontspec[Path = OpenFonts/fonts/lato/]{Lato-Light}\selectfont #2
} \\[5pt]
\centering{
\color{headings}
\fontspec[Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-Medium}\fontsize{11pt}{14pt}\selectfont #3}
\noindent\makebox[\linewidth]{\color{headings}\rule{\paperwidth}{0.0pt}}
\vspace{0pt}
}

% Section seperators
\usepackage{titlesec}
\titlespacing{\section}{0pt}{0pt}{0pt}
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\newcommand{\sectionsep}{\vspace{8pt}}

% Headings command
\titleformat{\section}{\color{headings}
\scshape\fontspec[Path = OpenFonts/fonts/lato/]{Lato-Light}\fontsize{16pt}{24pt}\selectfont \raggedright\uppercase}{}{0em}{}

% Subeadings command
\titleformat{\subsection}{
\color{subheadings}\fontspec[Path = OpenFonts/fonts/lato/]{Lato-Bold}\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase}{}{0em}{}

\newcommand{\runsubsection}[1]{
\color{subheadings}\fontspec[Path = OpenFonts/fonts/lato/]{Lato-Bold}\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase {#1} \normalfont}

% Descriptors command
\newcommand{\descript}[1]{
\color{subheadings}\raggedright\scshape\fontspec[Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-Medium}\fontsize{11pt}{13pt}\selectfont {#1 \\} \normalfont}

% Location command
\newcommand{\location}[1]{
\color{headings}\raggedright\fontspec[Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-Medium}\fontsize{10pt}{12pt}\selectfont {#1\\} \normalfont}

% Bullet Lists with fewer gaps command
\newenvironment{tightemize}{
\vspace{-\topsep}\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt}
{\end{itemize}\vspace{-\topsep}}

% Cover Letter
\newcommand{\companyname}[1]{\raggedright\fontspec[Path = OpenFonts/fonts/lato/]{Lato-Bold}\fontsize{12pt}{14pt}\selectfont {#1 \\} \normalfont}

\newcommand{\companyaddress}[1]{\raggedright\fontspec[Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-Medium}\fontsize{11pt}{13pt}\selectfont {#1 \\}\mbox{}\\\mbox{}\\ \normalfont}

\newcommand{\currentdate}[1]{\raggedleft\fontspec[Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-Medium}\fontsize{11pt}{13pt}\selectfont {#1 \\} \normalfont}

% Letter content command
\newcommand{\lettercontent}[1]{\raggedright\fontspec[Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-Medium}\fontsize{11pt}{13pt}\selectfont {#1 \\}\mbox{}\\ \normalfont}

\newcommand{\closing}[1]{\raggedright\fontspec[Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-Medium}\fontsize{11pt}{13pt}\selectfont {#1 \\}\mbox{}\\\mbox{}\\ \normalfont}

\newcommand{\signature}[1]{\raggedright\fontspec[Path = OpenFonts/fonts/bevietnampro/]{BeVietnamPro-Medium}\fontsize{11pt}{13pt}\selectfont {#1 \\} \normalfont}