require 'test_helper'
require 'helpers/api_helper'

class BoardsTest < ActionDispatch::IntegrationTest

  include ApiHelper

  test "index" do
    get "/boards"

    real_res = Board.all.to_a

    check_response_data(real_res)
  end

  test "show" do
    get "/boards/#{boards(:board_1).id}"

    real_res = boards(:board_1)

    check_response_data(real_res)
  end

  test "create board" do
    post "/boards",
      { board: { description: "created new", title: "created new" } }

    real_res = Board.where(description: "created new", title: "created new").first

    check_response_data(real_res)
  end

  test "update board" do
    put "/boards/#{boards(:board_1).id}",
      { board: { description: "update", title: "update" } }

    real_res = Board.find(boards(:board_1).id)

    check_response_data(real_res)

    assert_equal real_res.title, "update", "Board title not updated"
    assert_equal real_res.description, "update", "Board description not updated"
  end

  test "destroy board" do
    real_res = Board.find(boards(:board_10).id)

    delete "/boards/#{boards(:board_10).id}"

    check_response_data(real_res)

    assert_nil Board.find_by_id(boards(:board_10).id), "Board not deleted"
  end
end
