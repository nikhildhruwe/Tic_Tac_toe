#!/bin/bash -x

echo -e "\n\tWelcome to Tic-Tac-Toe game.\n"

row=3
function toss(){

	checkToss=$((RANDOM%2))

	if (($checkToss == 1 ))
	then
		echo -e "\nPlayer 1 plays First"
		player1=1
	else
		echo -e "\nComputer plays First"
		player1=0
	fi
}

function resetBoard(){

	board=(1 2 3 4 5 6 7 8 9)
	for (( i=0,j=0;j<$row;i=$(($i+3)),j++ ))
	do
		echo -e "\t${board[i]} | ${board[i+1]} | ${board[i+2]}"
		if (($j!=$(($row-1))))
		then
			echo -e "\t---------"
		fi
	done

}
#****** Main Method *****
resetBoard
toss
