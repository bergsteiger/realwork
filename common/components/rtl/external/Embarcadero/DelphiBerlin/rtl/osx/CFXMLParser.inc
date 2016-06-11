{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFXMLParser.h                          }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{  CFXMLParser will be officially deprecated in a future release of Mac OS X. Clients should be
    aware of the fact that CFXMLParser has some serious deficiencies in terms of both performance
    and standards compliance and should migrate their XML parsing to NSXMLParser, NSXMLDocument, or
    other XML parsing technologies that will suit their needs better than CFXMLParser.
 }

{$IFNDEF __COREFOUNDATION_CFXMLPARSER__}

{$DEFINE __COREFOUNDATION_CFXMLPARSER__}

{$I CFArray.inc}
{$I CFBase.inc}
{$I CFData.inc}
{$I CFDictionary.inc}
{$I CFTree.inc}
{$I CFURL.inc}
{$I CFXMLNode.inc}

type
  PCFXMLParserRef = ^CFXMLParserRef;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLParserRef}
  {$ENDIF}
  CFXMLParserRef = ^__CFXMLParser;
  {$EXTERNALSYM CFXMLParserRef}
  __CFXMLParser = record
  end;
  {$EXTERNALSYM __CFXMLParser}

{ These are the various options you can configure the parser with.  These are
   chosen such that an option flag of 0 (kCFXMLParserNoOptions) leaves the XML
   as "intact" as possible (reports all structures; performs no replacements).
   Hence, to make the parser do the most work, returning only the pure element
   tree, set the option flag to kCFXMLParserAllOptions.

kCFXMLParserValidateDocument -
   validate the document against its grammar from the DTD, reporting any errors.
   Currently not supported.

kCFXMLParserSkipMetaData -
   silently skip over metadata constructs (the DTD and comments)

kCFXMLParserReplacePhysicalEntities -
   replace declared entities like &lt;.  Note that other than the 5 predefined
   entities (lt, gt, quot, amp, apos), these must be defined in the DTD.
   Currently not supported.

kCFXMLParserSkipWhitespace -
   skip over all whitespace that does not abut non-whitespace character data.
   In other words, given <foo>  <bar> blah </bar></foo>, the whitespace between
   foo's open tag and bar's open tag would be suppressed, but the whitespace
   around blah would be preserved.

kCFXMLParserAddImpliedAttributes -
   where the DTD specifies implied attribute-value pairs for a particular element,
   add those pairs to any occurances of the element in the element tree.
   Currently not supported.
 }

const
  kCFXMLParserValidateDocument        = 1 shl 0;
  {$EXTERNALSYM kCFXMLParserValidateDocument}
  kCFXMLParserSkipMetaData            = 1 shl 1;
  {$EXTERNALSYM kCFXMLParserSkipMetaData}
  kCFXMLParserReplacePhysicalEntities = 1 shl 2;
  {$EXTERNALSYM kCFXMLParserReplacePhysicalEntities}
  kCFXMLParserSkipWhitespace          = 1 shl 3;
  {$EXTERNALSYM kCFXMLParserSkipWhitespace}
  kCFXMLParserResolveExternalEntities = 1 shl 4;
  {$EXTERNALSYM kCFXMLParserResolveExternalEntities}
  kCFXMLParserAddImpliedAttributes    = 1 shl 5;
  {$EXTERNALSYM kCFXMLParserAddImpliedAttributes}
  kCFXMLParserAllOptions              = $00FFFFFF;
  {$EXTERNALSYM kCFXMLParserAllOptions}
  kCFXMLParserNoOptions               = 0;
  {$EXTERNALSYM kCFXMLParserNoOptions}
type
  CFXMLParserOptions = CFOptionFlags;
  {$EXTERNALSYM CFXMLParserOptions}

