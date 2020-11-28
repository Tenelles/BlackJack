# frozen_string_literal: true

require_relative 'player'

class Interface
  class << self
    def highlight
      puts
    end

    def show_text(message)
      puts message
    end

    def get_info(message)
      show_text(message)
      gets.chomp
    end

    def get_limited_info(message, cases)
      puts "#{message} (#{cases.keys.join(', ')})"
      answer = gets.chomp.to_sym
      raise 'Wrong!' unless cases.key?(answer)
      answer
    rescue StandardError
      puts 'Wrong input!'
      retry
    end

    def show_player_cards(player, mode)
      show_text("#{player.name}:")
      player.hand.cards.each do |card|
        print("#{CARDS_LETTERS[card.value]}#{SUITS_ICONS[card.suit]} ") if mode == :show
        print('X*') if mode == :hide
      end
      print " --> #{player.points}" if mode == :show
      puts
    end

    CARDS_LETTERS =
      { two: '2',
        three: '3',
        four: '4',
        five: '5',
        six: '6',
        seven: '7',
        eight: '8',
        nine: '9',
        ten: '10',
        jack: 'J',
        queen: 'Q',
        king: 'K',
        ace: 'A' }.freeze

    SUITS_ICONS =
      {
        spades: '♠',
        diamonds: '♦',
        clubs: '♣',
        hearts: '♥'
      }.freeze
  end
end
