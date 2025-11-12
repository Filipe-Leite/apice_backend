namespace :db do
  namespace :populate do
    desc "Associa tópicos de administração à disciplina Administração"
    task associate_administration_topics: :environment do
      puts "Associando tópicos à disciplina Administração..."

      # Busca a disciplina Administração
      administration_discipline = Discipline.find_by(name: "Administração")
      
      unless administration_discipline
        puts "ERRO: Disciplina 'Administração' não encontrada."
        puts "Execute primeiro: rails db:populate:disciplines"
        next
      end

      # Lista de tópicos de administração para associar
      administration_topics = [
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
        "Administração de Banco de Dados"
      ]

      associations_created = 0

      administration_topics.each do |topic_name|
        # Busca o tópico pelo nome
        topic = Topic.find_by(name: topic_name)
        
        unless topic
          puts "AVISO: Tópico '#{topic_name}' não encontrado."
          next
        end

        # Verifica se a associação já existe
        association_exists = ActiveRecord::Base.connection.select_one("
          SELECT 1 FROM topics_disciplines 
          WHERE topic_id = #{topic.id} AND discipline_id = #{administration_discipline.id}
        ")

        unless association_exists
          # Cria a associação
          current_time = Time.current
          ActiveRecord::Base.connection.execute("
            INSERT INTO topics_disciplines (topic_id, discipline_id, created_at, updated_at) 
            VALUES (#{topic.id}, #{administration_discipline.id}, '#{current_time}', '#{current_time}')
          ")
          associations_created += 1
          puts "✅ Associado: #{topic.name} → Administração"
        else
          puts "📖 Associação já existe: #{topic.name} → Administração"
        end
      end

      puts "\n" + "="*50
      puts "ASSOCIAÇÕES CONCLUÍDAS!"
      puts "Novas associações criadas: #{associations_created}"
      puts "Total de tópicos associados à Administração: #{Topic.joins('INNER JOIN topics_disciplines ON topics.id = topics_disciplines.topic_id').where('topics_disciplines.discipline_id = ?', administration_discipline.id).count}"
    end

    desc "Cria subtópicos para os tópicos da disciplina Administração"
    task administration_subtopics: :environment do
      puts "Criando subtópicos para os tópicos de Administração..."

      # Busca a disciplina Administração pelo nome
      administration_discipline = Discipline.find_by(name: "Administração")
      
      unless administration_discipline
        puts "ERRO: Disciplina 'Administração' não encontrada."
        puts "Execute primeiro: rails db:populate:disciplines"
        next
      end

      # Busca todos os tópicos associados à disciplina Administração via SQL
      administration_topics = Topic.find_by_sql(["
        SELECT t.* 
        FROM topics t
        INNER JOIN topics_disciplines td ON t.id = td.topic_id
        WHERE td.discipline_id = ?
      ", administration_discipline.id])
      
      if administration_topics.empty?
        puts "AVISO: Nenhum tópico encontrado para a disciplina Administração."
        puts "Execute primeiro: rails db:populate:associate_administration_topics"
        next
      end

      puts "Encontrados #{administration_topics.count} tópicos em Administração:"
      administration_topics.each { |topic| puts "  - #{topic.name}" }

      # Mapeamento de tópicos para seus subtópicos específicos
      topic_subtopics_mapping = {
        "Administração" => [
          "Fundamentos da Administração",
          "Evolução do Pensamento Administrativo",
          "Teorias da Administração",
          "Funções Administrativas",
          "Habilidades do Administrador",
          "Processo Administrativo",
          "Administração Científica",
          "Teoria Clássica"
        ],
        "Administração Financeira" => [
          "Análise de Fluxo de Caixa",
          "Orçamento Empresarial",
          "Análise de Investimentos",
          "Gestão de Capital de Giro",
          "Custos e Preços",
          "Análise de Demonstrações Financeiras",
          "Fontes de Financiamento",
          "Controladoria Financeira"
        ],
        "Administração de Recursos Humanos" => [
          "Recrutamento e Seleção",
          "Treinamento e Desenvolvimento",
          "Avaliação de Desempenho",
          "Remuneração e Benefícios",
          "Gestão por Competências",
          "Clima Organizacional",
          "Relacionamento Trabalhista",
          "Gestão de Talentos"
        ],
        "Administração de Marketing" => [
          "Pesquisa de Mercado",
          "Comportamento do Consumidor",
          "Mix de Marketing (4Ps)",
          "Segmentação de Mercado",
          "Posicionamento de Marca",
          "Marketing Digital",
          "Gestão de Vendas",
          "Marketing Estratégico"
        ],
        "Administração de Logística" => [
          "Gestão de Estoques",
          "Armazenagem e Distribuição",
          "Gestão de Transportes",
          "Cadeia de Suprimentos",
          "Logística Reversa",
          "Gestão de Compras",
          "Roteirização e Distribuição",
          "Logística Integrada"
        ],
        "Administração de Operações" => [
          "Planejamento da Produção",
          "Controle de Qualidade",
          "Gestão da Capacidade",
          "Layout e Arranjo Físico",
          "Manutenção Industrial",
          "Gestão de Processos",
          "Melhoria Contínua",
          "Gestão da Produção"
        ],
        "Administração de Projetos" => [
          "Iniciação de Projetos",
          "Planejamento de Escopo",
          "Gestão de Tempo e Cronograma",
          "Gestão de Custos do Projeto",
          "Gestão de Riscos",
          "Gestão de Qualidade em Projetos",
          "Encerramento de Projetos",
          "Metodologias Ágeis"
        ],
        "Administração de Qualidade" => [
          "Controle Estatístico de Processo",
          "ISO 9001",
          "Ferramentas da Qualidade",
          "Sistema de Gestão da Qualidade",
          "Satisfação do Cliente",
          "Melhoria de Processos",
          "Certificação e Acreditação",
          "Gestão da Qualidade Total"
        ],
        "Administração Pública" => [
          "Políticas Públicas",
          "Gestão Orçamentária Pública",
          "Licitações e Contratos",
          "Governança Pública",
          "Controle e Auditoria",
          "Gestão de Pessoas no Setor Público",
          "Transparência e Accountability",
          "Administração Municipal"
        ],
        "Administração Hospitalar" => [
          "Gestão de Serviços de Saúde",
          "Acreditação Hospitalar",
          "Gestão de Leitos",
          "Administração de Unidades de Saúde",
          "Gestão de Materiais Médicos",
          "Qualidade em Saúde",
          "Gestão Financeira Hospitalar",
          "Humanização em Saúde"
        ],
        "Administração Rural" => [
          "Gestão de Propriedades Rurais",
          "Administração Agropecuária",
          "Gestão de Recursos Naturais",
          "Agricultura de Precisão",
          "Gestão de Custos Rurais",
          "Comercialização Agrícola",
          "Gestão de Pessoal Rural",
          "Planejamento Rural"
        ],
        "Administração de Materiais" => [
          "Gestão de Estoques",
          "Classificação de Materiais",
          "Gestão de Almoxarifado",
          "Compras e Suprimentos",
          "Gestão de Patrimônio",
          "Controle de Materiais",
          "Cadeia de Suprimentos",
          "Logística de Materiais"
        ],
        "Administração Estratégica" => [
          "Análise SWOT",
          "Planejamento Estratégico",
          "BSC - Balanced Scorecard",
          "Missão, Visão e Valores",
          "Análise de Cenários",
          "Formulação de Estratégias",
          "Implementação Estratégica",
          "Gestão Estratégica de Negócios"
        ],
        "Administração de Sistemas" => [
          "Gestão de TI",
          "Sistemas de Informação Gerencial",
          "Governança de TI",
          "Gestão de Banco de Dados",
          "Segurança da Informação",
          "Infraestrutura de TI",
          "Sistemas Integrados",
          "Gestão de Redes"
        ],
        "Administração de Empresas" => [
          "Gestão Empresarial",
          "Organização Empresarial",
          "Tomada de Decisão",
          "Liderança Empresarial",
          "Comunicação Organizacional",
          "Cultura Organizacional",
          "Mudança Organizacional",
          "Desempenho Organizacional"
        ],
        "Administração de Vendas" => [
          "Gestão de Equipes de Vendas",
          "Técnicas de Vendas",
          "Gestão de Portfólio",
          "Relacionamento com Clientes",
          "Precificação Estratégica",
          "Canais de Distribuição",
          "Vendas Consultivas",
          "Gestão de Key Accounts"
        ]
      }

      total_subtopics_created = 0
      total_associations_created = 0
      topics_without_mapping = []

      administration_topics.each do |topic|
        subtopics_list = topic_subtopics_mapping[topic.name]
        
        if subtopics_list.nil?
          topics_without_mapping << topic.name
          next
        end

        puts "\n📋 Criando subtópicos para: #{topic.name}"
        topic_subtopics_created = 0
        topic_associations_created = 0

        subtopics_list.each do |subtopic_name|
          subtopic = Subtopic.find_or_create_by!(name: subtopic_name)
          
          if subtopic.previously_new_record?
            topic_subtopics_created += 1
            puts "  ✅ Subtópico criado: #{subtopic.name}"
          else
            puts "  📖 Subtópico encontrado: #{subtopic.name}"
          end

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
            topic_associations_created += 1
            puts "    🔗 Associado ao tópico #{topic.name}"
          end
        end

        total_subtopics_created += topic_subtopics_created
        total_associations_created += topic_associations_created
        puts "  📊 Resumo: #{topic_subtopics_created} novos subtópicos, #{topic_associations_created} novas associações"
      end

      puts "\n" + "="*60
      puts "🎉 POPULAÇÃO DE SUBTÓPICOS CONCLUÍDA!"
      puts "="*60
      puts "📚 Disciplina: #{administration_discipline.name}"
      puts "📋 Tópicos processados: #{administration_topics.count}"
      puts "✅ Novos subtópicos criados: #{total_subtopics_created}"
      puts "🔗 Novas associações criadas: #{total_associations_created}"
      
      if topics_without_mapping.any?
        puts "\n⚠️  Tópicos sem mapeamento específico (ignorados):"
        topics_without_mapping.each { |name| puts "  - #{name}" }
      end

      puts "\n📈 ESTATÍSTICAS FINAIS POR TÓPICO:"
      administration_topics.each do |topic|
        subtopic_count = ActiveRecord::Base.connection.select_one("
          SELECT COUNT(*) as count FROM subtopics_topics 
          WHERE topic_id = #{topic.id}
        ")['count'].to_i
        
        puts "  - #{topic.name}: #{subtopic_count} subtópicos"
      end
    end

    desc "Fluxo completo para criar subtópicos de Administração"
    task full_administration_setup: :environment do
      puts "🚀 INICIANDO SETUP COMPLETO DE ADMINISTRAÇÃO"
      puts "="*50
      
      Rake::Task['db:populate:disciplines'].invoke
      puts ""
      Rake::Task['db:populate:topics'].invoke
      puts ""
      Rake::Task['db:populate:associate_administration_topics'].invoke
      puts ""
      Rake::Task['db:populate:administration_subtopics'].invoke
      
      puts "="*50
      puts "🎉 SETUP COMPLETO CONCLUÍDO!"
    end
  end
end