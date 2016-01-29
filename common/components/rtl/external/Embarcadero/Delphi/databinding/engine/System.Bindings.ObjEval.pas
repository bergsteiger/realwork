{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.ObjEval;

interface

uses
  System.SysUtils, System.Generics.Collections, System.TypInfo, System.Rtti, System.Bindings.Consts,
  System.Bindings.EvalProtocol;

                                                                               

/// <summary>Creates a wrapper for the given object.</summary>
/// <param name="AObject">The object for which the wrapper is created.</param>
/// <returns>A reference to the wrapper for the given object. The returned reference
/// points to the scope support of the object wrapper.</returns>
function WrapObject(AObject: TObject): IScope;

var
  IsProxyClassProc: function(ClassType: TClass): Boolean;

implementation

uses
  System.Bindings.EvalSys, System.Bindings.CustomScope, System.Bindings.CustomWrapper,
  System.Bindings.Factories, System.RTLConsts;

type
  PValue = ^TValue;

  { TObjectWrapper

    Wraps around a spcified object and stores an internal dictionary scope to
    which it delegates most of the functionality that must be implemented to
    suppport the scope interfaces. }

  TAbstractStructuredWrapper = class abstract(TInterfacedObject,
    IWrapper,
    IValue,
    ILocation,
    IWrapperBinding,
    IScope, IScopeEx, IScopeEnumerable, IScopeSymbols)
  private type
    TSymbols = TList<String>;
  private var
    FCtx: TRttiContext;
    FSkipCache: Boolean;
    FCache: TDictionaryScope; // stores pairs of property/method names and intf wrappers used in the script
    FCacheCounter: IInterface;
    FSymbols: TSymbols;
    FEvalTimeOnly: Boolean;
    FBinding: Pointer; // weak reference to ICompiledBinding
  protected
    // the following methods look up for the name in the given RTTI type and
    // create the appropriate wrapper if name is found as a member of RttiType
    function LookupMethod(RttiType: TRttiType; const Name: String): IInterface; virtual; abstract;
    function LookupProperty(RttiType: TRttiType; const Name: String): IInterface; virtual; abstract;
    function LookupIndexedProperty(RttiType: TRttiType; const Name: String): IInterface; virtual; abstract;
    function LookupField(RttiType: TRttiType; const Name: String): IInterface; virtual; abstract;
    // lookups the RTTI information for the given Name and creates for that
    // name a wrapper appropriate with the type of the member denoted by Name
    // and returns the wrapper; if there is no object member with the given Name,
    // it returns nil
    function LookupRtti(const Name: String): IInterface; virtual;
  public
    constructor Create(EvalTimeOnly: Boolean; const Binding: ICompiledBinding);
    destructor Destroy; override;

    { IValue }
    function GetType: PTypeInfo; virtual; abstract;
    function GetValue: TValue; virtual; abstract;

    { ILocation }
    procedure SetValue(const AValue: TValue); virtual; abstract;

    { IWrapperBinding }
    function GetBinding: ICompiledBinding; inline;
    procedure SetBinding(const Binding: ICompiledBinding); inline;

    property Binding: ICompiledBinding read GetBinding write SetBinding;

    { IScope }
    function Lookup(const Name: string): IInterface; overload; virtual; abstract;

    { IScopeEx }
    // checks if Obj is wrapped by this wrapper; if not, it searches for a wrapper
    // in the internal cache that may wrap Obj; it returns the found wrapper or
    // nil if no wrapper wraps Obj
    function Lookup(Obj: TObject): IInterface; overload; virtual; abstract;

    { IScopeEnumerable }
    function GetEnumerator: IScopeEnumerator;

    { IScopeSymbols }
    function GetSymbols(Index: Integer): String; inline;
    procedure SetSymbols(Index: Integer; const Value: String); inline;
    function GetSymbolCount: Integer; inline;

    procedure Add(const Symbol: String);
    procedure Remove(const Symbol: String); inline;
    function Contains(const Symbol: String): Boolean; inline;
    procedure Clear; inline;

    property Symbols[Index: Integer]: String read GetSymbols write SetSymbols;
    property SymbolCount: Integer read GetSymbolCount;
  end;

  TObjectWrapper = class(TAbstractStructuredWrapper,
    IPlaceholder,
    IScopeSelf, IScopeEnumerable)
  private var
    FIsProxyClass: Boolean;
    FObject: TObject;
    FMetaClass: TClass;
    FCustomScope: ICustomScope;
    FExternalWrap: Boolean;

    // returns the metaclass that best fits the parent object; if the wrapper
    // is not attached, it returns the metaclass passed in at wrapper creation
    function GetAvailClassType: TClass;
  protected
    function LookupMethod(RttiType: TRttiType; const Name: String): IInterface; override;
    function LookupProperty(RttiType: TRttiType; const Name: String): IInterface; override;
    function LookupIndexedProperty(RttiType: TRttiType; const Name: String): IInterface; override;
    function LookupField(RttiType: TRttiType; const Name: String): IInterface; override;
    function LookupRtti(const Name: String): IInterface; override;

    // returns a virtual wrapper for the symbol Name; if the wrapper doesn't
    // exist in the cache, but a custom wrapper is returned by a custom scope,
    // it creates a virtual wrapper that uses the custom wrapper and adds
    // the virtual wrapper to the internal cache
    function LookupVirtualWrapper(const Name: String): IInterface;
    // returns a default RTTI wrapper for the given name by checking the RTTI
    // for the current wrapped object type; if the wrapper doesn't exist, but
    // RTTI info exists, it creates a new wrapper for the symbol and adds it to
    // the internal cache
    function LookupDefault(const Name: String): IInterface;
    property IsProxyClass: Boolean read FIsProxyClass;
  public
    // creates an object wrapper around the AObject;
    // EvalTimeOnly indicates that the wrapper has a valid value only at evaluation time;
    // Binding refers to the compiled binding that created this wrapper during compilation
    constructor Create(AObject: TObject; MetaClass: TClass; AExternalWrap: Boolean = False;
      EvalTimeOnly: Boolean = False; const Binding: ICompiledBinding = nil);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;

    { IPlaceholder }
    function GetAttachment: TObject; inline;
    // returns the metaclass passed in at wrapper creation; it doesn't return
    // the best fit metaclass for the attachment because as a placeholder,
    // it must always know which is the minimum requirement for the object class
    function GetMetaClass: TClass; inline;
    function GetAttached: Boolean; inline;
    function GetEvalTimeOnly: Boolean; inline;

    // intercept the calls to attach/detach to change the value of FValue accordingly
    procedure Attach(Obj: TObject);
    procedure Detach;

    { IScope }
    function Lookup(const Name: string): IInterface; overload; override;

    { IScopeEx }
    // checks if Obj is wrapped by this wrapper; if not, it searches for a wrapper
    // in the internal cache that may wrap Obj; it returns the found wrapper or
    // nil if no wrapper wraps Obj
    function Lookup(Obj: TObject): IInterface; overload; override;

    { IScopeSelf }
    function GetSelf: IInterface; inline;
  end;

  TRecordWrapper = class(TAbstractStructuredWrapper,
    IRecordPlaceholder)
  private
    FRecord: TValue;
    FTypeInfo: PTypeInfo;
  protected
    function LookupMethod(RttiType: TRttiType; const Name: String): IInterface; override;
    function LookupProperty(RttiType: TRttiType; const Name: String): IInterface; override;
    function LookupIndexedProperty(RttiType: TRttiType; const Name: String): IInterface; override;
    function LookupField(RttiType: TRttiType; const Name: String): IInterface; override;
  public
    // creates an wrapper arond the given record; ATypeInfo specifies the type
    // information of the record in case ARecord is empty
    constructor Create(ARecord: TValue; ATypeInfo: PTypeInfo;
      EvalTimeOnly: Boolean; const Binding: ICompiledBinding);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;

    { IScope }
    function Lookup(const Name: string): IInterface; overload; override;

    { IScopeEx }
    function Lookup(Obj: TObject): IInterface; overload; override;

    { IRecordPlaceholder }
    function GetAttachment: TValue;
    function GetAttached: Boolean; inline;
    function GetEvalTimeOnly: Boolean; inline;

    procedure Attach(Rec: TValue);
    procedure Detach;

    property Attachment: TValue read GetAttachment;
    property Attached: Boolean read GetAttached;
    property EvalTimeOnly: Boolean read GetEvalTimeOnly;
  end;

  TAbstractMemberGroup = class abstract(TInterfacedObject,
    IWrapper,
    IGroup,
    IWrapperBinding,
    IScopeEnumerable)
  private
    FCache: TObjectMemberGroupScope; // sustains links to all the result wrappers of the indexed property
    FCacheCounter: IInterface;
    FBinding: Pointer; // weak reference to ICompiledBinding
  public
    constructor Create(const Binding: ICompiledBinding);
    destructor Destroy; override;

    { IGroup }
    function GetWrappers(Index: Integer): IInterface; inline;
    function GetWrapperCount: Integer; inline;

    function Add: Integer; overload; inline;
    function Add(out Wrapper: IInterface): Integer; overload; virtual; abstract;
    procedure Clear; inline;

    property Wrappers[Index: Integer]: IInterface read GetWrappers;
    property WrapperCount: Integer read GetWrapperCount;

    { IWrapperBinding }
    function GetBinding: ICompiledBinding; inline;
    procedure SetBinding(const Binding: ICompiledBinding); inline;

    { IScopeEnumerable }
    function GetEnumerator: IScopeEnumerator;
  end;

  TAbstractObjectMemberGroup = class abstract(TAbstractMemberGroup,
    IChild,
    IPlaceholder)
  private
    FEvalTimeOnly: Boolean;
  public
    constructor Create(EvalTimeOnly: Boolean; const Binding: ICompiledBinding);

    { IChild }
    function GetParent: TObject; virtual; abstract;
    function GetMemberName: String; virtual; abstract;

    { IPlaceholder }
    function GetAttachment: TObject; virtual; abstract;
    function GetMetaClass: TClass; virtual; abstract;
    function GetAttached: Boolean; inline;
    function GetEvalTimeOnly: Boolean; inline;

    procedure Attach(Obj: TObject); virtual; abstract;
    procedure Detach; virtual; abstract;
  end;

  TPhysicalObjectMemberGroup = class abstract(TAbstractObjectMemberGroup,
    IRttiChild)
  private
    FObject: TObject;
    FMetaClass: TClass;
    FMember: TRttiMember;
    FAttaching: Boolean;
  public
    constructor Create(AObject: TObject; AMember: TRttiMember; MetaClass: TClass;
      EvalTimeOnly: Boolean; const Binding: ICompiledBinding);

    // these methods attach/detach the group wrapper to/from the given object
    // and doesn't propagate this down to the member instance wrappers in its scope
    procedure AttachObjectOnly(Obj: TObject); inline;
    procedure DetachObjectOnly; inline;

    { IChild }
    function GetParent: TObject; override;
    function GetMemberName: String; override;

    { IRttiChild }
    function GetMember: TRttiMember; virtual;

    { IPlaceholder }
    function GetAttachment: TObject; override;
    function GetMetaClass: TClass; override;

    procedure Attach(Obj: TObject); override;
    procedure Detach; override;
  end;

  TPhysicalRecordMemberGroup = class abstract(TAbstractMemberGroup,
    IRecordChild,
    IRecordPlaceholder)
  private
    FRecord: TValue;
    FMember: TRttiMember;
    FEvalTimeOnly: Boolean;
    FAttaching: Boolean;
  public
    constructor Create(ARecord: TValue; AMember: TRttiMember; EvalTimeOnly: Boolean;
      const Binding: ICompiledBinding);

    // attach/detach only the record, without going recursively to the contained wrappers
    procedure AttachRecordOnly(Rec: TValue);
    procedure DetachRecordOnly;

    { IRecordChild }
    function GetParent: TValue;
    function GetMember: TRttiMember; inline;

    { IRecordPlaceholder }
    function GetAttachment: TValue;
    function GetAttached: Boolean; inline;
    function GetEvalTimeOnly: Boolean; inline;

    procedure Attach(Rec: TValue);
    procedure Detach;
  end;

  TObjectPropertyGroup = class(TPhysicalObjectMemberGroup)
  public
    constructor Create(AObject: TObject; AProperty: TRttiProperty; MetaClass: TClass;
      EvalTimeOnly: Boolean; const Binding: ICompiledBinding);

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;
  end;

  TRecordPropertyGroup = class(TPhysicalRecordMemberGroup)
  public
    constructor Create(ARecord: TValue; AProperty: TRttiProperty;
      EvalTimeOnly: Boolean; const Binding: ICompiledBinding);

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;
  end;

  TIndexedObjectPropertyGroup = class(TPhysicalObjectMemberGroup)
  public
    constructor Create(AObject: TObject; AIndexedProperty: TRttiIndexedProperty;
      MetaClass: TClass; const Binding: ICompiledBinding);

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;
  end;

  TIndexedRecordPropertyGroup = class(TPhysicalRecordMemberGroup)
  public
    constructor Create(ARecord: TValue; AProperty: TRttiIndexedProperty;
      const Binding: ICompiledBinding);

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;
  end;

  TObjectFieldGroup = class(TPhysicalObjectMemberGroup)
  public
    constructor Create(AObject: TObject; AField: TRttiField; MetaClass: TClass;
      EvalTimeOnly: Boolean; const Binding: ICompiledBinding);

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;
  end;

  TRecordFieldGroup = class(TPhysicalRecordMemberGroup)
  public
    constructor Create(ARecord: TValue; AField: TRttiField;
      EvalTimeOnly: Boolean; const Binding: ICompiledBinding);

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;
  end;

  TObjectMethodGroup = class(TPhysicalObjectMemberGroup)
  public
    constructor Create(AObject: TObject; AMethod: TRttiMethod; MetaClass: TClass;
      const Binding: ICompiledBinding);

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;
  end;

  TRecordMethodGroup = class(TPhysicalRecordMemberGroup)
  public
    constructor Create(ARecord: TValue; AMethod: TRttiMethod;
      const Binding: ICompiledBinding);

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;
  end;

  TDynamicObjectMemberGroup = class(TPhysicalObjectMemberGroup,
    IDynamicGroup)
  private
    FFixedGroup: IGroup;
    FMemberName: String;
  public
    constructor Create(AObject: TObject; AMemberName: String; MetaClass: TClass;
      const Binding: ICompiledBinding);

    { IChild }
    function GetMemberName: String; override;

    { IRttiChild }
    function GetMember: TRttiMember; override;

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;

    { IDynamicGroup }
    function GetFixedGroup: IGroup; inline;
    procedure SetFixedGroup(const Group: IGroup);
  end;

  TVirtualObjectMemberGroup = class(TAbstractObjectMemberGroup)
  private
    FCustomWrapper: IInterface;
    FWrapperType: TCustomWrapperType;
    FAttaching: Boolean;

    // raises an exception if the given wrapper does not support the specified
    // interface; the name of the interface is necessary for the error message
    procedure CheckIntfSupport(const Wrapper: IInterface;
      const IID: TGUID; const IntfName: String);
    // verifies if the passed custom wrapper implements the needed interfaces
    procedure CheckCustomWrapper(const Wrapper: IInterface);
  public
    constructor Create(const CustomWrapper: IInterface; const Binding: ICompiledBinding);

    { IChild }
    function GetParent: TObject; override;
    function GetMemberName: String; override;

    { IPlaceholder }
    function GetAttachment: TObject; override;
    function GetMetaClass: TClass; override;

    procedure Attach(Obj: TObject); override;
    procedure Detach; override;

    { IGroup }
    function Add(out Wrapper: IInterface): Integer; override;
  end;

  TAbstractMemberInstance = class abstract(TInterfacedObject, IInterface,
    IWrapper,
    IValue, ILocation,
    IWrapperBinding,
    IScope, IScopeEx, IScopeEnumerable, IScopeSymbols)
  protected type
    // describes the type of the cache used by the member
    TCacheType = (ctNone, ctObject, ctRecord);
  private
    FGroup: TAbstractMemberGroup;
    FCache: TAbstractStructuredWrapper;
    FCacheCounter: IInterface;
    FCacheType: TCacheType;

    function GetObjectCache: TObjectWrapper;
    function GetRecordCache: TRecordWrapper;
  protected
    function GetCache: TAbstractStructuredWrapper; virtual;

    // returns True if the wrapper can have an internal cache instantiated;
    // the cache can be created only if type of the member is either object
    // or record
    function CanCache: Boolean; virtual;
    // returns True if the wrapper has its cache instantiated
    function HasCache: Boolean; virtual;
    // methods called when the cache needs to be instantiated; this mechanism
    // permits lazy instantiation of the cache; the cache is used only when
    // the result type of the member is of an object type or record type;
    // these function must return a reference to the cache
    function CreateObjectCache: TObjectWrapper; virtual; abstract;
    function CreateRecordCache: TRecordWrapper; virtual; abstract;
    // returns True if the result type of the member is of an object type or
    // a record type
    function IsStructuredType: Boolean; inline;

    // gives access to the parent group
    property Group: TAbstractMemberGroup read FGroup;
    // gives access to the internal cache that holds the subwrappers; the cache
    // is available only if CanCache returns True and the cache hasn't been
    // instantiated already
    property Cache: TAbstractStructuredWrapper read GetCache;
    // use the cache as an object cache
    property ObjectCache: TObjectWrapper read GetObjectCache;
    // use the cache as a record cache
    property RecordCache: TRecordWrapper read GetRecordCache;
    // the type of the cache used to store the subwrappers; it can also be
    // determined using the result of GetType, but it requires additional
    // processing
    property CacheType: TCacheType read FCacheType;
  public
    constructor Create(Group: TAbstractMemberGroup);
    destructor Destroy; override;

    { IInterface }
    // reimplement IInterface.QI to conditionally support IScope depending on value
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; virtual; stdcall;

    { IValue }
    function GetType: PTypeInfo; virtual; abstract;
    function GetValue: TValue; virtual; abstract;

    { ILocation }
    procedure SetValue(const AValue: TValue); virtual; abstract;

    { IWrapperBinding }
    function GetBinding: ICompiledBinding; virtual;
    procedure SetBinding(const Binding: ICompiledBinding); virtual;

    // the scope support is restricted in QueryInterface, depending on the
    // result type of the property; if it's of an object type, the scope support
    // interfaces can be queried
    { IScope }
    function Lookup(const Name: string): IInterface; overload; virtual;

    { IScopeEx }
    function Lookup(Obj: TObject): IInterface; overload; virtual;

    { IScopeEnumerable }
    function GetEnumerator: IScopeEnumerator; virtual;

    { IScopeSymbols }
    function GetSymbols(Index: Integer): String; virtual;
    procedure SetSymbols(Index: Integer; const Value: String); virtual;
    function GetSymbolCount: Integer; virtual;

    procedure Add(const Symbol: String); virtual;
    procedure Remove(const Symbol: String); virtual;
    function Contains(const Symbol: String): Boolean; virtual;
    procedure Clear; virtual;
  end;

  TAbstractObjectMemberInstance = class abstract(TAbstractMemberInstance,
    IChild,
    IPlaceholder)
  private
    function GetGroup: TAbstractObjectMemberGroup; inline;
  protected
    function CreateObjectCache: TObjectWrapper; override;
    function CreateRecordCache: TRecordWrapper; override;

    property Group: TAbstractObjectMemberGroup read GetGroup;
  public
    constructor Create(Group: TAbstractObjectMemberGroup);
    destructor Destroy; override;

    { IChild }
    function GetParent: TObject; inline;
    function GetMemberName: String; inline;

    { IPlaceholder }
    function GetAttachment: TObject; inline;
    function GetMetaClass: TClass; inline;
    function GetAttached: Boolean; inline;
    function GetEvalTimeOnly: Boolean; inline;

    // intercept the calls to attach/detach to change the value of FValue accordingly
    // and redirect to the internal cache storing the actual information
    procedure Attach(Obj: TObject); virtual; abstract;
    procedure Detach; virtual; abstract;
  end;

  TPhysicalObjectMemberInstance = class abstract(TAbstractObjectMemberInstance,
    IRttiChild)
  private
    FAttaching: Boolean;

    function GetGroup: TPhysicalObjectMemberGroup; inline;
  protected
    property Group: TPhysicalObjectMemberGroup read GetGroup;
  public
    constructor Create(Group: TPhysicalObjectMemberGroup);

    { IRttiChild }
    function GetMember: TRttiMember; inline;

    { IPlaceholder }
    // intercept the calls to attach/detach to change the value of FValue accordingly
    // and redirect to the internal cache storing the actual information
    procedure Attach(Obj: TObject); override;
    procedure Detach; override;
  end;

  TPhysicalRecordMemberInstance = class abstract(TAbstractMemberInstance,
    IRecordChild,
    IRecordPlaceholder)
  private
    FAttaching: Boolean;

    function GetGroup: TPhysicalRecordMemberGroup; inline;
  protected
    function CreateObjectCache: TObjectWrapper; override;
    function CreateRecordCache: TRecordWrapper; override;

    property Group: TPhysicalRecordMemberGroup read GetGroup;
  public
    constructor Create(Group: TPhysicalRecordMemberGroup);

    { IRecordChild }
    function GetParent: TValue;
    function GetMember: TRttiMember; inline;

    { IRecordPlaceholder }
    function GetAttachment: TValue;
    function GetAttached: Boolean; inline;
    function GetEvalTimeOnly: Boolean; inline;

    procedure Attach(Rec: TValue);
    procedure Detach;
  end;

  TPhysicalParamedObjectMemberInstance = class(TPhysicalObjectMemberInstance,
    IArguments)
  private
    FArgs: TArray<TValue>;
  public
    { IArguments }
    procedure SetArgs(const Args: TArray<TValue>); virtual;
    function GetArgs: TArray<TValue>; virtual;
  end;

  TPhysicalParamedRecordMemberInstance = class(TPhysicalRecordMemberInstance,
    IArguments)
  private
    FArgs: TArray<TValue>;
  public
    { IArguments }
    procedure SetArgs(const Args: TArray<TValue>); virtual;
    function GetArgs: TArray<TValue>; virtual;
  end;

  TObjectPropertyInstance = class(TPhysicalObjectMemberInstance)
  public
    constructor Create(Group: TObjectPropertyGroup);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;
  end;

  TRecordPropertyInstance = class(TPhysicalRecordMemberInstance)
  public
    constructor Create(Group: TRecordPropertyGroup);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;
  end;

  TIndexedObjectPropertyInstance = class(TPhysicalParamedObjectMemberInstance)
  public
    constructor Create(Group: TIndexedObjectPropertyGroup);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;

    { IArguments }
    procedure SetArgs(const Args: TArray<TValue>); override;
  end;

  TIndexedRecordPropertyInstance = class(TPhysicalParamedRecordMemberInstance)
  public
    constructor Create(Group: TIndexedRecordPropertyGroup);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;

    { IArguments }
    procedure SetArgs(const Args: TArray<TValue>); override;
  end;

  TObjectFieldInstance = class(TPhysicalObjectMemberInstance)
  public
    constructor Create(Group: TObjectFieldGroup);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;
  end;

  TRecordFieldInstance = class(TPhysicalRecordMemberInstance)
  public
    constructor Create(Group: TRecordFieldGroup);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;
  end;

  TObjectMethodInstance = class(TPhysicalParamedObjectMemberInstance,
    IInvokable)
  private
    FValue: TValue;
  public
    constructor Create(Group: TObjectMethodGroup);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;

    { IInvokable }
    function Invoke(const Args: TArray<IValue>): IValue;
  end;

  TRecordMethodInstance = class(TPhysicalParamedRecordMemberInstance,
    IInvokable)
  private
    FValue: TValue;
  public
    constructor Create(Group: TRecordMethodGroup);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;

    { IInvokable }
    function Invoke(const Args: TArray<IValue>): IValue;
  end;

  TDynamicObjectMemberInstance = class(TPhysicalParamedObjectMemberInstance,
    IInvokable,
    IDynamicInstance)
  private
    FFixedInstance: IInterface;
  public
    constructor Create(Group: TDynamicObjectMemberGroup);

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;

    { IArguments }
    procedure SetArgs(const Args: TArray<TValue>); override;
    function GetArgs: TArray<TValue>; override;

    { IInvokable }
    function Invoke(const Args: TArray<IValue>): IValue;

    { IPlaceholder }
    // reattach the fixed instance when the dynamic instance is reattaching
    procedure Attach(Obj: TObject); override;
    procedure Detach; override;

    { IDynamicInstance }
    function GetFixedInstance: IInterface; inline;
    procedure SetFixedInstance(const Instance: IInterface); inline;
  end;

  TVirtualObjectMemberInstance = class(TAbstractObjectMemberInstance,
    IArguments, IInvokable)
  private
    FValue: TValue;
    FArgs: TArray<TValue>;
    FAttaching: Boolean;

    function GetCustomWrapper: IInterface; inline;
    function GetWrapperType: TCustomWrapperType;
  protected
    function GetCache: TAbstractStructuredWrapper; override;
    // virtual instances must have a cache because the type of the virtual
    // member may not be known at compile-time; if the expression considers
    // the wrapped member as an object and it won't be true at evaluation time,
    // evaluation errors will be risen
    function CanCache: Boolean; override;

    procedure TransformCache(const FromCache, ToCache: IInterface);
    procedure TransformGroup(const FromWrpr, ToWrpr: IInterface);
    procedure TransformInstance(const FromWrpr, ToWrpr: IInterface);

    // transforms the internal cache to the given cache type
    procedure ConvertCache(ToType: TAbstractMemberInstance.TCacheType);
  public
    constructor Create(Group: TVirtualObjectMemberGroup);

    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;

    { IValue }
    function GetType: PTypeInfo; override;
    function GetValue: TValue; override;

    { ILocation }
    procedure SetValue(const AValue: TValue); override;

    { IArguments }
    function GetArgs: TArray<TValue>; inline;
    procedure SetArgs(const Args: TArray<TValue>);

    { IInvokable }
    function Invoke(const Args: TArray<IValue>): IValue;

    { IPlaceholder }
    procedure Attach(Obj: TObject); override;
    procedure Detach; override;
  end;

function WrapObject(AObject: TObject): IScope;
begin
  if AObject = nil then
    raise EWrapperError.Create(sScopeObjNull);
  Result := TObjectWrapper.Create(AObject, AObject.ClassType, True);
end;

{ TObjectWrapper }

procedure TObjectWrapper.Attach(Obj: TObject);
var
  LWrpr: IInterface;
  LWrprPlaceholder: IPlaceholder;
begin
  FObject := Obj;
                                                                           
// that is more specialized (on a deeper level of the hierarchy) is attached
// to the wrapper? Would it be appropriate for the system to query the
// custom scope factory for a better fitted custom scope and dispose of the
// current one?

  // assure that for the custom scope we have the new object assigned to it
  if Assigned(FCustomScope) then
    FCustomScope.MappedObject := FObject;

                                                                                      
// this is an object wrapper and wraps an object. What else could it wrap?
  for LWrpr in Self do
    if Supports(LWrpr, IPlaceholder, LWrprPlaceholder) then
      LWrprPlaceholder.Attach(GetValue.AsObject);
end;

constructor TObjectWrapper.Create(AObject: TObject; MetaClass: TClass;
  AExternalWrap: Boolean; EvalTimeOnly: Boolean; const Binding: ICompiledBinding);
begin
  inherited Create(EvalTimeOnly, Binding);

  if not Assigned(MetaClass) then
    raise EWrapperError.CreateFmt(SParamIsNil, ['MetaClass']);

  FObject := AObject;
  FMetaClass := MetaClass;
  FSkipCache := False;
  FIsProxyClass := False;
  FExternalWrap := AExternalWrap;
  if Assigned(AObject) and Assigned(IsProxyClassProc) then
    FIsProxyClass := IsProxyClassProc(AObject.ClassType);
end;

procedure TObjectWrapper.Detach;
var
  LWrpr: IInterface;
  LWrprPlaceholder: IPlaceholder;
begin
  FObject := nil;

  for LWrpr in Self do
    if Supports(LWrpr, IPlaceholder, LWrprPlaceholder) then
      LWrprPlaceholder.Detach;
end;

function TObjectWrapper.GetAvailClassType: TClass;
begin
  if Assigned(FObject) then
    Result := FObject.ClassType
  else
    Result := FMetaClass;
end;

function TObjectWrapper.GetAttached: Boolean;
begin
  Result := Assigned(FObject);
end;

function TObjectWrapper.GetAttachment: TObject;
begin
  Result := FObject;
end;

function TObjectWrapper.GetEvalTimeOnly: Boolean;
begin
  Result := FEvalTimeOnly;
end;

function TObjectWrapper.GetMetaClass: TClass;
begin
  Result := FMetaClass;
end;

function TObjectWrapper.GetSelf: IInterface;
begin
  //Note: A Lookup on a TDictionaryScope with blank property name accomplishes the same
  //This is to provide the ability to specify 'Self' as the expression for all other scopes that implement
  // IScopeSelf.

  Result := Self;
end;

function TObjectWrapper.GetType: PTypeInfo;
begin
  Result := GetAvailClassType.ClassInfo;
end;

function TObjectWrapper.GetValue: TValue;
begin
  Result := FObject;
end;

function TObjectWrapper.LookupVirtualWrapper(const Name: String): IInterface;
var
  LClassType: TClass;
  LCustomWrapper: IInterface;
begin
  Result := nil;

  // grab the custom scope that the user might have registered in the custom scope factory;
  // check if the custom scope can create a wrapper for the given name;
  // if we have a custom wrapper, then we create a virtual wrapper and return it
  LClassType := GetAvailClassType;
  if TBindingScopeFactory.IsObjectTypeRegistered(LClassType, True) then
  begin
    // try to create and cache the custom scope assigned to this object
    if not Assigned(FCustomScope) then
      FCustomScope := TBindingScopeFactory.CreateScope(FObject, GetMetaClass);

    // grab the custom wrapper from the custom scope
    LCustomWrapper := nil;
    if Assigned(FCustomScope) then
      LCustomWrapper := FCustomScope.Lookup(Name);

    // having a custom wrapper means that we must also have a virtual wrapper
    if Assigned(LCustomWrapper) then
    begin
      // search for the virtual member group associated with the member name
      Result := FCache.Lookup(Name);

      // create a virtual member group for the member
      if not Assigned(Result) then
      begin
        if Supports(LCustomWrapper, ICustomWrapper) then
          Result := TVirtualObjectMemberGroup.Create(LCustomWrapper, GetBinding)
        else
          Result := LCustomWrapper;

        FCache.Map.Add(Name, Result);
      end;
    end;
  end;
end;

procedure TObjectWrapper.SetValue(const AValue: TValue);
begin
  FObject := AValue.AsObject;
end;

function TObjectWrapper.Lookup(const Name: string): IInterface;
begin
  Result := nil;

  // it can create a wrapper for name only if name is used in the expression
  // The following lines causes expressions that have an scope of TObjectWrapper to fail.
  // For example, an expression of "Text" fails when scope is WrapObject(MyEdit)

                                                                                               
// the TopScope and ScopeSymbols in the Evaluator, at compile-time. The TopScope can be a TNestedScope
// and when queried for IScopeSymbols, it returns a reference to the IScopeSymbols of the inner/outer
// scope and this may be incorrect in some cases. Must test this to check the problem out.

//  if Contains(Name) or (Binding.Phase = cbpCompiling) then
  begin
    // grab a virtual wrapper for the given symbol
    Result := LookupVirtualWrapper(Name);

    // no virtual wrapper was found to handle the symbol Name;
    // check for a default RTTI wrapper that may do it
    if not Assigned(Result) then
      Result := LookupDefault(Name);
  end;
end;

function TObjectWrapper.Lookup(Obj: TObject): IInterface;
begin
  Result := nil;
  if Assigned(FObject) then
    if FObject = Obj then
      Result := Self
    else
      Result := FCache.Lookup(Obj);
end;

function TObjectWrapper.LookupDefault(const Name: String): IInterface;
var
  DynamicGroup: IDynamicGroup;
  FixedGroup: IGroup;
  Wrapper: IInterface;
  CacheFound: Boolean; // the wrapper was found in the cache
  RttiFound: Boolean; // wrapper found in RTTI
begin
  Result := nil;
  RttiFound := False;
  CacheFound := False;

  // search the cache first to see if there's a wrapper stored for Name
  if not FSkipCache then
  begin
    Result := FCache.Lookup(Name);
    CacheFound := Assigned(Result);
  end;

  // search for Name among the object members because no wrapper was in the
  // internal cache for the Name symbol
  if not CacheFound then
  begin
    Result := LookupRtti(Name);
    RttiFound := Assigned(Result);
  end;

  // we have information on the interpreter phase, so depending on the phase,
  // there can be done additional processing such as creating dynamic wrappers
  // or linking dynamic wrappers to fixed wrappers
  if Assigned(Binding) then
    case Binding.Phase of
      cbpCompiling: // compile-time lookup
          // no wrapper in cache and no RTTI info for Name were found;
          // generate a dynamic group wrapper because at evaluation-time there
          // may be an RTTI object member for the given Name, due to the yet unknown,
          // but possible dynamic type of the parent object
          if not CacheFound and not RttiFound and not FExternalWrap then
          begin
            Result := TDynamicObjectMemberGroup.Create(FObject, Name, GetMetaClass, GetBinding);

            // we must add the wrapper to the cache and this permits us to do so;
            // it's like supposing that the true fixed wrapper will be found
            // at some point during the evaluation and therefore we must store
            // in the cache a this surrogate wrapper until we find the real one
            RttiFound := True;
          end;
      cbpEvaluating: // evaluation-time lookup
        // the wrapper for Name was found in the cache; being an unlinked dynamic
        // wrapper, we have to search the RTTI to provide a concrete fixed wrapper
        // for the dynamic wrapper in order to provide concrete values; if this fails,
        // it means that Name is really an inexistent object member
        if CacheFound and // wrapper was found in cache
           Supports(Result, IDynamicGroup, DynamicGroup) and // it's a dynamic wrapper
           not Assigned(DynamicGroup.FixedGroup) then // it's not linked
        begin
          // force a new search for Name in the current RTTI information in order
          // to generate a concrete RTTI wrapper
          Wrapper := LookupRtti(Name);

          // link the dynamic group to the fixed group
          if Supports(Wrapper, IGroup, FixedGroup) then
            DynamicGroup.SetFixedGroup(FixedGroup)
          else // the Name symbol actually doesn't exist
                                                                  
            // to make "nil" work
            //raise EEvaluatorError.CreateFmt(sLookupError, [Name]);
        end;
    end;

  // add the wrapper to the internal cache only if it hasn't been found
  // already in the internal cache
  if (not CacheFound) and RttiFound and (not FSkipCache) then
    FCache.Map.Add(Name, Result);
end;

function TObjectWrapper.LookupField(RttiType: TRttiType;
  const Name: String): IInterface;
var
  LField: TRttiField;
begin
  LField := RttiType.GetField(Name);
  if Assigned(LField) then
    Result := TObjectFieldGroup.Create(FObject, LField, GetMetaClass, GetEvalTimeOnly, GetBinding)
  else
    Result := nil;
end;

function TObjectWrapper.LookupIndexedProperty(RttiType: TRttiType;
  const Name: String): IInterface;
var
  LIndexedProperty: TRttiIndexedProperty;
begin
  LIndexedProperty := RttiType.GetIndexedProperty(Name);
  if Assigned(LIndexedProperty) then
    Result := TIndexedObjectPropertyGroup.Create(FObject, LIndexedProperty, GetMetaClass, GetBinding)
  else
    Result := nil;
end;

function TObjectWrapper.LookupMethod(RttiType: TRttiType;
  const Name: String): IInterface;
var
  LMethod: TRttiMethod;
begin
  LMethod := RttiType.GetMethod(Name);
  if Assigned(LMethod) then
    Result := TObjectMethodGroup.Create(FObject, LMethod, GetMetaClass, GetBinding)
  else
    Result := nil;
end;

function TObjectWrapper.LookupProperty(RttiType: TRttiType;
  const Name: String): IInterface;
var
  LProperty: TRttiProperty;
begin
  if Name <> '' then
    LProperty := RttiType.GetProperty(Name)
  else
    LProperty := nil;
  if Assigned(LProperty) then
    Result := TObjectPropertyGroup.Create(FObject, LProperty, GetMetaClass, GetEvalTimeOnly, GetBinding)
  else
    Result := nil;
end;

function TObjectWrapper.LookupRtti(const Name: String): IInterface;
begin
  if IsProxyClass then
    Exit(nil);

  Result := inherited;
end;

{ TObjectProperty }

constructor TObjectPropertyInstance.Create(Group: TObjectPropertyGroup);
begin
  inherited Create(Group);
end;

function TObjectPropertyInstance.GetType: PTypeInfo;
var
  LMember: TRttiMember;
begin
               
  LMember := GetMember;
  if Assigned(LMember) then
    Result := TRttiProperty(LMember).PropertyType.Handle
  else
                                                                          
    Result := GetParent.ClassInfo;
end;

function TObjectPropertyInstance.GetValue: TValue;
var
  LParent: TObject;
  LMember: TRttiMember;
begin
  LParent := GetParent;
  if Assigned(LParent) then
  begin
    LMember := GetMember;
    if Assigned(LMember) then
      Result := TRttiProperty(LMember).GetValue(LParent)
    else
      Result := TValue.From<TObject>(LParent);
  end
  else
    Result := TValue.Empty;
end;

procedure TObjectPropertyInstance.SetValue(const AValue: TValue);
var
  LParent: TObject;
  LMember: TRttiMember;
begin
  LParent := GetParent;
  LMember := GetMember;
  if Assigned(LParent) and Assigned(LMember) then
    TRttiProperty(LMember).SetValue(LParent, AValue);
end;
{ TIndexedObjectProperty }

procedure TPhysicalObjectMemberGroup.Attach(Obj: TObject);
var
  LResultWrapper: IInterface;
  LPlaceholder: IPlaceholder;
begin
  if not FAttaching then
  begin
    FAttaching := True;

    AttachObjectOnly(Obj);
    for LResultWrapper in Self do
      if Supports(LResultWrapper, IPlaceholder, LPlaceholder) then
        LPlaceholder.Attach(Obj);

    FAttaching := False;
  end;
end;

procedure TPhysicalObjectMemberGroup.AttachObjectOnly(Obj: TObject);
begin
  FObject := Obj;
end;

constructor TPhysicalObjectMemberGroup.Create(AObject: TObject;
  AMember: TRttiMember; MetaClass: TClass; EvalTimeOnly: Boolean;
  const Binding: ICompiledBinding);
begin
  inherited Create(EvalTimeOnly, Binding);

  if not Assigned(MetaClass) then
    raise EWrapperError.CreateFmt(SParamIsNil, ['MetaClass']);

  FObject := AObject;
  FMember := AMember;
  FMetaClass := MetaClass;
end;

procedure TPhysicalObjectMemberGroup.Detach;
var
  LResultWrapper: IInterface;
  LPlaceholder: IPlaceholder;
begin
  if not FAttaching then
  begin
    FAttaching := True;

    DetachObjectOnly;
    for LResultWrapper in Self do
      if Supports(LResultWrapper, IPlaceholder, LPlaceholder) then
        LPlaceholder.Detach;

    FAttaching := False;
  end;
end;

procedure TPhysicalObjectMemberGroup.DetachObjectOnly;
begin
  FObject := nil;
end;

function TPhysicalObjectMemberGroup.GetAttachment: TObject;
begin
  Result := FObject;
end;

function TPhysicalObjectMemberGroup.GetMember: TRttiMember;
begin
  Result := FMember;
end;

function TPhysicalObjectMemberGroup.GetMemberName: String;
begin
  Result := '';
  if Assigned(FMember) then
    Result := FMember.Name;
end;

function TPhysicalObjectMemberGroup.GetMetaClass: TClass;
begin
  Result := FMetaClass;
end;

function TPhysicalObjectMemberGroup.GetParent: TObject;
begin
  Result := FObject;
end;

{ TIndexedObjectPropertyResult }

constructor TIndexedObjectPropertyInstance.Create(
  Group: TIndexedObjectPropertyGroup);
begin
  inherited Create(Group);
end;

function TIndexedObjectPropertyInstance.GetType: PTypeInfo;
begin
  Result := TRttiIndexedProperty(GetMember).PropertyType.Handle;
end;

function TIndexedObjectPropertyInstance.GetValue: TValue;
var
  LParent: TObject;
begin
  LParent := GetParent;

  // the arguments cannot be set at compile-time and we cannot return values
  // for an indexed property; plus that an indexed property must have at least
  // one parameter which means that its value can be determined only at
  // evaluation-time
  if Assigned(LParent) and Assigned(GetArgs()) then
    Result := TRttiIndexedProperty(GetMember).GetValue(LParent, GetArgs)
  else
    Result := TValue.Empty;
end;

procedure TIndexedObjectPropertyInstance.SetArgs(const Args: TArray<TValue>);
begin
  inherited;

  Attach(GetParent);
end;

procedure TIndexedObjectPropertyInstance.SetValue(const AValue: TValue);
var
  LParent: TObject;
begin
  LParent := GetParent;
  if Assigned(LParent) and Assigned(GetArgs()) then
    TRttiIndexedProperty(GetMember).SetValue(LParent, GetArgs, AValue);

                                                                                            
end;

{ TIndexedObjectPropertyGroup }

function TIndexedObjectPropertyGroup.Add(out Wrapper: IInterface): Integer;
begin
  Wrapper := TIndexedObjectPropertyInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper);
