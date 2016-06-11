{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit uRESTDebuggerResStrs;

interface

resourcestring
  RSCannotProceedWithoutRequest = 'Cannot proceed without Request-Token';
  RSProvideAuthEndPoint = 'Please provide an Authentication-Endpoint';
  RSProvideClientID = 'Please provide a Client-ID (sometimes called "App-Key")';
  RSProvideAuthCode = 'Please provide an Authentication-Code. This value can be requested in Step #1 "Authorization" ';
  RSProvideTokenEndPoint = 'Please provide a Token-Endpoint';
  RSProvideClientIDAndClientSecret = 'Please provide a Client-ID and a Client-Secret (sometimes called "App-Key" / "App-Secret")';
  RSComponentsCopied = 'The following components have been copied to the clipboard: %s';
  RSConfirmDeleteCustomParameter = 'Are you sure you want to delete the custom parameter?';
  RSConfirmClearRecentRequests = 'Are you sure that you want to clear the list of the most recent requests?';
  RSNoCustomParameterSelected = 'No custom parameter selected.';
  RSBytesOfDataReturnedAndTiming = '%d : %s - %d bytes of data returned. Timing: Pre: %dms - Exec: %dms - Post: %dms - Total: %dms';
  RSProxyServerEnabled  = 'Proxy-server enabled: ';
  RSProxyServerDisabled = 'Proxy-server disabled';
  RSContentIsValidJSON = 'Content is valid JSON';
  RSInvalidRootElement = 'Invalid root element';
  RSContentIsNotJSON = 'Content is not JSON';
  RSRootElementAppliesToJSON = 'Root Element, "%s" not applied.  Root Element is only applied to JSON content.  Content is not JSON.';
  RSEditParameter = 'Edit parameter';
  RSEditCustomParameter = 'Edit custom parameter';
  RSAddParameter = 'Add parameter';
  RSAddCustomParameter = 'Add custom parameter';
  RSUnableToValidateCertifcate = 'Unable to validate the certificate of this website.  Continue with this request?';

implementation

end.
