GT="gt.annotated"
OCR="ocr.annotated"
SEMI="gt.semi-manually-annotated"

# make train and test sets (LOC and PER)
head -n 181456 $GT.csv | cut -f 1,2 > train.gt.csv # first 136 pages
head -n 211134 $SEMI.csv | cut -f 1,2 >> train.gt.csv # 101 pages

tail -n +181458 $GT.csv | cut -f 1,2 > test.gt.csv # last 34/170 pages
tail -n +172999 $OCR.csv | cut -f 1,2 > test.ocr.csv # last 34/170 pages

# train
#rm gt-loc-per-model.ser.gz
#Make gt-loc-per-model.ser.gz

# predict
#java -cp ../../../Downloads/stanford-ner-2016-10-31/stanford-ner.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier gt-loc-per-model.ser.gz -testFile test.gt.csv > gt+gt-loc-per.log
#java -cp ../../../Downloads/stanford-ner-2016-10-31/stanford-ner.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier gt-loc-per-model.ser.gz -testFile test.ocr.csv > gt+ocr-loc-per.log
 
 

# make train and test sets (ORG) with PER AND LOC
head -n 181456 $GT.csv | cut -f 1,2,3 > train.gt.csv 
head -n 200000 $SEMI.csv | cut -f 1,2,3 >> train.gt.csv

cut -f 1,3 gt+gt-loc-per.log > temp1.gt
cut -f 1,3 gt+ocr-loc-per.log > temp1.ocr

tail -n +181458 $GT.csv | cut -f 3 > temp2.gt # last 34/170 pages
tail -n +172999 $OCR.csv | cut -f 3 > temp2.ocr # last 34/170 pages

paste temp1.gt temp2.gt > test.gt.csv
paste temp1.ocr temp2.ocr > test.ocr.csv

# train
#rm gt-org-model.ser.gz
#Make gt-org-model.ser.gz

# predict
#java -cp ../../../Downloads/stanford-ner-2016-10-31/stanford-ner.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier gt-org-model.ser.gz -testFile test.gt.csv > gt+gt-org.log
#java -cp ../../../Downloads/stanford-ner-2016-10-31/stanford-ner.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier gt-org-model.ser.gz -testFile test.ocr.csv > gt+ocr-org.log
 


# make train and test sets (ORG) without PER AND LOC
head -n 181456 $GT.csv | cut -f 1,3 > train.gt.csv 
head -n 200000 gt.semi-manually-annotated.csv | cut -f 1,3 >> train.gt.csv

tail -n +181458 $GT.csv | cut -f 1,3 > test.gt.csv # last 34/170 pages
tail -n +172999 $OCR.csv | cut -f 1,3 > test.ocr.csv # last 34/170 pages

# train

#rm gt-model.ser.gz
#Make gt-model.ser.gz

# tag
#java -cp ../../../Downloads/stanford-ner-2016-10-31/stanford-ner.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier gt-model.ser.gz -testFile test.gt.csv > gt+gt-org.log
#java -cp ../../../Downloads/stanford-ner-2016-10-31/stanford-ner.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier gt-model.ser.gz -testFile test.ocr.csv > gt+ocr-org.log
 

# evaluate with my scripts
tail -n +181458 $GT.csv | cut -f 1,2,3 > test.gt.csv # last 34/170 pages

tail -n +172999 $OCR.csv | cut -f 1,2 > temp1 # last 34/170 pages
tail -n +172999 $OCR.csv | cut -f 2 > temp2 # last 34/170 pages
paste temp1 temp2 > ocr-loc-per.log
tail -n +172999 $OCR.csv | cut -f 1,3 > temp1 # last 34/170 pages
tail -n +172999 $OCR.csv | cut -f 3 > temp2 # last 34/170 pages
paste temp1 temp2 > ocr-org.log

echo
echo "evaluation: GT" 
cat gt+gt-loc-per.log gt+gt-org.log | python3 evaluate-gt.py
echo
echo "evaluation: effect of OCR" 
cat ocr-loc-per.log ocr-org.log | python3 evaluate-ocr.py test.gt.csv
echo
echo "evaluation: effect of OCR and NER system" 
cat gt+ocr-loc-per.log gt+ocr-org.log | python3 evaluate-ocr.py test.gt.csv

# remove temps
rm temp1.gt
rm temp1.ocr
rm temp2.gt
rm temp2.ocr
rm temp1
rm temp2



# counts from all data
echo
echo "counts from all GT data (LOC, PER, ORG)"
grep "B-LOC" $GT.csv | wc -l
grep "B-PER" $GT.csv | wc -l
grep "B-ORG" $GT.csv | wc -l
echo "counts from all GT+SEMI data (LOC, PER, ORG)"
grep "B-LOC" $GT.csv $SEMI.csv | wc -l
grep "B-PER" $GT.csv $SEMI.csv | wc -l
grep "B-ORG" $GT.csv $SEMI.csv | wc -l
echo "counts from all OCR data (LOC, PER, ORG)"
grep "B-LOC" $OCR.csv | wc -l
grep "B-PER" $OCR.csv | wc -l
grep "B-ORG" $OCR.csv | wc -l



# counts from test data
tail -n +181458 $GT.csv | cut -f 1,2,3 > test.gt.csv # last 34/170 pages
tail -n +172999 $OCR.csv | cut -f 1,2,3 > test.ocr.csv # last 34/170 pages
echo
echo "counts from test GT data (LOC, PER, ORG)"
grep "B-LOC" test.gt.csv | wc -l
grep "B-PER" test.gt.csv | wc -l
grep "B-ORG" test.gt.csv | wc -l
echo
echo "counts from test OCR data (LOC, PER, ORG)"
grep "B-LOC" test.ocr.csv | wc -l
grep "B-PER" test.ocr.csv | wc -l
grep "B-ORG" test.ocr.csv | wc -l









# =======================================================================================================================


# make gt.csv

#head -n 250424 groundtruth6.csv | grep "<FILENAME>" | cut -f 2 > filenames
#head -n 250424 groundtruth6.csv | sed -e "s/<FILENAME>.*//g" | python3 remove_special_chars.py | tail -n +2 > gt.csv 


# make ocr.csv

#python3 make_ocr_csv.py | python3 remove_special_chars.py | cut -f 1 | python3 tokenize1.py | python3 tokenize2.py| python3 add_O.py > ocr.words.csv

# opeta stanford train.gt:llä

#Make gt-model.ser.gz

# käytä train.gt-stanfordia ocr.csv:ään
#cat ocr.words.csv | sed -e "s/FILENAME.*//g" > tmp
#java -cp ../../../../Downloads/stanford-ner-2016-10-31/stanford-ner.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier gt-model.ser.gz -testFile tmp > tmp2
#cut -f 1,3 tmp2 > ocr.csv
#rm tmp tmp2





