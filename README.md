# awstats_monthly_pdf

Generates a pdf version of an AWStats report and send it via mail 
on the last day of the month.

## Cronjob 

Since `L` for last day of month is no standard cron option, 
we need specify a range of possible last days. 

```
55 23  28-31 * * /path/to/awstats_monthly_pdf.sh > /dev/null 2>&1
```

The check if today is the last day of the month is done within this line  
`[ $(date -d +1day +%d) -ne 1 ] && exit` in the script.

## Requirements

This script requires:

- [awstats](https://www.awstats.org/)
- mailx
- [htmldoc](https://www.msweet.org/htmldoc/)
