{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
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
    function  GetMimeBoundary: string;
    procedure SetMimeBoundary(const Value: string);

    function  GetWebNodeOptions: WebNodeOptions;
    procedure SetWebNodeOptions(Value: WebNodeOptions);

    property  MimeBoundary: string read GetMimeBoundary write SetMimeBoundary;

    property Options: WebNodeOptions read GetWebNodeOptions write SetWebNodeOptions;
  end;

implementation

end.
