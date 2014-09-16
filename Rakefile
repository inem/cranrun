require_relative "app"

task :fetch do
  app = App.new
  app.first_run("fixtures/contrib.html")
end

task :update do
  app = App.new
  app.update("fixtures/contrib2.html")
end