{ This list is expected to grow }
const
  kCFXMLStatusParseNotBegun                 = -2;
  {$EXTERNALSYM kCFXMLStatusParseNotBegun}
  kCFXMLStatusParseInProgress               = -1;
  {$EXTERNALSYM kCFXMLStatusParseInProgress}
  kCFXMLStatusParseSuccessful               = 0;
  {$EXTERNALSYM kCFXMLStatusParseSuccessful}
  kCFXMLErrorUnexpectedEOF                  = 1;
  {$EXTERNALSYM kCFXMLErrorUnexpectedEOF}
  kCFXMLErrorUnknownEncoding                = 2;
  {$EXTERNALSYM kCFXMLErrorUnknownEncoding}
  kCFXMLErrorEncodingConversionFailure      = 3;
  {$EXTERNALSYM kCFXMLErrorEncodingConversionFailure}
  kCFXMLErrorMalformedProcessingInstruction = 4;
  {$EXTERNALSYM kCFXMLErrorMalformedProcessingInstruction}
  kCFXMLErrorMalformedDTD                   = 5;
  {$EXTERNALSYM kCFXMLErrorMalformedDTD}
  kCFXMLErrorMalformedName                  = 6;
  {$EXTERNALSYM kCFXMLErrorMalformedName}
  kCFXMLErrorMalformedCDSect                = 7;
  {$EXTERNALSYM kCFXMLErrorMalformedCDSect}
  kCFXMLErrorMalformedCloseTag              = 8;
  {$EXTERNALSYM kCFXMLErrorMalformedCloseTag}
  kCFXMLErrorMalformedStartTag              = 9;
  {$EXTERNALSYM kCFXMLErrorMalformedStartTag}
  kCFXMLErrorMalformedDocument              = 10;
  {$EXTERNALSYM kCFXMLErrorMalformedDocument}
  kCFXMLErrorElementlessDocument            = 11;
  {$EXTERNALSYM kCFXMLErrorElementlessDocument}
  kCFXMLErrorMalformedComment               = 12;
  {$EXTERNALSYM kCFXMLErrorMalformedComment}
  kCFXMLErrorMalformedCharacterReference    = 13;
  {$EXTERNALSYM kCFXMLErrorMalformedCharacterReference}
  kCFXMLErrorMalformedParsedCharacterData   = 14;
  {$EXTERNALSYM kCFXMLErrorMalformedParsedCharacterData}
  kCFXMLErrorNoData                         = 15;
  {$EXTERNALSYM kCFXMLErrorNoData}
type
  CFXMLParserStatusCode = CFIndex;
  {$EXTERNALSYM CFXMLParserStatusCode}


