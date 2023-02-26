#!/bin/bash

#if [ $(date -d +1day +%d) -eq 1 ]; then
if [ true ]; then
	perl /home/kdoz/bin/awstats-7.8/tools/awstats_buildstaticpages.pl \
		-config=florian.latzel.io -output -staticlinks \
		-awstatsprog=/home/kdoz/bin/awstats-7.8/wwwroot/cgi-bin/awstats.pl \
		-lang=de -dir=/home/kdoz/html -buildpdf=/home/kdoz/bin/htmldoc && \
	echo "AWStats Bericht `date +%Y.%m`" |  \
	mailx -s "AWStats montly" \
		-a /home/kdoz/html/awstats.florian.latzel.io.pdf florian@latzel.io && \
	rm /home/kdoz/html/awstats.florian.latzel.io.pdf
fi

