require 'salesforce_bulk'
require 'csv'
require 'Constants'
require 'connection_util'
require 'pg'
require "action_mailer"

class ImportCenter
  include MFiFlexConstants
  include ConnectionUtil
    
  def import(salesforceUserName,salesforcePassword,pgConn,salesforceOrgId)
    salesforce = SalesforceBulk::Api.new(salesforceUserName,salesforcePassword)
    
    # Query using BULK API
    res = salesforce.query(getCenterObjName,getCenterQuery);
    
    q_result = res.result.records
    
    #Upsert into Postgres
    upsertRecords(getCenterObjName,q_result,pgConn,salesforceOrgId)
    
  end
  
end