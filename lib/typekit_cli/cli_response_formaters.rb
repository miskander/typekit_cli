module TypeKitCli
  module CliResponseFormaters
    def output_simple_table(data)
      data = data.kind_of?(Array) ? data : [data]
      Formatador.display_table(data)
    end

    def output_error_line(str)
      Formatador.display_line("[red]#{str}[/]")
    end

    def output_kit_and_families(hash, kit_id)
      kit = hash['kit']
      families = kit['families']
      kit.delete('families')

      Formatador.display_line("Kit #{kit_id}")
      output_simple_table(kit)

      Formatador.display_line("Kit Families")
      output_simple_table(families)
    end
  end
end