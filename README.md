# Cowsay Ruby 🐄💬

A Ruby implementation of the classic `cowsay` command-line utility with enhanced formatting capabilities and customizable cow expressions.

## Features

- 🎭 **17 different eye types** - from default to manga style
- 👄 **7 mouth expressions** - including vampire fangs and smoking
- 🎲 **Random expressions** - let the cow surprise you
- 📦 **Smart data formatting** - handles Arrays, Hashes, and ActiveRecord objects
- 💭 **Say or Think modes** - speech bubbles or thought clouds
- 🎨 **Unicode box drawing** - beautiful bubble borders

## Installation

This is a standalone Ruby module, not a published gem. To use it in your project:

### Option 1: Add to your project
1. Copy the `cowsay.rb` file to your project directory
2. Require it in your Ruby files:

```ruby
require_relative 'cowsay'
```

### Option 2: Keep it organized
1. Create a `lib/` or `utils/` directory in your project
2. Place `cowsay.rb` in that directory
3. Add the directory to your `.gitignore` if you don't want to commit it:

```gitignore
# Utility scripts
utils/cowsay.rb
# or
lib/cowsay.rb
```

4. Require it with the proper path:

```ruby
require_relative 'lib/cowsay'
# or
require_relative 'utils/cowsay'
```

### Option 3: Git stash for temporary use
If you're just experimenting or using it temporarily:

```bash
# Add the file and stash it
git add cowsay.rb
git stash push -m "Add cowsay utility"

# Later, when you want to use it again
git stash apply
```

## Basic Usage

### Simple Messages

```ruby
cowsay("Hello World!")
```

```
╔═══════════════╗
║ Hello World!  ║
╚═══════════════╝
                 \   ^___^
                  \  (oo)\______
                    (••)\       )\/\
                     ‾‾ ||----w |
                        ||     ||
```

### Thinking Mode

```ruby
cowthink("Hmm, interesting...")
```

```
╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
╎ Hmm, interesting... ╎
╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯
                 O   ^___^
                  o  (oo)\______
                    (••)\       )\/\
                     ‾‾ ||----w |
                        ||     ||
```

## Customization Options

### Eye Types

Choose from 17 different eye expressions:

```ruby
# Predefined eye types
cowsay("I'm dead!", eyes: :dead)            # xx
cowsay("Money!", eyes: :greedy)             # $$
cowsay("Watching you...", eyes: :paranoid)  # @@
cowsay("So tired...", eyes: :tired)         # --
cowsay("WIRED!", eyes: :wired)              # OO
cowsay("Sleepy time", eyes: :sleepy)        # zz
cowsay("Beep boop", eyes: :robocop)         # ══
cowsay("Future cow", eyes: :cyborg)         # ⭕⭕
cowsay("Kawaii!", eyes: :manga)             # ◕◕

# Random eyes
cowsay("Surprise me!", eyes: :random)
```

**Available eye types:**
- `:default` - oo
- `:robocop` - ══  
- `:cyborg` - ⭕⭕
- `:dead` - xx
- `:greedy` - $$
- `:paranoid` - @@
- `:stoned` - **
- `:tired` - --
- `:wired` - OO
- `:young` - ..
- `:sleepy` - zz
- `:confused` - oO
- `:big_eyes` - 00
- `:cartoon` - ⊙⊙
- `:wink` - o~
- `:look_up` - ⍝⍝
- `:manga` - ◕◕

### Mouth Types

Express different moods with 7 mouth options:

```ruby
cowsay("Whoa!", mouth: :surprised)            # O/
cowsay("I'm speechless", mouth: :speechless)  # ⊂⊃
cowsay("Bleh I'm dead", mouth: :dead)         # U‾
cowsay("Muhahaha", mouth: :vampire)           # ▽▽
cowsay("Cool story", mouth: :smoking)         # ⧐-

# Random mouth
cowsay("What will I say?", mouth: :random)
```

**Available mouth types:**
- `:default` - ‾‾
- `:dead` - U‾
- `:surprised` - O/
- `:amazed` - o/
- `:speechless` - ⊂⊃
- `:vampire` - ▽▽
- `:smoking` - ⧐-

### Combine Options

```ruby
# Mix and match for personality
cowsay("Time for bed!", eyes: :sleepy, mouth: :speechless)
cowsay("Random cow!", eyes: :random, mouth: :random)
```

## Data Structure Formatting

Cowsay can beautifully format complex Ruby data structures:

### Arrays

```ruby
cowsay([1, 2, 3, "hello", "world"])
```

```
╔═══════════════╗
║ [             ║
║   1,          ║
║   2,          ║
║   3,          ║
║   "hello",    ║
║   "world"     ║
║ ]             ║
╚═══════════════╝
```

### Hashes

```ruby
cowsay({name: "Ruby", type: "language", awesome: true})
```

```
╔═══════════════════════╗
║ {                     ║
║   name: "Ruby",       ║
║   type: "language",   ║
║   awesome: true       ║
║ }                     ║
╚═══════════════════════╝
```

### ActiveRecord Objects

When used in Rails applications, cowsay will format ActiveRecord objects showing their attributes:

```ruby
user = User.find(1)
cowsay(user)
```

```
╔═══════════════════════╗
║ User:                 ║
║ {                     ║
║   id: 1,              ║
║   name: "John Doe",   ║
║   email: "john@..."   ║
║ }                     ║
╚═══════════════════════╝
```

## API Reference

### Main Methods

#### `cowsay(message, options = {})`
Display a message in a speech bubble with a cow.

#### `cowthink(message, options = {})`  
Display a message in a thought bubble with a cow.

#### `Cowsay.say(message, options = {})`
Class method equivalent to `cowsay()`.

#### `Cowsay.think(message, options = {})`
Class method equivalent to `cowthink()`.

### Options

- `:eyes` - Symbol or string specifying eye type (see eye types above)
- `:mouth` - Symbol or string specifying mouth type (see mouth types above)

Both options accept `:random` to randomly select from available types.

## Architecture

The file is structured with clean separation of concerns:

- **`Cowsay`** - Main module with public API
- **`Renderer`** - Orchestrates cow and bubble rendering  
- **`BubbleBuilder`** - Creates speech/thought bubbles with proper sizing
- **`CowTemplate`** - Handles cow ASCII art rendering
- **`EyeSelector`** & **`MouthSelector`** - Manage facial expressions
- **`Formatter`** - Formats complex Ruby data structures

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Add tests for your changes
4. Commit your changes (`git commit -am 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Original `cowsay` by Tony Monroe
- Ruby verions `ruby_cowsay` by [Patrick Tulskie](https://github.com/PatrickTulskie/ruby_cowsay)
- Inspired by the classic Unix command-line tool
- Built with ❤️ for the Ruby community

---

**Moo-tivational Quote:** *"The cow says what needs to be said!"* 🐄 ✨