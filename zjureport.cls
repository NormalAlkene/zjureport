% vim: foldmethod=marker
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zjureport}

\DeclareOption{infohdr}{\def\opt@infohdr}
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexart}
}
\ProcessOptions\relax

\LoadClass{ctexart}
\RequirePackage{geometry, graphicx, tabularx, listings, fontspec, fancyhdr, xkeyval, titlesec}
\RequirePackage{etoolbox}
\RequirePackage[svgnames]{xcolor}

\geometry{a4paper, scale=0.8}

\newcolumntype{Y}{>{\centering\arraybackslash}X}

% {{{ CTEX settings
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
% }}}

% {{{ Info table settings
% Deprecated info setting commands
\newcommand*{\@course}{}
\newcommand*{\@expname}{}
\newcommand*{\@exptype}{}
\newcommand*{\@coauthor}{}
\newcommand*{\@instructor}{}
\newcommand*{\@stuid}{}
\newcommand*{\@major}{}
\newcommand*{\@college}{}
\newcommand*{\@location}{}
\newcommand*{\course}[1]{\renewcommand{\@course}{#1}}
\newcommand*{\expname}[1]{\renewcommand{\@expname}{#1}}
\newcommand*{\exptype}[1]{\renewcommand{\@exptype}{#1}}
\newcommand*{\coauthor}[1]{\renewcommand{\@coauthor}{#1}}
\newcommand*{\instructor}[1]{\renewcommand{\@instructor}{#1}}
\newcommand*{\stuid}[1]{\renewcommand{\@stuid}{#1}}
\newcommand*{\major}[1]{\renewcommand{\@major}{#1}}
\newcommand*{\college}[1]{\renewcommand{\@college}{#1}}
\newcommand*{\location}[1]{\renewcommand{\@location}{#1}}
\renewcommand*{\date}[1]{\renewcommand{\@date}{#1}}

\ifdef{\opt@infohdr}{%
    \renewcommand{\headrulewidth}{0pt}
    \fancypagestyle{firstpage}{%
        \fancyhead{}
        \fancyhead[R]{%
            \let\orig@arraystretch\arraystretch
            \renewcommand*{\arraystretch}{1.5}
            \begin{tabular}[b]{l c}
                专业： & \@major \\
                \cline{2-2}
                姓名： & \@author \\
                \cline{2-2}
                学号： & \@stuid \\
                \cline{2-2}
                日期： & \@date \\
                \cline{2-2}
                地点： & \@location \\
                \cline{2-2}
            \end{tabular}
            \let\arraystretch\orig@arraystretch
        }
    }
}{}

\newcommand{\makeinfo}{%
    \par\noindent
    \begin{tabularx}{\textwidth}{r Y r c r c}
        课\hspace{\fill}程\hspace{\fill}名\hspace{\fill}称： & \@course & 指\hspace{\fill}导\hspace{\fill}老\hspace{\fill}师： & \@instructor & 成\hspace{\fill}绩： & \\
        \cline{2-2}\cline{4-4}\cline{6-6}
        \expandafter\notblank\expandafter{\@coauthor}{%
            实\hspace{\fill}验\hspace{\fill}名\hspace{\fill}称： & \@expname & 实\hspace{\fill}验\hspace{\fill}类\hspace{\fill}型： & \@exptype & 同\hspace{\fill}组\hspace{\fill}学\hspace{\fill}生\hspace{\fill}姓\hspace{\fill}名： & \@coauthor \\
            \cline{2-2}\cline{4-4}\cline{6-6}
        }{%
            实\hspace{\fill}验\hspace{\fill}名\hspace{\fill}称： & \multicolumn{3}{c}{\@expname} & 实\hspace{\fill}验\hspace{\fill}类\hspace{\fill}型： & \@exptype \\
            \cline{2-4}\cline{6-6}
        }
    \end{tabularx}
    \ifundef{\opt@infohdr}{
        \begin{tabularx}{\textwidth}{r Y r Y r Y r Y}
            专业： & \@major & 姓名： & \@author & 学号： & \@stuid & 日期： & \@date \\
            \cline{2-2}\cline{4-4}\cline{6-6}\cline{8-8}
        \end{tabularx}
    }{}
    \par\bigskip
}

% }}}

% {{{ Cover page and title
\renewcommand{\maketitle}{{%
    \vspace*{12pt}
    \par\noindent\centering
    \parbox[b]{.24\textwidth}{%
        \includegraphics[width=.24\textwidth]{zju.pdf}
    }
    \quad
    \parbox[b]{.24\textwidth}{%
        \Huge\textsf{\textbf{实验报告}}
        \smallskip
    }
    \par\bigskip
    \ifdef{\opt@infohdr}{%
        \thispagestyle{firstpage}
    }{}
}}

\newcommand{\makecoverpage}{%
    \begin{titlepage}
        \begin{center}
            \def\opt@coverpage{}
            \vspace*{2cm}

            \noindent\includegraphics[width = .5\textwidth]{zju.pdf}

            \vspace*{1cm}

            \noindent\parbox[b]{.6\textwidth}{%
                \noindent\Huge\textbf{\textsf{本\hspace{\fill}科\hspace{\fill}生\hspace{\fill}实\hspace{\fill}验\hspace{\fill}报\hspace{\fill}告}}
            }
            \vspace*{1cm}

            \noindent\includegraphics[width = .3\textwidth]{zju-logo.pdf}

            \vspace*{1cm}

            \let\orig@arraystretch\arraystretch
            \renewcommand*{\arraystretch}{2.3}
            \begin{tabular}[b]{l c}
                \expandafter\notblank\expandafter{\@major}{%
                    \Large 实\hspace{\fill}验\hspace{\fill}名\hspace{\fill}称： & \Large \@expname \\
                    \cline{2-2}
                }{}
                \expandafter\notblank\expandafter{\@major}{%
                    \Large 学\hspace{\fill}院： & \Large \@college \\
                    \cline{2-2}
                }{}
                \expandafter\notblank\expandafter{\@major}{%
                    \Large 专\hspace{\fill}业： & \Large \@major \\
                    \cline{2-2}
                }{}
                \expandafter\notblank\expandafter{\@author}{%
                    \Large 姓\hspace{\fill}名： & \Large \@author \\
                    \cline{2-2}
                }{}
                \expandafter\notblank\expandafter{\@stuid}{%
                    \Large 学\hspace{\fill}号： & \Large \@stuid \\
                    \cline{2-2}
                }{}
                \expandafter\notblank\expandafter{\@instructor}{%
                    \Large 指\hspace{\fill}导\hspace{\fill}教\hspace{\fill}师： & \Large \@instructor \\
                    \cline{2-2}
                }{}
                \expandafter\notblank\expandafter{\@date}{%
                    \Large 日\hspace{\fill}期： & \Large \@date \\
                    \cline{2-2}
                }{}
                \expandafter\notblank\expandafter{\@location}{%
                    \Large 地\hspace{\fill}点： & \Large \@location \\
                    \cline{2-2}
                }{}
                \end{tabular}
            \let\arraystretch\orig@arraystretch
        \end{center}
    \end{titlepage}
}
% }}}

% {{{ Table of contents
\newcommand{\simpletoc}{%
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

\let\complextoc\tableofcontents

% Redefinition of the tableofcontents
\let\orig@tableofcontents\tableofcontents
\renewcommand{\tableofcontents}{\simpletoc}

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
% }}}

% {{{ Listing settings
\setmonofont{Noto Sans Mono}
\lstset{%
    basicstyle          =   \linespread{0.85}\ttfamily,
    keywordstyle        =   [0]\bfseries\color{blue},
    keywordstyle        =   [1]\bfseries\color{magenta},
    stringstyle         =   \color{Magenta!90!black},
    commentstyle        =   \color{LimeGreen}\ttfamily,
    breaklines          =   true,   
    %columns             =   flexible,
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

\lstdefinestyle{plain}{%
    numbers = none
}

% }}}

\pagestyle{plain}
