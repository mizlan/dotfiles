# query firefox history

cp places.sqlite pog.sqlite
{
sqlite3 -separator $'\t' pog.sqlite <<EOF
select url, title
 from moz_places
 where title like "%$1%" or url like "%$1%";
EOF
} | fzf | cut -f 1 | xargs open
