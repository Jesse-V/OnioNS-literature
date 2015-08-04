%%
% 
% This is a modified version of engineering's style file.  The following lists
% the differences. Author Unknown
%
% 	- Added cs option
% 	- Added department name Computer Science
%	- Added degree in Computer Science
% 	- Changed the counters for the table of contents (TOC)
%	- Changed the capitalization of CONTENTS in TOC	
%	- Changed the capitalization of LIST OF TABLES of LIST OF FIGURES
%	- Changed the capitalization of ACKNOWLEDGEMENTS and PREFACE
%	- Changed the heading of "Vita" to "CURRICULUM VITAE"
%	- Changed the capitalization of ABSTRACT
%	- Changed the spacing between floats (images) and text
%	- Changed the capitalization of REFERENCES
% 	- Made bibliography double spaced
%	- Changed the capitalization of APPENDIX and APPENDICES
%	- Changed the capitalization of CHAPTER
%	- Changed the text location in \paragraph sections and 
%         \subparagraph sections
% 	- Changed \citemid to place a colon in citations where the
%         citation has a note such as the page number where the
%         citation is refering to
%
%   
%	
%  In addition the following changes have been made to reflect recent changes in the Graduate School
%  Author: Kyle Feuz
%  
%  - Added and second line for the dean's title
%  - Added a public abstract page
%



