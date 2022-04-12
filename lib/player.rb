# frozen_string_literal: true

# This is a class that handles players.
class Player
  attr_reader :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end
end
