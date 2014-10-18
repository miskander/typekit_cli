require 'spec_helper'

describe TypeKit do
  let(:cli) { TypeKit.new }
  let(:http_response) { double("response") }
  let(:success_status_code) { "200" }
  let(:failed_status_code) { "404" }
  let(:response_body) { {"title"=> "Test Output"}.to_json }

  before(:each, type: :success_request) do
    expect(http_response).to receive(:code).and_return(success_status_code)
    expect(http_response).to receive(:body).and_return(response_body)
  end
  before(:each, type: :failure_request) do
    expect(http_response).to receive(:code).twice.and_return(failed_status_code)
  end
  def subject
    cli
  end

  context "#list_kits" do
    it 'should output the response if the API request was successful', :type => :success_request do
      expect(cli).to receive(:get_request).and_return(http_response)
      expect(cli).to receive(:output_simple_table).and_return(nil)

      cli.list_kits
    end
    it 'should output an error message if the request failed', :type => :failure_request do
      expect(cli).to receive(:get_request).and_return(http_response)
      expect(cli).to receive(:output_error_line).with("An error occurred while trying to fetch your kits, response code #{failed_status_code}")

      cli.list_kits
    end
  end
  context "#show_draft_kit" do
    it 'should output the response if the API request was successful', :type => :success_request do
      expect(cli).to receive(:get_request).with("foo").and_return(http_response)
      expect(cli).to receive(:output_kit_and_families).and_return(nil)

      cli.show_draft_kit("foo")
    end
    it 'should output an error message if the request failed', :type => :failure_request do
      expect(cli).to receive(:get_request).with("foo").and_return(http_response)
      expect(cli).to receive(:output_error_line).with("An error occurred while trying to fetch draft kit, response code #{failed_status_code}")

      cli.show_draft_kit("foo")
    end
  end
  context "#publish_kit" do
    it 'should output the response if the API request was successful', :type => :success_request do
      expect(cli).to receive(:post_request).with("foo/publish").and_return(http_response)
      expect(cli).to receive(:output_simple_table).and_return(nil)

      cli.publish_kit("foo")
    end
    it 'should output an error message if the request failed', :type => :failure_request do
      expect(cli).to receive(:post_request).with("foo/publish").and_return(http_response)
      expect(cli).to receive(:output_error_line).with("An error occurred while trying to fetch published kit, response code #{failed_status_code}")

      cli.publish_kit("foo")
    end
  end
  context "#show_published_kit" do
    it 'should output the response if the API request was successful', :type => :success_request do
      expect(cli).to receive(:get_request).with("foo/published").and_return(http_response)
      expect(cli).to receive(:output_kit_and_families).and_return(nil)

      cli.show_published_kit("foo")
    end
    it 'should output an error message if the request failed', :type => :failure_request do
      expect(cli).to receive(:get_request).with("foo/published").and_return(http_response)
      expect(cli).to receive(:output_error_line).with("An error occurred while trying to fetch published kit, response code #{failed_status_code}")

      cli.show_published_kit("foo")
    end
  end
  context "#show_kit_family" do
    it 'should output the response if the API request was successful', :type => :success_request do
      expect(cli).to receive(:get_request).with("foo/families/bar").and_return(http_response)
      expect(cli).to receive(:output_simple_table).and_return(nil)

      cli.show_kit_family("foo", "bar")
    end
    it 'should output an error message if the request failed', :type => :failure_request do
      expect(cli).to receive(:get_request).with("foo/families/bar").and_return(http_response)
      expect(cli).to receive(:output_error_line).with("An error occurred while trying to fetch kit family, response code #{failed_status_code}")

      cli.show_kit_family("foo", "bar")
    end
  end
  it_behaves_like TypeKitCli::RequestHelpers
  it_behaves_like TypeKitCli::CliResponseFormaters
end