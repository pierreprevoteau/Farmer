require 'test_helper'

class TranscodesControllerTest < ActionController::TestCase
  setup do
    @transcode = transcodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transcodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transcode" do
    assert_difference('Transcode.count') do
      post :create, transcode: { extention: @transcode.extention, general_option: @transcode.general_option, infile_option: @transcode.infile_option, outfile_option: @transcode.outfile_option, title: @transcode.title }
    end

    assert_redirected_to transcode_path(assigns(:transcode))
  end

  test "should show transcode" do
    get :show, id: @transcode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transcode
    assert_response :success
  end

  test "should update transcode" do
    patch :update, id: @transcode, transcode: { extention: @transcode.extention, general_option: @transcode.general_option, infile_option: @transcode.infile_option, outfile_option: @transcode.outfile_option, title: @transcode.title }
    assert_redirected_to transcode_path(assigns(:transcode))
  end

  test "should destroy transcode" do
    assert_difference('Transcode.count', -1) do
      delete :destroy, id: @transcode
    end

    assert_redirected_to transcodes_path
  end
end
