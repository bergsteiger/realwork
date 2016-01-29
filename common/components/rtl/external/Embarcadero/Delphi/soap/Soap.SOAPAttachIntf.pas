{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{         SOAP Attachment Interfaces                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}
unit Soap.SOAPAttachIntf;

interface

uses
 System.Classes, System.Generics.Collections, Soap.InvokeRegistry;

{ $WARN SYMBOL_DEPRECATED OFF}
type
  TSoapDataList = class(TList<TSoapAttachment>)
  public
//    procedure Clear; override;
    function Add(Item: TSoapAttachment): Integer; reintroduce;
    procedure Assign(ListA: TList<TSoapAttachment>; AOperator: TListAssignOp = laCopy;
                     ListB: TList<TSoapAttachment> = Nil); reintroduce;
    procedure Insert(Index: Integer; aClass: TClass); reintroduce;
    function Remove(aClass: TClass): Integer; reintroduce;
  end;

  TOnSendAttachmentEvent = procedure(AttachmentStream: TStream; Attachment: TSOAPAttachment) of object;
  TOnGetAttachmentEvent = procedure(AttachmentStream: TStream; Attachment: TSOAPAttachment) of object;

  IMimeAttachmentHandler = interface
  ['{6B742425-FE6A-4EC2-ACF9-4751AF4E0EF8}']
  procedure ProcessMultiPartForm(const ASourceStream, ADestStream: TStream;
{$IFDEF NEXTGEN}
                                 const AMimeBoundary: string;
{$ELSE !NEXTGEN}
                                 const AMimeBoundary: AnsiString;
{$ENDIF NEXTGEN}
                                 SoapHeaders: TStrings;
                                 Attachments: TSoapDataList;
                                 const TempDir: string);

    { Add a new Soap Header  }
    procedure AddSoapHeader(Value: string);
    procedure CreateMimeStream(Envelope: TStream; Attachments: TSoapDataList);
    { combine MimeBoundary, Soap Headers and Envelope, and Attachments into single Stream }
    procedure FinalizeStream;

    function  GetMIMEStream(Release: Boolean = False): TStream;
{$IFDEF NEXTGEN}
    function  GetMIMEBoundary: string;
    procedure SetMIMEBoundary(const MimeBndry: string);
{$ELSE !NEXTGEN}
    function  GetMIMEBoundary: AnsiString;
    procedure SetMIMEBoundary(const MimeBndry: AnsiString);
{$ENDIF NEXTGEN}
    function  GetOnSendAttachmentEvent: TOnSendAttachmentEvent;
    procedure SetOnSendAttachmentEvent(OnSendAttachment: TOnSendAttachmentEvent);
    function  GetOnGetAttachmentEvent: TOnGetAttachmentEvent;
    procedure SetOnGetAttachmentEvent(OnGetAttachment: TOnGetAttachmentEvent);

{$IFDEF NEXTGEN}
    property MIMEBoundary: string read GetMimeBoundary write SetMimeBoundary;
{$ELSE !NEXTGEN}
    property MIMEBoundary: AnsiString read GetMimeBoundary write SetMimeBoundary;
{$ENDIF NEXTGEN}
    property OnSendAttachment: TOnSendAttachmentEvent read GetOnSendAttachmentEvent write SetOnSendAttachmentEvent;
    property OnGetAttachment: TOnGetAttachmentEvent read GetOnGetAttachmentEvent write SetOnGetAttachmentEvent;
  end;


implementation

uses
  System.SysUtils, Soap.SOAPConst;

//procedure TSoapDataList.Clear;
//var
//  I: Integer;
//begin
//  for I := 0 to Count -1 do
//    TSOAPAttachmentData(Items[I]).Free;
//  inherited Clear;
//end;

procedure TSoapDataList.Assign(ListA: TList<TSoapAttachment>; AOperator: TListAssignOp = laCopy;
                               ListB: TList<TSoapAttachment> = Nil);
begin
  raise Exception.CreateRes(@SInvalidMethod);
end;

function TSoapDataList.Add(Item: TSoapAttachment): Integer;
begin
  Result := inherited Add(Item);
end;

procedure TSoapDataList.Insert(Index: Integer; aClass: TClass);
begin
  raise Exception.CreateRes(@SInvalidMethod);
end;

function TSoapDataList.Remove(aClass: TClass): Integer;
begin
  raise Exception.CreateRes(@SInvalidMethod);
end;



end.
