{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.Consts;

interface

resourcestring
  sUnknownQueryCondition = 'Unknown query condition';
  sMissingClassForQuery = 'Missing class for query';
  sMissingExpressionForQuery = 'Missing expression for query';
  sObjectNotAttachedToBackend = 'Object not attached to backend';
  sFormatParseError = 'Parse Error: %0:s (%1:d)';
  sFormatKinveyError = 'Kinvey Error: %0:s. %1:s';
  sSessionIDRequired =  'SessionID required';
  sAPIKeyRequired =  'APIKey required';
  sBackendClassNameRequired = 'BackendClassName required';
  sJSONObjectRequired = 'JSON object required';
  sInvalidAuthenticationForThisOperation = 'Invalid authentication (%0:s) for this operation. %1:s';
  sUseValidAuthentication = 'Use %s.';
  sUseValidAuthentications = 'Use %0:s or %1:s.';
  sAccessDenied = 'Access denied';
  sJSONObjectExpected = 'JSON object expected';
  sChannelNamesExpected = 'Channel names expected';
  sDeviceNamesExpected = 'Device names expected';
  sOneUserExpected = 'One user expected';

  sNoBackendService =  'Cannot complete operation because a service is not available.  %s.Provider property must not be nil.';

  sObjectIDRequired = 'ObjectID required';
  sMasterKeyRequired = 'MasterKey required';
  sAuthTokenRequired = 'AuthToken required';
  sBackendCollectionNameRequired = 'BackendCollectionName required';
  sAppKeyRequired = 'AppKey required';
  sAppSecretRequired = 'AppSecret required';
  sMasterSecretRequired = 'MasterSecret required';
  sUserNameRequired = 'User name required';
  sGroupNameRequired = 'Group name required';

  sNoMetaFactory =  'No meta type factory';
  sObjectNotFound = 'Object not found';

  sPushEventsProviderRequired = 'Provider is nil.  A provider is required to use push events';
  sPushEventsNotSupportByProvider =  'Push events are not supported by the "%s" provider on this platform';
  sPushEventsPushServiceConnectionRequired = 'Application is not connected to push service.  Push service connection is required to register or unregister an application';

  sPushDeviceNoPushService = 'No %0:s compatible push service available for device "%1:s"';
  sPushDevicePushServiceNotFound = 'Push service "%1:s" not found.  %0:s requires this service.';
  sPushDeviceGCMAppIDBlank = 'GCM AppID is blank.  Specify a GCM AppID.';

  sServiceNotSupportedByProvider = 'Service not supported by %s provider';

  sDuplicateProviderID = 'Duplicatate ProviderID: %s';
  sProviderNotFound = 'Provider not found: %s';
  sDuplicateService = 'Duplicate service for provider: %s';
  sUnregisterServiceNotFound = 'Unregister error.  Service not found for provider: %s';
  sUnregisterProviderNotFound = 'Unregister error.  Provider "%s" not registered.';
  sBackendThreadRunning = 'A backend thread can''t be started because it is already running.';
  sUnsupportedBackendQueryType = 'Unsupported Backend query type: %s';

  sCreateAtRequired = 'CreatedAt required';
  sDownloadUrlRequired = 'Download URL required';
  sExpiresAtRequired = 'ExpiresAt required';
  sUpdatedAtRequired = 'UpdatedAt required';
  sFileNameRequired = 'Filename required';
  sFileIDRequired = 'FileID required';
  sDataTypeNameRequired = 'Data type name required';

  sUnexpectedDeleteObjectCount = 'Unexpected delete count: %d';
  sParameterNotMetaType = 'Parameter is not meta type';

  sPushDeviceParseInstallationIDBlankDelete = 'Installation ID is blank.  Installation ID is required to delete a Parse installation';

  sKinveyRequiresCustomEndpoint = 'Kinvey push service requires a custom endpoint.';

  sExtrasName = 'Name';
  sExtrasValue = 'Value';

  sDeviceIDUnavailable = 'DeviceID is not available.  This application may not be configured to support push notifications';
  sDeviceTokenUnavailable = 'DeviceToken is not available.  This application may not be configured to support push notifications';
  sDeviceTokenRequestFailed = 'DeviceToken request failed: %s';

  sOperationRequiresAuthentication = 'Request requires %s authentication';
  sAuthenticationNotSupported = 'Authentication type, %s, is not supported.';

  sParameterNotLogin = 'Login parameter does not identify a logged in user';

  sBackendAuthMultipleProviders = 'In order to Login or Signup, all components must be connected to the same provider';
  sBackendAuthMismatchedProvider = 'Auth component and connected components must use the same provider';
  sLoginRequired = 'Operation cannot be completed because a user is not logged in.';

  sWrongProvider = 'Wrong provider';

implementation

end.
