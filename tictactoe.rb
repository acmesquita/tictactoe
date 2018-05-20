load('game.rb')

modality = 1;

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

game = Game.new({:modality=> modality})
game.start_game
