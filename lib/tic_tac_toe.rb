
WIN_COMBINATIONS = [[0,1,2],
                    [3,4,5], 
                    [6,7,8],
                    [0,3,6],
                    [1,4,7],
                    [2,5,8],
                    [0,4,8],
                    [2,4,6]]
                    
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(pos)
  return pos.to_i - 1
end

def move(board, pos, char)
  board[pos] = char
end

def position_taken?(board,pos)
  return ! [""," ", nil].include?(board[pos])
end

def valid_move?(board,pos)
  if ! pos.between?(0,8) || position_taken?(board,pos)
    return false
  end
  return true
end

def turn(board)
  puts "Please enter postion on board (1-9)?"
  pos = gets.strip
  pos = input_to_index(pos)
  if valid_move?(board,pos)
    move(board, pos, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  c = 0
  board.each do |pos|
    if ["O","X"].include?(pos)
      c += 1
    end
  end
  return c
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  end
  return "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    next if comb.any? {|pos| ! position_taken?(board,pos)}
    return comb if comb.all? {|pos| board[pos] == "X"}
    return comb if comb.all? {|pos| board[pos] == "O"}
  end
  return false
end

def full?(board)
  return true if board.all? {|pos| ["X","O"].include?(pos)}
  return false
end

def draw?(board)
  won = won?(board)
  full = full?(board)
  return false if won || (!won and !full)
  return true if !won && full
end

def over?(board)
  return true if (won?(board) || draw?(board) || full?(board))
end

def winner(board)
  comb =  won?(board)
  if comb 
    return board[comb[0]]
  end
end

def play(board)
  until over?(board)
   turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end