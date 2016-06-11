{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{     File: msxml.h                                     }
{     Copyright (c) Microsoft Corporation, 1997-1998    }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


{*******************************************************}
{       Win32 API Interface Unit                        }
{*******************************************************}

unit Winapi.MSXMLIntf;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// This unit includes all interfaces originally declared in msxml.pas
// ************************************************************************ //

// $Rev: 17244 $
// File generated on 5/21/2009 8:41:50 PM from Type Library described below.


{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
{$MINENUMSIZE 4}
interface

uses Winapi.Windows, Winapi.ActiveX;
{$HPPEMIT '#include <msxml.h>'}
{$HPPEMIT '#include <MsXml2.h>'}

// *********************************************************************//
// Declaration of structures, unions and aliases moved here from msxml.pas
// *********************************************************************//
type
  PWord1 = ^Word; {*}
  {$EXTERNALSYM PWord1}
  tagDOMNodeType = TOleEnum;
  {$EXTERNALSYM tagDOMNodeType}
  DOMNodeType = tagDOMNodeType;
  {$EXTERNALSYM DOMNodeType}
  _SOMITEMTYPE = TOleEnum;
  {$EXTERNALSYM _SOMITEMTYPE}
  SOMITEMTYPE = _SOMITEMTYPE;
  {$EXTERNALSYM SOMITEMTYPE}
  _SCHEMADERIVATIONMETHOD = TOleEnum;
  {$EXTERNALSYM _SCHEMADERIVATIONMETHOD}
  SCHEMADERIVATIONMETHOD = _SCHEMADERIVATIONMETHOD;
  {$EXTERNALSYM SCHEMADERIVATIONMETHOD}
  _SCHEMATYPEVARIETY = TOleEnum;
  {$EXTERNALSYM _SCHEMATYPEVARIETY}
  SCHEMATYPEVARIETY = _SCHEMATYPEVARIETY;
  {$EXTERNALSYM SCHEMATYPEVARIETY}
  _SCHEMAWHITESPACE = TOleEnum;
  {$EXTERNALSYM _SCHEMAWHITESPACE}
  SCHEMAWHITESPACE = _SCHEMAWHITESPACE;
  {$EXTERNALSYM SCHEMAWHITESPACE}
  _SCHEMACONTENTTYPE = TOleEnum;
  {$EXTERNALSYM _SCHEMACONTENTTYPE}
  SCHEMACONTENTTYPE = _SCHEMACONTENTTYPE;
  {$EXTERNALSYM SCHEMACONTENTTYPE}
  _SCHEMAPROCESSCONTENTS = TOleEnum;
  {$EXTERNALSYM _SCHEMAPROCESSCONTENTS}
  SCHEMAPROCESSCONTENTS = _SCHEMAPROCESSCONTENTS;
  {$EXTERNALSYM SCHEMAPROCESSCONTENTS}
  _SCHEMAUSE = TOleEnum;
  {$EXTERNALSYM _SCHEMAUSE}
  SCHEMAUSE = _SCHEMAUSE;
  {$EXTERNALSYM SCHEMAUSE}
  _SERVERXMLHTTP_OPTION = TOleEnum;
  {$EXTERNALSYM _SERVERXMLHTTP_OPTION}
  SERVERXMLHTTP_OPTION = _SERVERXMLHTTP_OPTION;
  {$EXTERNALSYM SERVERXMLHTTP_OPTION}
  _SXH_PROXY_SETTING = TOleEnum;
  {$EXTERNALSYM _SXH_PROXY_SETTING}
  SXH_PROXY_SETTING = _SXH_PROXY_SETTING;
  {$EXTERNALSYM SXH_PROXY_SETTING}

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IXMLDOMImplementation = interface;
  {$EXTERNALSYM IXMLDOMImplementation}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMImplementation);' *)
  IXMLDOMImplementationDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMImplementationDisp}
  IXMLDOMNode = interface;
  {$EXTERNALSYM IXMLDOMNode}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMNode);' *)
  IXMLDOMNodeDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMNodeDisp}
  IXMLDOMNodeList = interface;
  {$EXTERNALSYM IXMLDOMNodeList}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMNodeList);' *)
  IXMLDOMNodeListDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMNodeListDisp}
  IXMLDOMNamedNodeMap = interface;
  {$EXTERNALSYM IXMLDOMNamedNodeMap}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMNamedNodeMap);' *)
  IXMLDOMNamedNodeMapDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMNamedNodeMapDisp}
  IXMLDOMDocument = interface;
  {$EXTERNALSYM IXMLDOMDocument}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMDocument);' *)
  IXMLDOMDocumentDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMDocumentDisp}
  IXMLDOMDocumentType = interface;
  {$EXTERNALSYM IXMLDOMDocumentType}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMDocumentType);' *)
  IXMLDOMDocumentTypeDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMDocumentTypeDisp}
  IXMLDOMElement = interface;
  {$EXTERNALSYM IXMLDOMElement}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMElement);' *)
  IXMLDOMElementDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMElementDisp}
  IXMLDOMAttribute = interface;
  {$EXTERNALSYM IXMLDOMAttribute}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMAttribute);' *)
  IXMLDOMAttributeDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMAttributeDisp}
  IXMLDOMDocumentFragment = interface;
  {$EXTERNALSYM IXMLDOMDocumentFragment}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMDocumentFragment);' *)
  IXMLDOMDocumentFragmentDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMDocumentFragmentDisp}
  IXMLDOMCharacterData = interface;
  {$EXTERNALSYM IXMLDOMCharacterData}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMCharacterData);' *)
  IXMLDOMCharacterDataDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMCharacterDataDisp}
  IXMLDOMText = interface;
  {$EXTERNALSYM IXMLDOMText}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMText);' *)
  IXMLDOMTextDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMTextDisp}
  IXMLDOMComment = interface;
  {$EXTERNALSYM IXMLDOMComment}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMComment);' *)
  IXMLDOMCommentDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMCommentDisp}
  IXMLDOMCDATASection = interface;
  {$EXTERNALSYM IXMLDOMCDATASection}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMCDATASection);' *)
  IXMLDOMCDATASectionDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMCDATASectionDisp}
  IXMLDOMProcessingInstruction = interface;
  {$EXTERNALSYM IXMLDOMProcessingInstruction}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMProcessingInstruction);' *)
  IXMLDOMProcessingInstructionDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMProcessingInstructionDisp}
  IXMLDOMEntityReference = interface;
  {$EXTERNALSYM IXMLDOMEntityReference}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMEntityReference);' *)
  IXMLDOMEntityReferenceDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMEntityReferenceDisp}
  IXMLDOMParseError = interface;
  {$EXTERNALSYM IXMLDOMParseError}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMParseError);' *)
  IXMLDOMParseErrorDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMParseErrorDisp}
  IXMLDOMDocument2 = interface;
  {$EXTERNALSYM IXMLDOMDocument2}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMDocument2);' *)
  IXMLDOMDocument2Disp = dispinterface;
  {$EXTERNALSYM IXMLDOMDocument2Disp}
  IXMLDOMSchemaCollection = interface;
  {$EXTERNALSYM IXMLDOMSchemaCollection}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMSchemaCollection);' *)
  IXMLDOMSchemaCollectionDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMSchemaCollectionDisp}
  IXMLDOMDocument3 = interface;
  {$EXTERNALSYM IXMLDOMDocument3}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMDocument3);' *)
  IXMLDOMDocument3Disp = dispinterface;
  {$EXTERNALSYM IXMLDOMDocument3Disp}
  IXMLDOMNotation = interface;
  {$EXTERNALSYM IXMLDOMNotation}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMNotation);' *)
  IXMLDOMNotationDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMNotationDisp}
  IXMLDOMEntity = interface;
  {$EXTERNALSYM IXMLDOMEntity}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMEntity);' *)
  IXMLDOMEntityDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMEntityDisp}
  IXMLDOMParseError2 = interface;
  {$EXTERNALSYM IXMLDOMParseError2}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMParseError2);' *)
  IXMLDOMParseError2Disp = dispinterface;
  {$EXTERNALSYM IXMLDOMParseError2Disp}
  IXMLDOMParseErrorCollection = interface;
  {$EXTERNALSYM IXMLDOMParseErrorCollection}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMParseErrorCollection);' *)
  IXMLDOMParseErrorCollectionDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMParseErrorCollectionDisp}
  IXTLRuntime = interface;
  {$EXTERNALSYM IXTLRuntime}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXTLRuntime);' *)
  IXTLRuntimeDisp = dispinterface;
  {$EXTERNALSYM IXTLRuntimeDisp}
  IXSLTemplate = interface;
  {$EXTERNALSYM IXSLTemplate}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXSLTemplate);' *)
  IXSLTemplateDisp = dispinterface;
  {$EXTERNALSYM IXSLTemplateDisp}
  IXSLProcessor = interface;
  {$EXTERNALSYM IXSLProcessor}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXSLProcessor);' *)
  IXSLProcessorDisp = dispinterface;
  {$EXTERNALSYM IXSLProcessorDisp}
  ISAXXMLReader = interface;
  {$EXTERNALSYM ISAXXMLReader}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISAXXMLReader);' *)
  ISAXEntityResolver = interface;
  {$EXTERNALSYM ISAXEntityResolver}
  ISAXContentHandler = interface;
  {$EXTERNALSYM ISAXContentHandler}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISAXContentHandler);' *)
  ISAXLocator = interface;
  {$EXTERNALSYM ISAXLocator}
  ISAXAttributes = interface;
  {$EXTERNALSYM ISAXAttributes}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISAXAttributes);' *)
  ISAXDTDHandler = interface;
  {$EXTERNALSYM ISAXDTDHandler}
  ISAXErrorHandler = interface;
  {$EXTERNALSYM ISAXErrorHandler}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISAXErrorHandler);' *)
  ISAXXMLFilter = interface;
  {$EXTERNALSYM ISAXXMLFilter}
  ISAXLexicalHandler = interface;
  {$EXTERNALSYM ISAXLexicalHandler}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISAXLexicalHandler);' *)
  ISAXDeclHandler = interface;
  {$EXTERNALSYM ISAXDeclHandler}
  IVBSAXXMLReader = interface;
  {$EXTERNALSYM IVBSAXXMLReader}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXXMLReader);' *)
  IVBSAXXMLReaderDisp = dispinterface;
  {$EXTERNALSYM IVBSAXXMLReaderDisp}
  IVBSAXEntityResolver = interface;
  {$EXTERNALSYM IVBSAXEntityResolver}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXEntityResolver);' *)
  IVBSAXEntityResolverDisp = dispinterface;
  {$EXTERNALSYM IVBSAXEntityResolverDisp}
  IVBSAXContentHandler = interface;
  {$EXTERNALSYM IVBSAXContentHandler}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXContentHandler);' *)
  IVBSAXContentHandlerDisp = dispinterface;
  {$EXTERNALSYM IVBSAXContentHandlerDisp}
  IVBSAXLocator = interface;
  {$EXTERNALSYM IVBSAXLocator}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXLocator);' *)
  IVBSAXLocatorDisp = dispinterface;
  {$EXTERNALSYM IVBSAXLocatorDisp}
  IVBSAXAttributes = interface;
  {$EXTERNALSYM IVBSAXAttributes}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXAttributes);' *)
  IVBSAXAttributesDisp = dispinterface;
  {$EXTERNALSYM IVBSAXAttributesDisp}
  IVBSAXDTDHandler = interface;
  {$EXTERNALSYM IVBSAXDTDHandler}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXDTDHandler);' *)
  IVBSAXDTDHandlerDisp = dispinterface;
  {$EXTERNALSYM IVBSAXDTDHandlerDisp}
  IVBSAXErrorHandler = interface;
  {$EXTERNALSYM IVBSAXErrorHandler}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXErrorHandler);' *)
  IVBSAXErrorHandlerDisp = dispinterface;
  {$EXTERNALSYM IVBSAXErrorHandlerDisp}
  IVBSAXXMLFilter = interface;
  {$EXTERNALSYM IVBSAXXMLFilter}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXXMLFilter);' *)
  IVBSAXXMLFilterDisp = dispinterface;
  {$EXTERNALSYM IVBSAXXMLFilterDisp}
  IVBSAXLexicalHandler = interface;
  {$EXTERNALSYM IVBSAXLexicalHandler}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXLexicalHandler);' *)
  IVBSAXLexicalHandlerDisp = dispinterface;
  {$EXTERNALSYM IVBSAXLexicalHandlerDisp}
  IVBSAXDeclHandler = interface;
  {$EXTERNALSYM IVBSAXDeclHandler}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBSAXDeclHandler);' *)
  IVBSAXDeclHandlerDisp = dispinterface;
  {$EXTERNALSYM IVBSAXDeclHandlerDisp}
  IMXWriter = interface;
  {$EXTERNALSYM IMXWriter}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMXWriter);' *)
  IMXWriterDisp = dispinterface;
  {$EXTERNALSYM IMXWriterDisp}
  IMXAttributes = interface;
  {$EXTERNALSYM IMXAttributes}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMXAttributes);' *)
  IMXAttributesDisp = dispinterface;
  {$EXTERNALSYM IMXAttributesDisp}
  IMXReaderControl = interface;
  {$EXTERNALSYM IMXReaderControl}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMXReaderControl);' *)
  IMXReaderControlDisp = dispinterface;
  {$EXTERNALSYM IMXReaderControlDisp}
  IMXSchemaDeclHandler = interface;
  {$EXTERNALSYM IMXSchemaDeclHandler}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMXSchemaDeclHandler);' *)
  IMXSchemaDeclHandlerDisp = dispinterface;
  {$EXTERNALSYM IMXSchemaDeclHandlerDisp}
  ISchemaItem = interface;
  {$EXTERNALSYM ISchemaItem}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaItem);' *)
  ISchemaItemDisp = dispinterface;
  {$EXTERNALSYM ISchemaItemDisp}
  ISchemaParticle = interface;
  {$EXTERNALSYM ISchemaParticle}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaParticle);' *)
  ISchemaParticleDisp = dispinterface;
  {$EXTERNALSYM ISchemaParticleDisp}
  ISchemaElement = interface;
  {$EXTERNALSYM ISchemaElement}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaElement);' *)
  ISchemaElementDisp = dispinterface;
  {$EXTERNALSYM ISchemaElementDisp}
  ISchema = interface;
  {$EXTERNALSYM ISchema}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchema);' *)
  ISchemaDisp = dispinterface;
  {$EXTERNALSYM ISchemaDisp}
  ISchemaItemCollection = interface;
  {$EXTERNALSYM ISchemaItemCollection}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaItemCollection);' *)
  ISchemaItemCollectionDisp = dispinterface;
  {$EXTERNALSYM ISchemaItemCollectionDisp}
  ISchemaStringCollection = interface;
  {$EXTERNALSYM ISchemaStringCollection}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaStringCollection);' *)
  ISchemaStringCollectionDisp = dispinterface;
  {$EXTERNALSYM ISchemaStringCollectionDisp}
  ISchemaType = interface;
  {$EXTERNALSYM ISchemaType}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaType);' *)
  ISchemaTypeDisp = dispinterface;
  {$EXTERNALSYM ISchemaTypeDisp}
  ISchemaComplexType = interface;
  {$EXTERNALSYM ISchemaComplexType}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaComplexType);' *)
  ISchemaComplexTypeDisp = dispinterface;
  {$EXTERNALSYM ISchemaComplexTypeDisp}
  ISchemaAny = interface;
  {$EXTERNALSYM ISchemaAny}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaAny);' *)
  ISchemaAnyDisp = dispinterface;
  {$EXTERNALSYM ISchemaAnyDisp}
  ISchemaModelGroup = interface;
  {$EXTERNALSYM ISchemaModelGroup}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaModelGroup);' *)
  ISchemaModelGroupDisp = dispinterface;
  {$EXTERNALSYM ISchemaModelGroupDisp}
  IMXXMLFilter = interface;
  {$EXTERNALSYM IMXXMLFilter}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMXXMLFilter);' *)
  IMXXMLFilterDisp = dispinterface;
  {$EXTERNALSYM IMXXMLFilterDisp}
  IXMLDOMSchemaCollection2 = interface;
  {$EXTERNALSYM IXMLDOMSchemaCollection2}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMSchemaCollection2);' *)
  IXMLDOMSchemaCollection2Disp = dispinterface;
  {$EXTERNALSYM IXMLDOMSchemaCollection2Disp}
  ISchemaAttribute = interface;
  {$EXTERNALSYM ISchemaAttribute}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaAttribute);' *)
  ISchemaAttributeDisp = dispinterface;
  {$EXTERNALSYM ISchemaAttributeDisp}
  ISchemaAttributeGroup = interface;
  {$EXTERNALSYM ISchemaAttributeGroup}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaAttributeGroup);' *)
  ISchemaAttributeGroupDisp = dispinterface;
  {$EXTERNALSYM ISchemaAttributeGroupDisp}
  ISchemaIdentityConstraint = interface;
  {$EXTERNALSYM ISchemaIdentityConstraint}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaIdentityConstraint);' *)
  ISchemaIdentityConstraintDisp = dispinterface;
  {$EXTERNALSYM ISchemaIdentityConstraintDisp}
  ISchemaNotation = interface;
  {$EXTERNALSYM ISchemaNotation}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaNotation);' *)
  ISchemaNotationDisp = dispinterface;
  {$EXTERNALSYM ISchemaNotationDisp}
  IXMLDOMSelection = interface;
  {$EXTERNALSYM IXMLDOMSelection}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLDOMSelection);' *)
  IXMLDOMSelectionDisp = dispinterface;
  {$EXTERNALSYM IXMLDOMSelectionDisp}
  XMLDOMDocumentEvents = dispinterface;
  {$EXTERNALSYM XMLDOMDocumentEvents}
  IDSOControl = interface;
  {$EXTERNALSYM IDSOControl}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDSOControl);' *)
  IDSOControlDisp = dispinterface;
  {$EXTERNALSYM IDSOControlDisp}
  IXMLHTTPRequest = interface;
  {$EXTERNALSYM IXMLHTTPRequest}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IXMLHTTPRequest);' *)
  IXMLHTTPRequestDisp = dispinterface;
  {$EXTERNALSYM IXMLHTTPRequestDisp}
  IServerXMLHTTPRequest = interface;
  {$EXTERNALSYM IServerXMLHTTPRequest}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IServerXMLHTTPRequest);' *)
  IServerXMLHTTPRequestDisp = dispinterface;
  {$EXTERNALSYM IServerXMLHTTPRequestDisp}
  IServerXMLHTTPRequest2 = interface;
  {$EXTERNALSYM IServerXMLHTTPRequest2}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IServerXMLHTTPRequest2);' *)
  IServerXMLHTTPRequest2Disp = dispinterface;
  {$EXTERNALSYM IServerXMLHTTPRequest2Disp}
  IMXNamespacePrefixes = interface;
  {$EXTERNALSYM IMXNamespacePrefixes}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMXNamespacePrefixes);' *)
  IMXNamespacePrefixesDisp = dispinterface;
  {$EXTERNALSYM IMXNamespacePrefixesDisp}
  IVBMXNamespaceManager = interface;
  {$EXTERNALSYM IVBMXNamespaceManager}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVBMXNamespaceManager);' *)
  IVBMXNamespaceManagerDisp = dispinterface;
  {$EXTERNALSYM IVBMXNamespaceManagerDisp}
  IMXNamespaceManager = interface;
  {$EXTERNALSYM IMXNamespaceManager}
  (*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMXNamespaceManager);' *)

