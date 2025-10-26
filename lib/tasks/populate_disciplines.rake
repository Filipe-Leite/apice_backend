namespace :db do
  namespace :populate do
    desc "Popula o banco de dados com disciplinas"
    task disciplines: :environment do
      puts "Iniciando população das disciplinas..."
      
      disciplines = [
        "Administration",
        "Aeronautics", 
        "Agronomy / Agriculture",
        "Anthropology",
        "Archaeology",
        "Architecture",
        "Arts",
        "Astronomy",
        "Astrophysics",
        "Audiovisual Studies",
        "Biochemistry",
        "Biology",
        "Biomedical Sciences",
        "Biotechnology",
        "Business Administration",
        "Chemical Engineering",
        "Chemistry",
        "Civil Engineering",
        "Communication Studies",
        "Computer Science",
        "Dentistry",
        "Economics",
        "Education",
        "Electrical Engineering",
        "Environmental Sciences",
        "Philosophy",
        "Physics",
        "Political Science",
        "Psychology",
        "Sociology",
        "Software Engineering",
        "Statistics",
        "Telecommunications",
        "Theater",
        "Theology",
        "Transportation Engineering",
        "Urban Planning",
        "Veterinary Medicine",
        "Visual Arts"
      ]

      disciplines.each do |discipline_name|
        # Usando find_or_create_by para evitar duplicatas
        discipline = Discipline.find_or_create_by!(name: discipline_name)
        puts "Disciplina criada/encontrada: #{discipline.name}"
      end

      puts "População concluída! Total de disciplinas: #{Discipline.count}"
    end

    desc "Limpa todas as disciplinas (cuidado!)"
    task clear_disciplines: :environment do
      puts "Limpando todas as disciplinas..."
      count = Discipline.count
      Discipline.destroy_all
      puts "#{count} disciplinas removidas."
    end

    desc "Recria as disciplinas (limpa e popula)"
    task reset_disciplines: :environment do
      Rake::Task['db:populate:clear_disciplines'].invoke
      Rake::Task['db:populate:disciplines'].invoke
    end
  end
end