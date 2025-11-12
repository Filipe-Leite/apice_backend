namespace :db do
  namespace :populate do
    desc "Popula o banco de dados com disciplinas"
    task disciplines: :environment do
      puts "Iniciando população das disciplinas..."
      
      disciplines = [
        # Administração (diversas áreas)
        "Administração",
        "Administração Financeira",
        "Administração de Produção",
        "Administração de Materiais",
        "Administração de Recursos Humanos",
        "Administração de Marketing",
        "Administração de Vendas",
        "Administração Hospitalar",
        "Administração Pública",
        "Administração Rural",
        "Administração de Empresas",
        "Administração de Sistemas",
        "Administração de Operações",
        "Administração Estratégica",
        "Administração Contábil",
        "Administração de Qualidade",
        "Administração de Projetos",
        "Administração de Logística",
        "Administração de Redes",
        "Administração de Banco de Dados",
        
        # Agricultura e Agronomia
        "Agronomia",
        "Agricultura Familiar",
        "Agricultura Orgânica",
        "Agricultura Sustentável",
        "Agricultura de Precisão",
        "Agroecologia",
        "Agroindústria",
        "Agronegócio",
        "Agropecuária",
        "Agroclimatologia",
        
        # Antropologia
        "Antropologia Cultural",
        "Antropologia Social",
        "Antropologia Biológica",
        "Antropologia Física",
        "Antropologia Urbana",
        "Antropologia do Direito",
        "Antropologia Médica",
        "Antropologia Visual",
        
        # Arquitetura e Urbanismo
        "Arquitetura",
        "Arquitetura Sustentável",
        "Arquitetura Urbanística",
        "Arquitetura de Interiores",
        "Arquitetura Paisagística",
        "Arquitetura Hospitalar",
        "Arquitetura Commercial",
        "Arquitetura Residencial",
        
        # Arte
        "Arte",
        "Arte Digital",
        "Arte Contemporânea",
        "Arte Moderna",
        "Arte Renascentista",
        "Arte Barroca",
        "Arte Medieval",
        "Arte Rupestre",
        "Arte Educação",
        "Arte Terapia",
        
        # Astronomia
        "Astronomia",
        "Astronomia Observacional",
        "Astronomia Planetária",
        "Astronomia Estelar",
        "Astronomia Galáctica",
        "Astronomia de Posição",
        "Astrofísica",
        "Astrobiologia",
        "Astrogeologia",
        
        # Letras A (diversas áreas)
        "Álgebra",
        "Álgebra Linear",
        "Álgebra Abstrata",
        "Álgebra Computacional",
        "Anatomia",
        "Anatomia Humana",
        "Anatomia Animal",
        "Anatomia Comparada",
        "Análise",
        "Análise Matemática",
        "Análise Real",
        "Análise Complexa",
        "Análise Numérica",
        "Análise de Sistemas",
        "Análise de Dados",
        "Análise Financeira",
        "Arqueologia",
        "Arqueologia Pré-Histórica",
        "Arqueologia Clássica",
        "Arqueologia Subaquática",
        "Auditoria",
        "Auditoria Contábil",
        "Auditoria Financeira",
        "Auditoria de Sistemas",
        "Auditoria Ambiental",
        
        # Outras disciplinas com A
        "Algoritmos",
        "Algoritmos Avançados",
        "Algoritmos Distribuídos",
        "Antropologia",
        "Aquicultura",
        "Aquariofilia",
        "Arborização",
        "Arquivologia",
        "Artesanato",
        "Artes Cênicas",
        "Astronáutica",
        "Atuária",
        "Automação",
        "Automação Industrial",
        "Automação Residencial",
        "Avaliação",
        "Avaliação de Imóveis",
        "Avaliação Educacional",
        "Avicultura",
        
        # Disciplinas técnicas com A
        "Alvenaria",
        "Apicultura",
        "Arboricultura",
        "Artilharia",
        "Artilharia Naval",
        "Aviação",
        "Aviação Civil",
        "Aviação Commercial"
      ]

      disciplines_created = 0
      disciplines_skipped = 0

      disciplines.each do |discipline_name|
        discipline = Discipline.find_or_initialize_by(name: discipline_name)
        
        if discipline.new_record?
          discipline.save!
          disciplines_created += 1
          puts "Disciplina criada: #{discipline.name}"
        else
          disciplines_skipped += 1
          puts "Disciplina encontrada: #{discipline.name}"
        end
      rescue => e
        puts "Erro ao criar disciplina '#{discipline_name}': #{e.message}"
      end

      puts "\n--- População concluída ---"
      puts "Disciplinas criadas: #{disciplines_created}"
      puts "Disciplinas já existentes: #{disciplines_skipped}"
      puts "Total de disciplinas no banco: #{Discipline.count}"
      
      # Estatísticas detalhadas
      puts "\n--- Estatísticas por letra inicial ---"
      total_a = 0
      ('A'..'Z').each do |letter|
        count = Discipline.where("name ILIKE ?", "#{letter}%").count
        puts "Letra #{letter}: #{count} disciplinas" if count > 0
        total_a += count if letter == 'A'
      end
      
      puts "\n--- Disciplinas começando com 'A' ---"
      Discipline.where("name ILIKE 'A%'").order(:name).each do |discipline|
        puts "  - #{discipline.name}"
      end
      
      puts "\nTotal de disciplinas começando com 'A': #{total_a}"
      puts "Total de disciplinas começando com 'Administração': #{Discipline.where("name ILIKE 'Administração%'").count}"
    end

    desc "Limpa todas as disciplinas (cuidado!)"
    task clear_disciplines: :environment do
      puts "Limpando todas as disciplinas..."
      count = Discipline.count
      Discipline.destroy_all
      puts "#{count} disciplinas removidas."
    end

    desc "Recria as disciplinas (limpa e popula)"
    task reset_disciplines: :environment do
      Rake::Task['db:populate:clear_disciplines'].invoke
      Rake::Task['db:populate:disciplines'].invoke
    end

    desc "Popula todas as tabelas (topics e disciplines)"
    task all: :environment do
      puts "Populando todas as tabelas..."
      Rake::Task['db:populate:topics'].invoke
      Rake::Task['db:populate:disciplines'].invoke
      puts "População completa!"
    end
  end
end