end;

constructor TIndexedObjectPropertyGroup.Create(AObject: TObject;
  AIndexedProperty: TRttiIndexedProperty; MetaClass: TClass;
  const Binding: ICompiledBinding);
begin
  inherited Create(AObject, AIndexedProperty, MetaClass, True, Binding);
end;

{ TObjectPropertyGroup }

function TObjectPropertyGroup.Add(out Wrapper: IInterface): Integer;
begin
  Wrapper := TObjectPropertyInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper);
end;

constructor TObjectPropertyGroup.Create(AObject: TObject;
  AProperty: TRttiProperty; MetaClass: TClass; EvalTimeOnly: Boolean;
  const Binding: ICompiledBinding);
begin
  inherited Create(AObject, AProperty, MetaClass, EvalTimeOnly, Binding);
end;

{ TAbstractObjectPropertyInstance }

procedure TPhysicalObjectMemberInstance.Attach(Obj: TObject);
begin
  if not FAttaching then
  begin
    FAttaching := True;

    // attach only the object of the group to have a proper value for the
    // result of the property and attach all other wrappers contained in the
    // scope of this property instance wrapper
    Group.AttachObjectOnly(Obj);

    // attach the subwrappers in the cache
    if CanCache then
      case CacheType of
        ctObject:
          ObjectCache.Attach(GetValue.AsObject);
        ctRecord:
          RecordCache.Attach(GetValue);
      end;

    // now attach-notify the group to reattach the other property instance wrappers
    // that it contains
    Group.Attach(Obj);

    FAttaching := False;
  end;
