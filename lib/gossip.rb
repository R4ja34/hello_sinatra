# gossip.rb
require 'csv'

# Classe Gossip (le modèle)
class Gossip
  attr_accessor :author, :content, :id
  @@count_id = 0
  @@instances = []
  
  def initialize(author, content)
    @@count_id += 1
    @id = @@count_id
    @author = author
    @content = content
    @@instances << self
  end

  # Méthode pour enregistrer le gossip dans un fichier CSV
  def save
    CSV.open('./db/gossips.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    return @@instances
  end

  def self.find(id)
    all_gossips = Gossip.all
    return all_gossips[(id.to_i-1)] if (id.to_i-1).between?(0, all_gossips.length - 1)
  end
end

