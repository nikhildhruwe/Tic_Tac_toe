#!/bin/bash -x

echo -e "\n   Welcome to Tic-Tac-Toe game.\n"
echo -e "Player vs Computer\n"

row=3
column=3
numberOfShell=$(($row*$column))

function toss(){

	checkToss=$((RANDOM%2))

	if (($checkToss == 1 ))
	then
		echo -e "\nPlayer 1 plays First\n"
		playerChance=1
	else
		echo -e "\nComputer plays First\n"
		playerChance=0
	fi
}

function assignSymbol(){
	assign=$((RANDOM%2))

	if (($assign==1))
	then
		playerSymbol='X'
		computerSymbol='O'
	else
		playerSymbol='O'
     	computerSymbol='X'
	fi

	echo -e "\nPlayer 1 = $playerSymbol"
	echo -e "Computer = $computerSymbol"

}


function resetBoard(){

	board=( 1 2 3 4 5 6 7 8 9 )
	for (( i=0,j=0;j<$row;i=$(($i+3)),j++ ))
	do
		echo -e "\t${board[i]} | ${board[i+1]} | ${board[i+2]}"
		if (($j!=$(($row-1))))
		then
			echo -e "\t---------"
		fi


	done

}

function updatedBoard() {

	for (( i=0,j=0;j<$row;i=$(($i+3)),j++ ))
   do
      echo -e "\t${board[i]} | ${board[i+1]} | ${board[i+2]}"
      if (($j!=$(($row-1))))
      then
         echo -e "\t---------"
      fi
   done


}
function playerInput() {

		echo -e "\nPlayers 1's Turn:"
		while ((1))
		do
			read -p "Select shell number: " shellNumber
			if (( ($shellNumber<1) || ($shellNumber>9)))
			then
				echo "Invalid, input 1...9"
			elif (($shellNumber!=${board[$shellNumber-1]}))
			then
				echo -e "Invalid: Shell is already occupied, choose again"

			else
					break
			fi
		done
		board[$shellNumber-1]=$playerSymbol
		updatedBoard
}

function computerInput() {

		echo -e "\nComputer's turn,"
		while ((1))
		do
			shellNumber=$((RANDOM%9+1))
			if (($shellNumber==${board[$shellNumber-1]}))
			then
				break
			fi
		done
		echo -e "Computer Selected shell number:$shellNumber"
		board[$shellNumber-1]=$computerSymbol
		updatedBoard

}
function checkWinCombination(){

		local symbol=$1

	if [ ${board[0]} == $symbol ] && [ ${board[1]} == $symbol ] && [ ${board[2]} == $symbol ]
   then
      echo 1
   elif [ ${board[3]} == $symbol ] && [ ${board[4]} == $symbol ] && [ ${board[5]} == $symbol ]
   then
      echo 1
   elif [ ${board[6]} == $symbol ] && [ ${board[7]} == $symbol ] && [ ${board[8]} == $symbol ]
   then
      echo 1
   elif [ ${board[0]} == $symbol ] && [ ${board[3]} == $symbol ] && [ ${board[6]} == $symbol ]
   then
      echo 1
   elif [ ${board[1]} == $symbol ] && [ ${board[4]} == $symbol ] && [ ${board[7]} == $symbol ]
   then
      echo 1
   elif [ ${board[2]} == $symbol ] && [ ${board[5]} == $symbol ] && [ ${board[8]} == $symbol ]
   then
      echo 1
   elif [ ${board[0]} == $symbol ] && [ ${board[4]} == $symbol ] && [ ${board[8]} == $symbol ]
   then
      echo 1
   elif [ ${board[2]} == $symbol ] && [ ${board[4]} == $symbol ] && [ ${board[6]} == $symbol ]
   then
      echo 1
   else
      echo 0
   fi




}
#****** Main Method *****
assignSymbol
toss
resetBoard
tie=1
if (( $playerChance==1 ))
then
	for ((k=0;$k<$numberOfShell;k++))
	do
			playerInput
			checkWin=$(checkWinCombination $playerSymbol)
			if (( $checkWin == 1 ))
			then
				tie=0
				echo -e "Player Won"
				break;
			fi


			computerInput
			checkWin=$(checkWinCombination $computerSymbol)
			if (( $checkWin == 1 ))
			then
				tie=0
				echo -e "Computer Won"
				break
			fi

	done
else
	for ((k=0;$k<$numberOfShell;k++))
	do
			computerInput
			checkWin=$(checkWinCombination $computerSymbol)
         if (( $checkWin == 1 ))
         then
				tie=0
				echo -e "Computer Won"
            break
         fi
			playerInput

			checkWin=$(checkWinCombination $playerSymbol)
         if (( $checkWin == 1 ))
         then
				tie=0
				echo -e "Player Won"
            break;
         fi
	done
fi

if (($tie==1))
then
	echo "It is a tie"
fi
