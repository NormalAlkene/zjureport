\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zjureport}

\DeclareOption{infohdr}{\def\opt@infohdr}
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexart}
}
\ProcessOptions\relax

\LoadClass{ctexart}
\RequirePackage{geometry, graphicx, tabularx, listings, fontspec, fancyhdr}
\RequirePackage{etoolbox}
\RequirePackage[svgnames]{xcolor}

\geometry{a4paper, scale=0.8}

\ctexset{
	section = {
		format = {\LARGE\sffamily\bfseries},
        name = {,、},
        number = {\chinese{section}},
        aftername = \hspace{0.3em}
	},
	subsection = {
		format = {\Large\sffamily\bfseries},
        name = {（,）},
        number = {\chinese{subsection}},
        aftername = \hspace{0.3em},
	},
	subsubsection = {
		format = {\large\sffamily\bfseries},
        name = {,.},
        number = {\arabic{subsubsection}},
        aftername = \hspace{0.35em}
	},
	paragraph = {
		format = {\large\bfseries}
	}
}

\newcommand*\course[1]{\def\@course{#1}}
\newcommand*\expname[1]{\def\@expname{#1}}
\newcommand*\exptype[1]{\def\@exptype{#1}}
\newcommand*\coauthor[1]{\def\@coauthor{#1}}
\newcommand*\teacher[1]{\def\@teacher{#1}}
\newcommand*\stuid[1]{\def\@stuid{#1}}
\newcommand*\major[1]{\def\@major{#1}}
\newcommand*\location[1]{\def\@location{#1}}
\renewcommand*\date[1]{\def\@date{#1}}

\newcolumntype{Y}{>{\centering\arraybackslash}X}

\renewcommand{\maketitle}{{%
    \noindent\centering%
    \parbox[b]{.24\textwidth}{%
        \includegraphics[width=.24\textwidth]{zju.pdf}
    }
    \quad
    \parbox[b]{.25\textwidth}{%
        \Huge\textsf{\textbf{实验报告}}
        \smallskip
    }
    \par\bigskip
    \ifdef{\opt@infohdr}{%
        \thispagestyle{titlepage}
    }{}
}}

\ifdef{\opt@infohdr}{%
    \renewcommand{\headrulewidth}{0pt}
    \fancypagestyle{titlepage}{%
        \fancyhead{}
        \fancyhead[R]{%
            \let\orig@arraystretch\arraystretch
            \renewcommand*{\arraystretch}{1.5}
            \begin{tabular}[t]{l c}
                \ifdef{\@major}{%
                    专业： & \@major \\
                    \cline{2-2}
                }{}
                \ifdef{\@author}{%
                    姓名： & \@author \\
                    \cline{2-2}
                }{}
                \ifdef{\@stuid}{%
                    学号： & \@stuid \\
                    \cline{2-2}
                }{}
                \ifdef{\@date}{%
                    日期： & \@date \\
                    \cline{2-2}
                }{}
                \ifdef{\@location}{%
                    地点： & \@location \\
                    \cline{2-2}
                }{}
                \end{tabular}
            \let\arraystretch\orig@arraystretch
        }
    }
}{}

% TODO: more customizable?
\newcommand{\makeinfo}{%
    \par\noindent
    \begin{tabularx}{\textwidth}{r Y r c r c}
        课程名称： & \@course & 指导老师： & \@teacher & 成绩： & \\
        \cline{2-2}\cline{4-4}\cline{6-6}
        \ifdef{\@coauthor}{%
            实验名称： & \@expname & 实验类型： & \@exptype & 同组学生姓名： & \@coauthor \\
            \cline{2-2}\cline{4-4}\cline{6-6}
        }{%
            实验名称： & \multicolumn{3}{c}{\@expname} & 实验类型： & \@exptype \\
            \cline{2-4}\cline{6-6}
        }
    \end{tabularx}
    \begin{tabularx}{\textwidth}{r Y r Y r Y r Y}
        专业： & \@major & 姓名： & \@author & 学号： & \@stuid & 日期： & \@date \\
        \cline{2-2}\cline{4-4}\cline{6-6}\cline{8-8}
    \end{tabularx}
    \par\bigskip
}

% Redefinition of the tableofcontents
\let\orig@tableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
    \IfFileExists{\jobname.toc}{%
        \par\noindent%
        \begin{tabularx}{\textwidth}{X l}
            \immediate\input{\jobname.toc}
        \end{tabularx}
        \par
    }{}
    \def\flag@writetoc{\relax}
    \newwrite\file@toc
    \immediate\openout\file@toc=\jobname.toc
    \AtEndDocument{%
        \immediate\closeout\file@toc
    }
}

\let\orig@section\section
\renewcommand{\section}[1]{%
    \orig@section{#1}
    \ifdef{\flag@writetoc}{%
        \ifnumodd{\value{section}}{%
            \immediate\write\file@toc{\chinese{section}、#1 &}
        }{%
            \immediate\write\file@toc{\chinese{section}、#1 \\}
        }
    }{}
}

\setmonofont{Consolas}

\lstset{%
    basicstyle          =   \linespread{0.85}\ttfamily,
    keywordstyle        =   \bfseries\color{blue},
    stringstyle         =   \color{Magenta!90!black},
    commentstyle        =   \color{LimeGreen},
    breaklines          =   true,   
    columns             =   flexible,
    numbers             =   left,
    numbersep           =   2em,
    numberstyle         =   \footnotesize,
    showspaces          =   false,
    showstringspaces    =   false,
    captionpos          =   tb,
    frame               =   lrtb,
    extendedchars       =   true,
    tabsize             =   4,
}

\lstdefinestyle{CPP}{%
    language = C++,
    morekeywords={size_t}
}

\pagestyle{plain}
