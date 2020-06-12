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
		computerWinningShell
		checkWinningShell=$?
		if [ $checkWinningShell -eq 1 ]
		then
			echo -e "Computer Selected shelll number: $shellNumber"
		else
		while ((1))
		do
			shellNumber=$((RANDOM%9+1))
			if (($shellNumber==${board[$shellNumber-1]}))
			then
			echo -e "Computer Selected shell number:$shellNumber"
			break
			fi
		done
		fi
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

function computerWinningShell(){
#columns
		if [ ${board[0]} == $computerSymbol ] && [ ${board[1]} == $computerSymbol ]
      then
      	if [ ${board[2]}==3 ]
       	then
             shellNumber=3
             return 1
			fi
		elif [ ${board[0]} == $computerSymbol ] && [ ${board[2]} == $computerSymbol ]
      then
         if [ ${board[1]}==2 ]
         then
             shellNumber=2
             return 1
			fi
		elif [ ${board[1]} == $computerSymbol ] && [ ${board[2]} == $computerSymbol ]
      then
         if [ ${board[0]}==1 ]
         then
             shellNumber=1
             return 1
			fi

		elif [ ${board[3]} == $computerSymbol ] && [ ${board[4]} == $computerSymbol ]
      then
         if [ ${board[5]}==6 ]
         then
             shellNumber=6
             return 1
			fi
		elif [ ${board[3]} == $computerSymbol ] && [ ${board[5]} == $computerSymbol ]
      then
         if [ ${board[4]}==5 ]
         then
             shellNumber=5
             return 1
			fi
		elif [ ${board[4]} == $computerSymbol ] && [ ${board[5]} == $computerSymbol ]
      then
         if [ ${board[3]}==4 ]
         then
             shellNumber=4
             return 1
			fi

		elif [ ${board[6]} == $computerSymbol ] && [ ${board[7]} == $computerSymbol ]
      then
         if [ ${board[8]}==9 ]
         then
             shellNumber=9
             return 1
			fi
		elif [ ${board[6]} == $computerSymbol ] && [ ${board[8]} == $computerSymbol ]
      then
         if [ ${board[7]}==8 ]
         then
             shellNumber=8
             return 1
			fi
		elif [ ${board[7]} == $computerSymbol ] && [ ${board[8]} == $computerSymbol ]
      then
         if [ ${board[6]}==7 ]
         then
             shellNumber=7
             return 1
			fi
#colmumn
		elif [ ${board[0]} == $computerSymbol ] && [ ${board[3]} == $computerSymbol ]
      then
         if [ ${board[6]}==7 ]
         then
             shellNumber=7
             return 1
			fi
		elif [ ${board[0]} == $computerSymbol ] && [ ${board[6]} == $computerSymbol ]
      then
         if [ ${board[3]}==4 ]
         then
             shellNumber=4
             return 1
			fi
		elif [ ${board[3]} == $computerSymbol ] && [ ${board[6]} == $computerSymbol ]
      then
         if [ ${board[0]}==1 ]
         then
             shellNumber=1
             return 1
			fi



		elif [ ${board[1]} == $computerSymbol ] && [ ${board[4]} == $computerSymbol ]
      then
         if [ ${board[7]}==8 ]
         then
             shellNumber=8
             return 1
			fi
		elif [ ${board[4]} == $computerSymbol ] && [ ${board[7]} == $computerSymbol ]
      then
         if [ ${board[1]}==2 ]
         then
             shellNumber=2
             return 1
			fi
		elif [ ${board[1]} == $computerSymbol ] && [ ${board[7]} == $computerSymbol ]
      then
         if [ ${board[4]}==5 ]
         then
             shellNumber=5
             return 1
			fi


			elif [ ${board[2]} == $computerSymbol ] && [ ${board[5]} == $computerSymbol ]
      then
         if [ ${board[8]}==9 ]
         then
             shellNumber=9
             return 1
			fi
		elif [ ${board[2]} == $computerSymbol ] && [ ${board[8]} == $computerSymbol ]
      then
         if [ ${board[5]}==6 ]
         then
             shellNumber=6
             return 1
			fi
		elif [ ${board[5]} == $computerSymbol ] && [ ${board[8]} == $computerSymbol ]
      then
         if [ ${board[2]}==3 ]
         then
             shellNumber=3
             return 1
			fi



#diagonals
		elif [ ${board[0]} == $computerSymbol ] && [ ${board[4]} == $computerSymbol ]
      then
         if [ ${board[8]}==9 ]
         then
             shellNumber=9
             return 1
			fi
		elif [ ${board[0]} == $computerSymbol ] && [ ${board[8]} == $computerSymbol ]
      then
         if [ ${board[4]}==5 ]
         then
             shellNumber=5
             return 1
			fi
		elif [ ${board[4]} == $computerSymbol ] && [ ${board[8]} == $computerSymbol ]
      then
         if [ ${board[0]}==1 ]
         then
             shellNumber=1
             return 1
			fi


		elif [ ${board[2]} == $computerSymbol ] && [ ${board[4]} == $computerSymbol ]
      then
         if [ ${board[6]}==7 ]
         then
             shellNumber=7
             return 1
			fi
		elif [ ${board[2]} == $computerSymbol ] && [ ${board[6]} == $computerSymbol ]
      then
         if [ ${board[4]}==5 ]
         then
             shellNumber=5
             return 1
			fi
		elif [ ${board[4]} == $computerSymbol ] && [ ${board[6]} == $computerSymbol ]
      then
         if [ ${board[2]}==3 ]
         then
             shellNumber=3
             return 1
			fi
		else
			return 0
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
