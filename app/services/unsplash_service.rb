class UnsplashService
  def self.search(query)
    access_key = 'SuPXGqGpPv32qZpl9DNNZX7hO-KzwTihkP2cE19sRhs' # Replace with your actual Unsplash Access Key
    url = "https://api.unsplash.com/search/photos"

    response = Faraday.get(url, { query: query }, { "Authorization" => "Client-ID #{access_key}" })

    JSON.parse(response.body)
  end
end
