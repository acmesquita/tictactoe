class Game
    def initialize(options=[])
      @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
      @player2 = "X" # the computer's marker
      @player1 = "O" # the user's marker
      @modality = options[:modality]
      @game_way = options[:game_way]
      @players_turn = @player1
    end
  
    def start_game
      # start by printing the board
      draw_board(@board)
      # loop through until the game was won or tied
      game_way(@game_way)
    end

    def game_way(game_way)
      case game_way
      when 1
        until game_is_over(@board) || tie(@board)
          get_human_spot
          if !game_is_over(@board) && !tie(@board)
            eval_board(@modality)
          end
          draw_board(@board)
        end
        finish_game(@board)
      when 2
        until game_is_over(@board) || tie(@board)
          get_human_spot
          draw_board(@board)
        end
      when 3
        until game_is_over(@board) || tie(@board)
          eval_board(@modality)
          draw_board(@board)
          finish_game(@board)
        end
      else
        game_way(1)
      end
    end

    def finish_game(board)
      if(game_is_over(board))
        puts "Game over. Player #{@players_turn} wins."
      else
        puts "Game over. Deu velha"
      end.
  
    def get_human_spot
      spot = nil
      until spot
        spot = get_spot
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @players_turn
        else
          spot = nil
        end
      end
    end

    def get_spot
      begin
        value = Integer(gets.chomp)
        change_player
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

    def change_player
      players = [@player1, @player2]
      @players_turn = players.select{|p| p != @players_turn}.first
    end
  
    def eval_board(modality)
      spot = nil
      until spot
        if @board[4] == "4"
          spot = 4
          @board[spot] = @players_turn
        else
          spot = get_move(modality, @board, @players_turn)
          if @board[spot] != "X" && @board[spot] != "O"
            @board[spot] = @players_turn
          else
            spot = nil
          end
        end
      end
    end

    def get_move(modality, board, next_player)
      case modality
      when 1
        return get_easy_move(board, next_player)
      when 2
        return get_middle_move(board, next_player)
      when 3
        return get_best_move(board, next_player)
      else
        return get_easy_move(board, next_player)
      end
    end
    
    def get_easy_move(board, next_player)
      change_player
      n = board.select{|x| x != "X"}.shuffle.bsearch{ |x| x != "O"}.to_i
    end

    def get_middle_move(board, next_player)
      change_player
      available_spaces = []
      available_spaces = board.select{|x| x != "X"}.select{|x| x != "O"}
      n = available_spaces.shuffle.first.to_i
      available_spaces[n].to_i
    end


    def get_best_move(board, next_player, depth = 0, best_score = {})
      change_player
      available_spaces = []
      best_move = nil
      available_spaces = board.select{|x| x != "X"}.select{|x| x != "O"}
      available_spaces.each do |as|
        board[as.to_i] = @players_turn
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          change_player
          board[as.to_i] = @players_turn
          change_player
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
      puts "Player #{@players_turn} Enter [0-8]:"
    end
  
  end  