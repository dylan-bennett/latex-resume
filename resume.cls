% Originally created by Murat Can Karacabey
\author{Murat Can Karacabey}
\RequirePackage[dvipsnames]{xcolor} % moved here I guess article class causes option clash with xcolor if used after loading the class
\LoadClass[11pt]{article}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/07/17 Resume Class]
\RequirePackage[sfdefault]{noto}
\RequirePackage{etoolbox}
\RequirePackage{pgffor}
\RequirePackage{titlesec}
\RequirePackage{tikz}
\RequirePackage{fontspec}
\RequirePackage[left=0.75in,top=0.3in,right=0.75in,bottom=0.6in]{geometry} % Document margins
\RequirePackage{hyperref}
\RequirePackage{fontawesome}
\RequirePackage{mfirstuc}
\RequirePackage{ifthen}
\RequirePackage{lipsum}
\RequirePackage{array}
\pagestyle{empty}

% Setup
% Theme color
\def\@themecolor{red}
\newcommand*{\setthemecolor}[1]{\def\@themecolor{#1}}

% Hyperlinks
\hypersetup{
    colorlinks=true,
    urlcolor=cyan,
}

% Helper commands
% Separator
\newcommand{\separator}[1]{%
  {\color{\@themecolor} \hspace{#1} \textbar \hspace{#1}}%
}

% Wide separator
\newcommand{\wideseparator}{%
  \separator{0.6em}%
}

% Narrow separator
\newcommand{\narrowseparator}{%
  \separator{0.1em}%
}

% Name
\newcommand*{\setname}[2]{\def\@firstname{#1} \def\@lastname{#2}}
\newcommand*{\name}{
  {\Huge \textsc{\@firstname \hspace{0.1em} \@lastname}}%
}

% Headline
\newcommand*{\setheadline}[1]{\def\@headline{#1}}
\newcommand*{\headline}{%
  \emph{\@headline}%
}

% Contact
\newcommand*{\setaddress}[1]{\def\@address{#1}}
\newcommand*{\setmobile}[1]{\def\@mobile{#1}}
\newcommand*{\contact}{%
  \small \@address%
  \wideseparator%
  \@mobile%
}

% Links
\newcommand*{\setemail}[1]{\def\@email{#1}}
\newcommand*{\setgithubpersonal}[1]{\def\@githubpersonal{#1}}
\newcommand*{\setgithubhatch}[1]{\def\@githubhatch{#1}}
\newcommand*{\setlinkedinaccount}[1]{\def\@linkedinaccount{#1}}
\newcommand*{\emailview}{%
  \href{mailto:\@email}{\faEnvelope\ \footnotesize \@email}%
}
\newcommand*{\githubviewpersonal}{%
  \href{\@githubpersonal}{\faGithubSquare\ \footnotesize github - personal}%
}
\newcommand*{\githubviewhatch}{%
  \href{\@githubhatch}{\faGithubSquare\ \footnotesize github - hatch coding}%
}
\newcommand*{\linkedinview}{%
  \href{\@linkedinaccount}{\faLinkedinSquare\ \footnotesize linkedin}%
}
\newcommand*{\links}{%
  \emailview%
  \wideseparator%
  \githubviewpersonal%
  \wideseparator%
  \githubviewhatch%
  \wideseparator%
  \linkedinview%
}

% Header View
\newcommand{\resumeheader}{%
  \begin{minipage}{0.9\linewidth}
    \center \name \\
    \center \contact \\
    \center \headline \\
    \center \links
  \end{minipage}
  \vspace{1em}
}

% Section header
\newcommand{\sectionheader}[1]{%
    \vspace{10pt}% Space before section header
    % \hspace{0pt}% Left indent
    {
      \large \bfseries \scshape \raggedright \color{\@themecolor} #1 
      \hspace{0.1em} \color{black} \hrulefill
    }%
    \par% End the paragraph
    \vspace{5pt}% Space after section header
}

% Summary
\newcommand{\summary}[1]{%
  % \begin{minipage}{0.95\linewidth}
    \small
    \setlength{\baselineskip}{1.2\baselineskip}
    \hspace{2em} #1%
  % \end{minipage} \\[0.1cm]%
  \vspace{0.5em}
}

% Experience and Education
\newcommand{\position}[1]{%
  \small \textsc{#1}%
}
\newcommand{\company}[1]{%
  \small \textsc{\textbf{#1}}%
}
\newcommand{\daterange}[1]{%
  \footnotesize \color{black!60!\@themecolor} \textit{#1}%
}
\newcommand{\experienceheader}[3]{%
  \company{#1} \hspace{0.5em} \position{#2}%
  \hfill \daterange{#3}\\[0.1cm]%
}
\newcommand{\coloredbullet}{%
  \color{\@themecolor} \textbullet%
}
\newcommand{\experience}[1]{%
  \small \indent \coloredbullet \hspace{0.3em} \color{black} #1\\[0.1cm]%
}

% Skills
% List of skills with a category
\newcommand{\skillscategory}[2]{%
  \small%
  \textsc{\textbf{#1}}\hspace{0.5em}%
  \parbox[t]{14cm}{%
    % Set the line spacing, in case it runs into the next line
    \setlength{\baselineskip}{1.4\baselineskip}%

    % Add a separator between skills
    \newif\iffirstskill
    \firstskilltrue
    \@for\skill:=#2\do{%
      \iffirstskill
        \firstskillfalse
      \else
        \narrowseparator%
      \fi
      \skill%
    }
  }\\
}

% List of categories, formatted as a table for better alignment
\newcommand{\skillscategories}[1]{%
  \begin{tabular}{rl}%
    \@for\category:=#1\do{\category\\[0.01cm]}%
  \end{tabular}%
}

% Cover Letter
%Setup for coverletter
\newcommand*{\setcompanyname}[1]{\def\@companyname{#1}}
\newcommand*{\setcontactperson}[1]{\def\@contactperson{#1}}
\newcommand*{\setpositionname}[1]{\def\@positionname{#1}}

%Coverletter subview
\newcommand{\companyandposition}{%
\begin{tabular}{>{\scshape \bfseries \color{\@themecolor}}l  >{\small }l}
  Company: & \@companyname \\
  Position: & \@positionname \\
\end{tabular}%
}

%Coverletter
\newcommand{\coverletter}[1]{%
  % Company and position
  \companyandposition \\[0.1cm]%

  % Horizontal rule
  \color{black} \hrulefill \\[0.5cm]%

  % Greeting
  \textbf{ Dear \@contactperson, \\[0.5cm]}%

  % Body
  \setlength{\baselineskip}{1.2\baselineskip}%
  #1 \\[0.5cm]%

  % Signature
  \textbf{ Sincerely, \\[0.5cm]}%
  \indent \@firstname\ \@lastname%
}

%Footnote
\newcommand{\createfootnote}{%
  % Footnote styling
  \renewcommand{\footnotesize}{\fontsize{7pt}{11pt}\selectfont}
  % \renewcommand{\footnoterule}{\rule{0.3\linewidth}{0.5pt}}

  % Remove footnote numbering
  \let\thefootnote\relax
  
  % Footnote content
  \footnote{
    \today\ / \href{https://github.com/dylan-bennett/resume}{source code}
  }
}