namespace :db do
  namespace :populate do
    desc "Popula o banco de dados com livros famosos como sources"
    task books: :environment do
      puts "Iniciando população com livros famosos..."
      
      famous_books = [
        # Clássicos da Literatura Mundial
        "Dom Quixote",
        "1984",
        "Orgulho e Preconceito",
        "O Pequeno Príncipe",
        "O Senhor dos Anéis",
        "Harry Potter e a Pedra Filosofal",
        "Crime e Castigo",
        "Ulisses",
        "Cem Anos de Solidão",
        "A Divina Comédia",
        "Guerra e Paz",
        "Moby Dick",
        "Os Miseráveis",
        "Madame Bovary",
        "A Metamorfose",
        "O Processo",
        "O Estrangeiro",
        "Lolita",
        "O Apanhador no Campo de Centeio",
        "O Grande Gatsby",
        "Admirável Mundo Novo",
        "Fahrenheit 451",
        "A Revolução dos Bichos",
        "O Retrato de Dorian Gray",
        "Drácula",
        "Frankenstein",
        "O Médico e o Monstro",
        "Moby Dick",
        "As Vinhas da Ira",
        "O Sol é para Todos",
        "O Velho e o Mar",
        "A Sangue Frio",
        "O Nome da Rosa",
        "A Insustentável Leveza do Ser",
        "Norwegian Wood",
        "A Sombra do Vento",
        "O Caçador de Pipas",
        "A Menina que Roubava Livros",
        "O Código Da Vinci",
        "As Crônicas de Nárnia",

        # Literatura Brasileira
        "O Cortiço",
        "Dom Casmurro",
        "Memórias Póstumas de Brás Cubas",
        "O Guarani",
        "Iracema",
        "Macunaíma",
        "Vidas Secas",
        "Grande Sertão: Veredas",
        "O Tempo e o Vento",
        "Capitães da Areia",
        "Triste Fim de Policarpo Quaresma",
        "O Quinze",
        "Claro Enigma",
        "A Rosa do Povo",
        "Mayombe",
        "A Hora da Estrela",
        "A Paixão Segundo G.H.",
        "Laços de Família",
        "Feliz Ano Novo",
        "A Moreninha",

        # Livros de Filosofia
        "A República - Platão",
        "Assim Falou Zaratustra - Nietzsche",
        "Crítica da Razão Pura - Kant",
        "O Ser e o Nada - Sartre",
        "Meditações - Descartes",
        "Ética a Nicômaco - Aristóteles",
        "O Príncipe - Maquiavel",
        "Leviatã - Hobbes",
        "O Contrato Social - Rousseau",
        "A Riqueza das Nações - Adam Smith",
        "O Capital - Marx",
        "A Origem das Espécies - Darwin",
        "A Interpretação dos Sonhos - Freud",
        "O Mal-Estar na Civilização - Freud",
        "Vigiar e Punir - Foucault",
        "A Arqueologia do Saber - Foucault",
        "O Segundo Sexo - Simone de Beauvoir",

        # Livros de Ciência e Tecnologia
        "Uma Breve História do Tempo - Stephen Hawking",
        "O Gene Egoísta - Richard Dawkins",
        "Cosmos - Carl Sagan",
        "A Estrutura das Revoluções Científicas - Thomas Kuhn",
        "O Andar do Bêbado - Leonard Mlodinow",
        "Sapiens: Uma Breve História da Humanidade - Yuval Harari",
        "Homo Deus: Uma Breve História do Amanhã - Yuval Harari",
        "21 Lições para o Século 21 - Yuval Harari",
        "O Ponto de Mutação - Fritjof Capra",
        "A Teoria de Tudo - Stephen Hawking",
        "O Universo Numa Casca de Noz - Stephen Hawking",
        "A Elegância do Ouriço - Muriel Barbery",
        "O Livro da Física - Vários Autores",
        "O Livro da Matemática - Vários Autores",
        "Os Botões de Napoleão - Penny Le Couteur",
        "A Física do Impossível - Michio Kaku",
        "O Futuro da Mente - Michio Kaku",

        # Livros de Programação e TI
        "Código Limpo - Robert Martin",
        "O Programador Pragmático - Andrew Hunt",
        "Padrões de Projeto - Erich Gamma",
        "Refatoração - Martin Fowler",
        "Introdução a Algoritmos - Cormen",
        "Estruturas de Dados e Algoritmos - Narasimha Karumanchi",
        "O Mythical Man-Month - Frederick Brooks",
        "The Art of Computer Programming - Donald Knuth",
        "Domain-Driven Design - Eric Evans",
        "JavaScript: The Good Parts - Douglas Crockford",
        "Python Crash Course - Eric Matthes",
        "Effective Java - Joshua Bloch",
        "Clean Architecture - Robert Martin",
        "Head First Design Patterns - Eric Freeman",
        "You Don't Know JS - Kyle Simpson",
        "The Rust Programming Language - Steve Klabnik",
        "Eloquent JavaScript - Marijn Haverbeke",

        # Livros de Negócios e Economia
        "Pai Rico, Pai Pobre - Robert Kiyosaki",
        "Os 7 Hábitos das Pessoas Altamente Eficazes - Stephen Covey",
        "A Arte da Guerra - Sun Tzu",
        "Como Fazer Amigos e Influenciar Pessoas - Dale Carnegie",
        "O Poder do Hábito - Charles Duhigg",
        "Rápido e Devagar - Daniel Kahneman",
        "Freakonomics - Steven Levitt",
        "A Estratégia do Oceano Azul - W. Chan Kim",
        "Startup Enxuta - Eric Ries",
        "Good to Great - Jim Collins",
        "A Meta - Eliyahu Goldratt",
        "O Lado Difícil das Situações Difíceis - Ben Horowitz",
        "Trabalhe 4 Horas por Semana - Timothy Ferriss",
        "A Quinta Disciplina - Peter Senge",
        "Inovação na Gestão - Gary Hamel",

        # Livros de Psicologia e Desenvolvimento Pessoal
        "O Poder do Agora - Eckhart Tolle",
        "Mindset - Carol Dweck",
        "O Milagre da Manhã - Hal Elrod",
        "A Coragem de Ser Imperfeito - Brené Brown",
        "O Homem em Busca de um Sentido - Viktor Frankl",
        "Inteligência Emocional - Daniel Goleman",
        "Fluxo - Mihaly Csikszentmihalyi",
        "O Poder do Subconsciente - Joseph Murphy",
        "Os Segredos da Mente Milionária - T. Harv Eker",
        "O Alquimista - Paulo Coelho",
        "Brida - Paulo Coelho",
        "Veronika Decide Morrer - Paulo Coelho",
        "Maktub - Paulo Coelho",
        "Man's Search for Meaning - Viktor Frankl",
        "Thinking, Fast and Slow - Daniel Kahneman",

        # Livros de História
        "Guns, Germs, and Steel - Jared Diamond",
        "Sapiens - Yuval Harari",
        "A História do Mundo - Ernst Gombrich",
        "Os Brasileiros - Laurentino Gomes",
        "1808 - Laurentino Gomes",
        "1822 - Laurentino Gomes",
        "1889 - Laurentino Gomes",
        "Cidadãos - Simon Schama",
        "A Queda - Constantine Pleshakov",
        "O Outro Lado da História - James Loewen",
        "A Era dos Extremos - Eric Hobsbawm",
        "O Século XX - Martin Gilbert",
        "A Primeira Guerra Mundial - Martin Gilbert",
        "A Segunda Guerra Mundial - Antony Beevor",
        "Stalingrado - Antony Beevor"
      ]

      books_created = 0
      books_skipped = 0

      famous_books.each do |book_title|
        source = Source.find_or_initialize_by(title: book_title)
        
        if source.new_record?
          begin
            source.save!
            books_created += 1
            puts "📚 Livro criado: #{source.title}"
          rescue => e
            puts "❌ Erro ao criar livro '#{book_title}': #{e.message}"
          end
        else
          books_skipped += 1
          puts "📖 Livro já existente: #{source.title}"
        end
      end

      puts "\n" + "="*50
      puts "📊 RELATÓRIO DE POPULAÇÃO DE LIVROS"
      puts "="*50
      puts "✅ Livros criados: #{books_created}"
      puts "📖 Livros já existentes: #{books_skipped}"
      puts "📚 Total de livros no banco: #{Source.count}"
      
      # Estatísticas por categoria
      categories = {
        "Clássicos Mundiais" => Source.where("title IN (?)", famous_books[0..39]).count,
        "Literatura Brasileira" => Source.where("title IN (?)", famous_books[40..59]).count,
        "Filosofia" => Source.where("title IN (?)", famous_books[60..76]).count,
        "Ciência/Tecnologia" => Source.where("title IN (?)", famous_books[77..93]).count,
        "Programação/TI" => Source.where("title IN (?)", famous_books[94..109]).count,
        "Negócios/Economia" => Source.where("title IN (?)", famous_books[110..124]).count,
        "Psicologia/Desenvolvimento" => Source.where("title IN (?)", famous_books[125..139]).count,
        "História" => Source.where("title IN (?)", famous_books[140..154]).count
      }
      
      puts "\n--- 📈 Estatísticas por Categoria ---"
      categories.each do |category, count|
        puts "  #{category}: #{count} livros"
      end
      
      # Top 10 livros mais curtos (para demonstração)
      puts "\n--- 📖 Top 10 Livros (mais curtos) ---"
      Source.order("LENGTH(title) ASC").limit(10).each do |source|
        puts "  - #{source.title} (#{source.title.length} chars)"
      end
    end

    desc "Limpa todos os livros das sources"
    task clear_books: :environment do
      puts "Limpando todos os livros das sources..."
      count = Source.count
      Source.destroy_all
      puts "#{count} livros removidos das sources."
    end

    desc "Recria os livros (limpa e popula)"
    task reset_books: :environment do
      Rake::Task['db:populate:clear_books'].invoke
      Rake::Task['db:populate:books'].invoke
    end
  end
end