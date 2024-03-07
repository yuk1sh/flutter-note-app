class JournalsController < ApplicationController
	def index
		journals = Journal.all
		render json: journals
	end

	def show
		journal = Journal.find(params[:id])
		render json: journal
	end

	def create
		journal = Journal.create({content: journal_params[:content]})

		render json: journal
	end

	def update
		journal = Journal.find(params[:id])
		journal.update(journal_params)
		render json: journal
	end

	def destroy
		journal = Journal.find(params[:id])
		journal.destroy
		render json: journal
	end

	private

	def journal_params
		params.permit(:content)
	end
end
