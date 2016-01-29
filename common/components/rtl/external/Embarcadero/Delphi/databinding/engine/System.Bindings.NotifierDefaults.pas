{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.NotifierDefaults;

interface

uses
  System.SysUtils, System.Classes, System.Rtti, System.Generics.Collections, System.Bindings.Consts,

  System.Bindings.NotifierContracts, System.Bindings.Manager;

type
  { TBindingNotifier

    Default implementor for IBindingNotifier which is used by objects that
    support data binding. }

  TBindingNotifier = class(TInterfacedObject, IBindingNotifier)
  private
    FOwner: TObject;
    FManager: TBindingManager;
    FReserved: TBindingNotifReservedType;
  protected
    function GetOwner: TObject; inline;
    function GetManager: TBindingManager; inline;
    function GetReserved: TBindingNotifReservedType; inline;
    procedure SetReserved(Value: TBindingNotifReservedType); inline;
    procedure SetOwner(Value: TObject); inline;

    procedure Notify(const PropertyName: String); virtual;
  public
    constructor Create(Owner: TObject; Manager: TBindingManager);

    property Owner: TObject read GetOwner write SetOwner;
    property Manager: TBindingManager read GetManager;
    property Reserved: TBindingNotifReservedType read GetReserved write SetReserved;
  end;

  { TBindingNotification

    Default implementor for IBindingNotification which is used to receive
    notifications from bindable objects. It acts like a notification interceptor. }

  TBindingNotification = class abstract(TInterfacedObject, IBindingNotification)
  private
    FOwner: TObject;
  protected
    // binding expressions receive notifications from script objects through here
    procedure Notification(Notifier: IBindingNotifier; const PropertyName: String); virtual; abstract;

    // the object that will actually receive the notification;
    property Owner: TObject read FOwner;
  public
    constructor Create(Owner: TObject);
  end;

implementation

constructor TBindingNotifier.Create(Owner: TObject; Manager: TBindingManager);
begin
  if not Assigned(Owner) then
    raise EBindingNotifyError.Create(sOwnerNotFound);

  inherited Create;

  FOwner := Owner;
  FManager := Manager;
  FReserved := bnrtExternal;
end;

function TBindingNotifier.GetManager: TBindingManager;
begin
  Result := FManager;
end;

function TBindingNotifier.GetOwner: TObject;
begin
  Result := FOwner;
end;

function TBindingNotifier.GetReserved: TBindingNotifReservedType;
begin
  Result := FReserved;
end;

procedure TBindingNotifier.Notify(const PropertyName: String);
var
  BindingNotif: IBindingNotification;
begin
  if Supports(Manager, IBindingNotification, BindingNotif) then
    BindingNotif.Notification(Self, PropertyName)
  else
    raise EBindingNotifyError.Create(sUnsupportedManager);
end;

procedure TBindingNotifier.SetOwner(Value: TObject);
begin
  FOwner := Value;
end;

procedure TBindingNotifier.SetReserved(Value: TBindingNotifReservedType);
begin
  FReserved := Value;
end;

{ TBindingNotification }

constructor TBindingNotification.Create(Owner: TObject);
begin
  inherited Create;

  if not Assigned(Owner) then
    raise EBindingNotifyError.Create(sOwnerNotFound);

  FOwner := Owner;
end;

end.
