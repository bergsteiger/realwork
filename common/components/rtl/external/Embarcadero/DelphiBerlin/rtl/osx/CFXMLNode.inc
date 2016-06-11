{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFXMLNode.h                            }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{  CFXMLParser (and thus CFXMLNode) will be officially deprecated in a future release of Mac OS X.
    Clients should be aware of the fact that CFXMLParser has some serious deficiencies in terms of both
    performance and standards compliance and should migrate their XML parsing to NSXMLParser, NSXMLDocument, or
    other XML parsing technologies that will suit their needs better than CFXMLParser.
 }

{$IFNDEF __COREFOUNDATION_CFXMLNODE__}

{$DEFINE __COREFOUNDATION_CFXMLNODE__}

{$I CFArray.inc}
{$I CFDictionary.inc}
{$I CFString.inc}
{$I CFTree.inc}
{$I CFURL.inc}

const
  kCFXMLNodeCurrentVersion = 1;
  {$EXTERNALSYM kCFXMLNodeCurrentVersion}

type
  PCFXMLNodeRef = ^CFXMLNodeRef;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLNodeRef}
  {$ENDIF}
  CFXMLNodeRef = ^__CFXMLNode;
  {$EXTERNALSYM CFXMLNodeRef}
  __CFXMLNode = record
  end;
  {$EXTERNALSYM __CFXMLNode}

  PCFXMLTreeRef = ^CFXMLTreeRef;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLTreeRef}
  {$ENDIF}
  CFXMLTreeRef = CFTreeRef;
  {$EXTERNALSYM CFXMLTreeRef}

{  An CFXMLNode describes an individual XML construct - like a tag, or a comment, or a string
    of character data.  Each CFXMLNode contains 3 main pieces of information - the node's type,
    the data string, and a pointer to an additional data structure.  The node's type ID is an enum
    value of type CFXMLNodeTypeID.  The data string is always a CFStringRef; the meaning of the
    string is dependent on the node's type ID. The format of the additional data is also dependent
    on the node's type; in general, there is a custom structure for each type that requires
    additional data.  See below for the mapping from type ID to meaning of the data string and
    structure of the additional data.  Note that these structures are versioned, and may change
    as the parser changes.  The current version can always be identified by kCFXMLNodeCurrentVersion;
    earlier versions can be identified and used by passing earlier values for the version number
    (although the older structures would have been removed from the header).

    An CFXMLTree is simply a CFTree whose context data is known to be an CFXMLNodeRef.  As
    such, an CFXMLTree can be used to represent an entire XML document; the CFTree
    provides the tree structure of the document, while the CFXMLNodes identify and describe
    the nodes of the tree.  An XML document can be parsed to a CFXMLTree, and a CFXMLTree
    can generate the data for the equivalent XML document - see CFXMLParser.h for more
    information on parsing XML.
    }

{ Type codes for the different possible XML nodes; this list may grow. }
const
  kCFXMLNodeTypeDocument                 = 1;
  {$EXTERNALSYM kCFXMLNodeTypeDocument}
  kCFXMLNodeTypeElement                  = 2;
  {$EXTERNALSYM kCFXMLNodeTypeElement}
  kCFXMLNodeTypeAttribute                = 3;
  {$EXTERNALSYM kCFXMLNodeTypeAttribute}
  kCFXMLNodeTypeProcessingInstruction    = 4;
  {$EXTERNALSYM kCFXMLNodeTypeProcessingInstruction}
  kCFXMLNodeTypeComment                  = 5;
  {$EXTERNALSYM kCFXMLNodeTypeComment}
  kCFXMLNodeTypeText                     = 6;
  {$EXTERNALSYM kCFXMLNodeTypeText}
  kCFXMLNodeTypeCDATASection             = 7;
  {$EXTERNALSYM kCFXMLNodeTypeCDATASection}
  kCFXMLNodeTypeDocumentFragment         = 8;
  {$EXTERNALSYM kCFXMLNodeTypeDocumentFragment}
  kCFXMLNodeTypeEntity                   = 9;
  {$EXTERNALSYM kCFXMLNodeTypeEntity}
  kCFXMLNodeTypeEntityReference          = 10;
  {$EXTERNALSYM kCFXMLNodeTypeEntityReference}
  kCFXMLNodeTypeDocumentType             = 11;
  {$EXTERNALSYM kCFXMLNodeTypeDocumentType}
  kCFXMLNodeTypeWhitespace               = 12;
  {$EXTERNALSYM kCFXMLNodeTypeWhitespace}
  kCFXMLNodeTypeNotation                 = 13;
  {$EXTERNALSYM kCFXMLNodeTypeNotation}
  kCFXMLNodeTypeElementTypeDeclaration   = 14;
  {$EXTERNALSYM kCFXMLNodeTypeElementTypeDeclaration}
  kCFXMLNodeTypeAttributeListDeclaration = 15;
  {$EXTERNALSYM kCFXMLNodeTypeAttributeListDeclaration}
