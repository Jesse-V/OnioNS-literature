#!/bin/bash

rm -f thesis.aux thesis.bbl thesis.blg thesis.lof thesis.log thesis.out thesis.synctex.gz thesis.toc
rm -f conference/acm-ccs.aux conference/acm-ccs.bbl conference/acm-ccs.blg conference/acm-ccs.lof conference/acm-ccs.log conference/acm-ccs.out conference/acm-ccs.synctex.gz conference/acm-ccs.toc

rm -f doc/*.aux conference/*.aux
rm -f doc/*.log conference/*.log

rm -f *.tex.bak conference/*.bak
rm -f doc/*.tex.bak conference/*.bak
