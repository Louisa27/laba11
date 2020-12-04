class Result < ApplicationRecord
    validates :request, uniqueness: true
    
    def self.check_db(data)
        return if find_by(request: data).nil?
        JSON.parse(Result.find_by(request: data).response)
    end

    def self.insert_in_db(req, res)
        parsed = res.to_json
        record = create(request: req, response: parsed)
        record.save if record.valid?
    end

    def self.parse_db
        Result.all.map { |rec| [rec.request, rec.response] }
    end
end

