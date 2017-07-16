module ApiHelper
  def check_response_data(real_res)
    real_res = [real_res] unless Array===real_res
    assert @response.ok?, @response.inspect

    response_body = @response.body
    res = ActiveSupport::JSON.decode(response_body)
    res = [res] unless Array===res

    assert res, res
    assert_equal real_res.length, res.length, print_failure_data(real_res, res)

    res.each_index do |i|
      real_values = real_res[i]
      real_values = real_values.attributes if ActiveRecord::Base===real_values
      res[i].each_pair do |name, value|
        assert_equal real_values[name.to_s].to_json, value.to_json
      end
    end
  end

  def print_failure_data(real, from_api)
    "Real result: #{real}\nApi sent: #{from_api}"
  end
end
