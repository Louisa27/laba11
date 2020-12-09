class HomeController < ApplicationController
  def input; end

  def output
    @arr = []
    @arr = Result.check_res(params[:txt]) if check_params(params[:txt])
  end

  def serialize_db
    render xml: Result.parse_db.to_xml
  end

  def last_rec
    render xml: Result.parse_db.last.to_xml
  end

  protected

  def check_params(str)
    !str.empty? && str.split.length == 1 && str.to_i.to_s == str
  end
end