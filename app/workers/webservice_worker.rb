class WebserviceWorker
  include Sidekiq::Worker
  
  def perform()
    # TODO Add URL to perform the api call.
    uri = URI.parse(url),  post_args = { }
    
    resp, data = Net::HTTP.post_form(uri, post_args)
    
    uri = URI.parse("http://example.com/")
    resp, data = Net::HTTP.post_form(uri)
    # TODO Please write the code after getting the api response
  end
end