%  -- usuthesis --
% 
%  A LaTeX class for the preparation of USU thesis' and dissertations.
% 
%  (last_modified) Mon Jun  4 12:41:24 2007 by Scott Budge <scott@goga.ece.usu.edu>
%
%
%  Info: $Id: usuthesis.cls 30 2007-10-04 22:54:24Z scott $   USU
%  Revision: $Rev: 30 $
% $LastChangedDate: 2007-10-04 16:54:24 -0600 (Thu, 04 Oct 2007) $
% $LastChangedBy: scott $
%
%  --- Usage ---
%
%  Several options can be specified with in the documentclass statement... 
%
%    Department - makes department specific format changes
%    - cs
%    - ee
%	 - ce
%    - mae
% 
%    Document type - controls titlepage layout
%    - msthesis = MS plan A thesis
%    - msreport = MS plan B report
%    - dissertation = PhD dissertation
%
%    Proposal flag - indicates that the document is a proposal rather than
%                    a finished document (alters title page layout)
%    - proposal = MS proposal
%
%    Fontsize - defaults to 11pt 
%    - 10pt
%    - 11pt
%    - 12pt
%%
%    Options example:
%      \documentclass[ee,msthesis]{usuthesis}
%
%  --- Bug Reports ---
%
%  This class file is probably not perfect. Reports of any bugs you encounter
%  are most welcome. Please email them to me at <amcinnes@cc.usu.edu>, 
%  or stop by my office (EL-241C) and tell me what the problem is. I'll do
%  my best to get it fixed ASAP.
%
%  --- Origins ---
%
%  Based on Lili Ma's modifications to version 1.6 of the original usuthesis
%  class maintained by Dr. Scott Budge and Dr. Todd Moon. That class was in 
%  turn based on a combination of the standard LaTeX book.cls, and a thesis
%  style file originating at Colorado State University. Also makes use of a
%  variety of ideas from Mark Senn's puthesis.cls Purdue University 
%  thesis class.
%
%  --- Notes ---
%
%  Setting the line spacing for the frontmatter to singlespaced is legacy from
%  the original usuthesis.sty. At some point it would be nice to change it,
%  since so much of the frontmatter seems to actually be doublespaced. But I'm
%  afraid that transition would require a lot of tinkering with the vspace's
%  and vskip's scattered throughout the frontmatter sections. I don't really
%  want to tackle that right now.
%  
%  --- Revision History ---
%
%  Note that this file is a lot more fun to work with if you have an editor
%  that supports folding, like Jedit or Emacs. Hence all the {{{ }}} pairs. 
%
%  History:
%  2005-02-18  -  Restructured original files into one class 
%              -  Moved to layout control via setspace.sty and geometry.sty 
%  2005-02-19  -  Added support for different types of title pages
%  2005-02-20  -  Added \makeappendix, \makeappendices, and redef'ed \appendix
%              -  Added \references
%              -  Consolidated several environment definitions into \newfbmatter
%              -  Added cite.sty and url.sty as required packages, to improve
%                 citation and bibliography formatting 
%  2005-02-23  -  Minor tweaks to "notation" environment
%  2005-03-03  -  Modified margin settings to ensure 1" bottom margin 
%  2005-03-04  -  Modified handling of the proposal option
%              -  Added signature blocks to proposal coversheets 
%              -  Fixed double spacing of LoT and LoF
%  2005-08-29  -  Fixes based on feedback from Pat Patterson's dissertation
%                 1. Reduced computed page count by 1
%                 2. Removed an extra blank line between "Contents" and the ToC
%                 3. Tweaked definition of \@chapter to prevent extra blank
%                    lines from being inserted into LoT and LoF (thanks to
%                    Dr. Todd Moon for help in tracking down the root cause of 
%                    this problem
%                 4. Removed extra blank lines in chapter headings, between 
%                    "Chapter xxx" and the chapter name, and between the
%                    chapter name and the body text
%                 5. Inserted an extra blank line between "References" and the
%                    reference list
%  2005-10-25  -  Improved the handling of the page count for the abstract page.
%                 Now writes the total page count to the .aux file, instead of
%                 generating an extra blank page at the end of the document.
%                 Also separated out and clarified the decrements that are
%                 applied to the page counters to get the final page count.
%  2005-10-26  -  Cleaned up handling of title page approval block formatting.
%                 Removed the Grad Dean signature line from the approval
%                 block for the msreport option (tip of the hat to Mitch 
%                 Whiteley for pointing out that grad dean approval is 
%                 unnecessary for Plan B reports.
%  2006-01-31  -  Setting of 'mae' option now sets the department and degree.
%  2006-01-31  -  Handling of proposals fixed so that the word 'proposal'
%                 actually appears on the cover sheet (tip of the hat to 
%                 Dave Woffinden for the bug report).
%  2006-07-20  -  Adjusted LoT and LoF to provide single-spacing within entries
%                 and double-spacing between entries.
%  2006-07-20  -  Alter page count (again) so that it is precisely frontmatter 
%                 (including cover page) + mainmatter. This is apparently what 
%                 the page count is supposed to be.
%  2007-11-06  -  Fixed the appendix and appendices labling and number in the
%			%TOC, LoT, LoF and individual section headings.
%
%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{usuthesis}[2007/06/04 rev 23 Revised USU thesis class]

%{{{ A handy macro for debugging: \IW{ <x> } will write <x> to the console
% This idea from Mark Senn's puthesis.cls
\newcommand{\IW}[1]{\immediate\write16{#1}}
%}}}

%{{{ Options passed in through class invocation
%{{{ Option declarations
%{{{ Department name definitions
%
% Used to set formatting options.
% Defaults to ee.
% Option for mae added only to provide an example - it has no effect right now.
%
\newcommand{\@@dept}{ee}
\newcommand{\set@@dept}[1]{\renewcommand{\@@dept}{#1}}
\DeclareOption{cs}{\set@@dept{cs}}
\DeclareOption{ee}{\set@@dept{ee}}
\DeclareOption{ce}{\set@@dept{ce}}
\DeclareOption{mae}{\set@@dept{mae}}
%}}}

%{{{ Document type definitions
%
% What type of document are we producing. 
% Used to determine formatting options.
%
\newcommand{\@@type}{msthesis}
\newcommand{\set@@type}[1]{\renewcommand{\@@type}{#1}}
\DeclareOption{msthesis}{\set@@type{msthesis}}
\DeclareOption{msreport}{\set@@type{msreport}}
\DeclareOption{dissertation}{\set@@type{dissertation}}
%}}}

%{{{ Proposal flag - changes the handling of signature blocks
\newif\if@isproposal \@isproposalfalse
\DeclareOption{proposal}{\@isproposaltrue}
%}}}

%{{{ Font size control
\newcommand{\@@fontsize}{11pt}
\newcommand{\set@@fontsize}[1]{\renewcommand{\@@fontsize}{#1}}
\DeclareOption{10pt}{\set@@fontsize{10pt}}
\DeclareOption{11pt}{\set@@fontsize{11pt}}
\DeclareOption{12pt}{\set@@fontsize{12pt}}
%}}}
%}}}

%{{{ Options that we don't want to see
\newcommand{\@@classname}{usuthesis}

\DeclareOption{notitlepage}
    {\ClassWarning{\@@classname}
	{Option '\CurrentOption' is not available for \@@classname.}}
\DeclareOption{twocolumn}
    {\ClassWarning{\@@classname}
	{Option '\CurrentOption' is not available for \@@classname.}}
\DeclareOption{landscape}
    {\ClassWarning{\@@classname}
	{Option '\CurrentOption' is not available for \@@classname.}}
\DeclareOption{legalpaper}
    {\ClassWarning{\@@classname}
	{Option '\CurrentOption' is not available for \@@classname.}}
\DeclareOption{a4paper}
    {\ClassWarning{\@@classname}
	{Option '\CurrentOption' is not available for \@@classname.}}
\DeclareOption{a5paper}
    {\ClassWarning{\@@classname}
	{Option '\CurrentOption' is not available for \@@classname.}}
\DeclareOption{executivepaper}
    {\ClassWarning{\@@classname}
	{Option '\CurrentOption' is not available for \@@classname.}}
\DeclareOption{b5paper}
    {\ClassWarning{\@@classname}
	{Option '\CurrentOption' is not available for \@@classname.}}
%}}}

% Catch any undeclared options and pass them to book class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}%
                \typeout{Passing '\CurrentOption' on to LaTex2e book.cls}}

% Default options
%\ExecuteOptions{}

% Process the options
\ProcessOptions\relax
%}}}

%{{{ Load the base class 
\LoadClass[letterpaper,\@@fontsize,oneside,onecolumn,titlepage]{book}[2001/04/21]
%}}}

%{{{ Set up conditional handling (i.e. if-then's)
\RequirePackage{ifthen}
\newcommand{\ifthen}[2]{\ifthenelse{#1}{#2}{}}
%}}}

%{{{ Line-spacing control
\RequirePackage{setspace}
\newcommand{\singlespaced}{\singlespacing}
\newcommand{\doublespaced}{\doublespacing}
\newcommand{\triplespaced}{\setstretch {2.6}}
%}}}

%{{{ Department-specific formatting
\ifthen{\equal{cs}{\@@dept}}
{
  % Nothing here right now
}
\ifthen{\equal{ee}{\@@dept}}
{
  % Nothing here right now
}
\ifthen{\equal{ce}{\@@dept}}
{
  % Nothing here right now
}
\ifthen{\equal{mae}{\@@dept}}
{
  % Nothing here right now
}
%}}}

%{{{ Counters for numbers of different types of pages
\newcounter{savemainpageno}
\newcounter{savefrontpageno}
\newcounter{savetotalpageno}
%}}}

%{{{ Set up margins, and other page parameters.
% Use the geometry package for margins to make our life easier
\RequirePackage{geometry}
\geometry{%
    paper=letterpaper,
    includeheadfoot,
    truedimen,
    bindingoffset=0.5in,  % bindingoffset + left = required 1.5in margin
    left=1in,
    top=1in,
    right=1in,
    bottom=1in,
    headheight=\@@fontsize,
    headsep=\baselineskip,
    footskip=0pt}

\tabskip 0.1em plus 10em minus 0.1em

% set paragraph indent spacing
\parindent 2em

% minimize orphans and widows
\clubpenalty=9999
\widowpenalty=9999
\displaywidowpenalty=9999
\brokenpenalty=9999

% reset footnote demarcation line
\renewcommand\footnoterule{%
    \kern-1pt
    \hrule\@width1.5in
    \kern.6pt}
%}}}

%{{{ Set up title page macros and defaults.

\newif\if@reportORproposal \@reportORproposalfalse

\def\doctype#1{\gdef\Zdocument{#1}}
\def\year#1{\gdef\Zyear{#1}}
\def\month#1{\gdef\Zmonth{#1}}
\def\title#1{\gdef\Ztitle{#1}}
\def\author#1{\gdef\Zauthor{#1}}
\def\degree#1{\gdef\Zdegree{#1}}
\def\departmentname#1{\gdef\Zdepartmentname{#1}}
\def\degreein#1{\gdef\Zdegreein{#1}}
\def\majorprof#1{\gdef\Zmajorprof{#1}}
\def\deptchair#1{\gdef\Zdeptchair{#1}}

\def\firstreader#1{\gdef\Zfirstreader{#1}}
\def\secondreader#1{\gdef\Zsecondreader{#1}}
\def\thirdreader#1{\gdef\Zthirdreader{#1}}
\def\fourthreader#1{\gdef\Zfourthreader{#1}}
\def\lastreader#1{\gdef\Zlastreader{#1}}
\def\fifthreader#1{\gdef\Zfifthreader{#1}}  % not used right now

\def\graddean#1{\gdef\Zgraddean{#1}}
\def\deantitle#1{\gdef\Zdeantitle{#1}}
\def\deansecondtitle#1{\gdef\Zdeansecondtitle{#1}}
%}}}

%{{{ Set some title page values based on dept option
\ifthen{\equal{cs}{\@@dept}}{%
  \departmentname{Computer Science}
  \degreein{Computer Science}
}
\ifthen{\equal{ee}{\@@dept}}{%
  \departmentname{Electrical and Computer Engineering}
  \degreein{Electrical Engineering}
}
\ifthen{\equal{ce}{\@@dept}}{%
  \departmentname{Electrical and Computer Engineering}
  \degreein{Computer Engineering}
}
\ifthen{\equal{mae}{\@@dept}}{%
  \departmentname{Mechanical and Aerospace Engineering}
  \degreein{Mechanical Engineering}
}

%}}}

%{{{ Set some title page values based on document type and the proposal flag
\ifthen{\equal{dissertation}{\@@type}}{%
  \doctype{dissertation}
  % 5 committee members, so last reader is the 4th one
  \lastreader{\Zfourthreader}
  \if@isproposal
    \doctype{dissertation proposal}
    \@reportORproposaltrue
  \fi
}
\ifthen{\equal{msthesis}{\@@type}}{%
  \doctype{thesis}
  % Only 3 committee members, so last reader is the 2nd one
  \lastreader{\Zsecondreader}
  \if@isproposal
    \doctype{thesis proposal}
    \@reportORproposaltrue
  \fi  
}
\ifthen{\equal{msreport}{\@@type}}{%
  \doctype{report}
  % Only 3 committee members, so last reader is the 2nd one
  \lastreader{\Zsecondreader}
  \if@isproposal
    \doctype{report proposal}
  \fi  
  \@reportORproposaltrue
}
%}}}

%{{{ Define styles for the frontmatter and main body
\def\preliminaries{%
    % Set the page numbering style
    \eject\pagestyle{topnumber}\pagenumbering{roman}%
    \setcounter{page}{1}\eject}

\def\body{%
    % Save the number of frontmatter pages, which is 1 less than the
    % current page number
    \setcounter{savefrontpageno}{\value{page}}% 
    \addtocounter{savefrontpageno}{-1}%
    % Reset line spacing, and page numbering style
    % Reset the page counter: mainmatter is numbered from '1'
    \eject\doublespaced\pagestyle{topnumber}%
    \pagenumbering{arabic}\setcounter{page}{1}\eject}

%}}}

%{{{ Change footnote and page number formatting
\long\def\@makefntext#1{\parindent=18pt $^{\@thefnmark}$#1\par}
\def\ps@topnumber{\def\@oddhead{\hfil\thepage}\let\@evenhead=\@oddhead\def\@oddfoot{}\let\@evenfoot=\@oddfoot}
%}}}

%{{{ Table of Contents

\setcounter{secnumdepth}{2} 
\setcounter{tocdepth}{1}

\renewcommand*{\tableofcontents}{
    % USU requires the word "CONTENTS" to appear on the toc page
    \chapter*{\begin{center} CONTENTS\\[5ex]\end{center}}
    \noindent
    \hfill Page\\
    \vspace{-\baselineskip}
    \@starttoc{toc}
}
%}}}

%{{{ List of Tables
% LoT should be single-spaced within entries and double-spaced between entries
\renewcommand*{\listoftables}{
    \vskip0pt
    \chapter*{\begin{center} LIST OF TABLES  \end{center}}
    \addcontentsline{toc}{chapter}{LIST OF TABLES}
    \addvspace{10pt}
    \typeout{!! List of Tables...!!}
    \noindent
    Table \hfill Page\\         % newline allows us to use a vspace...
    % vspace adjusts spacing to get a doublespace between table headings
    % and table contents
    \vspace{-\baselineskip}
    \@starttoc{lot}     
    \newpage
}
% Ensure double-spacing between entries
\renewcommand*\l@table{\par\addvspace{\bigskipamount}\pagebreak[2]
 \@dottedtocline{1}{1.5em}{2.3em}}
%}}}

\usepackage{listings}		% code listings

%{{{ List of Listings
% LoL should be single-spaced within entries and double-spaced between entries
\renewcommand*{\lstlistoflistings}{
    \vskip0pt
    \chapter*{\begin{center} LIST OF LISTINGS  \end{center}}
    \addcontentsline{toc}{chapter}{LIST OF LISTINGS}
    \addvspace{10pt}
    \typeout{!! List of Listings...!!}
    \noindent
    Listing \hfill Page\\         % newline allows us to use a vspace...
    % vspace adjusts spacing to get a doublespace between table headings
    % and table contents
    \vspace{-\baselineskip}
    \@starttoc{lol}     
    \newpage
}
% Ensure double-spacing between entries
\renewcommand*\l@lstlisting{\par\addvspace{\bigskipamount}\pagebreak[2]
 \@dottedtocline{1}{1.5em}{2.3em}}
%}}}

%{{{ List of Figures
% LoF should be single-spaced within entries and double-spaced between entries 
\renewcommand*{\listoffigures}{
    \vskip0pt
    \chapter*{\begin{center} LIST OF FIGURES \end{center}}
    \addcontentsline{toc}{chapter}{LIST OF FIGURES}
    \addtocontents{toc}{\vspace{.5\baselineskip} \noindent CHAPTER}
    \addvspace{10pt} 
    \typeout{!! List of Figures...!!}
    \noindent
    Figure \hfill Page\\         % newline allows us to use a vspace...
    % vspace adjusts spacing to get a doublespace between table headings
    % and table contents
    \vspace{-\baselineskip} 
    \@starttoc{lof}     
    \newpage 
}
% Ensure double-spacing between entries
\renewcommand*\l@figure{\par\addvspace{\bigskipamount}\pagebreak[2]
 \@dottedtocline{1}{1.5em}{2.3em}}
%}}}

%{{{ List of Algorithms
\newcommand*{\listofalgs}{
    \vskip0pt
    \chapter*{\begin{center} List of Algorithms \end{center}}
    \addcontentsline{toc}{chapter}{List of Algorithms}
    \addvspace{10pt} 
    \typeout{!! List of Algorithms...!!}
    \noindent
    Algorithm \hfill Page\\         % newline allows us to use a vspace...
    % vspace adjusts spacing to get a doublespace between table headings
    % and table contents
    \vspace{-\baselineskip}
    \@starttoc{alg}
    \newpage 
}
% Ensure double-spacing between entries
\newcommand*\l@alg{\par\addvspace{\bigskipamount}\pagebreak[2]
 \@dottedtocline{1}{1.5em}{2.3em}}
%}}}

%{{{ Set up a floating algorithm environment
\RequirePackage{float}
\floatstyle{ruled}
\newfloat{alg}{thp}{alg}[chapter]
\floatname{alg}{Algorithm}
%}}}

%{{{ Template for many of the front and back matter environments
\newcommand*{\newfbmatter}[3]
{
    \newenvironment{#1}
    % beginning definition
    {
        \chapter*{\begin{center} #2 \end{center}}
        \addcontentsline{toc}{chapter}{#2}
        \vskip 00pt\par
        % set the line spacing 
        \begin{#3}
    }
    % end definition
    {
        \end{#3}
        \clearpage
    }
}
%}}}

%{{{ Define some frontmatter and backmatter environments
% Public Abstract
\newfbmatter{publicabstract}{PUBLIC ABSTRACT}{doublespacing}
% Acknowledgments
\newfbmatter{acknowledgments}{ACKNOWLEDGMENTS}{doublespacing}  
% Preface
\newfbmatter{preface}{PREFACE}{doublespacing}  
% Notations
\newfbmatter{notation}{NOTATION}{doublespacing}
% Acronyms
\newfbmatter{acronyms}{ACRONYMS}{singlespacing}
% Vita
\newfbmatter{vita}{CURRICULUM VITAE\\~\\}{doublespacing}
%}}}

%{{{{ Proposal page environment
\newenvironment{proposal}
% beginning definition
{
    \newpage
    \null \vskip 26pt  
    \addcontentsline{toc}{chapter}{PROPOSAL}
    \begin{center}
        {\Large \textbf{PROPOSAL}}\\
        % empty line creates required triple space 
        % between 'Proposal' and title
        \ \\
        \begin{doublespace}
            \expandafter{\Ztitle}\\
        \end{doublespace}
            \ \\  % empty line to create required triple space
            by\\
            \ \\  % empty line to create required triple space
        \begin{doublespace}
            \expandafter{\Zauthor}\if@isproposal\else ,  \Zdegree \fi \\
        \end{doublespace}
            Utah State University, {\Zyear}\\
    \end{center}
    \begin{singlespace}  % Make sure that we're single spaced
        \ \\  % empty line to create required triple space
        Major Professor: {\Zmajorprof}\\
        Department: {\Zdepartmentname}\\
    \end{singlespace}
    \begin{doublespace}
}
% end definition
{
    \end{doublespace}
}
%}}}

%{{{{ Abstract page environment
\newenvironment{abstract}
% beginning definition
{
    \newpage
    \null \vskip 26pt  
    \addcontentsline{toc}{chapter}{ABSTRACT}
    \begin{center}
        {ABSTRACT}\\
        % empty line creates required triple space 
        % between 'Abstract' and title
        \ \\
        \begin{doublespace}
            \expandafter{\Ztitle}\\
        \end{doublespace}
            \ \\  % empty line to create required triple space
            by\\
            \ \\  % empty line to create required triple space
        \begin{doublespace}
            \expandafter{\Zauthor}\if@isproposal\else ,  \Zdegree \fi \\
        \end{doublespace}
            Utah State University, {\Zyear}\\
    \end{center}
    \begin{singlespace}  % Make sure that we're single spaced
        \ \\  % empty line to create required triple space
        Major Professor: {\Zmajorprof}\\
        Department: {\Zdepartmentname}\\
    \end{singlespace}
    \begin{doublespace}
}
% end definition
{
    \end{doublespace}
    % place page count at the end of the abstract
    \par \bigskip
    \hfill (\ref{totalpageno} pages)
}
%}}}

%{{{ Dedication page
\newenvironment{dedication}
% begin
{
    \newpage
    \null\vskip 200pt
    \vskip 20pt\par
}
% end  
{
    \clearpage
}
%}}}

%{{{ Title page
\renewcommand*{\maketitle}%
{{
    \thispagestyle{empty}
    \begin{center}
        \null\vskip 1\baselineskip
        \begin{doublespace}  % USU requires doublespace title
            \large\uppercase\expandafter{\Ztitle}\\
            \ \\
            by\\
            \ \\
        \end{doublespace}
        \Zauthor\\[1\baselineskip]
        A \Zdocument\ submitted in partial fulfillment \\
        of the requirements for the degree\\
        \begin{doublespace}
            of\\
            \uppercase\expandafter{\Zdegree\\}
            in\\
            \Zdegreein\\
        \end{doublespace}
    \end{center}
    \begin{flushleft}
    % Approval block
        \ifthenelse{\equal{dissertation}{\@@type}}{%
            % if dissertation then leave room for extra row of
            % committee members in approval block
            \vspace{1\baselineskip}
        }{%
            \vspace{2\baselineskip}
        }
        Approved:
        \null\vskip 2\baselineskip
            
         % first row is common to all
        \rule{2.5in}{1pt} \hspace{0.5in}  \rule{2.5in}{1pt}\\[-3pt]
        \makebox[2.5in][l]{\Zmajorprof} \hspace{0.5in}
        \makebox[2.5in][l]{\Zfirstreader}\\
        \makebox[2.5in][l]{Major Professor} \hspace{0.5in}
        \makebox[2.5in][l]{Committee Member}
        \null\vskip 2\baselineskip

        % PhD committees have 5 members, so we need extra signature
        % lines if this is a dissertation
        \ifthen{\equal{dissertation}{\@@type}}{%
            % middle row
            \rule{2.5in}{1pt} \hspace{0.5in}  \rule{2.5in}{1pt}\\[-3pt]
            \makebox[2.5in][l]{\Zsecondreader} \hspace{0.5in}
            \makebox[2.5in][l]{\Zthirdreader}\\
            \makebox[2.5in][l]{Committee Member} \hspace{0.5in}
            \makebox[2.5in][l]{Committee Member}
            \null\vskip 2\baselineskip
        }
        % Format of the last row of signatures depends on whether or not this
        % is a proposal/report, or a thesis/dissertation (no grad dean signature
        % for the former).
        \if@reportORproposal
             \rule{2.5in}{1pt} \\[-3pt]
             \makebox[2.5in][l]{\Zlastreader}\\
             \makebox[2.5in][l]{Committee Member}
        \else
             \rule{2.5in}{1pt} \hspace{0.5in}  \rule{2.5in}{1pt}\\[-3pt]
             \makebox[2.5in][l]{\Zlastreader} \hspace{0.5in}
             \makebox[2.5in][l]{\Zgraddean}\\
             \makebox[2.5in][l]{Committee Member} \hspace{0.5in}
             \makebox[2.5in][l]{\Zdeantitle}
             \makebox[2.5in]{} \hspace{0.5in} \makebox[2.5in][l]{\Zdeansecondtitle}
        \fi
    \end{flushleft}
    \begin{center}
        \vspace{6mm}
        \vfill
        UTAH STATE UNIVERSITY\\
        Logan, Utah\\
        \begin{doublespace}
            % USU requires doublespace between address and year
            {\Zyear}\\
        \end{doublespace}
   \end{center}
   \clearpage
}}
%}}}

%{{{ Copyright page
\newcommand{\makecopyright}%
{{
   \begin{center}
      \null 
      \vfill
      Copyright \hspace{5pt} \copyright \hspace{5pt} \Zauthor \hspace{5pt} \Zyear \\
      \vskip 14pt
      All Rights Reserved \\
      \vfill
   \end{center}
   \clearpage
}}
%}}}

%{{{ Signature page - I think this is legacy and not used any more
\def\makesignature{\newpage\null\vskip 54pt
    \begin{center} UTAH STATE UNIVERSITY \\[2\baselineskip] \end{center}
    \begin{flushright} {\Zmonth, \Zyear} \end{flushright}
    \par\noindent We hereby recommend that the \Zdocument\
    \uppercase\expandafter{\Ztitle}\ prepared under our supervision by
    \Zauthor\ be accepted as fulfilling in part requirements for the
    degree of \Zdegree.
    \begin{center}
          \vskip 1\baselineskip
          \underline{Committee on Graduate Work} \\[1\baselineskip]
          \rule{3.5in}{1pt}\\[-8pt]
          \makebox[3.5in][l]{Commitee Member}
          \rule{3.5in}{1pt}\\[-8pt]
          \makebox[3.5in][l]{Commitee Member}
          \rule{3.5in}{1pt}\\[-8pt]
          \makebox[3.5in][l]{Commitee Member}
          \rule{3.5in}{1pt}\\[-8pt]
          \makebox[3.5in][l]{Adviser}
          \rule{3.5in}{1pt}\\[-8pt]
          \makebox[3.5in][l]{Department Head}
     \end{center}
}
%}}}

%{{{ Set up float spacing

% These commands control spacing between floats and text.

\setlength{\textfloatsep}{36pt plus 2pt minus 4pt}   % Space between main text and floats
                                                     % at top or bottom of page.

\setlength{\floatsep}{36pt plus 2pt minus 4pt}       % Space between adjacent floats moved
                                                     % to top or bottom of text page.

\setlength{\@fpsep}{36pt plus 2pt minus 4pt}         % This is the vertical spacing between 
                                                     % floatpage floats

\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.8}

%}}}

%{{{ Alter bibliography environment
% Redefine thebibliography such that there is a triple-space between
% the bibliography title and the list of references
\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \vskip \baselineskip
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

%}}}

%{{{ BibTeX references - first parameter is .bib, second is bibstyle
\newcommand{\@@bibname}{REFERENCES}
\renewcommand\bibname{\@@bibname \\}
\newcommand{\references}[2]
{
    \clearpage
    \refstepcounter{chapter}
    \addcontentsline{toc}{chapter}{\@@bibname}
    \begin{doublespace}
        \bibliography{#1}
        \bibliographystyle{#2}
    \end{doublespace}
}
%}}}

%{{{ Appendices
% Provide commands for sub-appendicies
\newcommand{\appendixsection}{\section}
\newcommand{\appendixsubsection}{\subsection}
 
% Set up the appendix section by creating a coversheet and resetting the 
% chapter counters

% Use this if there is only one appendix
\newcommand{\makeappendix}
{
    \clearpage
    % Create 'Appendix' page, and add to TOC
    \refstepcounter{chapter}
    \null\vfil
    \begin{center}
        {\Large\textbf{APPENDIX}}
    \end{center}
    \addcontentsline{toc}{chapter}{Appendix} 
    \vfil\clearpage
    %update labeling macros
    \renewcommand{\thechapter}{A}%
    \renewcommand{\thesection}{\thechapter.\@arabic\c@section}
    \renewcommand{\thesubsection}{\thesection.\@arabic\c@subsection}
}

% Use this, and the redefined \appendix, when creating multiple appendices
\newcommand{\makeappendices}
{
    \clearpage
    % Create 'Appendices' page, and add to TOC
    \refstepcounter{chapter}
    \null\vfil
    \begin{center}
        {\Large\textbf{APPENDICES}}
    \end{center}
    \addcontentsline{toc}{chapter}{APPENDICES} 
    \vfil\clearpage
    % reset counters manually as the automatic reset has been
    % circumvented
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
    \setcounter{subsection}{0}%
    \setcounter{subsubsection}{0}%
    \renewcommand{\@chapapp}{Appendix}%
    % Change the recursive labeling to skip over the section level.
    % Because the appendix resides at the section level, the logical section
    % and sub section must be bumped down for the correct TOC, etc apperance 
    \renewcommand{\thechapter}{\Alph{chapter}}
    \renewcommand{\thesubsection}{\thechapter.\@arabic\c@subsection}
    \renewcommand{\thesubsubsection}{\thesubsection .\@arabic\c@subsubsection}
    % Define a chapter-like command for creating appendices
    %update sub appendicies commands to call the appropriate level of subsection
    \renewcommand{\appendixsection}{\subsection}
    \renewcommand{\appendixsubsection}{\subsubsection}
}

% Note that this command inserts individual appendices into the table of
% contents as sections under the appendices heading
\renewcommand{\appendix}[1]
{
    \clearpage
    \refstepcounter{chapter}
    \setcounter{subsection}{0}%
    \setcounter{subsubsection}{0}%
    \@makechapterhead{#1}
    \addcontentsline{toc}{section}{\@chapapp{} \thechapter\hspace{12pt} #1} 
}

%}}}

%{{{ Set up chapter headings

%{{{ Tweak base class chapter setting slightly
% This is a bit of a hack, but seems to work...
% Redefine \@chapter so that we don't get spurious blank lines
% when the chapter changes in the LoT and LoF
% 

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    % Following 2 lines commented out to remove the
                    % extra lines that were being inserted into the
                    % LoT and LoF
                    %\addtocontents{lof}{\protect\addvspace{10\p@}}%
                    %\addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
%}}}

\def\@chapapp{CHAPTER}
%{{{ Heading for \chapter command (includes chapter number)
\def\@makechapterhead#1{             
    \vspace*{25pt}                          % Space at top of text page.
    { 
        \parindent 0pt \leftskip=0pt plus 1filll \rightskip=\leftskip
        \@chapapp{} \thechapter  % 'Chapter' and number.
        \par
                                        % Title.
        #1\par
        \nobreak                            % TeX penalty to prevent page break.
        \vskip 0.5\baselineskip            % Space between title and text.
    } 
}
%}}}
%{{{ % Heading for \chapter* command (no chapter number)
\def\@makeschapterhead#1{               
    \vspace*{10pt}                         % Space at top of page.
    { 
        \parindent 0pt \leftskip=0pt plus 1filll \rightskip=\leftskip
                                        % Title.
        #1\par
        \nobreak                           % TeX penalty to prevent page break.
        \vskip 0.1pt plus 0pt minus 0pt    % Space between title and text.
    }  
}
%}}}

\def\@afterheading{} % Allow indenting after headings.
%}}}

%{{{ Define section heading styles
\def\chapter{\clearpage  \global\@topnum\z@ \@afterindentfalse \secdef\@chapter\@schapter}
\def\section{\@startsection {section}{1}{\z@}
    {4.20ex}{0.04ex}{\normalsize\bf}}  
\def\subsection{\@startsection{subsection}{2}{\z@}
    {4.20ex}{0.04ex}{\normalsize\bf}}  
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}
    {4.20ex}{0.04ex}{\normalsize\bf}}  
% \def\paragraph{\@startsection{paragraph}{4}{\z@}
    % {4.20ex}{0.04ex}{\normalsize\bf}}  
% \def\paragraph{\@startsection
     % {paragraph}{4}{\parindent}{3.25ex plus 1ex minus .2ex}{-1em}{\normalsize\bf}}
\def\paragraph#1{
     \@startsection {paragraph}{4}{\parindent}{\z@}{-1em}{\normalsize\bf}
     {#1.}
     }
\def\subparagraph{\@startsection
     {subparagraph}{4}{\parindent}{3.25ex plus 1ex minus
     .2ex}{-1em}{\normalsize\bf}}  
%}}}

%{{{ Adjust TOC layout

% This command is used in "\l@chapter".
\def\mydotfill{\cleaders\hbox{$\m@th \mkern2.9mu . \mkern2.9mu$}\hfill}

\def\l@chapter#1#2{%
    \pagebreak[3]
    \vskip .75em plus 1pt \@tempdima 1.5em 
    \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \leavevmode #1\mydotfill \hbox to\@pnumwidth{\hss #2}
        \par
    \endgroup
    \vskip .75em plus 1pt \@tempdima 1.5em 
}

%{{{ Adjust the spacing between entries in the tables of contents
\def\@dottedtoclinelo#1#2#3#4#5{\ifnum #1>\c@tocdepth \else
  \vskip \z@ \@plus.2\p@
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode
   \@tempdima #3\relax
   \advance\leftskip \@tempdima \hbox{}\hskip -\leftskip
    {#4}\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep
       mu$}\hfill \nobreak
        \hbox to\@pnumwidth{\hfil\reset@font\rmfamily #5} \vskip 12pt}\fi}
%}}}
%}}}

%{{{ Include some other packages
\RequirePackage{cite}
\RequirePackage{url}
%}}}

%{{{ This redefines how notes are seperated from the citation.
\renewcommand\citemid{:}  % semicolon before optional note
                          % notes, in our case, will usually be
                          % a page number for a cite
%}}}

%{{{ Once we're done with everything else, count total number of pages 
\AtEndDocument{%
    % A hack to get the total number of pages for the abstract pager 
    % First ensure we've finished paginating
    \clearpage%
    % Find the number of mainmatter pages. Since clearpage
    % steps the page counter we need to subtract off 1 page to get the
    % correct mainmatter count
    \setcounter{savemainpageno}{\value{page}}%
    \addtocounter{savemainpageno}{-1}%
    % Add together the mainmatter page count and frontmatter to page count
    % to get a total page count
    \setcounter{savetotalpageno}{\value{savemainpageno}}%
    \addtocounter{savetotalpageno}{\value{savefrontpageno}}%
    % Write page count to the aux file as a label, which can then
    % be referred to on the abstract page 
    \immediate\write\@mainaux{\string\newlabel{totalpageno}{{\number\value{savetotalpageno}}{\number\value{savetotalpageno}}{}{}{}}}%
}
%}}}

%{{{ Obsolete commands 
\newcommand{\gettotalpages}{%
    % We don't use this command any more. The command definition is left
    % in for purposes of backwards compatibility with older thesis.tex files.
    \IW{}
    \IW{Warning: the command 'gettotalpages' doesn't do anything anymore!}
    \IW{         You can remove it from your thesis.tex file.}
    \IW{}
}
%}}}
%}}}
\endinput
%%
%% End of file 'usuthesis.cls'.
