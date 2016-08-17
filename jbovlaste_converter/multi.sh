#!/bin/bash

mkdir -p gismu-cmavo
mkdir -p temp
mkdir -p stardict
rm stardict/*.tar.gz
mkdir -p kindle
# rafsi-jbo
sh/rafsi.sh 
mkdir -p stardict/rafsi-jbo 
cp temp/rafsi00tab1 stardict/rafsi-jbo/rafsi-jbo 
cd stardict/rafsi-jbo 
tabfile rafsi-jbo 
cd - 
mv stardict/rafsi-jbo/rafsi-jbo temp/rafsi-jbo.txt 
tar cvfz stardict/rafsi-jbo-`date +%Y%m%d`.tar.gz stardict/rafsi-jbo
# vlaste
for i in xml/*.xml 
do 
	cat $i | sh/stika.sh 
	bangu_iso=`echo $i | sed -e 's/\.xml//' | sed -e 's/xml\///'`
	mv temp/gimste "gismu-cmavo/"$bangu_iso"-gimste.html" 
	mv temp/mahoste "gismu-cmavo/"$bangu_iso"-mahoste.html" 
	mv temp/gimste.tsv "gismu-cmavo/"$bangu_iso"-gimste.tsv" 
	mv temp/mahoste.tsv "gismu-cmavo/"$bangu_iso"-mahoste.tsv" 
	mkdir -p "stardict/jbo-"$bangu_iso 
	sed -f sh/lai-sed5quot < temp/vlaste > "stardict/jbo-"$bangu_iso"/jbo-"$bangu_iso 
	mv temp/vlaste "temp/jbo-"$bangu_iso".txt" 
	cd "stardict/jbo-"$bangu_iso 
	tabfile "jbo-"$bangu_iso 
	rm "jbo-"$bangu_iso 
	cd - 
	tar cvfz "stardict/jbo-"$bangu_iso"-"`date +%Y%m%d`".tar.gz" "stardict/jbo-"$bangu_iso
done
# jorne
for i in xml/*.xml 
do
	bangu_iso=`echo $i | sed -e 's/\.xml//' | sed -e 's/xml\///'`
	if [ $bangu_iso != "eng" -a $bangu_iso != "jbo" ]
	then 
		cat temp/jbo-jbo.txt "temp/jbo-"$bangu_iso".txt" temp/jbo-eng.txt temp/rafsi-jbo.txt > temp/temp 
		mkdir -p "stardict/jbo-"$bangu_iso"-eng-rafsi" 
		sed -f sh/lai-sed5quot < temp/temp > "stardict/jbo-"$bangu_iso"-eng-rafsi/jbo-"$bangu_iso"-eng-rafsi" 
		cd "stardict/jbo-"$bangu_iso"-eng-rafsi" 
		tabfile "jbo-"$bangu_iso"-eng-rafsi" 
		cd - 
		mv "stardict/jbo-"$bangu_iso"-eng-rafsi/jbo-"$bangu_iso"-eng-rafsi" "temp/jbo-"$bangu_iso"-eng-rafsi.txt" 
		tar cvfz "stardict/jbo-"$bangu_iso"-eng-rafsi-"`date +%Y%m%d`".tar.gz" "stardict/jbo-"$bangu_iso"-eng-rafsi"
	elif [ "$bangu_iso" = "eng" ]
	then
		cat temp/jbo-jbo.txt temp/jbo-eng.txt temp/rafsi-jbo.txt > temp/temp 
		mkdir -p "stardict/jbo-eng-rafsi" 
		sed -f sh/lai-sed5quot < temp/temp > "stardict/jbo-eng-rafsi/jbo-eng-rafsi" 
		cd "stardict/jbo-eng-rafsi" 
		tabfile "jbo-eng-rafsi" 
		cd - 
		mv "stardict/jbo-eng-rafsi/jbo-eng-rafsi" "temp/jbo-eng-rafsi.txt" 
		tar cvfz "stardict/jbo-eng-rafsi-"`date +%Y%m%d`".tar.gz" "stardict/jbo-eng-rafsi"
	else
		cat temp/jbo-jbo.txt temp/rafsi-jbo.txt > temp/temp 
		mkdir -p "stardict/jbo-rafsi" 
		sed -f sh/lai-sed5quot < temp/temp > "stardict/jbo-rafsi/jbo-rafsi" 
		cd "stardict/jbo-rafsi" 
		tabfile "jbo-rafsi" 
		cd - 
		mv "stardict/jbo-rafsi/jbo-rafsi" "temp/jbo-rafsi.txt" 
		tar cvfz "stardict/jbo-rafsi-"`date +%Y%m%d`".tar.gz" "stardict/jbo-rafsi"
	fi
# romazi
	if [ $bangu_iso = "jpn" ]
	then
		mkdir -p stardict/romazi-jbo 
		sed -f sh/lai-sed5quot < temp/romazi-jbo.txt > stardict/romazi-jbo/romazi-jbo 
		cd stardict/romazi-jbo 
		tabfile romazi-jbo 
		rm romazi-jbo 
		cd - 
		tar cvfz stardict/romazi-jbo-`date +%Y%m%d`.tar.gz stardict/romazi-jbo 
		cat temp/jbo-jbo.txt temp/jbo-jpn.txt temp/jbo-eng.txt temp/rafsi-jbo.txt temp/romazi-jbo.txt > temp/temp 
		mkdir -p stardict/jbo-jpn-eng-rafsi-romazi 
		sed -f sh/lai-sed5quot < temp/temp > stardict/jbo-jpn-eng-rafsi-romazi/jbo-jpn-eng-rafsi-romazi 
		cd stardict/jbo-jpn-eng-rafsi-romazi 
		tabfile jbo-jpn-eng-rafsi-romazi 
		cd - 
		mv stardict/jbo-jpn-eng-rafsi-romazi/jbo-jpn-eng-rafsi-romazi temp/jbo-jpn-eng-rafsi-romazi.txt 
		tar cvfz stardict/jbo-jpn-eng-rafsi-romazi-`date +%Y%m%d`.tar.gz stardict/jbo-jpn-eng-rafsi-romazi
	fi
done
rm temp/temp
# kindle
# cd temp
# cat jbo-jbo.txt jbo-fra.txt jbo-frafacile.txt jbo-jpn.txt jbo-eng.txt rafsi-jbo.txt romazi-jbo.txt > jbo-fra-frafacile-jpn-eng-rafsi-romazi.txt 
# sed -f ../sh/lai-sed4 jbo-fra-frafacile-jpn-eng-rafsi-romazi.txt > vlaste-kindle 
# tab2opf.py -utf vlaste-kindle 
# kindlegen vlaste-kindle.opf
# cd -
# cp temp/vlaste-kindle.mobi kindle/lojban`date +%Y%m%d`.mobi
