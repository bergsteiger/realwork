{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMS.Consts;

interface

resourcestring
  sBodyTypeNotFound = 'Body does not contain %s';
  sAddNotSupported = 'Add not supported';
  sNameNotFound = 'Name not found: %s';
  sNoEndpointImplementationFound = 'No endpoint implementation found';
  sHeaderNotFound = 'Header not found: %s';
  sSetValueNotSupported = 'SetValue not supported';
  sDuplicateEndpoints = 'Duplicate endpoints: %0:s.  Each endpoint must have a different HTTP method or URL';
  sConstructorNotFound = 'Constructor not found for %s';
  sUnrecognizedEndpointMethodSignature = 'Unrecognized signature for endpoint method %0:s.%1s';

  sUnauthorizedDescription = 'The credentials of the request are not authorized for the requested operation.';
  sUnauthorizedMessage = 'Unauthorized request';
  sNotFoundDescription = 'The request does not identify a known application, resource, endpoint, or entity';
  sNotFoundMessage = 'Not found';
  sForbiddenDescription = 'The request is for an operation that is not allowed';
  sForbiddenMessage = 'Forbidden';
  sBadRequestDescription = 'The request has unexpected or missing query parameters, url segments or request body';
  sBadRequestMessage = 'Bad request';
  sDuplicateDescription = 'The request is to create or rename an entity, with a name already in use';
  sDuplicateMessage = 'Duplicate';

  sGroupNotFound = 'Group not found: %s';
  sChannelNamesExpected = 'Channel names expected';


  sSwaggerVersion = '2.0';
  sEMSMetaDataVersion = '0.0.0';
  sEMSMetaDataTitle = 'EMS API Documentation';
  sEMSMetaDataDescription = 'Enterprise Mobility Services API' +  sLineBreak +  sLineBreak +
      '  [Learn about EMS](https://www.embarcadero.com/products/rad-studio/enterprise-mobility-services)' +  sLineBreak +  sLineBreak +
      '  EMS (Enterprise Mobility Services) offers a Mobile Enterprise Application Platform (MEAP)'+  sLineBreak +  sLineBreak +
      '  TurnKey Middleware for Interconnected Distributed Apps';
  sAuthHeaderDesc = 'Header used by the EMS server';

implementation

end.
