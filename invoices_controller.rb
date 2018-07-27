require 'uri'
require 'base64'
require 'yaml'

class InvoicesController < ApplicationController
  DEFAULT_ITEMS_PER_PAGE = 30
  MAX_ITEMS_PER_PAGE = 50
  XLSX_TOKEN_EXPIRE_TIME = 10

  include SpreadsheetHelper

  skip_before_action :set_current_user, :authenticate_request,
                     if: proc { download_request? }

  def index
    #
  end

  def oauth
    url = construct_baseUrl
    render json: url
  end

  def load_config
    config = YAML.load_file(Rails.root.join('config/QBOconfig.yml'))
    @hostURL = config["Settings"]["host_uri"]
    @baseURL = config["Constant"]["baseURL"]
    @exchangeURL = config["Constant"]["tokenURL"]
    @client_id = config['OAuth2']['client_id']
    @client_secret = config['OAuth2']['client_secret']
    @scope = config["Constant"]["scope"]
    @refresh_token_scope = config["Constant"]["resfresh_grant_type"]
    @redirect_uri = config["Settings"]["redirect_uri"]
    @state = config["Settings"]["state"]
    @response_type = config["Constant"]["response_type"]
    @grant_type = config['Constant']['grant_type']
  end

  def construct_baseUrl
    load_config
    uri = URI(@baseURL)
    query_params = Array.new
    query_params.push(["client_id", @client_id])
    query_params.push(["scope", @scope])
    query_params.push(["redirect_uri", @redirect_uri])
    query_params.push(["response_type", @response_type])
    query_params.push(["state", @state])
    #append query string
    query_params.each do |element|
      params = URI.decode_www_form(uri.query || "") << element
      uri.query = URI.encode_www_form(params)
    end
    return uri
  end
end
