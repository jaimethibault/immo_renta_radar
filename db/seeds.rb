require "rest-client"
require 'nokogiri'

def populate_listings_retrieved_by_seloger_api(type_bien, min_price, max_price, search_type, cp)
  # arguments info for the method
    # type_bien: Appartement: 1, Maison: 2
    # min_price: 0
    # max_price: 200000
    # search_type: 2 #(1|2) renting or selling
    # cp: 780043 # cp to codeInsee (https://public.opendatasoft.com/explore/dataset/correspondance-code-insee-code-postal/table/)

  # building the request
  base_url = "http://ws.seloger.com/search.xml?"
  query = "idtypebien=#{type_bien}&pxmin=#{min_price}&pxmax=#{max_price}&idtt=#{search_type}&ci=#{cp}"

  # calling the API
  response = RestClient.get(base_url + query)

  # parsing the response
  document  = Nokogiri::XML(response)

  # displaying data
  puts ">>>>>>>>>>>>>>"

  document.root.xpath('annonces').each do |annonce|
    annonce.xpath('annonce').each do |element|
      idAnnonce   = element.xpath('idAnnonce').text
      surface     = element.xpath('surface').text
      prix        = element.xpath('prix').text
      ville       = element.xpath('ville').text
      cp          = element.xpath('cp').text

      puts "#{idAnnonce} | #{prix.to_f.fdiv(surface.to_f).round(0)}€/m2 | #{surface}m2 pour #{prix}€ à #{cp} | #{ville}"
      Listing.create!(seloger_id: idAnnonce, surface: surface.to_f, price: prix.to_f, city: ville, cp: cp)
      puts Listing.last
    end
  end

  puts "<<<<<<<<<<<<<<"
end

# buy
populate_listings_retrieved_by_seloger_api(1,0,200000,2,780043)
# display_listings_retrieved_by_seloger_api(1,200000,600000,2,780043)
# display_listings_retrieved_by_seloger_api(1,0,200000,2,750110)

# rent
# display_listings_retrieved_by_seloger_api(1,0,200000,1,780043)
# display_listings_retrieved_by_seloger_api(1,0,200000,1,750110)
