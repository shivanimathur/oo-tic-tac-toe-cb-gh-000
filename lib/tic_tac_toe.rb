class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]



  def display_board(board = @board)
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, token = "X")
    @token = token
    @board[index] = @token
  end
  def position_taken?(index)
    input_to_index(index)
    @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(position)
    input_to_index(position)
    position.between?(0,8) && !position_taken?(position)
  end

  def turn_count(board = @board)
    @board.count{ |token| token == "X" || token == "O" }
  end

  def current_player(board = @board)
    turn_count(board) % 2 == 0 ? "X" : "O"
  end

  def turn(board = @board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def won?(board = @board)
      WIN_COMBINATIONS.detect do |combo|
        board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(combo[0])
      end
  end

  def full?(board = @board)
    board.all?{|token| token == "X" || token == "O"}
  end

  def draw?(board = @board)
    !won?(board) && full?(board)
  end

  def over?(board = @board)
    won?(board) || draw?(board)
  end

  def winner(board = @board)
    if winning_combo = won?(board)
      board[winning_combo.first]
    end
  end

  def play(board = @board)
    while !over?(board)
      turn(board)
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
end
