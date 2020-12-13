class HomeController < ApplicationController
  before_action :check_params, only: %(output)

  def input; end

  def output
    @result = Result.create_or_get_by_request(@request)
  end

  def serialize_db
    render xml: Result.all.to_xml
  end

  def last_rec
    render xml: (res = Result.last).nil? ? ["База данных пуста"].to_xml : res.to_xml
  end

  protected

  def check_params
    @request = Integer(params[:txt], exception: false)
    @error = 'Введено не число' if @request.nil?
    render :output unless @error.nil?
  end
end