// *********************************************************************//
// Interface: IXMLDOMImplementation
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8F-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMImplementation = interface(IDispatch)
    ['{2933BF8F-7B36-11D2-B20E-00C04F983E60}']
    function hasFeature(const feature: WideString; const version: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMImplementationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8F-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMImplementationDisp = dispinterface
    ['{2933BF8F-7B36-11D2-B20E-00C04F983E60}']
    function hasFeature(const feature: WideString; const version: WideString): WordBool; dispid 145;
  end;

// *********************************************************************//
// Interface: IXMLDOMNode
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF80-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMNode = interface(IDispatch)
    ['{2933BF80-7B36-11D2-B20E-00C04F983E60}']
    function Get_nodeName: WideString; safecall;
    function Get_nodeValue: OleVariant; safecall;
    procedure Set_nodeValue(value: OleVariant); safecall;
    function Get_nodeType: DOMNodeType; safecall;
    function Get_parentNode: IXMLDOMNode; safecall;
    function Get_childNodes: IXMLDOMNodeList; safecall;
    function Get_firstChild: IXMLDOMNode; safecall;
    function Get_lastChild: IXMLDOMNode; safecall;
    function Get_previousSibling: IXMLDOMNode; safecall;
    function Get_nextSibling: IXMLDOMNode; safecall;
    function Get_attributes: IXMLDOMNamedNodeMap; safecall;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; safecall;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; safecall;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; safecall;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; safecall;
    function hasChildNodes: WordBool; safecall;
    function Get_ownerDocument: IXMLDOMDocument; safecall;
    function cloneNode(deep: WordBool): IXMLDOMNode; safecall;
    function Get_nodeTypeString: WideString; safecall;
    function Get_text: WideString; safecall;
    procedure Set_text(const text: WideString); safecall;
    function Get_specified: WordBool; safecall;
    function Get_definition: IXMLDOMNode; safecall;
    function Get_nodeTypedValue: OleVariant; safecall;
    procedure Set_nodeTypedValue(typedValue: OleVariant); safecall;
    function Get_dataType: OleVariant; safecall;
    procedure Set_dataType(const dataTypeName: WideString); safecall;
    function Get_xml: WideString; safecall;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; safecall;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; safecall;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; safecall;
    function Get_parsed: WordBool; safecall;
    function Get_namespaceURI: WideString; safecall;
    function Get_prefix: WideString; safecall;
    function Get_baseName: WideString; safecall;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); safecall;
    property nodeName: WideString read Get_nodeName;
    property nodeValue: OleVariant read Get_nodeValue write Set_nodeValue;
    property nodeType: DOMNodeType read Get_nodeType;
    property parentNode: IXMLDOMNode read Get_parentNode;
    property childNodes: IXMLDOMNodeList read Get_childNodes;
    property firstChild: IXMLDOMNode read Get_firstChild;
    property lastChild: IXMLDOMNode read Get_lastChild;
    property previousSibling: IXMLDOMNode read Get_previousSibling;
    property nextSibling: IXMLDOMNode read Get_nextSibling;
    property attributes: IXMLDOMNamedNodeMap read Get_attributes;
    property ownerDocument: IXMLDOMDocument read Get_ownerDocument;
    property nodeTypeString: WideString read Get_nodeTypeString;
    property text: WideString read Get_text write Set_text;
    property specified: WordBool read Get_specified;
    property definition: IXMLDOMNode read Get_definition;
    property nodeTypedValue: OleVariant read Get_nodeTypedValue write Set_nodeTypedValue;
    property xml: WideString read Get_xml;
    property parsed: WordBool read Get_parsed;
    property namespaceURI: WideString read Get_namespaceURI;
    property prefix: WideString read Get_prefix;
    property baseName: WideString read Get_baseName;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMNodeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF80-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMNodeDisp = dispinterface
    ['{2933BF80-7B36-11D2-B20E-00C04F983E60}']
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMNodeList
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF82-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMNodeList = interface(IDispatch)
    ['{2933BF82-7B36-11D2-B20E-00C04F983E60}']
    function Get_item(index: Integer): IXMLDOMNode; safecall;
    function Get_length: Integer; safecall;
    function nextNode: IXMLDOMNode; safecall;
    procedure reset; safecall;
    function Get__newEnum: IUnknown; safecall;
    property item[index: Integer]: IXMLDOMNode read Get_item; default;
    property length: Integer read Get_length;
    property _newEnum: IUnknown read Get__newEnum;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMNodeListDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF82-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMNodeListDisp = dispinterface
    ['{2933BF82-7B36-11D2-B20E-00C04F983E60}']
    property item[index: Integer]: IXMLDOMNode readonly dispid 0; default;
    property length: Integer readonly dispid 74;
    function nextNode: IXMLDOMNode; dispid 76;
    procedure reset; dispid 77;
    property _newEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: IXMLDOMNamedNodeMap
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF83-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMNamedNodeMap = interface(IDispatch)
    ['{2933BF83-7B36-11D2-B20E-00C04F983E60}']
    function getNamedItem(const name: WideString): IXMLDOMNode; safecall;
    function setNamedItem(const newItem: IXMLDOMNode): IXMLDOMNode; safecall;
    function removeNamedItem(const name: WideString): IXMLDOMNode; safecall;
    function Get_item(index: Integer): IXMLDOMNode; safecall;
    function Get_length: Integer; safecall;
    function getQualifiedItem(const baseName: WideString; const namespaceURI: WideString): IXMLDOMNode; safecall;
    function removeQualifiedItem(const baseName: WideString; const namespaceURI: WideString): IXMLDOMNode; safecall;
    function nextNode: IXMLDOMNode; safecall;
    procedure reset; safecall;
    function Get__newEnum: IUnknown; safecall;
    property item[index: Integer]: IXMLDOMNode read Get_item; default;
    property length: Integer read Get_length;
    property _newEnum: IUnknown read Get__newEnum;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMNamedNodeMapDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF83-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMNamedNodeMapDisp = dispinterface
    ['{2933BF83-7B36-11D2-B20E-00C04F983E60}']
    function getNamedItem(const name: WideString): IXMLDOMNode; dispid 83;
    function setNamedItem(const newItem: IXMLDOMNode): IXMLDOMNode; dispid 84;
    function removeNamedItem(const name: WideString): IXMLDOMNode; dispid 85;
    property item[index: Integer]: IXMLDOMNode readonly dispid 0; default;
    property length: Integer readonly dispid 74;
    function getQualifiedItem(const baseName: WideString; const namespaceURI: WideString): IXMLDOMNode; dispid 87;
    function removeQualifiedItem(const baseName: WideString; const namespaceURI: WideString): IXMLDOMNode; dispid 88;
    function nextNode: IXMLDOMNode; dispid 89;
    procedure reset; dispid 90;
    property _newEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: IXMLDOMDocument
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF81-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMDocument = interface(IXMLDOMNode)
    ['{2933BF81-7B36-11D2-B20E-00C04F983E60}']
    function Get_doctype: IXMLDOMDocumentType; safecall;
    function Get_implementation_: IXMLDOMImplementation; safecall;
    function Get_documentElement: IXMLDOMElement; safecall;
    procedure _Set_documentElement(const DOMElement: IXMLDOMElement); safecall;
    function createElement(const tagName: WideString): IXMLDOMElement; safecall;
    function createDocumentFragment: IXMLDOMDocumentFragment; safecall;
    function createTextNode(const data: WideString): IXMLDOMText; safecall;
    function createComment(const data: WideString): IXMLDOMComment; safecall;
    function createCDATASection(const data: WideString): IXMLDOMCDATASection; safecall;
    function createProcessingInstruction(const target: WideString; const data: WideString): IXMLDOMProcessingInstruction; safecall;
    function createAttribute(const name: WideString): IXMLDOMAttribute; safecall;
    function createEntityReference(const name: WideString): IXMLDOMEntityReference; safecall;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; safecall;
    function createNode(type_: OleVariant; const name: WideString; const namespaceURI: WideString): IXMLDOMNode; safecall;
    function nodeFromID(const idString: WideString): IXMLDOMNode; safecall;
    function load(xmlSource: OleVariant): WordBool; safecall;
    function Get_readyState: Integer; safecall;
    function Get_parseError: IXMLDOMParseError; safecall;
    function Get_url: WideString; safecall;
    function Get_async: WordBool; safecall;
    procedure Set_async(isAsync: WordBool); safecall;
    procedure abort; safecall;
    function loadXML(const bstrXML: WideString): WordBool; safecall;
    procedure save(destination: OleVariant); safecall;
    function Get_validateOnParse: WordBool; safecall;
    procedure Set_validateOnParse(isValidating: WordBool); safecall;
    function Get_resolveExternals: WordBool; safecall;
    procedure Set_resolveExternals(isResolving: WordBool); safecall;
    function Get_preserveWhiteSpace: WordBool; safecall;
    procedure Set_preserveWhiteSpace(isPreserving: WordBool); safecall;
    procedure Set_onreadystatechange(Param1: OleVariant); safecall;
    procedure Set_ondataavailable(Param1: OleVariant); safecall;
    procedure Set_ontransformnode(Param1: OleVariant); safecall;
    property doctype: IXMLDOMDocumentType read Get_doctype;
    property implementation_: IXMLDOMImplementation read Get_implementation_;
    property documentElement: IXMLDOMElement read Get_documentElement write _Set_documentElement;
    property readyState: Integer read Get_readyState;
    property parseError: IXMLDOMParseError read Get_parseError;
    property url: WideString read Get_url;
    property async: WordBool read Get_async write Set_async;
    property validateOnParse: WordBool read Get_validateOnParse write Set_validateOnParse;
    property resolveExternals: WordBool read Get_resolveExternals write Set_resolveExternals;
    property preserveWhiteSpace: WordBool read Get_preserveWhiteSpace write Set_preserveWhiteSpace;
    property onreadystatechange: OleVariant write Set_onreadystatechange;
    property ondataavailable: OleVariant write Set_ondataavailable;
    property ontransformnode: OleVariant write Set_ontransformnode;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMDocumentDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF81-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMDocumentDisp = dispinterface
    ['{2933BF81-7B36-11D2-B20E-00C04F983E60}']
    property doctype: IXMLDOMDocumentType readonly dispid 38;
    property implementation_: IXMLDOMImplementation readonly dispid 39;
    property documentElement: IXMLDOMElement dispid 40;
    function createElement(const tagName: WideString): IXMLDOMElement; dispid 41;
    function createDocumentFragment: IXMLDOMDocumentFragment; dispid 42;
    function createTextNode(const data: WideString): IXMLDOMText; dispid 43;
    function createComment(const data: WideString): IXMLDOMComment; dispid 44;
    function createCDATASection(const data: WideString): IXMLDOMCDATASection; dispid 45;
    function createProcessingInstruction(const target: WideString; const data: WideString): IXMLDOMProcessingInstruction; dispid 46;
    function createAttribute(const name: WideString): IXMLDOMAttribute; dispid 47;
    function createEntityReference(const name: WideString): IXMLDOMEntityReference; dispid 49;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; dispid 50;
    function createNode(type_: OleVariant; const name: WideString; const namespaceURI: WideString): IXMLDOMNode; dispid 54;
    function nodeFromID(const idString: WideString): IXMLDOMNode; dispid 56;
    function load(xmlSource: OleVariant): WordBool; dispid 58;
    property readyState: Integer readonly dispid -525;
    property parseError: IXMLDOMParseError readonly dispid 59;
    property url: WideString readonly dispid 60;
    property async: WordBool dispid 61;
    procedure abort; dispid 62;
    function loadXML(const bstrXML: WideString): WordBool; dispid 63;
    procedure save(destination: OleVariant); dispid 64;
    property validateOnParse: WordBool dispid 65;
    property resolveExternals: WordBool dispid 66;
    property preserveWhiteSpace: WordBool dispid 67;
    property onreadystatechange: OleVariant writeonly dispid 68;
    property ondataavailable: OleVariant writeonly dispid 69;
    property ontransformnode: OleVariant writeonly dispid 70;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMDocumentType
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8B-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMDocumentType = interface(IXMLDOMNode)
    ['{2933BF8B-7B36-11D2-B20E-00C04F983E60}']
    function Get_name: WideString; safecall;
    function Get_entities: IXMLDOMNamedNodeMap; safecall;
    function Get_notations: IXMLDOMNamedNodeMap; safecall;
    property name: WideString read Get_name;
    property entities: IXMLDOMNamedNodeMap read Get_entities;
    property notations: IXMLDOMNamedNodeMap read Get_notations;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMDocumentTypeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8B-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMDocumentTypeDisp = dispinterface
    ['{2933BF8B-7B36-11D2-B20E-00C04F983E60}']
    property name: WideString readonly dispid 131;
    property entities: IXMLDOMNamedNodeMap readonly dispid 132;
    property notations: IXMLDOMNamedNodeMap readonly dispid 133;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMElement
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF86-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMElement = interface(IXMLDOMNode)
    ['{2933BF86-7B36-11D2-B20E-00C04F983E60}']
    function Get_tagName: WideString; safecall;
    function getAttribute(const name: WideString): OleVariant; safecall;
    procedure setAttribute(const name: WideString; value: OleVariant); safecall;
    procedure removeAttribute(const name: WideString); safecall;
    function getAttributeNode(const name: WideString): IXMLDOMAttribute; safecall;
    function setAttributeNode(const DOMAttribute: IXMLDOMAttribute): IXMLDOMAttribute; safecall;
    function removeAttributeNode(const DOMAttribute: IXMLDOMAttribute): IXMLDOMAttribute; safecall;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; safecall;
    procedure normalize; safecall;
    property tagName: WideString read Get_tagName;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMElementDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF86-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMElementDisp = dispinterface
    ['{2933BF86-7B36-11D2-B20E-00C04F983E60}']
    property tagName: WideString readonly dispid 97;
    function getAttribute(const name: WideString): OleVariant; dispid 99;
    procedure setAttribute(const name: WideString; value: OleVariant); dispid 100;
    procedure removeAttribute(const name: WideString); dispid 101;
    function getAttributeNode(const name: WideString): IXMLDOMAttribute; dispid 102;
    function setAttributeNode(const DOMAttribute: IXMLDOMAttribute): IXMLDOMAttribute; dispid 103;
    function removeAttributeNode(const DOMAttribute: IXMLDOMAttribute): IXMLDOMAttribute; dispid 104;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; dispid 105;
    procedure normalize; dispid 106;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMAttribute
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF85-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMAttribute = interface(IXMLDOMNode)
    ['{2933BF85-7B36-11D2-B20E-00C04F983E60}']
    function Get_name: WideString; safecall;
    function Get_value: OleVariant; safecall;
    procedure Set_value(attributeValue: OleVariant); safecall;
    property name: WideString read Get_name;
    property value: OleVariant read Get_value write Set_value;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMAttributeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF85-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMAttributeDisp = dispinterface
    ['{2933BF85-7B36-11D2-B20E-00C04F983E60}']
    property name: WideString readonly dispid 118;
    property value: OleVariant dispid 120;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMDocumentFragment
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA413-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXMLDOMDocumentFragment = interface(IXMLDOMNode)
    ['{3EFAA413-272F-11D2-836F-0000F87A7782}']
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMDocumentFragmentDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA413-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXMLDOMDocumentFragmentDisp = dispinterface
    ['{3EFAA413-272F-11D2-836F-0000F87A7782}']
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMCharacterData
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF84-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMCharacterData = interface(IXMLDOMNode)
    ['{2933BF84-7B36-11D2-B20E-00C04F983E60}']
    function Get_data: WideString; safecall;
    procedure Set_data(const data: WideString); safecall;
    function Get_length: Integer; safecall;
    function substringData(offset: Integer; count: Integer): WideString; safecall;
    procedure appendData(const data: WideString); safecall;
    procedure insertData(offset: Integer; const data: WideString); safecall;
    procedure deleteData(offset: Integer; count: Integer); safecall;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); safecall;
    property data: WideString read Get_data write Set_data;
    property length: Integer read Get_length;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMCharacterDataDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF84-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMCharacterDataDisp = dispinterface
    ['{2933BF84-7B36-11D2-B20E-00C04F983E60}']
    property data: WideString dispid 109;
    property length: Integer readonly dispid 110;
    function substringData(offset: Integer; count: Integer): WideString; dispid 111;
    procedure appendData(const data: WideString); dispid 112;
    procedure insertData(offset: Integer; const data: WideString); dispid 113;
    procedure deleteData(offset: Integer; count: Integer); dispid 114;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); dispid 115;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMText
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF87-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMText = interface(IXMLDOMCharacterData)
    ['{2933BF87-7B36-11D2-B20E-00C04F983E60}']
    function splitText(offset: Integer): IXMLDOMText; safecall;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMTextDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF87-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMTextDisp = dispinterface
    ['{2933BF87-7B36-11D2-B20E-00C04F983E60}']
    function splitText(offset: Integer): IXMLDOMText; dispid 123;
    property data: WideString dispid 109;
    property length: Integer readonly dispid 110;
    function substringData(offset: Integer; count: Integer): WideString; dispid 111;
    procedure appendData(const data: WideString); dispid 112;
    procedure insertData(offset: Integer; const data: WideString); dispid 113;
    procedure deleteData(offset: Integer; count: Integer); dispid 114;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); dispid 115;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMComment
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF88-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMComment = interface(IXMLDOMCharacterData)
    ['{2933BF88-7B36-11D2-B20E-00C04F983E60}']
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMCommentDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF88-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMCommentDisp = dispinterface
    ['{2933BF88-7B36-11D2-B20E-00C04F983E60}']
    property data: WideString dispid 109;
    property length: Integer readonly dispid 110;
    function substringData(offset: Integer; count: Integer): WideString; dispid 111;
    procedure appendData(const data: WideString); dispid 112;
    procedure insertData(offset: Integer; const data: WideString); dispid 113;
    procedure deleteData(offset: Integer; count: Integer); dispid 114;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); dispid 115;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMCDATASection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8A-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMCDATASection = interface(IXMLDOMText)
    ['{2933BF8A-7B36-11D2-B20E-00C04F983E60}']
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMCDATASectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8A-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMCDATASectionDisp = dispinterface
    ['{2933BF8A-7B36-11D2-B20E-00C04F983E60}']
    function splitText(offset: Integer): IXMLDOMText; dispid 123;
    property data: WideString dispid 109;
    property length: Integer readonly dispid 110;
    function substringData(offset: Integer; count: Integer): WideString; dispid 111;
    procedure appendData(const data: WideString); dispid 112;
    procedure insertData(offset: Integer; const data: WideString); dispid 113;
    procedure deleteData(offset: Integer; count: Integer); dispid 114;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); dispid 115;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMProcessingInstruction
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF89-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMProcessingInstruction = interface(IXMLDOMNode)
    ['{2933BF89-7B36-11D2-B20E-00C04F983E60}']
    function Get_target: WideString; safecall;
    function Get_data: WideString; safecall;
    procedure Set_data(const value: WideString); safecall;
    property target: WideString read Get_target;
    property data: WideString read Get_data write Set_data;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMProcessingInstructionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF89-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMProcessingInstructionDisp = dispinterface
    ['{2933BF89-7B36-11D2-B20E-00C04F983E60}']
    property target: WideString readonly dispid 127;
    property data: WideString dispid 128;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMEntityReference
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8E-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMEntityReference = interface(IXMLDOMNode)
    ['{2933BF8E-7B36-11D2-B20E-00C04F983E60}']
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMEntityReferenceDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8E-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMEntityReferenceDisp = dispinterface
    ['{2933BF8E-7B36-11D2-B20E-00C04F983E60}']
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMParseError
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA426-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXMLDOMParseError = interface(IDispatch)
    ['{3EFAA426-272F-11D2-836F-0000F87A7782}']
    function Get_errorCode: Integer; safecall;
    function Get_url: WideString; safecall;
    function Get_reason: WideString; safecall;
    function Get_srcText: WideString; safecall;
    function Get_line: Integer; safecall;
    function Get_linepos: Integer; safecall;
    function Get_filepos: Integer; safecall;
    property errorCode: Integer read Get_errorCode;
    property url: WideString read Get_url;
    property reason: WideString read Get_reason;
    property srcText: WideString read Get_srcText;
    property line: Integer read Get_line;
    property linepos: Integer read Get_linepos;
    property filepos: Integer read Get_filepos;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMParseErrorDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA426-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXMLDOMParseErrorDisp = dispinterface
    ['{3EFAA426-272F-11D2-836F-0000F87A7782}']
    property errorCode: Integer readonly dispid 0;
    property url: WideString readonly dispid 179;
    property reason: WideString readonly dispid 180;
    property srcText: WideString readonly dispid 181;
    property line: Integer readonly dispid 182;
    property linepos: Integer readonly dispid 183;
    property filepos: Integer readonly dispid 184;
  end;

