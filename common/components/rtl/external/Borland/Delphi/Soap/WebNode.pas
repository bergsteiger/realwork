{***************************************************************}
{                                                               }
{   Borland Delphi Visual Component Library                     }
{                                                               }
{   Copyright (c) 2000-2001 Borland Software Corporation        }
{                                                               }
{***************************************************************}

unit WebNode;

interface

uses Classes, IntfInfo, WSDLIntf, SOAPAttachIntf;

type



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
    procedure SetMimeBoundary(Value: string);
    property  MimeBoundary: string read GetMimeBoundary write SetMimeBoundary;
  end;


implementation

end.
