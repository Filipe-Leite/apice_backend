namespace :db do
  namespace :populate do
    desc "Cria tópicos para outras disciplinas (diferente de ID 1)"
    task other_disciplines_topics: :environment do
      puts "Criando tópicos para outras disciplinas..."
      
      # Verifica se existem disciplinas além da ID 1
      other_disciplines = Discipline.where.not(id: 1)
      
      if other_disciplines.empty?
        puts "AVISO: Não foram encontradas disciplinas além da ID 1."
        puts "Criando algumas disciplinas de exemplo..."
        
        # Cria algumas disciplinas de exemplo
        disciplines_data = [
          { name: "Mathematics" },
          { name: "Physics" },
          { name: "Computer Science" },
          { name: "Biology" },
          { name: "Chemistry" }
        ]
        
        disciplines_data.each do |discipline_data|
          Discipline.find_or_create_by!(name: discipline_data[:name])
        end
        
        other_disciplines = Discipline.where.not(id: 1)
        puts "Disciplinas criadas: #{other_disciplines.pluck(:name).join(', ')}"
      end

      # Tópicos para Mathematics (exemplo)
      math_topics = [
        "Cálculo Diferencial",
        "Cálculo Integral",
        "Álgebra Linear",
        "Geometria Analítica",
        "Teoria dos Números",
        "Estatística Básica",
        "Probabilidade",
        "Equações Diferenciais",
        "Análise Real",
        "Topologia"
      ]

      # Tópicos para Physics (exemplo)
      physics_topics = [
        "Mecânica Clássica",
        "Termodinâmica",
        "Eletromagnetismo",
        "Óptica",
        "Física Moderna",
        "Relatividade",
        "Mecânica Quântica",
        "Física Nuclear",
        "Astrofísica",
        "Física de Partículas"
      ]

      # Tópicos para Computer Science (exemplo)
      cs_topics = [
        "Algoritmos e Estruturas de Dados",
        "Programação Orientada a Objetos",
        "Banco de Dados",
        "Redes de Computadores",
        "Inteligência Artificial",
        "Segurança da Informação",
        "Engenharia de Software",
        "Sistemas Operacionais",
        "Compiladores",
        "Computação Distribuída"
      ]

      # Tópicos para Biology (exemplo)
      biology_topics = [
        "Genética Molecular",
        "Biologia Celular",
        "Ecologia",
        "Evolução",
        "Anatomia Humana",
        "Fisiologia Animal",
        "Botânica",
        "Microbiologia",
        "Imunologia",
        "Bioquímica"
      ]

      # Tópicos para Chemistry (exemplo)
      chemistry_topics = [
        "Química Orgânica",
        "Química Inorgânica",
        "Físico-Química",
        "Química Analítica",
        "Bioquímica",
        "Química dos Materiais",
        "Espectroscopia",
        "Termoquímica",
        "Cinética Química",
        "Eletroquímica"
      ]

      # Mapeamento de disciplinas para seus tópicos
      discipline_topics_mapping = {
        "Mathematics" => math_topics,
        "Physics" => physics_topics,
        "Computer Science" => cs_topics,
        "Biology" => biology_topics,
        "Chemistry" => chemistry_topics
      }

      total_topics_created = 0
      total_associations_created = 0

      other_disciplines.each do |discipline|
        topics_list = discipline_topics_mapping[discipline.name]
        
        unless topics_list
          puts "AVISO: Não há tópicos definidos para a disciplina: #{discipline.name}"
          next
        end

        puts "\nProcessando disciplina: #{discipline.name} (ID: #{discipline.id})"
        discipline_topics_created = 0
        discipline_associations_created = 0

        topics_list.each do |topic_name|
          # Cria o tópico
          topic = Topic.find_or_create_by!(name: topic_name)
          
          if topic.persisted? && !topic.previously_new_record?
            puts "Tópico encontrado: #{topic.name}"
          else
            discipline_topics_created += 1
            puts "Tópico criado: #{topic.name} (ID: #{topic.id})"
          end

          # Associa à disciplina atual
          association_exists = ActiveRecord::Base.connection.select_one(
            "SELECT 1 FROM topics_disciplines WHERE discipline_id = #{discipline.id} AND topic_id = #{topic.id}"
          )

          unless association_exists
            # Cria a associação
            ActiveRecord::Base.connection.execute(
              "INSERT INTO topics_disciplines (discipline_id, topic_id, created_at, updated_at) VALUES (#{discipline.id}, #{topic.id}, '#{Time.current}', '#{Time.current}')"
            )
            discipline_associations_created += 1
            puts "  → Associado à #{discipline.name}"
          end
        end

        total_topics_created += discipline_topics_created
        total_associations_created += discipline_associations_created
        
        puts "Resumo para #{discipline.name}:"
        puts "  - Tópicos criados: #{discipline_topics_created}"
        puts "  - Associações criadas: #{discipline_associations_created}"
      end

      puts "\n" + "="*50
      puts "POPULAÇÃO CONCLUÍDA!"
      puts "Tópicos criados (total): #{total_topics_created}"
      puts "Associações criadas (total): #{total_associations_created}"
      
      # Estatísticas finais
      puts "\nESTATÍSTICAS FINAIS:"
      Discipline.all.each do |discipline|
        topic_count = Topic.joins(:topics_disciplines)
                          .where(topics_disciplines: { discipline_id: discipline.id })
                          .count
        puts " - #{discipline.name} (ID: #{discipline.id}): #{topic_count} tópicos"
      end
    end

    desc "Limpa tópicos das outras disciplinas (diferente de ID 1)"
    task clear_other_disciplines_topics: :environment do
      puts "Limpando tópicos das outras disciplinas..."
      
      # Lista de tópicos específicos para remover (baseado nos arrays acima)
      other_disciplines_topics = [
        # Mathematics
        "Cálculo Diferencial", "Cálculo Integral", "Álgebra Linear", "Geometria Analítica",
        "Teoria dos Números", "Estatística Básica", "Probabilidade", "Equações Diferenciais",
        "Análise Real", "Topologia",
        
        # Physics
        "Mecânica Clássica", "Termodinâmica", "Eletromagnetismo", "Óptica", "Física Moderna",
        "Relatividade", "Mecânica Quântica", "Física Nuclear", "Astrofísica", "Física de Partículas",
        
        # Computer Science
        "Algoritmos e Estruturas de Dados", "Programação Orientada a Objetos", "Banco de Dados",
        "Redes de Computadores", "Inteligência Artificial", "Segurança da Informação",
        "Engenharia de Software", "Sistemas Operacionais", "Compiladores", "Computação Distribuída",
        
        # Biology
        "Genética Molecular", "Biologia Celular", "Ecologia", "Evolução", "Anatomia Humana",
        "Fisiologia Animal", "Botânica", "Microbiologia", "Imunologia", "Bioquímica",
        
        # Chemistry
        "Química Orgânica", "Química Inorgânica", "Físico-Química", "Química Analítica",
        "Bioquímica", "Química dos Materiais", "Espectroscopia", "Termoquímica", "Cinética Química",
        "Eletroquímica"
      ]

      count = 0
      other_disciplines_topics.each do |topic_name|
        topic = Topic.find_by(name: topic_name)
        if topic
          # Remove associações primeiro
          ActiveRecord::Base.connection.execute(
            "DELETE FROM topics_disciplines WHERE topic_id = #{topic.id}"
          )
          
          # Remove o tópico
          topic.destroy
          count += 1
          puts "Tópico removido: #{topic_name}"
        end
      end

      puts "#{count} tópicos de outras disciplinas removidos."
    end

    desc "Recria os tópicos das outras disciplinas (limpa e popula)"
    task reset_other_disciplines_topics: :environment do
      Rake::Task['db:populate:clear_other_disciplines_topics'].invoke
      Rake::Task['db:populate:other_disciplines_topics'].invoke
    end
  end
end