#!/bin/bash

PrintMovieData() {
    movie_id_=$1 ; item=$2
    cat $item | awk -F\| '{if ($1 == movie_id_) { print $0 }}'
}

PrintActionMovies() {
    item=$1
    cat $item | awk -F\| '{if ($7 == 1) { print $1, $2 } }' | head -n 10
}

PrintAverageRate() {
    movie_id_=$1 ; data=$2
    rate_=$(cat $data | awk -F\| -v movie_id="$movie_id_" '{if ($2 == movie_id) { sum += $3 ; num++ }} END { printf "%.6f", sum/num }')
    echo "average rating of $movie_id_ : $rate_"
}

PrintnIMDbURL() {
    item=$1
    cat $item | awk -F\| '{ $5 = "" ; print $0 }}' | head -n 10
}

PrintUserData() {
    user=$1
    cat $user | awk -F\| '{ print "user " $1 " is " $2 " years old " $3 $4}}' | head -n 10
}

PrintModifyDate() {
    item=$1
    sed -E -i 's/^([^|]*\|[^|]*\|)([0-9]{2}-[A-Za-z]{3}-[0-9]{4})(.*)$/\1\3\2/' "$item"
    sed -E -i 's/([0-9]{2})-(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-([0-9]{4})/\3\2\1/' "$item"
    tail -n 10 "$item"
}

PrintUserRated() {
    user_id_=$1 ; data=$2 ; item=$3
    ratedlist=$(cat $data | awk -F\| -v user_id="$user_id_" '{if ($1 == user_id_) {print $2}}' | sort -n)
    echo "$ratedlist" | tr '\n' '|'
    echo ""
    toplist=$(echo "$ratedlist" | tr "|" '\n' | head -n 10)
    cat $item | awk -F\| -v toplist="$toplist" '$1 ~ ("^" toplist "$") {print $1 "|" $2 }'
}

PrintSpecAverageRates() {
    user=$1 ; data=$1
    awk -F \| '
    
    '
}

sel="0"
u_item="u.item" ; u_data="u.data" ; u_user="u.user"

echo "--------------------------"
echo "User Name: Jiyoujin"
echo "Student Number: 12224435"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'"
echo "4. Delete the 'IMDb URL' from 'u.item'"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "--------------------------"

until [ $sel = "9" ]
do
        clear
        read -p "Enter your choice [ 1-9 ] " choice
        case $choice in
            1)
                echo ""
                echo "Please enter 'movie id'(1~1682):"
                read movie_id_
                PrintMovieData "$movie_id_" "$u_item"
                echo ""
                ;;
            2)
                echo ""
                echo "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n):"
                read agree_
                if [ "$agree_" = "y" ]
                then PrintActionMovies "$u_item" ; echo ""
                elif [ "$agree_" = "n" ]
                then echo "canceled." ; echo ""
                else
                echo "wrong commands." ; echo ""
                fi
                ;;
	        3)
                echo ""
                echo "Please enter the 'movie id'(1~1682):"
                read movie_id_
                PrintAverageRate "$movie_id_" "$u_data"
                echo ""
                ;;
            4)
                echo ""
                echo "Do you want to delete the 'IDMb URL' from 'u.item'?(y/n):"
                read agree_
                if [ "$agree_" = "y" ]
                then PrintnIDMbURL "$u_item" ; echo ""
                elif [ "$agree_" = "n" ]
                then echo "canceled." ; echo ""
                else
                echo "wrong commands." ; echo ""
                fi
                ;;
            5)
                echo ""
                echo "Do you want to get the data about users from 'u.user'?(y/n):"
                read agree_
                if [ "$agree_" = "y" ]
                then PrintUserData "$u_user" ; echo ""
                elif [ "$agree_" = "n" ]
                then echo "canceled." ; echo ""
                else
                echo "wrong commands." ; echo ""
                fi
                ;;
 	        6)
                echo ""
                echo "Do you want to Modify the format of 'release data' in 'u.item'?(y/n):"
                read agree_
                if [ "$agree_" = "y" ]
                then PrintModifyDate "$u_item" ; echo ""
                elif [ "$agree_" = "n" ]
                then echo "canceled." ; echo ""
                else
                echo "wrong commands." ; echo ""
                fi
                ;;
            7)
                echo ""
                echo "Please enter the 'user id'(1~943):"
                read user_id_
                PrintUserRated "$user_id_" "$u_data" "$u_item"
                echo ""
                ;;
            8)
                echo ""
                echo "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n):"
                read agree_
                if [ "$agree_" = "y" ]
                then PrintSpecAverageRates "$u_user" "$u_data" ; echo ""
                elif [ "$agree_" = "n" ]
                then echo "canceled." ; echo ""
                else
                echo "wrong commands." ; echo ""
                fi
                ;;
            9)
                echo "Bye!"
                sel="9"
                ;;
            *)
                echo "Invalid choice." ; echo ""
                ;;
        esac
done