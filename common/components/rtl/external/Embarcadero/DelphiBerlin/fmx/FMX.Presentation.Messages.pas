{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Presentation.Messages;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes;

type

{ TMessageSender }

  /// <summary>ID of message</summary>
  TMessageID = Word;

  /// <summary>Record type that represents a message with value for <c>TMessageSender</c>.</summary>
  TDispatchMessageWithValue<T> = record
    MsgID: TMessageID;
    Value: T;
  public
    constructor Create(const AMessageID: TMessageID; const AValue: T);
  end;

  /// <summary>Class to allow sending message notifications to a TObject <c>Receiver</c>.</summary>
  TMessageSender = class(TPersistent)
  private
    FReceiver: TObject;
    FNeedFreeReceiver: Boolean;
    FCanNotify: Integer;
    procedure SetReceiver(const Value: TObject);
  protected
    /// <summary>Creates and returns the Receiver object of the message. By default returns nil.</summary>
    function CreateReceiver: TObject; virtual;
    /// <summary>Frees the Receiver, if receiver was created by <c>CreateReceiver</c>.</summary>
    procedure FreeReceiver; virtual;
  public
    constructor Create; overload; virtual;
    destructor Destroy; override;
    /// <summary>Returns whether <c>TMessageSender</c> has a Receiver or not.</summary>
    function HasReceiver: Boolean;
    { Sending Messages }
    /// <summary>Sends a message to an object.</summary>
    procedure SendMessage(const AMessageID: TMessageID); overload;
    /// <summary>Sends a message with value to an object.</summary>
    procedure SendMessage<T>(const AMessageID: TMessageID; const AValue: T); overload;
    /// <summary>Sends a message with value to an object and allows to get result from <c>Receiver</c>.</summary>
    procedure SendMessageWithResult<T>(const AMessageID: TMessageID; var AValue: T);
    { Notifications }
    /// <summary>Disables <c>TMessageSender</c> from sending messages.</summary>
    procedure DisableNotify; virtual;
    /// <summary>Enables <c>TMessageSender</c> to send messages. Use CanNotify to check whether TMessageSender can send
    /// messages.</summary>
    /// <remarks>The model reads quantity of calls of <c>DisableNotify</c>. So all calls of <c>DisableNotify</c> and
    /// <c>EnableNotify</c>shall be pairs.</remarks>
    procedure EnableNotify; virtual;
    /// <summary>Returns whether <c>TMessageSender</c> can send messages.</summary>
    function CanNotify: Boolean; virtual;
  public
    /// <summary>Returns the object that receives the message.</summary>
    property Receiver: TObject read FReceiver write SetReceiver;
  end;

  /// <summary>Interface allows access to TMessageSender object</summary>
  IMessageSender = interface
  ['{64DD751B-91F5-4767-994F-2787E21ABEF2}']
    /// <summary>Return link to TMessageSender object</summary>
    function GetMessageSender: TMessageSender;
    /// <summary>Link to TMessageSender object that can be used to send messages</summary>
    property MessageSender: TMessageSender read GetMessageSender;
  end;

implementation

uses
  System.SysUtils;

{ TMessageSender }

function TMessageSender.CanNotify: Boolean;
begin
  Result := FCanNotify = 0;
end;

constructor TMessageSender.Create;
begin
  inherited;
  FReceiver := CreateReceiver;
  FNeedFreeReceiver := FReceiver <> nil;
end;

function TMessageSender.CreateReceiver: TObject;
begin
  Result := nil
end;

destructor TMessageSender.Destroy;
begin
  FreeReceiver;
  FReceiver := nil;
  inherited;
end;

procedure TMessageSender.DisableNotify;
begin
  Inc(FCanNotify);
end;

procedure TMessageSender.EnableNotify;
begin
  if FCanNotify > 0 then
    Dec(FCanNotify);
end;

function TMessageSender.HasReceiver: Boolean;
begin
  Result := FReceiver <> nil;
end;

procedure TMessageSender.FreeReceiver;
begin
  if HasReceiver and FNeedFreeReceiver then
    FreeAndNil(FReceiver);
end;

procedure TMessageSender.SendMessage(const AMessageID: TMessageID);
var
  Message: TDispatchMessage;
begin
  if HasReceiver and CanNotify then
  begin
    Message.MsgID := AMessageID;
    Receiver.Dispatch(Message);
  end;
end;

procedure TMessageSender.SendMessage<T>(const AMessageID: TMessageID; const AValue: T);
var
  Message: TDispatchMessageWithValue<T>;
begin
  if HasReceiver and CanNotify then
  begin
    Message := TDispatchMessageWithValue<T>.Create(AMessageID, AValue);
    Receiver.Dispatch(Message);
  end;
end;

procedure TMessageSender.SendMessageWithResult<T>(const AMessageID: TMessageID; var AValue: T);
var
  Message: TDispatchMessageWithValue<T>;
begin
  if HasReceiver and CanNotify then
  begin
    Message := TDispatchMessageWithValue<T>.Create(AMessageID, AValue);
    Receiver.Dispatch(Message);
    AValue := Message.Value;
  end;
end;

procedure TMessageSender.SetReceiver(const Value: TObject);
begin
  FreeReceiver;
  FReceiver := Value;
  FNeedFreeReceiver := False;
end;

{ TDispatchMessageWithValue<T> }

constructor TDispatchMessageWithValue<T>.Create(const AMessageID: TMessageID; const AValue: T);
begin
  MsgID := AMessageID;
  Value := AValue;
end;

end.
