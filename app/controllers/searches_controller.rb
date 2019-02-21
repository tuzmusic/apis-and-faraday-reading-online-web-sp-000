class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'JH3XXDQUANJDED1LWP5ODUK122IAT0OQ3LUVDSKHRBFNMF3D'
        req.params['client_secret'] = 'ORNTTLWFXHWITHJ3GVRUSLHOYGCYP2FPK2H3MM3VNP24O3TX'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetails']
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
      render 'search'
  end
end