end;

constructor TPhysicalObjectMemberInstance.Create(
  Group: TPhysicalObjectMemberGroup);
begin
  inherited Create(Group);
end;

procedure TPhysicalObjectMemberInstance.Detach;
begin
  if not FAttaching then
  begin
    FAttaching := True;

    Group.DetachObjectOnly;

    if CanCache then
      case CacheType of
        ctObject:
          ObjectCache.Detach;
        ctRecord:
          RecordCache.Detach;
      end;

    Group.Detach;

    FAttaching := False;
  end;
end;

constructor TAbstractObjectMemberInstance.Create(
  Group: TAbstractObjectMemberGroup);
begin
  inherited Create(Group)
end;

function TAbstractObjectMemberInstance.CreateObjectCache: TObjectWrapper;
var
  LCtx: TRttiContext;
  LValue: TObject;
  LValueClass: TClass;
begin
  LCtx := TRttiContext.Create;
  try
    LValue := GetValue.AsObject;
  except
    // Value may not be available at compile time
    LValue := nil;
  end;
  LValueClass := (LCtx.GetType(GetType) as TRttiInstanceType).MetaclassType;

  Result := TObjectWrapper.Create(LValue, LValueClass, False, GetEvalTimeOnly, GetBinding);
end;

function TAbstractObjectMemberInstance.CreateRecordCache: TRecordWrapper;
begin
  Result := TRecordWrapper.Create(GetValue, GetType, GetEvalTimeOnly, GetBinding);
