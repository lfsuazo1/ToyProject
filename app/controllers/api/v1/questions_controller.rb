# frozen_string_literal: true
module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :authenticate_user!

      def index
        @questions = Question.all
        render json: serializer.new(@questions, include: ['user']), status: :ok
      end

      def create
        @question = Question.new(question_params)
        @question.user = current_user
        if @question.save
          render json: serializer.new(@question, include: ['user']), status: :created
        else
          render json: { errors: @question.errors }, status: 422
        end
      end

      def show

          @question = Question.find(params[:id])
          render json: serializer.new(@question,include:['user'])
        rescue ActiveRecord::RecordNotFound
          render json: { error:{"status":404,"detail":"Object not found"} }, status: :not_found

      end

      def update
        @question = Question.find(params[:id])
        if @question.update(question_params)
          render json: serializer.new(@question) , status: :ok
        else
          render json: {data: @question.errors },
                 status: :unprocessable_entity
        end
        rescue ActiveRecord::RecordNotFound
          render json: { error:{"status":404,"detail":"Object not found"} }, status: :not_found
      end

      def destroy
        @question = Question.find(params[:id])
        if @question.destroy
          render json:[], status: :ok
        else
          render json: { errors: @question.errors }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error:{"status":404,"detail":"Object not found"} }, status: :not_found

      end

      private

      def serializer
        QuestionSerializer
      end

      def question_params
        params.require(:question).permit(:message)
      end
    end
  end
end
