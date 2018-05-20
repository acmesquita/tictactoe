class Game
    def initialize(options=[])
      @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
      @com = "X" # the computer's marker
      @hum = "O" # the user's marker
    end
  
    def start_game
      # start by printing the board
      draw_board(@board)
      # loop through until the game was won or tied
      until game_is_over(@board) || tie(@board)
        get_human_spot
        if !game_is_over(@board) && !tie(@board)
          eval_board
        end
        draw_board(@board)
      end
      puts "Game over"
    end
  
    def get_human_spot
      spot = nil
      until spot
        spot = get_spot;
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @hum
        else
          spot = nil
        end
      end
    end

    def get_spot
        begin
            value = Integer(gets.chomp)
            if(value.between?(0,8))
                return value
            else 
                puts "Input invalid. Enter [0-8]:"
                get_spot
            end
        rescue ArgumentError
            puts "Intup invalid. Enter [0-8]:"
            get_spot
        end
    end
  
    def eval_board
      spot = nil
      until spot
        if @board[4] == "4"
          spot = 4
          @board[spot] = @com
        else
          spot = get_best_move(@board, @com)
          if @board[spot] != "X" && @board[spot] != "O"
            @board[spot] = @com
          else
            spot = nil
          end
        end
      end
    end
  
    def get_best_move(board, next_player, depth = 0, best_score = {})
      available_spaces = []
      best_move = nil
      board.each do |s|
        if s != "X" && s != "O"
          available_spaces << s
        end
      end
      available_spaces.each do |as|
        board[as.to_i] = @com
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = @hum
          if game_is_over(board)
            best_move = as.to_i
            board[as.to_i] = as
            return best_move
          else
            board[as.to_i] = as
          end
        end
      end
      if best_move
        return best_move
      else
        n = rand(0..available_spaces.count)
        return available_spaces[n].to_i
      end
    end
  
    def game_is_over(b)
  
      [b[0], b[1], b[2]].uniq.length == 1 ||
      [b[3], b[4], b[5]].uniq.length == 1 ||
      [b[6], b[7], b[8]].uniq.length == 1 ||
      [b[0], b[3], b[6]].uniq.length == 1 ||
      [b[1], b[4], b[7]].uniq.length == 1 ||
      [b[2], b[5], b[8]].uniq.length == 1 ||
      [b[0], b[4], b[8]].uniq.length == 1 ||
      [b[2], b[4], b[6]].uniq.length == 1
    end
  
    def tie(b)
      b.all? { |s| s == "X" || s == "O" }
    end

    def draw_board(b)
        system("clear")
        puts " #{b[0]} | #{b[1]} | #{b[2]} \n===+===+===\n #{b[3]} | #{b[4]} | #{b[5]} \n===+===+===\n #{b[6]} | #{b[7]} | #{b[8]} \n"
        puts "Enter [0-8]:"
    end
  
  end  