// *********************************************************************//
// Interface: IXMLDOMDocument2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF95-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMDocument2 = interface(IXMLDOMDocument)
    ['{2933BF95-7B36-11D2-B20E-00C04F983E60}']
    function Get_namespaces: IXMLDOMSchemaCollection; safecall;
    function Get_schemas: OleVariant; safecall;
    procedure _Set_schemas(otherCollection: OleVariant); safecall;
    function validate: IXMLDOMParseError; safecall;
    procedure setProperty(const name: WideString; value: OleVariant); safecall;
    function getProperty(const name: WideString): OleVariant; safecall;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMDocument2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF95-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMDocument2Disp = dispinterface
    ['{2933BF95-7B36-11D2-B20E-00C04F983E60}']
    property namespaces: IXMLDOMSchemaCollection readonly dispid 201;
    property schemas: OleVariant dispid 202;
    function validate: IXMLDOMParseError; dispid 203;
    procedure setProperty(const name: WideString; value: OleVariant); dispid 204;
    function getProperty(const name: WideString): OleVariant; dispid 205;
    property doctype: IXMLDOMDocumentType readonly dispid 38;
    property implementation_: IXMLDOMImplementation readonly dispid 39;
    property documentElement: IXMLDOMElement dispid 40;
    function createElement(const tagName: WideString): IXMLDOMElement; dispid 41;
    function createDocumentFragment: IXMLDOMDocumentFragment; dispid 42;
    function createTextNode(const data: WideString): IXMLDOMText; dispid 43;
    function createComment(const data: WideString): IXMLDOMComment; dispid 44;
    function createCDATASection(const data: WideString): IXMLDOMCDATASection; dispid 45;
    function createProcessingInstruction(const target: WideString; const data: WideString): IXMLDOMProcessingInstruction; dispid 46;
    function createAttribute(const name: WideString): IXMLDOMAttribute; dispid 47;
    function createEntityReference(const name: WideString): IXMLDOMEntityReference; dispid 49;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; dispid 50;
    function createNode(type_: OleVariant; const name: WideString; const namespaceURI: WideString): IXMLDOMNode; dispid 54;
    function nodeFromID(const idString: WideString): IXMLDOMNode; dispid 56;
    function load(xmlSource: OleVariant): WordBool; dispid 58;
    property readyState: Integer readonly dispid -525;
    property parseError: IXMLDOMParseError readonly dispid 59;
    property url: WideString readonly dispid 60;
    property async: WordBool dispid 61;
    procedure abort; dispid 62;
    function loadXML(const bstrXML: WideString): WordBool; dispid 63;
    procedure save(destination: OleVariant); dispid 64;
    property validateOnParse: WordBool dispid 65;
    property resolveExternals: WordBool dispid 66;
    property preserveWhiteSpace: WordBool dispid 67;
    property onreadystatechange: OleVariant writeonly dispid 68;
    property ondataavailable: OleVariant writeonly dispid 69;
    property ontransformnode: OleVariant writeonly dispid 70;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMSchemaCollection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {373984C8-B845-449B-91E7-45AC83036ADE}
// *********************************************************************//
  IXMLDOMSchemaCollection = interface(IDispatch)
    ['{373984C8-B845-449B-91E7-45AC83036ADE}']
    procedure add(const namespaceURI: WideString; var_: OleVariant); safecall;
    function get(const namespaceURI: WideString): IXMLDOMNode; safecall;
    procedure remove(const namespaceURI: WideString); safecall;
    function Get_length: Integer; safecall;
    function Get_namespaceURI(index: Integer): WideString; safecall;
    procedure addCollection(const otherCollection: IXMLDOMSchemaCollection); safecall;
    function Get__newEnum: IUnknown; safecall;
    property length: Integer read Get_length;
    property namespaceURI[index: Integer]: WideString read Get_namespaceURI; default;
    property _newEnum: IUnknown read Get__newEnum;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMSchemaCollectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {373984C8-B845-449B-91E7-45AC83036ADE}
// *********************************************************************//
  IXMLDOMSchemaCollectionDisp = dispinterface
    ['{373984C8-B845-449B-91E7-45AC83036ADE}']
    procedure add(const namespaceURI: WideString; var_: OleVariant); dispid 3;
    function get(const namespaceURI: WideString): IXMLDOMNode; dispid 4;
    procedure remove(const namespaceURI: WideString); dispid 5;
    property length: Integer readonly dispid 6;
    property namespaceURI[index: Integer]: WideString readonly dispid 0; default;
    procedure addCollection(const otherCollection: IXMLDOMSchemaCollection); dispid 8;
    property _newEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: IXMLDOMDocument3
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF96-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMDocument3 = interface(IXMLDOMDocument2)
    ['{2933BF96-7B36-11D2-B20E-00C04F983E60}']
    function validateNode(const node: IXMLDOMNode): IXMLDOMParseError; safecall;
    function importNode(const node: IXMLDOMNode; deep: WordBool): IXMLDOMNode; safecall;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMDocument3Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF96-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMDocument3Disp = dispinterface
    ['{2933BF96-7B36-11D2-B20E-00C04F983E60}']
    function validateNode(const node: IXMLDOMNode): IXMLDOMParseError; dispid 208;
    function importNode(const node: IXMLDOMNode; deep: WordBool): IXMLDOMNode; dispid 209;
    property namespaces: IXMLDOMSchemaCollection readonly dispid 201;
    property schemas: OleVariant dispid 202;
    function validate: IXMLDOMParseError; dispid 203;
    procedure setProperty(const name: WideString; value: OleVariant); dispid 204;
    function getProperty(const name: WideString): OleVariant; dispid 205;
    property doctype: IXMLDOMDocumentType readonly dispid 38;
    property implementation_: IXMLDOMImplementation readonly dispid 39;
    property documentElement: IXMLDOMElement dispid 40;
    function createElement(const tagName: WideString): IXMLDOMElement; dispid 41;
    function createDocumentFragment: IXMLDOMDocumentFragment; dispid 42;
    function createTextNode(const data: WideString): IXMLDOMText; dispid 43;
    function createComment(const data: WideString): IXMLDOMComment; dispid 44;
    function createCDATASection(const data: WideString): IXMLDOMCDATASection; dispid 45;
    function createProcessingInstruction(const target: WideString; const data: WideString): IXMLDOMProcessingInstruction; dispid 46;
    function createAttribute(const name: WideString): IXMLDOMAttribute; dispid 47;
    function createEntityReference(const name: WideString): IXMLDOMEntityReference; dispid 49;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; dispid 50;
    function createNode(type_: OleVariant; const name: WideString; const namespaceURI: WideString): IXMLDOMNode; dispid 54;
    function nodeFromID(const idString: WideString): IXMLDOMNode; dispid 56;
    function load(xmlSource: OleVariant): WordBool; dispid 58;
    property readyState: Integer readonly dispid -525;
    property parseError: IXMLDOMParseError readonly dispid 59;
    property url: WideString readonly dispid 60;
    property async: WordBool dispid 61;
    procedure abort; dispid 62;
    function loadXML(const bstrXML: WideString): WordBool; dispid 63;
    procedure save(destination: OleVariant); dispid 64;
    property validateOnParse: WordBool dispid 65;
    property resolveExternals: WordBool dispid 66;
    property preserveWhiteSpace: WordBool dispid 67;
    property onreadystatechange: OleVariant writeonly dispid 68;
    property ondataavailable: OleVariant writeonly dispid 69;
    property ontransformnode: OleVariant writeonly dispid 70;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMNotation
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8C-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMNotation = interface(IXMLDOMNode)
    ['{2933BF8C-7B36-11D2-B20E-00C04F983E60}']
    function Get_publicId: OleVariant; safecall;
    function Get_systemId: OleVariant; safecall;
    property publicId: OleVariant read Get_publicId;
    property systemId: OleVariant read Get_systemId;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMNotationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8C-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMNotationDisp = dispinterface
    ['{2933BF8C-7B36-11D2-B20E-00C04F983E60}']
    property publicId: OleVariant readonly dispid 136;
    property systemId: OleVariant readonly dispid 137;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMEntity
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8D-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMEntity = interface(IXMLDOMNode)
    ['{2933BF8D-7B36-11D2-B20E-00C04F983E60}']
    function Get_publicId: OleVariant; safecall;
    function Get_systemId: OleVariant; safecall;
    function Get_notationName: WideString; safecall;
    property publicId: OleVariant read Get_publicId;
    property systemId: OleVariant read Get_systemId;
    property notationName: WideString read Get_notationName;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMEntityDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF8D-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMEntityDisp = dispinterface
    ['{2933BF8D-7B36-11D2-B20E-00C04F983E60}']
    property publicId: OleVariant readonly dispid 140;
    property systemId: OleVariant readonly dispid 141;
    property notationName: WideString readonly dispid 142;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXMLDOMParseError2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA428-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXMLDOMParseError2 = interface(IXMLDOMParseError)
    ['{3EFAA428-272F-11D2-836F-0000F87A7782}']
    function Get_errorXPath: WideString; safecall;
    function Get_allErrors: IXMLDOMParseErrorCollection; safecall;
    function errorParameters(index: Integer): WideString; safecall;
    function Get_errorParametersCount: Integer; safecall;
    property errorXPath: WideString read Get_errorXPath;
    property allErrors: IXMLDOMParseErrorCollection read Get_allErrors;
    property errorParametersCount: Integer read Get_errorParametersCount;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMParseError2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA428-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXMLDOMParseError2Disp = dispinterface
    ['{3EFAA428-272F-11D2-836F-0000F87A7782}']
    property errorXPath: WideString readonly dispid 190;
    property allErrors: IXMLDOMParseErrorCollection readonly dispid 187;
    function errorParameters(index: Integer): WideString; dispid 188;
    property errorParametersCount: Integer readonly dispid 189;
    property errorCode: Integer readonly dispid 0;
    property url: WideString readonly dispid 179;
    property reason: WideString readonly dispid 180;
    property srcText: WideString readonly dispid 181;
    property line: Integer readonly dispid 182;
    property linepos: Integer readonly dispid 183;
    property filepos: Integer readonly dispid 184;
  end;

