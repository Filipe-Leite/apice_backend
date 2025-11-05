namespace :db do
  namespace :populate do
    desc "Popula o banco de dados com subtópicos"
    task subtopics: :environment do
      puts "Iniciando população dos subtópicos..."
      
      subtopics = [
        # Seus subtópicos existentes...
        "Limites e Continuidade",
        "Derivadas e Aplicações", 
        "Integrais Definidas e Indefinidas",
        "Classes e Objetos",
        "Herança e Polimorfismo",
        "Encapsulamento e Abstração",
        "Listas Ligadas",
        "Pilhas e Filas",
        "Árvores e Grafos",
        "Análise Assintótica",
        "Algoritmos de Busca",
        "Programação Dinâmica",
        "Equação de Schrödinger",
        "Poço de Potencial Infinito",
        "Oscilador Harmônico Quântico",
        "Matrizes e Determinantes",
        "Sistemas Lineares",
        "Autovalores e Autovetores",
        "Distribuições de Probabilidade",
        "Testes de Hipótese",
        "Análise de Regressão",
        "Pré-Socráticos",
        "Platão e Teoria das Ideias",
        "Aristóteles e Lógica",
        "Memória e Aprendizagem",
        "Atenção e Percepção",
        "Linguagem e Pensamento",
        "Teoria do Prospecto",
        "Vieses Cognitivos",
        "Nudge e Arquitetura de Escolha",
        "Estrutura do DNA",
        "Replicação do DNA",
        "Transcrição e Tradução",
        "Sistema Cardiovascular",
        "Sistema Respiratório",
        "Sistema Digestório",
        "Tensão e Deformação",
        "Torção em Eixos",
        "Flexão em Vigas",
        "Leis de Kirchhoff",
        "Análise Nodal e de Malhas",
        "Circuitos RC, RL e RLC",
        "Escopo e Planejamento",
        "Cronograma e Caminho Crítico",
        "Gestão de Riscos",
        
        # Novos subtópicos com A
        "Álgebra Booleana",
        "Análise Combinatória",
        "Arquitetura de Computadores",
        "Algoritmos de Ordenação",
        "Análise de Complexidade",
        "Autômatos e Linguagens Formais",
        "Álgebra Relacional",
        "Análise de Dados",
        "Aprendizado de Máquina",
        "Arquitetura de Software",
        "Análise de Requisitos",
        "Administração de Sistemas",
        "Arte Digital",
        "Animação 3D",
        "Acústica Musical",
        "Arranjos Orquestrais",
        "Anatomia Artística",
        "Arte Contemporânea",
        "Arqueologia Histórica",
        "Antropologia Social",
        "Administração Pública",
        "Análise Econômica",
        "Agronomia Sustentável",
        "Astronomia Observacional",
        "Astrofísica Estelar",
        "Análise Química",
        "Álgebra Abstracta",
        "Análise Numérica",
        "Álgebra Geométrica",
        "Análise Funcional",
        "Anatomia Comparada",
        "Antibiograma e Resistência",
        "Auxologia e Crescimento",
        "Análises Clínicas",
        "Anestesiologia",
        "Angiologia e Cirurgia Vascular",
        "Aparelho Locomotor",
        "Audiologia",
        "Alergia e Imunologia",
        "Agricultura Orgânica",
        "Aquicultura e Pesca",
        "Arborização Urbana",
        "Análise Ambiental",
        "Auditoria Contábil",
        "Análise de Investimentos",
        "Administração Financeira",
        "Arquivologia e Gestão Documental"
      ]

      subtopics_created = 0

      subtopics.each do |subtopic_name|
        subtopic = Subtopic.find_or_create_by!(name: subtopic_name)
        
        if subtopic.persisted? && !subtopic.previously_new_record?
          puts "Subtópico encontrado: #{subtopic.name}"
        else
          subtopics_created += 1
          puts "Subtópico criado: #{subtopic.name}"
        end
      end

      puts "População concluída! Subtópicos criados: #{subtopics_created}, total: #{Subtopic.count}"
    end

    desc "Limpa todos os subtópicos"
    task clear_subtopics: :environment do
      puts "Limpando todos os subtópicos..."
      count = Subtopic.count
      Subtopic.destroy_all
      puts "#{count} subtópicos removidos."
    end

    desc "Recria os subtópicos (limpa e popula)"
    task reset_subtopics: :environment do
      Rake::Task['db:populate:clear_subtopics'].invoke
      Rake::Task['db:populate:subtopics'].invoke
    end
  end
end