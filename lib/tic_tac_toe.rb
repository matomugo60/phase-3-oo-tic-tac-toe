require 'pry'


class TicTacToe
    attr_reader :board
  
    WIN_COMBINATIONS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  
    def initialize
      @board = Array.new(9, " ")
    end
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
  
    def input_to_index(input)
      input.to_i - 1
    end
  
    def move(index, player_token = "X")
      @board[index] = player_token
    end
  
    def position_taken?(index)
      @board[index] != " " && @board[index] != "" && @board[index] != nil
    end
  
    def valid_move?(index)
      index.between?(0, 8) && !position_taken?(index)
    end
  
    def turn_count
      @board.count { |token| token == "X" || token == "O" }
    end
  
    def current_player
      turn_count % 2 == 0 ? "X" : "O"
    end
  
    def turn
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      if valid_move?(index)
        player_token = current_player
        move(index, player_token)
        display_board
      else
        turn
      end
    end
  
    def won?
      WIN_COMBINATIONS.detect do |combo|
        position_1 = @board[combo[0]]
        position_2 = @board[combo[1]]
        position_3 = @board[combo[2]]
        position_1 == position_2 && position_2 == position_3 && position_taken?(combo[0])
      end
    end
  
    def full?
      @board.all? { |token| token == "X" || token == "O" }
    end
  
    def draw?
      !won? && full?
    end
  
    def over?
      won? || draw?
    end
  
    def winner
      if combo = won?
        @board[combo[0]]
      end
    end
  
    def play
      until over?
        turn
      end
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cat's Game!"
      end
    end
  end
  

  binding.pry