{  These functions are called as a parse progresses.

createXMLStructure -
  called as new XML structures are encountered by the parser.  May return NULL to indicate
  that the given structure should be skipped; if NULL is returned for a given structure,
  only minimal parsing is done for that structure (enough to correctly determine its end,
  and to extract any data necessary for the remainder of the parse, such as Entity definitions).
  createXMLStructure (or indeed, any of the tree-creation callbacks) will not be called for any
  children of the skipped structure.  The only exception is that the top-most element will always
  be reported even if NULL was returned for the document as a whole.  NOTE: for performance reasons,
  the node passed to createXMLStructure cannot be safely retained by the client; the node as
  a whole must be copied (via CFXMLNodeCreateCopy), or its contents must be extracted and copied.

addChild -
  called as children are parsed and are ready to be added to the tree.  If createXMLStructure
  returns NULL for a given structure, that structure is omitted entirely, and addChild will
  NOT be called for either a NULL child or parent.

endXMLStructure -
  called once a structure (and all its children) are completely parsed.  As elements are encountered,
  createXMLStructure is called for them first, then addChild to add the new structure to its parent,
  then addChild (potentially several times) to add the new structure's children to it, then finally 
  endXMLStructure to show that the structure has been fully parsed.

createXMLStructure, addChild, and endXMLStructure are all REQUIRED TO BE NON-NULL.

resolveExternalEntity -
  called when external entities are referenced (NOT when they are simply defined).  If the function
  pointer is NULL, the parser uses its internal routines to try and resolve the entity.  If the
  function pointer is set, and the function returns NULL, a place holder for the external entity
  is inserted into the tree.  In this manner, the parser's client can prevent any external network 
  or file accesses.

handleError - called as errors/warnings are encountered in the data stream.  At some point, we will
  have an enum of the expected errors, some of which will be fatal, others of which will not.  If
  the function pointer is NULL, the parser will silently attempt to recover.  The
  handleError function may always return false to force the parser to stop; if handleError returns
  true, the parser will attempt to recover (fatal errors will still cause the parse to abort
  immediately).
 }

  CFXMLParserCreateXMLStructureCallBack = function(parser: CFXMLParserRef;
    nodeDesc: CFXMLNodeRef; info: Pointer): Pointer; cdecl;
  {$EXTERNALSYM CFXMLParserCreateXMLStructureCallBack}
  CFXMLParserAddChildCallBack = procedure(parser: CFXMLParserRef;
    parent: Pointer; child: Pointer; info: Pointer); cdecl;
  {$EXTERNALSYM CFXMLParserAddChildCallBack}
  CFXMLParserEndXMLStructureCallBack = procedure(parser: CFXMLParserRef;
    xmlType: Pointer; info: Pointer); cdecl;
  {$EXTERNALSYM CFXMLParserEndXMLStructureCallBack}
  CFXMLParserResolveExternalEntityCallBack = function(parser: CFXMLParserRef;
    extID: PCFXMLExternalID; info: Pointer): CFDataRef; cdecl;
  {$EXTERNALSYM CFXMLParserResolveExternalEntityCallBack}
  CFXMLParserHandleErrorCallBack = function(parser: CFXMLParserRef;
    error: CFXMLParserStatusCode; info: Pointer): Boolean; cdecl;
  {$EXTERNALSYM CFXMLParserHandleErrorCallBack}

  PCFXMLParserCallBacks = ^CFXMLParserCallBacks;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLParserCallBacks}
  {$ENDIF}
  CFXMLParserCallBacks = record
    version: CFIndex;
    createXMLStructure: CFXMLParserCreateXMLStructureCallBack;
    addChild: CFXMLParserAddChildCallBack;
    endXMLStructure: CFXMLParserEndXMLStructureCallBack;
    resolveExternalEntity: CFXMLParserResolveExternalEntityCallBack;
    handleError: CFXMLParserHandleErrorCallBack;
  end;
  {$EXTERNALSYM CFXMLParserCallBacks}

  CFXMLParserRetainCallBack = function(info: Pointer): Pointer; cdecl;
  {$EXTERNALSYM CFXMLParserRetainCallBack}
  CFXMLParserReleaseCallBack = procedure(info: Pointer); cdecl;
  {$EXTERNALSYM CFXMLParserReleaseCallBack}
  CFXMLParserCopyDescriptionCallBack = function(
    info: Pointer): CFStringRef; cdecl;
  {$EXTERNALSYM CFXMLParserCopyDescriptionCallBack}

  PCFXMLParserContext = ^CFXMLParserContext;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLParserContext}
  {$ENDIF}
  CFXMLParserContext = record
    version: CFIndex;
    info: Pointer;
    retain: CFXMLParserRetainCallBack;
    release: CFXMLParserReleaseCallBack;
    copyDescription: CFXMLParserCopyDescriptionCallBack;
  end;
  {$EXTERNALSYM CFXMLParserContext}

function CFXMLParserGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserGetTypeID';
{$EXTERNALSYM CFXMLParserGetTypeID}

{ Creates a parser which will parse the given data with the given options.  xmlData may not be NULL. 
   dataSource should be the URL from which the data came, and may be NULL; it is used to resolve any
   relative references found in xmlData. versionOfNodes determines which version CFXMLNodes are produced
   by the parser; see CFXMLNode.h for more details.  callBacks are the callbacks called by the parser as
   the parse progresses; callBacks, callBacks->createXMLStructure, callBacks->addChild, and
   callBacks->endXMLStructure must all be non-NULL.  context determines what if any info pointer is
   passed to the callbacks as the parse progresses; context may be NULL.  }
