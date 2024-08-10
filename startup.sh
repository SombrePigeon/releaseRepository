#!/bin/sh
TAGS=`git ls-remote --refs --tags ${SOURCE} | cut --delimiter='/' --fields=3 | tr '-' '~' | sort --version-sort`
cd /usr/local/apache2/htdocs/
echo $TAGS
for TAG in $TAGS; do 
	if [ -d "$TAG" ]; then
		echo "Le tag $TAG existe déjà."
	else
		echo "Le tag $TAG n'existe pas."
		echo "Création du tag :"
		git clone -b "$TAG" --single-branch --depth 1 $SOURCE $TAG
		rm -rf $TAG/.*
	fi
done 

exec "$@"