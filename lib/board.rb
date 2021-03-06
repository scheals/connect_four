# frozen_string_literal: true

# This is a class that handles a Connect Four gameboard with its rules.
class Board
  attr_reader :board

  def initialize
    @board = Array.new(6) { Array.new(7) { '  ' } }
  end

  # rubocop: disable Metrics/AbcSize
  def show
    puts <<-HEREDOC
       1     2     3     4     5     6     7

    || #{sixth_row[0]} || #{sixth_row[1]} || #{sixth_row[2]} || #{sixth_row[3]} || #{sixth_row[4]} || #{sixth_row[5]} || #{sixth_row[6]} ||
    || #{fifth_row[0]} || #{fifth_row[1]} || #{fifth_row[2]} || #{fifth_row[3]} || #{fifth_row[4]} || #{fifth_row[5]} || #{fifth_row[6]} ||
    || #{fourth_row[0]} || #{fourth_row[1]} || #{fourth_row[2]} || #{fourth_row[3]} || #{fourth_row[4]} || #{fourth_row[5]} || #{fourth_row[6]} ||
    || #{third_row[0]} || #{third_row[1]} || #{third_row[2]} || #{third_row[3]} || #{third_row[4]} || #{third_row[5]} || #{third_row[6]} ||
    || #{second_row[0]} || #{second_row[1]} || #{second_row[2]} || #{second_row[3]} || #{second_row[4]} || #{second_row[5]} || #{second_row[6]} ||
    || #{first_row[0]} || #{first_row[1]} || #{first_row[2]} || #{first_row[3]} || #{first_row[4]} || #{first_row[5]} || #{first_row[6]} ||
     \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C

    HEREDOC
  end
  # rubocop: enable Metrics/AbcSize

  def drop(token, column)
    target_column = find_column(column)
    last_token = topmost_token(target_column)
    return first_row[column - 1] = token unless last_token

    board[last_token - 1][column - 1] = token
  end

  def win?
    four_in_a_row? || four_in_a_column? || four_in_a_diagonal?
  end

  def tie?
    board.reject { |row| row.all? { |space| space == "\u26AA" || space == "\u26AB" } }.empty?
  end

  def valid_column?(column)
    return true if (1..7).include?(column) && !full?(column)

    false
  end

  private

  def find_column(column)
    board.transpose[column - 1]
  end

  def topmost_token(column)
    column.index { |space| space == "\u26AA" || space == "\u26AB" }
  end

  def full?(column)
    return true if topmost_token(find_column(column)).zero?

    false
  end

  def create_diagonals
    bottom_diagonals = create_bottom_diagonals
    top_diagonals = create_top_diagonals
    top_diagonals + bottom_diagonals
  end

  def create_top_diagonals
    diagonals = []
    sixth_row.each_index do |index|
      diagonals << [[sixth_row[index]], [sixth_row[index]]]
      diagonals[index][0] += top_right_left_diagonals(index)
      diagonals[index][1] += top_left_right_diagonals(index)
    end
    diagonals
  end

  def create_bottom_diagonals
    diagonals = []
    first_row.each_index do |index|
      diagonals << [[first_row[index]], [first_row[index]]]
      diagonals[index][0] += bottom_right_left_diagonals(index)
      diagonals[index][1] += bottom_left_right_diagonals(index)
    end
    diagonals
  end

  def top_left_right_diagonals(index)
    diagonals = []
    next_row = 1
    next_column = index + 1
    until next_column > 6 || next_row > 5
      diagonals << board[next_row][next_column]
      next_row += 1
      next_column += 1
    end
    diagonals
  end

  def top_right_left_diagonals(index)
    diagonals = []
    next_row = 1
    next_column = index - 1
    until next_column.negative? || next_row > 5
      diagonals << board[next_row][next_column]
      next_row += 1
      next_column -= 1
    end
    diagonals
  end

  def bottom_left_right_diagonals(index)
    diagonals = []
    next_row = 4
    next_column = index + 1
    until next_column > 6 || next_row.negative?
      diagonals << board[next_row][next_column]
      next_row -= 1
      next_column += 1
    end
    diagonals
  end

  def bottom_right_left_diagonals(index)
    diagonals = []
    next_row = 4
    next_column = index - 1
    until next_column.negative? || next_row.negative?
      diagonals << board[next_row][next_column]
      next_row -= 1
      next_column -= 1
    end
    diagonals
  end

  def four_in_a_row?
    case board
    in [*, [*, "\u26AA", "\u26AA", "\u26AA", "\u26AA", *], *] then return true
    in [*, [*, "\u26AB", "\u26AB", "\u26AB", "\u26AB", *], *] then return true
    else false
    end
  end

  def four_in_a_column?
    case board.transpose
    in [*, [*, "\u26AA", "\u26AA", "\u26AA", "\u26AA", *], *] then return true
    in [*, [*, "\u26AB", "\u26AB", "\u26AB", "\u26AB", *], *] then return true
    else false
    end
  end

  def four_in_a_diagonal?
    diagonals = create_diagonals
    case diagonals
    in [*, [*, [*, "\u26AA", "\u26AA", "\u26AA", "\u26AA", *], *], *] then return true
    in [*, [*, [*, "\u26AB", "\u26AB", "\u26AB", "\u26AB", *], *], *] then return true
    else false
    end
    false
  end

  def first_row
    board[5]
  end

  def second_row
    board[4]
  end

  def third_row
    board[3]
  end

  def fourth_row
    board[2]
  end

  def fifth_row
    board[1]
  end

  def sixth_row
    board[0]
  end
end