// *********************************************************************//
// Interface: IXMLDOMParseErrorCollection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA429-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXMLDOMParseErrorCollection = interface(IDispatch)
    ['{3EFAA429-272F-11D2-836F-0000F87A7782}']
    function Get_item(index: Integer): IXMLDOMParseError2; safecall;
    function Get_length: Integer; safecall;
    function Get_next: IXMLDOMParseError2; safecall;
    procedure reset; safecall;
    function Get__newEnum: IUnknown; safecall;
    property item[index: Integer]: IXMLDOMParseError2 read Get_item; default;
    property length: Integer read Get_length;
    property next: IXMLDOMParseError2 read Get_next;
    property _newEnum: IUnknown read Get__newEnum;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMParseErrorCollectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA429-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXMLDOMParseErrorCollectionDisp = dispinterface
    ['{3EFAA429-272F-11D2-836F-0000F87A7782}']
    property item[index: Integer]: IXMLDOMParseError2 readonly dispid 0; default;
    property length: Integer readonly dispid 193;
    property next: IXMLDOMParseError2 readonly dispid 194;
    procedure reset; dispid 195;
    property _newEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: IXTLRuntime
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA425-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXTLRuntime = interface(IXMLDOMNode)
    ['{3EFAA425-272F-11D2-836F-0000F87A7782}']
    function uniqueID(const pNode: IXMLDOMNode): Integer; safecall;
    function depth(const pNode: IXMLDOMNode): Integer; safecall;
    function childNumber(const pNode: IXMLDOMNode): Integer; safecall;
    function ancestorChildNumber(const bstrNodeName: WideString; const pNode: IXMLDOMNode): Integer; safecall;
    function absoluteChildNumber(const pNode: IXMLDOMNode): Integer; safecall;
    function formatIndex(lIndex: Integer; const bstrFormat: WideString): WideString; safecall;
    function formatNumber(dblNumber: Double; const bstrFormat: WideString): WideString; safecall;
    function formatDate(varDate: OleVariant; const bstrFormat: WideString; varDestLocale: OleVariant): WideString; safecall;
    function formatTime(varTime: OleVariant; const bstrFormat: WideString; varDestLocale: OleVariant): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IXTLRuntimeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3EFAA425-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  IXTLRuntimeDisp = dispinterface
    ['{3EFAA425-272F-11D2-836F-0000F87A7782}']
    function uniqueID(const pNode: IXMLDOMNode): Integer; dispid 187;
    function depth(const pNode: IXMLDOMNode): Integer; dispid 188;
    function childNumber(const pNode: IXMLDOMNode): Integer; dispid 189;
    function ancestorChildNumber(const bstrNodeName: WideString; const pNode: IXMLDOMNode): Integer; dispid 190;
    function absoluteChildNumber(const pNode: IXMLDOMNode): Integer; dispid 191;
    function formatIndex(lIndex: Integer; const bstrFormat: WideString): WideString; dispid 192;
    function formatNumber(dblNumber: Double; const bstrFormat: WideString): WideString; dispid 193;
    function formatDate(varDate: OleVariant; const bstrFormat: WideString; varDestLocale: OleVariant): WideString; dispid 194;
    function formatTime(varTime: OleVariant; const bstrFormat: WideString; varDestLocale: OleVariant): WideString; dispid 195;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: IXMLDOMNodeList readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: IXMLDOMNamedNodeMap readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: IXMLDOMDocument readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

// *********************************************************************//
// Interface: IXSLTemplate
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF93-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXSLTemplate = interface(IDispatch)
    ['{2933BF93-7B36-11D2-B20E-00C04F983E60}']
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode); safecall;
    function Get_stylesheet: IXMLDOMNode; safecall;
    function createProcessor: IXSLProcessor; safecall;
    property stylesheet: IXMLDOMNode read Get_stylesheet write _Set_stylesheet;
  end;

// *********************************************************************//
// DispIntf:  IXSLTemplateDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF93-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXSLTemplateDisp = dispinterface
    ['{2933BF93-7B36-11D2-B20E-00C04F983E60}']
    property stylesheet: IXMLDOMNode dispid 2;
    function createProcessor: IXSLProcessor; dispid 3;
  end;

// *********************************************************************//
// Interface: IXSLProcessor
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF92-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXSLProcessor = interface(IDispatch)
    ['{2933BF92-7B36-11D2-B20E-00C04F983E60}']
    procedure Set_input(pVar: OleVariant); safecall;
    function Get_input: OleVariant; safecall;
    function Get_ownerTemplate: IXSLTemplate; safecall;
    procedure setStartMode(const mode: WideString; const namespaceURI: WideString); safecall;
    function Get_startMode: WideString; safecall;
    function Get_startModeURI: WideString; safecall;
    procedure Set_output(pOutput: OleVariant); safecall;
    function Get_output: OleVariant; safecall;
    function transform: WordBool; safecall;
    procedure reset; safecall;
    function Get_readyState: Integer; safecall;
    procedure addParameter(const baseName: WideString; parameter: OleVariant;
                           const namespaceURI: WideString); safecall;
    procedure addObject(const obj: IDispatch; const namespaceURI: WideString); safecall;
    function Get_stylesheet: IXMLDOMNode; safecall;
    property input: OleVariant read Get_input write Set_input;
    property ownerTemplate: IXSLTemplate read Get_ownerTemplate;
    property startMode: WideString read Get_startMode;
    property startModeURI: WideString read Get_startModeURI;
    property output: OleVariant read Get_output write Set_output;
    property readyState: Integer read Get_readyState;
    property stylesheet: IXMLDOMNode read Get_stylesheet;
  end;

// *********************************************************************//
// DispIntf:  IXSLProcessorDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF92-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXSLProcessorDisp = dispinterface
    ['{2933BF92-7B36-11D2-B20E-00C04F983E60}']
    property input: OleVariant dispid 2;
    property ownerTemplate: IXSLTemplate readonly dispid 3;
    procedure setStartMode(const mode: WideString; const namespaceURI: WideString); dispid 4;
    property startMode: WideString readonly dispid 5;
    property startModeURI: WideString readonly dispid 6;
    property output: OleVariant dispid 7;
    function transform: WordBool; dispid 8;
    procedure reset; dispid 9;
    property readyState: Integer readonly dispid 10;
    procedure addParameter(const baseName: WideString; parameter: OleVariant;
                           const namespaceURI: WideString); dispid 11;
    procedure addObject(const obj: IDispatch; const namespaceURI: WideString); dispid 12;
    property stylesheet: IXMLDOMNode readonly dispid 13;
  end;

// *********************************************************************//
// Interface: ISAXXMLReader
// Flags:     (16) Hidden
// GUID:      {A4F96ED0-F829-476E-81C0-CDC7BD2A0802}
// *********************************************************************//
  ISAXXMLReader = interface(IUnknown)
    ['{A4F96ED0-F829-476E-81C0-CDC7BD2A0802}']
    function getFeature(var pwchName: Word; out pvfValue: WordBool): HResult; stdcall;
    function putFeature(var pwchName: Word; vfValue: WordBool): HResult; stdcall;
    function getProperty(var pwchName: Word; out pvarValue: OleVariant): HResult; stdcall;
    function putProperty(var pwchName: Word; varValue: OleVariant): HResult; stdcall;
    function getEntityResolver(out ppResolver: ISAXEntityResolver): HResult; stdcall;
    function putEntityResolver(const pResolver: ISAXEntityResolver): HResult; stdcall;
    function getContentHandler(out ppHandler: ISAXContentHandler): HResult; stdcall;
    function putContentHandler(const pHandler: ISAXContentHandler): HResult; stdcall;
    function getDTDHandler(out ppHandler: ISAXDTDHandler): HResult; stdcall;
    function putDTDHandler(const pHandler: ISAXDTDHandler): HResult; stdcall;
    function getErrorHandler(out ppHandler: ISAXErrorHandler): HResult; stdcall;
    function putErrorHandler(const pHandler: ISAXErrorHandler): HResult; stdcall;
    function getBaseURL(out ppwchBaseUrl: PWord1): HResult; stdcall;
    function putBaseURL(var pwchBaseUrl: Word): HResult; stdcall;
    function getSecureBaseURL(out ppwchSecureBaseUrl: PWord1): HResult; stdcall;
    function putSecureBaseURL(var pwchSecureBaseUrl: Word): HResult; stdcall;
    function parse(varInput: OleVariant): HResult; stdcall;
    function parseURL(var pwchUrl: Word): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISAXEntityResolver
