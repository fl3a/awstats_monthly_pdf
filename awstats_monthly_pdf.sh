#!/bin/bash

# Generate awstats pdf on last day of month 
# and send  the pdf as attachment via email (mailx).
# See https://github.com/fl3a/awstats_monthly_pdf

set -o nounset
set -o errexit

# Exit when today + 1 day not equals 1, 
# which means today is not the last day in the month
[ $(date -d +1day +%d) -ne 1 ] && exit 

buildstaticpages="/home/kdoz/bin/awstats-7.8/tools/awstats_buildstaticpages.pl"
domain="florian.latzel.io"
config="awstats.florian.latzel.io.conf"
awstats="/home/kdoz/bin/awstats-7.8/wwwroot/cgi-bin/awstats.pl"
lang="de"
dir="/home/kdoz/html"
htmldoc="/home/kdoz/bin/htmldoc"

subject="Statistik für $domain (`date +%Y.%m`)"
pdf="${dir}/awstats.${domain}.pdf"
email="florian@latzel.io"

perl $buildstaticpages -config=$domain -output -staticlinks \
	-awstatsprog=$awstats -lang=$lang -dir=$dir -buildpdf=$htmldoc 
echo "$subject" | mailx -s "$subject" -a $pdf $email 
rm  $pdf
