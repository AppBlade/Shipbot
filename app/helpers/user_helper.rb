module UserHelper

 def time_since(date_time)
	string_frmt = "%l:%M %p today" if date_time.today?
	string_frmt ||= "%A" if (Time.now - date_time) < 7.days 
	string_frmt ||= "%b %d" if (Time.now - date_time) < 1.month
	string_frmt ||= "%m/%d/%Y"
	return date_time.strftime(string_frmt) unless string_frmt == "%b %d"
	date_time.strftime(string_frmt).ordinalize
 end

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
