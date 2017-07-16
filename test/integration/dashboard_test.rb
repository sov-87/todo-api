require 'test_helper'
require 'helpers/api_helper'

class DashboardTest < ActionDispatch::IntegrationTest

  include ApiHelper

  test "index" do
    get "/"

    real_res = {
      "total_boards" => 11,
      "total_tasks" => 70,
      "incomplete_tasks" => 50
    }

    check_response_data(real_res)
  end
end
