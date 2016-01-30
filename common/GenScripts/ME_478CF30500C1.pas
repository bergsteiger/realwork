unit Classes;
 {* Реализация модуля Classes. }

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Rtl\Common\Classes.pas"
// Стереотип: "UtilityPack"

interface

uses
 l3IntfUses
 , Messages
 , ActiveX
 , SysUtils
;

type
 TFiler = class(TObject)
 end;//TFiler

 TPersistent = class(TObject)
  protected
   procedure DefineProperties(Filer: TFiler); virtual;
   function GetNamePath: String; virtual;
   procedure AssignTo(Dest: TPersistent); virtual;
   function GetOwner: TPersistent; virtual;
  public
   procedure Assign(Source: TPersistent); virtual;
 end;//TPersistent

 TComponentName = ;

 TWndMethod = procedure(var Message: TMessage) of object;

 TBiDiMode = (
 );//TBiDiMode

 TSeekOrigin = (
  {* TStream seek origins }
  soBeginning
  , soCurrent
  , soEnd
 );//TSeekOrigin

 TStrings = class(TPersistent)
  {* TStrings is the base class for objects that represent a list of strings. }
  protected
   function Get(Index: Integer): String; virtual; abstract;
   procedure Put(Index: Integer;
    const S: String); virtual; abstract;
   function GetCount: Integer; virtual; abstract;
   function GetObject(Index: Integer): TObject; virtual;
   procedure PutObject(Index: Integer;
    AObject: TObject); virtual;
  public
   procedure Clear; virtual; abstract;
   procedure Insert(Index: Integer;
    const S: String); virtual; abstract;
 end;//TStrings

 TOperation = (
  opInsert
  , opRemove
 );//TOperation

 TList = class(TObject)
  {* TList stores an array of pointers. }
 end;//TList

 TStringList = class(TStrings)
  {* TStringList maintains a list of strings. }
  protected
   function Get(Index: Integer): String; override;
   procedure Put(Index: Integer;
    const S: String); override;
   function GetCount: Integer; override;
  public
   procedure Clear; override;
   procedure Insert(Index: Integer;
    const S: String); override;
 end;//TStringList

 TInterfaceList = class(TInterfacedObject)
  {* TInterfaceList represents a list of interfaces. }
 end;//TInterfaceList

 TDuplicates = (
  dupIgnore
  , dupAccept
  , dupError
 );//TDuplicates

 TStreamAdapter = class(TInterfacedObject, IStream)
  {* TStreamAdapter implements the IStream interface on a TStream object. }
 end;//TStreamAdapter

 TStream = class(TObject)
  {* TStream is the base class type for stream objects that can read from or write to various kinds of storage media, such as disk files, dynamic memory, and so on }
  protected
   procedure SetSize(const NewSize: Int64); virtual;
  public
   function Read(var Buffer;
    Count: Integer): Integer; virtual; abstract;
   function Write(Buffer;
    Count: Integer): Integer; virtual; abstract;
   function Seek(Offset: Integer;
    Origin: Word): Integer; overload; virtual;
   function Seek(const Offset: Int64;
    Origin: TSeekOrigin): Int64; overload; virtual;
 end;//TStream

 TCustomMemoryStream = {abstract} class(TStream)
  {* TCustomMemoryStream is an abstract base class used as the common ancestor for memory streams }
  public
   function Read(var Buffer;
    Count: Integer): Integer; override;
   function Write(Buffer;
    Count: Integer): Integer; override;
 end;//TCustomMemoryStream

 TWriter = class(TObject)
 end;//TWriter

 TStream = class(TObject)
  {* Поток. }
 end;//TStream

 TPersistent = class(TObject)
 end;//TPersistent

 TComponent = class(TPersistent)
 end;//TComponent

 TStrings = class(TPersistent)
  {* Список строк. }
 end;//TStrings

 TInterfacedPersistent = class(TPersistent)
  {* TInterfacedPersistent is an ancestor for persistent objects that implement interfaces. }
 end;//TInterfacedPersistent

 TThread = class(TObject)
  {* TThread is an abstract class that enables creation of separate threads of execution in an application. }
  protected
   procedure Execute; virtual; abstract;
 end;//TThread

 TMemoryStream = class(TCustomMemoryStream)
  {* TMemoryStream is a stream that stores its data in dynamic memory. }
 end;//TMemoryStream

 TShiftState = (
  ssShift
  , ssAlt
  , ssCtrl
  , ssLeft
  , ssRight
  , ssMiddle
  , ssDouble
 );//TShiftState

 TShortCut =  .. ;

 TAlignment = (
 );//TAlignment

 EListError = class(Exception)
 end;//EListError

 TNotifyEvent = procedure(Sender: TObject) of object;
  {* TNotifyEvent is used for events that do not require parameters. }

 EStreamError = class
 end;//EStreamError

 EFCreateError = class
 end;//EFCreateError

 TComponent = class(TPersistent)
  {* TComponent is the common ancestor of all component classes. }
  protected
   procedure Notification(AComponent: TComponent;
    Operation: TOperation); virtual;
   procedure WriteState(Writer: TWriter); virtual;
   procedure SetName(const aValue: TComponentName); virtual;
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; stdcall; virtual;
   procedure Loaded; virtual;
  public
   constructor Create(AOwner: TComponent); reintroduce; virtual;
 end;//TComponent

 TDataModule = class(TComponent)
 end;//TDataModule

 TCollection = class;

 TCollectionItem = class(TPersistent)
  protected
   procedure SetIndex(Value: Integer); virtual;
   function GetDisplayName: String; virtual;
  public
   constructor Create(aCollection: TCollection); reintroduce; virtual;
 end;//TCollectionItem

 TCollectionNotification = (
 );//TCollectionNotification

 TCollection = class(TPersistent)
  protected
   procedure Notify(Item: TCollectionItem;
    Action: TCollectionNotification); virtual;
   function GetAttrCount: Integer; virtual;
   function GetAttr(Index: Integer): AnsiString; virtual;
   function GetItemAttr(Index: Integer;
    ItemIndex: Integer): AnsiString; virtual;
 end;//TCollection

 TCollectionItemClass = class of TCollectionItem;

 TInterfacedPersistent = class(TPersistent)
  {* TInterfacedPersistent is an ancestor for persistent objects that implement interfaces. }
 end;//TInterfacedPersistent

 TBasicAction = class(TComponent)
 end;//TBasicAction

 TOwnedCollection = class(TCollection)
 end;//TOwnedCollection

 TThread = class(TObject)
  protected
   procedure Execute; virtual; abstract;
 end;//TThread

 THelpContext = ;

 THelpType = ;

 TBasicActionLink = class(TObject)
  protected
   procedure AssignClient(AClient: TObject); virtual;
 end;//TBasicActionLink

 EParserError = class
 end;//EParserError

 EReadError = class(Exception)
 end;//EReadError

