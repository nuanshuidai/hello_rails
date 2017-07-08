class CandidatesController < ApplicationController
    before_action :find_candidate, only: [:edit, :update, :destroy, :vote]
    
    def index
        @candidates = Candidate.all
    end

    def new
        @candidate = Candidate.new
        
    end

    def create
        @candidate = Candidate.new(candidate_params)
        
        if @candidate.save
            #成功
            ContactMailer.say_hello_to(@candidate).deliver_now
            redirect_to candidates_path, notice: "新增候选人成功！"
        else
            #失败
            render :new
        end
    end

    def edit
        #@candidate = Candidate.find_by(id:params[:id])
    end

    def update
        #@candidate = Candidate.find_by(id:params[:id])

        if @candidate.update(candidate_params)
            #成功
            redirect_to candidates_path, notice: "资料更新成功！"
        else
            #失败
            render :edit
        end 
        
    end

    def destroy
        #@candidate = Candidate.find_by(id:params[:id])
        @candidate.destroy if @candidate
        redirect_to candidates_path, notice: "资料删除成功！"
        
        
    end

    def vote
        #@candidate = Candidate.find_by(id:params[:id])
        @candidate.vote_logs.create(ip_address:request.remote_ip) if @candidate
        redirect_to candidates_path, notice: "完成投票！"
    end 

    private
    
    def candidate_params
        params.require(:candidate).permit(:name,:age,:party,:politics)

    end
    
    def find_candidate
        @candidate = Candidate.find_by(id:params[:id])
    end
end
