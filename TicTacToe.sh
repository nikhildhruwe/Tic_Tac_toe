#!/bin/bash -x

echo -e "       Welcome to Tic-Tac-Toe game.\n"

row=3
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
resetBoard
