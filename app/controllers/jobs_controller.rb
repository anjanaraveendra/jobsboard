class JobsController < ApplicationController
  def index
  end

  def new
    @job = Job.new
  end

  def index
    @jobs = Job.page(params[:page]).per(25)
  end

  def show
    @job = Job.find(params[:id])
    render :action => 'show'
  end

  def create
    @job = Job.new(params.require(:job).permit(:title, :company, :url))
  if @job.save
    redirect_to root_path
  else
    render "new"
  end
 end

 def edit
    @job = Job.find(params[:id])
 end

# def update
#     @job = Job.find(params[:id])
#     if @job.update(job_params)
#       format.html { redirect_to @job, notice: 'Job was successfully updated.' }
#       format.json { head :no_content }
#     else
#       render 'edit'
#     end
# end

  def update
    @job = Job.find params[:id]

      if @job.update(job_params)
        redirect_to jobs_path      
      else
        format.html { render :edit }
      end
  end

 def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to(:back)
    flash[:error] = "Job was destroyed!"
  end

  private

   def job_params
     params.require(:job).permit(:title, :company, :url)
   end

end
