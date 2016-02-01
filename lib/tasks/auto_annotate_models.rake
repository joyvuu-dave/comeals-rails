if(Rails.env.development?)
  # Annotate models
  task :annotate do
    puts 'Annotating models...'
    system 'bundle exec annotate --show-migration --show-indexes --show-foreign-keys '
  end

  # Run annotate task after db:migrate
  #  and db:rollback tasks
  Rake::Task['db:migrate'].enhance do
    Rake::Task['annotate'].invoke
  end

  Rake::Task['db:rollback'].enhance do
    Rake::Task['annotate'].invoke
  end
end
