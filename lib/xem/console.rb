module Xem
  class Console
    attr_reader :xem
    attr_accessor :chars_per_line, :max_visible_lines

    HELP_TEXT = %{
      ? - help
      exit - quit application
      fps - show current fps
      quality - change openGL functions hint
    }

    def initialize(xem)
      @xem = xem
      @visible = false
      @textbuf = "Type ? tos see available commands\n> "
      self.chars_per_line = (xem.video_mode.Width / 8.5).floor
      self.max_visible_lines = 9
    end

    def toggle
      visible? ? hide : show
    end

    def show
      @visible = true
    end

    def hide
      @visible = false
    end

    def visible?
      @visible
    end

    def draw
      y = 0
      space_between_lines = 20
      lines = @textbuf.lines.to_a.reverse.first(max_visible_lines).reverse
      lines.each do |line|
        xem.print([0, y], xem.color('000000'), line.chomp, 0.6)
        y += space_between_lines
      end
      xem.print([0, y - space_between_lines/2], xem.color('000000'), "-" * chars_per_line, 0.6)
    end

    def ascii_press(key)
      if @textbuf.lines.to_a.last.chomp.length < chars_per_line
        @textbuf += key
      else
        @textbuf += "\n" + key
      end
    end

    def non_ascii_press(key)
      case key
        when 294
          @textbuf += "\n" + evaluate_command(@textbuf.lines.to_a.last.chomp.gsub('> ', ''))
          @textbuf += "\n> "
        when 295
          lines = @textbuf.lines.to_a
          lines[-1] = "> " + lines.last[2..-2]
          @textbuf = lines.join
        else
          #@textbuf += "<#{key}>"
      end
    end

    protected

    def evaluate_command(cmd)
      case cmd
        when "exit"
          xem.shutdown
          "shutting down"
        when "fps"
          '%.2f' % xem.fps
        when "quality"
          xem.toggle_gl_hints
          "switched to #{xem.settings.get(:gl_hints) == GL_NICEST ? 'GL_NICEST' : 'GL_FASTEST'}"
        when "?"
          HELP_TEXT
        else
          "unknown command, type ? to see help"
      end
    end
  end

  class Xem
    attr_reader :console

    def enable_console
      settings.set(:console, true)
      @console ||= Console.new(self)
    end
  end
end
