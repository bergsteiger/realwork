{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Messages;

{$MINENUMSIZE 4}
{$H+}

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type
  { Base class for all messages }
  TMessage = class abstract
  end;

  TMessageListener = reference to procedure(const Sender : TObject; const M : TMessage);
  TMessageListenerMethod = procedure (const Sender : TObject; const M : TMessage) of object;

  { TMessageManager can have many independent instances, but it
    maintains one global instnace accessible by TMessageManager.DefaultManager }
  TMessageManager = class
  protected
  type
    TListenerWithId = record
      Id : Integer;
      Listener : TMessageListener;
      ListenerMethod : TMessageListenerMethod;
    end;
    TListenerRegistry = TDictionary<TClass,TDictionary<Integer,TListenerWithId>>;
  private
    FListeners : TListenerRegistry;
    FLastId : Integer;

    { Global instance }
    class var FDefaultManager : TMessageManager;
    class function GetDefaultManager : TMessageManager; static;
  public
    constructor Create;
    destructor Destroy; override;
    class procedure UnInitialize;

    procedure RegisterMessageClass(const AMessageClass : TClass);

    function SubscribeToMessage(
                  const AMessageClass : TClass;
                  const AListener : TMessageListener) : Integer; overload;

    function SubscribeToMessage(
                  const AMessageClass : TClass;
                  const AListenerMethod : TMessageListenerMethod) : Integer; overload;

    procedure Unsubscribe(const AMessageClass : TClass; Id : Integer); overload;
    procedure Unsubscribe(const AMessageClass : TClass;
                  const AListener : TMessageListener); overload;
    procedure Unsubscribe(const AMessageClass : TClass;
                  const AListenerMethod : TMessageListenerMethod); overload;

    procedure SendMessage(const Sender: TObject; AMessage : TMessage); overload;
    procedure SendMessage(const Sender: TObject; AMessage : TMessage;
                  ADispose : Boolean); overload;

    class property DefaultManager : TMessageManager read GetDefaultManager;
  end;

implementation

uses System.Types;

{ TMessageManager }

constructor TMessageManager.Create;
begin
  FListeners := TListenerRegistry.Create;
  FLastId := 1;
end;

destructor TMessageManager.Destroy;
var
  L : TDictionary<Integer, TListenerWithId>;
  O : TObject;
begin
  for L in FListeners.Values do
  begin
    O := TObject(L);
    FreeAndNil(O);
  end;

  FreeAndNil(FListeners);
  inherited;
end;

class function TMessageManager.GetDefaultManager: TMessageManager;
begin
  if not Assigned(FDefaultManager) then
    FDefaultManager := TMessageManager.Create;

  Result := FDefaultManager;
end;

class procedure TMessageManager.UnInitialize;
begin
  FreeAndNil(FDefaultManager);
end;



procedure TMessageManager.RegisterMessageClass(const AMessageClass: TClass);
begin
  if not FListeners.ContainsKey(AMessageClass) then
  begin
    FListeners.Add(AMessageClass, TDictionary<Integer, TListenerWithId>.Create);
  end;
end;

function TMessageManager.SubscribeToMessage(
                              const AMessageClass: TClass;
                              const AListener: TMessageListener) : Integer;
var
  L : TListenerWithId;
  Subscribers: TDictionary<Integer, TListenerWithId>;
begin
  Result := -1;
  RegisterMessageClass(AMessageClass);
  if FListeners.TryGetValue(AMessageClass, Subscribers) then
  begin
    L.Listener := AListener;
    L.ListenerMethod := nil;
    Inc(FLastId);
    L.Id := FLastId;
    Result := L.Id;
    Subscribers.Add(L.Id, L);
  end;
end;

function TMessageManager.SubscribeToMessage(const AMessageClass: TClass;
  const AListenerMethod: TMessageListenerMethod): Integer;
var
  L : TListenerWithId;
  Subscribers: TDictionary<Integer, TListenerWithId>;
begin
  Result := -1;
  RegisterMessageClass(AMessageClass);
  if FListeners.TryGetValue(AMessageClass, Subscribers) then
  begin
    L.Listener := nil;
    L.ListenerMethod := AListenerMethod;
    Inc(FLastId);
    L.Id := FLastId;
    Result := L.Id;
    Subscribers.Add(L.Id, L);
  end;
end;

procedure TMessageManager.Unsubscribe(const AMessageClass: TClass;
  const AListener: TMessageListener);
var
  L : TListenerWithId;
  Subscribers: TDictionary<Integer, TListenerWithId>;
begin
  if FListeners.TryGetValue(AMessageClass, Subscribers) then
    for L in Subscribers.Values do
      if @L.Listener = @AListener then
      begin
        Subscribers.Remove(L.Id);
        break;
      end;
end;

procedure TMessageManager.Unsubscribe(const AMessageClass: TClass;
  const AListenerMethod: TMessageListenerMethod);
var
  L : TListenerWithId;
  Subscribers: TDictionary<Integer, TListenerWithId>;
begin
  if FListeners.TryGetValue(AMessageClass, Subscribers) then
    for L in Subscribers.Values do
      if (TMethod(L.ListenerMethod).Code = TMethod(AListenerMethod).Code)
        and ((TMethod(L.ListenerMethod).Data = TMethod(AListenerMethod).Data)) then
      begin
        Subscribers.Remove(L.Id);
        Break;
      end;
end;

procedure TMessageManager.Unsubscribe(const AMessageClass: TClass; Id: Integer);
var
  Subscribers: TDictionary<Integer, TListenerWithId>;
begin
  if FListeners.TryGetValue(AMessageClass, Subscribers) then
    Subscribers.Remove(Id);
end;

procedure TMessageManager.SendMessage(const Sender: TObject; AMessage: TMessage;
  ADispose: Boolean);
var
  L : TListenerWithId;
  Subscribers: TDictionary<Integer, TListenerWithId>;
begin
  try
    if FListeners.TryGetValue(AMessage.ClassType, Subscribers) then
      for L in Subscribers.Values do
      begin
        if Assigned(L.Listener) then
          L.Listener(Sender, AMessage)
        else
        if Assigned(L.ListenerMethod) then
          L.ListenerMethod(Sender, AMessage);
      end;
  finally
    if ADispose then
      AMessage.Free;
  end;
end;

procedure TMessageManager.SendMessage(const Sender: TObject; AMessage: TMessage);
begin
  SendMessage(Sender, AMessage, True);
end;

initialization
finalization
  TMessageManager.UnInitialize;
end.
