require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "Profile Tester",
      email: "profile_tester@example.com",
      password: "password",
      password_confirmation: "password",
      role: :artist,
      status: :active
    )
    @profile = @user.create_profile!(display_name: "Old Name", bio: "before")

    post login_path, params: { email: @user.email, password: "password" }
  end

  test "should update profile" do
    patch mypage_path, params: {
      profile: {
        display_name: "New Name",
        bio: "after",
        area: "Tokyo"
      }
    }

    assert_redirected_to mypage_path
    follow_redirect!
    assert_response :success

    @profile.reload
    assert_equal "New Name", @profile.display_name
    assert_equal "after", @profile.bio
    assert_equal "Tokyo", @profile.area
  end

  test "should render errors when profile update is invalid" do
    patch mypage_path, params: {
      profile: {
        display_name: "",
        bio: "after"
      }
    }

    assert_response :unprocessable_entity
    assert_includes response.body, "入力内容を確認してください。"

    @profile.reload
    assert_equal "Old Name", @profile.display_name
  end
end