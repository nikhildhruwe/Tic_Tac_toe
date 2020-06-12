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
			echo -e "Computer Selected winning shelll number: $shellNumber"
			board[$shellNumber-1]=$computerSymbol
			updatedBoard

			return
		fi

		computerBlockShell
		checkBlocking=$?
		if [ $checkBlocking -eq 1 ]
		then
			echo -e "Computer Selected blocking shell number: $shellNumber"
			board[$shellNumber-1]=$computerSymbol
			updatedBoard

			return
		fi
		computerCornerCentreShell
		check=$?
		if [ $check -eq 1 ]
		then
			echo -e "Computer Selected Corner shell number: $shellNumber"
         board[$shellNumber-1]=$computerSymbol
         updatedBoard

		elif [ $check -eq 2 ]
		then
			echo -e "Computer Selected Centre shell number: $shellNumber"
         board[$shellNumber-1]=$computerSymbol
         updatedBoard

		else
			while ((1))
			do
				shellNumber=$((RANDOM%9+1))
				if (($shellNumber==${board[$shellNumber-1]}))
				then
					echo -e "Computer Selected shell number:$shellNumber"
					board[$shellNumber-1]=$computerSymbol
					updatedBoard
					return
				fi
			done
		fi

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
function computerCornerCentreShell() {

			if ((${board[0]} == 1 ))
			then
				shellNumber=1
				return 1
			elif ((${board[2]} == 3 ))
			then
				shellNumber=3
				return 1
			elif ((${board[6]} == 7 ))
			then
				shellNumber=7
				return 1
			elif ((${board[8]} == 9 ))
			then
				shellNumber=9
				return 1
			elif ((${board[4]} == 5 ))
			then
				shellNumber=5
				return 2
			else
				return 0
			fi

}
function computerWinningShell(){
#Rows
      for ((a=0,r=0;$a<$row;a++,r=$(($r+3))))
      do

      if [ ${board[r]} == $computerSymbol ] && [ ${board[r+1]} == $computerSymbol ]
      then
         if (( ${board[r+2]} == $(($r+2+1)) ))
         then
             shellNumber=$(($r+2+1))
             return 1
         fi
      elif [ ${board[r]} == $computerSymbol ] && [ ${board[r+2]} == $computerSymbol ]
      then
         if (( ${board[r+1]} == $(($r+1+1)) ))
         then
             shellNumber=$(($r+1+1))
             return 1
         fi
      elif [ ${board[r+1]} == $computerSymbol ] && [ ${board[r+2]} == $computerSymbol ]
      then
         if (( ${board[r]} == $(($r+1)) ))
         then
             shellNumber=$(($r+1))
             return 1
         fi
      fi
      done


#colmumn
      local c=0
      for ((c=0;$c<$column;c++))
      do
      if [ ${board[c]} == $computerSymbol ] && [ ${board[c+3]} == $computerSymbol ]
      then
         if (( ${board[c+6]} == $(($c+6+1)) ))
         then
             shellNumber=$(($c+6+1))
             return 1
         fi
      elif [ ${board[c]} == $computerSymbol ] && [ ${board[c+6]} == $computerSymbol ]
      then
         if (( ${board[c+3]} == $(($c+3+1)) ))
         then
             shellNumber=$(($c+3+1))
             return 1
         fi
      elif [ ${board[c+3]} == $computerSymbol ] && [ ${board[c+6]} == $computerSymbol ]
      then
         if (( ${board[c]} == $(($c+1)) ))
         then
             shellNumber=$(($c+1))
             return 1
         fi
      fi
      done


#diagonals
      if [ ${board[0]} == $computerSymbol ] && [ ${board[4]} == $computerSymbol ]
      then
         if (( ${board[8]}==9 ))
         then
             shellNumber=9
             return 1
         fi
      elif [ ${board[0]} == $computerSymbol ] && [ ${board[8]} == $computerSymbol ]
      then
         if (( ${board[4]}==5 ))
         then
             shellNumber=5
             return 1
         fi
      elif [ ${board[4]} == $computerSymbol ] && [ ${board[8]} == $computerSymbol ]
      then
         if (( ${board[0]}==1 ))
         then
             shellNumber=1
             return 1
         fi


      elif [ ${board[2]} == $computerSymbol ] && [ ${board[4]} == $computerSymbol ]
      then
         if (( ${board[6]}==7 ))
         then
             shellNumber=7
             return 1
         fi
      elif [ ${board[2]} == $computerSymbol ] && [ ${board[6]} == $computerSymbol ]
      then
         if (( ${board[4]}==5 ))
         then
             shellNumber=5
             return 1
         fi
      elif [ ${board[4]} == $computerSymbol ] && [ ${board[6]} == $computerSymbol ]
      then
         if (( ${board[2]}==3 ))
         then
             shellNumber=3
             return 1
         fi
      else
         return 0
      fi


}



