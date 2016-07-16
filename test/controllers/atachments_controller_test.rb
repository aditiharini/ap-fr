require 'test_helper'

class AtachmentsControllerTest < ActionController::TestCase
  setup do
    @atachment = atachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:atachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create atachment" do
    assert_difference('Atachment.count') do
      post :create, atachment: {  }
    end

    assert_redirected_to atachment_path(assigns(:atachment))
  end

  test "should show atachment" do
    get :show, id: @atachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @atachment
    assert_response :success
  end

  test "should update atachment" do
    patch :update, id: @atachment, atachment: {  }
    assert_redirected_to atachment_path(assigns(:atachment))
  end

  test "should destroy atachment" do
    assert_difference('Atachment.count', -1) do
      delete :destroy, id: @atachment
    end

    assert_redirected_to atachments_path
  end
end
