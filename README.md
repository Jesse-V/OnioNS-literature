The Onion Name System: Tor-Powered Decentralized DNS for Tor Onion Services
======

This repository contains my thesis that I wrote for my Master's in Computer Science at Utah State University. It also contains the academic paper that was recently accepted into the Proceedings on Privacy Enhancing Technologies. The paper will appear in the first issue of the PoPETS 2017 publication.

* [Direct link to the thesis PDF](https://github.com/Jesse-V/OnioNS-literature/raw/master/thesis/thesis.pdf)
* [Direct link to PoPETS 2017.1 pre-print](https://github.com/Jesse-V/OnioNS-literature/raw/master/conference/conference.pdf)

Due to extensive feedback from the peer-reviewers of CSS'15, NDSS'16, PoPETS'16, PoPETS'17, and Tor developers, the paper differs significantly from the original thesis. The main ideas are still there, but many components such as the name registration protocol and the random number beacon went through many iterations.

Compiling the LaTex sources:
======

1. sudo apt-get install texmaker texlive-latex-extra texlive-science texlive-fonts-recommended texlive-font-utils pgf
2. Switch Texmaker's Quick Build to the 2nd option
3. Add "--shell-escape" to the pdfLaTeX command in Configure TexMaker -> Commands.
4. Set the "Run" button to "Quick Build" and then press the Run arrow.
