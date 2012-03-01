require '500px'

client = F00px::Client.new(
  :key => 'RT1LCuX4CqDF9tzuNbcwAY6GcsoXIR25wX7Hdd6o',
  :secret => 'ZHEfH36ojHr3FVmlsnawjf6e6JDt9EiwOBuZJx34',
  :url => 'https://api.500px.com')

photos = client.photos
x = 1
puts client.photos.collect{|c|c.id}.inspect
5.times do
  x += 1
  photos.page!(x)
  puts "Now on page #{photos.current_page}"
  puts photos.collect{|c|c.id}.inspect
end

