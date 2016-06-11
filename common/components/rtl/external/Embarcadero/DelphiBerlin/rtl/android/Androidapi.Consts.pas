{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Consts;

interface

resourcestring
  SJNIRTTINotAvailable = 'RTTI for type %s was not found.  Perhaps missing {$M+}?';
  SJNIClassNotFound = 'Java class %s could not be found';
  SJNIType = '%s is not a valid Java type';
  SInternalBindingError = 'Internal error creating binding for ''%s''';
  SBadJNIClass = '''%s'' must be an interface derived from IJavaClass';
  SBadJNIInstance = '''%s'' must be an interface derived from IJavaInstance';
  SErrorCreatingJNIObject = 'Unable to create Java object for instance of ''%s''';
  SJNIInvokeError = 'Fatal error invoking interface';
  SInvalidJNIType = 'The type ''%s'' is not supported with jni interoperability';
  SJNINoInterface = 'No implemented interface found in ''%s''';
  SJNIMethodNotFound = 'Invoke error: method ''%s'' not found';
  SJNIUnknownMethod = 'Invoke error: method not found';
  SJNIInvalidSetter = 'Method ''%s'' is not a valid property setter';
  SJNIInvalidGetter = 'Method ''%s'' is not a valid property getter';

  // In-App Billing messages
  SUnknown = 'Unknown';
  SOk = 'OK';
  SUserCanceled = 'User Canceled';
  SBillingUnavailable = 'Billing Unavailable';
  SItemUnavailable = 'Item unavailable';
  SDeveloperError = 'Developer Error';
  SError = 'Error';
  SItemAlreadyOwned = 'Item Already Owned';
  SItemNotOwned = 'Item not owned';
  SRemoteExceptionOccurred = 'Remote exception during initialization';
  SBadResponse = 'Bad response received';
  SVerificationFailed = 'Purchase signature verification failed';
  SSendIntentFailed =  'Send intent failed';
  SUnknownPurchaseResponse = 'Unknown purchase response';
  SMissingToken = 'Missing token';
  SUnknownError = 'Unknown error';
  SSubscriptionsNotavailable = 'Subscriptions not available';
  SInvalidConsumption = 'Invalid consumption attempt';
  SIABUnavailable = 'Billing service unavailable on device.';
  SIABv3NotFound = 'Error checking for billing v3 support.';
  SSuccess = 'Success';
  SPurchaseDataParse = 'Failed to parse purchase data.';
  SNullReturn = 'IAB returned null purchaseData or dataSignature';
  SNullInResultData = 'Null data in IAB result';
  SSignatureFailureFmt = 'Signature verification failed for sku %s';
  SBuyFailure = 'Unable to buy item';
  SPurchaseProblem = 'Problem purchashing item.';
  SSetupOK = 'Setup successful.';
  SConsumeOKFmt = 'Successful consume of sku %s';
  SInventoryRefreshOK = 'Inventory refresh successful.';
  SNoSubscriptions = 'Subscriptions are not available.';
  sSetupException = 'RemoteException while setting up in-app billing.';
  SConsumeErrorFmt = 'Remote exception while consuming. PurchaseInfo: %s';
  SIABNotSetUpErrorFmt = 'IAB helper is not set up. Can''t perform operation: %s';
  SCantConsumeThoseErrorFmt = 'Items of type ''%s'' can''t be consumed.';
  SSkuTokenMissingErrorFmt = 'PurchaseInfo is missing token for sku: %s %s';
  SIntentSendError = 'Failed to send intent.';
  SBadIntentResponseCodeType = 'Unexpected type for intent response code: %s';
  SBadBundleResponseCodeType = 'Unexpected type for bundle response code: %s';
  SAsyncInProgressError = 'Can''t start async operation (%s) because another async operation(%s) is in progress.';
  SSkuConsumptionErrorFmt = 'Error consuming sku %s';
  SPurchaseFlowError = 'Remote exception while starting purchase flow';
  SInventoryRefreshRemoteError = 'Remote exception while refreshing inventory.';
  SInventoryJSONError = 'Error parsing JSON response while refreshing inventory.';
  SInventoryRefreshOwnedItemsError = 'Error refreshing inventory (querying owned items).';
  SInventoryRefreshItemPricesError = 'Error refreshing inventory (querying prices of items).';
  SInventoryRefreshOwnedSubsError = 'Error refreshing inventory (querying owned subscriptions).';
  SInventoryRefreshSubsPricesError = 'Error refreshing inventory (querying prices of subscriptions).';

implementation

end.
