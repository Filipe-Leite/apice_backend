namespace :db do
  namespace :populate do
    desc "Popula os tipos de card"
    task card_types: :environment do
      puts "Criando tipos de card..."

      card_types = [
        "quote",
        "summary", 
        "comment",
        "bibliographic",
        "sketch"
      ]

      types_created = 0
      types_skipped = 0

      card_types.each do |type_name|
        card_type = CardType.find_or_initialize_by(name: type_name)
        
        if card_type.new_record?
          card_type.save!
          types_created += 1
          puts "✅ Tipo de card criado: #{type_name}"
        else
          types_skipped += 1
          puts "📖 Tipo de card já existente: #{type_name}"
        end
      end

      puts "\n" + "="*50
      puts "🎉 POPULAÇÃO DE TIPOS DE CARD CONCLUÍDA!"
      puts "✅ Novos tipos criados: #{types_created}"
      puts "📖 Tipos já existentes: #{types_skipped}"
      puts "📊 Total de tipos: #{CardType.count}"
      puts "="*50

      # Lista todos os tipos
      puts "\n📋 LISTA DE TIPOS DE CARD:"
      CardType.all.order(:name).each do |card_type|
        puts "  • #{card_type.name} (ID: #{card_type.id})"
      end
    end

    desc "Limpa todos os tipos de card"
    task clear_card_types: :environment do
      puts "Limpando todos os tipos de card..."
      count = CardType.count
      CardType.destroy_all
      puts "#{count} tipos de card removidos."
    end

    desc "Recria os tipos de card (limpa e popula)"
    task reset_card_types: :environment do
      Rake::Task['db:populate:clear_card_types'].invoke
      Rake::Task['db:populate:card_types'].invoke
    end
  end
end