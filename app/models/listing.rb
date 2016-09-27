# require 'elasticsearch/model'

class Listing < ActiveRecord::Base
  
  validates :title, presence: true
  validates :description, presence: true
  validates :price_per_night, presence: true
  validates :location, presence: true
  validates :room_type, presence: true
  validates :guest_capacity, presence: true

  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  searchkick

  has_many :reservations, :dependent => :destroy
  belongs_to :user
  scope :price_per_night, -> (min, max) { where('price_per_night >= ? AND price_per_night <= ?' , min.to_i, max.to_i) }
  mount_uploaders :photos, PhotoUploader

#   def self.search(query)
#   __elasticsearch__.search(
#     {
#       query: {
#         multi_match: {
#           query: query,
#           fields: ['location^10', 'string']
#         }
#       },
#       highlight: {
#         pre_tags: ['<em>'],
#         post_tags: ['</em>'],
#         fields: {
#           location: {},
#           string: {}
#         }
#       }
#     }
#   )
# end

# settings index: { number_of_shards: 1 } do
#   mappings dynamic: 'false' do
#     indexes :location, analyzer: 'english', index_options: 'offsets'
#     indexes :string, analyzer: 'english'
#   end
# end

end


# # Delete the previous articles index in Elasticsearch
# Listing.__elasticsearch__.client.indices.delete index: Listing.index_name rescue nil

# # Create the new index with the new mapping
# Listing.__elasticsearch__.client.indices.create \
#   index: Listing.index_name,
#   body: { settings: Listing.settings.to_hash, mappings: Listing.mappings.to_hash }

# # Index all article records from the DB to Elasticsearch
# Listing.import 