procedure Rect;
procedure AllocateHWnd(Mathod: TWndMethod);

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , ComponentsProcessingPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure Rect;
//#UC START# *4CB722C101EB_478CF30500C1_var*
//#UC END# *4CB722C101EB_478CF30500C1_var*
begin
//#UC START# *4CB722C101EB_478CF30500C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CB722C101EB_478CF30500C1_impl*
end;//Rect

procedure AllocateHWnd(Mathod: TWndMethod);
//#UC START# *549BCFD20030_478CF30500C1_var*
//#UC END# *549BCFD20030_478CF30500C1_var*
begin
//#UC START# *549BCFD20030_478CF30500C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *549BCFD20030_478CF30500C1_impl*
end;//AllocateHWnd

procedure TPersistent.DefineProperties(Filer: TFiler);
//#UC START# *4FD08EF002D0_478CF32A03B6_var*
//#UC END# *4FD08EF002D0_478CF32A03B6_var*
begin
//#UC START# *4FD08EF002D0_478CF32A03B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD08EF002D0_478CF32A03B6_impl*
end;//TPersistent.DefineProperties

function TPersistent.GetNamePath: String;
//#UC START# *55CCBC12038F_478CF32A03B6_var*
//#UC END# *55CCBC12038F_478CF32A03B6_var*
begin
//#UC START# *55CCBC12038F_478CF32A03B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CCBC12038F_478CF32A03B6_impl*
end;//TPersistent.GetNamePath

procedure TPersistent.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_478CF32A03B6_var*
//#UC END# *478CF34E02CE_478CF32A03B6_var*
begin
//#UC START# *478CF34E02CE_478CF32A03B6_impl*
 assert(false, 'TPersistent.Assign not implemented');
//#UC END# *478CF34E02CE_478CF32A03B6_impl*
end;//TPersistent.Assign

procedure TPersistent.AssignTo(Dest: TPersistent);
//#UC START# *478CF372010B_478CF32A03B6_var*
//#UC END# *478CF372010B_478CF32A03B6_var*
begin
//#UC START# *478CF372010B_478CF32A03B6_impl*
 assert(false, 'TPersistent.AssignTo not implemented');
//#UC END# *478CF372010B_478CF32A03B6_impl*
end;//TPersistent.AssignTo

function TPersistent.GetOwner: TPersistent;
//#UC START# *480DD1890221_478CF32A03B6_var*
//#UC END# *480DD1890221_478CF32A03B6_var*
begin
//#UC START# *480DD1890221_478CF32A03B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *480DD1890221_478CF32A03B6_impl*
end;//TPersistent.GetOwner