function computerBlockShell(){

#Rows
		local a=0
		local r=0
      for ((a=0,r=0;$a<$row;a++,r=$(($r+3))))
      do

      if [ ${board[r]} == $playerSymbol ] && [ ${board[r+1]} == $playerSymbol ]
      then
         if (( ${board[r+2]} == $(($r+2+1)) ))
         then
             shellNumber=$(($r+2+1))
             return 1
         fi
      elif [ ${board[r]} == $playerSymbol ] && [ ${board[r+2]} == $playerSymbol ]
      then
         if (( ${board[r+1]} == $(($r+1+1)) ))
         then
             shellNumber=$(($r+1+1))
             return 1
         fi
      elif [ ${board[r+1]} == $playerSymbol ] && [ ${board[r+2]} == $playerSymbol ]
      then
         if (( ${board[r]} == $(($r+1)) ))
         then
             shellNumber=$(($r+1))
             return 1
         fi
      fi
      done


#colmumn
      local c=0
      for ((c=0;$c<$column;c++))
      do
      if [ ${board[c]} == $playerSymbol ] && [ ${board[c+3]} == $playerSymbol ]
      then
         if (( ${board[c+6]} == $(($c+6+1)) ))
         then
             shellNumber=$(($c+6+1))
             return 1
         fi
      elif [ ${board[c]} == $playerSymbol ] && [ ${board[c+6]} == $playerSymbol ]
      then
         if (( ${board[c+3]} == $(($c+3+1)) ))
         then
             shellNumber=$(($c+3+1))
             return 1
         fi
      elif [ ${board[c+3]} == $playerSymbol ] && [ ${board[c+6]} == $playerSymbol ]
      then
         if (( ${board[c]} == $(($c+1)) ))
         then
             shellNumber=$(($c+1))
             return 1
         fi
      fi
      done


#diagonals
      if [ ${board[0]} == $playerSymbol ] && [ ${board[4]} == $playerSymbol ]
      then
         if (( ${board[8]}==9 ))
         then
             shellNumber=9
             return 1
         fi
      elif [ ${board[0]} == $playerSymbol ] && [ ${board[8]} == $playerSymbol ]
      then
         if (( ${board[4]}==5 ))
         then
             shellNumber=5
             return 1
         fi
      elif [ ${board[4]} == $playerSymbol ] && [ ${board[8]} == $playerSymbol ]
      then
         if (( ${board[0]}==1 ))
         then
             shellNumber=1
             return 1
         fi


      elif [ ${board[2]} == $playerSymbol ] && [ ${board[4]} == $playerSymbol ]
      then
         if (( ${board[6]}==7 ))
         then
             shellNumber=7
             return 1
         fi
      elif [ ${board[2]} == $playerSymbol ] && [ ${board[6]} == $playerSymbol ]
      then
         if (( ${board[4]}==5 ))
         then
             shellNumber=5
             return 1
         fi
      elif [ ${board[4]} == $playerSymbol ] && [ ${board[6]} == $playerSymbol ]
      then
         if (( ${board[2]}==3 ))
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
