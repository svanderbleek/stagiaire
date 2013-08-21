class Stagiaire
  def initialize(directory)
    @directory = directory || Dir.pwd
  end

  def run
    puts "Running in directory: #{directory}"
  end

  private

  attr_reader :directory
end
