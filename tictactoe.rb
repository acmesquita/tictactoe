load('game.rb')

modality = 1;
game_way = 1;

begin
  puts "Modality [1-Player vs Comp, 2-Player vs Player, 3-Comp vc Comp]:"
  value = Integer(gets.chomp)
  if(value.between?(1,3))
    game_way = value
  end
  rescue ArgumentError
end
if(game_way == 1)
  begin
    puts "Modality [1-easy, 2-middle, 3-hard]:"
    value = Integer(gets.chomp)
    if(value.between?(1,3))
      modality = value
    else 
      puts "Input invalid. Start again 1"
      exit
    end
    rescue ArgumentError
  end
end
game = Game.new({:modality=> modality, :game_way => game_way})
game.start_game
