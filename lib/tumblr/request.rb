require 'json'

module Tumblr
  module Request

    #Performs a get request
    def get(path, params={})
      response = connection.get do |req|
        req.url path 
        req.params = params
      end
      #check for errors and encapsulate
      response.body['response']
    end
    
    #Performs post request
    def post(path, params={})
      response = connection.post do |req|
        req.url path
        req.body = params unless params.empty?
      end
      #Check for errors and encapsulate
      # @PBH  - quick and dirty way of 
      statuscode = response.body['meta']['status']
      resp = 

      #if the staus is good - say so
      success = [200, 201].include?(statuscode)
      if success
        result = response.body['response']
      else
        #in this case = send whole body
        result = response.body
      end
      result['success'] = success
      result
    end
  end
end
