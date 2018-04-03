require './lib/seloger_api'

# seeding for sale listings
# SelogerApi.new.populate_listings(1,0,200000,2,780043, 'sale')
# display_listings_retrieved_by_seloger_api(1,200000,600000,2,780043)
# display_listings_retrieved_by_seloger_api(1,0,200000,2,750110)

# seeding for rent listings
SelogerApi.new.populate_listings(1,0,200000,1,780043, 'rent')
# display_listings_retrieved_by_seloger_api(1,0,200000,1,750110)
