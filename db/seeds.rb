require_relative("../models/house.rb")
require_relative("../models/student.rb")
require("pry")

Student.delete_all()
House.delete_all()

house1 = House.new({
  "name" => "Slytherin"
  })

house1.save()

house2 = House.new({
  "name" => "Ravenclaw"
  })

house2.save()

house3 = House.new({
  "name" => "Hufflepuff"
  })

house3.save()

house4 = House.new({
  "name" => "Gryffindor"
  })

house4.save()

student1 = Student.new({
  "first_name" => "Minerva",
  "last_name" => "McGonagall",
  "age" => 16,
  "house_id" => house4.id()
  })

student1.save()

student2 = Student.new({
  "first_name" => "Mike",
  "last_name" => "Sprout",
  "age" => 18,
  "house_id" => house3.id()
  })

student2.save()

student3 = Student.new({
  "first_name" => "Nick",
  "last_name" => "Headless",
  "age" => 14,
  "house_id" => house1.id()
  })

student3.save()

student4 = Student.new({
  "first_name" => "Ron",
  "last_name" => "Weasley",
  "age" => 12,
  "house_id" => house2.id()
  })

student4.save()

binding.pry
nil
