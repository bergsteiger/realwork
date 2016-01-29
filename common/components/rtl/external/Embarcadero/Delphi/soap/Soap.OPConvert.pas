{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                 SOAP Support                          }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.OPConvert;

{$INCLUDE 'CompVer.inc'}

interface

uses
  System.Classes, System.SysUtils, Soap.IntfInfo, Soap.InvokeRegistry,
  Soap.OpConvertOptions, Soap.SOAPAttachIntf, Xml.xmldom;

type
  //Note: If you have to use one of the enumerated values in TSOAPConvertOption
  //      you must add OpConvertOptions to your uses clause.
  TSOAPConvertOption = Soap.OpConvertOptions.TSOAPConvertOption;
  TSOAPConvertOptions = Soap.OpConvertOptions.TSOAPConvertOptions;

  IOPConvert = interface
  ['{1F955FE3-890B-474C-A3A4-5E072D30CC4F}']
    { Property Accessors }
    function  GetOptions: TSOAPConvertOptions;
    procedure SetOptions(const Value: TSOAPConvertOptions);
    function  GetAttachments: TSoapDataList;
    procedure SetAttachments(Value: TSoapDataList);
    function  GetTempDir: string;
    procedure SetTempDir(const Value: string);
    function  GetEncoding: DOMString;
    procedure SetEncoding(const Encoding: DOMString);

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
    property Encoding: DOMString read GetEncoding write SetEncoding;
  end;


implementation

end.

