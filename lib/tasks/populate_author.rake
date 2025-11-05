namespace :db do
  namespace :populate do
    desc "Popula o banco de dados com autores"
    task authors: :environment do
      puts "Iniciando população dos autores..."
      
      authors = [
        # Autores com A (novos)
        "Alan Turing",
        "Albert Einstein",
        "Alexander Graham Bell",
        "Alfred Nobel",
        "Alice Walker",
        "Alistair MacLean",
        "Amartya Sen",
        "Amy Tan",
        "André Gide",
        "Andrew Wiles",
        "Anne Frank",
        "Anne Rice",
        "Anthony Burgess",
        "Anton Chekhov",
        "Antonie van Leeuwenhoek",
        "Archimedes",
        "Aristotle",
        "Arthur C. Clarke",
        "Arthur Conan Doyle",
        "Arthur Schopenhauer",
        "Auguste Comte",
        "Augustus De Morgan",
        "Ayn Rand",
        "Alan Moore",
        "Aldous Huxley",
        "Alexander Hamilton",
        "Algernon Charles Swinburne",
        "Alice Munro",
        "Alberto Moravia",
        "Aleksandr Solzhenitsyn",
        "Alessandro Manzoni",
        "Alexandre Dumas",
        "Alfred Hitchcock",
        "Alfred Lord Tennyson",
        "Alistair Cooke",
        "Allen Ginsberg",
        "Alvarez de Toledo",
        "Ambrose Bierce",
        "Anatole France",
        "André Malraux",
        "Andrea Camilleri",
        "Angela Carter",
        "Anita Desai",
        "Ann Patchett",
        "Annie Dillard",
        "Annie Proulx",
        "Anthony Trollope",
        "Antonio Gramsci",
        "Apollinaire",
        "Arata Isozaki",
        "Archer Mayor",
        "Archie Brown",
        "Arctic Monkeys",
        "Ariel Dorfman",
        "Aristophanes",
        "Arnaldur Indriðason",
        "Arnold Bennett",
        "Arnold J. Toynbee",
        "Arto Paasilinna",
        "Arthur Golden",
        "Arthur Miller",
        "Arthur Ransome",
        "Astrid Lindgren",
        "Atul Gawande",
        "Avery Corman",
        "Azar Nafisi",

        # Autores famosos da ciência e tecnologia
        "Isaac Newton",
        "Marie Curie",
        "Stephen Hawking",
        "Richard Feynman",
        "Grace Hopper",
        "Linus Torvalds",
        "Tim Berners-Lee",
        "Donald Knuth",
        
        # Autores de matemática
        "Carl Gauss",
        "Leonhard Euler",
        "Évariste Galois",
        "Henri Poincaré",
        "John von Neumann",
        "Kurt Gödel",
        "Paul Erdős",
        "Terence Tao",
        "Sophie Germain",
        
        # Autores de programação
        "Martin Fowler",
        "Robert C. Martin",
        "Kent Beck",
        "Erich Gamma",
        "Grady Booch",
        "James Gosling",
        "Bjarne Stroustrup",
        "Guido van Rossum",
        "Yukihiro Matsumoto",
        "Anders Hejlsberg",
        
        # Autores de filosofia
        "Platão",
        "Sócrates",
        "René Descartes",
        "Immanuel Kant",
        "Friedrich Nietzsche",
        "Jean-Paul Sartre",
        "Simone de Beauvoir",
        "Ludwig Wittgenstein",
        "John Locke",
        
        # Autores de psicologia
        "Sigmund Freud",
        "Carl Jung",
        "B.F. Skinner",
        "Jean Piaget",
        "Lev Vygotsky",
        "Abraham Maslow",
        "Carl Rogers",
        "Steven Pinker",
        "Elizabeth Loftus",
        
        # Autores de literatura técnica
        "Robert Sedgewick",
        "Thomas Cormen",
        "Alfred Aho",
        "Jeffrey Ullman",
        "Stuart Russell",
        "Peter Norvig",
        "Andrew Ng",
        "Yann LeCun",
        "Geoffrey Hinton",
        "Joshua Bloch"
      ]

      authors_created = 0

      authors.each do |author_name|
        author = Author.find_or_create_by!(name: author_name)
        
        if author.persisted? && !author.previously_new_record?
          puts "Autor encontrado: #{author.name} (Reference: #{author.reference})"
        else
          authors_created += 1
          puts "Autor criado: #{author.name} (Reference: #{author.reference})"
        end
      end

      puts "População concluída! Autores criados: #{authors_created}, total: #{Author.count}"
      
      # Estatísticas sobre autores com A
      authors_with_a = Author.where("name ILIKE 'a%'")
      puts "Autores que começam com 'A': #{authors_with_a.count}"
      puts "Lista de autores com A:"
      authors_with_a.each do |author|
        puts "  - #{author.name}"
      end
    end

    desc "Limpa todos os autores"
    task clear_authors: :environment do
      puts "Limpando todos os autores..."
      count = Author.count
      Author.destroy_all
      puts "#{count} autores removidos."
    end

    desc "Recria os autores (limpa e popula)"
    task reset_authors: :environment do
      Rake::Task['db:populate:clear_authors'].invoke
      Rake::Task['db:populate:authors'].invoke
    end
  end
end