namespace :db do
  namespace :populate do
    desc "Popula o banco de dados com sources (fontes) - apenas título"
    task sources: :environment do
      puts "Iniciando população das sources..."

      sources_titles = [
        # Fontes com A (novas)
        "Álgebra Abstrata",
        "Análise Complexa",
        "Algoritmos Avançados",
        "Arquitetura de Software Moderna",
        "Android Development Guide",
        "API Design Patterns",
        "Artificial Intelligence: A Modern Approach",
        "Applied Cryptography",
        "Advanced Data Structures",
        "Automated Software Testing",
        "Agile Methodology Handbook",
        "AWS Cloud Practitioner",
        "Azure Infrastructure Guide",
        "Arduino Programming",
        "Applied Machine Learning",
        "Advanced Neural Networks",
        "Atomic Habits",
        "Art of War",
        "Anna Karenina",
        "A Tale of Two Cities",
        "Animal Farm",
        "A Clockwork Orange",
        "A Brief History of Humankind",
        "Astrophysics for People in a Hurry",
        "Advanced Quantum Mechanics",
        "Applied Electromagnetism",
        "Analytical Chemistry",
        "Anatomy and Physiology",
        "Advanced Pharmacology",
        "Agricultural Engineering",
        "Aeronautical Principles",
        "Automotive Systems",
        "Architectural Design",
        "Art History: Renaissance",
        "Ancient Greek Philosophy",
        "American History",
        "African Anthropology",
        "Asian Economies",
        "Accounting Principles",
        "Advanced Marketing",
        "Administrative Law",
        "Alternative Energy",
        "Aquatic Ecosystems",
        "Atmospheric Science",
        "Algebraic Topology",
        "Applied Statistics",
        "Algorithmic Game Theory",
        "Automata Theory",
        "Advanced Compiler Design",
        "Axiomatic Set Theory",

        # Fontes de Matemática
        "Cálculo Volume 1",
        "Cálculo Volume 2", 
        "Álgebra Linear e suas Aplicações",
        "Geometria Analítica",
        "Equações Diferenciais",
        "Teoria dos Números",
        "Probabilidade e Estatística",
        "Análise Real",
        "Topologia Geral",
        "Matemática Discreta",

        # Fontes de Programação
        "Clean Code: A Handbook of Agile Software Craftsmanship",
        "The Pragmatic Programmer",
        "Design Patterns: Elements of Reusable Object-Oriented Software",
        "Refactoring: Improving the Design of Existing Code",
        "Introduction to Algorithms",
        "Structure and Interpretation of Computer Programs",
        "The Art of Computer Programming",
        "Code Complete",
        "You Don't Know JS",
        "The Rust Programming Language",

        # Fontes de Física
        "The Feynman Lectures on Physics",
        "A Brief History of Time",
        "The Theory of Everything",
        "Quantum Mechanics: The Theoretical Minimum",
        "Classical Mechanics",
        "Electrodynamics",
        "Thermodynamics and Statistical Mechanics",
        "General Relativity",
        "String Theory for Dummies",
        "The Particle at the End of the Universe",

        # Fontes de Filosofia
        "A República",
        "Crítica da Razão Pura",
        "Assim Falou Zaratustra",
        "O Ser e o Nada",
        "Meditações Metafísicas",
        "A Ética a Nicômaco",
        "O Leviatã",
        "A Riqueza das Nações",
        "O Contrato Social",
        "A Origem das Espécies",

        # Fontes de Psicologia
        "Thinking, Fast and Slow",
        "Predictably Irrational",
        "The Man Who Mistook His Wife for a Hat",
        "Influence: The Psychology of Persuasion",
        "Emotional Intelligence",
        "Flow: The Psychology of Optimal Experience",
        "The Interpretation of Dreams",
        "Modern Man in Search of a Soul",
        "The Archetypes and the Collective Unconscious",
        "Beyond Freedom and Dignity",

        # Fontes de Biologia
        "The Double Helix",
        "The Selfish Gene",
        "The Origin of Species",
        "The Diversity of Life",
        "Molecular Biology of the Cell",
        "Biology for Dummies",
        "Human Anatomy",
        "Principles of Genetics",
        "Microbiology: An Introduction",
        "Ecology: Concepts and Applications",

        # Fontes de Engenharia
        "Mechanics of Materials",
        "Fundamentals of Thermodynamics",
        "Control Systems Engineering",
        "Digital Design and Computer Architecture",
        "Signals and Systems",
        "Electric Circuits",
        "Engineering Economy",
        "Project Management: A Systems Approach",
        "Structural Analysis",
        "Fluid Mechanics",

        # Fontes de Economia
        "Nudge: Improving Decisions About Health, Wealth, and Happiness",
        "Freakonomics",
        "Thinking in Systems",
        "The Wealth of Nations",
        "Capital in the Twenty-First Century",
        "The General Theory of Employment, Interest and Money",
        "Principles of Economics",
        "Economics for Dummies",
        "Behavioral Economics",
        "Monetary Theory and Policy",

        # Fontes de Medicina
        "Harrison's Principles of Internal Medicine",
        "Gray's Anatomy",
        "The Johns Hopkins Manual of Gynecology and Obstetrics",
        "Robbins and Cotran Pathologic Basis of Disease",
        "Goodman & Gilman's The Pharmacological Basis of Therapeutics",
        "Current Medical Diagnosis and Treatment",
        "The Washington Manual of Medical Therapeutics",
        "Clinical Neurology",
        "Principles of Surgery",
        "Textbook of Radiology"
      ]

      sources_created = 0

      sources_titles.each do |title|
        source = Source.find_or_create_by!(title: title)
        
        if source.persisted? && !source.previously_new_record?
          puts "Source já existente: #{source.title}"
        else
          sources_created += 1
          puts "Source criada: #{source.title}"
        end
      end

      puts "População concluída! Sources criadas: #{sources_created}, total: #{Source.count}"
      
      # Estatísticas sobre sources com A
      sources_with_a = Source.where("title ILIKE 'a%'")
      puts "Sources que começam com 'A': #{sources_with_a.count}"
      puts "Lista de sources com A:"
      sources_with_a.each do |source|
        puts "  - #{source.title}"
      end
    end

    desc "Limpa todas as sources"
    task clear_sources: :environment do
      puts "Limpando todas as sources..."
      count = Source.count
      Source.destroy_all
      puts "#{count} sources removidas."
    end

    desc "Recria as sources (limpa e popula)"
    task reset_sources: :environment do
      Rake::Task['db:populate:clear_sources'].invoke
      Rake::Task['db:populate:sources'].invoke
    end
  end
end