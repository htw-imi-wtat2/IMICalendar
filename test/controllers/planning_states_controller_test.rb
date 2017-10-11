require 'test_helper'

class PlanningStatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planning_state = planning_states(:one)
  end

  test "should get index" do
    get planning_states_url
    assert_response :success
  end

  test "should get new" do
    get new_planning_state_url
    assert_response :success
  end

  test "should create planning_state" do
    assert_difference('PlanningState.count') do
      post planning_states_url, params: { planning_state: { announced: @planning_state.announced, date_set: @planning_state.date_set, event_id: @planning_state.event_id, notes: @planning_state.notes, room_booked: @planning_state.room_booked } }
    end

    assert_redirected_to planning_state_url(PlanningState.last)
  end

  test "should show planning_state" do
    get planning_state_url(@planning_state)
    assert_response :success
  end

  test "should get edit" do
    get edit_planning_state_url(@planning_state)
    assert_response :success
  end

  test "should update planning_state" do
    patch planning_state_url(@planning_state), params: { planning_state: { announced: @planning_state.announced, date_set: @planning_state.date_set, event_id: @planning_state.event_id, notes: @planning_state.notes, room_booked: @planning_state.room_booked } }
    assert_redirected_to planning_state_url(@planning_state)
  end

  test "should destroy planning_state" do
    assert_difference('PlanningState.count', -1) do
      delete planning_state_url(@planning_state)
    end

    assert_redirected_to planning_states_url
  end
end
