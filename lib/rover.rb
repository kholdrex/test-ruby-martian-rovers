class Rover
  COORDINATE_PLANE_ANGLES = {
      90  => [0, 1],
      180 => [-1, 0],
      270 => [0, -1],
      360 => [1, 0],
      0   => [1, 0]
  }

  CARDINAL = {
      'N' => 90,
      'E' => 180,
      'S' => 270,
      'W' => 360
  }

  COMMANDS = {
      'L' => :left,
      'R' => :right,
      'M' => :move
  }

  attr_accessor :position, :current_degree, :commands

  def initialize(cardinal, position, commands)
    @position = position
    @commands = commands
    @current_degree = CARDINAL[cardinal]
  end

  def execute
    @commands.each do |command|
      send(COMMANDS[command]) if COMMANDS[command]
    end

    [@position, CARDINAL.key(@current_degree)].join(' ')
  end

  private

  def move
    @position = @position.zip(COORDINATE_PLANE_ANGLES[@current_degree]).map { |x, y| x + y }
  end

  def left
    @current_degree = (current_degree_value_for('left') + 90).abs
  end

  def right
    @current_degree = (current_degree_value_for('right') - 90).abs
  end

  def current_degree_value_for(pos)
    case pos
      when 'right'
        @current_degree.zero? ? 360 : @current_degree
      when 'left'
        @current_degree == 360 ? 0 : @current_degree
    end
  end
end