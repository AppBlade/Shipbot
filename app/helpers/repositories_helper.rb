module RepositoriesHelper

  def automatic_build_status(repository)
    if repository.github_webhook_id?
      if repository.github_webhook_confirmed?
        'Will be performed when tags are pushed to Github'
      else
        'Will not be performed yet, we are still waiting on Github to confirm the hooks'
      end
    else
      'Will not be performed, you aren\'t an admin on the Github project'
    end
  end

end