function TStrings.GetObject(Index: Integer): TObject;
//#UC START# *47E21BAA029A_47E21A8A0324_var*
//#UC END# *47E21BAA029A_47E21A8A0324_var*
begin
//#UC START# *47E21BAA029A_47E21A8A0324_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E21BAA029A_47E21A8A0324_impl*
end;//TStrings.GetObject

procedure TStrings.PutObject(Index: Integer;
 AObject: TObject);
//#UC START# *47E21BC40258_47E21A8A0324_var*
//#UC END# *47E21BC40258_47E21A8A0324_var*
begin
//#UC START# *47E21BC40258_47E21A8A0324_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E21BC40258_47E21A8A0324_impl*
end;//TStrings.PutObject

procedure TStringList.Clear;
//#UC START# *47E21AB50104_4807756101FE_var*
//#UC END# *47E21AB50104_4807756101FE_var*
begin
//#UC START# *47E21AB50104_4807756101FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E21AB50104_4807756101FE_impl*
end;//TStringList.Clear

procedure TStringList.Insert(Index: Integer;
 const S: String);
//#UC START# *47E21AD40366_4807756101FE_var*
//#UC END# *47E21AD40366_4807756101FE_var*
begin
//#UC START# *47E21AD40366_4807756101FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E21AD40366_4807756101FE_impl*
end;//TStringList.Insert

function TStringList.Get(Index: Integer): String;
//#UC START# *47E21AF20186_4807756101FE_var*
//#UC END# *47E21AF20186_4807756101FE_var*
begin
//#UC START# *47E21AF20186_4807756101FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E21AF20186_4807756101FE_impl*
end;//TStringList.Get

procedure TStringList.Put(Index: Integer;
 const S: String);
//#UC START# *47E21B0A0167_4807756101FE_var*
//#UC END# *47E21B0A0167_4807756101FE_var*
begin
//#UC START# *47E21B0A0167_4807756101FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E21B0A0167_4807756101FE_impl*
end;//TStringList.Put

function TStringList.GetCount: Integer;
//#UC START# *47E21B2403D5_4807756101FE_var*
//#UC END# *47E21B2403D5_4807756101FE_var*
begin
//#UC START# *47E21B2403D5_4807756101FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E21B2403D5_4807756101FE_impl*
end;//TStringList.GetCount

procedure TStream.SetSize(const NewSize: Int64);
//#UC START# *5481E0EE0096_47E150FF028A_var*
//#UC END# *5481E0EE0096_47E150FF028A_var*
begin
//#UC START# *5481E0EE0096_47E150FF028A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481E0EE0096_47E150FF028A_impl*
end;//TStream.SetSize

function TStream.Seek(Offset: Integer;
 Origin: Word): Integer;
//#UC START# *49BE65B10224_47E150FF028A_var*
//#UC END# *49BE65B10224_47E150FF028A_var*
begin
//#UC START# *49BE65B10224_47E150FF028A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BE65B10224_47E150FF028A_impl*
end;//TStream.Seek

function TStream.Seek(const Offset: Int64;
 Origin: TSeekOrigin): Int64;
//#UC START# *49BE65E80020_47E150FF028A_var*
//#UC END# *49BE65E80020_47E150FF028A_var*
begin
//#UC START# *49BE65E80020_47E150FF028A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BE65E80020_47E150FF028A_impl*
end;//TStream.Seek

function TCustomMemoryStream.Read(var Buffer;
 Count: Integer): Integer;
//#UC START# *49BE656C006E_483FF4CA0307_var*
//#UC END# *49BE656C006E_483FF4CA0307_var*
begin
//#UC START# *49BE656C006E_483FF4CA0307_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BE656C006E_483FF4CA0307_impl*
end;//TCustomMemoryStream.Read

function TCustomMemoryStream.Write(Buffer;
 Count: Integer): Integer;
//#UC START# *49BE658C0261_483FF4CA0307_var*
//#UC END# *49BE658C0261_483FF4CA0307_var*
begin
//#UC START# *49BE658C0261_483FF4CA0307_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BE658C0261_483FF4CA0307_impl*
end;//TCustomMemoryStream.Write

procedure TComponent.Notification(AComponent: TComponent;
 Operation: TOperation);
//#UC START# *4F884378016A_479878FA0103_var*
//#UC END# *4F884378016A_479878FA0103_var*
begin
//#UC START# *4F884378016A_479878FA0103_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F884378016A_479878FA0103_impl*
end;//TComponent.Notification

procedure TComponent.WriteState(Writer: TWriter);
//#UC START# *4FD092040227_479878FA0103_var*
//#UC END# *4FD092040227_479878FA0103_var*
begin
//#UC START# *4FD092040227_479878FA0103_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD092040227_479878FA0103_impl*
end;//TComponent.WriteState