end;

destructor TAbstractObjectMemberInstance.Destroy;
begin
  FCacheCounter := nil;

  inherited;
end;

function TPhysicalObjectMemberInstance.GetGroup: TPhysicalObjectMemberGroup;
begin
  Result := TPhysicalObjectMemberGroup(inherited Group);
end;

function TPhysicalObjectMemberInstance.GetMember: TRttiMember;
begin
  Result := Group.GetMember;
end;

{ TObjectMethodGroup }

function TObjectMethodGroup.Add(out Wrapper: IInterface): Integer;
begin
                                                                               
  Wrapper := TObjectMethodInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper);
end;

constructor TObjectMethodGroup.Create(AObject: TObject; AMethod: TRttiMethod;
  MetaClass: TClass; const Binding: ICompiledBinding);
begin
  inherited Create(AObject, AMethod, MetaClass, True, Binding);
end;

{ TAbstractParamedObjectMemberInstance }

function TPhysicalParamedObjectMemberInstance.GetArgs: TArray<TValue>;
begin
  Result := FArgs;
end;

procedure TPhysicalParamedObjectMemberInstance.SetArgs(
  const Args: TArray<TValue>);
begin
  FArgs := Args;
end;

{ TObjectMethodInstance }

constructor TObjectMethodInstance.Create(Group: TObjectMethodGroup);
begin
  inherited Create(Group);
