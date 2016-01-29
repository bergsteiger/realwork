{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.WebNode;

interface

uses
  System.Classes, Soap.IntfInfo, Soap.SOAPAttachIntf;

type
  WebNodeOption = (wnoSOAP12);

  WebNodeOptions = set of WebNodeOption;

  { IWebNode defines the basic interface to be implemented by any
    SOAP Transport. IOW, if you want to implement SOAP on SMTP,
    plain Socket, etc - you'll have to create a RIO that implements
    IWebNode.
    See THTTPRIO and TLinkedRIO for examples }
  IWebNode = interface
  ['{77DB2644-0C12-4C0A-920E-89579DB9CC16}']
    { Obsolete - use version that takes a Stream as first parameter }
    procedure Execute(const DataMsg: String; Response: TStream); overload; deprecated;
    procedure BeforeExecute(const IntfMD: TIntfMetaData;
                            const MethMD: TIntfMethEntry;
                            MethodIndex: Integer;
                            AttachHandler: IMimeAttachmentHandler);

    procedure Execute(const Request: TStream; Response: TStream); overload;
    function  Execute(const Request: TStream): TStream; overload;

    { Transport Attributes exposed in a generic fashion so that Converter
      can break apart a multipart/related packet }
{$IFDEF NEXTGEN}
    function  GetMimeBoundary: string;
    procedure SetMimeBoundary(const Value: string);
{$ELSE !NEXTGEN}
    function  GetMimeBoundary: AnsiString;
    procedure SetMimeBoundary(const Value: AnsiString);
{$ENDIF NEXTGEN}

    function  GetWebNodeOptions: WebNodeOptions;
    procedure SetWebNodeOptions(Value: WebNodeOptions);

{$IFDEF NEXTGEN}
    property  MimeBoundary: string read GetMimeBoundary write SetMimeBoundary;
{$ELSE !NEXTGEN}
    property  MimeBoundary: AnsiString read GetMimeBoundary write SetMimeBoundary;
{$ENDIF NEXTGEN}

    property Options: WebNodeOptions read GetWebNodeOptions write SetWebNodeOptions;
  end;

implementation

end.
