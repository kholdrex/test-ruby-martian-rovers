require './lib/rover'

class Nasa
  attr_accessor :rovers, :plateau

  def initialize(file_path)
    raise 'File not found!' unless File.exist?(file_path)
    @rovers = []
    @plateau = []

    parse(file_path)
  end

  private

  def parse(file_path)
    raise_unless_file_valid(file_path)

    data = []

    File.open(file_path).each_with_index do |line, index|
      if index == 0
        @plateau = [line.split(' ').map(&:to_i), [0, 0]]
      else
        if (index % 2) == 0
          @rovers << Rover.new(data[2], [data[0].to_i, data[1].to_i], line.chars)
        else
          data = line.split(' ')
        end
      end
    end
  end

  def raise_unless_file_valid(file_path)
    raise 'File is not valid!' if File.open(file_path).each_line.count < 3
  end
end
