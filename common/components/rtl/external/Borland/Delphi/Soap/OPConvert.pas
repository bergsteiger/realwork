{*******************************************************}
{                                                       }
{ Borland Delphi Visual Component Library               }
{                 SOAP Support                          }
{                                                       }
{ Copyright (c) 2001 Borland Software Corporation       }
{                                                       }
{*******************************************************}

unit OPConvert;

interface

uses IntfInfo, InvokeRegistry, SysUtils, Classes, XMLIntf, SOAPAttachIntf, Contnrs;

type

  { Various options that control how data is [de]serialized. }
  TSOAPConvertOption = (soSendUntyped,              { Skip "xsi:type="xxx:xxxx" attribute }
                        soSendMultiRefObj,          { Use HREF/ID for remotable types     }
                        soSendMultiRefArray,        { Use HREF/ID for arrays              }
                        soTryAllSchema,             { Allow 1999/2010/2001 mixing         }
                        soRootRefNodesToBody,       { HREF/ID nodes are siblings          }
                        soDocument,                 { Don't use sec. 5 Encoding           }
                        soReturnSuccessForFault,    { Don't set statuscode 500 upon error }
                        soUTF8InHeader,             { Put charset="UTF-8" in header       }
                        soDontSendEmptyNodes,       { Skip empty string/array & nil object nodes }
                        soCacheMimeResponse,        { Cache Mime Response to Disk - HACK  }
                        soDontClearOutBoundHeaders, { Outbound headers are not cleared -  Client only!! }
                        soCustomFaultAtDetailsNode, { Outbound faults are at <details> instead of child of <details> }
                        soLiteralParams,            { We re serializing Literal parameters - they we not unwound }
                        soUTF8EncodeXML,            { uTF8Encode XML packet }
                        soXXXXHdr);

  TSOAPConvertOptions = set of TSOAPConvertOption;

  IOPConvert = interface
  ['{1F955FE3-890B-474C-A3A4-5E072D30CC4F}']
    { Property Accessors }
    function  GetOptions: TSOAPConvertOptions;
    procedure SetOptions(const Value: TSOAPConvertOptions);
    function  GetAttachments: TSoapDataList;
    procedure SetAttachments(Value: TSoapDataList);
    function  GetTempDir: string;
    procedure SetTempDir(const Value: string);
    function  GetEncoding: WideString;
    procedure SetEncoding(const Encoding: WideString);

    { client methods }
    function InvContextToMsg(const IntfMD: TIntfMetaData;
                             MethNum: Integer;
                             Con: TInvContext;
                             Headers: THeaderList): TStream;
    procedure ProcessResponse(const Resp: TStream;
                              const IntfMD: TIntfMetaData;
                              const MD: TIntfMethEntry;
                              Context: TInvContext;
                              Headers: THeaderList);  overload;
    { Obsolete - use version that takes a stream as first parameter }
    procedure ProcessResponse(const Resp: InvString;
                              const IntfMD: TIntfMetaData;
                              const MD: TIntfMethEntry;
                              Context: TInvContext); overload; deprecated;

    { server methods }
    procedure MsgToInvContext(const Request: InvString;
                              const IntfMD: TIntfMetaData;
                              var MethNum: Integer;
                              Context: TInvContext); overload;
    procedure MsgToInvContext(const Request: TStream;
                              const IntfMD: TIntfMetaData;
                              var MethNum: Integer;
                              Context: TInvContext;
                              Headers: THeaderList);  overload;
    procedure MakeResponse(const IntfMD: TIntfMetaData;
                              const MethNum: Integer;
                              Context: TInvContext;
                              Response: TStream;
                              Headers: THeaderList);
    procedure MakeFault(const Ex: Exception; EStream: TStream);

    property Attachments:  TSoapDataList read GetAttachments write SetAttachments;
    property Options:  TSOAPConvertOptions read GetOptions write SetOptions;
    property TempDir: string read GetTempDir write SetTempDir;
    property Encoding: WideString read GetEncoding write SetEncoding;
  end;


implementation

end.
