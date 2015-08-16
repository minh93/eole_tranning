class StaticPagesController < ApplicationController
  def fb2
    @lines = [""]
    1000.times do |number|
      number += 1
      if number%15 == 0
        @lines << "person_puppy.png"
      elsif number%5 == 0
        @lines << "puppy.png"
      elsif number%3 == 0 || number.to_s.include?("3")
        @lines << "person.png"
      else
        @lines << number
      end
    end
  end

  def fb1
    @lines = [""]
    1000.times do |number|
      number += 1
      if number%15 == 0
        @lines << "FizzBuzz"
      elsif number%5 == 0
        @lines << "Buzz"
      elsif number%3 == 0
        @lines << "Fizz"
      else
        @lines << number.to_s
      end
    end
  end

def directory_listing
  if params[:path] == ""
    path = "."
  else
    path = params[:path]
  end
  @lines = [""]
  travelsal(@lines, path)    
  render :directory_listing
end

def index
  render :directory_listing
end

private

def travelsal(lines, path, prefix='')
  return [1, 0] if not Dir.exist? path
  children = Dir.entries(path).
  reject { |e| e[0] == '.' }.
  map { |p| File.join(path, p) }
  children.each_with_index do |f, i|
    if i < children.length - 1
      lines << (prefix + '├── ' + File.basename(f))
      travelsal(lines, f, prefix + '│   ')
    else
      lines << (prefix + '└── ' + File.basename(f))
      travelsal(lines, f, prefix + '    ')
    end
  end
end

end
