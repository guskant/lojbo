#!/bin/bash

LF=$(printf '\\\012_')
LF=${LF%_}

tr "\n" " " > temp/temp0
cd temp
bangu_cmene=`sed -e 's/^.*<direction from="lojban" to="//' -e 's/">.*$//' < temp0`
echo $bangu_cmene
#vlaste
cat temp0 | tr "\r" " " > temp1
cat temp1 | sed -e 's/<valsi /'"$LF"'<valsi /g' > temp2
cat temp2 | sed -e '/xml version/d' > temp3
cat temp3 | sed -e 's/<nlword word=/'"$LF"'<nlword word=/g'  > temp4
echo "" >> temp4
csplit temp4 '/<nlword word=/' {0}
sed -f ../sh/lai-sed0 < xx00 > vlaste00tab
sed -f ../sh/lai-sed1 < xx01 > vlaste01tab
if  [ $bangu_cmene = "日本語" ]
then
nkf -eW vlaste01tab > nkf.out
kakasi -Ja -Ha -Ka -Ea -rkunrei < nkf.out > romazi-jbo.txt
fi
#gimste
sed -f ../sh/lai-sed0gismu < xx00 > tempgismu
sed -f ../sh/lai-sed5quot < tempgismu > gimste.tsv
sed -e 's/ *\t\+/	/g' < tempgismu > temp18
sed -e 's/\t\+/	/g' < temp18 > temp19
sed -e 's/\texperimental gismu\t/ [experimental]	/g' < temp19 > temp20
sed -e 's/\tgismu\t/	/g' < temp20 > temp21
sed -e 's/\t/<br \/>/g' < temp21 > temp22
sed -e 'a\<\/p><p>' < temp22 > temp23
if  [ $bangu_cmene = "lojban" ]
then
	echo "gimste bau la "$bangu_cmene" ji'u la <a href='http://jbovlaste.lojban.org'>jbovlaste</a> de'i li " > name
else
	echo "gimste bau la'o by "$bangu_cmene" by ji'u la <a href='http://jbovlaste.lojban.org'>jbovlaste</a> de'i li " > name
fi
echo `date +%Y-%m-%d` >> name
echo `cat name` > html_header2
echo "</title></head><body><h3>" >> html_header2
echo `cat name` >> html_header2
echo "</h3><p>" >> html_header2
cat ../lib/html_header1 html_header2 temp23 ../lib/html_footer > gimste
#ma'oste
sed -f ../sh/lai-sed0cmavo < xx00 > tempcmavo
sed -f ../sh/lai-sed5quot < tempcmavo > mahoste.tsv
sed -e 's/ *\t\+/	/g' < tempcmavo > temp117
sed -e 's/\t\+/	/g' < temp117 > temp118
sed -e 's/\texperimental cmavo\t/ [experimental]	/g' < temp118 > temp119
sed -e 's/\tcmavo-compound\t/	/g' < temp119 > temp120
sed -e 's/\tcmavo\t/	/g' < temp120 > temp121
sed -e 's/\t/<br \/>/g' < temp121 > temp122
sed -e 'a\<\/p><p>' < temp122 > temp123
if  [ $bangu_cmene = "lojban" ]
then
	echo "ma'oste bau la "$bangu_cmene" ji'u la <a href='http://jbovlaste.lojban.org'>jbovlaste</a> de'i li " > name
else
	echo "ma'oste bau la'o by "$bangu_cmene" by ji'u la <a href='http://jbovlaste.lojban.org'>jbovlaste</a> de'i li " > name
fi
echo `date +%Y-%m-%d` >> name
echo `cat name` > html_header2
echo "</title></head><body><h3>" >> html_header2
echo `cat name` >> html_header2
echo "</h3><p>" >> html_header2
cat ../lib/html_header1 html_header2 temp123 ../lib/html_footer > mahoste
#selmaho
awk 'BEGIN { FS = "\t" } ; {print "+"$6"\t"$1"\t"$7"\\n"$8} ' < mahoste.tsv > tempselmaho1
sed -e '/\+\t/d' < tempselmaho1 > tempselmaho2
sed -e 's/      \t/ /' < tempselmaho2 > selmaho00tab
#jorne
cat vlaste00tab selmaho00tab vlaste01tab > vlaste
#clean
rm temp* xx* vlaste00tab vlaste01tab name html_header2
cd -
