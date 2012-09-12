require 'salesforce_bulk'
require 'csv'
require 'Constants'
require 'connection_util'
require 'pg'
require "action_mailer"

class ImportLoanPaymentCollection
  include MFiFlexConstants
  include ConnectionUtil
    
  def import(salesforceUserName,salesforcePassword,pgConn,salesforceOrgId)
    salesforce = SalesforceBulk::Api.new(salesforceUserName,salesforcePassword)
    
    # Query using BULK API
    res = salesforce.query(getLoanPaymentCollectionObjName,getLoanPaymentCollectionQuery);
    
    q_result = res.result.records
    
    #Upsert into Postgres
    upsertRecords(getLoanPaymentCollectionObjName,q_result,pgConn,salesforceOrgId)
    
  end
  
end