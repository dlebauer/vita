% This example document class is based on the Typesetting your
% academic CV in LaTeX by Dario Taraborelli.  The original article
% is avaiable at http://nitens.org/taraborelli/cvtex
%
% Additional modifications made by Robert Oakes.  Copyright 2009.

% modifications by David LeBauer
\newcommand{\header}[1]{\marginpar{\hspace{6cm}\parbox{4.0cm}{\textbf{#1}}}} 
\newcommand{\mypub}{\hangindent=2em\hangafter=1}
% \doi{} creates link
\newcommand{\doi}[1]{\href{http://dx.doi.org/#1}{doi:#1}}


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{xetexCV}[2009/11/15 - Modern looking resume which
uses the xetex typesetting system.]

% Load the Base Class
\LoadClassWithOptions{article}

% Begin Requirements
\RequirePackage{ifthen}
\RequirePackage{fontspec}
\RequirePackage{xunicode}
\RequirePackage{xltxtra}

\RequirePackage{graphicx}
\RequirePackage[colorlinks]{hyperref}
\hypersetup{linkcolor=blue,citecolor=blue,filecolor=black,urlcolor=blue} 

% Fonts
\defaultfontfeatures{Mapping=tex-text}
\setromanfont [Ligatures={Common}, BoldFont={Fontin Bold}, ItalicFont={Fontin Italic}]{Fontin}
\setsansfont [Ligatures={Common}, BoldFont={Fontin Sans Bold}, ItalicFont={Fontin Sans Italic}]{Fontin Sans}

% Custom Document Formatting
\newcommand\decorativeline[1][1pt]{%
	\par\noindent%
	\rule[0.5ex]{\linewidth}{#1}\par}

\pagestyle{empty}
\hyphenpenalty=5000
\tolerance=1000

% CV and Contact Information
\def\@cvname{\relax}
\newcommand{\cvname}[1]{\gdef\@cvname{#1}}

\def\@cvimage{\relax}
\newcommand{\cvimage}[1]{\gdef\@cvimage{#1}}

\def\@institution{\relax}
\newcommand{\institution}[1]{\gdef\@institution{#1}}

\def\@contactaddress{\relax}
\newcommand{\contactaddress}[1]{\gdef\@contactaddress{#1}}

\def\@phonenumber{\relax}
\newcommand{\phonenumber}[1]{\gdef\@phonenumber{#1}}

\def\@faxnumber{\relax}
\newcommand{\faxnumber}[1]{\gdef\@faxnumber{#1}}

\def\@email{\relax}
\newcommand{\email}[1]{\gdef\@email{#1}}

\newcommand\@website{\relax}
\newcommand{\website}[1]{\gdef\@website{#1}}

% Set the Paper Size and Margins
\RequirePackage{geometry} 
\geometry{letterpaper, textwidth=5.5in, textheight=8.5in, marginparsep=1.0pt, marginparwidth=2.0in, margin=0.7in}
\setlength\parindent{0in}

% Spcial Commands for Fancy Characters and Years
\newcommand{\amper}{{\fontspec[Scale=.95]{Hoefler Text}\selectfont\itshape\&}}
\newcommand{\years}[1]{\marginpar{\hspace{5.13cm}\parbox{3.0cm}{\emph{#1}}}}
%DSL: \newcommand{\years}[1]{\marginpar{\hspace{6cm}\parbox{4.0cm}{\textit{#1}}}} 

% Headings and Heading Fonts
\RequirePackage[normalem]{ulem}
\renewcommand\section{\@startsection{section}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex \vspace{1mm}}%
	{0.5mm}%
	{\sffamily\large\bfseries}}

\renewcommand\subsection{\@startsection{subsection}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex}%
	{3.0mm}%
	{\sffamily\mdseries}}

\newcommand{\cvsection}[1]{\leftskip 0cm
	\section*{#1}\decorativeline\marginpar{\vspace{0.3ex}}
	\leftskip 116pt}

\newcommand{\cvsubsection}[1]{\leftskip 0cm \vspace{-0.2cm}
	\subsection*{\textbf{#1}}\vspace{1.0mm} \leftskip 116pt}
% Below version for a tighter cvsubsectionx
%\newcommand{\cvsubsection}[1]{\marginpar{\vspace{0.2cm}\hspace{5.13cm}\parbox{4.0cm}{\textbf{#1}}}\vspace{0.75cm}} 

\reversemarginpar

\newcommand\makecvtitle{
	\ifthenelse{\equal{\@cvimage}{\relax}}
	{ % Create Without Image
	\ifthenelse{\equal{\@cvname}{\relax}}{}
	{\textsf{\LARGE\bfseries \@cvname}\decorativeline\vspace{0.3cm}}
	\leftskip 116pt
	% Contact Information and Other Details
	\ifthenelse{\equal{\@institution}{\relax}}{}
		{\bfseries{\@institution}\\}
	\ifthenelse{\equal{\@contactaddress}{\relax}}{}
		{\mdseries \@contactaddress\\[0.2cm]}
	\ifthenelse{\equal{\@phonenumber}{\relax}}{}
		{Phone: \texttt{\@phonenumber}\\}
	\ifthenelse{\equal{\@faxnumber}{\relax}}{}
		{Fax: \texttt{\@faxnumber}\\[0.2cm]}
	\ifthenelse{\equal{\@email}{\relax}}{}
		{Email: \href{mailto:\@email}{\@email}\\}
	\ifthenelse{\equal{\@website}{\relax}}{}
		{Website: \href{\@website}{\@website}}}
	{% Create With Image
	\ifthenelse{\equal{\@cvname}{\relax}}{}
	{\textsf{\LARGE\bfseries \@cvname}\decorativeline\vspace{0.3cm}}
	\begin{minipage}{6in}
		\begin{minipage}{114pt}
			\resizebox*{100pt}{!}{\includegraphics{\@cvimage}}
		\end{minipage}
		\begin{minipage}{4in}
			\ifthenelse{\equal{\@institution}{\relax}}{}{\bfseries\@institution\\}
			\mdseries\@contactaddress\\[0.2cm]
			\ifthenelse{\equal{\@phonenumber}{\relax}}{}{Phone: \texttt{\@phonenumber}\\}
			\ifthenelse{\equal{\@faxnumber}{\relax}}{}{Fax: \texttt{\@faxnumber}\\[0.2cm]}
			\ifthenelse{\equal{\@email}{\relax}}{}{Email: \href{mailto:\@email}{\@email}\\}
			\ifthenelse{\equal{\@website}{\relax}}{}{Website: \href{\@website}{\@website}\\}
		\end{minipage}
	\end{minipage}
	}}