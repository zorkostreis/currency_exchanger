module API
  module V1
    class CurrenciesController < ApplicationController
      def index
        currencies = Currency.sorted.page(params[:page].to_i || 1)

        render json: currencies
      end

      def show
        currency = Currency.find_by!(iso: params[:iso_code]&.upcase)

        render json: currency
      end
    end
  end
end
