# gossip.rb
require 'csv'

# Classe Gossip (le modèle)
class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  # Méthode pour enregistrer le gossip dans un fichier CSV
  def save
    CSV.open('./db/gossips.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = [] # Crée un tableau vide pour stocker les potins
    CSV.foreach('./db/gossips.csv') do |row|
      author, content = row # Démontage de chaque ligne du CSV
      gossip_provisoire = Gossip.new(author, content) # Crée un objet Gossip pour chaque ligne
      all_gossips << gossip_provisoire # Ajoute l'objet au tableau
    end
    all_gossips
  end
end
