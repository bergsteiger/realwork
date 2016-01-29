{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.NotifierContracts;

interface

uses
  System.SysUtils, System.Generics.Collections,

  System.Bindings.Manager;

type
  EBindingNotifyError = class(Exception);

  IBindingNotifier = interface;

  TBindingNotifReservedType = (bnrtExternal, bnrtInternal);

  /// <summary>
  /// Anyone who is interested in receiving notifications from an object about
  /// changes that happen in the properties of the object must implement this
  /// interface. </summary>
  IBindingNotification = interface
  ['{83360F64-6260-4029-96B3-070FB253F075}']
    procedure Notification(Notifier: IBindingNotifier; const PropertyName: String);
  end;

  /// <summary>
  /// Used by bindable objects to notify the expressions in which they are present
  /// about the changes of one of their properties.</summary>
  IBindingNotifier = interface
  ['{767FC59A-C8D9-4810-9A9E-B7648706F0B6}']
    function GetOwner: TObject;
    function GetManager: TBindingManager;
    function GetReserved: TBindingNotifReservedType;
    procedure SetReserved(Value: TBindingNotifReservedType);
    procedure SetOwner(Value: TObject);

    // notifies all the Expressions that the value of PropertyName has changed
    procedure Notify(const PropertyName: String);

    property Owner: TObject read GetOwner write SetOwner;
    property Manager: TBindingManager read GetManager;
    // used internally; never change the value of this property as a user
    property Reserved: TBindingNotifReservedType read GetReserved write SetReserved;
  end;

implementation

end.
