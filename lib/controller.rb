require 'sinatra'
require 'pry'
require_relative 'gossip'

class ApplicationController < Sinatra::Base
  def initialize
    super
    CSV.foreach('./db/gossips.csv') do |row|
      author, content = row # Démontage de chaque ligne du CSV
      Gossip.new(author, content) # Crée un objet Gossip pour chaque ligne
    end
  end
    
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    author = params['gossip_author']
    content = params['gossip_content']
    gossip = Gossip.new(author, content)
    gossip.save
    redirect '/'
  end

  
  get '/gossips/:id' do
    id = params['id']
    gossip = Gossip.find(id)
  
    if gossip
      erb :show, locals: { gossip: gossip }
    else
      "Potin non trouvé"
    end
  end  
end


# binding.pry