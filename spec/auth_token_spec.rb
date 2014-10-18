require 'spec_helper'

describe TypeKitCli::AuthToken do
  let(:token_obj){TypeKitCli::AuthToken.new}
  context "#get_token" do
    it 'should use use a cached token if it exists' do
      expect(File).to receive(:exist?).with("#{Dir.home}/.typekit").and_return(true)
      file = double('file')

      expect(File).to receive(:open).with("#{Dir.home}/.typekit", "r").and_yield(file)
      expect(file).to receive(:gets).and_return("foo_bar")
      token = token_obj.get_token
      expect(token).to eql("foo_bar")
    end
    it 'should prompt the user if file doesn\'t exist' do
      expect(File).to receive(:exist?).with("#{Dir.home}/.typekit").and_return(false)
      expect(token_obj).to receive(:prompt_for_token).and_return("foo_bar")
      token = token_obj.get_token
      expect(token).to eql("foo_bar")
    end
  end
end