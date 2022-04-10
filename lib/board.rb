# frozen_string_literal: true

# This is a class that handles a Connect Four gameboard with its rules.
class Gameboard
  def initialize
    @board = Array.new(6) { Array.new(7) { "\u26F6" } }
  end

  # rubocop: disable Metrics/AbcSize
  def show
    puts <<-HEREDOC

    || #{sixth_row[0]} || #{sixth_row[1]} || #{sixth_row[2]} || #{sixth_row[3]} || #{sixth_row[4]} || #{sixth_row[5]} || #{sixth_row[6]} ||
    || #{fifth_row[0]} || #{fifth_row[1]} || #{fifth_row[2]} || #{fifth_row[3]} || #{fifth_row[4]} || #{fifth_row[5]} || #{fifth_row[6]} ||
    || #{fourth_row[0]} || #{fourth_row[1]} || #{fourth_row[2]} || #{fourth_row[3]} || #{fourth_row[4]} || #{fourth_row[5]} || #{fourth_row[6]} ||
    || #{third_row[0]} || #{third_row[1]} || #{third_row[2]} || #{third_row[3]} || #{third_row[4]} || #{third_row[5]} || #{third_row[6]} ||
    || #{second_row[0]} || #{second_row[1]} || #{second_row[2]} || #{second_row[3]} || #{second_row[4]} || #{second_row[5]} || #{second_row[6]} ||
    || #{first_row[0]} || #{first_row[1]} || #{first_row[2]} || #{first_row[3]} || #{first_row[4]} || #{first_row[5]} || #{first_row[6]} ||
    \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C

    HEREDOC
  end
  # rubocop: enable Metrics/AbcSize

  def drop(token, column)
    target_column = @board.transpose[column - 1]
    last_token = target_column.index { |space| space == "\u26AA" || space == "\u26AB" }
    return first_row[column - 1] = token unless last_token

    @board[last_token - 1][column - 1] = token
  end

  private

  def first_row
    @board[5]
  end

  def second_row
    @board[4]
  end

  def third_row
    @board[3]
  end

  def fourth_row
    @board[2]
  end

  def fifth_row
    @board[1]
  end

  def sixth_row
    @board[0]
  end
end
