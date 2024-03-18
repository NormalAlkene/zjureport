\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zjureport}

\DeclareOption{infohdr}{\def\@infohdr}
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexart}%
}
\ProcessOptions\relax

\LoadClass{ctexart}
\RequirePackage{geometry, graphicx, tabularx, listings}
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

% Parameters
\newcommand\course[1]{\def\@course{#1}}
\newcommand\expname[1]{\def\@expname{#1}}
\newcommand\exptype[1]{\def\@exptype{#1}}
\newcommand\coauthor[1]{\def\@coauthor{#1}}
\newcommand\teacher[1]{\def\@teacher{#1}}
\newcommand\stuid[1]{\def\@stuid{#1}}
\newcommand\major[1]{\def\@major{#1}}
\newcommand\location[1]{\def\@location{#1}}

\newcolumntype{Y}{>{\centering\arraybackslash}X}


\renewcommand{\maketitle}{{
    \noindent
    \centering
    \parbox[b]{.25\textwidth}{
        \includegraphics[width=.25\textwidth]{zju.pdf}
    }
    \quad
    \parbox[b]{.25\textwidth}{
        \Huge \textbf{实验报告}
        \smallskip
    }

    \ifx\@infohdr\undefined \else
    \hspace{.08\textwidth}
    \parbox[b]{.1\textwidth}{
		\renewcommand{\arraystretch}{1.5}
		\begin{tabular}{l c}
			专业： & \@major \\
			\cline{2-2}
			姓名： & \@author \\
			\cline{2-2}
			学号： & \@stuid \\
			\cline{2-2}
			日期： & \@date \\
			\cline{2-2}
            \ifx\@location\undefined \else
			地点： & \@location \\
			\cline{2-2}
            \fi
		\end{tabular}
		\renewcommand{\arraystretch}{1}
    }
    \fi

	\begin{table}[h]
		\begin{tabularx}{\textwidth}{r Y r c r c}
			课程名称： & \@course & 指导老师： & \@teacher & 成绩： & \\
			\cline{2-2}\cline{4-4}\cline{6-6}
            \ifx\@coauthor\undefined
                实验名称： & \multicolumn{3}{c}{\@expname} & 实验类型： & \@exptype \\
                \cline{2-4}\cline{6-6}
            \else
                实验名称： & \@expname & 实验类型： & \@exptype & 同组学生姓名： & \@coauthor \\
                \cline{2-2}\cline{4-4}\cline{6-6}
            \fi
		\end{tabularx}

        \begin{tabularx}{\textwidth}{r Y r Y r Y r Y}
            专业： & \@major & 姓名： & \@author & 学号： & \@stuid & 日期： & \@date \\
			\cline{2-2}\cline{4-4}\cline{6-6}\cline{8-8}
        \end{tabularx}
	\end{table}
}}

\newcommand{\faketoc}{
	\noindent
	\begin{table}[h]
		\begin{tabularx}{\textwidth}{l X l}
			一、实验目的和要求（必填） & & 二、实验内容和原理（必填）\\
			三、主要仪器设备（必填） & & 四、操作方法和实验步骤 \\
			五、实验数据记录和处理 &  & 六、实验结果与分析（必填）\\
			七、讨论、心得 \\
		\end{tabularx}
	\end{table}
}

\newcommand{\makeinfo}{
    \noindent
    \begin{table}[h]
        \begin{tabularx}{\textwidth}{c Y c c c c}
            实验名称：& \@expname & 姓名： & \@author & 学号： & \@stuid\\
            \cline{2-2}\cline{4-4}\cline{6-6}
        \end{tabularx}
    \end{table}
}

\setmonofont{Consolas}

\lstset{
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

\lstdefinestyle{CPP}{
    language = C++,
    morekeywords={size_t}
}

\pagestyle{plain}
