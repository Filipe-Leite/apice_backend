# lib/tasks/populate.rake
namespace :db do
  namespace :populate do
    desc "Popula o banco completo com foco em Administração"
    task full_administration: :environment do
      puts "🚀 INICIANDO POPULAÇÃO COMPLETA DO BANCO"
      puts "="*60

      # 1. Popula disciplines
      puts "\n📚 CRIANDO DISCIPLINAS..."
      disciplines = [
        "Administração",
        "Administração Financeira",
        "Administração de Recursos Humanos",
        "Administração de Marketing",
        "Administração de Produção",
        "Administração de Projetos",
        "Administração Pública",
        "Administração Hospitalar",
        "Administração Rural",
        "Administração de Qualidade",
        "Economia",
        "Contabilidade",
        "Direito",
        "Psicologia",
        "Sociologia",
        "Matemática",
        "Estatística",
        "Informática",
        "Engenharia de Produção"
      ]

      disciplines_created = 0
      disciplines.each do |name|
        discipline = Discipline.find_or_create_by!(name: name)
        if discipline.previously_new_record?
          disciplines_created += 1
          puts "  ✅ Disciplina criada: #{name}"
        end
      end
      puts "📊 Total de disciplinas: #{disciplines_created} novas, #{Discipline.count} no total"

      # 2. Popula topics
      puts "\n📋 CRIANDO TÓPICOS..."
      topics = [
        # Tópicos de Administração Geral
        "Teorias da Administração",
        "Planejamento Estratégico",
        "Organização Empresarial",
        "Direção e Liderança",
        "Controle e Avaliação",
        "Tomada de Decisão",
        "Comunicação Organizacional",
        "Cultura Organizacional",
        "Mudança Organizacional",
        "Desempenho Organizacional",

        # Tópicos de Administração Financeira
        "Análise de Demonstrações Financeiras",
        "Orçamento Empresarial",
        "Gestão de Custos",
        "Análise de Investimentos",
        "Fontes de Financiamento",
        "Gestão de Capital de Giro",
        "Avaliação de Empresas",
        "Risco e Retorno",

        # Tópicos de RH
        "Recrutamento e Seleção",
        "Treinamento e Desenvolvimento",
        "Avaliação de Desempenho",
        "Remuneração e Benefícios",
        "Gestão por Competências",
        "Clima Organizacional",
        "Desenvolvimento Organizacional",
        "Gestão de Talentos",

        # Tópicos de Marketing
        "Pesquisa de Mercado",
        "Comportamento do Consumidor",
        "Segmentação de Mercado",
        "Posicionamento de Marca",
        "Mix de Marketing",
        "Marketing Digital",
        "Gestão de Vendas",
        "Marketing Estratégico",

        # Tópicos de Produção
        "Gestão da Produção",
        "Controle de Qualidade",
        "Gestão de Estoques",
        "Layout e Arranjo Físico",
        "Manutenção Industrial",
        "Logística e Cadeia de Suprimentos",
        "Gestão de Processos",
        "Melhoria Contínua"
      ]

      topics_created = 0
      topics.each do |name|
        topic = Topic.find_or_create_by!(name: name)
        if topic.previously_new_record?
          topics_created += 1
          puts "  ✅ Tópico criado: #{name}"
        end
      end
      puts "📊 Total de tópicos: #{topics_created} novos, #{Topic.count} no total"

      # 3. Associa disciplines com topics
      puts "\n🔗 ASSOCIANDO DISCIPLINAS COM TÓPICOS..."
      administration_discipline = Discipline.find_by(name: "Administração")
      finance_discipline = Discipline.find_by(name: "Administração Financeira")
      rh_discipline = Discipline.find_by(name: "Administração de Recursos Humanos")
      marketing_discipline = Discipline.find_by(name: "Administração de Marketing")
      production_discipline = Discipline.find_by(name: "Administração de Produção")

      # Mapeamento de disciplinas para tópicos
      discipline_topics_mapping = {
        "Administração" => [
          "Teorias da Administração", "Planejamento Estratégico", "Organização Empresarial",
          "Direção e Liderança", "Controle e Avaliação", "Tomada de Decisão",
          "Comunicação Organizacional", "Cultura Organizacional", "Mudança Organizacional",
          "Desempenho Organizacional"
        ],
        "Administração Financeira" => [
          "Análise de Demonstrações Financeiras", "Orçamento Empresarial", "Gestão de Custos",
          "Análise de Investimentos", "Fontes de Financiamento", "Gestão de Capital de Giro",
          "Avaliação de Empresas", "Risco e Retorno"
        ],
        "Administração de Recursos Humanos" => [
          "Recrutamento e Seleção", "Treinamento e Desenvolvimento", "Avaliação de Desempenho",
          "Remuneração e Benefícios", "Gestão por Competências", "Clima Organizacional",
          "Desenvolvimento Organizacional", "Gestão de Talentos"
        ],
        "Administração de Marketing" => [
          "Pesquisa de Mercado", "Comportamento do Consumidor", "Segmentação de Mercado",
          "Posicionamento de Marca", "Mix de Marketing", "Marketing Digital",
          "Gestão de Vendas", "Marketing Estratégico"
        ],
        "Administração de Produção" => [
          "Gestão da Produção", "Controle de Qualidade", "Gestão de Estoques",
          "Layout e Arranjo Físico", "Manutenção Industrial", "Logística e Cadeia de Suprimentos",
          "Gestão de Processos", "Melhoria Contínua"
        ]
      }

      associations_created = 0
      discipline_topics_mapping.each do |discipline_name, topic_names|
        discipline = Discipline.find_by(name: discipline_name)
        next unless discipline

        topic_names.each do |topic_name|
          topic = Topic.find_by(name: topic_name)
          next unless topic

          # Verifica se a associação já existe
          association_exists = ActiveRecord::Base.connection.select_one("
            SELECT 1 FROM topics_disciplines 
            WHERE topic_id = #{topic.id} AND discipline_id = #{discipline.id}
          ")

          unless association_exists
            current_time = Time.current
            ActiveRecord::Base.connection.execute("
              INSERT INTO topics_disciplines (topic_id, discipline_id, created_at, updated_at) 
              VALUES (#{topic.id}, #{discipline.id}, '#{current_time}', '#{current_time}')
            ")
            associations_created += 1
            puts "  ✅ Associado: #{topic.name} → #{discipline.name}"
          end
        end
      end
      puts "📊 Total de associações criadas: #{associations_created}"

      # 4. Popula subtopics
      puts "\n📝 CRIANDO SUBTÓPICOS..."
      topic_subtopics_mapping = {
        "Teorias da Administração" => [
          "Administração Científica - Taylor",
          "Teoria Clássica - Fayol",
          "Teoria das Relações Humanas - Mayo",
          "Teoria Burocrática - Weber",
          "Teoria Estruturalista",
          "Teoria dos Sistemas",
          "Teoria Contingencial",
          "Abordagem Neoclássica"
        ],
        "Planejamento Estratégico" => [
          "Análise SWOT",
          "Missão, Visão e Valores",
          "Objetivos Estratégicos",
          "Análise de Cenários",
          "Formulação de Estratégias",
          "Implementação Estratégica",
          "Balanced Scorecard - BSC",
          "Monitoramento e Controle"
        ],
        "Recrutamento e Seleção" => [
          "Análise de Cargos",
          "Descrição e Especificação de Cargos",
          "Fontes de Recrutamento",
          "Técnicas de Seleção",
          "Entrevista por Competências",
          "Dinâmicas de Grupo",
          "Testes Psicológicos",
          "Indução e Integração"
        ],
        "Pesquisa de Mercado" => [
          "Definição do Problema",
          "Planejamento da Pesquisa",
          "Coleta de Dados Primários",
          "Coleta de Dados Secundários",
          "Amostragem",
          "Análise de Dados",
          "Relatório de Pesquisa",
          "Aplicação dos Resultados"
        ],
        "Gestão da Produção" => [
          "Planejamento da Capacidade",
          "Programação da Produção",
          "Controle de Produção",
          "Gestão de Materiais",
          "Arranjo Físico",
          "Tempo-Padrão",
          "Produtividade",
          "Lean Manufacturing"
        ]
      }

      subtopics_created = 0
      subtopic_associations_created = 0

      topic_subtopics_mapping.each do |topic_name, subtopic_names|
        topic = Topic.find_by(name: topic_name)
        next unless topic

        puts "  📋 Criando subtópicos para: #{topic.name}"
        
        subtopic_names.each do |subtopic_name|
          subtopic = Subtopic.find_or_create_by!(name: subtopic_name)
          
          if subtopic.previously_new_record?
            subtopics_created += 1
            puts "    ✅ Subtópico criado: #{subtopic.name}"
          end

          # Associa subtópico ao tópico
          association_exists = ActiveRecord::Base.connection.select_one("
            SELECT 1 FROM subtopics_topics 
            WHERE topic_id = #{topic.id} AND subtopic_id = #{subtopic.id}
          ")

          unless association_exists
            current_time = Time.current
            ActiveRecord::Base.connection.execute("
              INSERT INTO subtopics_topics (topic_id, subtopic_id, created_at, updated_at) 
              VALUES (#{topic.id}, #{subtopic.id}, '#{current_time}', '#{current_time}')
            ")
            subtopic_associations_created += 1
            puts "      🔗 Associado ao tópico #{topic.name}"
          end
        end
      end
      puts "📊 Total de subtópicos: #{subtopics_created} novos, #{Subtopic.count} no total"
      puts "📊 Total de associações subtópicos-tópicos: #{subtopic_associations_created}"

      # 5. Popula authors
      puts "\n👤 CRIANDO AUTORES..."
      authors = [
        "Peter Drucker",
        "Henry Mintzberg",
        "Michael Porter",
        "Philip Kotler",
        "Idalberto Chiavenato",
        "Stephen Covey",
        "Jim Collins",
        "Peter Senge",
        "Frederick Taylor",
        "Henri Fayol",
        "Elton Mayo",
        "Max Weber",
        "Abraham Maslow",
        "Frederick Herzberg",
        "Douglas McGregor",
        "Warren Bennis",
        "John Kotter",
        "Clayton Christensen",
        "Gary Hamel",
        "C. K. Prahalad"
      ]

      authors_created = 0
      authors.each do |name|
        author = Author.find_or_create_by!(name: name)
        if author.previously_new_record?
          authors_created += 1
          puts "  ✅ Autor criado: #{name}"
        end
      end
      puts "📊 Total de autores: #{authors_created} novos, #{Author.count} no total"

      # 6. Associa authors com topics
      puts "\n🔗 ASSOCIANDO AUTORES COM TÓPICOS..."
      author_topics_mapping = {
        "Peter Drucker" => ["Teorias da Administração", "Planejamento Estratégico"],
        "Henry Mintzberg" => ["Teorias da Administração", "Organização Empresarial"],
        "Michael Porter" => ["Planejamento Estratégico", "Marketing Estratégico"],
        "Philip Kotler" => ["Marketing Estratégico", "Comportamento do Consumidor"],
        "Idalberto Chiavenato" => ["Teorias da Administração", "Recrutamento e Seleção"],
        "Frederick Taylor" => ["Teorias da Administração", "Gestão da Produção"],
        "Henri Fayol" => ["Teorias da Administração", "Organização Empresarial"]
      }

      author_associations_created = 0
      author_topics_mapping.each do |author_name, topic_names|
        author = Author.find_by(name: author_name)
        next unless author

        topic_names.each do |topic_name|
          topic = Topic.find_by(name: topic_name)
          next unless topic

          association_exists = ActiveRecord::Base.connection.select_one("
            SELECT 1 FROM topics_authors 
            WHERE topic_id = #{topic.id} AND author_id = #{author.id}
          ")

          unless association_exists
            current_time = Time.current
            ActiveRecord::Base.connection.execute("
              INSERT INTO topics_authors (topic_id, author_id, created_at, updated_at) 
              VALUES (#{topic.id}, #{author.id}, '#{current_time}', '#{current_time}')
            ")
            author_associations_created += 1
            puts "  ✅ Associado: #{author.name} → #{topic.name}"
          end
        end
      end
      puts "📊 Total de associações autores-tópicos: #{author_associations_created}"

      # 7. Popula sources
      puts "\n📚 CRIANDO FONTES (LIVROS)..."
      sources = [
        "Administração: Teoria, Processo e Prática",
        "Administração de Recursos Humanos",
        "Administração de Marketing",
        "Administração Financeira e Orçamentária",
        "Administração da Produção e Operações",
        "Administração Estratégica",
        "O Gerente Eficaz",
        "Inovação e Espírito Empreendedor",
        "A Estratégia do Oceano Azul",
        "Vantagem Competitiva",
        "Marketing 4.0",
        "Os 7 Hábitos das Pessoas Altamente Eficazes",
        "Empresas Feitas para Vencer",
        "A Quinta Disciplina",
        "Princípios da Administração Científica",
        "Administração Industrial e Geral",
        "O Lado Humano da Empresa",
        "A Ética Protestante e o Espírito do Capitalismo",
        "Motivação e Personalidade",
        "A Motivação para Trabalhar"
      ]

      sources_created = 0
      sources.each do |title|
        source = Source.find_or_create_by!(title: title)
        if source.previously_new_record?
          sources_created += 1
          puts "  ✅ Fonte criada: #{title}"
        end
      end
      puts "📊 Total de fontes: #{sources_created} novas, #{Source.count} no total"

      puts "\n" + "="*60
      puts "🎉 POPULAÇÃO COMPLETA CONCLUÍDA!"
      puts "="*60
      puts "📊 RESUMO FINAL:"
      puts "  • Disciplinas: #{Discipline.count}"
      puts "  • Tópicos: #{Topic.count}"
      puts "  • Subtópicos: #{Subtopic.count}"
      puts "  • Autores: #{Author.count}"
      puts "  • Fontes: #{Source.count}"
      puts "  • Associações disciplines-topics: #{associations_created}"
      puts "  • Associações topics-subtopics: #{subtopic_associations_created}"
      puts "  • Associações authors-topics: #{author_associations_created}"
      puts "="*60
    end

    desc "Limpa todo o banco de dados (CUIDADO!)"
    task clear_all: :environment do
      puts "🧹 LIMPANDO TODO O BANCO DE DADOS..."
      
      # Remove em ordem para respeitar constraints de foreign key
      ActiveRecord::Base.connection.execute("DELETE FROM subtopics_topics")
      ActiveRecord::Base.connection.execute("DELETE FROM topics_authors")
      ActiveRecord::Base.connection.execute("DELETE FROM topics_disciplines")
      
      Subtopic.destroy_all
      Author.destroy_all
      Source.destroy_all
      Topic.destroy_all
      Discipline.destroy_all
      
      puts "✅ Banco de dados limpo com sucesso!"
    end

    desc "Recria todo o banco (limpa e popula)"
    task reset_all: :environment do
      Rake::Task['db:populate:clear_all'].invoke
      Rake::Task['db:populate:full_administration'].invoke
    end
  end
end