procedure TComponent.SetName(const aValue: TComponentName);
//#UC START# *52BC212F023F_479878FA0103_var*
//#UC END# *52BC212F023F_479878FA0103_var*
begin
//#UC START# *52BC212F023F_479878FA0103_impl*
 !!! Needs to be implemented !!!
//#UC END# *52BC212F023F_479878FA0103_impl*
end;//TComponent.SetName

constructor TComponent.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_479878FA0103_var*
//#UC END# *47D1602000C6_479878FA0103_var*
begin
//#UC START# *47D1602000C6_479878FA0103_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D1602000C6_479878FA0103_impl*
end;//TComponent.Create

function TComponent.QueryInterface(const IID: TGUID;
 out Obj): HResult;
//#UC START# *47D160620295_479878FA0103_var*
//#UC END# *47D160620295_479878FA0103_var*
begin
//#UC START# *47D160620295_479878FA0103_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D160620295_479878FA0103_impl*
end;//TComponent.QueryInterface

procedure TComponent.Loaded;
//#UC START# *484516C00214_479878FA0103_var*
//#UC END# *484516C00214_479878FA0103_var*
begin
//#UC START# *484516C00214_479878FA0103_impl*
 !!! Needs to be implemented !!!
//#UC END# *484516C00214_479878FA0103_impl*
end;//TComponent.Loaded

procedure TCollectionItem.SetIndex(Value: Integer);
//#UC START# *4F8E7D3303B9_4D555B5B01E8_var*
//#UC END# *4F8E7D3303B9_4D555B5B01E8_var*
begin
//#UC START# *4F8E7D3303B9_4D555B5B01E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8E7D3303B9_4D555B5B01E8_impl*
end;//TCollectionItem.SetIndex

function TCollectionItem.GetDisplayName: String;
//#UC START# *55CCBB5A01E5_4D555B5B01E8_var*
//#UC END# *55CCBB5A01E5_4D555B5B01E8_var*
begin
//#UC START# *55CCBB5A01E5_4D555B5B01E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CCBB5A01E5_4D555B5B01E8_impl*
end;//TCollectionItem.GetDisplayName

constructor TCollectionItem.Create(aCollection: TCollection);
//#UC START# *4D555CF50027_4D555B5B01E8_var*
//#UC END# *4D555CF50027_4D555B5B01E8_var*
begin
//#UC START# *4D555CF50027_4D555B5B01E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D555CF50027_4D555B5B01E8_impl*
end;//TCollectionItem.Create

procedure TCollection.Notify(Item: TCollectionItem;
 Action: TCollectionNotification);
//#UC START# *4F8E7A900279_4D555B78015F_var*
//#UC END# *4F8E7A900279_4D555B78015F_var*
begin
//#UC START# *4F8E7A900279_4D555B78015F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8E7A900279_4D555B78015F_impl*
end;//TCollection.Notify

function TCollection.GetAttrCount: Integer;
//#UC START# *560A9DA80335_4D555B78015F_var*
//#UC END# *560A9DA80335_4D555B78015F_var*
begin
//#UC START# *560A9DA80335_4D555B78015F_impl*
 !!! Needs to be implemented !!!
//#UC END# *560A9DA80335_4D555B78015F_impl*
end;//TCollection.GetAttrCount

function TCollection.GetAttr(Index: Integer): AnsiString;
//#UC START# *560A9DCD009D_4D555B78015F_var*
//#UC END# *560A9DCD009D_4D555B78015F_var*
begin
//#UC START# *560A9DCD009D_4D555B78015F_impl*
 !!! Needs to be implemented !!!
//#UC END# *560A9DCD009D_4D555B78015F_impl*
end;//TCollection.GetAttr

function TCollection.GetItemAttr(Index: Integer;
 ItemIndex: Integer): AnsiString;
//#UC START# *560A9DEB0155_4D555B78015F_var*
//#UC END# *560A9DEB0155_4D555B78015F_var*
begin
//#UC START# *560A9DEB0155_4D555B78015F_impl*
 !!! Needs to be implemented !!!
//#UC END# *560A9DEB0155_4D555B78015F_impl*
end;//TCollection.GetItemAttr

procedure TBasicActionLink.AssignClient(AClient: TObject);
//#UC START# *5339368F0001_52A088B20026_var*
//#UC END# *5339368F0001_52A088B20026_var*
begin
//#UC START# *5339368F0001_52A088B20026_impl*
 !!! Needs to be implemented !!!
//#UC END# *5339368F0001_52A088B20026_impl*
end;//TBasicActionLink.AssignClient

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCollectionItem);
 {* Регистрация TCollectionItem }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCollection);
 {* Регистрация TCollection }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOwnedCollection);
 {* Регистрация TOwnedCollection }
{$IfEnd} // NOT Defined(NoScripts)

end.