end;

function TObjectMethodInstance.GetType: PTypeInfo;
var
  LReturnType: TRttiType;
begin
  LReturnType  := TRttiMethod(GetMember).ReturnType;
  // it is a function and has a result type
  if Assigned(LReturnType) then
    Result := TRttiMethod(GetMember).ReturnType.Handle
  else // it is a procedure without any result type
    Result := nil;
end;

function TObjectMethodInstance.GetValue: TValue;
begin
  Result := FValue;
end;

function TObjectMethodInstance.Invoke(const Args: TArray<IValue>): IValue;
var
  LParent: TObject;
  LClassType: TClass;
  LMethod: TRttiMethod;
  LMethodResult: TValue;
  LHasStructResult: Boolean; // indicates that the result is structured (object or record)
begin
  LParent := GetParent;
  LMethod := TRttiMethod(GetMember);
  SetArgs(AdaptArguments(Args));

  if LMethod.IsClassMethod then
  begin
    // determine the RTTI to use based on the existence of the object to which
    // the method wrapper is attached
    if Assigned(LParent) then
      LClassType := LParent.ClassType
    else
      LClassType := GetMetaClass;

                                                                    
    LMethodResult := LMethod.Invoke(LClassType, GetArgs)
  end
  else
    if LMethod.IsStatic then
      LMethodResult := LMethod.Invoke(nil, GetArgs)
    else
      if Assigned(LParent) then
        LMethodResult := LMethod.Invoke(LParent, GetArgs)
      else
        LMethodResult := TValue.Empty;

  LHasStructResult := LMethodResult.IsObject or
                     (LMethodResult.IsEmpty and (LMethodResult.TypeInfo^.Kind = tkRecord));
  if LHasStructResult then
    // the implementation of IValue is done by the method wrapper instead;
    // it is done like this to avoid querying the cache for interface references
    Result := Self
  else
    Result := TValueWrapper.Create(LMethodResult);

  // the return value is set to whatever result we have: object or other types of results;
  // store the actual value of the result internally and reattach this wrapper
  // to trigger a chain of reattachments for the contained wrappers
  FValue := LMethodResult;
  if LHasStructResult then
    Attach(LParent);
end;

procedure TObjectMethodInstance.SetValue(const AValue: TValue);
begin
  FValue := AValue;
end;

{ TObjectFieldGroup }

function TObjectFieldGroup.Add(out Wrapper: IInterface): Integer;
begin
  Wrapper := TObjectFieldInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper);
end;

constructor TObjectFieldGroup.Create(AObject: TObject; AField: TRttiField;
  MetaClass: TClass; EvalTimeOnly: Boolean; const Binding: ICompiledBinding);
begin
  inherited Create(AObject, AField, MetaClass, EvalTimeOnly, Binding);
end;

{ TObjectFieldInstance }

constructor TObjectFieldInstance.Create(Group: TObjectFieldGroup);
begin
  inherited Create(Group);
end;

function TObjectFieldInstance.GetType: PTypeInfo;
begin
  Result := TRttiField(GetMember).FieldType.Handle;
end;

function TObjectFieldInstance.GetValue: TValue;
var
  LParent: TObject;
begin
  LParent := GetParent;
  if Assigned(LParent) then
    Result := TRttiField(GetMember).GetValue(LParent)
  else
    Result := TValue.Empty;
end;

procedure TObjectFieldInstance.SetValue(const AValue: TValue);
var
  LParent: TObject;
begin
  LParent := GetParent;
  if Assigned(LParent) then
    TRttiField(GetMember).SetValue(LParent, AValue);
end;

{ TVirtualMemberInstance }

procedure TVirtualObjectMemberInstance.Attach(Obj: TObject);
begin
  if not FAttaching then
  begin
    FAttaching := True;

    // reattach the contained wrappers
    if CanCache then
      case CacheType of
        ctObject:
          ObjectCache.Attach(GetValue.AsObject);
        ctRecord:
          RecordCache.Attach(GetValue);
      end;

    // reattach the group, the custom wrapper and the other virtual instance
    // siblings to the same object
    Group.Attach(Obj);

    FAttaching := False;
  end;
end;

function TVirtualObjectMemberInstance.CanCache: Boolean;
begin
  Result := True;
end;

constructor TVirtualObjectMemberInstance.Create(Group: TVirtualObjectMemberGroup);
begin
  inherited Create(Group);
end;

procedure TVirtualObjectMemberInstance.Detach;
begin
  if not FAttaching then
  begin
    FAttaching := True;

    if CanCache then
      case CacheType of
        ctObject:
          ObjectCache.Detach;
        ctRecord:
          RecordCache.Detach;
      end;
    Group.Detach;

    FAttaching := False;
  end;
end;

function TVirtualObjectMemberInstance.GetArgs: TArray<TValue>;
begin
  Result := FArgs;
end;

function TVirtualObjectMemberInstance.GetCache: TAbstractStructuredWrapper;
var
  LType: PTypeInfo;
begin
  Result := inherited GetCache;
  LType := GetType;

  // create the default cache of object type in order to store the subwrappers somewhere
  if not Assigned(Result) and not Assigned(LType)  then
  begin
    FCache := CreateObjectCache;
    FCacheCounter := FCache;
    FCacheType := TCacheType.ctObject;

    Result := FCache;
  end
  else
    // check if the object cache is appropriate for the actual type of the wrapped value
    if Assigned(Result) and Assigned(LType) then
      case CacheType of
        ctObject:
          if LType^.Kind = tkRecord then
            ConvertCache(TCacheType.ctRecord);
        ctRecord:
          if LType^.Kind = tkClass then
            ConvertCache(TCacheType.ctObject);
      end;
end;

function TVirtualObjectMemberInstance.GetCustomWrapper: IInterface;
begin
  Result := TVirtualObjectMemberGroup(FGroup).FCustomWrapper;
end;

function TVirtualObjectMemberInstance.GetType: PTypeInfo;
begin
  if GetWrapperType in [cwtProperty, cwtIndexedProperty] then
    Result := (GetCustomWrapper as IValue).GetType
  else
    Result := FValue.TypeInfo;
end;

function TVirtualObjectMemberInstance.GetValue: TValue;
begin
  // the value can be updated using GetValue only for properties; for methods,
  // it will return the last result, if any
  if GetWrapperType in [cwtProperty, cwtIndexedProperty] then
    FValue := (GetCustomWrapper as IValue).GetValue;

  Result := FValue;
end;

function TVirtualObjectMemberInstance.GetWrapperType: TCustomWrapperType;
begin
  Result := (GetCustomWrapper as ICustomWrapper).WrapperType;
end;

function TVirtualObjectMemberInstance.Invoke(const Args: TArray<IValue>): IValue;
var
  ResVal: TValue;
begin
  Result := (GetCustomWrapper as IInvokable).Invoke(Args);

  // we are dealing with an object result and we can't use TValueWrapper returned
  // by the custom wrapper because it doesn't have support for all the necessary
  // interfaces that a wrapped object needs;
  // we must re-attach the resulting object to the cache and return the
  // virtual wrapper instance as an IValue
  ResVal := Result.GetValue;
  if not ResVal.IsEmpty and (ResVal.TypeInfo^.Kind in [tkClass, tkRecord]) then
    if CanCache then
    begin
      case CacheType of
        ctObject:
          ObjectCache.Attach(ResVal.AsObject);
        ctRecord:
          RecordCache.Attach(ResVal);
      end;

      Result := Self;
    end;
end;

procedure TVirtualObjectMemberInstance.ConvertCache(ToType: TAbstractMemberInstance.TCacheType);
var
  LCache: TAbstractStructuredWrapper;
  LCacheCounter: IInterface;
begin
  if ToType <> TCacheType.ctNone then
  begin
    // create the new record cache
    case ToType of
      ctObject:
        LCache := CreateObjectCache;
      ctRecord:
        LCache := CreateRecordCache;
      else
        LCache := nil;
    end;
    LCacheCounter := LCache;

    // generate the record cache contents and replace the current cache
    TransformCache(FCache, LCache);
    FCache := LCache;
    FCacheCounter := FCache; // free the old cache cache
    FCacheType := TCacheType.ctRecord;
  end;
end;

function TVirtualObjectMemberInstance.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  // depending on the custom wrapper type, it returns the appropriate interfaces
  // that the virtual wrapper is supposed to support
  if ((IID = IValue) or (IID = IInvokable) or (IID = IArguments)) and
     (not Supports(GetCustomWrapper, IID)) then
    Result := E_NOINTERFACE
  else
    Result := inherited QueryInterface(IID, Obj);
end;

procedure TVirtualObjectMemberInstance.SetArgs(const Args: TArray<TValue>);
begin
  FArgs := Args;
  (GetCustomWrapper as IArguments).SetArgs(FArgs);
end;

procedure TVirtualObjectMemberInstance.SetValue(const AValue: TValue);
begin
                                                                            
  raise EWrapperError.Create(sVirtualMemberReadOnly);
end;

procedure TVirtualObjectMemberInstance.TransformCache(
  const FromCache, ToCache: IInterface);
var
  FromCacheSym: IScopeSymbols;
  FromCacheScope: IScope;
  ToCacheScope: IScope;
  FromWrpr: IInterface;
  ToWrpr: IInterface;
  i: Integer;
begin
  if Supports(FromCache, IScope, FromCacheScope) and
     Supports(FromCache, IScopeSymbols, FromCacheSym) and
     Supports(ToCache, IScope, ToCacheScope) then
    for i := 0 to FromCacheSym.SymbolCount - 1 do
    begin
      // grab the wrapper from the object cache and create a wrapper in the
      // record cache for the current symbol
      FromWrpr := FromCacheScope.Lookup(FromCacheSym.Symbols[i]);
      ToWrpr := ToCacheScope.Lookup(FromCacheSym.Symbols[i]);

      // the cache can contain only group wrappers; copy the group wrappers
      // in a depth-first manner
      TransformGroup(FromWrpr, ToWrpr);
    end;
end;

procedure TVirtualObjectMemberInstance.TransformGroup(
  const FromWrpr, ToWrpr: IInterface);
var
  FromGroup: IGroup;
  ToGroup: IGroup;
  FromDynGrp: IDynamicGroup;
  ToDynGrp: IDynamicGroup;
  i: Integer;
