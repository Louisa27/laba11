class HomeController < ApplicationController
  def input; end

  def output
    @arr = []
    render xml: convert_to_xml(check_res(params[:txt]))
  end

  def serialize_db
    render xml: Result.parse_db.to_xml
  end

  def last_rec
    render xml: Result.parse_db.last.to_xml
  end

  protected

  def convert_to_xml(arr)
    Nokogiri::XML::Builder.new do
      result do
        arr&.each_with_index do |elem, i|
          element do
            index i+1
            value elem 
            square elem*elem
          end
        end
      end
    end
  end

  def check_res(req)
    return Result.check_db(req) unless Result.check_db(req).nil?
    if (check_params(req))
      (req.to_i + 1).times { |i| @arr.append(i) if (i * i).to_s.reverse.to_i == (i * i) };
      Result.insert_in_db(req, @arr)
    end
    @arr
  end

  def check_params(str)
    '!str.empty? && str.split.length == 1 && str.to_i.to_s == str ?'
  end
end
