{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
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
  sDuplicateActionName = 'Duplicate action name';
  sOnlyOneDispatcher = 'Only one WebDispatcher per form/data module';
  sHTTPItemName = 'Name';
  sHTTPItemURI = 'PathInfo';
  sHTTPItemEnabled = 'Enabled';
  sHTTPItemDefault = 'Default';
  sHTTPItemProducer = 'Producer';
  sHTTPItemMethod = 'Method';

  sResNotFound = 'Resource %s not found';

  sTooManyColumns = 'Too many table columns';
  sFieldNameColumn = 'Field Name';
  sFieldTypeColumn = 'Field Type';

  sInternalApplicationError = '<html><body><h1>Internal Application Error</h1>' + sLineBreak +
                              '<p>%0:s' + sLineBreak +
                              '<p><hr width="100%%"><i>%1:s</i></body></html>';
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

