namespace :dev do
  
  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Makes the initial setup of develop environment"
  task setup: :environment do
    unless Rails.env.production?
      show_spinner("Deleting current db...") { %x(rails db:drop) }
      show_spinner("Creating new db...") { %x(rails db:create) }
      show_spinner("Runnig migrations...") { %x(rails db:migrate) }
      show_spinner("Creating default adm user...") { %x(rails dev:add_default_admin) }
      show_spinner("Creating more 10 dummy adm users...") { %x(rails dev:add_dummy_adms) }
      show_spinner("Creating default user...") { %x(rails dev:add_default_user) }
      show_spinner("Creating default subjects...") { %x(rails dev:add_subjects) }
      show_spinner("Creating answers and questions for quiz...") { %x(rails dev:add_answers_and_questions) }
    else
      puts "Task available only in development or test environment."
      puts "You are in: #{Rails.env}"
    end
  end

  desc "Creates default adm user"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end
  
  desc "Adds 10 dummy adm users"
  task add_dummy_adms: :environment do
    10.times do
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Creates default user"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adds the subjects related to the questions used in the quiz"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end
  
  desc "Adds the answers and questions for quiz"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      2.times do
        params = create_questions_params(subject)
        answers = params[:question][:answers_attributes] 
        add_answers(answers)
        elect_correct_answer(answers)
        Question.create!(params[:question])
      end
    end
  end

  desc "Reset the counter of subjects"
  task reset_subject_counter: :environment do
    show_spinner("Reseting counters of subjects...") do
      Subject.find_each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end
    end
  end

  private 

  def add_answers(answers = []) 
    rand(2...5).times do |i|
      answers.push(
        { description: Faker::Lorem.sentence, correct: false }
      )
    end
  end

  def create_questions_params(subject = Subject.all.sample)
    { question: {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
    }}
  end

  def elect_correct_answer(answers = [])
    index = rand(answers.size)
    answers[index][:correct] = true
  end
  
  def show_spinner(msg_start, msg_end="(Done!)")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :arrow_pulse)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end
end
