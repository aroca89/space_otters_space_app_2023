if [ $# -ge 2 ]
then
	cat $1 \
		| awk 'NR % 12 == 1' \
		| tr -s '[:blank:]' '\t' \
		| cut -f "1,2,3,12,13,14,15,23,27" - \
		| grep -v "999" > $2
else
	echo "KO"
fi