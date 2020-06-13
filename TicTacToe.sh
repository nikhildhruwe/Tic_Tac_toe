#!/bin/bash -x

echo -e "\n   Welcome to Tic-Tac-Toe game.\n"
echo -e "Player vs Computer\n"

row=3
column=3
numberOfShell=$(($row*$column))

function toss(){

	echo -e "Toss.."
	checkToss=$((RANDOM%2))
	if (($checkToss == 1 ))
	then
		echo -e "\nPlayer Won the Toss\n"
		playerChance=1
	else
		echo -e "\nComputer Won the Toss\n"
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
	echo -e "********* BOARD ************\n"
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
echo -e "\n********* BOARD ***********\n"
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
		echo -e "\nPlayer's Turn:"
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
		computerWinBlockShell $computerSymbol
		checkWinningShell=$?
		if [ $checkWinningShell -eq 1 ]
		then
			return
		fi

		computerWinBlockShell $playerSymbol
		checkBlocking=$?
		if [ $checkBlocking -eq 1 ]
		then
			return
		fi
		computerCornerCentreSideShell
		check=$?
		if [ $check -eq 1 ]
		then
				return
		elif [ $check -eq 2 ]
		then
				return
		elif [ $check -eq 3 ]
      then
			return
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
function computerCornerCentreSideShell() {

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
			elif ((${board[1]} == 2 ))
			then
				shellNumber=2
				return 3
			elif ((${board[3]} == 4 ))
			then
				shellNumber=4
				return 3
			elif ((${board[5]} == 6 ))
			then
				shellNumber=6
				return 3
			elif ((${board[7]} == 8 ))
			then
				shellNumber=8
				return 3
			else
				return 0
			fi

}

function computerWinBlockShell(){

#Rows
		local symbol=$1
		local a=0
		local r=0
      for ((a=0,r=0;$a<$row;a++,r=$(($r+3))))
      do

      if [ ${board[r]} == $symbol ] && [ ${board[r+1]} == $symbol ]
      then
         if (( ${board[r+2]} == $(($r+2+1)) ))
         then
             shellNumber=$(($r+2+1))
             return 1
         fi
      elif [ ${board[r]} == $symbol ] && [ ${board[r+2]} == $symbol ]
      then
         if (( ${board[r+1]} == $(($r+1+1)) ))
         then
             shellNumber=$(($r+1+1))
             return 1
         fi
      elif [ ${board[r+1]} == $symbol ] && [ ${board[r+2]} == $symbol ]
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
      if [ ${board[c]} == $symbol ] && [ ${board[c+3]} == $symbol ]
      then
         if (( ${board[c+6]} == $(($c+6+1)) ))
         then
             shellNumber=$(($c+6+1))
             return 1
         fi
      elif [ ${board[c]} == $symbol ] && [ ${board[c+6]} == $symbol ]
      then
         if (( ${board[c+3]} == $(($c+3+1)) ))
         then
             shellNumber=$(($c+3+1))
             return 1
         fi
      elif [ ${board[c+3]} == $symbol ] && [ ${board[c+6]} == $symbol ]
      then
         if (( ${board[c]} == $(($c+1)) ))
         then
             shellNumber=$(($c+1))
             return 1
         fi
      fi
      done


#diagonals
      if [ ${board[0]} == $symbol ] && [ ${board[4]} == $symbol ]
      then
         if (( ${board[8]}==9 ))
         then
             shellNumber=9
             return 1
         fi
      elif [ ${board[0]} == $symbol ] && [ ${board[8]} == $symbol ]
      then
         if (( ${board[4]}==5 ))
         then
             shellNumber=5
             return 1
         fi
      elif [ ${board[4]} == $symbol ] && [ ${board[8]} == $symbol ]
      then
         if (( ${board[0]}==1 ))
         then
             shellNumber=1
             return 1
         fi


      elif [ ${board[2]} == $symbol ] && [ ${board[4]} == $symbol ]
      then
         if (( ${board[6]}==7 ))
         then
             shellNumber=7
             return 1
         fi
      elif [ ${board[2]} == $symbol ] && [ ${board[6]} == $symbol ]
      then
         if (( ${board[4]}==5 ))
         then
             shellNumber=5
             return 1
         fi
      elif [ ${board[4]} == $symbol ] && [ ${board[6]} == $symbol ]
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
chanceNumber=0
while ((1))
do
	if (( $playerChance==1 ))
   then
		playerInput
		((chanceNumber++))
		playerChance=0
    fi

     computerInput
     echo -e "Computer Selected shell number: $shellNumber"
	  board[$shellNumber-1]=$computerSymbol
	  updatedBoard
     checkWin=$(checkWinCombination $computerSymbol)
     if (( $checkWin == 1 ))
     then
         tie=0
         echo -e "\nComputer WON"
         break
      fi
      ((chanceNumber++))
      if (($chanceNumber==9))
      then
            break
       fi

       playerInput
       checkWin=$(checkWinCombination $playerSymbol)
       if (( $checkWin == 1 ))
       then
          tie=0
          echo -e "\nPlayer WON"
          break;
       fi

     ((chanceNumber++))
     if (($chanceNumber==9))
     then
        break
      fi
done

if (($tie==1))
then
	echo -e "\n   It is a TIE\n"

fi
echo "*********** GAME OVER***********"