begin
  // setting the fixed group of a dynamic group automatically adds the correct
  // number of dynamic instances
  if Supports(FromWrpr, IDynamicGroup, FromDynGrp) then
    if Supports(ToWrpr, IDynamicGroup, ToDynGrp) then
      ToDynGrp.FixedGroup := FromDynGrp.FixedGroup
    else
      raise EWrapperError.CreateFmt(sConvertWrapperFail, ['IDynamicGroup'])
  else
  // the destination group needs to have the same number of instances
  // as the source group
  if Supports(FromWrpr, IGroup, FromGroup) then
    if Supports(ToWrpr, IGroup, ToGroup) then
      for i := 1 to FromGroup.WrapperCount - ToDynGrp.WrapperCount do
        ToGroup.Add
    else
      raise EWrapperError.CreateFmt(sConvertWrapperFail, ['IGroup']);

  // transform each instance from the source group to the destination one
  if Supports(FromWrpr, IGroup, FromGroup) then
    for i := 0 to FromGroup.WrapperCount - 1 do
      TransformInstance(FromGroup.Wrappers[i], ToGroup.Wrappers[i]);
end;

procedure TVirtualObjectMemberInstance.TransformInstance(
  const FromWrpr, ToWrpr: IInterface);
var
  FromArguments: IArguments;
  ToArguments: IArguments;
begin
  // copy the necessary arguments
  if Supports(FromWrpr, IArguments, FromArguments) then
    if Supports(ToWrpr, IArguments, ToArguments) then
      ToArguments.Args := FromArguments.Args
    else
      raise EWrapperError.CreateFmt(sConvertWrapperFail, ['IArguments']);

  // transform the subwrappers from the source group to the destination group
  TransformCache(FromWrpr, ToWrpr);
end;

{ TAbstractObjectMemberGroup }

constructor TAbstractObjectMemberGroup.Create(EvalTimeOnly: Boolean;
  const Binding: ICompiledBinding);
begin
  inherited Create(Binding);

  FEvalTimeOnly := EvalTimeOnly;
end;

function TAbstractObjectMemberGroup.GetAttached: Boolean;
begin
  Result := GetAttachment <> nil;
end;

function TAbstractObjectMemberGroup.GetEvalTimeOnly: Boolean;
begin
  Result := FEvalTimeOnly;
end;

{ TVirtualObjectMemberGroup }

function TVirtualObjectMemberGroup.Add(out Wrapper: IInterface): Integer;
begin
  Wrapper := TVirtualObjectMemberInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper)
end;

procedure TVirtualObjectMemberGroup.Attach(Obj: TObject);
var
  LWrapperInstance: IInterface;
  LPlaceholder: IPlaceholder;
begin
  if not FAttaching then
  begin
    FAttaching := True;

    // attach the custom wrapper to the new object
    (FCustomWrapper as IPlaceholder).Attach(Obj);

    // make all the virtual instances attach themselves to the new object
    for LWrapperInstance in Self do
      if Supports(LWrapperInstance, IPlaceholder, LPlaceholder) then
        LPlaceholder.Attach(Obj);

    FAttaching := False;
  end;
end;

procedure TVirtualObjectMemberGroup.CheckCustomWrapper(
  const Wrapper: IInterface);
begin
  CheckIntfSupport(Wrapper, ICustomWrapper, 'ICustomWrapper');
  case (Wrapper as ICustomWrapper).WrapperType of
    cwtProperty:
        CheckIntfSupport(Wrapper, IValue, 'IValue');
    cwtMethod:
        CheckIntfSupport(Wrapper, IInvokable, 'IInvokable');
    cwtIndexedProperty:
      begin
        CheckIntfSupport(Wrapper, IValue, 'IValue');
        CheckIntfSupport(Wrapper, IArguments, 'IArguments');
      end;
  end;
end;

procedure TVirtualObjectMemberGroup.CheckIntfSupport(const Wrapper: IInterface;
  const IID: TGUID; const IntfName: String);
begin
  if not Supports(Wrapper, ICustomWrapper) then
    raise EWrapperError.CreateFmt(sInvalidCustomWrapper, [IntfName]);
end;

constructor TVirtualObjectMemberGroup.Create(const CustomWrapper: IInterface;
  const Binding: ICompiledBinding);
begin
  inherited Create(True, Binding);

  CheckCustomWrapper(CustomWrapper);
  FCustomWrapper := CustomWrapper;
  FWrapperType := (FCustomWrapper as ICustomWrapper).WrapperType;
end;

procedure TVirtualObjectMemberGroup.Detach;
var
  LWrapperInstance: IInterface;
  LPlaceholder: IPlaceholder;
begin
  if not FAttaching then
  begin
    FAttaching := True;

    // detach the custom wrapper from the object
    (FCustomWrapper as IPlaceholder).Detach;

    // detach all the virtual member instances from the parent object
    for LWrapperInstance in Self do
      if Supports(LWrapperInstance, IPlaceholder, LPlaceholder) then
        LPlaceholder.Detach;

    FAttaching := False;
  end;
end;

function TVirtualObjectMemberGroup.GetAttachment: TObject;
begin
  Result := (FCustomWrapper as IPlaceholder).GetAttachment;
end;

function TVirtualObjectMemberGroup.GetMemberName: String;
begin
  Result := (FCustomWrapper as IChild).GetMemberName;
end;

function TVirtualObjectMemberGroup.GetMetaClass: TClass;
begin
  Result := (FCustomWrapper as IPlaceholder).GetMetaClass;
end;

function TVirtualObjectMemberGroup.GetParent: TObject;
begin
  Result := (FCustomWrapper as IChild).GetParent;
end;

{ TAbstractObjectMemberInstance }

function TAbstractObjectMemberInstance.GetAttached: Boolean;
begin
  Result := Group.GetAttached;
end;

function TAbstractObjectMemberInstance.GetAttachment: TObject;
begin
  Result := Group.GetAttachment;
end;

function TAbstractObjectMemberInstance.GetEvalTimeOnly: Boolean;
begin
  Result := Group.GetEvalTimeOnly;
end;

function TAbstractObjectMemberInstance.GetGroup: TAbstractObjectMemberGroup;
begin
  Result := TAbstractObjectMemberGroup(FGroup);
end;

function TAbstractObjectMemberInstance.GetMemberName: String;
begin
  Result := Group.GetMemberName;
end;

function TAbstractObjectMemberInstance.GetMetaClass: TClass;
begin
  Result := Group.GetMetaClass;
end;

function TAbstractObjectMemberInstance.GetParent: TObject;
begin
  Result := Group.GetParent;
end;

{ TDynamicObjectMemberInstance }

procedure TDynamicObjectMemberInstance.Attach(Obj: TObject);
var
  LPlaceholder: IPlaceholder;
begin
  inherited;

  if Supports(FFixedInstance, IPlaceholder, LPlaceholder) then
    LPlaceholder.Attach(Obj);
end;

constructor TDynamicObjectMemberInstance.Create(
  Group: TDynamicObjectMemberGroup);
begin
  inherited Create(Group);
end;

procedure TDynamicObjectMemberInstance.Detach;
var
  LPlaceholder: IPlaceholder;
begin
  inherited;

  if Supports(FFixedInstance, IPlaceholder, LPlaceholder) then
    LPlaceholder.Detach;
end;

function TDynamicObjectMemberInstance.GetArgs: TArray<TValue>;
var
  LArguments: IArguments;
begin
  if Supports(FFixedInstance, IArguments, LArguments) then
    Result := LArguments.GetArgs
  else
    Result := nil;
end;

function TDynamicObjectMemberInstance.GetFixedInstance: IInterface;
begin
  Result := FFixedInstance;
end;

function TDynamicObjectMemberInstance.GetType: PTypeInfo;
var
  LValue: IValue;
begin
  // the type is given by the actual type of stored by the fixed instance wrapper;
  // if there is not fixed instance wrapper specified yet, the type of the
  // dynamic instance is considered to be an object
  if Supports(FFixedInstance, IValue, LValue) then
    Result := LValue.GetType
  else
    Result := TObject.ClassInfo;
end;

function TDynamicObjectMemberInstance.GetValue: TValue;
var
  LValue: IValue;
begin
  if Supports(FFixedInstance, IValue, LValue) then
    Result := LValue.GetValue
  else
    Result := TValue.Empty;
end;

function TDynamicObjectMemberInstance.Invoke(
  const Args: TArray<IValue>): IValue;
var
  LInvokable: IInvokable;
begin
  if Supports(FFixedInstance, IInvokable, LInvokable) then
    Result := LInvokable.Invoke(Args)
  else
    Result := Self;
end;

procedure TDynamicObjectMemberInstance.SetArgs(const Args: TArray<TValue>);
var
  LArguments: IArguments;
begin
  if Supports(FFixedInstance, IArguments, LArguments) then
    LArguments.SetArgs(Args);
end;

procedure TDynamicObjectMemberInstance.SetFixedInstance(
  const Instance: IInterface);
begin
  FFixedInstance := Instance;
end;

procedure TDynamicObjectMemberInstance.SetValue(const AValue: TValue);
var
  LLocation: ILocation;
begin
  if Supports(FFixedInstance, ILocation, LLocation) then
    LLocation.SetValue(AValue);
end;

{ TDynamicObjectMemberGroup }

function TDynamicObjectMemberGroup.Add(out Wrapper: IInterface): Integer;
begin
  Wrapper := TDynamicObjectMemberInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper);
end;

constructor TDynamicObjectMemberGroup.Create(AObject: TObject;
  AMemberName: String; MetaClass: TClass; const Binding: ICompiledBinding);
begin
  inherited Create(AObject, nil, MetaClass, True, Binding);

  FMemberName := AMemberName;
end;

function TDynamicObjectMemberGroup.GetFixedGroup: IGroup;
begin
  Result := FFixedGroup;
end;

function TDynamicObjectMemberGroup.GetMember: TRttiMember;
begin
  if Assigned(FFixedGroup) then
    Result := (FFixedGroup as IRttiChild).GetMember
  else
    Result := nil;
end;

function TDynamicObjectMemberGroup.GetMemberName: String;
begin
  Result := FMemberName;
end;

procedure TDynamicObjectMemberGroup.SetFixedGroup(const Group: IGroup);
var
  Instance: IDynamicInstance;
  i: Integer;
begin
  FFixedGroup := Group;

  if Assigned(Group) then
  begin
    // the fixed group must have the same number of group member instances
    // as this dynamic group; the dynamic group is the driver and the fixed
    // group is the storage
    for i := 1 to WrapperCount - Group.WrapperCount do
      Group.Add;

    // link the dynamic instances to the fixed instances in the two groups
    // based on their indexed positions
    for i := 0 to WrapperCount - 1 do
      if Supports(Wrappers[i], IDynamicInstance, Instance) then
        Instance.FixedInstance := Group.Wrappers[i];
  end;
end;

{ TAbstractStructuredWrapper }

procedure TAbstractStructuredWrapper.Add(const Symbol: String);
begin
  FSymbols.Add(Symbol);
end;

procedure TAbstractStructuredWrapper.Clear;
begin
  FSymbols.Clear;
end;

function TAbstractStructuredWrapper.Contains(const Symbol: String): Boolean;
begin
  Result := FSymbols.Contains(Symbol);
end;

constructor TAbstractStructuredWrapper.Create(EvalTimeOnly: Boolean;
  const Binding: ICompiledBinding);
begin
  inherited Create;

  FCtx := TRttiContext.Create;
  FCache := TDictionaryScope.Create;
  FCacheCounter := FCache;
  FSymbols := TSymbols.Create;
  FEvalTimeOnly := EvalTimeOnly;
  FBinding := Pointer(Binding);
end;

destructor TAbstractStructuredWrapper.Destroy;
begin
  FSymbols.Free;
  FCacheCounter := nil;

  inherited;
end;

