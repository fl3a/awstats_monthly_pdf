#!/bin/bash

# Generate awstats pdf on last day of month 
# and send  the pdf as attachment via email

# Exit when today + 1 day not equals 1, 
# which means today is not the last day in the month
[ $(date -d +1day +%d) -ne 1 ] && exit 0

set -x
set -e

buildstaticpages="/home/kdoz/bin/awstats-7.8/tools/awstats_buildstaticpages.pl"
awstats="/home/kdoz/bin/awstats-7.8/wwwroot/cgi-bin/awstats.pl"
domain="florian.latzel.io"
dir="/home/kdoz/html"
htmldoc="/home/kdoz/bin/htmldoc"

email="florian@latzel.io"
subject="AWStats monthly report `date +%Y.%m` for $domain"
pdf="${dir}/awstats.${domain}.pdf"

perl $buildstaticpages -config=$domain -output -staticlinks \
	-awstatsprog=$awstats -lang=de -dir=$dir -buildpdf=$htmldoc && \
echo "$subject" | mailx -s "$subject" -a $pdf $email && \
rm  $pdf
