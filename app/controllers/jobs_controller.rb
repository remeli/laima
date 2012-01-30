# encoding:utf-8
class JobsController < ApplicationController
  respond_to :html
  
  def index
    @jobs = Job.all
    respond_to @jobs
  end
  
  def show
    @job = Job.find(params[:id])
    respond_to @job
  end
  
  def new
    @job = Job.new
    respond_to @job
  end
  
  def edit
    @job = Job.find(params[:id])
    respond_to @job
  end
  
  def create
    @job = Job.new(params[:job])
    if @job.save
      flash[:notice] = "Работа успешно добавлена"
      respond_with(@job, :location => jobs_path)
    else
      render 'new'
    end
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.update_attrbiutes(params[:job])
      flash[:notice] = "Работа успешно обновлена"
      respond_with(@job, :location => jobs_path)
    else
      render 'edit'
    end
  end
  
  def delete
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to(jobs_path, :notice => "Работа успешно удалена")
  end
end
