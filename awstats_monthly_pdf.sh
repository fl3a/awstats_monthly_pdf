#!/bin/bash

# Generate awstats pdf on last day of month 
# and send  the pdf as attachment via email (mailx).
# See https://github.com/fl3a/awstats_monthly_pdf

set -o nounset
set -o errexit

# Exit when today + 1 day not equals 1, 
# which means today is not the last day in the month
[ $(date -d +1day +%d) -ne 1 ] && exit 

# AWStatst
buildstaticpages="${HOME}/bin/awstats/tools/awstats_buildstaticpages.pl"
domain="florian.latzel.io"
config="awstats.florian.latzel.io.conf"
awstats="${HOME}/bin/awstats/wwwroot/cgi-bin/awstats.pl"
lang="de"
dir="${HOME}/html"
htmldoc="${HOME}/bin/htmldoc"

# Mail
date=`date +%Y-%m`
subject="Statistik für ${domain} (${date})"
pdf="${dir}/awstats.${domain}-${date}.pdf"
email="florian@latzel.io"

perl $buildstaticpages \
	-config=$domain \
	-output -staticlinks \
	-awstatsprog=$awstats \
	-lang=$lang \
	-dir=$dir \
	-buildpdf=$htmldoc 
mv ${dir}/awstats.${domain}.pdf $pdf 
echo "$subject" | mailx -s "$subject" -a $pdf $email 
rm  $pdf
