using Random
board=[]
for i=1:9
    push!(board,' ')
    end

function insertLetter(letter,pos)
    board[pos]=letter
    end

function spaceIsFree(pos)
    return board[pos]==' '
    end

function printBoard(board)
        println("   |   |   ")
        println(" ",board[1]," | ",board[2]," | ",board[3]," ")
        println("   |   |   ")
        println("------------")
        println("   |   |   ")
        println(" ",board[4]," | ",board[5]," | ",board[6]," ")
        println("   |   |   ")
        println("------------")
        println("   |   |   ")
        println(" ",board[7]," | ",board[8]," | ",board[9]," ")
        println("   |   |   ")
        println("           ")
    end

function isBoardFull(board)
    boardCopy=board[:]
    for i=1:length(boardCopy)
        if board[i]==' '
            boardCopy[i]=true
        else
            boardCopy[i]=false    
            end 
        end        
             
    if count(boardCopy)>0
        return false
    else 
        return true
        end
    end            

function isWinner(board,letter)
    return(
        (board[1]==letter && board[2]==letter && board[3]==letter) ||
        (board[4]==letter && board[5]==letter && board[6]==letter) ||
        (board[7]==letter && board[8]==letter && board[9]==letter) ||
        (board[1]==letter && board[4]==letter && board[7]==letter) ||
        (board[2]==letter && board[5]==letter && board[8]==letter) ||
        (board[3]==letter && board[6]==letter && board[9]==letter) ||
        (board[1]==letter && board[5]==letter && board[9]==letter) ||
        (board[3]==letter && board[5]==letter && board[7]==letter)
    )
    end

function input(prompt::AbstractString="")
    print(prompt)
    return chomp(readline())
    end

function playerMove()
    run=true
    while run
        move=input("Please select a position to enter the x between 1 to 9 : ")
        try
            move=parse(Int64, move)
            if move>0 && move<10
                if spaceIsFree(move)
                    run=false 
                    insertLetter('X',move)
                else    
                    println("Sorry, this place is occupied")
                end
            else  
                println("Please type a number between 1 and 9")
            end        

        catch 
            println("Please type a number")
            end        
        end 
    end   

function computerMove()
    
    possibleMoves=[0,0,0,0,0,0,0,0,0]
    k=1
    for i=1:length(board)
        if board[i]==' '
            possibleMoves[k]=i
            k+=1
        end
    end    

    move=0
    for n in ['O','X']
        for i in possibleMoves
            if i!=0
                boardCopy=board[:]
                boardCopy[i]=n
                if isWinner(boardCopy,n)
                    move=i
                    return move
                    end 
                end    
            end      
        end 

        cornerOpen=[]
        for i in possibleMoves
            if i in [1,3,7,9]
                push!(cornerOpen,i)
                end
            end    
        if length(cornerOpen)>0
            move=selectRandom(cornerOpen)
            return move
            end

        if 5 in possibleMoves
            move=5
            return move
            end
        edgeOpen=[]
        for i in possibleMoves
            if i in [2,4,6,8]
                push!(edgeOpen,i)
                end 
            end    
        if length(edgeOpen)>0
            move=selectRandom(edgeOpen)
            return move
            end 
            
        return 0    
    end
 
  
    

function selectRandom(array)
    ln=length(array)
    r=randperm(ln)[1]
    return array[r]
    end


function main()
    println("Welcome to the game")
    printBoard(board) 
    
    while (!(isBoardFull(board)))
        
        if (!isWinner(board,'O'))
            playerMove()
            printBoard(board)
        else
            println("Sorry, you loose")
            break
            end

        if (!isWinner(board,'X'))
            move=computerMove()
            if move==0
                println("Tie game")  
            else
                insertLetter('O', move)
                println("Computer placed an O on position ",move,':')
                printBoard(board)
                end  
        else
            println("You win")
            break
            end
        end
    end 

while true
    x=input("Do you want to play again? (y/n)")
    if lowercase(x)=="y"
        global board=[]
        for i=1:9
            push!(board,' ')
            end
        println("-------------------------")
        main()    
    elseif lowercase(x)=="n"
        break
    else
        println("Press y or n")
        end
    
    end 

    
