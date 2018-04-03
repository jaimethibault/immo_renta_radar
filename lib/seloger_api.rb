require 'rest-client'
require 'nokogiri'

class SelogerApi

  def populate_listings(type_bien, min_price, max_price, search_type, cp, type_of_listing)
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

      if type_of_listing == 'sale'
        ForSaleListing.create!(seloger_id: idAnnonce, surface: surface.to_f, price: prix.to_f, city: ville, cp: cp)
        puts "Created ForSaleListing with id: #{ForSaleListing.last.id}"
      elsif type_of_listing == 'rent'
        ForRentListing.create!(seloger_id: idAnnonce, surface: surface.to_f, rent_price: prix.to_f, city: ville, cp: cp)
        puts "Created ForRentListing with id: #{ForRentListing.last.id}"
      end
    end
  end

  puts "<<<<<<<<<<<<<<"
end

end