function TAbstractStructuredWrapper.GetBinding: ICompiledBinding;
begin
  Result := ICompiledBinding(FBinding);
end;

function TAbstractStructuredWrapper.GetEnumerator: IScopeEnumerator;
begin
  Result := FCache.GetEnumerator;
end;

function TAbstractStructuredWrapper.GetSymbolCount: Integer;
begin
  Result := FSymbols.Count;
end;

function TAbstractStructuredWrapper.GetSymbols(Index: Integer): String;
begin
  Result := FSymbols[Index];
end;

function TAbstractStructuredWrapper.LookupRtti(const Name: String): IInterface;
var
  RttiType: TRttiType;
begin
  RttiType := FCtx.GetType(GetType);

  // verify if it is a method name
  Result := LookupMethod(RttiType, Name);
  // verify if it is a property name
  if not Assigned(Result) then
    Result := LookupProperty(RttiType, Name);
  // verify if it is an indexed property
  if not Assigned(Result) then
    Result := LookupIndexedProperty(RttiType, Name);
  // verify if it is a field name
  if not Assigned(Result) then
    Result := LookupField(RttiType, Name);
end;

procedure TAbstractStructuredWrapper.Remove(const Symbol: String);
begin
  FSymbols.Remove(Symbol);
end;

procedure TAbstractStructuredWrapper.SetBinding(
  const Binding: ICompiledBinding);
begin
  FBinding := Pointer(Binding);
end;

procedure TAbstractStructuredWrapper.SetSymbols(Index: Integer;
  const Value: String);
begin
  FSymbols[Index] := Value;
end;

{ TRecordWrapper }

procedure TRecordWrapper.Attach(Rec: TValue);
var
  LWrpr: IInterface;
  LPlaceholder: IRecordPlaceholder;
begin
                                                                            

  FRecord := Rec;

  for LWrpr in Self do
    if Supports(LWrpr, IRecordPlaceholder, LPlaceholder) then
      LPlaceholder.Attach(GetValue);
end;

constructor TRecordWrapper.Create(ARecord: TValue; ATypeInfo: PTypeInfo;
  EvalTimeOnly: Boolean; const Binding: ICompiledBinding);
begin
  inherited Create(EvalTimeOnly, Binding);

                                                                                      
  FRecord := ARecord;
  FTypeInfo := ATypeInfo;
end;

procedure TRecordWrapper.Detach;
var
  LWrpr: IInterface;
  LPlaceholder: IRecordPlaceholder;
begin
  FRecord := TValue.Empty;

  for LWrpr in Self do
    if Supports(LWrpr, IRecordPlaceholder, LPlaceholder) then
      LPlaceholder.Detach;
end;

function TRecordWrapper.GetAttached: Boolean;
begin
  Result := not FRecord.IsEmpty;
end;

function TRecordWrapper.GetAttachment: TValue;
begin
  Result := FRecord;
end;

function TRecordWrapper.GetEvalTimeOnly: Boolean;
begin
  Result := FEvalTimeOnly;
end;

function TRecordWrapper.GetType: PTypeInfo;
begin
  Result := FTypeInfo;
end;

function TRecordWrapper.GetValue: TValue;
begin
  Result := FRecord;
end;

function TRecordWrapper.Lookup(const Name: string): IInterface;
begin
  Result := FCache.Lookup(Name);

  if not Assigned(Result) then
  begin
    Result := LookupRtti(Name);

    if Assigned(Result) then
      FCache.Map.AddOrSetValue(Name, Result);
  end;
end;

function TRecordWrapper.Lookup(Obj: TObject): IInterface;
begin
  Result := FCache.Lookup(Obj);
end;

function TRecordWrapper.LookupField(RttiType: TRttiType;
  const Name: String): IInterface;
var
  LField: TRttiField;
begin
  LField := RttiType.GetField(Name);
  if Assigned(LField) then
    Result := TRecordFieldGroup.Create(FRecord, LField, GetEvalTimeOnly, GetBinding)
  else
    Result := nil;
end;

function TRecordWrapper.LookupIndexedProperty(RttiType: TRttiType;
  const Name: String): IInterface;
var
  LIndexedProperty: TRttiIndexedProperty;
begin
  LIndexedProperty := RttiType.GetIndexedProperty(Name);
  if Assigned(LIndexedProperty) then
    Result := TIndexedRecordPropertyGroup.Create(FRecord, LIndexedProperty, GetBinding)
  else
    Result := nil;
end;

function TRecordWrapper.LookupMethod(RttiType: TRttiType;
  const Name: String): IInterface;
var
  LMethod: TRttiMethod;
begin
  LMethod := RttiType.GetMethod(Name);
  if Assigned(LMethod) then
    Result := TRecordMethodGroup.Create(FRecord, LMethod, GetBinding)
  else
    Result := nil;
end;

function TRecordWrapper.LookupProperty(RttiType: TRttiType;
  const Name: String): IInterface;
var
  LProperty: TRttiProperty;
begin
  LProperty := RttiType.GetProperty(Name);
  if Assigned(LProperty) then
    Result := TRecordPropertyGroup.Create(FRecord, LProperty, GetEvalTimeOnly, GetBinding)
  else
    Result := nil;
end;

procedure TRecordWrapper.SetValue(const AValue: TValue);
begin
                                                                  
  FRecord := AValue;
end;

{ TAbstractMemberGroup }

function TAbstractMemberGroup.Add: Integer;
var
  LWrapper: IInterface;
begin
  Result := Add(LWrapper);
end;

procedure TAbstractMemberGroup.Clear;
begin
  FCache.Wrappers.Clear;
end;

constructor TAbstractMemberGroup.Create(const Binding: ICompiledBinding);
begin
  inherited Create;

  FCache := TObjectMemberGroupScope.Create;
  FCacheCounter := FCache;
  FBinding := Pointer(Binding);
end;

destructor TAbstractMemberGroup.Destroy;
begin
  FCacheCounter := nil;

  inherited;
end;

function TAbstractMemberGroup.GetBinding: ICompiledBinding;
begin
  Result := ICompiledBinding(FBinding);
end;

function TAbstractMemberGroup.GetEnumerator: IScopeEnumerator;
begin
  Result := FCache.GetEnumerator;
end;

function TAbstractMemberGroup.GetWrapperCount: Integer;
begin
  Result := FCache.Wrappers.Count;
end;

function TAbstractMemberGroup.GetWrappers(Index: Integer): IInterface;
begin
  Result := FCache.Wrappers[Index];
end;

procedure TAbstractMemberGroup.SetBinding(const Binding: ICompiledBinding);
begin
  FBinding := Pointer(Binding);
end;

{ TPhysicalRecordMemberGroup }

procedure TPhysicalRecordMemberGroup.Attach(Rec: TValue);
var
  LResultWrapper: IInterface;
  LPlaceholder: IRecordPlaceholder;
begin
  if not FAttaching then
  begin
    FAttaching := True;

    AttachRecordOnly(Rec);
    for LResultWrapper in Self do
      if Supports(LResultWrapper, IRecordPlaceholder, LPlaceholder) then
        LPlaceholder.Attach(Rec);

    FAttaching := False;
  end;
end;

procedure TPhysicalRecordMemberGroup.AttachRecordOnly(Rec: TValue);
begin
  FRecord := Rec;
end;

constructor TPhysicalRecordMemberGroup.Create(ARecord: TValue;
  AMember: TRttiMember; EvalTimeOnly: Boolean; const Binding: ICompiledBinding);
begin
  inherited Create(Binding);

                                                                              
// or an empty value
  FRecord := ARecord;
  FMember := AMember;
  FEvalTimeOnly := EvalTimeOnly;
end;

procedure TPhysicalRecordMemberGroup.Detach;
var
  LResultWrapper: IInterface;
  LPlaceholder: IRecordPlaceholder;
begin
  if not FAttaching then
  begin
    FAttaching := True;

    DetachRecordOnly;
    for LResultWrapper in Self do
      if Supports(LResultWrapper, IRecordPlaceholder, LPlaceholder) then
        LPlaceholder.Detach;

    FAttaching := False;
  end;
end;

procedure TPhysicalRecordMemberGroup.DetachRecordOnly;
begin
  FRecord := TValue.Empty;
end;

function TPhysicalRecordMemberGroup.GetAttached: Boolean;
begin
  Result := not FRecord.IsEmpty;
end;

function TPhysicalRecordMemberGroup.GetAttachment: TValue;
begin
  Result := FRecord;
end;

function TPhysicalRecordMemberGroup.GetEvalTimeOnly: Boolean;
begin
  Result := FEvalTimeOnly;
end;

function TPhysicalRecordMemberGroup.GetMember: TRttiMember;
begin
  Result := FMember;
end;

function TPhysicalRecordMemberGroup.GetParent: TValue;
begin
  Result := FRecord;
end;

{ TRecordPropertyGroup }

function TRecordPropertyGroup.Add(out Wrapper: IInterface): Integer;
begin
                                                                     
  Wrapper := TRecordPropertyInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper);
end;

constructor TRecordPropertyGroup.Create(ARecord: TValue;
  AProperty: TRttiProperty; EvalTimeOnly: Boolean;
  const Binding: ICompiledBinding);
begin
  inherited Create(ARecord, AProperty, EvalTimeOnly, Binding);
end;

{ TAbstractMemberInstance }

procedure TAbstractMemberInstance.Add(const Symbol: String);
begin
  Cache.Add(Symbol);
end;

function TAbstractMemberInstance.CanCache: Boolean;
begin
  Result := IsStructuredType;
end;

procedure TAbstractMemberInstance.Clear;
begin
  Cache.Clear;
end;

function TAbstractMemberInstance.Contains(const Symbol: String): Boolean;
begin
  Result := Cache.Contains(Symbol)
end;

constructor TAbstractMemberInstance.Create(Group: TAbstractMemberGroup);
begin
  inherited Create;

  if not Assigned(Group) then
    raise EWrapperError.CreateFmt(SParamIsNil, ['Group']);

  FGroup := Group;
end;

destructor TAbstractMemberInstance.Destroy;
begin
  FCacheCounter := nil;

  inherited;
end;

function TAbstractMemberInstance.GetBinding: ICompiledBinding;
begin
  Result := FGroup.GetBinding;
end;

function TAbstractMemberInstance.GetCache: TAbstractStructuredWrapper;
var
  LType: PTypeInfo;
begin
  // create the internal object wrapper only if the property points to an object
  if CanCache and not HasCache then
  begin
    LType := GetType;

    // determine if we can have a cache and if it's type is a regular one (object or record)
    if Assigned(LType) then
      case LType^.Kind of
        tkClass: // use a TObjectWrapper cache
          begin
            FCache := CreateObjectCache;
            FCacheType := TCacheType.ctObject
          end;
        tkRecord: // use a TRecordWrapper cache
          begin
            FCache := CreateRecordCache;
            FCacheType := TCacheType.ctRecord;
          end
        else // can't use cache on this result type
          FCacheType := TCacheType.ctNone;
      end;

    FCacheCounter := FCache;
  end;

  Result := FCache;
end;

function TAbstractMemberInstance.GetEnumerator: IScopeEnumerator;
begin
  Result := Cache.GetEnumerator;
end;

function TAbstractMemberInstance.GetObjectCache: TObjectWrapper;
begin
  if CacheType = ctObject then
    Result := TObjectWrapper(FCache)
  else
    Result := nil;
end;

