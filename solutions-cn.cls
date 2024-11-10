% This is a LaTeX format for creating solutions to exercises(cn_version)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{solutions-cn}[26/10/2024 solutions document class]

\newif\ifusehyper
\usehyperfalse % default not to use hyperref

\DeclareOption{hyper}{
    \usehypertrue
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

\LoadClass[
    fontset=windows,
    a4paper,
    zihao=-4
]{ctexart}

% Package settings
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{mathrsfs}
\RequirePackage{tikz-cd}
\RequirePackage{enumerate}
\RequirePackage{tikz}
\RequirePackage{tcolorbox}
\RequirePackage{varwidth}
\RequirePackage[
    nottoc,
    notlot,
    notlof
]{tocbibind}
\RequirePackage[
    top = 25mm,
    bottom = 20mm,
    left = 30mm,
    right = 30mm
]{geometry}
\ifusehyper
    \RequirePackage{hyperref}
    \hypersetup{
        colorlinks = true,
        linkcolor = blue,
        citecolor = green,
        urlcolor = cyan
    }
\fi
\tcbuselibrary{theorems, skins, hooks, breakable}

% Math settings
\everymath{\displaystyle}

% Custom section settings
\ctexset{
    section = {
        format += {\zihao{3}},
        name = {第, 章},
        number = {\arabic{section}}
    },
    subsection = {
        format += {\bfseries\raggedright\zihao{-3}},
        name = {习题,}
    }
}

% New commands
\newcommand{\defeq}{\mathrel{\coloneqq}}
\newcommand{\eqdef}{\mathrel{\eqqcolon}}
\newcommand{\defequiv}{\mathrel{\vcentcolon\Leftrightarrow}}
\newcommand{\red}[1]{\textcolor{red}{#1}}

% colors
\definecolor{rmkbg}{HTML}{E6F8F6}
\definecolor{rmkfr}{HTML}{39C5BB}% use color of MIKU!

% Theorem style
\newtheoremstyle{dotless}{3pt}{3pt}{\songti}{2em}{\bfseries}{}{\ccwd}{}
\theoremstyle{dotless}
\newtheorem{problem}{}[subsection]
\newtheorem*{propstar}{\bfseries\heiti 命题}

% exercise environment
\newcounter{exercise}
\newenvironment{exercise}[1][]
{
    \refstepcounter{exercise}
    \noindent\textbf{\theexercise.}
    \ifx\relax#1\relax
    \else
        (#1)
    \fi
    \par\vspace{0.5em}
}
{\vspace{1em}}

% This is for additional content mentioned in class
\newcounter{additional}
\newenvironment{additional}[1][]
{
    \refstepcounter{additional}
    \noindent\textbf{\theadditional.}
    \ifx\relax#1\relax
    \else
        (#1)
    \fi
    \par\vspace{0.5em}}
{\vspace{1em}}

% Solution environment
\newtcolorbox{solution}[1][]{
    enhanced,
    before skip=2mm, after skip=2mm,
    breakable,
    colback=blue!5,
    colframe=blue!80!black,
    fonttitle=\itshape,
    boxrule=0.5mm,
    attach boxed title to top left={xshift=1cm, yshift*=1mm-\tcboxedtitleheight},
    varwidth boxed title*=-3cm,
    colbacktitle=blue!75!black,
    boxed title style={
        frame code={
			\path[fill=tcbcolback]
			([yshift=-1mm,xshift=-1mm]frame.north west)
			arc[start angle=0,end angle=180,radius=1mm]
			([yshift=-1mm,xshift=1mm]frame.north east)
			arc[start angle=180,end angle=0,radius=1mm];
			\path[left color=tcbcolback!60!black,right color=tcbcolback!60!black,
			middle color=tcbcolback!80!black]
			([xshift=-2mm]frame.north west) -- ([xshift=2mm]frame.north east)
			[rounded corners=1mm]-- ([xshift=1mm,yshift=-1mm]frame.north east)
			-- (frame.south east) -- (frame.south west)
			-- ([xshift=-1mm,yshift=-1mm]frame.north west)
			[sharp corners]-- cycle;
		},
        interior engine=empty,
    },
    #1
}
\let\oldproof\proof 
\let\endoldproof\endproof
\renewcommand{\proofname}{proof}
\renewenvironment{proof}[1][\proofname]
{
    \begin{solution}[title = #1]
    \pushQED{\qed}
}
{
    \popQED
    \end{solution}
}

% remark tcolorbox
\usetikzlibrary{arrows,calc,shadows.blur}
\newtcolorbox{remark}[1][]{%
	enhanced,
	colback=rmkbg,%
	colframe=rmkfr,
	size=small,
	boxrule=1pt,
	title=\textbf{注:},
	halign title=flush center,
	coltitle=rmkfr,
	breakable,
	drop shadow=black!50!white,
	attach boxed title to top left={xshift=1cm,yshift=-\tcboxedtitleheight/2,yshifttext=-\tcboxedtitleheight/2},
	minipage boxed title=1.5cm,
	boxed title style={%
		colback=white,
		size=fbox,
		boxrule=1pt,
		boxsep=2pt,
		underlay={%
			\coordinate (dotA) at ($(interior.west) + (-0.5pt,0)$);
			\coordinate (dotB) at ($(interior.east) + (0.5pt,0)$);
			\begin{scope}
				\clip (interior.north west) rectangle ([xshift=3ex]interior.east);
				\filldraw [white, blur shadow={shadow opacity=60, shadow yshift=-.75ex}, rounded corners=2pt] (interior.north west) rectangle (interior.south east);
			\end{scope}
			\begin{scope}[rmkfr]
				\fill (dotA) circle (2pt);
				\fill (dotB) circle (2pt);
			\end{scope}
		},
	},
	#1,
}