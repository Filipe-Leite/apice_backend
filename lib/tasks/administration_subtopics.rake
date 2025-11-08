namespace :db do
  namespace :populate do
    desc "Cria subtópicos para os tópicos da disciplina Administration (id 1)"
    task administration_subtopics: :environment do
      puts "Criando subtópicos para os tópicos de Administration..."

      # Busca todos os tópicos associados à disciplina Administration via tabela topics_disciplines
      administration_topics = Topic.joins("INNER JOIN topics_disciplines ON topics.id = topics_disciplines.topic_id")
                                  .where("topics_disciplines.discipline_id = ?", 1)
      
      if administration_topics.empty?
        puts "AVISO: Nenhum tópico encontrado para a disciplina Administration (ID 1)."
        puts "Execute primeiro: rails db:populate:administration_topics"
        return
      end

      puts "Encontrados #{administration_topics.count} tópicos em Administration"

      # Mapeamento de tópicos para seus subtópicos específicos
      topic_subtopics_mapping = {
        # Gestão Estratégica
        "Gestão Estratégica" => [
          "Análise SWOT",
          "Planejamento Estratégico",
          "BSC - Balanced Scorecard",
          "Missão, Visão e Valores",
          "Análise de Cenários",
          "Formulação de Estratégias",
          "Implementação Estratégica"
        ],

        # Administração Financeira
        "Administração Financeira" => [
          "Análise de Fluxo de Caixa",
          "Orçamento Empresarial",
          "Análise de Investimentos",
          "Gestão de Capital de Giro",
          "Custos e Preços",
          "Análise de Demonstrações Financeiras",
          "Fontes de Financiamento"
        ],

        # Recursos Humanos
        "Recursos Humanos" => [
          "Recrutamento e Seleção",
          "Treinamento e Desenvolvimento",
          "Avaliação de Desempenho",
          "Remuneração e Benefícios",
          "Gestão por Competências",
          "Clima Organizacional",
          "Relacionamento Trabalhista"
        ],

        # Marketing Empresarial
        "Marketing Empresarial" => [
          "Pesquisa de Mercado",
          "Comportamento do Consumidor",
          "Mix de Marketing (4Ps)",
          "Segmentação de Mercado",
          "Posicionamento de Marca",
          "Marketing Digital",
          "Gestão de Vendas"
        ],

        # Logística e Cadeia de Suprimentos
        "Logística e Cadeia de Suprimentos" => [
          "Gestão de Estoques",
          "Armazenagem e Distribuição",
          "Gestão de Transportes",
          "Cadeia de Suprimentos",
          "Logística Reversa",
          "Gestão de Compras",
          "Roteirização e Distribuição"
        ],

        # Gestão de Operações
        "Gestão de Operações" => [
          "Planejamento da Produção",
          "Controle de Qualidade",
          "Gestão da Capacidade",
          "Layout e Arranjo Físico",
          "Manutenção Industrial",
          "Gestão de Processos",
          "Melhoria Contínua"
        ],

        # Empreendedorismo
        "Empreendedorismo" => [
          "Identificação de Oportunidades",
          "Plano de Negócios",
          "Fontes de Capital",
          "Startups e Inovação",
          "Modelos de Negócio",
          "Pitch e Apresentação",
          "Gestão de Riscos Empreendedores"
        ],

        # Gestão de Projetos
        "Gestão de Projetos" => [
          "Iniciação de Projetos",
          "Planejamento de Escopo",
          "Gestão de Tempo e Cronograma",
          "Gestão de Custos do Projeto",
          "Gestão de Riscos",
          "Gestão de Qualidade em Projetos",
          "Encerramento de Projetos"
        ],

        # Comportamento Organizacional
        "Comportamento Organizacional" => [
          "Motivação no Trabalho",
          "Liderança e Poder",
          "Comunicação Organizacional",
          "Cultura Organizacional",
          "Mudança Organizacional",
          "Conflitos e Negociação",
          "Equipes de Trabalho"
        ],

        # Administração Pública
        "Administração Pública" => [
          "Políticas Públicas",
          "Gestão Orçamentária Pública",
          "Licitações e Contratos",
          "Governança Pública",
          "Controle e Auditoria",
          "Gestão de Pessoas no Setor Público",
          "Transparência e Accountability"
        ],

        # Gestão da Qualidade
        "Gestão da Qualidade" => [
          "Controle Estatístico de Processo",
          "ISO 9001",
          "Ferramentas da Qualidade",
          "Sistema de Gestão da Qualidade",
          "Satisfação do Cliente",
          "Melhoria de Processos",
          "Certificação e Acreditação"
        ],

        # Gestão de Riscos
        "Gestão de Riscos" => [
          "Identificação de Riscos",
          "Análise Qualitativa de Riscos",
          "Análise Quantitativa de Riscos",
          "Plano de Resposta a Riscos",
          "Monitoramento de Riscos",
          "Riscos Operacionais",
          "Riscos Estratégicos"
        ],

        # Ética Empresarial
        "Ética Empresarial" => [
          "Código de Ética",
          "Conflito de Interesses",
          "Compliance e Conformidade",
          "Responsabilidade Social",
          "Sustentabilidade",
          "Governança Corporativa",
          "Transparência e Prestação de Contas"
        ],

        # Controladoria
        "Controladoria" => [
          "Controle Orçamentário",
          "Análise de Custos",
          "Relatórios Gerenciais",
          "Auditoria Interna",
          "Gestão Patrimonial",
          "Análise de Viabilidade",
          "Controles Internos"
        ],

        # Gestão de Processos
        "Gestão de Processos" => [
          "Mapeamento de Processos",
          "Análise de Processos",
          "BPM - Business Process Management",
          "Workflow e Automação",
          "Indicadores de Processo",
          "Redesenho de Processos",
          "Melhoria Contínua"
        ]
      }

      total_subtopics_created = 0
      topics_without_mapping = []

      administration_topics.each do |topic|
        subtopics_list = topic_subtopics_mapping[topic.name]
        
        if subtopics_list.nil?
          topics_without_mapping << topic.name
          # Cria subtópicos genéricos para tópicos sem mapeamento específico
          subtopics_list = [
            "Fundamentos de #{topic.name}",
            "Aplicações Práticas em #{topic.name}",
            "Estudos de Caso em #{topic.name}",
            "Tendências em #{topic.name}",
            "Metodologias de #{topic.name}"
          ]
        end

        puts "\nCriando subtópicos para: #{topic.name}"
        topic_subtopics_created = 0

        subtopics_list.each do |subtopic_name|
          # Cria o subtópico
          subtopic = Subtopic.find_or_create_by!(name: subtopic_name)
          
          if subtopic.persisted? && !subtopic.previously_new_record?
            puts "  Subtópico encontrado: #{subtopic.name}"
          else
            topic_subtopics_created += 1
            puts "  Subtópico criado: #{subtopic.name} (ID: #{subtopic.id})"
          end

          # Associa o subtópico ao tópico usando a tabela subtopics_topics
          # Verifica se a associação já existe
          association_exists = ActiveRecord::Base.connection.select_one(
            "SELECT 1 FROM subtopics_topics WHERE topic_id = #{topic.id} AND subtopic_id = #{subtopic.id}"
          )

          unless association_exists
            # Cria a associação
            current_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
            ActiveRecord::Base.connection.execute(
              "INSERT INTO subtopics_topics (topic_id, subtopic_id, created_at, updated_at) VALUES (#{topic.id}, #{subtopic.id}, '#{current_time}', '#{current_time}')"
            )
            puts "    → Associado ao tópico #{topic.name}"
          end
        end

        total_subtopics_created += topic_subtopics_created
        puts "  Subtópicos criados para #{topic.name}: #{topic_subtopics_created}"
      end

      puts "\n" + "="*60
      puts "POPULAÇÃO DE SUBTÓPICOS CONCLUÍDA!"
      puts "Total de subtópicos criados: #{total_subtopics_created}"
      
      if topics_without_mapping.any?
        puts "\nTópicos sem mapeamento específico (usados subtópicos genéricos):"
        topics_without_mapping.each { |name| puts "  - #{name}" }
      end

      # Estatísticas finais
      puts "\nESTATÍSTICAS FINAIS:"
      administration_topics.each do |topic|
        # Conta subtópicos via tabela subtopics_topics
        result = ActiveRecord::Base.connection.select_one(
          "SELECT COUNT(*) as count FROM subtopics_topics WHERE topic_id = #{topic.id}"
        )
        subtopic_count = result['count'].to_i
        
        puts "  - #{topic.name}: #{subtopic_count} subtópicos"
      end

      # Total geral
      total_associations = ActiveRecord::Base.connection.select_one(
        "SELECT COUNT(*) as count FROM subtopics_topics st 
         INNER JOIN topics_disciplines td ON st.topic_id = td.topic_id 
         WHERE td.discipline_id = 1"
      )['count'].to_i

      puts "\nTotal de associações subtópicos-tópicos para Administration: #{total_associations}"
    end

    desc "Limpa subtópicos dos tópicos de Administration"
    task clear_administration_subtopics: :environment do
      puts "Limpando subtópicos dos tópicos de Administration..."
      
      # Primeiro, identifica os tópicos de Administration
      administration_topic_ids = Topic.joins("INNER JOIN topics_disciplines ON topics.id = topics_disciplines.topic_id")
                                     .where("topics_disciplines.discipline_id = ?", 1)
                                     .pluck(:id)

      if administration_topic_ids.empty?
        puts "Nenhum tópico de Administration encontrado."
        return
      end

      # Remove associações da tabela subtopics_topics para esses tópicos
      result = ActiveRecord::Base.connection.execute(
        "DELETE FROM subtopics_topics WHERE topic_id IN (#{administration_topic_ids.join(',')})"
      )
      
      puts "Associações removidas da tabela subtopics_topics: #{result.cmd_tuples}"

      # Remove subtópicos que não estão mais associados a nenhum tópico
      orphaned_subtopics = Subtopic.where("id NOT IN (SELECT DISTINCT subtopic_id FROM subtopics_topics)")
      orphaned_count = orphaned_subtopics.count
      
      orphaned_subtopics.destroy_all
      puts "Subtópicos órfãos removidos: #{orphaned_count}"

      puts "Limpeza concluída!"
    end

    desc "Recria os subtópicos de Administration (limpa e popula)"
    task reset_administration_subtopics: :environment do
      Rake::Task['db:populate:clear_administration_subtopics'].invoke
      Rake::Task['db:populate:administration_subtopics'].invoke
    end
  end
end