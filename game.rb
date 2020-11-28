# frozen_string_literal: true

require_relative 'interface'
require_relative 'player'
require_relative 'deck'

# Game
# methods
#   start - start game
#   finished? - is game finished
class Game
  START_MONEY = 100
  DEFAULT_BET = 10

  def initialize
    @is_finished = false
    @deck = Deck.new()
  end

  def start
    player_name = Interface.get_info('Enter your name:')
    self.player = Player.new(player_name, START_MONEY)
    self.dealer = Player.new('Dealer', START_MONEY)
    new_round until is_finished
    Interface.show_text('Game over!')
  end

  protected

  def new_round
    Interface.highlight
    Interface.show_text("Player: #{player.money}$")
    Interface.show_text("Dealer: #{dealer.money}$")
    Interface.highlight
    self.bank = 0
    deck.generate
    deck.shuffle
    take_first_cards(player, :show)
    take_first_cards(dealer, :hide)

    Interface.highlight
    choice = do_player_choice
    do_dealer_choice unless choice == :open
    sum_up
  end

  def take_first_cards(player, mode)
    self.bank += player.make_bet(DEFAULT_BET)
    player.clear_hand
    player.draw_card(deck)
    player.draw_card(deck)
    Interface.show_player_cards(player, mode)
  end

  def do_player_choice
    choices = { skip: 'skip', draw: 'draw a card', open: 'open the cards' }
    choice = Interface.get_limited_info('Your move:', choices)

    Interface.show_text("#{player.name} choice: #{choices[choice]}.")
    player.draw_card(deck) if choice == :draw
    choice
  end

  def do_dealer_choice
    choices = { skip: 'skip', draw: 'draw a card' }
    choice = if dealer.points >= 17
               :skip
             else
               :draw
             end

    Interface.show_text("#{dealer.name} choice: #{choices[choice]}.")
    dealer.draw_card(deck) if choice == :draw
    choice
  end

  def sum_up
    Interface.highlight
    Interface.show_player_cards(player, :show)
    Interface.show_player_cards(dealer, :show)

    proceed_win

    check_money(player)
    check_money(dealer)

    choice = Interface.get_limited_info('Do you want to continue:', { yes: 'yes', no: 'no' })
    self.is_finished = true if choice == :no
  end

  def proceed_win
    if player.points > dealer.points
      player.take_reward(bank)
      Interface.show_text('You won this round!')
    elsif player.points < dealer.points
      dealer.take_reward(bank)
      Interface.show_text('You lost this round...')
    else
      player.take_reward(bank / 2)
      dealer.take_reward(bank / 2)
      Interface.show_text('Draw')
    end
    Interface.highlight
  end

  def check_money(person)
    return unless person.money < DEFAULT_BET

    Interface.show_text("#{person.name} is bankrupt.")
    self.is_finished = true
  end

  attr_accessor :is_finished, :player, :dealer, :bank, :deck
end
