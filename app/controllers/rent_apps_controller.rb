class RentAppsController < ApplicationController
    before_action :store_user_location!, if: :storable_location?
    # The callback which stores the current location must be added before you authenticate the user 
    # as `authenticate_user!` (or whatever your resource is) will halt the filter chain and redirect 
    # before the location can be stored.
    before_action :authenticate_user!
    
    def rent_app_params
        params.require(:rent_app).permit(:building_id, :num_bed, :num_bath, :ssn, :dr_license_num,
                                        :license_state, :bank_name, :bank_acct_num, :res_phone,
                                        :work_phone, :names_of_occpts, :pets)
    end
    
    def new
        # renders 'new' template
    end
    
    def create
        @rent_app = RentApp.create!(rent_app_params)
        @rent_app.user_id = current_user.id
        @rent_app.submitted_time = Time.now
        @rent_app.save
        flash[:notice] = "Application successfully submitted."
        redirect_to root_path
    end

    private
    # Its important that the location is NOT stored if:
    # - The request method is not GET (non idempotent)
    # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an 
    #    infinite redirect loop.
    # - The request is an Ajax request as this can lead to very unexpected behaviour.
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
        # :user is the scope we are authenticating
        store_location_for(:user, request.fullpath)
    end
    
    def after_sign_in_path_for(resource_or_scope)
        stored_location_for(resource_or_scope) || super
    end

end
