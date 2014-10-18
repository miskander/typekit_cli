shared_examples TypeKitCli::CliResponseFormaters do

  let(:kit){{'kit'=> hash_data.merge({'families'=> array_data})}}
  let(:hash_data){{foo: "test string", bar:"test string 2"}}
  let(:array_data){[{foo: "test string"}, {bar: "test string 2"}]}
  let(:kit_id){"someid"}
  let(:text_msg){"test string"}

  context "#output_simple_table"do
    it 'should transform passed in data to an array if it is not before passing it to Formatador' do
      expect(Formatador).to receive(:display_table).with([hash_data])
      subject.output_simple_table(hash_data)
    end
    it 'should not transform the data if it is already an array before passing it to Formatador' do
      expect(Formatador).to receive(:display_table).with(array_data)
      subject.output_simple_table(array_data)
    end
  end
  context "#output_error_line" do
    it 'should apply red color to the error message passed in before passing it to Formatador' do
      expect(Formatador).to receive(:display_line).with("[red]#{text_msg}[/]")
      subject.output_error_line(text_msg)
    end
  end
  context "#output_kit_and_families" do
    it 'should print a kit table header' do
      expect(Formatador).to receive(:display_line).once.with("Kit #{kit_id}")
      allow(Formatador).to receive(:display_line)
      allow(subject).to receive(:output_simple_table).twice
      subject.output_kit_and_families(kit, kit_id)
    end
    it 'should print the kit table without the families value'do
      allow(Formatador).to receive(:display_line).twice
      expect(subject).to receive(:output_simple_table).with(kit['kit'])
      allow(subject).to receive(:output_simple_table)
      subject.output_kit_and_families(kit, kit_id)
    end
    it 'should print the families table header' do
      allow(Formatador).to receive(:display_line)
      expect(Formatador).to receive(:display_line).with("Kit Families")
      allow(subject).to receive(:output_simple_table).twice

      subject.output_kit_and_families(kit, kit_id)
    end
    it 'should print the families table' do
      allow(Formatador).to receive(:display_line).twice
      allow(subject).to receive(:output_simple_table)
      expect(subject).to receive(:output_simple_table).with(kit['kit']['families'])

      subject.output_kit_and_families(kit, kit_id)
    end
  end

end