// Flags:     (16) Hidden
// GUID:      {99BCA7BD-E8C4-4D5F-A0CF-6D907901FF07}
// *********************************************************************//
  ISAXEntityResolver = interface(IUnknown)
    ['{99BCA7BD-E8C4-4D5F-A0CF-6D907901FF07}']
    function resolveEntity(var pwchPublicId: Word; var pwchSystemId: Word; out pvarInput: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISAXContentHandler
// Flags:     (16) Hidden
// GUID:      {1545CDFA-9E4E-4497-A8A4-2BF7D0112C44}
// *********************************************************************//
  ISAXContentHandler = interface(IUnknown)
    ['{1545CDFA-9E4E-4497-A8A4-2BF7D0112C44}']
    function putDocumentLocator(const pLocator: ISAXLocator): HResult; stdcall;
    function startDocument: HResult; stdcall;
    function endDocument: HResult; stdcall;
    function startPrefixMapping(var pwchPrefix: Word; cchPrefix: SYSINT; var pwchUri: Word;
                                cchUri: SYSINT): HResult; stdcall;
    function endPrefixMapping(var pwchPrefix: Word; cchPrefix: SYSINT): HResult; stdcall;
    function startElement(var pwchNamespaceUri: Word; cchNamespaceUri: SYSINT;
                          var pwchLocalName: Word; cchLocalName: SYSINT; var pwchQName: Word;
                          cchQName: SYSINT; const pAttributes: ISAXAttributes): HResult; stdcall;
    function endElement(var pwchNamespaceUri: Word; cchNamespaceUri: SYSINT;
                        var pwchLocalName: Word; cchLocalName: SYSINT; var pwchQName: Word;
                        cchQName: SYSINT): HResult; stdcall;
    function characters(var pwchChars: Word; cchChars: SYSINT): HResult; stdcall;
    function ignorableWhitespace(var pwchChars: Word; cchChars: SYSINT): HResult; stdcall;
    function processingInstruction(var pwchTarget: Word; cchTarget: SYSINT; var pwchData: Word;
                                   cchData: SYSINT): HResult; stdcall;
    function skippedEntity(var pwchName: Word; cchName: SYSINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISAXLocator
// Flags:     (16) Hidden
// GUID:      {9B7E472A-0DE4-4640-BFF3-84D38A051C31}
// *********************************************************************//
  ISAXLocator = interface(IUnknown)
    ['{9B7E472A-0DE4-4640-BFF3-84D38A051C31}']
    function getColumnNumber(out pnColumn: SYSINT): HResult; stdcall;
    function getLineNumber(out pnLine: SYSINT): HResult; stdcall;
    function getPublicId(out ppwchPublicId: PWord1): HResult; stdcall;
    function getSystemId(out ppwchSystemId: PWord1): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISAXAttributes
// Flags:     (16) Hidden
// GUID:      {F078ABE1-45D2-4832-91EA-4466CE2F25C9}
// *********************************************************************//
  ISAXAttributes = interface(IUnknown)
    ['{F078ABE1-45D2-4832-91EA-4466CE2F25C9}']
    function getLength(out pnLength: SYSINT): HResult; stdcall;
    function getURI(nIndex: SYSINT; out ppwchUri: PWord1; out pcchUri: SYSINT): HResult; stdcall;
    function getLocalName(nIndex: SYSINT; out ppwchLocalName: PWord1; out pcchLocalName: SYSINT): HResult; stdcall;
    function getQName(nIndex: SYSINT; out ppwchQName: PWord1; out pcchQName: SYSINT): HResult; stdcall;
    function getName(nIndex: SYSINT; out ppwchUri: PWord1; out pcchUri: SYSINT;
                     out ppwchLocalName: PWord1; out pcchLocalName: SYSINT; out ppwchQName: PWord1;
                     out pcchQName: SYSINT): HResult; stdcall;
    function getIndexFromName(var pwchUri: Word; cchUri: SYSINT; var pwchLocalName: Word;
                              cchLocalName: SYSINT; out pnIndex: SYSINT): HResult; stdcall;
    function getIndexFromQName(var pwchQName: Word; cchQName: SYSINT; out pnIndex: SYSINT): HResult; stdcall;
    function getType(nIndex: SYSINT; out ppwchType: PWord1; out pcchType: SYSINT): HResult; stdcall;
    function getTypeFromName(var pwchUri: Word; cchUri: SYSINT; var pwchLocalName: Word;
                             cchLocalName: SYSINT; out ppwchType: PWord1; out pcchType: SYSINT): HResult; stdcall;
    function getTypeFromQName(var pwchQName: Word; cchQName: SYSINT; out ppwchType: PWord1;
                              out pcchType: SYSINT): HResult; stdcall;
    function getValue(nIndex: SYSINT; out ppwchValue: PWord1; out pcchValue: SYSINT): HResult; stdcall;
    function getValueFromName(var pwchUri: Word; cchUri: SYSINT; var pwchLocalName: Word;
                              cchLocalName: SYSINT; out ppwchValue: PWord1; out pcchValue: SYSINT): HResult; stdcall;
    function getValueFromQName(var pwchQName: Word; cchQName: SYSINT; out ppwchValue: PWord1;
                               out pcchValue: SYSINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISAXDTDHandler
// Flags:     (16) Hidden
// GUID:      {E15C1BAF-AFB3-4D60-8C36-19A8C45DEFED}
// *********************************************************************//
  ISAXDTDHandler = interface(IUnknown)
    ['{E15C1BAF-AFB3-4D60-8C36-19A8C45DEFED}']
    function notationDecl(var pwchName: Word; cchName: SYSINT; var pwchPublicId: Word;
                          cchPublicId: SYSINT; var pwchSystemId: Word; cchSystemId: SYSINT): HResult; stdcall;
    function unparsedEntityDecl(var pwchName: Word; cchName: SYSINT; var pwchPublicId: Word;
                                cchPublicId: SYSINT; var pwchSystemId: Word; cchSystemId: SYSINT;
                                var pwchNotationName: Word; cchNotationName: SYSINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISAXErrorHandler
// Flags:     (16) Hidden
// GUID:      {A60511C4-CCF5-479E-98A3-DC8DC545B7D0}
// *********************************************************************//
  ISAXErrorHandler = interface(IUnknown)
    ['{A60511C4-CCF5-479E-98A3-DC8DC545B7D0}']
    function error(const pLocator: ISAXLocator; var pwchErrorMessage: Word; hrErrorCode: HResult): HResult; stdcall;
    function fatalError(const pLocator: ISAXLocator; var pwchErrorMessage: Word;
                        hrErrorCode: HResult): HResult; stdcall;
    function ignorableWarning(const pLocator: ISAXLocator; var pwchErrorMessage: Word;
                              hrErrorCode: HResult): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISAXXMLFilter
// Flags:     (16) Hidden
// GUID:      {70409222-CA09-4475-ACB8-40312FE8D145}
// *********************************************************************//
  ISAXXMLFilter = interface(ISAXXMLReader)
    ['{70409222-CA09-4475-ACB8-40312FE8D145}']
    function getParent(out ppReader: ISAXXMLReader): HResult; stdcall;
    function putParent(const pReader: ISAXXMLReader): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISAXLexicalHandler
// Flags:     (16) Hidden
// GUID:      {7F85D5F5-47A8-4497-BDA5-84BA04819EA6}
// *********************************************************************//
  ISAXLexicalHandler = interface(IUnknown)
    ['{7F85D5F5-47A8-4497-BDA5-84BA04819EA6}']
    function startDTD(var pwchName: Word; cchName: SYSINT; var pwchPublicId: Word;
                      cchPublicId: SYSINT; var pwchSystemId: Word; cchSystemId: SYSINT): HResult; stdcall;
    function endDTD: HResult; stdcall;
    function startEntity(var pwchName: Word; cchName: SYSINT): HResult; stdcall;
    function endEntity(var pwchName: Word; cchName: SYSINT): HResult; stdcall;
    function startCDATA: HResult; stdcall;
    function endCDATA: HResult; stdcall;
    function comment(var pwchChars: Word; cchChars: SYSINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISAXDeclHandler
// Flags:     (16) Hidden
// GUID:      {862629AC-771A-47B2-8337-4E6843C1BE90}
// *********************************************************************//
  ISAXDeclHandler = interface(IUnknown)
    ['{862629AC-771A-47B2-8337-4E6843C1BE90}']
    function elementDecl(var pwchName: Word; cchName: SYSINT; var pwchModel: Word; cchModel: SYSINT): HResult; stdcall;
    function attributeDecl(var pwchElementName: Word; cchElementName: SYSINT;
                           var pwchAttributeName: Word; cchAttributeName: SYSINT;
                           var pwchType: Word; cchType: SYSINT; var pwchValueDefault: Word;
                           cchValueDefault: SYSINT; var pwchValue: Word; cchValue: SYSINT): HResult; stdcall;
    function internalEntityDecl(var pwchName: Word; cchName: SYSINT; var pwchValue: Word;
                                cchValue: SYSINT): HResult; stdcall;
    function externalEntityDecl(var pwchName: Word; cchName: SYSINT; var pwchPublicId: Word;
                                cchPublicId: SYSINT; var pwchSystemId: Word; cchSystemId: SYSINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IVBSAXXMLReader
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8C033CAA-6CD6-4F73-B728-4531AF74945F}
// *********************************************************************//
  IVBSAXXMLReader = interface(IDispatch)
    ['{8C033CAA-6CD6-4F73-B728-4531AF74945F}']
    function getFeature(const strName: WideString): WordBool; safecall;
    procedure putFeature(const strName: WideString; fValue: WordBool); safecall;
    function getProperty(const strName: WideString): OleVariant; safecall;
    procedure putProperty(const strName: WideString; varValue: OleVariant); safecall;
    function Get_entityResolver: IVBSAXEntityResolver; safecall;
    procedure _Set_entityResolver(const oResolver: IVBSAXEntityResolver); safecall;
    function Get_contentHandler: IVBSAXContentHandler; safecall;
    procedure _Set_contentHandler(const oHandler: IVBSAXContentHandler); safecall;
    function Get_dtdHandler: IVBSAXDTDHandler; safecall;
    procedure _Set_dtdHandler(const oHandler: IVBSAXDTDHandler); safecall;
    function Get_errorHandler: IVBSAXErrorHandler; safecall;
    procedure _Set_errorHandler(const oHandler: IVBSAXErrorHandler); safecall;
    function Get_baseURL: WideString; safecall;
    procedure Set_baseURL(const strBaseURL: WideString); safecall;
    function Get_secureBaseURL: WideString; safecall;
    procedure Set_secureBaseURL(const strSecureBaseURL: WideString); safecall;
    procedure parse(varInput: OleVariant); safecall;
    procedure parseURL(const strURL: WideString); safecall;
    property entityResolver: IVBSAXEntityResolver read Get_entityResolver write _Set_entityResolver;
    property contentHandler: IVBSAXContentHandler read Get_contentHandler write _Set_contentHandler;
    property dtdHandler: IVBSAXDTDHandler read Get_dtdHandler write _Set_dtdHandler;
    property errorHandler: IVBSAXErrorHandler read Get_errorHandler write _Set_errorHandler;
    property baseURL: WideString read Get_baseURL write Set_baseURL;
    property secureBaseURL: WideString read Get_secureBaseURL write Set_secureBaseURL;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXXMLReaderDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8C033CAA-6CD6-4F73-B728-4531AF74945F}
// *********************************************************************//
  IVBSAXXMLReaderDisp = dispinterface
    ['{8C033CAA-6CD6-4F73-B728-4531AF74945F}']
    function getFeature(const strName: WideString): WordBool; dispid 1282;
    procedure putFeature(const strName: WideString; fValue: WordBool); dispid 1283;
    function getProperty(const strName: WideString): OleVariant; dispid 1284;
    procedure putProperty(const strName: WideString; varValue: OleVariant); dispid 1285;
    property entityResolver: IVBSAXEntityResolver dispid 1286;
    property contentHandler: IVBSAXContentHandler dispid 1287;
    property dtdHandler: IVBSAXDTDHandler dispid 1288;
    property errorHandler: IVBSAXErrorHandler dispid 1289;
    property baseURL: WideString dispid 1290;
    property secureBaseURL: WideString dispid 1291;
    procedure parse(varInput: OleVariant); dispid 1292;
    procedure parseURL(const strURL: WideString); dispid 1293;
  end;

// *********************************************************************//
// Interface: IVBSAXEntityResolver
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0C05D096-F45B-4ACA-AD1A-AA0BC25518DC}
// *********************************************************************//
  IVBSAXEntityResolver = interface(IDispatch)
    ['{0C05D096-F45B-4ACA-AD1A-AA0BC25518DC}']
    function resolveEntity(var strPublicId: WideString; var strSystemId: WideString): OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXEntityResolverDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0C05D096-F45B-4ACA-AD1A-AA0BC25518DC}
// *********************************************************************//
  IVBSAXEntityResolverDisp = dispinterface
    ['{0C05D096-F45B-4ACA-AD1A-AA0BC25518DC}']
    function resolveEntity(var strPublicId: WideString; var strSystemId: WideString): OleVariant; dispid 1319;
  end;

// *********************************************************************//
// Interface: IVBSAXContentHandler
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2ED7290A-4DD5-4B46-BB26-4E4155E77FAA}
// *********************************************************************//
  IVBSAXContentHandler = interface(IDispatch)
    ['{2ED7290A-4DD5-4B46-BB26-4E4155E77FAA}']
    procedure _Set_documentLocator(const Param1: IVBSAXLocator); safecall;
    procedure startDocument; safecall;
    procedure endDocument; safecall;
    procedure startPrefixMapping(var strPrefix: WideString; var strURI: WideString); safecall;
    procedure endPrefixMapping(var strPrefix: WideString); safecall;
    procedure startElement(var strNamespaceURI: WideString; var strLocalName: WideString;
                           var strQName: WideString; const oAttributes: IVBSAXAttributes); safecall;
    procedure endElement(var strNamespaceURI: WideString; var strLocalName: WideString;
                         var strQName: WideString); safecall;
    procedure characters(var strChars: WideString); safecall;
    procedure ignorableWhitespace(var strChars: WideString); safecall;
    procedure processingInstruction(var strTarget: WideString; var strData: WideString); safecall;
    procedure skippedEntity(var strName: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXContentHandlerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2ED7290A-4DD5-4B46-BB26-4E4155E77FAA}
// *********************************************************************//
  IVBSAXContentHandlerDisp = dispinterface
    ['{2ED7290A-4DD5-4B46-BB26-4E4155E77FAA}']
    procedure startDocument; dispid 1323;
    procedure endDocument; dispid 1324;
    procedure startPrefixMapping(var strPrefix: WideString; var strURI: WideString); dispid 1325;
    procedure endPrefixMapping(var strPrefix: WideString); dispid 1326;
    procedure startElement(var strNamespaceURI: WideString; var strLocalName: WideString;
                           var strQName: WideString; const oAttributes: IVBSAXAttributes); dispid 1327;
    procedure endElement(var strNamespaceURI: WideString; var strLocalName: WideString;
                         var strQName: WideString); dispid 1328;
    procedure characters(var strChars: WideString); dispid 1329;
    procedure ignorableWhitespace(var strChars: WideString); dispid 1330;
    procedure processingInstruction(var strTarget: WideString; var strData: WideString); dispid 1331;
    procedure skippedEntity(var strName: WideString); dispid 1332;
  end;

// *********************************************************************//
// Interface: IVBSAXLocator
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {796E7AC5-5AA2-4EFF-ACAD-3FAAF01A3288}
// *********************************************************************//
  IVBSAXLocator = interface(IDispatch)
    ['{796E7AC5-5AA2-4EFF-ACAD-3FAAF01A3288}']
    function Get_columnNumber: SYSINT; safecall;
    function Get_lineNumber: SYSINT; safecall;
    function Get_publicId: WideString; safecall;
    function Get_systemId: WideString; safecall;
    property columnNumber: SYSINT read Get_columnNumber;
    property lineNumber: SYSINT read Get_lineNumber;
    property publicId: WideString read Get_publicId;
    property systemId: WideString read Get_systemId;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXLocatorDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {796E7AC5-5AA2-4EFF-ACAD-3FAAF01A3288}
// *********************************************************************//
  IVBSAXLocatorDisp = dispinterface
    ['{796E7AC5-5AA2-4EFF-ACAD-3FAAF01A3288}']
    property columnNumber: SYSINT readonly dispid 1313;
    property lineNumber: SYSINT readonly dispid 1314;
    property publicId: WideString readonly dispid 1315;
    property systemId: WideString readonly dispid 1316;
  end;

// *********************************************************************//
// Interface: IVBSAXAttributes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {10DC0586-132B-4CAC-8BB3-DB00AC8B7EE0}
// *********************************************************************//
  IVBSAXAttributes = interface(IDispatch)
    ['{10DC0586-132B-4CAC-8BB3-DB00AC8B7EE0}']
    function Get_length: SYSINT; safecall;
    function getURI(nIndex: SYSINT): WideString; safecall;
    function getLocalName(nIndex: SYSINT): WideString; safecall;
    function getQName(nIndex: SYSINT): WideString; safecall;
    function getIndexFromName(const strURI: WideString; const strLocalName: WideString): SYSINT; safecall;
    function getIndexFromQName(const strQName: WideString): SYSINT; safecall;
    function getType(nIndex: SYSINT): WideString; safecall;
    function getTypeFromName(const strURI: WideString; const strLocalName: WideString): WideString; safecall;
    function getTypeFromQName(const strQName: WideString): WideString; safecall;
    function getValue(nIndex: SYSINT): WideString; safecall;
    function getValueFromName(const strURI: WideString; const strLocalName: WideString): WideString; safecall;
    function getValueFromQName(const strQName: WideString): WideString; safecall;
    property length: SYSINT read Get_length;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXAttributesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {10DC0586-132B-4CAC-8BB3-DB00AC8B7EE0}
// *********************************************************************//
  IVBSAXAttributesDisp = dispinterface
    ['{10DC0586-132B-4CAC-8BB3-DB00AC8B7EE0}']
    property length: SYSINT readonly dispid 1344;
    function getURI(nIndex: SYSINT): WideString; dispid 1345;
    function getLocalName(nIndex: SYSINT): WideString; dispid 1346;
    function getQName(nIndex: SYSINT): WideString; dispid 1347;
    function getIndexFromName(const strURI: WideString; const strLocalName: WideString): SYSINT; dispid 1348;
    function getIndexFromQName(const strQName: WideString): SYSINT; dispid 1349;
    function getType(nIndex: SYSINT): WideString; dispid 1350;
    function getTypeFromName(const strURI: WideString; const strLocalName: WideString): WideString; dispid 1351;
    function getTypeFromQName(const strQName: WideString): WideString; dispid 1352;
    function getValue(nIndex: SYSINT): WideString; dispid 1353;
    function getValueFromName(const strURI: WideString; const strLocalName: WideString): WideString; dispid 1354;
    function getValueFromQName(const strQName: WideString): WideString; dispid 1355;
  end;

// *********************************************************************//
// Interface: IVBSAXDTDHandler
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {24FB3297-302D-4620-BA39-3A732D850558}
// *********************************************************************//
  IVBSAXDTDHandler = interface(IDispatch)
    ['{24FB3297-302D-4620-BA39-3A732D850558}']
    procedure notationDecl(var strName: WideString; var strPublicId: WideString;
                           var strSystemId: WideString); safecall;
    procedure unparsedEntityDecl(var strName: WideString; var strPublicId: WideString;
                                 var strSystemId: WideString; var strNotationName: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXDTDHandlerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {24FB3297-302D-4620-BA39-3A732D850558}
// *********************************************************************//
  IVBSAXDTDHandlerDisp = dispinterface
    ['{24FB3297-302D-4620-BA39-3A732D850558}']
    procedure notationDecl(var strName: WideString; var strPublicId: WideString;
                           var strSystemId: WideString); dispid 1335;
    procedure unparsedEntityDecl(var strName: WideString; var strPublicId: WideString;
                                 var strSystemId: WideString; var strNotationName: WideString); dispid 1336;
  end;

// *********************************************************************//
// Interface: IVBSAXErrorHandler
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D963D3FE-173C-4862-9095-B92F66995F52}
// *********************************************************************//
  IVBSAXErrorHandler = interface(IDispatch)
    ['{D963D3FE-173C-4862-9095-B92F66995F52}']
    procedure error(const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
                    nErrorCode: Integer); safecall;
    procedure fatalError(const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
                         nErrorCode: Integer); safecall;
    procedure ignorableWarning(const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
                               nErrorCode: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXErrorHandlerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D963D3FE-173C-4862-9095-B92F66995F52}
// *********************************************************************//
  IVBSAXErrorHandlerDisp = dispinterface
    ['{D963D3FE-173C-4862-9095-B92F66995F52}']
    procedure error(const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
                    nErrorCode: Integer); dispid 1339;
    procedure fatalError(const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
                         nErrorCode: Integer); dispid 1340;
    procedure ignorableWarning(const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
                               nErrorCode: Integer); dispid 1341;
  end;

// *********************************************************************//
// Interface: IVBSAXXMLFilter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1299EB1B-5B88-433E-82DE-82CA75AD4E04}
// *********************************************************************//
  IVBSAXXMLFilter = interface(IDispatch)
    ['{1299EB1B-5B88-433E-82DE-82CA75AD4E04}']
    function Get_parent: IVBSAXXMLReader; safecall;
    procedure _Set_parent(const oReader: IVBSAXXMLReader); safecall;
    property parent: IVBSAXXMLReader read Get_parent write _Set_parent;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXXMLFilterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1299EB1B-5B88-433E-82DE-82CA75AD4E04}
