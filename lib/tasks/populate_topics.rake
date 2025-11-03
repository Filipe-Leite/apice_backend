namespace :db do
  namespace :populate do
    desc "Popula o banco de dados com tópicos"
    task topics: :environment do
      puts "Iniciando população dos tópicos..."
      
      topics = [
        "Cálculo Diferencial e Integral",
        "Programação Orientada a Objetos",
        "Estruturas de Dados",
        "Algoritmos e Complexidade",
        "Mecânica Quântica",
        "Termodinâmica",
        "Álgebra Linear",
        "Estatística Aplicada",
        "Filosofia Antiga",
        "Psicologia Cognitiva",
        "Sociologia Urbana",
        "Economia Comportamental",
        "Antropologia Cultural",
        "História do Brasil",
        "Geografia Humana",
        "Teorias da Comunicação",
        "Genética Molecular",
        "Fisiologia Humana",
        "Ecologia de Ecossistemas",
        "Imunologia Básica",
        "Anatomia Humana",
        "Bioquímica Metabólica",
        "Microbiologia Geral",
        "Resistência dos Materiais",
        "Circuitos Elétricos",
        "Controle e Automação",
        "Mecânica dos Fluidos",
        "Sistemas Digitais",
        "Gestão de Projetos",
        "Teoria das Cores",
        "História da Arte Contemporânea",
        "Comunicação Digital",
        "Fotografia e Imagem",
        "Literatura Brasileira",
        "Cinema e Audiovisual"
      ]

      topics_created = 0

      topics.each do |topic_name|
        topic = Topic.find_or_create_by!(name: topic_name)
        if topic.persisted? && !topic.previously_new_record?
          puts "Tópico encontrado: #{topic.name}"
        else
          topics_created += 1
          puts "Tópico criado: #{topic.name}"
        end
      end

      puts "População concluída! Tópicos criados: #{topics_created}, total: #{Topic.count}"
    end

    desc "Limpa todos os tópicos (cuidado!)"
    task clear_topics: :environment do
      puts "Limpando todos os tópicos..."
      count = Topic.count
      Topic.destroy_all
      puts "#{count} tópicos removidos."
    end

    desc "Recria os tópicos (limpa e popula)"
    task reset_topics: :environment do
      Rake::Task['db:populate:clear_topics'].invoke
      Rake::Task['db:populate:topics'].invoke
    end
  end
end