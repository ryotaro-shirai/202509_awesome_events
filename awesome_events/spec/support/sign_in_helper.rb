module SignInHelper
  def sign_in_as(user)
    OmniAuth.config.mock_auth[:github] =  github_mock(user)
    case 
    when respond_to?(:visit)
      visit root_path
      click_on "Githubでログイン"
    when respond_to?(:get)
      get "/auth/github/callback"
    else
      raise NotImplementedError
    end
    @current_user = user
  end

  def current_user
    @current_user
  end

  def github_mock(user)
    OmniAuth::AuthHash.new(
      provider: "github",
      uid: user.uid,
      info: {
        nickname: user.name,
        image: user.image_url
      }
    )
  end
end