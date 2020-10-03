#!/bin/sh

for entry in `find . -name "*.wrm"`
do
   echo "$entry"
   #count=$(grep "$entry" ./skipfiles)
   #if [ -n "${count}" ]; then
   #   continue; 
   #fi
   while read line; do
      for word in $line; do
         lower=$(echo "${word}" | tr ['A-Z'] ['a-z'])
         alpha=$(echo "${lower}" | sed 's/[a-zA-Z]//g')
         if [ -z "${alpha}" ]; then
            # check against standard word list /usr/share/words
            count=$(look "$lower")
            if [ -z "$count" ]; then
               # check against custom word list
               count=$(look "${lower}" ./ethers.words)
               if [ -z "$count" ]; then
                  echo "$word"
               fi
            fi
         fi
      done
   done < "$entry"
done
