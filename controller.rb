require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( "./models/student.rb" )
require_relative( "./models/house.rb" )


get "/hogwarts" do
  @students = Student.all()
  erb(:main)
end

get "/hogwarts/new" do
  @houses = House.all()
  erb(:new)
end

get "/hogwarts/:id" do
  @student = Student.find(params[:id])
erb(:show)
end



post "/hogwarts" do
  @student = Student.new(params).save()
  erb(:applied)
end
