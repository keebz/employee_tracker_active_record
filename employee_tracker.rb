require 'active_record'
require './lib/employee'
require './lib/division'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "welcome to the employee tracker."
  main
end

def main

  choice = nil

  until choice == 'e'
    puts "Select 'a' to add an employee"
    puts "Select 'l' to view lists"
    puts "Select 'd' to add a new division"
    puts "Select 'e' to exit"
    choice = gets.chomp
    case choice
    when 'a'
      add_employee
    when 'l'
      puts "Push '1' to list employees. Push '2' to list divsions:"
      selection = gets.chomp.to_i
      if selection == 1
        list_employees
      elsif selection == 2
        list_division
      else
        puts "invaild selection"
      end
    when 'd'
      add_division
    when 'e'
      puts "good-bye"
    else
      puts "invaild input"
    end
  end
end

def add_employee
  puts "Enter the name of the employee"
  employee_name = gets.chomp
  employee = Employee.new({:name => employee_name})
  employee.save
  puts "Employee added."
end

def list_employees
  puts "Here are all of your current employees"
  Employee.all.each_with_index do |employee, index|
    puts (index + 1).to_s + ". " + employee.name
  end
end

def add_division
  puts "Enter the name of a division"
  division_name = gets.chomp
  division = Division.new({:name => division_name})
  division.save
  puts "Division added."
end

def list_division
  puts "Here are all of the companies divisions:"
  Division.all.each_with_index do |division, index|
    puts (index + 1).to_s + ". " + division.name
  end
end



welcome
