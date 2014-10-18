module TypeKitCli
  module RequestHelpers
    BASE_TYPEKIT_URL='https://typekit.com/api/v1/json/kits/'

    def post_request(uri_str="")
      uri = URI.parse(BASE_TYPEKIT_URL+uri_str)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      headers = {'X-Typekit-Token' => AUTH_TOKEN}
      post_req = Net::HTTP::Post.new(uri.path, headers)
      http.request(post_req)
    end

    def get_request(uri_str="")
      uri = URI.parse(BASE_TYPEKIT_URL+uri_str)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      headers = {'X-Typekit-Token' => AUTH_TOKEN}
      http.get(uri.path, headers)
    end
  end
end