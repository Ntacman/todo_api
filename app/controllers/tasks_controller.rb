class TasksController < ApplicationController

  def index
    @tasks = Task.all.where(user: session[:user])
    @tasks = @tasks.where(:completed => true) if task_params[:filter] == 'completed'
    render json: @tasks.to_json(:only => [:title, :completed])
  end

  def uncompleted_tasks
    @tasks = Task.all.where(user: session[:user], completed: false)
    render json: @tasks.to_json
  end

  def completed_tasks
    @tasks = Task.all.where(user: session[:user], completed: true)

    render json: @tasks.to_json
  end

  def show
    @task = Task.find(task_params[:id])
    render json: @task.to_json
  end

  def create
    @task = Task.new(task_params[:task])
    @task.user = session[:user]

    if @task.save
      render json: {"title": @task.title, "completed": @task.completed}
    else
      render json: @task.errors
    end
  end

  def update
    @task = Task.find_by(id: task_params[:id], user: session[:user])

    if @task.update(task_params[:task])
      render json: {"title": @task.title, "completed": @task.completed}
    else
      render json: @task.errors
    end
  end

  def destroy
    @task = Task.find_by(id: task_params[:id], user: session[:user])
    @task.destroy
  end

  private

  def task_params
    params.permit(:id, :filter, { task: [:title, :note]})
  end

end
