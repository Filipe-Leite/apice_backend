namespace :db do
  namespace :populate do
    desc "Cria tópicos específicos de Administration e associa à disciplina ID 1"
    task administration_topics: :environment do
      puts "Criando tópicos específicos de Administration..."
      
      # Tópicos específicos de Administração
      administration_topics = [
        "Gestão Estratégica",
        "Administração Financeira",
        "Recursos Humanos",
        "Marketing Empresarial",
        "Logística e Cadeia de Suprimentos",
        "Gestão de Operações",
        "Empreendedorismo",
        "Planejamento Empresarial",
        "Controladoria",
        "Gestão de Projetos",
        "Comportamento Organizacional",
        "Teoria das Organizações",
        "Gestão da Qualidade",
        "Administração Pública",
        "Gestão de Processos",
        "Tomada de Decisão",
        "Liderança e Poder",
        "Cultura Organizacional",
        "Gestão do Conhecimento",
        "Inovação em Negócios",
        "Gestão de Riscos",
        "Ética Empresarial",
        "Responsabilidade Social Corporativa",
        "Gestão de Mudanças",
        "Estratégia Competitiva",
        "Análise de Mercado",
        "Gestão de Custos",
        "Orçamento Empresarial",
        "Avaliação de Desempenho",
        "Gestão por Competências",
        "Recrutamento e Seleção",
        "Treinamento e Desenvolvimento",
        "Gestão de Carreiras",
        "Clima Organizacional",
        "Comunicação Organizacional",
        "Negociação Empresarial",
        "Gestão de Conflitos",
        "Administração de Vendas",
        "Gestão de Marcas",
        "Pesquisa de Mercado",
        "Comércio Eletrônico",
        "Gestão de Estoques",
        "Distribuição Física",
        "Compras e Suprimentos",
        "Gestão da Produção",
        "Layout e Arranjo Físico",
        "Planejamento e Controle da Produção",
        "Gestão da Manutenção",
        "Administração de Materiais",
        "Gestão Ambiental Empresarial"
      ]

      # Encontra a disciplina Administration
      administration = Discipline.find_by(id: 1)
      
      unless administration
        puts "ERRO: Disciplina com id 1 (Administration) não encontrada!"
        return
      end

      puts "Disciplina encontrada: #{administration.name}"
      topics_created = 0
      associations_created = 0

      administration_topics.each do |topic_name|
        # Cria o tópico
        topic = Topic.find_or_create_by!(name: topic_name)
        
        if topic.persisted? && !topic.previously_new_record?
          puts "Tópico encontrado: #{topic.name}"
        else
          topics_created += 1
          puts "Tópico criado: #{topic.name} (ID: #{topic.id})"
        end

        # Associa à disciplina Administration usando a tabela topics_disciplines
        # Verifica se a associação já existe
        association_exists = ActiveRecord::Base.connection.select_one(
          "SELECT 1 FROM topics_disciplines WHERE discipline_id = #{administration.id} AND topic_id = #{topic.id}"
        )

        unless association_exists
          # Cria a associação
          ActiveRecord::Base.connection.execute(
            "INSERT INTO topics_disciplines (discipline_id, topic_id, created_at, updated_at) VALUES (#{administration.id}, #{topic.id}, '#{Time.current}', '#{Time.current}')"
          )
          associations_created += 1
          puts "  → Associado à Administration"
        end
      end

      puts "População concluída!"
      puts "Tópicos criados: #{topics_created}"
      puts "Associações criadas: #{associations_created}"
      
      # Mostra o ID do último tópico criado
      last_topic = Topic.last
      puts "Último tópico criado tem ID: #{last_topic.id}"
    end
  end
end