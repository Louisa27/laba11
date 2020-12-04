require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  test 'add new record to db' do
    req = '1'
    res = [0,1].to_json
    unless exs = Result.find_by(request: req).nil?
      Result.find_by(request: req).destroy
    end
    Result.create(request: req, response: res).save
    assert_not_nil Result.find_by(request: req).nil?
    Result.find_by(request: req).destroy if exs
  end

  test 'duplicate addition' do
    req = '1'
    res = [0,1].to_json
    unless exs = Result.find_by(request: req).nil?
      Result.find_by(request: req).destroy
    end
    Result.create(request: req, response: res).save
    assert_not Result.create(request: req, response: '{}').valid?
    Result.find_by(request: req).destroy if exs
  end
end