// *********************************************************************//
  IVBSAXXMLFilterDisp = dispinterface
    ['{1299EB1B-5B88-433E-82DE-82CA75AD4E04}']
    property parent: IVBSAXXMLReader dispid 1309;
  end;

// *********************************************************************//
// Interface: IVBSAXLexicalHandler
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {032AAC35-8C0E-4D9D-979F-E3B702935576}
// *********************************************************************//
  IVBSAXLexicalHandler = interface(IDispatch)
    ['{032AAC35-8C0E-4D9D-979F-E3B702935576}']
    procedure startDTD(var strName: WideString; var strPublicId: WideString;
                       var strSystemId: WideString); safecall;
    procedure endDTD; safecall;
    procedure startEntity(var strName: WideString); safecall;
    procedure endEntity(var strName: WideString); safecall;
    procedure startCDATA; safecall;
    procedure endCDATA; safecall;
    procedure comment(var strChars: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXLexicalHandlerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {032AAC35-8C0E-4D9D-979F-E3B702935576}
// *********************************************************************//
  IVBSAXLexicalHandlerDisp = dispinterface
    ['{032AAC35-8C0E-4D9D-979F-E3B702935576}']
    procedure startDTD(var strName: WideString; var strPublicId: WideString;
                       var strSystemId: WideString); dispid 1358;
    procedure endDTD; dispid 1359;
    procedure startEntity(var strName: WideString); dispid 1360;
    procedure endEntity(var strName: WideString); dispid 1361;
    procedure startCDATA; dispid 1362;
    procedure endCDATA; dispid 1363;
    procedure comment(var strChars: WideString); dispid 1364;
  end;

// *********************************************************************//
// Interface: IVBSAXDeclHandler
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E8917260-7579-4BE1-B5DD-7AFBFA6F077B}
// *********************************************************************//
  IVBSAXDeclHandler = interface(IDispatch)
    ['{E8917260-7579-4BE1-B5DD-7AFBFA6F077B}']
    procedure elementDecl(var strName: WideString; var strModel: WideString); safecall;
    procedure attributeDecl(var strElementName: WideString; var strAttributeName: WideString;
                            var strType: WideString; var strValueDefault: WideString;
                            var strValue: WideString); safecall;
    procedure internalEntityDecl(var strName: WideString; var strValue: WideString); safecall;
    procedure externalEntityDecl(var strName: WideString; var strPublicId: WideString;
                                 var strSystemId: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IVBSAXDeclHandlerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E8917260-7579-4BE1-B5DD-7AFBFA6F077B}
// *********************************************************************//
  IVBSAXDeclHandlerDisp = dispinterface
    ['{E8917260-7579-4BE1-B5DD-7AFBFA6F077B}']
    procedure elementDecl(var strName: WideString; var strModel: WideString); dispid 1367;
    procedure attributeDecl(var strElementName: WideString; var strAttributeName: WideString;
                            var strType: WideString; var strValueDefault: WideString;
                            var strValue: WideString); dispid 1368;
    procedure internalEntityDecl(var strName: WideString; var strValue: WideString); dispid 1369;
    procedure externalEntityDecl(var strName: WideString; var strPublicId: WideString;
                                 var strSystemId: WideString); dispid 1370;
  end;

// *********************************************************************//
// Interface: IMXWriter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}
// *********************************************************************//
  IMXWriter = interface(IDispatch)
    ['{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}']
    procedure Set_output(varDestination: OleVariant); safecall;
    function Get_output: OleVariant; safecall;
    procedure Set_encoding(const strEncoding: WideString); safecall;
    function Get_encoding: WideString; safecall;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool); safecall;
    function Get_byteOrderMark: WordBool; safecall;
    procedure Set_indent(fIndentMode: WordBool); safecall;
    function Get_indent: WordBool; safecall;
    procedure Set_standalone(fValue: WordBool); safecall;
    function Get_standalone: WordBool; safecall;
    procedure Set_omitXMLDeclaration(fValue: WordBool); safecall;
    function Get_omitXMLDeclaration: WordBool; safecall;
    procedure Set_version(const strVersion: WideString); safecall;
    function Get_version: WideString; safecall;
    procedure Set_disableOutputEscaping(fValue: WordBool); safecall;
    function Get_disableOutputEscaping: WordBool; safecall;
    procedure flush; safecall;
    property output: OleVariant read Get_output write Set_output;
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  end;

// *********************************************************************//
// DispIntf:  IMXWriterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}
// *********************************************************************//
  IMXWriterDisp = dispinterface
    ['{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}']
    property output: OleVariant dispid 1385;
    property encoding: WideString dispid 1387;
    property byteOrderMark: WordBool dispid 1388;
    property indent: WordBool dispid 1389;
    property standalone: WordBool dispid 1390;
    property omitXMLDeclaration: WordBool dispid 1391;
    property version: WideString dispid 1392;
    property disableOutputEscaping: WordBool dispid 1393;
    procedure flush; dispid 1394;
  end;

// *********************************************************************//
// Interface: IMXAttributes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F10D27CC-3EC0-415C-8ED8-77AB1C5E7262}
// *********************************************************************//
  IMXAttributes = interface(IDispatch)
    ['{F10D27CC-3EC0-415C-8ED8-77AB1C5E7262}']
    procedure addAttribute(const strURI: WideString; const strLocalName: WideString;
                           const strQName: WideString; const strType: WideString;
                           const strValue: WideString); safecall;
    procedure addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT); safecall;
    procedure clear; safecall;
    procedure removeAttribute(nIndex: SYSINT); safecall;
    procedure setAttribute(nIndex: SYSINT; const strURI: WideString;
                           const strLocalName: WideString; const strQName: WideString;
                           const strType: WideString; const strValue: WideString); safecall;
    procedure setAttributes(varAtts: OleVariant); safecall;
    procedure setLocalName(nIndex: SYSINT; const strLocalName: WideString); safecall;
    procedure setQName(nIndex: SYSINT; const strQName: WideString); safecall;
    procedure setType(nIndex: SYSINT; const strType: WideString); safecall;
    procedure setURI(nIndex: SYSINT; const strURI: WideString); safecall;
    procedure setValue(nIndex: SYSINT; const strValue: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IMXAttributesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F10D27CC-3EC0-415C-8ED8-77AB1C5E7262}
// *********************************************************************//
  IMXAttributesDisp = dispinterface
    ['{F10D27CC-3EC0-415C-8ED8-77AB1C5E7262}']
    procedure addAttribute(const strURI: WideString; const strLocalName: WideString;
                           const strQName: WideString; const strType: WideString;
                           const strValue: WideString); dispid 1373;
    procedure addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT); dispid 1383;
    procedure clear; dispid 1374;
    procedure removeAttribute(nIndex: SYSINT); dispid 1375;
    procedure setAttribute(nIndex: SYSINT; const strURI: WideString;
                           const strLocalName: WideString; const strQName: WideString;
                           const strType: WideString; const strValue: WideString); dispid 1376;
    procedure setAttributes(varAtts: OleVariant); dispid 1377;
    procedure setLocalName(nIndex: SYSINT; const strLocalName: WideString); dispid 1378;
    procedure setQName(nIndex: SYSINT; const strQName: WideString); dispid 1379;
    procedure setType(nIndex: SYSINT; const strType: WideString); dispid 1380;
    procedure setURI(nIndex: SYSINT; const strURI: WideString); dispid 1381;
    procedure setValue(nIndex: SYSINT; const strValue: WideString); dispid 1382;
  end;

// *********************************************************************//
// Interface: IMXReaderControl
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {808F4E35-8D5A-4FBE-8466-33A41279ED30}
// *********************************************************************//
  IMXReaderControl = interface(IDispatch)
    ['{808F4E35-8D5A-4FBE-8466-33A41279ED30}']
    procedure abort; safecall;
    procedure resume; safecall;
    procedure suspend; safecall;
  end;

// *********************************************************************//
// DispIntf:  IMXReaderControlDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {808F4E35-8D5A-4FBE-8466-33A41279ED30}
// *********************************************************************//
  IMXReaderControlDisp = dispinterface
    ['{808F4E35-8D5A-4FBE-8466-33A41279ED30}']
    procedure abort; dispid 1398;
    procedure resume; dispid 1399;
    procedure suspend; dispid 1400;
  end;

// *********************************************************************//
// Interface: IMXSchemaDeclHandler
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {FA4BB38C-FAF9-4CCA-9302-D1DD0FE520DB}
// *********************************************************************//
  IMXSchemaDeclHandler = interface(IDispatch)
    ['{FA4BB38C-FAF9-4CCA-9302-D1DD0FE520DB}']
    procedure schemaElementDecl(const oSchemaElement: ISchemaElement); safecall;
  end;

// *********************************************************************//
// DispIntf:  IMXSchemaDeclHandlerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {FA4BB38C-FAF9-4CCA-9302-D1DD0FE520DB}
// *********************************************************************//
  IMXSchemaDeclHandlerDisp = dispinterface
    ['{FA4BB38C-FAF9-4CCA-9302-D1DD0FE520DB}']
    procedure schemaElementDecl(const oSchemaElement: ISchemaElement); dispid 1403;
  end;

