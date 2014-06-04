require 'test_helper'

class Recruit::EntriesControllerTest < ActionController::TestCase
  setup do
    @recruit_entry = recruit_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recruit_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recruit_entry" do
    assert_difference('Recruit::Entry.count') do
      post :create, recruit_entry: {  }
    end

    assert_redirected_to recruit_entry_path(assigns(:recruit_entry))
  end

  test "should show recruit_entry" do
    get :show, id: @recruit_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recruit_entry
    assert_response :success
  end

  test "should update recruit_entry" do
    patch :update, id: @recruit_entry, recruit_entry: {  }
    assert_redirected_to recruit_entry_path(assigns(:recruit_entry))
  end

  test "should destroy recruit_entry" do
    assert_difference('Recruit::Entry.count', -1) do
      delete :destroy, id: @recruit_entry
    end

    assert_redirected_to recruit_entries_path
  end
end