type
  CFXMLNodeTypeCode = CFIndex;
  {$EXTERNALSYM CFXMLNodeTypeCode}

  PCFXMLElementInfo = ^CFXMLElementInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLElementInfo}
  {$ENDIF}
  CFXMLElementInfo = record
    attributes: CFDictionaryRef;
    attributeOrder: CFArrayRef;
    isEmpty: Boolean;
    _reserved: packed array[0..2] of Byte;
  end;
  {$EXTERNALSYM CFXMLElementInfo}

  PCFXMLProcessingInstructionInfo = ^CFXMLProcessingInstructionInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLProcessingInstructionInfo}
  {$ENDIF}
  CFXMLProcessingInstructionInfo = record
    dataString: CFStringRef;
  end;
  {$EXTERNALSYM CFXMLProcessingInstructionInfo}

  PCFXMLDocumentInfo = ^CFXMLDocumentInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLDocumentInfo}
  {$ENDIF}
  CFXMLDocumentInfo = record
    sourceURL: CFURLRef;
    encoding: CFStringEncoding;
  end;
  {$EXTERNALSYM CFXMLDocumentInfo}

  PCFXMLExternalID = ^CFXMLExternalID;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLExternalID}
  {$ENDIF}
  CFXMLExternalID = record
    systemID: CFURLRef;
    publicID: CFStringRef;
  end;
  {$EXTERNALSYM CFXMLExternalID}

  PCFXMLDocumentTypeInfo = ^CFXMLDocumentTypeInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLDocumentTypeInfo}
  {$ENDIF}
  CFXMLDocumentTypeInfo = record
    externalID: CFXMLExternalID;
  end;
  {$EXTERNALSYM CFXMLDocumentTypeInfo}

  PCFXMLNotationInfo = ^CFXMLNotationInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLNotationInfo}
  {$ENDIF}
  CFXMLNotationInfo = record
    externalID: CFXMLExternalID;
  end;
  {$EXTERNALSYM CFXMLNotationInfo}

  PCFXMLElementTypeDeclarationInfo = ^CFXMLElementTypeDeclarationInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLElementTypeDeclarationInfo}
  {$ENDIF}
  CFXMLElementTypeDeclarationInfo = record { This is expected to change in future versions }
    contentDescription: CFStringRef;
  end;
  {$EXTERNALSYM CFXMLElementTypeDeclarationInfo}

  PCFXMLAttributeDeclarationInfo = ^CFXMLAttributeDeclarationInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLAttributeDeclarationInfo}
  {$ENDIF}
  CFXMLAttributeDeclarationInfo = record { This is expected to change in future versions }
    attributeName: CFStringRef;
    typeString: CFStringRef;
    defaultString: CFStringRef;
  end;
  {$EXTERNALSYM CFXMLAttributeDeclarationInfo}

  PCFXMLAttributeListDeclarationInfo = ^CFXMLAttributeListDeclarationInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLAttributeListDeclarationInfo}
  {$ENDIF}
  CFXMLAttributeListDeclarationInfo = record
    numberOfAttributes: CFIndex;
    attributes: PCFXMLAttributeDeclarationInfo;
  end;
  {$EXTERNALSYM CFXMLAttributeListDeclarationInfo}

const
  kCFXMLEntityTypeParameter      = 0; { Implies parsed, internal }
  {$EXTERNALSYM kCFXMLEntityTypeParameter}
  kCFXMLEntityTypeParsedInternal = 1;
  {$EXTERNALSYM kCFXMLEntityTypeParsedInternal}
  kCFXMLEntityTypeParsedExternal = 2;
  {$EXTERNALSYM kCFXMLEntityTypeParsedExternal}
  kCFXMLEntityTypeUnparsed       = 3;
  {$EXTERNALSYM kCFXMLEntityTypeUnparsed}
  kCFXMLEntityTypeCharacter      = 4;
  {$EXTERNALSYM kCFXMLEntityTypeCharacter}
