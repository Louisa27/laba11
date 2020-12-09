class Result < ApplicationRecord
    validates :request, uniqueness: true
    
    def self.check_db(data)
        return if (res = find_by(request: data)).nil?
        JSON.parse(res.response)
    end

    def self.insert_in_db(req, res)
        parsed = res.to_json
        record = create(request: req, response: parsed)
        record.save if record.valid?
    end

    def self.check_res(req)
        arr = []
        return res = Result.check_db(req) unless res.nil?
        (req.to_i + 1).times { |i| arr.append(i) if (i * i).to_s.reverse.to_i == (i * i) };
        Result.insert_in_db(req, arr)
        arr
    end

    def self.parse_db
        Result.all.map { |rec| [rec.request, rec.response] }
    end
end