// *********************************************************************//
// Interface: ISchemaItem
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B3-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaItem = interface(IDispatch)
    ['{50EA08B3-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_name: WideString; safecall;
    function Get_namespaceURI: WideString; safecall;
    function Get_schema: ISchema; safecall;
    function Get_id: WideString; safecall;
    function Get_itemType: SOMITEMTYPE; safecall;
    function Get_unhandledAttributes: IVBSAXAttributes; safecall;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; safecall;
    property name: WideString read Get_name;
    property namespaceURI: WideString read Get_namespaceURI;
    property schema: ISchema read Get_schema;
    property id: WideString read Get_id;
    property itemType: SOMITEMTYPE read Get_itemType;
    property unhandledAttributes: IVBSAXAttributes read Get_unhandledAttributes;
  end;

// *********************************************************************//
// DispIntf:  ISchemaItemDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B3-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaItemDisp = dispinterface
    ['{50EA08B3-DD1B-4664-9A50-C2F40F4BD79A}']
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchemaParticle
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B5-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaParticle = interface(ISchemaItem)
    ['{50EA08B5-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_minOccurs: OleVariant; safecall;
    function Get_maxOccurs: OleVariant; safecall;
    property minOccurs: OleVariant read Get_minOccurs;
    property maxOccurs: OleVariant read Get_maxOccurs;
  end;

// *********************************************************************//
// DispIntf:  ISchemaParticleDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B5-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaParticleDisp = dispinterface
    ['{50EA08B5-DD1B-4664-9A50-C2F40F4BD79A}']
    property minOccurs: OleVariant readonly dispid 1455;
    property maxOccurs: OleVariant readonly dispid 1451;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchemaElement
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B7-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaElement = interface(ISchemaParticle)
    ['{50EA08B7-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_type_: ISchemaType; safecall;
    function Get_scope: ISchemaComplexType; safecall;
    function Get_defaultValue: WideString; safecall;
    function Get_fixedValue: WideString; safecall;
    function Get_isNillable: WordBool; safecall;
    function Get_identityConstraints: ISchemaItemCollection; safecall;
    function Get_substitutionGroup: ISchemaElement; safecall;
    function Get_substitutionGroupExclusions: SCHEMADERIVATIONMETHOD; safecall;
    function Get_disallowedSubstitutions: SCHEMADERIVATIONMETHOD; safecall;
    function Get_isAbstract: WordBool; safecall;
    function Get_isReference: WordBool; safecall;
    property type_: ISchemaType read Get_type_;
    property scope: ISchemaComplexType read Get_scope;
    property defaultValue: WideString read Get_defaultValue;
    property fixedValue: WideString read Get_fixedValue;
    property isNillable: WordBool read Get_isNillable;
    property identityConstraints: ISchemaItemCollection read Get_identityConstraints;
    property substitutionGroup: ISchemaElement read Get_substitutionGroup;
    property substitutionGroupExclusions: SCHEMADERIVATIONMETHOD read Get_substitutionGroupExclusions;
    property disallowedSubstitutions: SCHEMADERIVATIONMETHOD read Get_disallowedSubstitutions;
    property isAbstract: WordBool read Get_isAbstract;
    property isReference: WordBool read Get_isReference;
  end;

// *********************************************************************//
// DispIntf:  ISchemaElementDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B7-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaElementDisp = dispinterface
    ['{50EA08B7-DD1B-4664-9A50-C2F40F4BD79A}']
    property type_: ISchemaType readonly dispid 1476;
    property scope: ISchemaComplexType readonly dispid 1469;
    property defaultValue: WideString readonly dispid 1431;
    property fixedValue: WideString readonly dispid 1438;
    property isNillable: WordBool readonly dispid 1443;
    property identityConstraints: ISchemaItemCollection readonly dispid 1441;
    property substitutionGroup: ISchemaElement readonly dispid 1471;
    property substitutionGroupExclusions: SCHEMADERIVATIONMETHOD readonly dispid 1472;
    property disallowedSubstitutions: SCHEMADERIVATIONMETHOD readonly dispid 1433;
    property isAbstract: WordBool readonly dispid 1442;
    property isReference: WordBool readonly dispid 1444;
    property minOccurs: OleVariant readonly dispid 1455;
    property maxOccurs: OleVariant readonly dispid 1451;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchema
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B4-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchema = interface(ISchemaItem)
    ['{50EA08B4-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_targetNamespace: WideString; safecall;
    function Get_version: WideString; safecall;
    function Get_types: ISchemaItemCollection; safecall;
    function Get_elements: ISchemaItemCollection; safecall;
    function Get_attributes: ISchemaItemCollection; safecall;
    function Get_attributeGroups: ISchemaItemCollection; safecall;
    function Get_modelGroups: ISchemaItemCollection; safecall;
    function Get_notations: ISchemaItemCollection; safecall;
    function Get_schemaLocations: ISchemaStringCollection; safecall;
    property targetNamespace: WideString read Get_targetNamespace;
    property version: WideString read Get_version;
    property types: ISchemaItemCollection read Get_types;
    property elements: ISchemaItemCollection read Get_elements;
    property attributes: ISchemaItemCollection read Get_attributes;
    property attributeGroups: ISchemaItemCollection read Get_attributeGroups;
    property modelGroups: ISchemaItemCollection read Get_modelGroups;
    property notations: ISchemaItemCollection read Get_notations;
    property schemaLocations: ISchemaStringCollection read Get_schemaLocations;
  end;

// *********************************************************************//
// DispIntf:  ISchemaDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B4-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaDisp = dispinterface
    ['{50EA08B4-DD1B-4664-9A50-C2F40F4BD79A}']
    property targetNamespace: WideString readonly dispid 1474;
    property version: WideString readonly dispid 1481;
    property types: ISchemaItemCollection readonly dispid 1477;
    property elements: ISchemaItemCollection readonly dispid 1434;
    property attributes: ISchemaItemCollection readonly dispid 1427;
    property attributeGroups: ISchemaItemCollection readonly dispid 1426;
    property modelGroups: ISchemaItemCollection readonly dispid 1456;
    property notations: ISchemaItemCollection readonly dispid 1460;
    property schemaLocations: ISchemaStringCollection readonly dispid 1468;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchemaItemCollection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B2-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaItemCollection = interface(IDispatch)
    ['{50EA08B2-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_item(index: Integer): ISchemaItem; safecall;
    function itemByName(const name: WideString): ISchemaItem; safecall;
    function itemByQName(const name: WideString; const namespaceURI: WideString): ISchemaItem; safecall;
    function Get_length: Integer; safecall;
    function Get__newEnum: IUnknown; safecall;
    property item[index: Integer]: ISchemaItem read Get_item; default;
    property length: Integer read Get_length;
    property _newEnum: IUnknown read Get__newEnum;
  end;

// *********************************************************************//
// DispIntf:  ISchemaItemCollectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B2-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaItemCollectionDisp = dispinterface
    ['{50EA08B2-DD1B-4664-9A50-C2F40F4BD79A}']
    property item[index: Integer]: ISchemaItem readonly dispid 0; default;
    function itemByName(const name: WideString): ISchemaItem; dispid 1423;
    function itemByQName(const name: WideString; const namespaceURI: WideString): ISchemaItem; dispid 1424;
    property length: Integer readonly dispid 1447;
    property _newEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: ISchemaStringCollection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B1-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaStringCollection = interface(IDispatch)
    ['{50EA08B1-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_item(index: Integer): WideString; safecall;
    function Get_length: Integer; safecall;
    function Get__newEnum: IUnknown; safecall;
    property item[index: Integer]: WideString read Get_item; default;
    property length: Integer read Get_length;
    property _newEnum: IUnknown read Get__newEnum;
  end;

// *********************************************************************//
// DispIntf:  ISchemaStringCollectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B1-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaStringCollectionDisp = dispinterface
    ['{50EA08B1-DD1B-4664-9A50-C2F40F4BD79A}']
    property item[index: Integer]: WideString readonly dispid 0; default;
    property length: Integer readonly dispid 1447;
    property _newEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: ISchemaType
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B8-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaType = interface(ISchemaItem)
    ['{50EA08B8-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_baseTypes: ISchemaItemCollection; safecall;
    function Get_final: SCHEMADERIVATIONMETHOD; safecall;
    function Get_variety: SCHEMATYPEVARIETY; safecall;
    function Get_derivedBy: SCHEMADERIVATIONMETHOD; safecall;
    function isValid(const data: WideString): WordBool; safecall;
    function Get_minExclusive: WideString; safecall;
    function Get_minInclusive: WideString; safecall;
    function Get_maxExclusive: WideString; safecall;
    function Get_maxInclusive: WideString; safecall;
    function Get_totalDigits: OleVariant; safecall;
    function Get_fractionDigits: OleVariant; safecall;
    function Get_length: OleVariant; safecall;
    function Get_minLength: OleVariant; safecall;
    function Get_maxLength: OleVariant; safecall;
    function Get_enumeration: ISchemaStringCollection; safecall;
    function Get_whitespace: SCHEMAWHITESPACE; safecall;
    function Get_patterns: ISchemaStringCollection; safecall;
    property baseTypes: ISchemaItemCollection read Get_baseTypes;
    property final: SCHEMADERIVATIONMETHOD read Get_final;
    property variety: SCHEMATYPEVARIETY read Get_variety;
    property derivedBy: SCHEMADERIVATIONMETHOD read Get_derivedBy;
    property minExclusive: WideString read Get_minExclusive;
    property minInclusive: WideString read Get_minInclusive;
    property maxExclusive: WideString read Get_maxExclusive;
    property maxInclusive: WideString read Get_maxInclusive;
    property totalDigits: OleVariant read Get_totalDigits;
    property fractionDigits: OleVariant read Get_fractionDigits;
    property length: OleVariant read Get_length;
    property minLength: OleVariant read Get_minLength;
    property maxLength: OleVariant read Get_maxLength;
    property enumeration: ISchemaStringCollection read Get_enumeration;
    property whitespace: SCHEMAWHITESPACE read Get_whitespace;
    property patterns: ISchemaStringCollection read Get_patterns;
  end;

// *********************************************************************//
// DispIntf:  ISchemaTypeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B8-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaTypeDisp = dispinterface
    ['{50EA08B8-DD1B-4664-9A50-C2F40F4BD79A}']
    property baseTypes: ISchemaItemCollection readonly dispid 1428;
    property final: SCHEMADERIVATIONMETHOD readonly dispid 1437;
    property variety: SCHEMATYPEVARIETY readonly dispid 1480;
    property derivedBy: SCHEMADERIVATIONMETHOD readonly dispid 1432;
    function isValid(const data: WideString): WordBool; dispid 1445;
    property minExclusive: WideString readonly dispid 1452;
    property minInclusive: WideString readonly dispid 1453;
    property maxExclusive: WideString readonly dispid 1448;
    property maxInclusive: WideString readonly dispid 1449;
    property totalDigits: OleVariant readonly dispid 1475;
    property fractionDigits: OleVariant readonly dispid 1439;
    property length: OleVariant readonly dispid 1447;
    property minLength: OleVariant readonly dispid 1454;
    property maxLength: OleVariant readonly dispid 1450;
    property enumeration: ISchemaStringCollection readonly dispid 1435;
    property whitespace: SCHEMAWHITESPACE readonly dispid 1482;
    property patterns: ISchemaStringCollection readonly dispid 1462;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchemaComplexType
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B9-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaComplexType = interface(ISchemaType)
    ['{50EA08B9-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_isAbstract: WordBool; safecall;
    function Get_anyAttribute: ISchemaAny; safecall;
    function Get_attributes: ISchemaItemCollection; safecall;
    function Get_contentType: SCHEMACONTENTTYPE; safecall;
    function Get_contentModel: ISchemaModelGroup; safecall;
    function Get_prohibitedSubstitutions: SCHEMADERIVATIONMETHOD; safecall;
    property isAbstract: WordBool read Get_isAbstract;
    property anyAttribute: ISchemaAny read Get_anyAttribute;
    property attributes: ISchemaItemCollection read Get_attributes;
    property contentType: SCHEMACONTENTTYPE read Get_contentType;
    property contentModel: ISchemaModelGroup read Get_contentModel;
    property prohibitedSubstitutions: SCHEMADERIVATIONMETHOD read Get_prohibitedSubstitutions;
  end;

// *********************************************************************//
// DispIntf:  ISchemaComplexTypeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B9-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaComplexTypeDisp = dispinterface
    ['{50EA08B9-DD1B-4664-9A50-C2F40F4BD79A}']
    property isAbstract: WordBool readonly dispid 1442;
    property anyAttribute: ISchemaAny readonly dispid 1425;
    property attributes: ISchemaItemCollection readonly dispid 1427;
    property contentType: SCHEMACONTENTTYPE readonly dispid 1430;
    property contentModel: ISchemaModelGroup readonly dispid 1429;
    property prohibitedSubstitutions: SCHEMADERIVATIONMETHOD readonly dispid 1464;
    property baseTypes: ISchemaItemCollection readonly dispid 1428;
    property final: SCHEMADERIVATIONMETHOD readonly dispid 1437;
    property variety: SCHEMATYPEVARIETY readonly dispid 1480;
    property derivedBy: SCHEMADERIVATIONMETHOD readonly dispid 1432;
    function isValid(const data: WideString): WordBool; dispid 1445;
    property minExclusive: WideString readonly dispid 1452;
    property minInclusive: WideString readonly dispid 1453;
    property maxExclusive: WideString readonly dispid 1448;
    property maxInclusive: WideString readonly dispid 1449;
    property totalDigits: OleVariant readonly dispid 1475;
    property fractionDigits: OleVariant readonly dispid 1439;
    property length: OleVariant readonly dispid 1447;
    property minLength: OleVariant readonly dispid 1454;
    property maxLength: OleVariant readonly dispid 1450;
    property enumeration: ISchemaStringCollection readonly dispid 1435;
    property whitespace: SCHEMAWHITESPACE readonly dispid 1482;
    property patterns: ISchemaStringCollection readonly dispid 1462;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchemaAny
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BC-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaAny = interface(ISchemaParticle)
    ['{50EA08BC-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_namespaces: ISchemaStringCollection; safecall;
    function Get_processContents: SCHEMAPROCESSCONTENTS; safecall;
    property namespaces: ISchemaStringCollection read Get_namespaces;
    property processContents: SCHEMAPROCESSCONTENTS read Get_processContents;
  end;

// *********************************************************************//
// DispIntf:  ISchemaAnyDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BC-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaAnyDisp = dispinterface
    ['{50EA08BC-DD1B-4664-9A50-C2F40F4BD79A}']
    property namespaces: ISchemaStringCollection readonly dispid 1458;
    property processContents: SCHEMAPROCESSCONTENTS readonly dispid 1463;
    property minOccurs: OleVariant readonly dispid 1455;
    property maxOccurs: OleVariant readonly dispid 1451;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchemaModelGroup
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BB-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaModelGroup = interface(ISchemaParticle)
    ['{50EA08BB-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_particles: ISchemaItemCollection; safecall;
    property particles: ISchemaItemCollection read Get_particles;
  end;

// *********************************************************************//
// DispIntf:  ISchemaModelGroupDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BB-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaModelGroupDisp = dispinterface
    ['{50EA08BB-DD1B-4664-9A50-C2F40F4BD79A}']
    property particles: ISchemaItemCollection readonly dispid 1461;
    property minOccurs: OleVariant readonly dispid 1455;
    property maxOccurs: OleVariant readonly dispid 1451;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: IMXXMLFilter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C90352F7-643C-4FBC-BB23-E996EB2D51FD}
// *********************************************************************//
  IMXXMLFilter = interface(IDispatch)
    ['{C90352F7-643C-4FBC-BB23-E996EB2D51FD}']
    function getFeature(const strName: WideString): WordBool; safecall;
    procedure putFeature(const strName: WideString; fValue: WordBool); safecall;
    function getProperty(const strName: WideString): OleVariant; safecall;
    procedure putProperty(const strName: WideString; varValue: OleVariant); safecall;
    function Get_entityResolver: IUnknown; safecall;
    procedure _Set_entityResolver(const oResolver: IUnknown); safecall;
    function Get_contentHandler: IUnknown; safecall;
    procedure _Set_contentHandler(const oHandler: IUnknown); safecall;
    function Get_dtdHandler: IUnknown; safecall;
    procedure _Set_dtdHandler(const oHandler: IUnknown); safecall;
    function Get_errorHandler: IUnknown; safecall;
    procedure _Set_errorHandler(const oHandler: IUnknown); safecall;
    property entityResolver: IUnknown read Get_entityResolver write _Set_entityResolver;
    property contentHandler: IUnknown read Get_contentHandler write _Set_contentHandler;
    property dtdHandler: IUnknown read Get_dtdHandler write _Set_dtdHandler;
    property errorHandler: IUnknown read Get_errorHandler write _Set_errorHandler;
  end;

// *********************************************************************//
// DispIntf:  IMXXMLFilterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C90352F7-643C-4FBC-BB23-E996EB2D51FD}
// *********************************************************************//
  IMXXMLFilterDisp = dispinterface
    ['{C90352F7-643C-4FBC-BB23-E996EB2D51FD}']
    function getFeature(const strName: WideString): WordBool; dispid 1423;
    procedure putFeature(const strName: WideString; fValue: WordBool); dispid 1425;
    function getProperty(const strName: WideString): OleVariant; dispid 1424;
    procedure putProperty(const strName: WideString; varValue: OleVariant); dispid 1426;
    property entityResolver: IUnknown dispid 1421;
    property contentHandler: IUnknown dispid 1419;
    property dtdHandler: IUnknown dispid 1420;
    property errorHandler: IUnknown dispid 1422;
  end;

// *********************************************************************//
// Interface: IXMLDOMSchemaCollection2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B0-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  IXMLDOMSchemaCollection2 = interface(IXMLDOMSchemaCollection)
    ['{50EA08B0-DD1B-4664-9A50-C2F40F4BD79A}']
    procedure validate; safecall;
    procedure Set_validateOnLoad(validateOnLoad: WordBool); safecall;
    function Get_validateOnLoad: WordBool; safecall;
    function getSchema(const namespaceURI: WideString): ISchema; safecall;
    function getDeclaration(const node: IXMLDOMNode): ISchemaItem; safecall;
    property validateOnLoad: WordBool read Get_validateOnLoad write Set_validateOnLoad;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMSchemaCollection2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B0-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  IXMLDOMSchemaCollection2Disp = dispinterface
    ['{50EA08B0-DD1B-4664-9A50-C2F40F4BD79A}']
    procedure validate; dispid 1419;
    property validateOnLoad: WordBool dispid 1420;
    function getSchema(const namespaceURI: WideString): ISchema; dispid 1421;
    function getDeclaration(const node: IXMLDOMNode): ISchemaItem; dispid 1422;
    procedure add(const namespaceURI: WideString; var_: OleVariant); dispid 3;
    function get(const namespaceURI: WideString): IXMLDOMNode; dispid 4;
    procedure remove(const namespaceURI: WideString); dispid 5;
    property length: Integer readonly dispid 6;
    property namespaceURI[index: Integer]: WideString readonly dispid 0; default;
    procedure addCollection(const otherCollection: IXMLDOMSchemaCollection); dispid 8;
    property _newEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: ISchemaAttribute
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B6-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaAttribute = interface(ISchemaItem)
    ['{50EA08B6-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_type_: ISchemaType; safecall;
    function Get_scope: ISchemaComplexType; safecall;
    function Get_defaultValue: WideString; safecall;
    function Get_fixedValue: WideString; safecall;
    function Get_use: SCHEMAUSE; safecall;
    function Get_isReference: WordBool; safecall;
    property type_: ISchemaType read Get_type_;
    property scope: ISchemaComplexType read Get_scope;
    property defaultValue: WideString read Get_defaultValue;
    property fixedValue: WideString read Get_fixedValue;
    property use: SCHEMAUSE read Get_use;
    property isReference: WordBool read Get_isReference;
  end;

// *********************************************************************//
// DispIntf:  ISchemaAttributeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08B6-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaAttributeDisp = dispinterface
    ['{50EA08B6-DD1B-4664-9A50-C2F40F4BD79A}']
    property type_: ISchemaType readonly dispid 1476;
    property scope: ISchemaComplexType readonly dispid 1469;
    property defaultValue: WideString readonly dispid 1431;
    property fixedValue: WideString readonly dispid 1438;
    property use: SCHEMAUSE readonly dispid 1479;
    property isReference: WordBool readonly dispid 1444;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchemaAttributeGroup
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BA-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaAttributeGroup = interface(ISchemaItem)
    ['{50EA08BA-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_anyAttribute: ISchemaAny; safecall;
    function Get_attributes: ISchemaItemCollection; safecall;
    property anyAttribute: ISchemaAny read Get_anyAttribute;
    property attributes: ISchemaItemCollection read Get_attributes;
  end;

// *********************************************************************//
// DispIntf:  ISchemaAttributeGroupDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BA-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaAttributeGroupDisp = dispinterface
    ['{50EA08BA-DD1B-4664-9A50-C2F40F4BD79A}']
    property anyAttribute: ISchemaAny readonly dispid 1425;
    property attributes: ISchemaItemCollection readonly dispid 1427;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchemaIdentityConstraint
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BD-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaIdentityConstraint = interface(ISchemaItem)
    ['{50EA08BD-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_selector: WideString; safecall;
    function Get_fields: ISchemaStringCollection; safecall;
    function Get_referencedKey: ISchemaIdentityConstraint; safecall;
    property selector: WideString read Get_selector;
    property fields: ISchemaStringCollection read Get_fields;
    property referencedKey: ISchemaIdentityConstraint read Get_referencedKey;
  end;

// *********************************************************************//
// DispIntf:  ISchemaIdentityConstraintDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BD-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaIdentityConstraintDisp = dispinterface
    ['{50EA08BD-DD1B-4664-9A50-C2F40F4BD79A}']
    property selector: WideString readonly dispid 1470;
    property fields: ISchemaStringCollection readonly dispid 1436;
    property referencedKey: ISchemaIdentityConstraint readonly dispid 1466;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: ISchemaNotation
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BE-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaNotation = interface(ISchemaItem)
    ['{50EA08BE-DD1B-4664-9A50-C2F40F4BD79A}']
    function Get_systemIdentifier: WideString; safecall;
    function Get_publicIdentifier: WideString; safecall;
    property systemIdentifier: WideString read Get_systemIdentifier;
    property publicIdentifier: WideString read Get_publicIdentifier;
  end;

// *********************************************************************//
// DispIntf:  ISchemaNotationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {50EA08BE-DD1B-4664-9A50-C2F40F4BD79A}
// *********************************************************************//
  ISchemaNotationDisp = dispinterface
    ['{50EA08BE-DD1B-4664-9A50-C2F40F4BD79A}']
    property systemIdentifier: WideString readonly dispid 1473;
    property publicIdentifier: WideString readonly dispid 1465;
    property name: WideString readonly dispid 1457;
    property namespaceURI: WideString readonly dispid 1459;
    property schema: ISchema readonly dispid 1467;
    property id: WideString readonly dispid 1440;
    property itemType: SOMITEMTYPE readonly dispid 1446;
    property unhandledAttributes: IVBSAXAttributes readonly dispid 1478;
    function writeAnnotation(const annotationSink: IUnknown): WordBool; dispid 1483;
  end;

// *********************************************************************//
// Interface: IXMLDOMSelection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {AA634FC7-5888-44A7-A257-3A47150D3A0E}
// *********************************************************************//
  IXMLDOMSelection = interface(IXMLDOMNodeList)
    ['{AA634FC7-5888-44A7-A257-3A47150D3A0E}']
    function Get_expr: WideString; safecall;
    procedure Set_expr(const expression: WideString); safecall;
    function Get_context: IXMLDOMNode; safecall;
    procedure _Set_context(const ppNode: IXMLDOMNode); safecall;
    function peekNode: IXMLDOMNode; safecall;
    function matches(const pNode: IXMLDOMNode): IXMLDOMNode; safecall;
    function removeNext: IXMLDOMNode; safecall;
    procedure removeAll; safecall;
    function clone: IXMLDOMSelection; safecall;
    function getProperty(const name: WideString): OleVariant; safecall;
    procedure setProperty(const name: WideString; value: OleVariant); safecall;
    property expr: WideString read Get_expr write Set_expr;
    property context: IXMLDOMNode read Get_context write _Set_context;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMSelectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {AA634FC7-5888-44A7-A257-3A47150D3A0E}
// *********************************************************************//
  IXMLDOMSelectionDisp = dispinterface
    ['{AA634FC7-5888-44A7-A257-3A47150D3A0E}']
    property expr: WideString dispid 81;
    property context: IXMLDOMNode dispid 82;
    function peekNode: IXMLDOMNode; dispid 83;
    function matches(const pNode: IXMLDOMNode): IXMLDOMNode; dispid 84;
    function removeNext: IXMLDOMNode; dispid 85;
    procedure removeAll; dispid 86;
    function clone: IXMLDOMSelection; dispid 87;
    function getProperty(const name: WideString): OleVariant; dispid 88;
    procedure setProperty(const name: WideString; value: OleVariant); dispid 89;
    property item[index: Integer]: IXMLDOMNode readonly dispid 0; default;
    property length: Integer readonly dispid 74;
    function nextNode: IXMLDOMNode; dispid 76;
    procedure reset; dispid 77;
    property _newEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// DispIntf:  XMLDOMDocumentEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3EFAA427-272F-11D2-836F-0000F87A7782}
// *********************************************************************//
  XMLDOMDocumentEvents = dispinterface
    ['{3EFAA427-272F-11D2-836F-0000F87A7782}']
    procedure ondataavailable; dispid 198;
    procedure onreadystatechange; dispid -609;
  end;

// *********************************************************************//
// Interface: IDSOControl
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {310AFA62-0575-11D2-9CA9-0060B0EC3D39}
// *********************************************************************//
  IDSOControl = interface(IDispatch)
    ['{310AFA62-0575-11D2-9CA9-0060B0EC3D39}']
    function Get_XMLDocument: IXMLDOMDocument; safecall;
    procedure Set_XMLDocument(const ppDoc: IXMLDOMDocument); safecall;
    function Get_JavaDSOCompatible: Integer; safecall;
    procedure Set_JavaDSOCompatible(fJavaDSOCompatible: Integer); safecall;
    function Get_readyState: Integer; safecall;
    property XMLDocument: IXMLDOMDocument read Get_XMLDocument write Set_XMLDocument;
    property JavaDSOCompatible: Integer read Get_JavaDSOCompatible write Set_JavaDSOCompatible;
    property readyState: Integer read Get_readyState;
  end;

// *********************************************************************//
// DispIntf:  IDSOControlDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {310AFA62-0575-11D2-9CA9-0060B0EC3D39}
// *********************************************************************//
  IDSOControlDisp = dispinterface
    ['{310AFA62-0575-11D2-9CA9-0060B0EC3D39}']
    property XMLDocument: IXMLDOMDocument dispid 65537;
    property JavaDSOCompatible: Integer dispid 65538;
    property readyState: Integer readonly dispid -525;
  end;

// *********************************************************************//
// Interface: IXMLHTTPRequest
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {ED8C108D-4349-11D2-91A4-00C04F7969E8}
// *********************************************************************//
  IXMLHTTPRequest = interface(IDispatch)
    ['{ED8C108D-4349-11D2-91A4-00C04F7969E8}']
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant;
                   bstrUser: OleVariant; bstrPassword: OleVariant); safecall;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString); safecall;
    function getResponseHeader(const bstrHeader: WideString): WideString; safecall;
    function getAllResponseHeaders: WideString; safecall;
    procedure send(varBody: OleVariant); safecall;
    procedure abort; safecall;
    function Get_status: Integer; safecall;
    function Get_statusText: WideString; safecall;
    function Get_responseXML: IDispatch; safecall;
    function Get_responseText: WideString; safecall;
    function Get_responseBody: OleVariant; safecall;
    function Get_responseStream: OleVariant; safecall;
    function Get_readyState: Integer; safecall;
    procedure Set_onreadystatechange(const Param1: IDispatch); safecall;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  end;

// *********************************************************************//
// DispIntf:  IXMLHTTPRequestDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {ED8C108D-4349-11D2-91A4-00C04F7969E8}
// *********************************************************************//
  IXMLHTTPRequestDisp = dispinterface
    ['{ED8C108D-4349-11D2-91A4-00C04F7969E8}']
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant;
                   bstrUser: OleVariant; bstrPassword: OleVariant); dispid 1;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString); dispid 2;
    function getResponseHeader(const bstrHeader: WideString): WideString; dispid 3;
    function getAllResponseHeaders: WideString; dispid 4;
    procedure send(varBody: OleVariant); dispid 5;
    procedure abort; dispid 6;
    property status: Integer readonly dispid 7;
    property statusText: WideString readonly dispid 8;
    property responseXML: IDispatch readonly dispid 9;
    property responseText: WideString readonly dispid 10;
    property responseBody: OleVariant readonly dispid 11;
    property responseStream: OleVariant readonly dispid 12;
    property readyState: Integer readonly dispid 13;
    property onreadystatechange: IDispatch writeonly dispid 14;
  end;

// *********************************************************************//
// Interface: IServerXMLHTTPRequest
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2E9196BF-13BA-4DD4-91CA-6C571F281495}
// *********************************************************************//
  IServerXMLHTTPRequest = interface(IXMLHTTPRequest)
    ['{2E9196BF-13BA-4DD4-91CA-6C571F281495}']
    procedure setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; sendTimeout: Integer;
                          receiveTimeout: Integer); safecall;
    function waitForResponse(timeoutInSeconds: OleVariant): WordBool; safecall;
    function getOption(option: SERVERXMLHTTP_OPTION): OleVariant; safecall;
    procedure setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant); safecall;
  end;

// *********************************************************************//
// DispIntf:  IServerXMLHTTPRequestDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2E9196BF-13BA-4DD4-91CA-6C571F281495}
// *********************************************************************//
  IServerXMLHTTPRequestDisp = dispinterface
    ['{2E9196BF-13BA-4DD4-91CA-6C571F281495}']
    procedure setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; sendTimeout: Integer;
                          receiveTimeout: Integer); dispid 15;
    function waitForResponse(timeoutInSeconds: OleVariant): WordBool; dispid 16;
    function getOption(option: SERVERXMLHTTP_OPTION): OleVariant; dispid 17;
    procedure setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant); dispid 18;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant;
                   bstrUser: OleVariant; bstrPassword: OleVariant); dispid 1;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString); dispid 2;
    function getResponseHeader(const bstrHeader: WideString): WideString; dispid 3;
    function getAllResponseHeaders: WideString; dispid 4;
    procedure send(varBody: OleVariant); dispid 5;
    procedure abort; dispid 6;
    property status: Integer readonly dispid 7;
    property statusText: WideString readonly dispid 8;
    property responseXML: IDispatch readonly dispid 9;
    property responseText: WideString readonly dispid 10;
    property responseBody: OleVariant readonly dispid 11;
    property responseStream: OleVariant readonly dispid 12;
    property readyState: Integer readonly dispid 13;
    property onreadystatechange: IDispatch writeonly dispid 14;
  end;

// *********************************************************************//
// Interface: IServerXMLHTTPRequest2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2E01311B-C322-4B0A-BD77-B90CFDC8DCE7}
// *********************************************************************//
  IServerXMLHTTPRequest2 = interface(IServerXMLHTTPRequest)
    ['{2E01311B-C322-4B0A-BD77-B90CFDC8DCE7}']
    procedure setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant;
                       varBypassList: OleVariant); safecall;
    procedure setProxyCredentials(const bstrUserName: WideString; const bstrPassword: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IServerXMLHTTPRequest2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2E01311B-C322-4B0A-BD77-B90CFDC8DCE7}
