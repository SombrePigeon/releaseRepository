#!/bin/sh
${TAGS:=$(git ls-remote --refs --tags ${SOURCE} | cut --delimiter='/' --fields=3 | tr '-' '~' | sort --version-sort)}
cd /usr/local/apache2/htdocs/
echo $TAGS
if [ ! -d ".git" ]; then
    echo "Clonage du dépôt $SOURCE..."
    git clone --no-checkout $SOURCE .
else
    echo "Le dépôt a déjà été cloné."
fi

for TAG in $TAGS; do 
	if [ -d "$TAG" ]; then
		echo "Le tag $TAG existe déjà."
	else
		echo "Le tag $TAG n'existe pas."
		echo "Création du tag :"
		git worktree add $TAG
	fi
done 
for dir in */; do
    # Retirer le slash final pour comparer facilement
    dir=${dir%/}

    # Si le dossier n'est pas dans la liste TAG, supprime-le
    if ! echo "$TAGS" | grep -q -w "$dir"; then
        echo "Suppression du tag : $dir"
        git worktree remove $dir
    fi
done

exec "$@"