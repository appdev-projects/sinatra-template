# first we import sinatra so we have access to its 
# objects and methods
require 'sinatra'

# require active record to make use of it
require 'sinatra/activerecord'

# Define the Task model
class Task < ActiveRecord::Base
  # Attributes
  # - id: integer (primary key)
  # - name: string
  # - description: text
  # - created_at: datetime
  # - updated_at: datetime
end

# add a homepage
get('/') do
  redirect('/tasks')
end

# render a tasks index
get('/tasks') do
  @tasks = Task.all
  erb(:tasks_index)
end

# create a new task
get('/tasks/create') do
  @name = params.fetch("query_task_name")
  @description = params.fetch("query_task_description")

  @task = Task.new
  @task.name = @name
  @task.description = @description
  @task.save
  
  redirect('/tasks')
end

# show page for a task
get('/tasks/:path_id') do
  @task_id = params.fetch("path_id")

  @list_of_tasks = Task.where({ :id => @task_id })
  @task = @list_of_tasks.first

  erb(:tasks_show)
end

# delete task
get('/update_task/:path_id') do
  @task_id = params.fetch("path_id")

  @name = params.fetch("query_task_name")
  @description = params.fetch("query_task_description")

  @list_of_tasks = Task.where({ :id => @task_id })
  @task = @list_of_tasks.first

  @task.name = @name
  @task.description = @description
  @task.save
  
  redirect('/tasks/' + @task_id)
end

# edit task
get('/delete_task/:path_id') do
  @task_id = params.fetch("path_id")

  @list_of_tasks = Task.where({ :id => @task_id })
  @task = @list_of_tasks.first
  @task.destroy

  redirect('/tasks')
end
