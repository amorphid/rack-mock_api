Dir["./lib/**/*.rb"].each { |file| require file }

run MockApi.new
