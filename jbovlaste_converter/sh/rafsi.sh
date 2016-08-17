#!/bin/bash

LF=$(printf '\\\012_')
LF=${LF%_}

cat xml/eng.xml | tr "\n" " " > temp/temp0
cd temp
cat temp0 | tr "\r" " " > temp1
cat temp1 | sed -e 's/<valsi /'"$LF"'<valsi /g' > temp0
cat temp0 | sed -e '/xml version/d' > temp1
cat temp1 | sed -e 's/<nlword word=/'"$LF"'<nlword word=/g'  > temp0
echo "" >> temp0
csplit temp0 '/<nlword word=/' {0}
sed -f ../sh/lai-sed2 < xx00 > rafsi00tab
awk 'BEGIN { FS = "\t" } ; {print $2"\t"$1} ' < rafsi00tab > temp1
awk 'BEGIN { FS = "\t" } ; {print $3"\t"$1} ' < rafsi00tab > temp2
awk 'BEGIN { FS = "\t" } ; {print $4"\t"$1} ' < rafsi00tab > temp3
cat temp1 temp2 temp3 > temp4
sed -e '/^\t/d' < temp4 > temp5
echo "kib-	kibro *" >> temp5
sort -k 1 < temp5 > rafsi00tab1
rm temp* xx*
cd -