function TAbstractMemberInstance.GetRecordCache: TRecordWrapper;
begin
  if CacheType = ctRecord then
    Result := TRecordWrapper(FCache)
  else
    Result := nil;
end;

function TAbstractMemberInstance.GetSymbolCount: Integer;
begin
  Result := Cache.GetSymbolCount;
end;

function TAbstractMemberInstance.GetSymbols(Index: Integer): String;
begin
  Result := Cache.GetSymbols(Index);
end;

function TAbstractMemberInstance.HasCache: Boolean;
begin
  Result := Assigned(FCache);
end;

function TAbstractMemberInstance.IsStructuredType: Boolean;
var
  LTypInf: PTypeInfo;
begin
  LTypInf := GetType;
  Result := Assigned(LTypInf) and
           ((LTypInf^.Kind = tkClass) or (LTypInf^.Kind = tkRecord));
end;

function TAbstractMemberInstance.Lookup(const Name: string): IInterface;
begin
  Result := Cache.Lookup(Name);
end;

function TAbstractMemberInstance.Lookup(Obj: TObject): IInterface;
begin
  Result := Cache.Lookup(Obj);
end;

function TAbstractMemberInstance.QueryInterface(const IID: TGUID;
  out Obj): HRESULT;
begin
  // the property wrapper is not an object; don't permit querying for scope interfaces
  if (not CanCache) and
     ((IID = IScope) or
      (IID = IScopeEx) or
      (IID = IScopeEnumerable) or
      (IID = IScopeSymbols)) then
      Result := E_NOINTERFACE
  else
    Result := inherited QueryInterface(IID, Obj);
end;

procedure TAbstractMemberInstance.Remove(const Symbol: String);
begin
  Cache.Remove(Symbol);
end;

procedure TAbstractMemberInstance.SetBinding(const Binding: ICompiledBinding);
begin
  Group.SetBinding(Binding);
  if Assigned(Cache) then
    Cache.SetBinding(Binding);
end;

procedure TAbstractMemberInstance.SetSymbols(Index: Integer;
  const Value: String);
begin
  Cache.SetSymbols(Index, Value);
end;

{ TIndexedRecordPropertyGroup }

function TIndexedRecordPropertyGroup.Add(out Wrapper: IInterface): Integer;
begin
                                                                            
  Wrapper := TIndexedRecordPropertyInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper);
end;

constructor TIndexedRecordPropertyGroup.Create(ARecord: TValue;
  AProperty: TRttiIndexedProperty; const Binding: ICompiledBinding);
begin
  inherited Create(ARecord, AProperty, True, Binding);
end;

{ TRecordFieldGroup }

function TRecordFieldGroup.Add(out Wrapper: IInterface): Integer;
begin
                                                                  
  Wrapper := TRecordFieldInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper);
end;

constructor TRecordFieldGroup.Create(ARecord: TValue; AField: TRttiField;
  EvalTimeOnly: Boolean; const Binding: ICompiledBinding);
begin
  inherited Create(ARecord, AField, EvalTimeOnly, Binding);
end;

{ TRecordMethodGroup }

function TRecordMethodGroup.Add(out Wrapper: IInterface): Integer;
begin
                                                                   
  Wrapper := TRecordMethodInstance.Create(Self);
  Result := FCache.Wrappers.Add(Wrapper);
end;

constructor TRecordMethodGroup.Create(ARecord: TValue; AMethod: TRttiMethod;
  const Binding: ICompiledBinding);
begin
  inherited Create(ARecord, AMethod, True, Binding);
end;

{ TPhysicalRecordMemberInstance }

procedure TPhysicalRecordMemberInstance.Attach(Rec: TValue);
begin
  if not FAttaching then
  begin
    FAttaching := True;

    // attach only the record of the group to have a proper value for the
    // result of the property and attach all other wrappers contained in the
    // scope of this property instance wrapper
    Group.AttachRecordOnly(Rec);

    // attach the subwrappers in the cache
    if CanCache then
      case CacheType of
        ctObject:
          ObjectCache.Attach(GetValue.AsObject);
        ctRecord:
          RecordCache.Attach(GetValue);
      end;

    // now attach-notify the group to reattach the other property instance wrappers
    // that it contains
    Group.Attach(Rec);

    FAttaching := False;
  end;
end;

constructor TPhysicalRecordMemberInstance.Create(
  Group: TPhysicalRecordMemberGroup);
begin
  inherited Create(Group);
end;

function TPhysicalRecordMemberInstance.CreateObjectCache: TObjectWrapper;
var
  LCtx: TRttiContext;
  LValue: TObject;
  LValueClass: TClass;
begin
  LCtx := TRttiContext.Create;
  LValue := GetValue.AsObject;
  LValueClass := (LCtx.GetType(GetType) as TRttiInstanceType).MetaclassType;

  Result := TObjectWrapper.Create(LValue, LValueClass, False, GetEvalTimeOnly, GetBinding);
end;

function TPhysicalRecordMemberInstance.CreateRecordCache: TRecordWrapper;
begin
  Result := TRecordWrapper.Create(GetValue, GetType, GetEvalTimeOnly, GetBinding);
end;

procedure TPhysicalRecordMemberInstance.Detach;
begin
  if not FAttaching then
  begin
    FAttaching := True;

    Group.DetachRecordOnly;

    if CanCache then
      case CacheType of
        ctObject:
          ObjectCache.Detach;
        ctRecord:
          RecordCache.Detach;
      end;

    Group.Detach;

    FAttaching := False;
  end;
end;

function TPhysicalRecordMemberInstance.GetAttached: Boolean;
begin
  Result := Group.GetAttached;
end;

function TPhysicalRecordMemberInstance.GetAttachment: TValue;
begin
  Result := Group.GetAttachment;
end;

function TPhysicalRecordMemberInstance.GetEvalTimeOnly: Boolean;
begin
  Result := Group.GetEvalTimeOnly;
end;

function TPhysicalRecordMemberInstance.GetGroup: TPhysicalRecordMemberGroup;
begin
  Result := TPhysicalRecordMemberGroup(FGroup);
end;

function TPhysicalRecordMemberInstance.GetMember: TRttiMember;
begin
  Result := Group.GetMember;
end;

function TPhysicalRecordMemberInstance.GetParent: TValue;
begin
  Result := Group.GetParent;
end;

{ TPhysicalParamedRecordMemberInstance }

function TPhysicalParamedRecordMemberInstance.GetArgs: TArray<TValue>;
begin
  Result := FArgs;
end;

procedure TPhysicalParamedRecordMemberInstance.SetArgs(
  const Args: TArray<TValue>);
begin
  FArgs := Args;
end;

{ TRecordPropertyInstance }

constructor TRecordPropertyInstance.Create(Group: TRecordPropertyGroup);
begin
  inherited Create(Group);
end;

function TRecordPropertyInstance.GetType: PTypeInfo;
begin
  Result := TRttiProperty(GetMember).PropertyType.Handle;
end;

function TRecordPropertyInstance.GetValue: TValue;
var
  LParent: TValue;
begin
  LParent := GetParent;

  if not LParent.IsEmpty then
    Result := TRttiProperty(GetMember).GetValue(LParent.GetReferenceToRawData)
  else
    Result := TValue.Empty;
end;

procedure TRecordPropertyInstance.SetValue(const AValue: TValue);
var
  LParent: TValue;
begin
  LParent := GetParent;

  if not LParent.IsEmpty then
    TRttiProperty(GetMember).SetValue(LParent.GetReferenceToRawData, AValue);
end;

{ TIndexedRecordPropertyInstance }

constructor TIndexedRecordPropertyInstance.Create(
  Group: TIndexedRecordPropertyGroup);
begin
  inherited Create(Group);
end;

function TIndexedRecordPropertyInstance.GetType: PTypeInfo;
begin
  Result := TRttiIndexedProperty(GetMember).PropertyType.Handle;
end;

function TIndexedRecordPropertyInstance.GetValue: TValue;
var
  LParent: TValue;
begin
  LParent := GetParent;

  if not LParent.IsEmpty and Assigned(GetArgs()) then
    Result := TRttiIndexedProperty(GetMember).GetValue(LParent.GetReferenceToRawData, GetArgs)
  else
    Result := TValue.Empty;
end;

procedure TIndexedRecordPropertyInstance.SetArgs(const Args: TArray<TValue>);
begin
  inherited;

  Attach(GetParent);
end;

procedure TIndexedRecordPropertyInstance.SetValue(const AValue: TValue);
var
  LParent: TValue;
begin
  LParent := GetParent;

  if not LParent.IsEmpty and Assigned(GetArgs()) then
    TRttiIndexedProperty(GetMember).GetValue(LParent.GetReferenceToRawData, GetArgs);

                                                                                            
end;

{ TRecordFieldInstance }

constructor TRecordFieldInstance.Create(Group: TRecordFieldGroup);
begin
  inherited Create(Group);
end;

function TRecordFieldInstance.GetType: PTypeInfo;
begin
  Result := TRttiField(GetMember).FieldType.Handle;
end;

function TRecordFieldInstance.GetValue: TValue;
var
  LParent: TValue;
begin
  LParent := GetParent;
  if not LParent.IsEmpty then
    Result := TRttiField(GetMember).GetValue(LParent.GetReferenceToRawData)
  else
    Result := TValue.Empty;
end;

procedure TRecordFieldInstance.SetValue(const AValue: TValue);
var
  LParent: TValue;
begin
  LParent := GetParent;
  if not LParent.IsEmpty then
    TRttiField(GetMember).SetValue(LParent.GetReferenceToRawData, AValue);
end;

{ TRecordMethodInstance }

constructor TRecordMethodInstance.Create(Group: TRecordMethodGroup);
begin
  inherited Create(Group);
end;

function TRecordMethodInstance.GetType: PTypeInfo;
var
  LReturnType: TRttiType;
begin
  LReturnType  := TRttiMethod(GetMember).ReturnType;
  // it is a function and has a result type
  if Assigned(LReturnType) then
    Result := TRttiMethod(GetMember).ReturnType.Handle
  else // it is a procedure without any result type
    Result := nil;
end;

function TRecordMethodInstance.GetValue: TValue;
begin
  Result := FValue;
end;

function TRecordMethodInstance.Invoke(const Args: TArray<IValue>): IValue;
var
  LParent: TValue;
  LMethod: TRttiMethod;
  LMethodResult: TValue;
  LHasStructResult: Boolean;
begin
  LParent := GetParent;
  LMethod := TRttiMethod(GetMember);
  SetArgs(AdaptArguments(Args));

  if LMethod.IsStatic then
    LMethodResult := LMethod.Invoke(nil, GetArgs)
  else
    if not LParent.IsEmpty then
      LMethodResult := LMethod.Invoke(LParent, GetArgs)
    else
      LMethodResult := TValue.Empty;

  LHasStructResult := LMethodResult.IsObject or (LMethodResult.TypeInfo^.Kind = tkRecord);
  if LHasStructResult then
    // the implementation of IValue is done by the method wrapper instead;
    // it is done like this to avoid querying the cache for interface references
    Result := Self
  else
    Result := TValueWrapper.Create(LMethodResult);

  // the return value is set to whatever result we have: object or other types of results;
  // store the actual value of the result internally and reattach this wrapper
  // to trigger a chain of reattachments for the contained wrappers
  FValue := LMethodResult;
  if LHasStructResult then
    Attach(LParent);
end;

procedure TRecordMethodInstance.SetValue(const AValue: TValue);
begin
  FValue := AValue;
end;

end.