// *********************************************************************//
  IServerXMLHTTPRequest2Disp = dispinterface
    ['{2E01311B-C322-4B0A-BD77-B90CFDC8DCE7}']
    procedure setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant;
                       varBypassList: OleVariant); dispid 19;
    procedure setProxyCredentials(const bstrUserName: WideString; const bstrPassword: WideString); dispid 20;
    procedure setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; sendTimeout: Integer;
                          receiveTimeout: Integer); dispid 15;
    function waitForResponse(timeoutInSeconds: OleVariant): WordBool; dispid 16;
    function getOption(option: SERVERXMLHTTP_OPTION): OleVariant; dispid 17;
    procedure setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant); dispid 18;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant;
                   bstrUser: OleVariant; bstrPassword: OleVariant); dispid 1;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString); dispid 2;
    function getResponseHeader(const bstrHeader: WideString): WideString; dispid 3;
    function getAllResponseHeaders: WideString; dispid 4;
    procedure send(varBody: OleVariant); dispid 5;
    procedure abort; dispid 6;
    property status: Integer readonly dispid 7;
    property statusText: WideString readonly dispid 8;
    property responseXML: IDispatch readonly dispid 9;
    property responseText: WideString readonly dispid 10;
    property responseBody: OleVariant readonly dispid 11;
    property responseStream: OleVariant readonly dispid 12;
    property readyState: Integer readonly dispid 13;
    property onreadystatechange: IDispatch writeonly dispid 14;
  end;

// *********************************************************************//
// Interface: IMXNamespacePrefixes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C90352F4-643C-4FBC-BB23-E996EB2D51FD}
// *********************************************************************//
  IMXNamespacePrefixes = interface(IDispatch)
    ['{C90352F4-643C-4FBC-BB23-E996EB2D51FD}']
    function Get_item(index: Integer): WideString; safecall;
    function Get_length: Integer; safecall;
    function Get__newEnum: IUnknown; safecall;
    property item[index: Integer]: WideString read Get_item; default;
    property length: Integer read Get_length;
    property _newEnum: IUnknown read Get__newEnum;
  end;

// *********************************************************************//
// DispIntf:  IMXNamespacePrefixesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C90352F4-643C-4FBC-BB23-E996EB2D51FD}
// *********************************************************************//
  IMXNamespacePrefixesDisp = dispinterface
    ['{C90352F4-643C-4FBC-BB23-E996EB2D51FD}']
    property item[index: Integer]: WideString readonly dispid 0; default;
    property length: Integer readonly dispid 1416;
    property _newEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: IVBMXNamespaceManager
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C90352F5-643C-4FBC-BB23-E996EB2D51FD}
// *********************************************************************//
  IVBMXNamespaceManager = interface(IDispatch)
    ['{C90352F5-643C-4FBC-BB23-E996EB2D51FD}']
    procedure Set_allowOverride(fOverride: WordBool); safecall;
    function Get_allowOverride: WordBool; safecall;
    procedure reset; safecall;
    procedure pushContext; safecall;
    procedure pushNodeContext(const contextNode: IXMLDOMNode; fDeep: WordBool); safecall;
    procedure popContext; safecall;
    procedure declarePrefix(const prefix: WideString; const namespaceURI: WideString); safecall;
    function getDeclaredPrefixes: IMXNamespacePrefixes; safecall;
    function getPrefixes(const namespaceURI: WideString): IMXNamespacePrefixes; safecall;
    function getURI(const prefix: WideString): OleVariant; safecall;
    function getURIFromNode(const strPrefix: WideString; const contextNode: IXMLDOMNode): OleVariant; safecall;
    property allowOverride: WordBool read Get_allowOverride write Set_allowOverride;
  end;

// *********************************************************************//
// DispIntf:  IVBMXNamespaceManagerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C90352F5-643C-4FBC-BB23-E996EB2D51FD}
// *********************************************************************//
  IVBMXNamespaceManagerDisp = dispinterface
    ['{C90352F5-643C-4FBC-BB23-E996EB2D51FD}']
    property allowOverride: WordBool dispid 1406;
    procedure reset; dispid 1407;
    procedure pushContext; dispid 1408;
    procedure pushNodeContext(const contextNode: IXMLDOMNode; fDeep: WordBool); dispid 1409;
    procedure popContext; dispid 1410;
    procedure declarePrefix(const prefix: WideString; const namespaceURI: WideString); dispid 1411;
    function getDeclaredPrefixes: IMXNamespacePrefixes; dispid 1412;
    function getPrefixes(const namespaceURI: WideString): IMXNamespacePrefixes; dispid 1413;
    function getURI(const prefix: WideString): OleVariant; dispid 1414;
    function getURIFromNode(const strPrefix: WideString; const contextNode: IXMLDOMNode): OleVariant; dispid 1415;
  end;

// *********************************************************************//
// Interface: IMXNamespaceManager
// Flags:     (16) Hidden
// GUID:      {C90352F6-643C-4FBC-BB23-E996EB2D51FD}
// *********************************************************************//
  IMXNamespaceManager = interface(IUnknown)
    ['{C90352F6-643C-4FBC-BB23-E996EB2D51FD}']
    function putAllowOverride(fOverride: WordBool): HResult; stdcall;
    function getAllowOverride(out fOverride: WordBool): HResult; stdcall;
    function reset: HResult; stdcall;
    function pushContext: HResult; stdcall;
    function pushNodeContext(const contextNode: IXMLDOMNode; fDeep: WordBool): HResult; stdcall;
    function popContext: HResult; stdcall;
    function declarePrefix(var prefix: Word; var namespaceURI: Word): HResult; stdcall;
    function getDeclaredPrefix(nIndex: Integer; var pwchPrefix: Word; var pcchPrefix: SYSINT): HResult; stdcall;
    function getPrefix(var pwszNamespaceURI: Word; nIndex: Integer; var pwchPrefix: Word;
                       var pcchPrefix: SYSINT): HResult; stdcall;
    function getURI(var pwchPrefix: Word; const pContextNode: IXMLDOMNode; var pwchUri: Word;
                    var pcchUri: SYSINT): HResult; stdcall;
  end;

implementation

end.
