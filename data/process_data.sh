if [ $# -ge 2 ]
then
	cat $1 \
		| awk 'NR % 12 == 1' \
		| tr -s '[:blank:]' ',' \
		| cut -d "," -f "1,2,3,12,13,14,15,23,27" - \
		| grep -v "999" > tmp
	node convertJson.js tmp $2
	rm tmp
else
	echo "KO"
fi