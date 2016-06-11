{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Consts;

interface

const
  HTTP_HEADERFIELD_AUTH = 'Authorization'; // do not localize
  REST_NO_FALLBACK_CHARSET = 'raw'; // do not localize

resourcestring
  RNullableNoValue = 'Nullable type has no value';
  sExecuteRequestNilClient = 'Can''t execute TCustomRESTRequest when Client property is nil.';
  sParameterName = 'Name';
  sParameterValue = 'Value';
  sParameterKind = 'Kind';
  sOperationNotAllowedOnActiveComponent = 'Operation not allowed on active %s';
  sConfigureRESTComponent = 'Configure...';
  sExecuteRESTComponent = 'Execute...';
  sResetRESTClient = 'Reset Client';
  sClearRESTRequest = 'Clear Request Data';
  sClearRESTResponse = 'Clear Response Data';

  sResetRESTClientQuestion = 'Are you sure that you want to reset this Client to its default settings?';
  sClearRESTRequestQuestion ='Are you sure that you want to clear this Request''s data (including its Response)?';
  sClearRESTResponseQuestion ='Are you sure that you want to clear this Response''s data?';
  sInvalidRESTComponent = 'Invalid component-type: "%s"';
  sRESTAdapterUpdateDS = 'Update DataSet';
  sRESTAdapterClearDS = 'Clear DataSet';
  sRESTUnsupportedAuthMethod = 'Unsupported Authentication Method!';
  sRESTUnsupportedRequestMethod = 'Unsupported Request Method';
  sRESTErrorEmptyURL = 'URL for a request must not be empty';
  sRESTErrorEmptyParamName = 'Name of a parameter must not be empty';
  sRESTViewerNoContent = 'There is no content available.';
  sRESTViewerNotAvailable = 'The content-type is not recognized as text. The viewer cannot be opened.';

  sRESTUnsupportedDateTimeFormat = 'Unsupported DateTime format';

  sAdapterResponseComponentIsNil = 'Adapter does not have a Response component';
  sResponseContentIsNotJSON = 'Response content is not valid JSON';
  sResponseContentIsEmpty = 'Response content is empty';
  sAdapterInvalidRootElement = 'Adapter RootElement, "%s", is not a valid path for the response JSON';
  sResponseInvalidRootElement = 'Response RootElement, "%s",  is not a valid path for the response JSON';

  sResponseDidNotReturnArray = 'Response did not return an Array of %s';

  SAuthorizationCodeNeeded = 'An authorization code is needed before it can be changed into an access token.';

  sUnknownContentType = 'Unknown content type: %s';

  sNoClientAttached = 'Request has no client component';
  sUnknownRequestMethod = 'Unknown request-method. Cannot execute request.';
  sRESTRequestFailed = 'REST request failed: %s';

  sUnsupportedProtocol = 'Unsupported Protocol: %s';



implementation

end.
