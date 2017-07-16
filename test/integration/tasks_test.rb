require 'test_helper'
require 'helpers/api_helper'

class TasksTest < ActionDispatch::IntegrationTest

  include ApiHelper

  test "full index" do
    get "/boards/#{boards(:board_1).id}/tasks"

    real_res = boards(:board_1).tasks.to_a

    check_response_data(real_res)
  end

  test "show" do
    get "/boards/#{boards(:board_1).id}/tasks/#{tasks(:uncompleted_task_1_1).id}"

    real_res = Task.find(tasks(:uncompleted_task_1_1).id)

    check_response_data(real_res)
  end

  test "create task" do
    post "/boards/#{boards(:board_1).id}/tasks",
      { task: { description: "created new", title: "created new" } }

    real_res = Task.where(board_id: boards(:board_1).id,
      description: "created new",
      title: "created new").first

    check_response_data(real_res)
  end

  test "completed index" do
    get "/boards/#{boards(:board_1).id}/tasks?type=completed"

    real_res = boards(:board_1).tasks.completed.to_a

    check_response_data(real_res)
  end

  test "incompleted index" do
    get "/boards/#{boards(:board_1).id}/tasks?type=incompleted"

    real_res = boards(:board_1).tasks.incompleted.to_a

    check_response_data(real_res)
  end

  test "complete task" do
    put "/boards/#{boards(:board_1).id}/tasks/#{tasks(:uncompleted_task_1_1).id}/complete"

    real_res = Task.find(tasks(:uncompleted_task_1_1).id)

    check_response_data(real_res)
  end

  test "update task" do
    put "/boards/#{boards(:board_1).id}/tasks/#{tasks(:uncompleted_task_1_1).id}",
      { task: {description: "update", title: "update"} }

    real_res = Task.find(tasks(:uncompleted_task_1_1).id)

    check_response_data(real_res)

    assert_equal real_res.title, "update", "Task title not updated"
    assert_equal real_res.description, "update", "Task description not updated"
  end

  test "destroy task" do
    real_res = Task.find(tasks(:uncompleted_task_1_1).id)

    delete "/boards/#{boards(:board_1).id}/tasks/#{tasks(:uncompleted_task_1_1).id}"

    check_response_data(real_res)

    assert_nil Task.find_by_id(tasks(:uncompleted_task_1_1).id), "Task not deleted"
  end
end
