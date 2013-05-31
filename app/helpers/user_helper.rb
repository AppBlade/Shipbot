module UserHelper

  def main_provider(user)
	if user.access_keys.count > 0
  		user.access_keys.first.service
  	else
  		'no known provider'
	end
  end

  def main_provider_icon(user)
	if main_provider(user) == 'github'
		return 'icon-github'
	else
		return 'icon-cog'
	end
  end


end
