class API

    @@all_pages = []

    def self.extracting_data
        base_url = "https://rickandmortyapi.com/api/character?page="
        response = RestClient.get(base_url)
        data = JSON.parse(response.body)

        total_pages = data["info"]["pages"]
        #total_pages = 34
        
        page_number = 0
        until page_number == total_pages
            page_number += 1
            @@all_pages << "#{base_url}#{page_number}"
        end
    
        all_data = []

        @@all_pages.each do |url|
            individual_response = RestClient.get(url)
            all_data << JSON.parse(individual_response)["results"]
        end

        characters = all_data.flatten

        #may not be needed in API class
        characters.each do |character|
            Character.new(character["name"], character["species"], character["type"], character["location"]["name"], character["episode"])
        end
    end
end

#data["results"].select {|character| character["name"] == "Beth Smith"}
#data["results"].select {|character| character["name"].include?("Beth")}