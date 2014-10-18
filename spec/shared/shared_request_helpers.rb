shared_examples TypeKitCli::RequestHelpers do
  let(:http_obj) { double("http") }
  let(:post_request_obj) { double("post_request") }
  let(:uri) { double("uri") }
  TypeKitCli::RequestHelpers::AUTH_TOKEN = "test auth"

  context "#post_request" do
    it 'should append uri_str to base url' do
      test_uri = "test_uri"
      expect(URI).to receive(:parse).with(TypeKitCli::RequestHelpers::BASE_TYPEKIT_URL + test_uri).and_return(uri)

      allow(uri).to receive_messages({host: nil, port: nil, path: nil})
      allow(Net::HTTP).to receive(:new).and_return(http_obj)
      allow(http_obj).to receive_messages({:use_ssl= => nil, request: nil})
      allow(Net::HTTP::Post).to receive(:new).and_return(post_request_obj)
      allow(http_obj).to receive(:request)
      subject.post_request(test_uri)
    end
    it 'should use ssl' do
      allow(URI).to receive(:parse).and_return(uri)
      allow(uri).to receive_messages({host: nil, port: nil, path: nil})

      expect(Net::HTTP).to receive(:new).and_return(http_obj)

      allow(http_obj).to receive_messages({:use_ssl= => nil, request: nil})
      allow(Net::HTTP::Post).to receive(:new).and_return(post_request_obj)
      allow(http_obj).to receive(:request)
      subject.post_request
    end
    it 'should set the header with an auth token' do
      allow(URI).to receive(:parse).and_return(uri)
      allow(uri).to receive_messages({host: nil, port: nil, path: nil})
      allow(Net::HTTP).to receive(:new).and_return(http_obj)
      allow(http_obj).to receive_messages({:use_ssl= => nil, request: nil})

      header = {'X-Typekit-Token' => TypeKitCli::RequestHelpers::AUTH_TOKEN}
      expect(Net::HTTP::Post).to receive(:new).with(anything, header).and_return(post_request_obj)
      expect(http_obj).to receive(:request).with(post_request_obj)
      subject.post_request
    end
    it 'should make a post request and return the response' do
      allow(URI).to receive(:parse).and_return(uri)
      allow(uri).to receive_messages({host: nil, port: nil, path: nil})
      allow(Net::HTTP).to receive(:new).and_return(http_obj)
      allow(http_obj).to receive_messages({:use_ssl= => nil, request: nil})

      expect(Net::HTTP::Post).to receive(:new).and_return(post_request_obj)
      expect(http_obj).to receive(:request).with(post_request_obj)
      subject.post_request
    end
  end
  context "#get_request" do
    it 'should append uri_str to base url' do
      test_uri = "test_uri"
      expect(URI).to receive(:parse).with(TypeKitCli::RequestHelpers::BASE_TYPEKIT_URL + test_uri).and_return(uri)

      allow(uri).to receive_messages({host: nil, port: nil, path: nil})
      allow(Net::HTTP).to receive(:new).and_return(http_obj)
      allow(http_obj).to receive_messages({:use_ssl= => nil, request: nil})
      allow(http_obj).to receive(:get)

      subject.get_request(test_uri)
    end
    it 'should use ssl' do
      allow(URI).to receive(:parse).and_return(uri)
      allow(uri).to receive_messages({host: nil, port: nil, path: nil})

      expect(Net::HTTP).to receive(:new).and_return(http_obj)

      allow(http_obj).to receive_messages({:use_ssl= => nil, request: nil})
      allow(http_obj).to receive(:get)
      subject.get_request
    end
    it 'should set the header with an auth token' do
      allow(URI).to receive(:parse).and_return(uri)
      allow(uri).to receive_messages({host: nil, port: nil, path: nil})

      expect(Net::HTTP).to receive(:new).and_return(http_obj)

      allow(http_obj).to receive_messages({:use_ssl= => nil, request: nil})
      allow(http_obj).to receive(:get)
      subject.get_request
    end
    it 'should make a get request and return the response' do
      allow(URI).to receive(:parse).and_return(uri)
      allow(uri).to receive_messages({host: nil, port: nil, path: nil})
      allow(Net::HTTP).to receive(:new).and_return(http_obj)
      allow(http_obj).to receive_messages({:use_ssl= => nil, request: nil})

      expect(http_obj).to receive(:get)
      subject.get_request
    end
  end
end