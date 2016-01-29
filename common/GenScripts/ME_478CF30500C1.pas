unit Classes;

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
  procedure DefineProperties(Filer: TFiler);
  function GetNamePath: String;
  procedure Assign(Source: TPersistent);
  procedure AssignTo(Dest: TPersistent);
  function GetOwner: TPersistent;
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
  procedure Clear;
  procedure Insert(Index: Integer;
   const S: String);
  function Get(Index: Integer): String;
  procedure Put(Index: Integer;
   const S: String);
  function GetCount: Integer;
  function GetObject(Index: Integer): TObject;
  procedure PutObject(Index: Integer;
   AObject: TObject);
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
  procedure Clear;
  procedure Insert(Index: Integer;
   const S: String);
  function Get(Index: Integer): String;
  procedure Put(Index: Integer;
   const S: String);
  function GetCount: Integer;
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
  procedure SetSize(const NewSize: Int64);
  function Read(var Buffer;
   Count: Integer): Integer;
  function Write(Buffer;
   Count: Integer): Integer;
  function Seek(Offset: Integer;
   Origin: Word): Integer; overload;
  function Seek(const Offset: Int64;
   Origin: TSeekOrigin): Int64; overload;
 end;//TStream
 
 TCustomMemoryStream = class(TStream)
  {* TCustomMemoryStream is an abstract base class used as the common ancestor for memory streams }
  function Read(var Buffer;
   Count: Integer): Integer;
  function Write(Buffer;
   Count: Integer): Integer;
 end;//TCustomMemoryStream
 
 TWriter = class(TObject)
 end;//TWriter
 
 // TStream
 
 // TPersistent
 
 // TComponent
 
 // TStrings
 
 // TInterfacedPersistent
 
 // TThread
 
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
 
 // TShortCut
 
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
  procedure Notification(AComponent: TComponent;
   Operation: TOperation);
  procedure WriteState(Writer: TWriter);
  procedure SetName(const aValue: TComponentName);
  procedure Create(AOwner: TComponent);
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; stdcall;
  procedure Loaded;
 end;//TComponent
 
 TDataModule = class(TComponent)
 end;//TDataModule
 
 TCollection = class;
 
 TCollectionItem = class(TPersistent)
  procedure SetIndex(Value: Integer);
  function GetDisplayName: String;
  procedure Create(aCollection: TCollection);
 end;//TCollectionItem
 
 TCollectionNotification = (
 );//TCollectionNotification
 
 TCollection = class(TPersistent)
  procedure Notify(Item: TCollectionItem;
   Action: TCollectionNotification);
  function GetAttrCount: Integer;
  function GetAttr(Index: Integer): AnsiString;
  function GetItemAttr(Index: Integer;
   ItemIndex: Integer): AnsiString;
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
  procedure Execute;
 end;//TThread
 
 THelpContext = ;
 
 THelpType = ;
 
 TBasicActionLink = class(TObject)
  procedure AssignClient(AClient: TObject);
 end;//TBasicActionLink
 
 EParserError = class
 end;//EParserError
 
 EReadError = class(Exception)
 end;//EReadError
 
implementation

uses
 l3ImplUses
 , ComponentsProcessingPack
 , TtfwClassRef_Proxy
;

end.
