# frozen_string_literal: true

module Cowsay
  INDENT = "  "
  DEFAULT_BUBBLE_WIDTH = 13

  def self.say(message, options = {})
    Renderer.new(message, options).say
  end

  def self.think(message, options = {})
    Renderer.new(message, options).think
  end

  class Renderer
    def initialize(message, options = {})
      @message = Formatter.new(message).format
      @options = options
    end

    def say
      cow = CowTemplate.new(@options).render("\\")
      bubble = BubbleBuilder.new(@message).build_say_bubble
      puts bubble + cow
    end

    def think
      cow = CowTemplate.new(@options).render("oO")
      bubble = BubbleBuilder.new(@message).build_think_bubble
      puts bubble + cow
    end
  end

  class BubbleBuilder
    def initialize(message)
      @lines = message.split("\n")
      @width = calculate_width
    end

    def build_say_bubble
      bubble = []
      bubble << "╔#{'═' * (@width + 2)}╗"
      @lines.each do |line|
        bubble << "║ #{line.ljust(@width)} ║"
      end
      bubble << "╚#{'═' * (@width + 2)}╝"
      bubble.join("\n") << "\n"
    end

    def build_think_bubble
      bubble = []
      bubble << "╭#{'╌' * (@width + 2)}╮"
      @lines.each do |line|
        bubble << "╎ #{line.ljust(@width)} ╎"
      end
      bubble << "╰#{'╌' * (@width + 2)}╯"
      bubble.join("\n") << "\n"
    end

    private

    def calculate_width
      max_line_width = @lines.map(&:length).max
      [max_line_width, DEFAULT_BUBBLE_WIDTH].max
    end
  end

  class CowTemplate
    COW_TEMPLATE = <<-COW
                 $bubble_char2   ^___^
                  $bubble_char1  ($eyes)\\______
                    (••)\\       )\\/\\
                     $mouth ||----w |
                        ||     ||
    COW

    def initialize(options = {})
      @options = options
    end

    def render(bubble_char = "\\")
      eye_pattern = EyeSelector.new(@options).select
      mouth_pattern = MouthSelector.new(@options).select

      COW_TEMPLATE.gsub("$bubble_char1", bubble_char.first)
                  .gsub("$bubble_char2", bubble_char.last)
                  .gsub("$eyes", eye_pattern)
                  .gsub("$mouth", mouth_pattern)
    end
  end

  class EyeSelector
    EYE_TYPES = {
      default: "oo",
      robocop: "══",
      cyborg: "⭕⭕",
      dead: "xx",
      greedy: "$$",
      paranoid: "@@",
      stoned: "**",
      tired: "--",
      wired: "OO",
      young: "..",
      sleepy: "zz",
      confused: "oO",
      big_eyes: "00",
      cartoon: "⊙⊙",
      wink: "o~",
      look_up: "⍝⍝",
      manga: "◕◕"
    }.freeze

    def initialize(options = {})
      @eyes = options[:eyes]
    end

    def select
      return EYE_TYPES.values.sample if @eyes.to_s == "random"

      eye_key = EYE_TYPES.key?(@eyes&.to_sym) ? @eyes.to_sym : :default
      EYE_TYPES[eye_key]
    end
  end

  class MouthSelector
    MOUTH_TYPES = {
      default: "‾‾",
      dead: "U‾",
      surprised: "O/",
      amazed: "o/",
      speechless: "⊂⊃",
      vampire: "▽▽",
      smoking: "⧐-"
    }.freeze

    def initialize(options = {})
      @mouth = options[:mouth]
    end

    def select
      return MOUTH_TYPES.values.sample if @mouth.to_s == "random"

      mouth_key = MOUTH_TYPES.key?(@mouth&.to_sym) ? @mouth.to_sym : :default
      MOUTH_TYPES[mouth_key]
    end
  end

  class Formatter
    def initialize(value)
      @value = value
    end

    def format(depth = 0)
      case @value
      when defined?(ApplicationRecord) && ApplicationRecord
        format_active_record(@value, depth)
      when Hash
        format_hash(@value, depth)
      when Array
        format_array(@value, depth)
      when String
        format_string(@value)
      when NilClass
        "nil"
      else
        @value.to_s
      end
    end

    private

    def indent(depth)
      INDENT * depth
    end

    def format_active_record(record, depth = 0)
      attrs = record.attributes.map do |k, v|
        "#{indent(depth + 1)}#{k}: #{self.class.new(v).format(depth + 1)}"
      end

      "#{indent(depth)}#{record.class.name}:\n" \
        "#{indent(depth)}{\n" \
        "#{attrs.join(",\n")}\n" \
        "#{indent(depth)}}"
    end

    def format_hash(hash, depth = 0)
      return "#{indent(depth)}{}" if hash.empty?

      pairs = hash.map do |key, value|
        "#{indent(depth + 1)}#{key}: #{self.class.new(value).format(depth + 1)}"
      end

      "#{indent(depth)}{\n#{pairs.join(",\n")}\n#{indent(depth)}}"
    end

    def format_array(array, depth = 0)
      return "#{indent(depth)}[]" if array.empty?

      items = array.map do |item|
        "#{indent(depth + 1)}#{self.class.new(item).format(depth + 1)}"
      end

      "#{indent(depth)}[\n#{items.join(",\n")}\n#{indent(depth)}]"
    end

    def format_string(string)
      "\"#{string}\""
    end
  end
end

def cowsay(message, options = {})
  Cowsay.say(message, options)
end

def cowthink(message, options = {})
  Cowsay.think(message, options)
end

# Usage examples:
# cowsay("Hello World!")
# cowthink("Hmm, interesting...")
# cowsay("I'm dead!", eyes: :dead)
# cowsay("Money!", eyes: :greedy)
# cowsay("Watching you...", eyes: :random, mouth: :surprised)
# cowsay("Watching you...", eyes: :random, mouth: :random)
# cowsay([1, 2, 3], eyes: :tired)