function CFXMLParserCreate(allocator: CFAllocatorRef; xmlData: CFDataRef;
  dataSource: CFURLRef; parseOptions: CFOptionFlags; versionOfNodes: CFIndex;
  callBacks: PCFXMLParserCallBacks;
  context: PCFXMLParserContext): CFXMLParserRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserCreate';
{$EXTERNALSYM CFXMLParserCreate}

{ Arguments as above, except that the data to be parsed is loaded directly 
   from dataSource.  dataSource may not be NULL.  }
function CFXMLParserCreateWithDataFromURL(allocator: CFAllocatorRef;
  dataSource: CFURLRef; parseOptions: CFOptionFlags; versionOfNodes: CFIndex;
  callBacks: PCFXMLParserCallBacks;
  context: PCFXMLParserContext): CFXMLParserRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserCreateWithDataFromURL';
{$EXTERNALSYM CFXMLParserCreateWithDataFromURL}

procedure CFXMLParserGetContext(parser: CFXMLParserRef;
  context: PCFXMLParserContext); cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserGetContext';
{$EXTERNALSYM CFXMLParserGetContext}

procedure CFXMLParserGetCallBacks(parser: CFXMLParserRef;
  callBacks: PCFXMLParserCallBacks); cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserGetCallBacks';
{$EXTERNALSYM CFXMLParserGetCallBacks}

