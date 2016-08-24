module Tritech
  class API < Grape::API
    version 'v1', using: :header, vendor: 'tritech'
    format :json
    prefix :api
    


    helpers do
      def current_organization 
        @current_organization
      end
    end

    resource :organizations do
      desc 'Return an organization with public and private key.'
      post do
        Organizations.create(name: params[:name])
      end
    end

    resource :users do
      desc 'Return an organization with public and private key.'
      http_basic do |id, private_key|
        @current_organization = Organizations.authenticate!(id, private_key)
      end
      post do
        Users.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], organization_id: current_organization.id)
      end
      get do
        Users.where(organization_id: current_organization.id)
      end

      route_param :id do
        get :products do
          Users.find(params[:id]).products
        end
        post :products do
          user = Users.find(params[:id])
          user.create_product(name: params[:name], category: params[:category])
        end
      end
    end
  end
end