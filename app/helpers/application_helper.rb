module ApplicationHelper
  require 'embedly'
  require 'json'

  def display(url)
    embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])

    obj = embedly_api.extract :url => url
    obj.first.favicon_url
  end

  def describe(url)
    embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])

    obj = embedly_api.oembed :url => url
    obj.first.description
  end

  def title(url)
    embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])

    obj = embedly_api.extract :url => url
    obj.first.provider_name
  end
end