function CFXMLParserGetSourceURL(parser: CFXMLParserRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserGetSourceURL';
{$EXTERNALSYM CFXMLParserGetSourceURL}

{ Returns the character index of the current parse location }
function CFXMLParserGetLocation(parser: CFXMLParserRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserGetLocation';
{$EXTERNALSYM CFXMLParserGetLocation}

{ Returns the line number of the current parse location }
function CFXMLParserGetLineNumber(parser: CFXMLParserRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserGetLineNumber';
{$EXTERNALSYM CFXMLParserGetLineNumber}

{ Returns the top-most object returned by the createXMLStructure callback }
procedure CFXMLParserGetDocument(parser: CFXMLParserRef); cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserGetDocument';
{$EXTERNALSYM CFXMLParserGetDocument}

{ Get the status code or a user-readable description of the last error that occurred in a parse.
   If no error has occurred, a null description string is returned.  See the enum above for
   possible status returns }
function CFXMLParserGetStatusCode(parser: CFXMLParserRef): CFXMLParserStatusCode; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserGetStatusCode';
{$EXTERNALSYM CFXMLParserGetStatusCode}

function CFXMLParserCopyErrorDescription(parser: CFXMLParserRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserCopyErrorDescription';
{$EXTERNALSYM CFXMLParserCopyErrorDescription}

{ Cause any in-progress parse to abort with the given error code and description.  errorCode
   must be positive, and errorDescription may not be NULL.  Cannot be called asynchronously
   (i.e. must be called from within a parser callback) }
procedure CFXMLParserAbort(parser: CFXMLParserRef;
  errorCode: CFXMLParserStatusCode; errorDescription: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserAbort';
{$EXTERNALSYM CFXMLParserAbort}

{ Starts a parse of the data the parser was created with; returns success or failure.
   Upon success, use CFXMLParserGetDocument() to get the product of the parse.  Upon
   failure, use CFXMLParserGetErrorCode() or CFXMLParserCopyErrorDescription() to get
   information about the error.  It is an error to call CFXMLParserParse() while a
   parse is already underway. }
function CFXMLParserParse(parser: CFXMLParserRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLParserParse';
{$EXTERNALSYM CFXMLParserParse}

{ These functions provide a higher-level interface.  The XML data is parsed to a
   special CFTree (an CFXMLTree) with known contexts and callbacks.  See CFXMLNode.h
   for full details on using an CFXMLTree and the CFXMLNodes contained therein.
 }
{ Parse to an CFXMLTreeRef.  parseOptions are as above. versionOfNodes determines
   what version CFXMLNodes are used to populate the tree.  }
function CFXMLTreeCreateFromData(allocator: CFAllocatorRef; xmlData: CFDataRef;
  dataSource: CFURLRef; parseOptions: CFOptionFlags;
  versionOfNodes: CFIndex): CFXMLTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLTreeCreateFromData';
{$EXTERNALSYM CFXMLTreeCreateFromData}

{ As above, with the additional by-reference pass of a CFDictionaryRef containing
   various error information (see below). The caller is responsible for releasing the
   returned dictionary. If the error dictionary is not desired, pass NULL. }
function CFXMLTreeCreateFromDataWithError(allocator: CFAllocatorRef;
  xmlData: CFDataRef; dataSource: CFURLRef; parseOptions: CFOptionFlags;
  versionOfNodes: CFIndex; errorDict: PCFDictionaryRef): CFXMLTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLTreeCreateFromDataWithError';
{$EXTERNALSYM CFXMLTreeCreateFromDataWithError}

{ Loads the data to be parsed directly from dataSource.  Arguments as above. }
function CFXMLTreeCreateWithDataFromURL(allocator: CFAllocatorRef;
  dataSource: CFURLRef; parseOptions: CFOptionFlags;
  versionOfNodes: CFIndex): CFXMLTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLTreeCreateWithDataFromURL';
{$EXTERNALSYM CFXMLTreeCreateWithDataFromURL}

{ Generate the XMLData (ready to be written to whatever permanent storage is to be
   used) from an CFXMLTree.  Will NOT regenerate entity references (except those
   required for syntactic correctness) if they were replaced at the parse time;
   clients that wish this should walk the tree and re-insert any entity references
   that should appear in the final output file. }
function CFXMLTreeCreateXMLData(allocator: CFAllocatorRef;
  xmlTree: CFXMLTreeRef): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLTreeCreateXMLData';
{$EXTERNALSYM CFXMLTreeCreateXMLData}

{ Escaping and unescaping XML entities in CFStrings. The standard XML entities
   are always replaced.  }
{ Creates a CFString by replacing entities that appear in the entities dictionary.
   Dictionary keys are the entities themselves, and the values should be CFStrings
   containing the expansion. Pass NULL for entitiesDictionary to indicate no entities
   other than the standard five. }
function CFXMLCreateStringByEscapingEntities(allocator: CFAllocatorRef; 
  &string: CFStringRef; entitiesDictionary: CFDictionaryRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLCreateStringByEscapingEntities';
{$EXTERNALSYM CFXMLCreateStringByEscapingEntities}

function CFXMLCreateStringByUnescapingEntities(allocator: CFAllocatorRef;
  &string: CFStringRef; entitiesDictionary: CFDictionaryRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLCreateStringByUnescapingEntities';
{$EXTERNALSYM CFXMLCreateStringByUnescapingEntities}

{ CFXMLTreeCreateFromDataWithError error dictionary key constants. }
function kCFXMLTreeErrorDescription: CFStringRef;
{$EXTERNALSYM kCFXMLTreeErrorDescription}
{ value is a CFString containing the readable error string. }

function kCFXMLTreeErrorLineNumber: CFStringRef;
{$EXTERNALSYM kCFXMLTreeErrorLineNumber}
{ value is a CFNumber containing the line on which the error appears. }

function kCFXMLTreeErrorLocation: CFStringRef;
{$EXTERNALSYM kCFXMLTreeErrorLocation}
{ value is a CFNumber containing the byte location at which the error occurred. }

function kCFXMLTreeErrorStatusCode: CFStringRef;
{$EXTERNALSYM kCFXMLTreeErrorStatusCode}
{ value is a CFNumber containing the error status code. }

{$ENDIF !__COREFOUNDATION_CFXMLPARSER__}