type
  CFXMLEntityTypeCode = CFIndex;
  {$EXTERNALSYM CFXMLEntityTypeCode}

  PCFXMLEntityInfo = ^CFXMLEntityInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLEntityInfo}
  {$ENDIF}
  CFXMLEntityInfo = record
    entityType: CFXMLEntityTypeCode;
    replacementText: CFStringRef;    { NULL if entityType is external or unparsed }
    entityID: CFXMLExternalID;         { entityID.systemID will be NULL if entityType is internal }
    notationName: CFStringRef;       { NULL if entityType is parsed }
  end;
  {$EXTERNALSYM CFXMLEntityInfo}

  PCFXMLEntityReferenceInfo = ^CFXMLEntityReferenceInfo;
  {$IFDEF IOS}
  {$EXTERNALSYM PCFXMLEntityReferenceInfo}
  {$ENDIF}
  CFXMLEntityReferenceInfo = record
    entityType: CFXMLEntityTypeCode;
  end;
  {$EXTERNALSYM CFXMLEntityReferenceInfo}

{ 
 dataTypeCode                       meaning of dataString                format of infoPtr
 ===========                        =====================                =================
 kCFXMLNodeTypeDocument             <currently unused>                   CFXMLDocumentInfo *
 kCFXMLNodeTypeElement              tag name                             CFXMLElementInfo *
 kCFXMLNodeTypeAttribute            <currently unused>                   <currently unused>
 kCFXMLNodeTypeProcessingInstruction   name of the target                   CFXMLProcessingInstructionInfo *
 kCFXMLNodeTypeComment              text of the comment                  NULL
 kCFXMLNodeTypeText                 the text's contents                  NULL
 kCFXMLNodeTypeCDATASection         text of the CDATA                    NULL
 kCFXMLNodeTypeDocumentFragment     <currently unused>                   <currently unused>
 kCFXMLNodeTypeEntity               name of the entity                   CFXMLEntityInfo *
 kCFXMLNodeTypeEntityReference      name of the referenced entity        CFXMLEntityReferenceInfo *
 kCFXMLNodeTypeDocumentType         name given as top-level element      CFXMLDocumentTypeInfo *
 kCFXMLNodeTypeWhitespace           text of the whitespace               NULL
 kCFXMLNodeTypeNotation             notation name                        CFXMLNotationInfo *
 kCFXMLNodeTypeElementTypeDeclaration     tag name                       CFXMLElementTypeDeclarationInfo *
 kCFXMLNodeTypeAttributeListDeclaration   tag name                       CFXMLAttributeListDeclarationInfo *
 }

function CFXMLNodeGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLNodeGetTypeID';
{$EXTERNALSYM CFXMLNodeGetTypeID}

{ Creates a new node based on xmlType, dataString, and additionalInfoPtr.  version (together with xmlType) determines the expected structure of additionalInfoPtr }
function CFXMLNodeCreate(alloc: CFAllocatorRef; xmlType: CFXMLNodeTypeCode;
  dataString: CFStringRef; additionalInfoPtr: Pointer;
  version: CFIndex): CFXMLNodeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLNodeCreate';
{$EXTERNALSYM CFXMLNodeCreate}

{ Creates a copy of origNode (which may not be NULL). }
function CFXMLNodeCreateCopy(alloc: CFAllocatorRef;
  origNode: CFXMLNodeRef): CFXMLNodeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLNodeCreateCopy';
{$EXTERNALSYM CFXMLNodeCreateCopy}

function CFXMLNodeGetTypeCode(node: CFXMLNodeRef): CFXMLNodeTypeCode; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLNodeGetTypeCode';
{$EXTERNALSYM CFXMLNodeGetTypeCode}

function CFXMLNodeGetString(node: CFXMLNodeRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLNodeGetString';
{$EXTERNALSYM CFXMLNodeGetString}

function CFXMLNodeGetInfoPtr(node: CFXMLNodeRef): Pointer; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLNodeGetInfoPtr';
{$EXTERNALSYM CFXMLNodeGetInfoPtr}

function CFXMLNodeGetVersion(node: CFXMLNodeRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLNodeGetVersion';
{$EXTERNALSYM CFXMLNodeGetVersion}

{ CFXMLTreeRef }

{ Creates a childless, parentless tree from node }
function CFXMLTreeCreateWithNode(allocator: CFAllocatorRef;
  node: CFXMLNodeRef): CFXMLTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLTreeCreateWithNode';
{$EXTERNALSYM CFXMLTreeCreateWithNode}

{ Extracts and returns the node stored in xmlTree }
function CFXMLTreeGetNode(xmlTree: CFXMLTreeRef): CFXMLNodeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFXMLTreeGetNode';
{$EXTERNALSYM CFXMLTreeGetNode}


{$ENDIF !__COREFOUNDATION_CFXMLNODE__}


