require 'gosu'

class AnimationWindow < Gosu::Window
	def initialize filename, width, height, interval
		super(width, height, false)
		@filename, @width, @height, @interval = filename, width, height, interval
		@images = Gosu::Image.load_tiles self, filename, width, height, true
		@current_frame = 0
		@current = 0.0
	end

	def button_down id
		case id
		when Gosu::KbEscape
			self.close
		end
	end	

	def update
		dt = 16.0
		@current += dt
		if @current > @interval
			@current = 0.0
			@current_frame += 1
			if @current_frame > @images.size - 1
				@current_frame = 0
			end
		end
	end

	def draw
		@images[@current_frame].draw(0, 0, 0)
	end
end

filename, width, height, interval = ARGV
width = width.to_i
height = height.to_i
interval = interval.to_i

puts "File: #{filename}"
puts "Size: #{width} x #{height}"
puts "Interval: #{interval}"

window = AnimationWindow.new(filename, width, height, interval)
window.show
