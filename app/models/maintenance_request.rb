class MaintenanceRequest < ActiveRecord::Base
    belongs_to :maintenance_type
    belongs_to :user
    belongs_to :request_status
end
