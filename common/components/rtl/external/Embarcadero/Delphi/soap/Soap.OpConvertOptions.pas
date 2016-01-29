{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.OpConvertOptions;

interface

type
  { Various options that control how data is [de]serialized. }
  TSOAPConvertOption = (soSendUntyped,              { Skip "xsi:type="xxx:xxxx" attribute }
                        soSendMultiRefObj,          { Use HREF/ID for remotable types     }
                        soSendMultiRefArray,        { Use HREF/ID for arrays              }
                        soTryAllSchema,             { Allow 1999/2010/2001 mixing         }
                        soRootRefNodesToBody,       { HREF/ID nodes are siblings          }
                        soDocument,                 { Don't use sect5 Encoding; use Literal/XML encoding }
                        soReturnSuccessForFault,    { Don't set statuscode 500 upon error }
                        soUTF8InHeader,             { Put charset="UTF-8" in header       }
                        soDontSendEmptyNodes,       { Skip empty string/array & nil object nodes }
                        soCacheMimeResponse,        { Cache Mime Response to Disk - HACK  }
                        soDontClearOutBoundHeaders, { Outbound headers are not cleared -  Client only!! }
                        soCustomFaultAtDetailsNode, { Outbound faults are at <details> instead of child of <details> }
                        soLiteralParams,            { There were no wrapper elements for this service; it's bare }
                        soUTF8EncodeXML,            { UTF8Encode XML - Deprecated as XMLDom can handle this via the 'Encoding' property}
                        soXXXXHdr,                  { Flag used by runtime to indicate that we're writing a header }
                        soFormElementUnqualifed,    { Local elements are unqualifed }
                        soSOAP12,                   { Use SOAP v1.2 encoding rules }
                        soDontSendVarArrayType      { Don't set VarArrayType attribute when serializing VariantArrays }
                        );

  TSOAPConvertOptions = set of TSOAPConvertOption;

implementation

end.
