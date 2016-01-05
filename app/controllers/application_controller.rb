class ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing, with: ''
end
