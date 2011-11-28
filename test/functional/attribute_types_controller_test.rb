require 'test_helper'

class AttributeTypesControllerTest < ActionController::TestCase
  setup do
    @attribute_type = attribute_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attribute_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attribute_type" do
    assert_difference('AttributeType.count') do
      post :create, attribute_type: @attribute_type.attributes
    end

    assert_redirected_to attribute_type_path(assigns(:attribute_type))
  end

  test "should show attribute_type" do
    get :show, id: @attribute_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attribute_type.to_param
    assert_response :success
  end

  test "should update attribute_type" do
    put :update, id: @attribute_type.to_param, attribute_type: @attribute_type.attributes
    assert_redirected_to attribute_type_path(assigns(:attribute_type))
  end

  test "should destroy attribute_type" do
    assert_difference('AttributeType.count', -1) do
      delete :destroy, id: @attribute_type.to_param
    end

    assert_redirected_to attribute_types_path
  end
end
