#!/bin/bash

# Exit when today + 1 day not equals 1, 
# which means today is not the last day in the month
[ $(date -d +1day +%d) -ne 1 ] && exit 0

# Generate pdf
perl /home/kdoz/bin/awstats-7.8/tools/awstats_buildstaticpages.pl \
	-config=florian.latzel.io -output -staticlinks \
	-awstatsprog=/home/kdoz/bin/awstats-7.8/wwwroot/cgi-bin/awstats.pl \
	-lang=de -dir=/home/kdoz/html -buildpdf=/home/kdoz/bin/htmldoc && \
# Send pdf via mail
echo "AWStats Bericht `date +%Y.%m`" |  \
mailx -s "AWStats montly" \
	-a /home/kdoz/html/awstats.florian.latzel.io.pdf florian@latzel.io && \
rm /home/kdoz/html/awstats.florian.latzel.io.pdf

