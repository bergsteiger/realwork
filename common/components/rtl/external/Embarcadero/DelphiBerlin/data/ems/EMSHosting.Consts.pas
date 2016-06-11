{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.Consts;

interface

resourcestring

  sResourceNotFound = 'Resource not found: %s';
  sResourceErrorMessage = 'Resource error';
  sResourceMultipleEndpoints = 'Unable to resolve request to a single endpoint';
  sEdgeEOFError =  'Unexpected eof in Edge payload';
  sEdgeContentError =  'Unexpected content in edge payload';
  sEdgeFactoryDuplicate = 'Duplicate Edge payload handlers not allowed';
  sEdgeFactoryNotFound = 'Edge payload handler not found';
  sEdgeVersionError = 'Unexpected version in edge payload';
  sEdgeOldVersionError = 'Unexpected older version in edge payload';
  sEdgeModuleNameBlank = 'EdgeService registration error.  ModuleName must not be blank';
  sEdgeProtocolBlank = 'EdgeService registration error.  ListenerProtocol must not be blank';
  sEdgeUnknownListenerProtocol = 'Unknown listener protocol: %s';
implementation

end.
