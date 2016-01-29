{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ *************************************************************************** }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit Web.WebConst;

interface

resourcestring
  sErrorDecodingURLText = 'Error decoding URL style (%%XX) encoded string at position %d';
  sInvalidURLEncodedChar = 'Invalid URL encoded character (%s) at position %d';
  sInvalidHTMLEncodedChar = 'Invalid HTML encoded character (%s) at position %d';    
  sInvalidActionRegistration = 'Invalid Action registration';
  sDuplicateActionName = 'Duplicate action name';
  sFactoryAlreadyRegistered = 'Web Module Factory already registered';
  sAppFactoryAlreadyRegistered = 'Web App Module Factory already registered.';
  sOnlyOneDispatcher = 'Only one WebDispatcher per form/data module';
  sHTTPItemName = 'Name';
  sHTTPItemURI = 'PathInfo';
  sHTTPItemEnabled = 'Enabled';
  sHTTPItemDefault = 'Default';
  sHTTPItemProducer = 'Producer';

  sResNotFound = 'Resource %s not found';

  sTooManyColumns = 'Too many table columns';
  sFieldNameColumn = 'Field Name';
  sFieldTypeColumn = 'Field Type';

  sInvalidWebComponentsRegistration =  'Invalid Web component registration';
  sInvalidWebComponentsEnumeration =  'Invalid Web component enumeration';
  sInvalidWebParent = 'Operation not supported.  %s component does not support IGetWebComponentList'; 
                                                      
  sVariableIsNotAContainer = 'Variable %s is not a container';
  sInternalApplicationError = '<html><body><h1>Internal Application Error</h1>' + sLineBreak +
                              '<p>%0:s' + sLineBreak +
                              '<p><hr width="100%%"><i>%1:s</i></body></html>';
  sInvalidParent = 'Invalid parent';

  sActionDoesNotProvideResponse = 'Action does not provide response';
  sActionCantRespondToUnkownHTTPMethod = 'Action can''t respone to unknown HTTP method';
  sActionCantRedirectToBlankURL = 'Action can''t redirect to blank URL';

  sWebFileExtensionItemExtensions = 'Extensions';
  sWebFileExtensionItemMimeType = 'Mime Type';
  sDuplicateMimeTypes = 'Duplicate mime types for extension: %s';
  sWebFileDirectoryItemMask = 'Directory Mask';
  sWebFileDirectoryItemAction = 'Action';
  sWebFileExtensionsItemDisplayName = 'Mime type: ''%0:s'', Extensions: ''%1:s''';
  sWebDirectoryInclude = 'Include';
  sWebDirectoryExclude = 'Exclude';
  sWebDirectoryItemDisplayName = 'Action: %0:s, Mask: ''%1:s''';

implementation

end.

