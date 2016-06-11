{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.Bind.Components;

interface

uses
  System.Classes, System.SysUtils, System.Rtti, System.Generics.Collections,
  System.Bindings.Expression, System.Bindings.EvalProtocol,
  System.Bindings.Manager, System.Bindings.Outputs;

type
  TBasicBindComponent = class(TComponent)

  end;

  TCustomBindingsList = class;
  /// <summary>Base class for scope with supports linking</summary>
  TBaseLinkingBindSource = class;

  TContainedBindComponent = class abstract(TBasicBindComponent)
  private
    [weak] FBindingsList: TCustomBindingsList;
    FCategory: string;
    procedure SetBindingsList(const Value: TCustomBindingsList);
    procedure SetCategory(const Value: string);
    function GetIndex: Integer;
    procedure SetIndex(Value: Integer);
  protected
    function GetBindingsList: TCustomBindingsList; virtual;
    procedure ReadState(Reader: TReader); override;
    function GetControlComponent: TComponent; virtual; abstract;
    procedure SetControlComponent(const Value: TComponent);  virtual; abstract;
    procedure CheckControlComponent;
    function GetDisplayName: string; virtual;
    function Designing: Boolean; virtual;
    function Loading: Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanSetControlComponent(Value: TComponent): Boolean; virtual;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(AParent: TComponent); override;
    property BindingsList: TCustomBindingsList read GetBindingsList write SetBindingsList;
    [Stored(False)]
    property Index: Integer read GetIndex write SetIndex stored False;
    property ControlComponent: TComponent read GetControlComponent write SetControlComponent;
    property DisplayName: string read GetDisplayName;
  published
    property Category: string read FCategory write SetCategory;
  end;

  TBindCompExpressionType = (exprUnspecified, exprPosSource, exprPosControl, exprFill, exprParse, exprFormat, exprClear,
    exprFormatColumn, exprOther1, exprOther2, exprOther3, exprFormatControl);

  TBindCompEvalErrorEvent = procedure(Sender: TObject; AException: Exception) of object;
  TBindCompAssigningValueEvent = procedure(Sender: TObject; AssignValueRec: TBindingAssignValueRec;
     var Value: TValue; var Handled: Boolean) of object;
  TBindCompAssignedValueEvent = procedure(Sender: TObject; AssignValueRec: TBindingAssignValueRec;
     const Value: TValue) of object;

  IBindMemberChange = interface
    ['{C1A876BA-6128-477A-B7AB-60458993F366}']
    procedure MemberRenamed(AComponent: TComponent; const ACurMemberName, APrevMemberName: string);
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName, ANewMemberName: string);
    procedure MemberRemoved(AComponent: TComponent; const AMemberName: string);
  end;


  TCommonBindComponent = class(TContainedBindComponent, IBindMemberChange)
  strict private
    (*[weak]*) FSourceComponent: TComponent;
    FOnAssigningValue: TBindCompAssigningValueEvent;
    FOnAssignedValue: TBindCompAssignedValueEvent;
    FOnEvalError: TBindCompEvalErrorEvent;
    FOnLocationUpdated: TBindingLocationUpdatedEvent;
    (*[weak]*) FControlComponent: TComponent;
    FSourceMemberName: string;
  private
    FOnActivating: TNotifyEvent;
    FOnActivated: TNotifyEvent;
  protected
    { IBindMemberChange }
    procedure MemberRenamed(AComponent: TComponent; const ACurMemberName, APrevMemberName: string); virtual;
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName, ANewMemberName: string); virtual;
    procedure MemberRemoved(AComponent: TComponent; const AMemberName: string); virtual;
    function GetSourceComponent: TComponent; virtual;
    procedure SetSourceComponent(const Value: TComponent); virtual;
    procedure SetSourceMemberName(const Value: string); virtual;
    function GetSourceMemberName: string; virtual;
    procedure DoOnAssigningValue(AssignValueRec: TBindingAssignValueRec;
     var Value: TValue; var Handled: Boolean); virtual;
    procedure DoOnLocationUpdated(AOldLocation, ANewLocation: ILocation); virtual;
    procedure DoOnAssignedValue(AssignValueRec: TBindingAssignValueRec;
     const Value: TValue); virtual;
    procedure DoOnEvalError(AException: Exception); virtual;
    procedure DoOnActivating; virtual;
    procedure DoOnActivated; virtual;
    procedure DoOnDeactivating; virtual;
    procedure DoOnDeactivated; virtual;
    function GetControlScopes: TArray<IScope>;
    function GetSourceScopes: TArray<IScope>;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetControlComponent(const Value: TComponent); override;
    function GetControlComponent: TComponent; override;
    procedure FreeExpressionsObjects; virtual;
    procedure UpdateExpressions; virtual;
    procedure FreeExpressionObjects(AList: TList<TBindingExpression>);
    function GetComponentScope(AComponent: TComponent;
      const AMemberName: string=''): IScope;
    function GetComponentScopes(AComponent: TComponent;
      const AMemberName: string=''): TArray<IScope>; overload;
    function GetComponentScopes(AComponentScope: IScope): TArray<IScope>; overload;
    function GetMethodsScope: IScope;
    function GetOutputConverter: IValueRefConverter;
    function GetUseEvalShortcuts: Boolean; virtual;

    procedure UpdateSourceChanging; virtual;
    procedure UpdateSourceChanged; virtual;
    procedure UpdateControlChanging; virtual;
    procedure UpdateControlChanged; virtual;
    procedure UpdateSourceMemberChanging; virtual;
    procedure UpdateSourceMemberChanged; virtual;
    procedure EvaluateControlExpression(
      AEditorScope: IScope; const AEditorExpression: string; ACallback: TProc<IValue>); overload;
    procedure EvaluateSourceExpression(
      ASourceScope: IScope; const AEnumExpression: string; ACallback: TProc<IValue>); overload;

    procedure SetOnActivated(const Value: TNotifyEvent); virtual;
    procedure SetOnActivating(const Value: TNotifyEvent); virtual;
    procedure SetOnAssignedValue(const Value: TBindCompAssignedValueEvent); virtual;
    procedure SetOnAssigningValue(const Value: TBindCompAssigningValueEvent); virtual;
    procedure SetOnEvalError(const Value: TBindCompEvalErrorEvent); virtual;
    procedure SetOnLocationUpdated(const Value: TBindingLocationUpdatedEvent); virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EvaluateControlExpression(const AExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType = exprUnspecified); overload; virtual;
    procedure EvaluateSourceExpression(const AExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType = exprUnspecified); overload; virtual;
    procedure ExecuteAssignToControlExpression(const
      AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType = exprUnspecified); overload; virtual;
    procedure ExecuteAssignToSourceExpression(const
      AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType = exprUnspecified); virtual;
    property SourceComponent: TComponent read GetSourceComponent write SetSourceComponent;
    property SourceMemberName: string read GetSourceMemberName write SetSourceMemberName;
    property ControlComponent: TComponent read GetControlComponent write SetControlComponent;
    property OnAssigningValue: TBindCompAssigningValueEvent read FOnAssigningValue write SetOnAssigningValue;
    property OnAssignedValue: TBindCompAssignedValueEvent read FOnAssignedValue write SetOnAssignedValue;
    property OnEvalError: TBindCompEvalErrorEvent read FOnEvalError write SetOnEvalError;
    property OnLocationUpdated: TBindingLocationUpdatedEvent read FOnLocationUpdated write SetOnLocationUpdated;
    property OnActivating: TNotifyEvent read FOnActivating write SetOnActivating;
    property OnActivated: TNotifyEvent read FOnActivated write SetOnActivated;
  end;

  TContainedBindCompClass = class of TContainedBindComponent;

  TBindingsListEnumerator = class;

  TMethods = class;
  TOutputConverters = class;

  TDependency = class;
  IDependencyList = Interface
    ['{E79E5862-E1F2-4493-A642-5859A9D765D8}']
    function Add(ADependency: TDependency): TDependency;
    procedure Remove(ADependency: TDependency);
    procedure Notify(ASender: TObject; AComponent: TComponent; const AValue: string); overload;
    procedure Notify(ASender: TObject; ALocation: ILocation; const AExpr: string); overload;
    procedure Link(AComponent: TComponent; ALocation: ILocation);
    function GetLink(ALocation: ILocation): TComponent;
    procedure ClearLink(ALocation: ILocation);
  End;

  TCustomBindingsList = class(TComponent)
  private
    FBindComps: TList<TContainedBindComponent>;
    FMethods: TMethods;
    FUseAppManager: Boolean;
    FBindingsManager: TBindingManager;
    FOutputConverters: TOutputConverters;
    FOutputConverter: IValueRefConverter;
    FMethodsScope: IScope;
    FDependencyList: IDependencyList;
    FPromptDeleteUnused: Boolean;
    function GetBindComp(Index: Integer): TContainedBindComponent;
    function GetBindCompCount: Integer;
    procedure SetBindComp(Index: Integer; const Value: TContainedBindComponent);
    procedure SetMethods(const Value: TMethods);
    procedure SetOutputConverters(const Value: TOutputConverters);
    procedure SetUseAppManager(Value: Boolean);
    function GetUseAppManager: Boolean;
    function GetOutputConverterNames: TArray<string>;
  protected
    procedure AddBindComp(ABindComp: TContainedBindComponent);
    procedure RemoveBindComp(ABindComp: TContainedBindComponent);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMethodsScope: IScope;
    function GetOutputConverter: IValueRefConverter;
    procedure Notify(const AObject: TObject; const AProperty: string);
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Methods: TMethods read FMethods write SetMethods;
    property OutputConverters: TOutputConverters read FOutputConverters write SetOutputConverters;
    function GetEnumerator: TBindingsListEnumerator;
    property BindComps[Index: Integer]: TContainedBindComponent read GetBindComp write SetBindComp; default;
    property BindCompCount: Integer read GetBindCompCount;
    [Default(True)]
    property UseAppManager: Boolean read GetUseAppManager write SetUseAppManager default True;
    [Default(True)]
    property PromptDeleteUnused: Boolean read FPromptDeleteUnused write FPromptDeleteUnused default True;
    property DependencyList: IDependencyList read FDependencyList;
  end;

  TBindingsListEnumerator = class
  private
    FIndex: Integer;
    FBindCompList: TCustomBindingsList;
  public
    constructor Create(ABindCompList: TCustomBindingsList);
    function GetCurrent: TContainedBindComponent;
    function MoveNext: Boolean;
    property Current: TContainedBindComponent read GetCurrent;
  end;

  /// <summary>List of dependencies on components and properties</summary>
  TDependencyList = class(TInterfacedObject, IDependencyList)
  private
    FNotified: TDictionary<TComponent,TList<string>>;
    [weak] FBindingsList: TCustomBindingsList;
    FList: TList<TDependency>;
    FLocationDict: TDictionary<ILocation, TComponent>;
  public
    constructor Create(ABindCompList: TCustomBindingsList);
    destructor Destroy; override;
    function Add(ADependency: TDependency): TDependency;
    procedure Remove(ADependency: TDependency);
    procedure Link(AComponent: TComponent; ALocation: ILocation);
    function GetLink(ALocation: ILocation): TComponent;
    procedure ClearLink(ALocation: ILocation);
    procedure Notify(ASender: TObject; ALocation: ILocation; const AExpr: string); overload;
    procedure Notify(ASender: TObject; AComponent: TComponent; const AValue: string); overload;
  end;

  /// <summary>Describe the component/property that a binding component depends upon</summary>
  TDependency = class
  private
    [weak] FOwner: TObject;
    FComponent: TComponent;
    FMember: string;
    FExpr: string;
  public
    constructor Create(AOwner: TObject; AComponent: TComponent; const AMember, AExpr: string);
    procedure NotifyDependent; virtual;
    property Owner: TObject read FOwner;
    property Component: TComponent read FComponent;
    property Member: string read FMember;
    property Expr: string read FExpr;
  end;

  TBindingsList = class(TCustomBindingsList)
  published
    property Methods;
    property OutputConverters;
    property UseAppManager;
    property PromptDeleteUnused;
  end;

  TActivatedContainedBindComponent = class(TCommonBindComponent)
  strict private
    FAutoActivate: Boolean;
    procedure AddScopeExpressions;
    procedure RemoveScopeExpressions;
  private
    procedure DesignAutoActivateOnPropertyChange;
  protected
    procedure LoadActivate; virtual;
    procedure BindActivate(Value: Boolean); virtual;
    function CanDesignActivate: Boolean; virtual;
    function ActivateFromSource: Boolean;
    procedure UpdateEnableChanging; virtual;
    procedure UpdateEnableChanged; virtual;
    procedure SetActive(AValue: Boolean); virtual; abstract;
    function GetActive: Boolean; virtual; abstract;
    function GetAutoActivate: Boolean; virtual;
    procedure SetAutoActivate(AValue: Boolean); virtual;
    function CanActivate: Boolean; virtual;
    procedure ApplyComponents; virtual;
    procedure UpdateSourceChanging; override;
    procedure UpdateSourceMemberChanged; override;
    procedure UpdateSourceChanged; override;
    procedure UpdateControlChanged; override;
    procedure UpdateControlChanging; override;
    procedure UpdateSourceMemberChanging; override;
  public
    constructor Create(AOwner: TComponent); override;
    [Default(True)]
    property AutoActivate: Boolean read GetAutoActivate write SetAutoActivate default True;
    property Active: Boolean read GetActive write SetActive;
  end;

  TExpressions = class;

  TExpressionsBindComponent = class(TActivatedContainedBindComponent)
  private
    FDependencies: TList<TDependency>;
    FDependencyLinks: TList<ILocation>;
    FParseExpressions: TExpressions;
    FFormatExpressions: TExpressions;
    FClearExpressions: TExpressions;
    FControlExpressionObject: TBindingExpression;
    FParseExpressionObjects: TList<TBindingExpression>;
    FFormatExpressionObjects: TList<TBindingExpression>;
    FClearExpressionObjects: TList<TBindingExpression>;
  protected
    function GetClearExpressions: TExpressions; virtual;
    function GetFormatExpressions: TExpressions; virtual;
    function GetParseExpressions: TExpressions; virtual;
    procedure SetParseExpressions(const Value: TExpressions); virtual;
    procedure SetFormatExpressions(const Value: TExpressions); virtual;
    procedure SetClearExpressions(const Value: TExpressions); virtual;
    procedure AddDependency(ABindingExpression: TBindingExpression; ANotifyProc: TProc<TExpressionsBindComponent>; ASourceComponent: TComponent; ASourceMemberName, AExpression: string; AOutputComponent: TComponent);
    procedure CleanDependencies;
    procedure FreeExpressionsObjects; override;
    procedure NotifyDependentOutputs(ABindingExpression: TBindingExpression);
    procedure DoOnAssignedValue(AssignValueRec: TBindingAssignValueRec;
     const Value: TValue); override;
    procedure DoOnLocationUpdated(AOldLocation, ANewLocation: ILocation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property FormatExpressions: TExpressions read GetFormatExpressions write SetFormatExpressions;
    property ParseExpressions: TExpressions read GetParseExpressions write SetParseExpressions;
    property ClearExpressions: TExpressions read GetClearExpressions write SetClearExpressions;
  end;

  IBindActivate = interface
    ['{79856F26-5E66-4A24-B4DE-A7DBBE6356AD}']
    procedure SetActive(AValue: Boolean);
  end;

  // Single managed or unmanaged expression
  TBaseBindExpression = class(TActivatedContainedBindComponent, IBindActivate)
  private
    FDeferActive: Boolean;
    FActive: Boolean;
    FManaged: Boolean;
    FNotifyOutputs: Boolean;
    procedure SetManaged(const Value: Boolean);
    procedure SetNotifyOutputs(const Value: Boolean);
  protected
    procedure Loaded; override;
    function GetActive: Boolean; override;
    procedure EvaluateFormat; virtual;
    procedure EvaluateClear; virtual;
    { IBindActivate }
    procedure IBindActivate.SetActive = BindActivate;
    procedure SetActive(Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    [Default(True)]
    property Managed: Boolean read FManaged write SetManaged default True;
    property NotifyOutputs: Boolean read FNotifyOutputs write SetNotifyOutputs;
  end;

  TExpressionDirection = (dirSourceToControl, dirControlToSource, dirBidirectional);

  TCustomBindExpression = class(TBaseBindExpression)
  private
    FSourceExpression: string;
    FExpressionObject: TBindingExpression;
    FReverseExpressionObject: TBindingExpression;
    FControlExpression: string;
    FDirection: TExpressionDirection;
    procedure SetSourceExpression(const Value: string);
    procedure SetControlExpression(const Value: string);
  protected
    procedure EvaluateWithoutNotify;
    procedure UpdateExpressions; override;
    procedure FreeExpressionsObjects; override;
    function CanActivate: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ControlExpression: string read FControlExpression write SetControlExpression;
    property Direction: TExpressionDirection read FDirection write FDirection;
    procedure EvaluateFormat; override;
    procedure Evaluate;
    procedure Recompile;
    property SourceExpression: string read FSourceExpression write SetSourceExpression;
  end;

  TBindExpression = class(TCustomBindExpression)
  published
    property ControlComponent;
    property SourceComponent;
    property SourceMemberName;
    property SourceExpression;
    property ControlExpression;
    property AutoActivate;
    property Managed;
    property NotifyOutputs;
    property Direction;
    property OnAssigningValue;
    property OnAssignedValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;

  TExpressionsDir = class;

  // Collection of managed or unmanaged expression
  TCustomBindExprItems = class(TBaseBindExpression)
  private
    FFormatExpressions: TExpressionsDir;
    FFormatExpressionObjects:  TList<TBindingExpression>;
    FReverseFormatExpressionObjects:  TList<TBindingExpression>;
    FClearExpressionObjects:  TList<TBindingExpression>;
    FClearExpressions: TExpressionsDir;
    procedure SetFormatExpressions(Value: TExpressionsDir);
    procedure SetClearExpressions(const Value: TExpressionsDir);
    procedure EvaluateWithoutNotify;
  protected
    procedure UpdateExpressions; override;
    procedure FreeExpressionsObjects; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EvaluateFormat; override;
    procedure EvaluateClear; override;
    procedure Recompile;
    property FormatExpressions: TExpressionsDir read FFormatExpressions write SetFormatExpressions;
    property ClearExpressions: TExpressionsDir read FClearExpressions write SetClearExpressions;
  end;

  TBindExprItems = class(TCustomBindExprItems)
  published
    property ControlComponent;
    property SourceComponent;
    property SourceMemberName;
    property FormatExpressions;
    property ClearExpressions;
    property AutoActivate;
    property Managed;
    property NotifyOutputs;
    property OnAssigningValue;
    property OnAssignedValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;

  IBindNavigator = interface
  ['{50307CDD-63CD-4538-A211-D605C3811A0B}']
    function GetDataSource: TBaseLinkingBindSource;
    procedure SetDataSource(AScope: TBaseLinkingBindSource);
    property DataSource: TBaseLinkingBindSource read GetDataSource write SetDataSource;
  end;

  IScopeRecordEnumerator = interface
  ['{6C93BB29-D210-43E9-9850-0C22EDD0F9B2}']
                                               
    procedure First;
    function GetCurrent: IScope;
    function GetMemberCurrent(const AMemberName: string): IScope;
    function MoveNext: Boolean;
    property Current: IScope read GetCurrent;
  end;

  TScopeMemberType = (mtUnknown, mtText, mtInteger, mtFloat, mtBitmap, mtMemo, mtBoolean, mtBCD, mtUInteger,
   mtDateTime, mtCurrency, mtObject, mtVariant, mtDate, mtTime, mtChar, mtTValue);

  TValueCallback = reference to procedure(const AValue: TValue; AType: TScopeMemberType);

  IScopeRecordEnumeratorEvalShortcut = interface
  ['{64768DD1-CD80-434E-A5C1-D5990E0E04F9}']
    procedure GetMemberValue(const AMemberName: string;  const AType: TScopeMemberType;
      const ACallback: TValueCallback); overload;
    function GetMemberValue(const AMemberName: string; const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean; overload;
    function CanGetMemberValue(const AMemberName: string; AType: TScopeMemberType): Boolean;
  end;

  IScopeRecordEnumeratorCount = interface
    ['{46FAE534-6F58-4850-AF66-14DF7B8AEC0C}']
    function GetRecordCount: Integer;
    property RecordCount: Integer read GetRecordCount;
  end;

  IScopeRecordEnumeratorStatus = interface
    ['{755F088B-F673-45BD-A74D-ECBBDB38ACBA}']
    function GetMultiRecordChange: Boolean;
    property MultiRecordChange: Boolean read GetMultiRecordChange;
  end;

  IScopeRecordEnumerable = interface
    ['{34A6773D-A71B-4870-9C60-409A798206FA}']
    function GetEnumerator(const AMemberName: string; ABufferCount: Integer = -1): IScopeRecordEnumerator;
  end;

  IScopeRecordEnumerableBuffered = interface
    ['{DC2115E9-F163-43E2-A713-52A8455EF8FD}']
    function GetEnumerator(const AMemberName: string; ABuffered: Boolean): IScopeRecordEnumerator;
  end;

  IScopeCurrentRecord = interface
    ['{5ADA44B4-4E81-401B-9784-3B51D29A5149}']
    function GetCurrentRecord(const AMemberName: string): IScope;
  end;

  IScopeGetRecord = interface
    ['{D33C242C-310D-4BE7-9908-C3CAC3C856B6}']
    procedure GetRecord(ARow: Integer; const AMemberName: string; ACallback: TProc<IScope>);
  end;

  IScopeLookup = interface
    ['{95C4149E-E1AD-4D21-A8DF-A84A33B6D2D9}']
    function Lookup(const KeyFields: string; const KeyValues: TValue;
      const ResultFields: string): TValue;
    procedure GetLookupMemberNames(AList: TStrings);
  end;

  IScopeLocate = interface
    ['{CBC0B2CC-0011-4569-B17E-1B5B62BE59CF}']
    function Locate(const KeyFields: string; const KeyValues: TValue): Boolean;
  end;

  IScopeNavigatorUpdates = interface
    ['{3E48BABC-3939-4326-AD02-B1DF377746C6}']
    procedure ApplyUpdates;
    function GetCanApplyUpdates: Boolean;
    function GetCanCancelUpdates: Boolean;
    procedure CancelUpdates;
    property CanApplyUpdates: Boolean read GetCanApplyUpdates;
    property CanCancelUpdates: Boolean read GetCanCancelUpdates;
  end;

  IScopeBuffer = interface
    ['{43D47EB0-14F2-47D0-89F5-6CB516F36BF3}']
    function GetBufferCount(out ACount: Integer): Boolean;
  end;

  IBindLink = interface
    ['{4E952D1B-0D23-41C4-8DF0-D24C4C325D5C}']
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetUpdating: Boolean;
    property Updating: Boolean read GetUpdating;
    procedure SetIsReadOnly(Value: Boolean);
    function IsRequired: Boolean;
    function IsValidChar(AKey: Char): Boolean;
    function GetCanModify: Boolean;
    function GetIsModified: Boolean;
    procedure SetModified;
    function Edit: Boolean;
    function GetIsEditing: Boolean;
    procedure Reset;
    procedure UpdateRecord;
    procedure EvaluateParse(const AMemberName: string);
    procedure EvaluateFormat(const AMemberName: string);
    procedure EvaluateClear(const AMemberName: string);
    function GetActive: Boolean;
    procedure SetActive(AValue: Boolean);
    function GetBindComp: TComponent;
    function GetSourceMemberName: string;
    property Active: Boolean read GetActive write SetActive;
    property BindComp: TComponent read GetBindComp;
    property SourceMemberName: string read GetSourceMemberName;
    property IsModified: Boolean read GetIsModified;
    property CanModify: Boolean read GetCanModify;
    property IsEditing: Boolean read GetIsEditing;
    procedure ClearEditingLink;
  end;


  IBindPosition = interface
    ['{6E9EB32B-4982-4D4D-9510-A0ADFB1BDCC8}']
    function GetBindComp: TComponent;
    procedure PosChanged;
    procedure PosChanging;
    function GetActive: Boolean;
    function GetSourceMemberName: string;
    procedure EvaluatePosControl;
    procedure EvaluatePosClear;
    procedure SetActive(AValue: Boolean);
    property BindComp: TComponent read GetBindComp;
    property Active: Boolean read GetActive write SetActive;
    property SourceMemberName: string read GetSourceMemberName;
  end;

  IBindTrack = interface
    ['{7EE337E7-C25E-4900-90C3-DA2EE9F33954}']
    function GetTrack: Boolean;
    procedure SetTrack(const Value: Boolean);
    property Track: Boolean read GetTrack write SetTrack;
  end;

  IBindControlValue = interface
  ['{ABDF3DA4-7A87-44F3-9589-1610207529F7}']
    procedure ValueChanged;
    function GetUpdating: Boolean;
    property Updating: Boolean read GetUpdating;
  end;

  IBindListUpdate = interface
    ['{01EED9E9-F0BD-4752-A6BA-F79EF46ABE55}']
    function GetBindComp: TComponent;
    function GetActive: Boolean;
    procedure UpdateList;
    property BindComp: TComponent read GetBindComp;
    property Active: Boolean read GetActive;
  end;

  IBindListRefresh = interface
    ['{89D41A89-AA65-4177-A3D3-373E1430EF35}']
    procedure RefreshList;
    function RefreshNeeded: Boolean;
  end;

  IBindListRefreshing = interface
    ['{1B1D65B7-EB88-4D81-A1B4-D706DCE4C05C}']
    function GetListRefreshing: TNotifyEvent;
    procedure SetListRefreshing(AEvent: TNotifyEvent);
    property OnListRefreshing: TNotifyEvent read GetListRefreshing write SetListRefreshing;
  end;

  IBindLayoutChanged = interface
    ['{6913B4FE-45C1-4844-9C9F-A2F59309C9FC}']
    procedure LayoutChanged;
  end;

  TFormatCallback = reference to procedure(const ASourceScope, AControlScope: IScope);
  TQueryBreakCallback = reference to function(const ASourceScope: IScope): Boolean;

  TBindCheckBoxState = (cbUnchecked, cbChecked, cbGrayed);

  IBindCheckBoxEditor = interface
    ['{907EB30C-3C04-400C-88FD-3E9FD5EAE761}']
    function GetState: TBindCheckBoxState ;
    procedure SetState(Value: TBindCheckBoxState );
    function GetAllowGrayed: Boolean;
    procedure SetAllowGrayed(Value: Boolean);
    property AllowGrayed: Boolean read GetAllowGrayed write SetAllowGrayed;
    property State: TBindCheckBoxState read GetState write SetState;
  end;

  IBindDateTimeEditEditor = interface
  ['{B94877B1-5DCB-420F-A9E4-D3401C05AF25}']
    function GetIsEmpty: Boolean;
    procedure SetIsEmpty(Value: Boolean);
    function GetDateTime: TDateTime;
    procedure SetDateTime(ADateTime: TDateTime);
    property IsEmpty: Boolean read GetIsEmpty write SetIsEmpty;
    property SelectedDateTime: TDateTime read GetDateTime write SetDateTime;
  end;

  // Editor may provide list of members
  IBindFillControlMembers = interface
    ['{85AD494A-E7ED-402A-90FF-4F9B485B209C}']
    procedure GetItemMemberNames(ANames: TStrings);
    function GetItemMemberNameExpression(const AName: string): string;
    procedure GetHeaderMemberNames(ANames: TStrings);
    function GetHeaderMemberNameExpression(const AName: string): string;
    function CurrentHeaderItem: IScope;
  end;

  IBindListEditorCommon = interface
    ['{87465AA0-608E-4CA4-BE36-B808B3895486}']
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetRowCount: Integer;
    procedure ClearList;
    function GetSelectedItem: TObject;
    function GetSelectedText: string;
    function GetSelectedValue: TValue;
    function GetPositionGetter(var AGetter: string; var ABase: Integer): Boolean;
    function GetPositionSetter(var ASetter: string; var ABase: Integer): Boolean;
    property SelectedText: string read GetSelectedText;
    property SelectedValue: TValue read GetSelectedValue;
    property SelectedItem: TObject read GetSelectedItem;
    property RowCount: Integer read GetRowCount;
  end;

  IBindListGroupEditor = interface
    ['{788EB4F3-AA8F-42EA-AD73-B5A5B1D90A49}']
    procedure FillGroupList(ARecordEnumerator: IScopeRecordEnumerator;
      AFormatProc: TFormatCallback;
      AFormatHeaderProc: TFormatCallback;
      AQueryBreakCallback: TQueryBreakCallback);
    function AddHeader: IScope;
  end;

  IBindListSynchEditor = interface
    ['{B6F0F4F3-EDF7-44F6-A466-32F439B9E3EA}']
    function GetSynchIndex: Integer;
    procedure SetSynchIndex(AIndex: Integer);
    procedure ApplyFilter;
    property SynchIndex: Integer read GetSynchIndex write SetSynchIndex;
  end;

  /// <summary>
  /// Editors implement these methods to support the expression ListItemIndex(Self).
  /// </summary>
  IBindListItemIndexEditor = interface
    ['{A3EBD46C-A2F7-45A2-87FA-8E1CCE9C7601}']
    function GetItemIndex: Integer;
    procedure SetItemIndex(AIndex: Integer);
    /// <summary>Get or set the list item index</summary>
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
  end;

  IBindListEditorItem = interface
    ['{6FBB6044-F568-4996-BAA2-CD71F7D1A83E}']
    function CurrentObject: TObject;
    function CurrentIndex: Integer;
  end;

  IBindListEditor = interface(IBindListEditorCommon)
    ['{C0D3125F-F9E8-4EAE-98CB-AC16D0E7B075}']
    function GetSelectedValue: TValue;
    procedure SetSelectedValue(const AValue: TValue);
    procedure SetSelectedText(const AValue: string);
    function AddItem(Select: Boolean = False): IScope;
    function InsertItem(Select: Boolean = False): IScope;
    function CanInsertItem: Boolean;
    procedure DeleteToEnd;
    function UpdateNeeded(ARecordEnumerator: IScopeRecordEnumerator): Boolean;
    function RefreshNeeded(ARecordEnumerator: IScopeRecordEnumerator): Boolean;
    procedure UpdateList(ARecordEnumerator: IScopeRecordEnumerator; AFormatProc: TFormatCallback);
    procedure FillList(ARecordEnumerator: IScopeRecordEnumerator; AFormatProc: TFormatCallback);
    function CurrentItem: IScope;
    function MoveNext: Boolean;
    property SelectedText: string read GetSelectedText write SetSelectedText;
    property SelectedValue: TValue read GetSelectedValue write SetSelectedValue;
  end;

  IBindListEditorEvalShortcut = interface
    ['{B3E7381A-559C-479B-B867-92FDACFDFD34}']
    procedure SetCurrentValue(const AMemberName: string; const AValue: TValue; AType: TScopeMemberType);
    function CanSetCurrentValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
  end;

  IBindListLookupEditor = interface(IBindListEditor)
    ['{A70B5726-FF2F-4E6E-A99C-72C73FCF0168}']
    function GetUseLookups: Boolean;
    procedure SetUseLookups(AUseLookups: Boolean);
    function GetLookupValue(const AScope: IScope): TValue;
    procedure SetLookupValue(const AScope: IScope; const AValue: TValue);
    function GetSelectedLookupValue: TValue;
    procedure SetSelectedLookupValue(const AValue: TValue);
    property LookupValue[const AScope: IScope]: TValue read GetLookupValue write SetLookupValue;
    property SelectedLookupValue: TValue read GetSelectedLookupValue write SetSelectedLookupValue;
    property UseLookups: Boolean read GetUseLookups write SetUseLookups;
  end;

  TBindGridOnCallbackEvaluateFormat = reference to procedure(Col, Row: Integer; AEditorScope: IScope);
  IBindListVirtualEditor = interface(IBindListEditorCommon)
    ['{826B10CB-AD17-4D60-830C-7912B6ED6712}']
    procedure SetRowCount(ARowCount: Integer);
    procedure SetOnCallbackEvaluateFormat(OnCallbackEvaluateFormat: TBindGridOnCallbackEvaluateFormat);
    procedure UpdateCell(Col: Integer);
  end;

  // Editors, such a FMX TGrid editor, implement this interface to improve performance
  IBindListVirtualEditorScope = interface
    ['{E4E25A70-9D29-4B46-BB7B-E3A07DC676B0}']
    // Can cache the column scope in a TBindingExpression
    function CanCache: Boolean;
  end;

  IBindGridEditor = interface
    ['{FDE1D9BA-4277-4549-945F-ABFC5E61A56D}']
    procedure GetColumnNames(AList: TStrings);
    procedure GetColumnIndices(AList: TStrings);
  end;

  IBindLinkColumns = interface(IBindLink)
    ['{F0FAEC32-EC29-45C1-9490-1DC9CD169DD4}']
    function GetEditColumnName: string;
    function GetEditColumnIndex: integer;
    procedure SetEditColumn(const AName: string; AIndex: Integer);
    property EditColumnName: string read GetEditColumnName;
    property EditColumnIndex: Integer read GetEditColumnIndex;
  end;

  TExpressionItem = class;
  TExpressionItemDir = class;


  // Keep a control in synch with data
  TCustomBindPosition = class(TActivatedContainedBindComponent, IBindPosition, IBindActivate)
  private
    FPositionObserver: IPositionLinkObserver;
    procedure SetPosControlExpressions(const Value: TExpressions);
    procedure SetPosSourceExpressions(const Value: TExpressions);
    procedure SetPosClearExpressions(const Value: TExpressions);
   var
    FPosControlExpressions: TExpressions;
    FPosSourceExpressions: TExpressions;
    FPosClearExpressions: TExpressions;
    FDeferActive: Boolean;
    FActive: Boolean;
    FPosControlExpressionObjects: TList<TBindingExpression>;
    FPosSourceExpressionObjects: TList<TBindingExpression>;
    FPosClearExpressionObjects: TList<TBindingExpression>;
    FControlExpressionObject: TBindingExpression;
  protected
    procedure CheckEditingLink; virtual;
    procedure ClearEditingLink; virtual;
    function RequiresControlHandler: Boolean; virtual;
    procedure UpdateControlChanging; override;
    procedure UpdateExpressions; override;
    procedure FreeExpressionsObjects; override;
    procedure Loaded; override;
    procedure SetControlComponent(const Value: TComponent); override;
    { IBindPosition }
    function GetBindComp: TComponent;
    procedure PosChanged;
    procedure PosChanging;
    function GetActive: Boolean; override;
    procedure SetActive(Value: Boolean); override;
    procedure EvaluatePosControl;
    procedure EvaluatePosSource;
    procedure EvaluatePosClear;
    { IBindPosition }
    procedure IBindPosition.SetActive = BindActivate;
    { IBindActivate }
    procedure IBindActivate.SetActive = BindActivate;
  public
    property PosSourceExpressions: TExpressions read FPosSourceExpressions write SetPosSourceExpressions;
    property PosControlExpressions: TExpressions read FPosControlExpressions write SetPosControlExpressions;
    property PosClearExpressions: TExpressions read FPosClearExpressions write SetPosClearExpressions;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TBindPosition = class(TCustomBindPosition)
  published
    property ControlComponent;
    property SourceComponent;
    property SourceMemberName;
    property PosSourceExpressions;
    property PosControlExpressions;
    property PosClearExpressions;
    property AutoActivate;
    property OnAssigningValue;
    property OnAssignedValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;

  /// <summary>Update component properties with a control is modified by user input</summary>
  TCustomBindControlValue = class(TExpressionsBindComponent, IBindControlValue, IBindTrack)
  private
    FTrack: Boolean;
    FControlValueObserver: IControlValueObserver;
    FUpdateCounter: Integer;
    FDeferActive: Boolean;
    FActive: Boolean;
    procedure SetTrack(const Value: Boolean);
    function GetTrack: Boolean;
    procedure UpdateTrack;
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetUpdating: Boolean;
    procedure EvaluateParse;
    procedure EvaluateClear;
  protected
    function GetActive: Boolean; override;
    procedure SetActive(Value: Boolean); override;
    procedure CheckEditingLink; virtual;
    procedure ClearEditingLink; virtual;
    function RequiresControlHandler: Boolean; virtual;
    procedure UpdateControlChanging; override;
    procedure UpdateExpressions; override;
    procedure Loaded; override;
    { IBindControlValue }
    procedure ValueChanged;
    procedure EvaluateFormat;
  public
    function CanSetControlComponent(Value: TComponent): Boolean; override;
    property Track: Boolean read GetTrack write SetTrack;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;


  /// <summary>Update component properties with a control is modified by user input</summary>
  TBindControlValue = class(TCustomBindControlValue)
  published
    property Track;
    property ControlComponent;
    property SourceComponent;
    property SourceMemberName;
    property FormatExpressions;
    property ParseExpressions;
    property ClearExpressions;
    property AutoActivate;
    property OnAssigningValue;
    property OnAssignedValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;

  TFillItemMode = (fmFill, fmInsert, fmAdd, fmUpdate);
  TFillListItemEvent = procedure(Sender: TObject;
   const AEditor: IBindListEditorItem) of object;

  TCustomBindList = class(TActivatedContainedBindComponent, IBindActivate)
  private
    FBindListEditor: IBindListEditorCommon;
    FDeprecatedBufferCount: Integer;
    FFormatExpressions: TExpressions;
    FFormatControlExpressions: TExpressions;
    FClearControlExpressions: TExpressions;
    FFormatControlExpressionObjects:  TList<TBindingExpression>;
    FClearControlExpressionObjects:  TList<TBindingExpression>;
    FDeferActive: Boolean;
    FActive: Boolean;
    FAutoFill: Boolean;
    FControlExpressionObject: TBindingExpression;
    FEditor: string;
    FOnFilledListItem: TFillListItemEvent;
    FOnFillingListItem: TFillListItemEvent;
    FOnFillingList: TNotifyEvent;
    FOnFilledList: TNotifyEvent;
    procedure SetAutoFill(const Value: Boolean);
    procedure SetFormatExpressions(const Value: TExpressions);
    procedure EvaluateExpressionItem(AItem: TExpressionItem; AEditorScope,
      AEnumScope: IScope); overload;
    procedure EvaluateExpressions(AEditorScope: IScope; const AEditorExpression: string;
      AEnumScope: IScope; const AEnumExpression: string); overload;
    function GetBindListEditor: IBindListEditorCommon;
    procedure SetClearControlExpressions(const Value: TExpressions);
    procedure SetFormatControlExpressions(const Value: TExpressions);
    procedure EvaluateClearControl;
    procedure EvaluateFormatControl;
    procedure SetEditor(const Value: string);
    procedure SetBindListEditor(const AEditor: IBindListEditorCommon);
  protected
    function IsLinked: Boolean; virtual;
    procedure DoFilledListItem(const AEditor: IBindListEditor);
    procedure DoFillingListItem(const AEditor: IBindListEditor);
    procedure DoFilledList;
    procedure DoFillingList;
    procedure UpdateControlChanging; override;
    procedure FillListItem(const AEditor: IBindListEditor; const ASourceScope, AEditorScope: IScope; AMode: TFillItemMode); virtual;
    //procedure EvaluatePosControl; virtual;
    procedure UpdateExpressions; override;
    procedure FreeExpressionsObjects; override;
    procedure Loaded; override;
    function GetActive: Boolean; override;
    { IBindMemberChange }
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName, ANewMemberName: string); override;
    { IBindActivate }
    procedure IBindActivate.SetActive = BindActivate;
    procedure SetActive(Value: Boolean); override;

    function TryGetBindListEditor(out AEditor: IBindListEditorCommon): Boolean; virtual;
    property BindListEditor: IBindListEditorCommon read FBindListEditor write SetBindListEditor;
    // Backward compatability
    procedure DefineProperties(Filer: TFiler); override;
  public
    property FormatExpressions: TExpressions read FFormatExpressions write SetFormatExpressions;
    property FormatControlExpressions: TExpressions read FFormatControlExpressions write SetFormatControlExpressions;
    property ClearControlExpressions: TExpressions read FClearControlExpressions write SetClearControlExpressions;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearList;
    procedure FillList;
    function CanInsert: Boolean;
    function CanUpdate: Boolean;
    procedure InsertItem(Select: Boolean = True);
    procedure UpdateItem;
    procedure AddItem(Select: Boolean = True);
    procedure ExecuteAssignToSourceExpression(const AControlExpression,
      ASourceExpression: string; ACallback: TProc<IValue>; AType: TBindCompExpressionType); override;
    procedure ExecuteAssignToControlExpression(const AControlExpression,
      ASourceExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType); override;
    procedure EvaluateControlExpression(const AExpression: string; ACallback: TProc<IValue>; AType: TBindCompExpressionType); override;
    procedure EvaluateSourceExpression(const AExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType); override;
    procedure ResetList;
    [Default(-1)]
    property BufferCount: Integer read FDeprecatedBufferCount write FDeprecatedBufferCount default -1;
    [Default(True)]
    property AutoFill: Boolean read FAutoFill write SetAutoFill default True;
    property Editor: string read FEditor write SetEditor;
    property OnFillingListItem: TFillListItemEvent read FOnFillingListItem write FOnFillingListItem;
    property OnFilledListItem: TFillListItemEvent read FOnFilledListItem write FOnFilledListItem;
    property OnFillingList: TNotifyEvent read FOnFillingList write FOnFillingList;
    property OnFilledList: TNotifyEvent read FOnFilledList write FOnFilledList;
  end;

  TBindList = class(TCustomBindList)
  published
    property ControlComponent;
    property SourceComponent;
    property SourceMemberName;
    property FormatExpressions;
    property FormatControlExpressions;
    property ClearControlExpressions;
    property AutoFill;
    property AutoActivate;
    property OnAssigningValue;
    property OnAssignedValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
    property Editor;
  end;

  TCustomBindListLookup = class(TCustomBindList)
  private
    FLookupValueSourceExpression: string;
    FLookupValueSourceMemberName: string;
    procedure SetLookupValueSourceMemberName(const Value: string);
    procedure SetLookupValueSourceExpression(const Value: string);
    procedure CheckLookupList;
  protected
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName,
      ANewMemberName: string); override;
    procedure FillListItem(const AEditor: IBindListEditor; const ASourceScope, AEditorScope: IScope;
      AMode: TFillItemMode); override;
    function TryGetBindListEditor(out AEditor: IBindListEditorCommon): Boolean; override;
  public
    function GetSelectedValue: TValue;
    property LookupValueSourceExpression: string read FLookupValueSourceExpression write SetLookupValueSourceExpression;
    property LookupValueSourceMemberName: string read FLookupValueSourceMemberName write SetLookupValueSourceMemberName;
  end;

  TControlObserver = class;

  TCustomBindListLink = class(TCustomBindList, IBindPosition,
    IBindLink, IBindListUpdate)
  private
    FParseExpressionObjects:  TList<TBindingExpression>;
    FParseExpressions:  TExpressions;
    FPosSourceExpressions: TExpressions;
    FPosControlExpressions: TExpressions;
    FPosControlExpressionObjects: TList<TBindingExpression>;
    FPosSourceExpressionObjects: TList<TBindingExpression>;
    FControlExpressionObject: TBindingExpression;
    FControlObserver: TControlObserver;
    FUpdateCounter: Integer;
    FDeprecatedBufferCount: Integer;
    FLockPosControl: Integer;
    procedure SetPosControlExpressions(const Value: TExpressions);
    procedure SetPosSourceExpressions(const Value: TExpressions);
    procedure SetParseExpressions(const Value: TExpressions);
    procedure FillRecord(const ASourceScope, AEditorScope: IScope);
    procedure ClearModified;
    function RequiresControlHandler: Boolean;
    procedure CheckEditingLink;
  protected
    function IsLinked: Boolean; override;
    procedure UpdateControlChanging; override;
    procedure FreeExpressionsObjects; override;
    procedure UpdateExpressions; override;
    { IBindPosition }
    function GetBindComp: TComponent;
    procedure PosChanged;
    procedure PosChanging;
    function GetActive: Boolean; override;
    procedure SetActive(Value: Boolean); override;
    procedure EvaluatePosControl;
    procedure EvaluatePosSource;
    procedure EvaluatePosClear;
    { IBindLink }
    function GetUpdating: Boolean;
    procedure BeginUpdate;
    procedure EndUpdate;
    function IsRequired: Boolean;
    procedure SetIsReadOnly(Value: Boolean);
    function IsValidChar(AKey: Char): Boolean;
    function GetCanModify: Boolean;
    procedure SetModified;
    function GetIsModified: Boolean;
    function Edit: Boolean;
    function GetIsEditing: Boolean;
    procedure Reset;
    procedure UpdateRecord;
    procedure EvaluateParse(const AMemberName: string);
    procedure EvaluateFormat(const AMemberName: string);
    procedure EvaluateClear(const AMemberName: string);
    procedure ClearEditingLink; virtual;
    { IBindListUpdate }
    procedure UpdateList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ResetList;
    procedure ExecuteAssignToSourceExpression(const AControlExpression,
      ASourceExpression: string; ACallback: TProc<IValue>; AType: TBindCompExpressionType); override;
    property ControlComponent: TComponent read GetControlComponent write SetControlComponent;
    property PosSourceExpressions: TExpressions read FPosSourceExpressions write SetPosSourceExpressions;
    property PosControlExpressions: TExpressions read FPosControlExpressions write SetPosControlExpressions;
    property ParseExpressions: TExpressions read FParseExpressions write SetParseExpressions;
  end;

  TBindListLink = class(TCustomBindListLink)
  published
    property ControlComponent;
    property SourceComponent;
    property FormatExpressions;
    property ParseExpressions;
    property PosControlExpressions;
    property PosSourceExpressions;
    property FormatControlExpressions;
    property ClearControlExpressions;
    property SourceMemberName;
    property AutoFill;
    property AutoActivate;
    property OnAssigningValue;
    property OnAssignedValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
    property Editor;
  end;


  TCustomBindLink = class(TExpressionsBindComponent, IBindLink, IBindActivate, IBindTrack)
  private
    FUpdateCounter: Integer;
    FControlObserver: TControlObserver;
    FDeferActive: Boolean;
    FActive: Boolean;
    FTrack: Boolean;
    procedure SetTrack(const Value: Boolean);
    function GetTrack: Boolean;
    procedure UpdateTrack;
  protected
    function GetSourceScopes: TArray<IScope>; virtual;
    procedure UpdateExpressions; override;
    function RequiresControlHandler: Boolean; virtual;
    procedure CheckEditingLink; virtual;
    procedure ClearEditingLink; virtual;
    procedure UpdateControlChanging; override;
    { IBindLink }
    function GetUpdating: Boolean;
    procedure BeginUpdate;
    procedure EndUpdate;
    function IsRequired: Boolean;
    procedure SetIsReadOnly(Value: Boolean);
    function IsValidChar(AKey: Char): Boolean;
    function GetCanModify: Boolean;
    procedure ClearModified;
    procedure SetModified;
    function GetIsModified: Boolean;
    function Edit: Boolean;
    function GetIsEditing: Boolean;
    procedure Reset;
    procedure UpdateRecord;
    function GetActive: Boolean; override;
    function GetBindComp: TComponent;
    procedure EvaluateParse(const AMemberName: string);
    procedure EvaluateFormat(const AMemberName: string);
    procedure EvaluateClear(const AMemberName: string);
    procedure SetActive(Value: Boolean); override;
    procedure IBindLink.SetActive = BindActivate;
    { IBindActivate }
    procedure IBindActivate.SetActive = BindActivate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    function EvaluateControl: IValue;
    property Active: Boolean read GetActive write SetActive;
    property Track: Boolean read GetTrack write SetTrack;
  end;

  TBindLink = class(TCustomBindLink)
  published
    property SourceMemberName;
    property ControlComponent;
    property SourceComponent;
    property ParseExpressions;
    property FormatExpressions;
    property ClearExpressions;
    property AutoActivate;
    property Track;
    property OnAssigningValue;
    property OnAssignedValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;

  TColumnLinkExpressions = class;
  TColumnLinkExpressionItem = class;
  TColumnFormatExpressions = class;
  TColumnFormatExpressionItem = class;

  TCollectionEnumerator<T: TCollectionItem> = class(System.Generics.Collections.TEnumerator<T>)
  private
    FCollectionEnumerator: TCollectionEnumerator;
  public
    constructor Create(ACollection: TCollection);
    destructor Destroy; override;
    function DoGetCurrent: T; override;
    function DoMoveNext: Boolean; override;
  end;

  TFillBreakGroupItem = class(TCollectionItem)
  private
    FDisplayText: string;
    FMinValue: string;
    FMaxValue: string;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  published
    property DisplayText: string read FDisplayText write FDisplayText;
    property MinValue: string read FMinValue write FMinValue;
    property MaxValue: string read FMaxValue write FMaxValue;
  end;

  TFillBreakGroups = class(TOwnedCollection)
  type
    TEnumerator = TCollectionEnumerator<TFillBreakGroupItem>;
  private
    function GetItem(Index: Integer): TFillBreakGroupItem;
    procedure SetItem(Index: Integer; const Value: TFillBreakGroupItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    function GetEnumerator: TEnumerator;
    function AddItem: TFillBreakGroupItem;
    function FindItem(const AValue: TValue): TFillBreakGroupItem;
    property Items[Index: Integer]: TFillBreakGroupItem read GetItem write SetItem; default;
  end;

  TEvalShortcutEnumeratorToEditor = class;
  TEvalShortcutEnumerator = class;

  /// <summary>Evaluate an assignment from a data source to an editor.  May use a shortcut or expression engine.</summary>
  TEvalEnumeratorToEditor = class
  public type
    TOnEvalErrorEvent = procedure(AException: Exception) of object;
  private
    FUseEvalShortcuts: Boolean;
    FBindingExpression: TBindingExpression;
    FHaveEvalShortcut: Boolean;
    FEvalShortcut: TEvalShortcutEnumeratorToEditor;
    FSource: IScopeRecordEnumerator;
    FSourceMemberName: string;
    FEditor: IBindListEditor;
    FEditorMemberName: string;
    FCustom: Boolean;
    FOnEvalError: TOnEvalErrorEvent;
    procedure Evaluate; overload;
    procedure CheckEvalShortcut;
  public
    constructor Create(AUseEvalShortcuts: Boolean;
      const ASource: IScopeRecordEnumerator; const ASourceMemberName: string;
      const AEditor: IBindListEditor; const AEditorMemberName: string; ACustom: Boolean;
      const AOnEvalError: TOnEvalErrorEvent;
      const ABindingExpression: TBindingExpression);
    destructor Destroy; override;
    /// <summary>Enumerator of data source records, such as records in a dataset.</summary>
    property Source: IScopeRecordEnumerator read FSource;
    /// <summary>Data source member name, such as a FieldName.</summary>
    property SourceMemberName: string read FSourceMemberName;
    /// <summary>Editor for a list, such as a FMX TListView.</summary>
    property Editor: IBindListEditor read FEditor;
    /// <summary>Member name for a list, such as "Text".</summary>
    property EditorMemberName: string read FEditorMemberName;
    /// <summary>Indicate whether the assignment can be evaluated without expression engine.</summary>
    property UseEvalShortcuts: Boolean read FUseEvalShortcuts;
    /// <summary>Expression engine description of assignment.</summary>
    property Expression: TBindingExpression read FBindingExpression;
    /// <summary>Event to execute when the expression engine raises an exception</summary>
    property OnEvalError: TOnEvalErrorEvent read FOnEvalError;
    /// <summary>Indicate whether the expression has been customized.  A customized expression must
    /// be evaluated with expression engine, rather than by shortcut.</summary>
    property Custom: Boolean read FCustom;
  end;

  /// <summary>Evaluate an value from a data source.  May use a shortcut or expression engine.</summary>
  TEvalEnumerator = class
  public type
    TOnEvalErrorEvent = procedure(AException: Exception) of object;
  private
    FUseEvalShortcuts: Boolean;
    FBindingExpression: TBindingExpression;
    FHaveEvalShortcut: Boolean;
    FEvalShortcut: TEvalShortcutEnumerator;
    FSource: IScopeRecordEnumerator;
    FSourceMemberName: string;
    FCustom: Boolean;
    FOnEvalError: TOnEvalErrorEvent;
    function Evaluate(const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean; overload;
    procedure CheckEvalShortcut;
  public
    constructor Create(AUseEvalShortcuts: Boolean;
      const ASource: IScopeRecordEnumerator; const ASourceMemberName: string;
      ACustom: Boolean;
      const AOnEvalError: TOnEvalErrorEvent;
      const ABindingExpression: TBindingExpression);
    destructor Destroy; override;
    /// <summary>Enumerator of data source records, such as records in a dataset.</summary>
    property Source: IScopeRecordEnumerator read FSource;
    /// <summary>Data source member name, such as a FieldName.</summary>
    property SourceMemberName: string read FSourceMemberName;
    /// <summary>Indicate whether the assignment can be evaluated without expression engine.</summary>
    property UseEvalShortcuts: Boolean read FUseEvalShortcuts;
    /// <summary>Expression engine description of expression to evaluate.</summary>
    property Expression: TBindingExpression read FBindingExpression;
    /// <summary>Event to call when the expression engine raises an exception</summary>
    property OnEvalError: TOnEvalErrorEvent read FOnEvalError;
    /// <summary>Indicate whether the expression has been customized.  A customized
    /// expression must be evaluated with expression engine, rather than as a shortcut</summary>
    property Custom: Boolean read FCustom;
  end;

  TCustomBindGridList = class(TActivatedContainedBindComponent, IBindActivate)
  public
  type
    TArrayListCellExpression = TArray<TList<TEvalEnumeratorToEditor>>;
  private
    FFormatControlExpressions: TExpressions;
    FClearControlExpressions: TExpressions;
    FFormatControlExpressionObjects: TList<TBindingExpression>;
    FClearControlExpressionObjects: TList<TBindingExpression>;
    FControlExpressionObject: TBindingExpression;
    FActive: Boolean;
    FDeprecatedBufferCount: Integer;
    FBindListEditor: IBindListEditorCommon;
    FListItemStyle: string;
    FColumnExpressions: TColumnFormatExpressions;
    FDeferActive: Boolean;
    FAutoFill: Boolean;
    FBreakExpression: string;
    FBreakMemberName: string;
    FBreakCustom: Boolean;
    FBreakGroups: TFillBreakGroups;
    FDisableBreakGroups: Boolean;
    FOnFillingRecord: TFillListItemEvent;
    FOnFilledRecord: TFillListItemEvent;
    FOnFilledRecords: TNotifyEvent;
    FOnFillingRecords: TNotifyEvent;
    procedure SetColumnExpressions(const Value: TColumnFormatExpressions);
    function GetControlScopes(
      AColumnExpressionItem: TColumnFormatExpressionItem): TArray<IScope>;
    function GetSourceScopes(
      AColumnExpressionItem: TColumnFormatExpressionItem): TArray<IScope>;
    function GetBindListEditor: IBindListEditorCommon;
    function GetScopeRecordEnumerator: IScopeRecordEnumerator;
    procedure EvaluateExpressionItem(AColumnExpressionItem: TColumnFormatExpressionItem; AItem: TExpressionItem; AEditorScope,
      AEnumScope: IScope);
    procedure EvaluateExpressions(AColumnExpressionItem: TColumnFormatExpressionItem; AEditorScope: IScope;
      const AEditorExpression: string; AEnumScope: IScope;
      const AEnumExpression: string); overload;
    procedure EvaluateSourceExpression(AEnumScope: IScope;
      const AEnumExpression: string; ACallback: TProc<IValue>); overload;
    procedure SetFormatControlExpressions(const Value: TExpressions);
    procedure SetClearControlExpressions(const Value: TExpressions);
    procedure FormatColumns;
    procedure EvaluateClearControl;
    procedure EvaluateFormatControl;
    procedure GetBindingExpressions(const AEnumerator: IScopeRecordEnumerator; const AEditor: IBindListEditor;
      ACallback: TProc<TArrayListCellExpression>); overload;
    procedure GetBindingExpressions(const AEnumerator: IScopeRecordEnumerator; const AEditor: IBindListEditor;
      ACallback: TProc<TArrayListCellExpression, TArrayListCellExpression, TEvalEnumerator,
        TObject>); overload;
    procedure SetListItemStyle(const Value: string);
    procedure SetAutoFill(const Value: Boolean);
    procedure SetBreakGroups(const Value: TFillBreakGroups);
    procedure FillRecord2(const AEditor: IBindListEditor);
    procedure SetBindListEditor(const Value: IBindListEditorCommon);
  protected
    function IsLinked: Boolean; virtual;
    procedure DoFilledRecord(const AEditor: IBindListEditor); virtual;
    procedure DoFillingRecord(const AEditor: IBindListEditor); virtual;
    procedure DoFilledRecords; virtual;
    procedure DoFillingRecords; virtual;
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName, ANewMemberName: string); override;
    procedure FillRecords(const AEditor: IBindListEditor); virtual;
    procedure FillRecord(const AEditor: IBindListEditor;
      AEvaluate: TProc); virtual;
    /// <summary>Evaluate expressions to fill a break header</summary>
    procedure FillHeaderRecord(const AEditor: IBindListEditor;
      AEvaluate: TProc); virtual;
    function TryGetBindListEditor(out AEditor: IBindListEditorCommon): Boolean; virtual;
    procedure UpdateControlChanged; override;
    procedure FreeExpressionsObjects; override;
    procedure UpdateExpressions; override;
    procedure Loaded; override;
    function GetActive: Boolean; override;
    { IBindActivate }
    procedure IBindActivate.SetActive = BindActivate;
    procedure SetActive(Value: Boolean); override;
    procedure UpdateControlChanging; override;
    property BindListEditor: IBindListEditorCommon read FBindListEditor write SetBindListEditor;
    // Backward compatability
    procedure DefineProperties(Filer: TFiler); override;
  public
    property ColumnExpressions: TColumnFormatExpressions read FColumnExpressions write SetColumnExpressions;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InsertItem(Select: Boolean);
    function CanInsert: Boolean;
    function CanUpdate: Boolean;
    procedure UpdateItem;
    procedure AddItem(Select: Boolean = True);
    procedure ClearList; virtual;
    procedure FillList; virtual;
    procedure ResetList; virtual;
    procedure EvaluateControlExpression(AColumnExpressionItem:
      TColumnFormatExpressionItem; const AExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType); overload;
    procedure ExecuteAssignToControlExpression(AColumnExpressionItem:
      TColumnFormatExpressionItem;
      const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType); overload;
    procedure EvaluateSourceExpression(AColumnExpressionItem:
      TColumnFormatExpressionItem;
      const AExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType); overload;
    procedure ExecuteAssignToSourceExpression(AColumnExpressionItem:
      TColumnFormatExpressionItem;
      const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType); reintroduce; virtual;
    [Default(True)]
    property AutoFill: Boolean read FAutoFill write SetAutoFill default True;
    [Default(-1)]
    property BufferCount: Integer read FDeprecatedBufferCount write FDeprecatedBufferCount default -1;
    property FormatControlExpressions: TExpressions read FFormatControlExpressions write SetFormatControlExpressions;
    property ClearControlExpressions: TExpressions read FClearControlExpressions write SetClearControlExpressions;
    property ListItemStyle: string read FListItemStyle write SetListItemStyle;
                                                      
    property BreakExpression: string read FBreakExpression write FBreakExpression;
    property BreakMemberName: string read FBreakMemberName write FBreakMemberName;
    property BreakGroups: TFillBreakGroups read FBreakGroups write SetBreakGroups;
    property DisableBreakGroups: Boolean read FDisableBreakGroups write FDisableBreakGroups;
    property OnFillingRecord: TFillListItemEvent read FOnFillingRecord write FOnFillingRecord;
    property OnFilledRecord: TFillListItemEvent read FOnFilledRecord write FOnFilledRecord;
    property OnFillingRecords: TNotifyEvent read FOnFillingRecords write FOnFillingRecords;
    property OnFilledRecords: TNotifyEvent read FOnFilledRecords write FOnFilledRecords;
  end;

  TBindGridList = class(TCustomBindGridList)
  published
    property ControlComponent;
    property SourceComponent;
    property ColumnExpressions;
    property FormatControlExpressions;
    property ClearControlExpressions;
    property AutoFill;
    property AutoActivate;
    property OnAssigningValue;
    property OnAssignedValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
    property ListItemStyle;
    property BreakExpression;
    property BreakMemberName;
    property BreakGroups;
  end;

  TCustomBindGridListLookup = class(TCustomBindGridList)
  private
    FLookupEditor: IBindListLookupEditor;
    FLookupExpression: TBindingExpression;
    FLookupValueSourceExpression: string;
    FLookupValueSourceMemberName: string;
    procedure SetLookupValueSourceMemberName(const Value: string);
    procedure SetLookupValueSourceExpression(const Value: string);
    procedure CheckLookupList;
  protected
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName,
      ANewMemberName: string); override;
    procedure FillRecord(const AEditor: IBindListEditor; //AEditorScope: IScope;
      AEvaluate: TProc); override;
    procedure FillRecords(const AEditor: IBindListEditor); override;
    function TryGetBindListEditor(out AEditor: IBindListEditorCommon): Boolean; override;
  public
    function GetSelectedValue: TValue;
    property LookupValueSourceExpression: string read FLookupValueSourceExpression write SetLookupValueSourceExpression;
    property LookupValueSourceMemberName: string read FLookupValueSourceMemberName write SetLookupValueSourceMemberName;
  end;

  TCustomBindGridListLink = class(TCustomBindGridList, IBindPosition,
    IBindLink, IBindListUpdate)
  private
    FParseExpressionObjects: TList<TBindingExpression>;
    FParseExpressions:  TExpressions;
    FPosSourceExpressions: TExpressions;
    FPosControlExpressions: TExpressions;
    FPosControlExpressionObjects: TList<TBindingExpression>;
    FPosSourceExpressionObjects: TList<TBindingExpression>;
    FControlExpressionObject: TBindingExpression;
    FControlObserver: TControlObserver;
    FUpdateCounter: Integer;
    FDeprecatedBufferCount: Integer;
    FLockPosControl: Integer;
    procedure SetPosControlExpressions(const Value: TExpressions);
    procedure SetPosSourceExpressions(const Value: TExpressions);
    procedure SetParseExpressions(const Value: TExpressions);
    procedure ClearModified;
    function RequiresControlHandler: Boolean;
    procedure CheckEditingLink;
  protected
    function IsLinked: Boolean; override;
    procedure UpdateControlChanging; override;
    procedure FreeExpressionsObjects; override;
    procedure UpdateExpressions; override;
    { IBindPosition }
    function GetBindComp: TComponent;
    procedure PosChanged;
    procedure PosChanging;
    function GetActive: Boolean; override;
    procedure SetActive(Value: Boolean); override;
    procedure EvaluatePosControl;
    procedure EvaluatePosSource;
    procedure EvaluatePosClear;
    { IBindLink }
    function GetUpdating: Boolean;
    procedure BeginUpdate;
    procedure EndUpdate;
    function IsRequired: Boolean;
    procedure SetIsReadOnly(Value: Boolean);
    function IsValidChar(AKey: Char): Boolean;
    function GetCanModify: Boolean;
    procedure SetModified;
    function GetIsModified: Boolean;
    function Edit: Boolean;
    function GetIsEditing: Boolean;
    procedure Reset;
    procedure UpdateRecord;
    procedure EvaluateParse(const AMemberName: string);
    procedure EvaluateFormat(const AMemberName: string);
    procedure EvaluateClear(const AMemberName: string);
    procedure ClearEditingLink; virtual;
    { IBindListUpdate }
    procedure UpdateList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ResetList; override;
    property ControlComponent: TComponent read GetControlComponent write SetControlComponent;
    property PosSourceExpressions: TExpressions read FPosSourceExpressions write SetPosSourceExpressions;
    property PosControlExpressions: TExpressions read FPosControlExpressions write SetPosControlExpressions;
    property ParseExpressions: TExpressions read FParseExpressions write SetParseExpressions;
  end;

  TCustomBindGridLink = class(TActivatedContainedBindComponent, IBindPosition,
    IBindLink, IBindLinkColumns, IBindListUpdate, IBindActivate)
  public
  type
    TArrayListCellExpression = TArray<TList<TEvalEnumeratorToEditor>>;
  private
    FBindListEditor: IBindListEditorCommon;
    FControlObserver: TControlObserver;
    FUpdateCounter: Integer;
    FPosSourceExpressions: TExpressions;
    FPosControlExpressions: TExpressions;
    FPosControlExpressionObjects: TList<TBindingExpression>;
    FPosSourceExpressionObjects: TList<TBindingExpression>;
    FFormatControlExpressionObjects: TList<TBindingExpression>;
    FClearControlExpressionObjects: TList<TBindingExpression>;
    FControlExpressionObject: TBindingExpression;
    FFormatControlExpressions: TExpressions;
    FClearControlExpressions: TExpressions;
    FLockPosControl: Integer;
    FOnFillingRecord: TFillListItemEvent;
    FOnFilledRecord: TFillListItemEvent;
    procedure SetColumnExpressions(const Value: TColumnLinkExpressions);
    function GetControlScopes(
      AColumnExpressionItem: TColumnLinkExpressionItem): TArray<IScope>;
    function GetSourceScopes(
      AColumnExpressionItem: TColumnLinkExpressionItem): TArray<IScope>;
    function GetBindListEditor: IBindListEditorCommon;
    function GetScopeRecordEnumerator: IScopeRecordEnumerator;
    procedure EvaluateExpressionItem(AColumnExpressionItem: TColumnLinkExpressionItem; AItem: TExpressionItem; AEditorScope,
      AEnumScope: IScope);
    procedure EvaluateExpressions(AColumnExpressionItem: TColumnLinkExpressionItem; AEditorScope: IScope;
      const AEditorExpression: string; AEnumScope: IScope;
      const AEnumExpression: string); overload;
    procedure EvaluateSourceExpression(AEnumScope: IScope;
      const AEnumExpression: string; ACallback: TProc<IValue>); overload;
    function GetScopeCurrentRecord(AColumnExpressionItem: TColumnLinkExpressionItem): IScope;
    procedure SetPosControlExpressions(const Value: TExpressions);
    procedure SetPosSourceExpressions(const Value: TExpressions);
    function FindColumnExpressionItem(AIndex: Integer;
      AName: string): TColumnLinkExpressionItem;
    procedure SetClearControlExpressions(const Value: TExpressions);
    procedure SetFormatControlExpressions(const Value: TExpressions);
    procedure EvaluateClearControl;
    procedure EvaluateFormatControl;
    procedure FormatColumns;
    procedure UpdateRow(AEditor: IBindListVirtualEditor);
    //procedure CallbackGetValue(ACol, ARow: Integer; ACallback: TProc<TValue>);
    procedure EvaluateFormatCallback(ACol, ARow: Integer; AEditorScope: IScope; ACanCacheExpressions: Boolean);
    procedure GetBindingExpressions(const AEnumerator: IScopeRecordEnumerator;
      const AEditor: IBindListEditor;
      ACallback: TProc<TArrayListCellExpression>);
    function CreateUnmanagedExpression(
      AColumnExpressionItem: TColumnLinkExpressionItem; AEditorScope: IScope;
      const AEditorExpression: string; AEnumScope: IScope;
      const AEnumExpression: string): TBindingExpression;
    function CreateUnmanagedExpressionItem(
      AColumnExpressionItem: TColumnLinkExpressionItem; AItem: TExpressionItem;
      AEditorScope, AEnumScope: IScope): TBindingExpression;
    procedure SetBindListEditor(const Value: IBindListEditorCommon);
  var
    FUnmanagedColumnExpressions: TDictionary<Integer, TList<TBindingExpression>>;
    FDeprecatedBufferCount: Integer;
    FColumnExpressions: TColumnLinkExpressions;
    FEditColumnName: string;
    FEditColumnIndex: Integer;
    FEditColumnCurrent: TVarRec;
    FDeferActive: Boolean;
    FActive: Boolean;
    FAutoFill: Boolean;
    procedure SetAutoFill(const Value: Boolean);
    function UpdateColumnCurrent: string;
  protected
    function IsLinked: Boolean; virtual;
    function TryGetBindListEditor(out AEditor: IBindListEditorCommon): Boolean;
    procedure DoFillingRecord(const AEditor: IBindListEditor); virtual;
    procedure DoFilledRecord(const AEditor: IBindListEditor); virtual;
    procedure FillRecord(const AEditor: IBindListEditor;
      AEvaluate: TProc); virtual;
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName,
      ANewMemberName: string); override;
    procedure UpdateControlChanging; override;
    function RequiresControlHandler: Boolean; virtual;
    procedure CheckEditingLink; virtual;
    procedure ClearEditingLink; virtual;
    procedure FreeExpressionsObjects; override;
    procedure UpdateExpressions; override;
    { IBindPosition }
    function GetBindComp: TComponent;
    procedure PosChanged;
    procedure PosChanging;
    function GetActive: Boolean; override;
    procedure SetActive(Value: Boolean); override;
    procedure EvaluatePosControl;
    procedure EvaluatePosSource;
    procedure EvaluatePosClear;
    { IBindLink }
    function GetUpdating: Boolean;
    procedure BeginUpdate;
    procedure EndUpdate;
    function IsRequired: Boolean;
    procedure SetIsReadOnly(Value: Boolean);
    function IsValidChar(AKey: Char): Boolean;
    function GetCanModify: Boolean;
    procedure SetModified;
    procedure ClearModified;
    function GetIsModified: Boolean;
    function Edit: Boolean;
    function GetIsEditing: Boolean;
    procedure Reset;
    procedure UpdateRecord;
    procedure EvaluateParse(const AMemberName: string);
    procedure EvaluateFormat(const AMemberName: string);
    procedure EvaluateClear(const AMemberName: string);
    { IBindLinkColumns }
    function GetEditColumnName: string;
    function GetEditColumnIndex: Integer;
    procedure SetEditColumn(const AName: string; AIndex: Integer);
    { IBindListUpdate }
    procedure UpdateList;
    procedure IBindPosition.SetActive = BindActivate;
    procedure IBindLink.SetActive = BindActivate;
    { IBindActivate }
    procedure IBindActivate.SetActive = BindActivate;
    // Backward compatability
    procedure DefineProperties(Filer: TFiler); override;
    property BindListEditor: IBindListEditorCommon read FBindListEditor write SetBindListEditor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure ClearGrid; virtual;
    procedure FillGrid; virtual;
    procedure ResetGrid; virtual;
    procedure ResetColumns;
    function CanSetControlComponent(AControl: TComponent): Boolean; override;
    procedure EvaluateControlExpression(AColumnExpressionItem:
      TColumnLinkExpressionItem; const AExpression: string;
      ACallback: TProc<IValue>; AType: TBindCompExpressionType); overload;
    procedure ExecuteAssignToControlExpression(AColumnExpressionItem:
      TColumnLinkExpressionItem;
      const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType); overload;
    procedure EvaluateSourceExpression(AColumnExpressionItem:
      TColumnLinkExpressionItem;
      const AExpression: string; ACallback: TProc<IValue>; AType: TBindCompExpressionType); overload;
    procedure ExecuteAssignItemToSourceExpression(AColumnExpressionItem:
      TColumnLinkExpressionItem;
      const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
      AType: TBindCompExpressionType); reintroduce;
    property ColumnExpressions: TColumnLinkExpressions read FColumnExpressions write SetColumnExpressions;
    [Default(True)]
    property AutoFill: Boolean read FAutoFill write SetAutoFill default True;
    property PosSourceExpressions: TExpressions read FPosSourceExpressions write SetPosSourceExpressions;
    property PosControlExpressions: TExpressions read FPosControlExpressions write SetPosControlExpressions;
    property FormatControlExpressions: TExpressions read FFormatControlExpressions write SetFormatControlExpressions;
    property ClearControlExpressions: TExpressions read FClearControlExpressions write SetClearControlExpressions;
    [Default(-1)]
    property BufferCount: Integer read FDeprecatedBufferCount write FDeprecatedBufferCount default -1;
    property OnFillingRecord: TFillListItemEvent read FOnFillingRecord write FOnFillingRecord;
    property OnFilledRecord: TFillListItemEvent read FOnFilledRecord write FOnFilledRecord;
  end;

  TBindGridLink = class(TCustomBindGridLink)
  published
    property ControlComponent;
    property SourceComponent;
    property ColumnExpressions;
    property PosControlExpressions;
    property PosSourceExpressions;
    property FormatControlExpressions;
    property ClearControlExpressions;
    property AutoFill;
    property AutoActivate;
    property OnAssigningValue;
    property OnAssignedValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;

  TColumnFormatExpressionItem = class(TCollectionItem)
  private
    FName: string;
    FColumnName: string;
    FColumnIndex: Integer;
    FFormatCellExpressions: TExpressions;
    FFormatColumnExpressions: TExpressions;
    FSourceMemberName: string;
    FControlMemberName: string;
    FFormatCellHeaderExpressions: TExpressions;
    function GetColumnExpressions: TColumnFormatExpressions;
    function GetName: string;
    procedure SetName(const Value: string);
    procedure SetFormatCellExpressions(const Value: TExpressions);
    procedure SetFormatColumnExpressions(const Value: TExpressions);
    function GetColumnIndex: integer;
    procedure SetColumnIndex(Value: Integer);
    procedure SetFormatCellHeaderExpressions(const Value: TExpressions);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property ColumnExpressions: TColumnFormatExpressions read GetColumnExpressions;
  published
    property Name: string read GetName write SetName;
    property ColumnName: string read FColumnName write FColumnName;
    property ColumnIndex: Integer read GetColumnIndex write SetColumnIndex;
    property SourceMemberName: string read FSourceMemberName write FSourceMemberName;
    property ControlMemberName: string read FControlMemberName write FControlMemberName;
    property FormatCellExpressions: TExpressions read FFormatCellExpressions write SetFormatCellExpressions;
    property FormatCellHeaderExpressions: TExpressions read FFormatCellHeaderExpressions write SetFormatCellHeaderExpressions;
    property FormatColumnExpressions: TExpressions read FFormatColumnExpressions write SetFormatColumnExpressions;
  end;

  TColumnLinkExpressionItem = class(TCollectionItem)
  private
    FName: string;
    FColumnName: string;
    FColumnIndex: Integer;
    FFormatCellExpressions: TExpressions;
    FFormatColumnExpressions: TExpressions;
    FParseCellExpressions: TExpressions;
    FSourceMemberName: string;
    FControlMemberName: string;
    function GetColumnExpressions: TColumnLinkExpressions;
    function GetName: string;
    procedure SetName(const Value: string);
    procedure SetFormatCellExpressions(const Value: TExpressions);
    procedure SetParseExpressions(const Value: TExpressions);
    function GetColumnIndex: integer;
    procedure SetColumnIndex(Value: Integer);
    procedure SetFormatColumnExpressions(const Value: TExpressions);
    procedure SetSourceMemberName(const Value: string);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property ColumnExpressions: TColumnLinkExpressions read GetColumnExpressions;
  published
    property Name: string read GetName write SetName;
    property ColumnName: string read FColumnName write FColumnName;
    property ColumnIndex: Integer read GetColumnIndex write SetColumnIndex;
    property SourceMemberName: string read FSourceMemberName write SetSourceMemberName;
    property ControlMemberName: string read FControlMemberName write FControlMemberName;
    property ParseCellExpressions: TExpressions read FParseCellExpressions write SetParseExpressions;
    property FormatCellExpressions: TExpressions read FFormatCellExpressions write SetFormatCellExpressions;
    property FormatColumnExpressions: TExpressions read FFormatColumnExpressions write SetFormatColumnExpressions;
  end;

  TColumnFormatExpressions = class(TOwnedCollection)
  type
    TEnumerator = TCollectionEnumerator<TColumnFormatExpressionItem>;
  private
    FModified: Boolean;
    function GetItem(Index: Integer): TColumnFormatExpressionItem;
    procedure SetItem(Index: Integer; const Value: TColumnFormatExpressionItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    property Modified: Boolean read FModified;
  public
    function GetEnumerator: TEnumerator;
    function AddExpression: TColumnFormatExpressionItem;
    property Items[Index: Integer]: TColumnFormatExpressionItem read GetItem write SetItem; default;
  end;


  TColumnLinkExpressions = class(TOwnedCollection)
  type
    //TEnumerator = TCollection.TEnumerator<TColumnLinkExpressionItem>;
    TEnumerator = TCollectionEnumerator<TColumnLinkExpressionItem>;
  private
    FModified: Boolean;
    function GetItem(Index: Integer): TColumnLinkExpressionItem;
    procedure SetItem(Index: Integer; const Value: TColumnLinkExpressionItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    property Modified: Boolean read FModified;
  public
    function GetEnumerator: TEnumerator;
    function AddExpression: TColumnLinkExpressionItem;
    property Items[Index: Integer]: TColumnLinkExpressionItem read GetItem write SetItem; default;
  end;

  TExpressionItem = class(TCollectionItem)
  private
    FControlExpression: string;
    FSourceExpression: string;
    FCustom: Boolean;
    function GetExpressions: TExpressions;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  public
    property Expressions: TExpressions read GetExpressions;
    property Custom: Boolean read FCustom write FCustom;
  published
    property ControlExpression: string read FControlExpression write FControlExpression;
    property SourceExpression: string read FSourceExpression write FSourceExpression;
  end;

  TExpressionItemDir = class(TExpressionItem)
  private
    FDirection: TExpressionDirection;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  published
    property Direction: TExpressionDirection read FDirection write
      FDirection default dirSourceToControl;
  end;

{ TExpressions }

  TBindCompExpressionCollection = class(TOwnedCollection)

  end;

  TExpressions = class(TBindCompExpressionCollection)
  type
    //TEnumerator = class(TCollection.TEnumerator<TExpressionItem>);
    TEnumerator = TCollectionEnumerator<TExpressionItem>;
  private
    function GetItem(Index: Integer): TExpressionItem;
    procedure SetItem(Index: Integer; const Value: TExpressionItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    function GetEnumerator: TEnumerator;
    function AddExpression: TExpressionItem;
    property Items[Index: Integer]: TExpressionItem read GetItem write SetItem; default;
  end;

  TExpressionDirEnumerator = class;

  TExpressionsDir = class(TBindCompExpressionCollection)
  private
    function GetItem(Index: Integer): TExpressionItemDir;
    procedure SetItem(Index: Integer; const Value: TExpressionItemDir);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    function GetEnumerator: TExpressionDirEnumerator;
    function AddExpression: TExpressionItemDir;
    property Items[Index: Integer]: TExpressionItemDir read GetItem write SetItem; default;
  end;

  TExpressionDirEnumerator =  class(TCollectionEnumerator)
  public
    function GetCurrent: TExpressionItemDir; inline;
    property Current: TExpressionItemDir read GetCurrent;
  end;

  /// <summary>Binding component which wraps another binding component</summary>
  TBindComponentDelegate = class(TContainedBindComponent)
  private
    function GetOnAssigningValue: TBindCompAssigningValueEvent;
    function GetOnEvalError: TBindCompEvalErrorEvent;
    procedure SetOnAssigningValue(const Value: TBindCompAssigningValueEvent);
    procedure SetOnEvalError(const Value: TBindCompEvalErrorEvent);
    function GetOnActivated: TNotifyEvent;
    function GetOnActivating: TNotifyEvent;
    procedure SetOnActivated(const Value: TNotifyEvent);
    procedure SetOnActivating(const Value: TNotifyEvent);
    function GetOnAssignedValue: TBindCompAssignedValueEvent;
    procedure SetOnAssignedValue(const Value: TBindCompAssignedValueEvent);
  protected
    procedure Reactivate; virtual; abstract;
    function GetActive: Boolean; virtual; abstract;
    procedure GenerateExpressions(Sender: TComponent); virtual; abstract;
    procedure ClearGeneratedExpressions(Sender: TComponent); virtual; abstract;
    procedure Activated(Sender: TComponent); virtual;
    function CanActivate(Sender: TComponent): Boolean; virtual; abstract;
    function RequiresControlHandler: Boolean; virtual; abstract;
    function GetSourceScopes(Sender: TComponent; AScopes: TArray<IScope>): TArray<IScope>; virtual;
    procedure MemberRenaming(Sender: TComponent; AComponent: TComponent;
      const ACurMemberName, ANewMemberName: string); virtual;
    function GetUseEvalShortcuts: Boolean; virtual;
  public
    function GetDelegates: TArray<TCommonBindComponent>; virtual; abstract;
    property OnAssigningValue: TBindCompAssigningValueEvent read GetOnAssigningValue write SetOnAssigningValue;
    property OnAssignedValue: TBindCompAssignedValueEvent read GetOnAssignedValue write SetOnAssignedValue;
    property OnEvalError: TBindCompEvalErrorEvent read GetOnEvalError write SetOnEvalError;
    property OnActivating: TNotifyEvent read GetOnActivating write SetOnActivating;
    property OnActivated: TNotifyEvent read GetOnActivated write SetOnActivated;
  end;

  /// <summary>Binding component which wraps another binding component, and references a control</summary>
  TLinkControlDelegate = class(TBindComponentDelegate, IBindActivate)
  protected
    function GetControlComponent: TComponent; override;
    procedure SetControlComponent(const Value: TComponent);  override;
    function GetControlComponentMemberName: string; virtual;
    procedure SetActive(AValue: Boolean); virtual;
    procedure BindActivate(AValue: Boolean); virtual;
    { IBindActivate }
    procedure IBindActivate.SetActive = BindActivate;
  public
    function CanSetControlComponent(Value: TComponent): Boolean; override;
  end;

  /// <summary>Binding component which wraps another binding component, and references a control, datasource and field</summary>
  TLinkControlToFieldDelegate = class(TLinkControlDelegate)
  protected
    procedure SetDataSource(const Value: TBaseLinkingBindSource);
    function GetDataSource: TBaseLinkingBindSource;
    procedure SetSourceMember(const Value: string);
    function GetSourceMember: string;
    function GetDisplaysMultipleSourceMembers: Boolean; virtual;
  public
    property DataSource: TBaseLinkingBindSource read GetDataSource write SetDataSource;
  end;

  /// <summary>Direction of data flow for a TLinkControlToFieldDelegate</summary>
  TLinkControlToFieldDirection = (linkBidirectional, linkDataToControl, linkControlToData);
  /// <summary>Link a control to a field</summary>
  ///  <remarks>If the direction is bidirectiona then the control must support IEditLinkObserver</remarks>
  TCustomLinkControlToField = class(TLinkControlToFieldDelegate)
  private
    FDirection: TLinkControlToFieldDirection;
    FLookupMemberChange: TBasicBindComponent;
    FBinding: TExpressionsBindComponent;
    FCustomFormat: string;
    FCustomParse: string;
    FLookupValueFieldName: string;
    FLookupDataSource: TBaseLinkingBindSource;
    FLookupKeyFieldName: string;
    FUseEvalShortcuts: Boolean;
    function GetAutoActivate: Boolean;
    procedure SetDirection(const Value: TLinkControlToFieldDirection);
    function GetTrack: Boolean;
    procedure SetTrack(const Value: Boolean);
    procedure SetCustomFormat(const Value: string);
    procedure SetCustomParse(const Value: string);
    procedure SetLookupDataSource(const Value: TBaseLinkingBindSource);
    procedure SetLookupKeyFieldName(const Value: string);
    procedure SetLookupValueFieldName(const Value: string);
    function UsingLookup: Boolean;
    function GetDirection: TLinkControlToFieldDirection;
    procedure SetUseEvalShortcuts(const Value: Boolean);
  protected
    procedure Reactivate; override;
    function AllowBidirectional: Boolean; virtual;
    function CheckAllowBidirectional: Boolean; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetSourceScopes(Sender: TComponent;
      AScopes: TArray<IScope>): TArray<IScope>; override;
    procedure MemberRenaming(Sender: TComponent; AComponent: TComponent;
      const ACurMemberName, ANewMemberName: string); override;
    procedure SetAutoActivate(const Value: Boolean); virtual;
    function GetControlExpression: string; virtual;
    procedure SetActive(Value: Boolean); override;
    function GetActive: Boolean; override;
    function CanActivate(Sender: TComponent): Boolean; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    function RequiresControlHandler: Boolean; override;
    procedure Loaded; override;
    function GetUseEvalShortcuts: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearExpressionProperties; virtual;
    function GetDelegates: TArray<TCommonBindComponent>; override;
    property Binding: TExpressionsBindComponent read FBinding;
    property FieldName: string read GetSourceMember write SetSourceMember;
    [Default(True)]
    property AutoActivate: Boolean read GetAutoActivate write SetAutoActivate default True;
    property Active: Boolean read GetActive write SetActive;
    property Direction: TLinkControlToFieldDirection read GetDirection write SetDirection default linkBidirectional;
    procedure GenerateExpressions(Sender: TComponent); override;
    property Control: TComponent read GetControlComponent write SetControlComponent;
    property ControlMemberName: string read GetControlComponentMemberName;
    property Track: Boolean read GetTrack write SetTrack;
    property CustomFormat: string read FCustomFormat write SetCustomFormat;
    property CustomParse: string read FCustomParse write SetCustomParse;
    property LookupDataSource: TBaseLinkingBindSource read FLookupDataSource write SetLookupDataSource;
    property LookupKeyFieldName: string read FLookupKeyFieldName write SetLookupKeyFieldName;
    property LookupValueFieldName: string read FLookupValueFieldName write SetLookupValueFieldName;
    [Default(True)]
    property UseEvalShortcuts: Boolean read GetUseEvalShortcuts write SetUseEvalShortcuts default True;
  end;

  /// <summary>Link a control to a field</summary>
  ///  <remarks>If the direction is bidirectiona then the control must support IEditLinkObserver</remarks>
  TLinkControlToField = class(TCustomLinkControlToField)
  published
    property DataSource;
    property FieldName;
    property Control;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
    property Direction;
    property Track;
    property CustomFormat;
    property CustomParse;
    property LookupDataSource;
    property LookupKeyFieldName;
    property LookupValueFieldName;
    property UseEvalShortcuts;
  end;

  TFormatExpressionItem = class(TCollectionItem)
  private
    FSourceMemberName: string;
    FControlMemberName: string;
    FCustomFormat: string;
    procedure SetControlMemberName(const Value: string);
    procedure SetCustomFormat(const Value: string);
    procedure SetSourceMemberName(const Value: string);
  protected
    function GetDisplayName: string; override;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Collection: TCollection; const AControlMemberName: string; const ASourceMemberName: string = '';
      const ACustomFormat: string = ''); reintroduce;
  published
    property SourceMemberName: string read FSourceMemberName write SetSourceMemberName;
    property ControlMemberName: string read FControlMemberName write SetControlMemberName;
    property CustomFormat: string read FCustomFormat write SetCustomFormat;
  end;

  IControlEditorName = interface
    ['{54BA961D-A606-469E-98BE-0F39E97E98B6}']
    function GetControlEditorName(const AGuid: TGuid): string;
  end;

  TFormatExpressions = class(TOwnedCollection)
  type
    TEnumerator = TCollectionEnumerator<TFormatExpressionItem>;
  private
    FOnUpdate: TProc<TCollectionItem>;
    //FModified: Boolean;
    function GetItem(Index: Integer): TFormatExpressionItem;
    procedure SetItem(Index: Integer; const Value: TFormatExpressionItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    //property Modified: Boolean read FModified;
    procedure Update(AItem: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent);
    function GetEnumerator: TEnumerator;
    function AddExpression: TFormatExpressionItem;
    procedure SourceMemberRenaming(
      const ACurMemberName, ANewMemberName: string);
    property Items[Index: Integer]: TFormatExpressionItem read GetItem write SetItem; default;
    property OnUpdate: TProc<TCollectionItem> read FOnUpdate write FOnUpdate;
    
  end;

  TCustomLinkFillControlToField = class(TCustomLinkControlToField, IControlEditorName)
  private
    FBindList: TCustomBindGridListLookup;
    FFillDisplayCustomFormat: string;
    FFillValueCustomFormat: string;
    FFillExpressions: TFormatExpressions;
    FDeprecatedAutoBufferCount: Boolean;
    FFillHeaderExpressions: TFormatExpressions;
    FFillBreakFieldName: string;
    FFillBreakCustomFormat: string;
    FFillHeaderFieldName: string;
    FFillHeaderCustomFormat: string;
    function GetAutoFill: Boolean;
    function GetBufferCount: Integer;
    function GetFillDataSource: TBaseLinkingBindSource;
    function GetFillDisplayFieldName: string;
    function GetFillValueFieldName: string;
    procedure SetAutoFill(const Value: Boolean);
    procedure SetBufferCount(const Value: Integer);
    procedure SetFillDataSource(const Value: TBaseLinkingBindSource);
    procedure SetFillDisplayFieldName(const Value: string);
    procedure SetFillValueFieldName(const Value: string);
    procedure SetFillDisplayCustomFormat(const Value: string);
    procedure SetFillValueCustomFormat(const Value: string);
    function GetListItemStyle: string;
    procedure SetListItemStyle(const Value: string);
    procedure SetFillExpressions(const Value: TFormatExpressions);
    procedure SetFillHeaderExpressions(const Value: TFormatExpressions);
    procedure FillExpressionsUpdate(AItem: TCollectionItem);
    procedure OnListRefreshing(Sender: TObject);
    procedure SetFillBreakCustomFormat(const Value: string);
    procedure SetFillBreakFieldName(const Value: string);
    procedure SetFillHeaderCustomFormat(const Value: string);
    procedure SetFillHeaderFieldName(const Value: string);
    function GetFillBreakGroups: TFillBreakGroups;
    procedure SetFillBreakGroups(const Value: TFillBreakGroups);
    function GetOnFilledListItem: TFillListItemEvent;
    function GetOnFillingListItem: TFillListItemEvent;
    procedure SetOnFilledListItem(const Value: TFillListItemEvent);
    procedure SetOnFillingListItem(const Value: TFillListItemEvent);
    function GetOnFilledList: TNotifyEvent;
    function GetOnFillingList: TNotifyEvent;
    procedure SetOnFilledList(const Value: TNotifyEvent);
    procedure SetOnFillingList(const Value: TNotifyEvent);
  protected
    procedure MemberRenaming(Sender, AComponent: TComponent;
      const ACurMemberName, ANewMemberName: string); override;
    function GetControlComponentMemberName: string; override;
    procedure Activated(Sender: TComponent); override;
    function CanActivate(Sender: TComponent): Boolean; overload; override;
    procedure SetAutoActivate(const Value: Boolean); override;
    function GetControlExpression: string; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    procedure Loaded; override;
    procedure SetActive(Value: Boolean); override;
    function GetActive: Boolean; override;
    procedure SetControlComponent(const AValue: TComponent); override;
    { IControlEditorName }
    function GetControlEditorName(const AGuid: TGuid): string;
    // Backward compatability
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearExpressionProperties; override;
    function GetDelegates: TArray<TCommonBindComponent>; override;
    function CanSetControlComponent(Value: TComponent): Boolean; override;
    procedure GenerateExpressions(Sender: TComponent); override;
    function UsingLookupProperties: Boolean;
    property BindList: TCustomBindGridListLookup read FBindList;
    property FillDataSource: TBaseLinkingBindSource read GetFillDataSource write SetFillDataSource;
    property FillValueFieldName: string read GetFillValueFieldName write SetFillValueFieldName;
    property FillDisplayFieldName: string read GetFillDisplayFieldName write SetFillDisplayFieldName;
    property FillDisplayCustomFormat: string read FFillDisplayCustomFormat write SetFillDisplayCustomFormat;
    property FillValueCustomFormat: string read FFillValueCustomFormat write SetFillValueCustomFormat;
    property AutoFill: Boolean read GetAutoFill write SetAutoFill;
    property BufferCount: Integer read GetBufferCount write SetBufferCount;
    property ListItemStyle: string read GetListItemStyle write SetListItemStyle;
    property FillExpressions: TFormatExpressions read FFillExpressions write SetFillExpressions;
    property AutoBufferCount: Boolean read FDeprecatedAutoBufferCount write FDeprecatedAutoBufferCount;
    property FillHeaderExpressions: TFormatExpressions read FFillHeaderExpressions write SetFillHeaderExpressions;
    property FillBreakFieldName: string read FFillBreakFieldName write SetFillBreakFieldName;
    property FillBreakCustomFormat: string read FFillBreakCustomFormat write SetFillBreakCustomFormat;
    property FillHeaderFieldName: string read FFillHeaderFieldName write SetFillHeaderFieldName;
    property FillHeaderCustomFormat: string read FFillHeaderCustomFormat write SetFillHeaderCustomFormat;
    property FillBreakGroups: TFillBreakGroups read GetFillBreakGroups write SetFillBreakGroups;
    property OnFillingListItem: TFillListItemEvent read GetOnFillingListItem write SetOnFillingListItem;
    property OnFilledListItem: TFillListItemEvent read GetOnFilledListItem write SetOnFilledListItem;
    property OnFillingList: TNotifyEvent read GetOnFillingList write SetOnFillingList;
    property OnFilledList: TNotifyEvent read GetOnFilledList write SetOnFilledList;
  end;

  /// <summary>Link a control to a field, fill the control with possible values</summary>
  ///  <remarks>If the direction is bidirectiona then the control must support IEditLinkObserver</remarks>
  TLinkFillControlToField = class(TCustomLinkFillControlToField)
  published
    property DataSource;
    property FieldName;
    property Control;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
    property Direction;
    property Track;
    property CustomParse;
    property CustomFormat;
    property FillDataSource;
    property FillValueFieldName;
    property FillDisplayFieldName;
    property FillDisplayCustomFormat;
    property FillValueCustomFormat;
    property AutoFill;
    property ListItemStyle;
    property FillExpressions;
    property FillHeaderExpressions;
    property FillBreakFieldName;
    property FillBreakCustomFormat;
    property FillHeaderFieldName;
    property FillHeaderCustomFormat;
    property FillBreakGroups;
    property OnFillingListItem;
    property OnFilledListItem;
    property OnFillingList;
    property OnFilledList;
    property UseEvalShortcuts;
  end;

  /// <summary>Link a list control, such as TListBox, to a field</summary>
  /// <remarks>If the direction is bidirectiona then the control must support IEditLinkObserver</remarks>
  TCustomLinkListControlToField = class(TLinkControlToFieldDelegate, IControlEditorName)
  private
    FDirection: TLinkControlToFieldDirection;
    FBindListLink: TCustomBindGridListLink;
    FCustomFormat: string;
    FFillExpressions: TFormatExpressions;
    FFillHeaderExpressions: TFormatExpressions;
    FFillBreakFieldName: string;
    FFillBreakCustomFormat: string;
    FFillHeaderFieldName: string;
    FFillHeaderCustomFormat: string;
    FCustomParse: string;
    FDeprecatedAutoBufferCount: Boolean;
    FUseEvalShortcuts: Boolean;
    function GetAutoActivate: Boolean;
    procedure SetAutoActivate(const Value: Boolean);
    procedure SetCustomFormat(const Value: string);
    procedure SetCustomParse(const Value: string);
    function GetListItemStyle: string;
    procedure SetFillExpressions(const Value: TFormatExpressions);
    procedure SetFillHeaderExpressions(const Value: TFormatExpressions);
    procedure SetListItemStyle(const Value: string);
    procedure FillExpressionsUpdate(AItem: TCollectionItem);
    function GetBufferCount: Integer;
    procedure SetBufferCount(const Value: Integer);
    procedure OnListRefreshing(Sender: TObject);
    procedure SetFillBreakCustomFormat(const Value: string);
    procedure SetFillBreakFieldName(const Value: string);
    procedure SetFillHeaderCustomFormat(const Value: string);
    procedure SetFillHeaderFieldName(const Value: string);
    function GetFillBreakGroups: TFillBreakGroups;
    procedure SetFillBreakGroups(const Value: TFillBreakGroups);
    function GetOnFilledListItem: TFillListItemEvent;
    function GetOnFillingListItem: TFillListItemEvent;
    procedure SetOnFilledListItem(const Value: TFillListItemEvent);
    procedure SetOnFillingListItem(const Value: TFillListItemEvent);
    function GetOnFilledList: TNotifyEvent;
    function GetOnFillingList: TNotifyEvent;
    procedure SetOnFilledList(const Value: TNotifyEvent);
    procedure SetOnFillingList(const Value: TNotifyEvent);
    procedure SetUseEvalShortcuts(const Value: Boolean);
  protected
    procedure Reactivate; override;
    function GetActive: Boolean; override;
    procedure SetActive(Value: Boolean); override;
    function GetControlComponentMemberName: string; override;
    function CanActivate(Sender: TComponent): Boolean; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    function RequiresControlHandler: Boolean; override;
    procedure Loaded; override;
    function GetDisplaysMultipleSourceMembers: Boolean; override;
    { IControlEditorName }
    function GetControlEditorName(const AGuid: TGuid): string;
    procedure SetFieldName(const AName: string);
    // Backward compatability
    procedure DefineProperties(Filer: TFiler); override;
    function GetUseEvalShortcuts: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearExpressionProperties; virtual;
    procedure FillList;
    function GetDelegates: TArray<TCommonBindComponent>; override;
    property BindLink: TCustomBindGridListLink read FBindListLink;
    property FieldName: string read GetSourceMember write SetFieldName;
    [Default(True)]
    property AutoActivate: Boolean read GetAutoActivate write SetAutoActivate default True;
    property Active: Boolean read GetActive write SetActive;
    property Direction: TLinkControlToFieldDirection read FDirection write FDirection default linkBidirectional;
    [Default(-1)]
    property BufferCount: Integer read GetBufferCount write SetBufferCount default -1;
    property AutoBufferCount: Boolean read FDeprecatedAutoBufferCount write FDeprecatedAutoBufferCount;
    procedure GenerateExpressions(Sender: TComponent); override;
    property Control: TComponent read GetControlComponent write SetControlComponent;
    property ControlMemberName: string read GetControlComponentMemberName;
    property CustomFormat: string read FCustomFormat write SetCustomFormat;
    property CustomParse: string read FCustomParse write SetCustomParse;
    property FillExpressions: TFormatExpressions read FFillExpressions write SetFillExpressions;
    property ListItemStyle: string read GetListItemStyle write SetListItemStyle;
    property FillHeaderExpressions: TFormatExpressions read FFillHeaderExpressions write SetFillHeaderExpressions;
    property FillBreakFieldName: string read FFillBreakFieldName write SetFillBreakFieldName;
    property FillBreakCustomFormat: string read FFillBreakCustomFormat write SetFillBreakCustomFormat;
    property FillHeaderFieldName: string read FFillHeaderFieldName write SetFillHeaderFieldName;
    property FillHeaderCustomFormat: string read FFillHeaderCustomFormat write SetFillHeaderCustomFormat;
    property FillBreakGroups: TFillBreakGroups read GetFillBreakGroups write SetFillBreakGroups;
    property OnFillingListItem: TFillListItemEvent read GetOnFillingListItem write SetOnFillingListItem;
    property OnFilledListItem: TFillListItemEvent read GetOnFilledListItem write SetOnFilledListItem;
    property OnFillingList: TNotifyEvent read GetOnFillingList write SetOnFillingList;
    property OnFilledList: TNotifyEvent read GetOnFilledList write SetOnFilledList;
    [Default(True)]
    property UseEvalShortcuts: Boolean read GetUseEvalShortcuts write SetUseEvalShortcuts default True;
  end;

  /// <summary>Link a list control, such as TListBox, to a field</summary>
  /// <remarks>If the direction is bidirectiona then the control must support IEditLinkObserver</remarks>
  TLinkListControlToField = class(TCustomLinkListControlToField)
  published
    property DataSource;
    property FieldName;
    property Control;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
    property CustomFormat;
    property FillExpressions;
    property ListItemStyle;
    property FillHeaderExpressions;
    property FillBreakFieldName;
    property FillBreakCustomFormat;
    property FillHeaderFieldName;
    property FillHeaderCustomFormat;
    property FillBreakGroups;
    property OnFillingListItem;
    property OnFilledListItem;
    property OnFillingList;
    property OnFilledList;
  end;


  /// <summary>Binding component which wraps another binding component, and references a component property, datasource and fieldname</summary>
  TLinkPropertyToFieldDelegate = class(TBindComponentDelegate, IBindActivate)
  private
    FComponentProperty: string;
  protected
    procedure SetDataSource(const Value: TBaseLinkingBindSource);
    function GetDataSource: TBaseLinkingBindSource;
    procedure SetSourceMember(const Value: string);
    function GetSourceMember: string;
    function GetControlComponent: TComponent; override;
    procedure SetControlComponent(const Value: TComponent);  override;
    procedure SetComponentProperty(const Value: string);
    procedure SetActive(AValue: Boolean); virtual;
    procedure BindActivate(AValue: Boolean); virtual;
    { IBindActivate }
    procedure IBindActivate.SetActive = BindActivate;
  public
    property DataSource: TBaseLinkingBindSource read GetDataSource write SetDataSource;
    property Component: TComponent read GetControlComponent write SetControlComponent;
    property ComponentProperty: string read FComponentProperty write SetComponentProperty;
    property FieldName: string read GetSourceMember write SetSourceMember;
  end;

  /// <summary>Links the property of a component with a field</summary>
  /// <remarks>User input the the component is not monitored using an observer</remarks>
  TCustomLinkPropertyToField = class(TLinkPropertyToFieldDelegate)
  private
    FLookupMemberChange: TBasicBindComponent;
    FBindLink: TCustomBindLink;
    FCustomFormat: string;
    FLookupValueFieldName: string;
    FLookupDataSource: TBaseLinkingBindSource;
    FLookupKeyFieldName: string;
    function GetAutoActivate: Boolean;
    procedure SetAutoActivate(const Value: Boolean);
    procedure SetCustomFormat(const Value: string);
    procedure SetLookupDataSource(const Value: TBaseLinkingBindSource);
    procedure SetLookupKeyFieldName(const Value: string);
    procedure SetLookupValueFieldName(const Value: string);
    function UsingLookup: Boolean;
  protected
    procedure Reactivate; override;
    function GetActive: Boolean; override;
    procedure SetActive(Value: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetSourceScopes(Sender: TComponent;
      AScopes: TArray<IScope>): TArray<IScope>; override;
    procedure MemberRenaming(Sender: TComponent; AComponent: TComponent;
      const ACurMemberName, ANewMemberName: string); override;
  public
    function GetDelegates: TArray<TCommonBindComponent>; override;
    function CanActivate(Sender: TComponent): Boolean; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    function RequiresControlHandler: Boolean; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property BindLink: TCustomBindLink read FBindLink;
    [Default(True)]
    property AutoActivate: Boolean read GetAutoActivate write SetAutoActivate default True;
    property Active: Boolean read GetActive write SetActive;
    property CustomFormat: string read FCustomFormat write SetCustomFormat;
    procedure GenerateExpressions(Sender: TComponent); override;
    property LookupDataSource: TBaseLinkingBindSource read FLookupDataSource write SetLookupDataSource;
    property LookupKeyFieldName: string read FLookupKeyFieldName write SetLookupKeyFieldName;
    property LookupValueFieldName: string read FLookupValueFieldName write SetLookupValueFieldName;
  end;

  /// <summary>Links the property of a component with a field</summary>
  /// <remarks>User input the the component is not monitored using an observer</remarks>
  TLinkPropertyToField = class(TCustomLinkPropertyToField)
  published
    property DataSource;
    property FieldName;
    property Component;
    property CustomFormat;
    property ComponentProperty;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
    property LookupDataSource;
    property LookupKeyFieldName;
    property LookupValueFieldName;
  end;

  /// <summary>Binds a value of a control to a component property</summary>
  /// <remarks>The control must implement IEditObserver</remarks>
  TCustomLinkControlToProperty = class(TLinkControlDelegate)
  private
    FBindLink: TCustomBindControlValue;
    FDependency: TDependency;
    FComponentProperty: string;
    FCustomFormat: string;
    FCustomParse: string;
    FInitializeControlValue: Boolean;
    function GetAutoActivate: Boolean;
    procedure SetComponentProperty(const Value: string);
    procedure SetCustomFormat(const Value: string);
    function GetTrack: Boolean;
    procedure SetTrack(const Value: Boolean);
    procedure SetCustomParse(const Value: string);
    procedure SetInitializeControlValue(const Value: Boolean);
  protected
    procedure Reactivate; override;
    procedure SetAutoActivate(const Value: Boolean); virtual;
    function GetActive: Boolean; override;
    function GetControlExpression: string; virtual;
    procedure SetActive(Value: Boolean); override;
    procedure SetSourceComponent(const Value: TComponent);
    procedure SetControlComponent(const Value: TComponent); override;
    function GetSourceComponent: TComponent;
  public
    function GetDelegates: TArray<TCommonBindComponent>; override;
    function CanActivate(Sender: TComponent): Boolean; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    function RequiresControlHandler: Boolean; override;
    procedure Loaded; override;
    procedure ClearExpressionProperties; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property BindControlValue: TCustomBindControlValue read FBindLink;
    [Default(True)]
    property AutoActivate: Boolean read GetAutoActivate write SetAutoActivate default True;
    property Active: Boolean read GetActive write SetActive;
    procedure GenerateExpressions(Sender: TComponent); override;
    property Control: TComponent read GetControlComponent write SetControlComponent;
    property Component: TComponent read GetSourceComponent write SetSourceComponent;
    property ComponentProperty: string read FComponentProperty write SetComponentProperty;
    property ControlMemberName: string read GetControlComponentMemberName;
    property CustomFormat: string read FCustomFormat write SetCustomFormat;
    property CustomParse: string read FCustomParse write SetCustomParse;
    [Default(True)]
    property InitializeControlValue: Boolean read FInitializeControlValue write SetInitializeControlValue default True;
    property Track: Boolean read GetTrack write SetTrack;
  end;


  /// <summary>Binds a value of a control to a component property</summary>
  /// <remarks>The control must implement IEditObserver</remarks>
  TLinkControlToProperty = class(TCustomLinkControlToProperty)
  published
    property Control;
    property Track;
    property Component;
    property ComponentProperty;
    property AutoActivate;
    property CustomFormat;
    property CustomParse;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
    property InitializeControlValue;
  end;

  /// <summary>Binds a value of a control to a component property</summary>
  /// <remarks>The control must implement IEditObserver</remarks>
  TCustomLinkFillControlToProperty = class(TCustomLinkControlToProperty, IControlEditorName)
  private
    FBindList: TCustomBindGridListLookup;
    FFillDisplayCustomFormat: string;
    FFillValueCustomFormat: string;
    FFillExpressions: TFormatExpressions;
    FFillHeaderExpressions: TFormatExpressions;
    FFillBreakFieldName: string;
    FFillBreakCustomFormat: string;
    FFillHeaderFieldName: string;
    FFillHeaderCustomFormat: string;
    FDeprecatedAutoBufferCount: Boolean;
    function GetAutoFill: Boolean;
    function GetBufferCount: Integer;
    function GetFillDataSource: TBaseLinkingBindSource;
    function GetFillDisplayFieldName: string;
    function GetFillValueFieldName: string;
    procedure SetAutoFill(const Value: Boolean);
    procedure SetBufferCount(const Value: Integer);
    procedure SetFillDataSourceName(const Value: TBaseLinkingBindSource);
    procedure SetFillDisplayFieldName(const Value: string);
    procedure SetFillValueField(const Value: string);
    procedure SetFillDisplayCustomFormat(const Value: string);
    procedure SetFillValueCustomFormat(const Value: string);
    function GetListItemStyle: string;
    procedure SetListItemStyle(const Value: string);
    procedure SetFillExpressions(const Value: TFormatExpressions);
    procedure SetFillHeaderExpressions(const Value: TFormatExpressions);
    procedure FillExpressionsUpdate(AItem: TCollectionItem);
    procedure OnListRefreshing(Sender: TObject);
    procedure SetFillBreakCustomFormat(const Value: string);
    procedure SetFillBreakFieldName(const Value: string);
    procedure SetFillHeaderCustomFormat(const Value: string);
    procedure SetFillHeaderFieldName(const Value: string);
    function GetFillBreakGroups: TFillBreakGroups;
    procedure SetFillBreakGroups(const Value: TFillBreakGroups);
  protected
    procedure MemberRenaming(Sender, AComponent: TComponent;
      const ACurMemberName, ANewMemberName: string); override;
    function GetControlComponentMemberName: string; override;
    procedure Activated(Sender: TComponent); override;
    procedure SetAutoActivate(const Value: Boolean); override;
    function GetControlExpression: string; override;
    procedure SetActive(Value: Boolean); override;
    function GetActive: Boolean; override;
    procedure SetControlComponent(const AValue: TComponent); override;
    { IControlEditorName }
    function GetControlEditorName(const AGuid: TGuid): string;
    // Backward compatability
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearExpressionProperties; override;
    function GetDelegates: TArray<TCommonBindComponent>; override;
    function CanSetControlComponent(Value: TComponent): Boolean; override;
    function UsingLookupProperties: Boolean;
    function CanActivate(Sender: TComponent): Boolean; override;
    procedure Loaded; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    procedure GenerateExpressions(Sender: TComponent); override;
    property BindList: TCustomBindGridListLookup read FBindList;
    property FillDataSource: TBaseLinkingBindSource read GetFillDataSource write SetFillDataSourceName;
    property FillValueFieldName: string read GetFillValueFieldName write SetFillValueField;
    property FillDisplayFieldName: string read GetFillDisplayFieldName write SetFillDisplayFieldName;
    property FillDisplayCustomFormat: string read FFillDisplayCustomFormat write SetFillDisplayCustomFormat;
    property FillValueCustomFormat: string read FFillValueCustomFormat write SetFillValueCustomFormat;
    property AutoFill: Boolean read GetAutoFill write SetAutoFill;
    property BufferCount: Integer read GetBufferCount write SetBufferCount;
    property ListItemStyle: string read GetListItemStyle write SetListItemStyle;
    property FillExpressions: TFormatExpressions read FFillExpressions write SetFillExpressions;
    property AutoBufferCount: Boolean read FDeprecatedAutoBufferCount write FDeprecatedAutoBufferCount;
    property FillHeaderExpressions: TFormatExpressions read FFillHeaderExpressions write SetFillHeaderExpressions;
    property FillBreakFieldName: string read FFillBreakFieldName write SetFillBreakFieldName;
    property FillBreakCustomFormat: string read FFillBreakCustomFormat write SetFillBreakCustomFormat;
    property FillHeaderFieldName: string read FFillHeaderFieldName write SetFillHeaderFieldName;
    property FillHeaderCustomFormat: string read FFillHeaderCustomFormat write SetFillHeaderCustomFormat;
    property FillBreakGroups: TFillBreakGroups read GetFillBreakGroups write SetFillBreakGroups;
  end;

  /// <summary>Binds a value of a control to a component property, fill the control with possible values</summary>
  /// <remarks>The control must implement IEditObserver</remarks>
  TLinkFillControlToProperty = class(TCustomLinkFillControlToProperty)
  published
    property Track;
    property Control;
    property Component;
    property ComponentProperty;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;

    property FillDataSource;
    property FillValueFieldName;
    property FillDisplayFieldName;
    property FillDisplayCustomFormat;
    property FillValueCustomFormat;
    property CustomParse;
    property CustomFormat;
    property AutoFill;
    property ListItemStyle;
    property FillExpressions;
    property InitializeControlValue;
    property FillHeaderExpressions;
    property FillBreakFieldName;
    property FillBreakCustomFormat;
    property FillHeaderFieldName;
    property FillHeaderCustomFormat;
    property FillBreakGroups;
  end;

  TBindArtifactState = (eaInclude, eaExclude);
  TBindArtifactItem = class(TCollectionItem)
  private
    FID: string;
    FState: TBindArtifactState;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  published
    property ID: string read FID write FID;
    property State: TBindArtifactState read FState write FState;
  end;

{ TScopeMappings }

  TScopeMappings = class;

  TScopeMappingItem = class(TCollectionItem)
  private
    FAlias: string;
    (*[weak]*) FValComponent: TComponent;
    FValValue: TValue;
    (*[weak]*) FValObject: TObject;
    FValNotifyEvent: TNotifyEvent;
    FValVariant: Variant;
    function GetScopeMappings: TScopeMappings;
    procedure SetValObject(const Value: TObject);
    procedure SetValNotifyEvent(const Value: TNotifyEvent);
    procedure SetValComponent(const Value: TComponent);
    procedure SetValVariant(const Value: Variant);
    procedure ClearValue;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  public
    property ScopeMappings: TScopeMappings read GetScopeMappings;
    property ValObject: TObject read FValObject write SetValObject;
  published
    property Name: string read FAlias write FAlias;
    property ValComponent: TComponent read FValComponent write SetValComponent;
    property ValVariant: Variant read FValVariant write SetValVariant;
    property ValNotifyEvent: TNotifyEvent read FValNotifyEvent write SetValNotifyEvent;
  end;

  TScopeMappingsEnumerator =  class(TCollectionEnumerator)
  public
    function GetCurrent: TScopeMappingItem; inline;
    property Current: TScopeMappingItem read GetCurrent;
  end;

  TScopeMappings = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TScopeMappingItem;
    procedure SetItem(Index: Integer; const Value: TScopeMappingItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    function GetEnumerator: TScopeMappingsEnumerator;
    function AddExpression: TScopeMappingItem;
    property Items[Index: Integer]: TScopeMappingItem read GetItem write SetItem; default;
  end;


{ TBindArtifacts }

  TBindArtifacts = class(TOwnedCollection)
  private
    FModified: Boolean;
    function GetItem(Index: Integer): TBindArtifactItem;
    procedure SetItem(Index: Integer; const Value: TBindArtifactItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    property Modified: Boolean read FModified;
  public
    constructor Create(AOwner: TPersistent);
    property Items[Index: Integer]: TBindArtifactItem read GetItem write SetItem; default;
  end;

  TMethods = class(TBindArtifacts)
  protected
    procedure Update(Item: TCollectionItem); override;

  end;

  TOutputConverters = class(TBindArtifacts)
  protected
    procedure Update(Item: TCollectionItem); override;
  end;


  // A component can provide own scope
  IScopeComponent = interface
    ['{84C633CB-6A4B-407A-A8E4-D175923D8E61}']
    function GetScope: IScope;
    function GetMemberScope(const AMemberName: string): IScope;
    function GetScopeObject: TObject;
  end;

  IScopeExpressions = interface
    ['{EE75B066-3C8B-4102-9864-383447BFA6F2}']
    procedure AddExpression(AExpression: TBasicBindComponent);
    procedure RemoveExpression(AExpression: TBasicBindComponent);
  end;

  IScopeLocks = interface
    ['{174B9736-9D6B-46B6-9DD5-FE8A1B713C62}']
    procedure PosLockEnter;
    procedure PosLockLeave;
    function GetPosLock: Boolean;
    property PosLock: Boolean read GetPosLock;
  end;

  IScopeEditLink = interface
    ['{86C2783F-082F-4D78-98A3-CC3540D72A0D}']
    procedure SetField(ABindComp: TBasicBindComponent; const FieldName: string);
    function Edit(ABindComp: TBasicBindComponent): Boolean;
    function GetIsEditing(ABindComp: TBasicBindComponent): Boolean;
    procedure SetModified(ABindComp: TBasicBindComponent);
    function GetIsModified(ABindComp: TBasicBindComponent): Boolean;
    function GetCanModify(ABindComp: TBasicBindComponent): Boolean;
    procedure UpdateRecord(ABindComp: TBasicBindComponent);
    procedure Reset(ABindComp: TBasicBindComponent);
    procedure SetReadOnly(ABindComp: TBasicBindComponent; const Value: Boolean);
    procedure ClearModified(ABindComp: TBasicBindComponent);
    procedure PosChanging(ABindComp: TBasicBindComponent);
  end;

  TNotifyDistanceEvent = procedure(Sender: TObject; Distance: Integer) of object;

  IScopeActive = interface
    ['{56387EF7-0E9C-4049-AD67-37D0CA60F0D9}']
    function GetActive: Boolean;
    property Active: Boolean read GetActive;
  end;

  IScopeState = interface(IScopeActive)
    ['{2B1E1B3F-EBD5-46F0-A611-E5512D49BCFD}']
    function GetCanModify: Boolean;
    function GetCanDelete: Boolean;
    function GetCanInsert: Boolean;
    function GetEditing: Boolean;
    function GetCanRefresh: Boolean;
    procedure AddActiveChanged(LNotify: TNotifyEvent);
    procedure RemoveActiveChanged(LNotify: TNotifyEvent);
    procedure AddEditingChanged(LNotify: TNotifyEvent);
    procedure RemoveEditingChanged(LNotify: TNotifyEvent);
    procedure AddDataSetChanged(LNotify: TNotifyEvent);
    procedure RemoveDataSetChanged(LNotify: TNotifyEvent);
    procedure AddDataSetScrolled(LNotify: TNotifyDistanceEvent);
    procedure RemoveDataSetScrolled(LNotify: TNotifyDistanceEvent);
    property Editing: Boolean read GetEditing;
    property CanModify: Boolean read GetCanModify;
    property CanInsert: Boolean read GetCanInsert;
    property CanDelete: Boolean read GetCanDelete;
    property CanRefresh: Boolean read GetCanRefresh;
  end;

  IScopeEditor = interface
    ['{F2A94E16-2181-4943-8BDC-3D0CA7FDE336}']
    procedure Insert;
    procedure Delete;
    procedure Cancel;
    procedure Post;
    procedure Edit;
    procedure Refresh;
    function IsValidChar(const AFieldName: string; const AChar: Char): Boolean;
    function IsRequired(const AFieldName: string): Boolean;
  end;

  IScopeNavigator = interface
    ['{C71852CF-888A-42C6-9A15-B704E11229D8}']
    function GetBOF: Boolean;
    function GetEOF: Boolean;
    function GetSelected: Boolean;
    procedure Next;
    procedure Prior;
    procedure First;
    procedure Last;
    property Eof: Boolean read GetEOF; {Upper case EOF conflicts with C++}
    property BOF: Boolean read GetBOF;
    property Selected: Boolean read GetSelected;
  end;

  IScopeMemberNames = interface
  ['{E6D8BFA3-0453-436B-8434-D10623724644}']
    procedure GetMemberNames(AList: TStrings);
  end;

  IScopeMemberDisplayNames = interface
  ['{B02AADEE-2F39-4A26-A17C-5A7B391647FD}']
    function GetMemberDisplayName(const AMemberName: string; out ADisplayName: string): Boolean;
  end;

  IScopeUnidirectional = interface
    ['{4B7BCC08-0278-4CC4-ADF3-7376F2A0A8CC}']
    function GetIsUnidirectional: Boolean;
    property IsUnidirection: Boolean read GetIsUnidirectional;
  end;

  TPersistentPair = TPair<string, TPersistent>;

  TScopeMemberTypes = set of TScopeMemberType;
  /// <summary>Provide member names to use in generated expressions</summary>
  IScopeMemberScripting = interface
  ['{3B273E26-19DA-4591-99AF-6748B71ABD3A}']
    function GetMemberGetter(const AMemberName: string; var AGetter: string): Boolean;
    function GetMemberSetter(const AMemberName: string; var ASetter: string): Boolean;
    function GetMemberType(const AMemberName: string; var AType: TScopeMemberType): Boolean;
    function GetPositionGetter(var AGetter: string; var ABase: Integer): Boolean;
    function GetPositionSetter(var ASetter: string; var ABase: Integer): Boolean;
  end;

  TBaseBindScopeComponent = class(TComponent, IScopeComponent, IScopeExpressions, IScopeLocks)
  private
    FExpressions: TList<TBasicBindComponent>;
    FPosLock: Integer;
    FScopeMappings: TScopeMappings;
  protected
    procedure SetScopeMappings(const Value: TScopeMappings); virtual;
    function AddScopeMappings(AScope: IScope): IScope;
    function GetMember(const AMemberName: string): TObject; virtual;
    function GetValue: TObject; virtual;
    { IScopeComponent }
    function GetScope: IScope; virtual;
    function GetMemberScope(const AMemberName: string): IScope; virtual;
    function GetScopeObject: TObject;
    { IScopeLocks }
    procedure PosLockEnter;
    procedure PosLockLeave;
    function GetPosLock: Boolean;

    procedure AddExpression(AExpression: TBasicBindComponent); virtual;
    procedure RemoveExpression(AExpression: TBasicBindComponent); virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure ActivateExpressions(AValue: Boolean);
    property Expressions: TList<TBasicBindComponent> read FExpressions;
    property ScopeMappings: TScopeMappings read FScopeMappings write SetScopeMappings;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TBaseLinkingBindSource = class(TBaseBindScopeComponent)
  end;

  TBindEventList = class;

  TCustomBindScope = class(TBaseBindScopeComponent, IScopeActive,
    IScopeRecordEnumerable)
  private
    FComponent: TComponent;
    FActive: Boolean;
    FAutoActivate: Boolean;
    FDeferActive: Boolean;
    FDataObject: TObject;
    procedure SetComponent(const Value: TComponent);
    procedure SetDataObject(const Value: TObject);
    procedure SetAutoActivate(const Value: Boolean);
    function CanActivate: Boolean;
    procedure UpdateDataChanged;
    procedure UpdateDataChanging;
  protected
    function GetValue: TObject; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    function GetActive: Boolean;
    procedure SetActive(Value: Boolean);
    procedure Loaded; override;
    { IScopeRecordEnumerable }
    function GetEnumerator(const AMemberName: string; ABufferCount: Integer): IScopeRecordEnumerator;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Active: Boolean read GetActive write SetActive;
    property Component: TComponent read FComponent write SetComponent;
    property DataObject: TObject read FDataObject write SetDataObject;
    [Default(True)]
    property AutoActivate: Boolean read FAutoActivate write SetAutoActivate default True;
  end;

  // Component Owner defines a object scope
  TBindScope = class(TCustomBindScope)
  published
    property Component;
    property AutoActivate;
    property ScopeMappings;
  end;

  TBindEventListT = class
  protected
    FList: TList<TNotifyEvent>;
    procedure InternalAdd(AEvent: TNotifyEvent);
    procedure InternalRemove(AEvent: TNotifyEvent);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TBindEventList = class(TBindEventListT)
  public
    procedure Add(AEvent: TNotifyEvent);
    procedure Remove(AEvent: TNotifyEvent);
    procedure Send(Sender: TObject);
  end;

  TBindNotifyEvent1<T> = procedure(Sender: TObject; P: T) of object;

  TBindEventList1<T> = class(TBindEventListT)
  public
    procedure Add(AEvent: TBindNotifyEvent1<T>);
    procedure Remove(AEvent: TBindNotifyEvent1<T>);
    procedure Send(Sender: TObject; const P: T);
  end;


  TEnumBindCompProcInfo = Pointer;

  TEnumBindCompProc = procedure (const Category: string; BindCompClass: TContainedBindCompClass;
    Info: TEnumBindCompProcInfo) of object;


  // Design time support for components in the context of another component.
  // For example, create a Data Binding for a TEdit
  IBindCompFactoryContext = interface
    ['{E0FB570F-2EF0-44C7-BD19-F4F8ACAE2294}']
    function GetDesigner: IInterface;
    function GetControlComponent: TComponent;
    function GetOwner: TComponent;
    function GetBindingsList: TCustomBindingsList;
    property BindingsList: TCustomBindingsList read GetBindingsList;
    property Owner: TComponent read GetOwner;
    property ControlComponent: TComponent read GetControlComponent;
    property Designer: IInterface read GetDesigner;
  end;

  IBindCompFactoryExecuteContext = interface(IBindCompFactoryContext)
    ['{E0FB570F-2EF0-44C7-BD19-F4F8ACAE2294}']
    function UniqueName(const ABaseName: string): string;
    procedure BindCompCreated(AComponent: TComponent);
  end;

  IBindCompFactory = interface
    ['{C9E39805-4ED9-4C60-B903-4D3F9E8F0671}']
    function Enabled(AContext: IBindCompFactoryContext): Boolean;
    function GetCommandText(AContext: IBindCompFactoryContext): string;
    procedure Execute(AContext: IBindCompFactoryExecuteContext);
  end;

  TBindCompDesignerCollectionType = (colExpressions, colCollections);
  TBindCompDesignerExpressionType = (exprControlToSource, exprSourceToControl, exprBidirectional);
  TBindCompDesignerExpressionTypes = set of TBindCompDesignerExpressionType;

  TBindCompDesignExpressionCollection = record
  private
    FName: string;
    FCollection: TCollection;
    FParentCollectionItem: TCollectionItem;
    FCollectionType: TBindCompDesignerCollectionType;
  public
    constructor Create(const AName: string; ACollection: TCollection;
      AParentCollectionItem: TCollectionItem = nil;
      ACollectionType: TBindCompDesignerCollectionType = colExpressions);
    property Name: string read FName;
    property Collection: TCollection read FCollection;
    property ParentCollectionItem: TCollectionItem read FParentCollectionItem;
    property CollectionType: TBindCompDesignerCollectionType read FCollectionType;
  end;

  TBindCompDesignExpression = record
  type
    TExecuteDesignExpression = reference to procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>);
    TExecuteDesignExpression2 = reference to procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>);
    TSaveDesignExpression = reference to procedure(const AName: string; const AExpression: string);
  private
    FName: string;
    FControlScope: string;
    FControlExpression: string;
    FSourceScope: string;
    FSourceExpression: string;
    FExecuteControlProc: TExecuteDesignExpression;
    FExecuteSourceProc: TExecuteDesignExpression;
    FExecuteAssignToSourceProc: TExecuteDesignExpression2;
    FExecuteAssignToControlProc: TExecuteDesignExpression2;
    FSaveControlProc: TSaveDesignExpression;
    FSaveSourceProc: TSaveDesignExpression;
    FCollectionItem: TCollectionItem;
    FCollectionName: string;
    FParentCollectionItem: TCollectionItem;
    FExpressionType: TBindCompDesignerExpressionType;
  public
    constructor Create(const AName, AControlScope, AControlExpression: string;
      const ASourceScope, ASourceExpression: string;
      AExecuteAssignToControl, AExecuteAssignToSource: TExecuteDesignExpression2; AExecuteControl, AExecuteSource: TExecuteDesignExpression;
      ASaveControl, ASaveSource: TSaveDesignExpression; ACollectionItem: TCollectionItem;
      const ACollectionName: string;
      AParentCollectionItem: TCollectionItem;
      AExpressionType: TBindCompDesignerExpressionType);
    property Name: string read FName;
    property ControlScope: string read FControlScope;
    property ControlExpression: string read FControlExpression;
    property SourceScope: string read FSourceScope;
    property SourceExpression: string read FSourceExpression;
    property ExecuteAssignToControlProc: TExecuteDesignExpression2 read FExecuteAssignToControlProc;
    property ExecuteAssignToSourceProc: TExecuteDesignExpression2 read FExecuteAssignToSourceProc;
    property ExecuteSourceProc: TExecuteDesignExpression read FExecuteSourceProc;
    property ExecuteControlProc: TExecuteDesignExpression read FExecuteControlProc;
    property SaveSourceProc: TSaveDesignExpression read FSaveSourceProc;
    property SaveControlProc: TSaveDesignExpression read FSaveControlProc;
    property CollectionItem: TCollectionItem read FCollectionItem;
    property CollectionName: string read FCollectionName;
    property ParentCollectionItem: TCollectionItem read FParentCollectionItem;
    property ExpressionType: TBindCompDesignerExpressionType read FExpressionType;
  end;

  TBindCompDesignerBindsType = (biBindsComponent, biBindsComponentProperty, biBindsOther);
  TBindCompDesignerBindsTypes = set of TBindCompDesignerBindsType;
  IBindCompDesigner = interface
    ['{45B5E422-5908-4C9E-8073-361A7954F209}']
    function CanBindComponent(ADataBindingClass: TContainedBindCompClass; AComponent: TComponent;
    ADesigner: IInterface): Boolean;
    function BindsComponent(ABindComp: TContainedBindComponent; AComponent: TComponent): Boolean;
    function BindsComponentPropertyName(ABindComp: TContainedBindComponent; const APropertyName: string): Boolean;
    function GetDescription(ABindComp: TContainedBindComponent): string;
    function IsReadOnly(ABindComp: TContainedBindComponent; AExpression: TBindCompDesignExpression): Boolean; overload;
    function IsReadOnly(ABindComp: TContainedBindComponent; AItem: TCollectionItem): Boolean; overload;
    function IsReadOnly(ABindComp: TContainedBindComponent; ACollection: TCollection): Boolean; overload;
    function GetExpressions(ABindComp: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
    function GetExpressionCollections(ABindComp: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
  end;

  TEnumBindCompFactoryProc = procedure (BindCompFactory: IBindCompFactory; Info: TEnumBindCompProcInfo) of object;

  TBoundComponentOption = (dbcoptAddDataBindingsProperty, dbcoptApplyToDescendents);
  TBoundComponentOptions = set of TBoundComponentOption;

  TBindEditorFactory = class
  public
    constructor Create; virtual;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; virtual; abstract;
    function GetNames: TArray<string>; virtual;
    function HasNamedEditor(const AName: string): Boolean; virtual;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; virtual; abstract;
    function CreateNamedEditor(AIntf: TGuid; const AName: string;
      AObject: TObject): IInterface; virtual;
    function ReleaseEditor(const AEditor: IInterface): Boolean; virtual;
  end;

  EBindCompError = class(Exception);
  TBindCompException = EBindCompError;  // Alias for backward compatability


  TBindEditorFactoryClass = class of TBindEditorFactory;

  TControlObserver = class
  strict private
    FComponent: TComponent;
    FDictionary: TDictionary<Integer, IObserver>;
    function AddObserver(const ID: Integer;
      AFunc: TFunc<IObserver>): Boolean;
    procedure RemoveObserver(const ID: Integer);
    procedure SetComponent(const Value: TComponent);
    procedure RemoveObservers;
  public
    const
      IDEditLinkObserver = Integer(TObserverMapping.EditLinkID);
      IDEditGridLinkObserver = Integer(TObserverMapping.EditGridLinkID);
      IDPositionLinkObserver = Integer(TObserverMapping.PositionLinkID);
      IDControlValueObserver = Integer(TObserverMapping.ControlValueID);
  private
    function GetEditGridLink: IEditGridLinkObserver;
    function GetPositionLinkObserver: IPositionLinkObserver;
    function GetControlValueObserver: IControlValueObserver;
    function GetEditLink: IEditLinkObserver;
  public
    constructor Create;
    function EnsureObserving(const ID: Integer; AFunc: TFunc<IObserver>): Boolean;
    function IsObserving(const ID: Integer): Boolean;
    function GetObserver(const ID: Integer): IObserver;
    function TrySetActive(AValue: Boolean): Boolean;
    destructor Destroy; override;
    procedure Clear;
    property Component: TComponent read FComponent write SetComponent;
    property EditGridLinkObserver: IEditGridLinkObserver read GetEditGridLink;
    property PositionLinkObserver: IPositionLinkObserver read GetPositionLinkObserver;
    property EditLinkObserver: IEditLinkObserver read GetEditLink;
    property ControlValueObserver: IControlValueObserver read GetControlValueObserver;
  end;

  TObservableMemberOption = (moTrack);
  TObservableMemberOptions = set of TObservableMemberOption;

  /// <summary>Base class for evaluator shortcuts, that assign a value from data source to an editor</summary>
  TEvalShortcutEnumeratorToEditor = class abstract
  protected
    /// <summary>Evaluate expression to assign a value from a data source to an editor</summary>
    procedure Evaluate(const AExpression: TEvalEnumeratorToEditor); virtual; abstract;
  end;

  /// <summary>Base class for evaluator shortcuts that retrieve a value from a data source</summary>
  TEvalShortcutEnumerator = class abstract
  protected
    /// <summary>Evaluate an expression to retrieve a value from a data source</summary>
    function Evaluate(const AExpression: TEvalEnumerator; const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean; virtual; abstract;
  end;

  /// <summary>Base class for a factory of shortcut evaluators</summary>
  TEvalShortcutFactory = class abstract
  public
    /// <summary>Provide an evaluator for assigning from data source to editor</summary>
    function Supports(const AExpression: TEvalEnumeratorToEditor; out AEvalShortcut: TEvalShortcutEnumeratorToEditor): Boolean; overload; virtual; abstract;
    /// <summary>Indicate whether this factory can provide an evaluator for assigning from data source to editor</summary>
    function Supports(const AExpression: TEvalEnumeratorToEditor): Boolean; overload;
    /// <summary>Provide an evaluator for retrieving a value from a data source</summary>
    function Supports(const AExpression: TEvalEnumerator; out AEvalShortcut: TEvalShortcutEnumerator): Boolean; overload; virtual; abstract;
    /// <summary>Indicate whether this factory can provide an evaluator for retrieving a value from  a data source to editor</summary>
    function Supports(const AExpression: TEvalEnumerator): Boolean; overload;
  end;

  /// <summary>Singleton class for registering factories of shortcut evaluators, and instantiating shortcut evaluators</summary>
  TEvalShortcutFactories = class
  private
    class var FInstance: TEvalShortcutFactories;
    var FList: TList<TEvalShortcutFactory>;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>Provide an evaluator for assigning from data source to editor</summary>
    function Supports(const AExpression: TEvalEnumeratorToEditor; out AEvalShortcut: TEvalShortcutEnumeratorToEditor): Boolean; overload;
    /// <summary>Indicate whether a factory can provide an evaluator for assigning from data source to editor</summary>
    function Supports(const AExpression: TEvalEnumeratorToEditor): Boolean; overload;
    /// <summary>Provide an evaluator for retrieving a value from a data source</summary>
    function Supports(const AExpression: TEvalEnumerator; out AEvalShortcut: TEvalShortcutEnumerator): Boolean; overload;
    /// <summary>Indicate whether a factory can provide an evaluator for assigning from  a data source to editor</summary>
    function Supports(const AExpression: TEvalEnumerator): Boolean; overload;
    /// <summary>Register an evaluator shortcut factory</summary>
    procedure Register(const AFactory: TEvalShortcutFactory);
    /// <summary>Unregister an evaluator shortcut factory</summary>
    procedure Unregister(var AFactory: TEvalShortcutFactory);
    /// <summary>Singleton instance property.  Use this property to access instance methods.</summary>
    class property Instance: TEvalShortcutFactories read FInstance;
  end;


// Design time support
procedure RegisterBindComponents(const CategoryName: string;
  const AClasses: array of TContainedBindCompClass);
procedure UnRegisterBindComponents(const AClasses: array of TContainedBindCompClass);
function CreateBindComponent(AOwner: TComponent; ABindCompClass: TContainedBindCompClass): TContainedBindComponent;
procedure EnumRegisteredBindComponents(Proc: TEnumBindCompProc; Info: TEnumBindCompProcInfo);
procedure RegisterBindCompFactory(AFactory: IBindCompFactory);
procedure EnumRegisteredBindCompFactories(Proc: TEnumBindCompFactoryProc; Info: TEnumBindCompProcInfo);
procedure RegisterBindCompDesigner(AClass: TContainedBindCompClass; ADesigner: IBindCompDesigner);
function GetBindCompDesigner(AClass: TContainedBindCompClass): IBindCompDesigner;
procedure RegisterBoundComponents(const AClasses: array of TComponentClass; AFlags: TBoundComponentOptions);
function GetBoundComponentOptions(const AClass: TComponentClass): TBoundComponentOptions;


procedure RegisterBindEditorFactory(AFactories: array of TBindEditorFactoryClass);
procedure UnregisterBindEditorFactory(AFactories: array of TBindEditorFactoryClass);

/// <summary>Register the member which is the value of an observable control</summary>
/// <remarks>Text is the value property of TEdit</remarks>
procedure RegisterObservableMember(AClasses: TArray<TClass>; const APropertyName: string; const AFrameworkExt: string); overload;
procedure UnRegisterObservableMember(AClasses: TArray<TClass>);  overload

/// <summary>Register the property which is the value of an non-observable component</summary>
/// <remarks>Caption is the value property of TGroupBox</remarks>
procedure RegisterValuePropertyName(AClasses: TArray<TClass>; const APropertyName: string; const AFrameWorkExt: string); overload;
procedure UnRegisterValuePropertyName(AClasses: TArray<TClass>); overload;

/// <summary>Register options for  observable components</summary>
procedure RegisterObservableMemberOptions(AClasses: TArray<TClass>; AOptions: TObservableMemberOptions); overload;
procedure UnRegisterObservableMemberOptions(AClasses: TArray<TClass>);

/// <summary>Register the expression which is the value of list control item</summary>
/// <remarks>Selected(Text) is the value property of TEdit</remarks>
procedure RegisterListItemValueExpression(AClasses: TArray<TClass>; const AExpression: string; const AHeaderExpression: string = ''); overload;
procedure UnregisterListItemValueExpression(AClasses: TArray<TClass>); overload;

/// <summary>Get the property that is used to set and get the value of a control</summary>
/// <remarks>For example, the Text property is used to get and set the value of TEdit</remarks>
function GetControlValuePropertyName(AComponent: TComponent; out APropertyName: string): Boolean; overload;
function GetControlValuePropertyName(AComponent: TComponent; out APropertyName: string; out AWritable: Boolean): Boolean; overload;
function GetControlValuePropertyOptions(AComponent: TComponent; out AOptions: TObservableMemberOptions): Boolean; overload;
function GetControlValueClasses(const AFrameworkExt: string; FWritableOnly: Boolean): TArray<TComponentClass>;
/// <summary>Get the expresss that is used to set and get the value list item</summary>
/// <remarks>For example, "Text" is used to set the value of a listbox item</remarks>
function GetListItemValueExpression(AComponent: TComponent; out AExpression: string): Boolean; overload;
function GetListItemValueExpression(AComponent: TComponent; out AExpression: string; out AHeaderExpression: string): Boolean; overload;

function IsUnidirectionalDataSource(ADataSource: TComponent): Boolean; forward;
procedure CheckUnidirectionalDataSource(ADataSource: TComponent; ABindComponent: TContainedBindComponent); forward;

function GetScopeRecordEnumerator(const ASourceComponent: TComponent; ABuffered: Boolean): IScopeRecordEnumerator; overload;

const
  RegisterBindCompProc: procedure (const CategoryName: string;
    const AClasses: array of TContainedBindCompClass) = nil;
  UnRegisterBindCompProc: procedure (const AClasses: array of TContainedBindCompClass) = nil;
  EnumRegisteredBindCompsProc: procedure (Proc: TEnumBindCompProc; Info: Pointer) = nil;
  CreateBindCompProc: function (AOwner: TComponent; BindCompClass: TContainedBindCompClass): TContainedBindComponent = nil;
  RegisterBindCompFactoryProc: procedure(AFactory: IBindCompFactory) = nil;
  EnumRegisteredBindCompFactoriesProc: procedure(Proc: TEnumBindCompFactoryProc; Info: Pointer) = nil;
  RegisterBindCompDesignerProc: procedure (AClass: TContainedBindCompClass; ADesigner: IBindCompDesigner) = nil;
  GetBindCompDesignerProc: function (AClass: TContainedBindCompClass): IBindCompDesigner = nil;
  RegisterBoundComponentsProc: procedure (const AClasses: array of TComponentClass; AFlags: TBoundComponentOptions) = nil;
  GetBoundComponentOptionsProc: function (AClass: TComponentClass): TBoundComponentOptions = nil;
  function GetBindEditor(AComponent: TObject; AGuid: TGuid; const AName: string = ''): IInterface;
  procedure ReleaseBindEditor(const AEditor: IInterface);
  function GetBindEditorNames(AComponent: TObject; AGuid: TGuid): TArray<string>;

implementation

uses
  Data.Bind.Consts, Data.Bind.ObserverLinks, System.Bindings.NotifierContracts,
  System.Bindings.Methods, System.Bindings.CustomScope, System.StrUtils,
  System.Bindings.Helper, System.Bindings.ObjEval, System.TypInfo,
  System.Bindings.CustomWrapper, System.Bindings.Factories, System.Math,
  System.Bindings.EvalSys, System.Variants, Data.Bind.Editors;

type
  /// <summary>TCustomLinkControlToField proxy binding based on direction of data flow</summary>
  ///  <remarks>If the direction is controltodata then the link will be multicast, otherwise singlecast editing link will be established</remarks>
  TInternalLinkControlToFieldBinding = class(TExpressionsBindComponent, IBindTrack)
  strict private
    FAutoActivate: Boolean;
    FTrack: Boolean;
    FMember: string;
    FSource, FControl: TComponent;
    FBindLink: TCustomBindLink;
    FBindControlValue: TCustomBindControlValue;
  private
    [weak] FLinkComponent: TCustomLinkControlToField;
    function GetClearExpressions: TExpressions; override;
    function GetFormatExpressions: TExpressions; override;
    function GetParseExpressions: TExpressions; override;
    procedure SetClearExpressions(const Value: TExpressions); override;
    procedure SetFormatExpressions(const Value: TExpressions); override;
    procedure SetParseExpressions(const Value: TExpressions); override;
    function GetTrack: Boolean;
    procedure SetTrack(const Value: Boolean);
    function GetBindComponent: TExpressionsBindComponent;
    procedure CheckInternalBindComponents;
  protected
    procedure Loaded; override;
    function GetActive: Boolean; override;
    procedure SetActive(AValue: Boolean); override;
    procedure SetControlComponent(const Value: TComponent); override;
    function GetControlComponent: TComponent; override;
    function GetSourceComponent: TComponent; override;
    procedure SetSourceComponent(const Value: TComponent); override;
    procedure SetSourceMemberName(const Value: string); override;
    function GetSourceMemberName: string; override;
    procedure SetAutoActivate(AValue: Boolean); override;
    function GetAutoActivate: Boolean; override;
    procedure AssignTo(APersistent: TPersistent); override;
    procedure SetOnActivated(const Value: TNotifyEvent); override;
    procedure SetOnActivating(const Value: TNotifyEvent); override;
    procedure SetOnAssignedValue(const Value: TBindCompAssignedValueEvent); override;
    procedure SetOnAssigningValue(const Value: TBindCompAssigningValueEvent); override;
    procedure SetOnEvalError(const Value: TBindCompEvalErrorEvent); override;
    procedure SetOnLocationUpdated(const Value: TBindingLocationUpdatedEvent); override;
  public
    constructor Create(ALinkControlToField: TCustomLinkControlToField); reintroduce;
    destructor Destroy; override;
    property Active: Boolean read GetActive write SetActive;
    property Track: Boolean read GetTrack write SetTrack;
    property BindComponent: TExpressionsBindComponent read GetBindComponent;
  end;

  TValuePropertyOption = (vpObservable, vpTrack);
  TValuePropertyOptions = set of TValuePropertyOption;

  TBindComponentScope = class(TCustomScope)
  protected
    function DoLookup(const Name: String): IInterface; override;
  end;

  TBindScopeComponentScope = class(TBindComponentScope)
  protected
    function DoLookup(const Name: String): IInterface; override;
  end;

  TValuePropertyNameRec = record
    FPropertyName: string;
    FFrameworkExt: string;
    FOptions: TValuePropertyOptions;
    constructor Create(const APropertyName, AFrameworkExt: string; AOptions: TValuePropertyOptions);
  end;

  TListItemExpressionRec = record
    FExpression: string;
    FHeaderExpression: string;
    constructor Create(const AExpression, AHeaderExpression: string);
  end;

  TQuickBindProcDependency = class(TDependency)
  private
    FBinding: TExpressionsBindComponent;
    FNotifyProc: TProc<TExpressionsBindComponent>;
  public
    constructor Create(ABinding: TExpressionsBindComponent; ANotifyProc: TProc<TExpressionsBindComponent>;
      AComponent: TComponent; const AMember, AExpr: string);
    procedure NotifyDependent; override;
  end;

var
  FEditorFactories: TList<TBindEditorFactoryClass>;
  FValuePropertyNames: TDictionary<TClass, TValuePropertyNameRec>;
  FListItemValueExpressions: TDictionary<TClass, TListItemExpressionRec>;

constructor TValuePropertyNameRec.Create(const APropertyName: string; const AFrameworkExt: string; AOptions: TValuePropertyOptions);
begin
  FPropertyName := APropertyName;
  FFrameWorkExt := AFrameworkExt;
  FOptions := AOptions;
end;


constructor TListItemExpressionRec.Create(const AExpression, AHeaderExpression: string);
begin
  FExpression := AExpression;
  FHeaderExpression := AHeaderExpression;
end;

function GetScopeRecordEnumerator(const ASourceComponent: TComponent; const AMemberName: string; ABuffered: Boolean): IScopeRecordEnumerator; overload;
var
  LIntf2: IScopeRecordEnumerableBuffered;
  LIntf: IScopeRecordEnumerable;
begin
  if Supports(ASourceComponent, IScopeRecordEnumerableBuffered, LIntf2) then
    Result := LIntf2.GetEnumerator(AMemberName, ABuffered)
  else if Supports(ASourceComponent, IScopeRecordEnumerable, LIntf) then
    Result := LIntf.GetEnumerator(AMemberName, -1)
  else
    Result :=nil;
end;

function GetScopeRecordEnumerator(const ASourceComponent: TComponent; ABuffered: Boolean): IScopeRecordEnumerator; overload;
begin
  Result := GetScopeRecordEnumerator(ASourceComponent, '', ABuffered);
end;

function SafeClassName(AObject: TObject): string;
begin
  if AObject = nil then
    Result := 'nil' // Do not localize
  else
    Result := AObject.ClassName;
end;

function GetListItemValueExpression(AComponent: TComponent; out AExpression: string;
  out AHeaderExpression: string): Boolean;
var
  LListItemExpressionRec: TListItemExpressionRec;
  LClass: TClass;
  LClassKey: TClass;
begin
  Result := False;
  LClassKey := nil;
  if FListItemValueExpressions.TryGetValue(AComponent.ClassType, LListItemExpressionRec) then
    LClassKey := AComponent.ClassType;
  for LClass in  FListItemValueExpressions.Keys do
    if AComponent.ClassType.InheritsFrom(LClass) then
    begin
      LClassKey := LClass;
      break;
    end;
  if LClassKey <> nil then
  begin
    LListItemExpressionRec := FListItemValueExpressions[LClassKey];
    AExpression := LListItemExpressionRec.FExpression;
    AHeaderExpression := LListItemExpressionRec.FHeaderExpression;
    Exit(True);
  end;
end;

function GetListItemValueExpression(AComponent: TComponent; out AExpression: string): Boolean;
var
  LHeader: string;
begin
  Result := GetListItemValueExpression(AComponent, AExpression, LHeader);
end;

function GetObservableMemberAttribute(AClass: TClass): ObservableMemberAttribute;
var
  LCtxt: TRttiContext;
  LType: TRttiType;
  LAttributes: TArray<TCustomAttribute>;
  LAttribute: TCustomAttribute;
begin
  Result := nil;
  LType := LCtxt.GetType(AClass);
  if LType <> nil then
  begin
    LAttributes := LType.GetAttributes;
    for LAttribute in LAttributes do
    begin
      if LAttribute is ObservableMemberAttribute then
        Exit(ObservableMemberAttribute(LAttribute));
    end;
  end;

end;

function GetControlValuePropertyName(AComponent: TComponent; out APropertyName: string; out AOptions: TValuePropertyOptions): Boolean; overload;
var
  LValuePropertyNameRec: TValuePropertyNameRec;
  LClass: TClass;
  LClassKey: TClass;
  LObservableMemberAttribute: ObservableMemberAttribute;
begin
  Result := False;
  LClassKey := nil;
  if FValuePropertyNames.TryGetValue(AComponent.ClassType, LValuePropertyNameRec) then
    // Exact match
    LClassKey := AComponent.ClassType;
  if LClassKey = nil then
    for LClass in  FValuePropertyNames.Keys do
      if AComponent.ClassType.InheritsFrom(LClass) then
      begin
        LClassKey := LClass;
        break;
      end;
  if LClassKey <> nil then
  begin
    LValuePropertyNameRec := FValuePropertyNames[LClassKey];
    APropertyName := LValuePropertyNameRec.FPropertyName;
    AOptions := LValuePropertyNameRec.FOptions;
    Exit(True);
  end;

  LObservableMemberAttribute := GetObservableMemberAttribute(AComponent.ClassType);
  if Assigned(LObservableMemberAttribute) then
  begin
    APropertyName := LObservableMemberAttribute.MemberName;
    AOptions := [TValuePropertyOption.vpObservable];
    Exit(True);
  end;


end;

function GetControlValuePropertyName(AComponent: TComponent; out APropertyName: string; out AWritable: Boolean): Boolean;
var
  LOptions: TValuePropertyOptions;
begin
  Result := GetControlValuePropertyName(AComponent, APropertyName, LOptions);
  if Result then
    AWritable := vpObservable in LOptions
  else
    AWritable := False;



end;

function GetControlValuePropertyOptions(AComponent: TComponent; out AOptions: TObservableMemberOptions): Boolean; overload;
var
  LOptions: TValuePropertyOptions;
  LPropertyName: string;
begin
  AOptions := [];
  Result := GetControlValuePropertyName(AComponent, LPropertyName, LOptions);
  if Result then
    if vpTrack in LOptions then
      Include(AOptions, TObservableMemberOption.moTrack);
end;

function GetControlValueClasses(const AFrameworkExt: string; FWritableOnly: Boolean): TArray<TComponentClass>;
var
  LList: TList<TComponentClass>;
  LPair: TPair<TClass, TValuePropertyNameRec>;
begin
  LList := TList<TComponentClass>.Create;
  try
    for LPair in FValuePropertyNames do
    begin
      if (not FWritableOnly) or (vpObservable in LPair.Value.FOptions) then
        if (AFrameworkExt = '') or SameText(AFrameworkExt, LPair.Value.FFrameworkExt) then
          LList.Add(TComponentClass(LPair.Key));
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function GetControlValuePropertyName(AComponent: TComponent; out APropertyName: string): Boolean;
var
  LOptions: TValuePropertyOptions;
begin
  Result := GetControlValuePropertyName(AComponent, APropertyName, LOptions);

end;

const
  sWildcard = '*';

function GetFieldValueMemberNames(AComponent: TComponent; const AFieldName: string; out AMemberGetter: string;
  out AMemberSetter: string): Boolean;
var
  LScopeMemberScripting: IScopeMemberScripting;
begin
  Result := False;
  Assert((AFieldName <> '') and (AFieldName <> sWildCard));
  AMemberGetter := '';
  AMemberSetter := '';
  if Supports(AComponent, IScopeMemberScripting, LScopeMemberScripting) then
  begin
    LScopeMemberScripting.GetMemberGetter(AFieldName, AMemberGetter);
    LScopeMemberScripting.GetMemberSetter(AFieldName, AMemberSetter);
    Result := True;
  end;
end;

function GetBindEditor(AComponent: TObject; AGuid: TGuid; const AName: string): IInterface;
var
  LClass: TBindEditorFactoryClass;
  LFactory: TBindEditorFactory;
begin
  for LClass in FEditorFactories do
  begin
    LFactory := LClass.Create;
    try
      if LFactory.Supports(AGuid, AComponent) then
      begin
        if LFactory.HasNamedEditor(AName) then
        begin
          Result := LFactory.CreateNamedEditor(AGuid, AName, AComponent);
          Exit;
        end;
      end;
    finally
      LFactory.Free;
    end;
  end;
  Result := nil;
end;

procedure ReleaseBindEditor(const AEditor: IInterface);
var
  LClass: TBindEditorFactoryClass;
  LFactory: TBindEditorFactory;
begin
  for LClass in FEditorFactories do
  begin
    LFactory := LClass.Create;
    try
      if LFactory.ReleaseEditor(AEditor) then
        break;
    finally
      LFactory.Free;
    end;
  end;
end;

function GetBindEditorNames(AComponent: TObject; AGuid: TGuid): TArray<string>;
var
  LClass: TBindEditorFactoryClass;
  LFactory: TBindEditorFactory;
  LList: TList<string>;
begin
  LList := TList<string>.Create;
  try
    for LClass in FEditorFactories do
    begin
      LFactory := LClass.Create;
      try
        if LFactory.Supports(AGuid, AComponent) then
          LList.AddRange(LFactory.GetNames);
      finally
        LFactory.Free;
      end;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

procedure RegisterBindComponents(const CategoryName: string;
  const AClasses: array of TContainedBindCompClass);
begin
  if Assigned(RegisterBindCompProc) then
    RegisterBindCompProc(CategoryName, AClasses) else
    raise TBindCompException.CreateRes(@SInvalidBindCompRegistration);
end;

procedure UnRegisterBindComponents(const AClasses: array of TContainedBindCompClass);
begin
  if Assigned(UnRegisterBindCompProc) then
    UnRegisterBindCompProc(AClasses) else
    raise TBindCompException.CreateRes(@SInvalidBindCompUnregistration);
end;

procedure EnumRegisteredBindComponents(Proc: TEnumBindCompProc; Info: TEnumBindCompProcInfo);
begin
  if Assigned(EnumRegisteredBindCompsProc) then
    EnumRegisteredBindCompsProc(Proc, Info) else
    raise TBindCompException.CreateRes(@SInvalidBindCompEnumeration);
end;

function CreateBindComponent(AOwner: TComponent; ABindCompClass: TContainedBindCompClass): TContainedBindComponent;
begin
  if Assigned(CreateBindCompProc) then
    Result := CreateBindCompProc(AOwner, ABindCompClass) else
    raise TBindCompException.CreateRes(@SInvalidBindCompCreation);
end;

procedure RegisterBindCompFactory(AFactory: IBindCompFactory);
begin
  if Assigned(RegisterBindCompFactoryProc) then
    RegisterBindCompFactoryProc(AFactory) else
    raise TBindCompException.CreateRes(@SInvalidBindCompFactory);
end;

procedure EnumRegisteredBindCompFactories(Proc: TEnumBindCompFactoryProc; Info: TEnumBindCompProcInfo);
begin
  if Assigned(EnumRegisteredBindCompFactoriesProc) then
    EnumRegisteredBindCompFactoriesProc(Proc, Info) else
    raise TBindCompException.CreateRes(@SInvalidBindCompFactoryEnumeration);
end;

procedure RegisterBindCompDesigner(AClass: TContainedBindCompClass; ADesigner: IBindCompDesigner);
begin
  if Assigned(RegisterBindCompDesignerProc) then
    RegisterBindCompDesignerProc(AClass, ADesigner) else
    raise TBindCompException.CreateRes(@SInvalidBindCompDesigner);
end;

function GetBindCompDesigner(AClass: TContainedBindCompClass): IBindCompDesigner;
begin
  if Assigned(GetBindCompDesignerProc) then
    Result := GetBindCompDesignerProc(AClass) else
    raise TBindCompException.CreateRes(@SInvalidBindCompDesigner);
end;

procedure RegisterBoundComponents(const AClasses: array of TComponentClass; AFlags: TBoundComponentOptions);
begin
  if Assigned(RegisterBoundComponentsProc) then
    RegisterBoundComponentsProc(AClasses, AFlags) else
    raise TBindCompException.CreateRes(@SInvalidBindCompComponents);
end;

function GetBoundComponentOptions(const AClass: TComponentClass): TBoundComponentOptions;
begin
  if Assigned(GetBoundComponentOptionsProc) then
    Result := GetBoundComponentOptionsProc(AClass) else
    raise TBindCompException.CreateRes(@SInvalidBindCompComponents);
end;

{ TContainedBindComponent }

constructor TContainedBindComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

end;

function TContainedBindComponent.Designing: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

destructor TContainedBindComponent.Destroy;
begin

  inherited;
end;

function TContainedBindComponent.GetDisplayName: string;
begin
  Result := Self.Name;
end;

function TContainedBindComponent.GetBindingsList: TCustomBindingsList;
begin
  Result := FBindingsList;
end;

function TContainedBindComponent.GetIndex: Integer;
begin
  if BindingsList <> nil then
    Result := BindingsList.FBindComps.IndexOf(Self) else
    Result := -1;
end;

function TContainedBindComponent.GetParentComponent: TComponent;
begin
  if BindingsList <> nil then
    Result := BindingsList else
    Result := inherited GetParentComponent;
end;

function TContainedBindComponent.HasParent: Boolean;
begin
  if BindingsList <> nil then
    Result := True else
    Result := inherited HasParent;
end;

function TContainedBindComponent.Loading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

procedure TContainedBindComponent.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TCustomBindingsList then
    BindingsList := TCustomBindingsList(Reader.Parent);
end;

function TContainedBindComponent.CanSetControlComponent(
  Value: TComponent): Boolean;
begin
  Result := True;
end;

procedure TContainedBindComponent.CheckControlComponent;
begin
  if GetControlComponent = nil then
    raise TBindCompException.CreateFmt(sNoControl, [Self.GetDisplayName]);
end;

procedure TContainedBindComponent.SetCategory(const Value: string);
begin
  FCategory := Value;
end;

procedure TContainedBindComponent.SetBindingsList(
  const Value: TCustomBindingsList);
begin
  if Value <> BindingsList then
  begin
    if BindingsList <> nil then BindingsList.RemoveBindComp(Self);
    if Value <> nil then Value.AddBindComp(Self);
  end;
end;

procedure TContainedBindComponent.SetIndex(Value: Integer);
var
  CurIndex, Count: Integer;
begin
  CurIndex := GetIndex;
  if CurIndex >= 0 then
  begin
    Count := FBindingsList.FBindComps.Count;
    if Value < 0 then Value := 0;
    if Value >= Count then Value := Count - 1;
    if Value <> CurIndex then
    begin
      FBindingsList.FBindComps.Extract(Self);
      FBindingsList.FBindComps.Insert(Value, Self);
    end;
  end;
end;

procedure TContainedBindComponent.SetParentComponent(AParent: TComponent);
begin
  if not Loading and (AParent is TCustomBindingsList) then
    BindingsList := TCustomBindingsList(AParent);
end;

{ TBindCompListEnumerator }

constructor TBindingsListEnumerator.Create(ABindCompList: TCustomBindingsList);
begin
  inherited Create;
  FIndex := -1;
  FBindCompList := ABindCompList;
end;

function TBindingsListEnumerator.GetCurrent: TContainedBindComponent;
begin
  Result := FBindCompList[FIndex];
end;

function TBindingsListEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FBindCompList.BindCompCount - 1;
  if Result then
    Inc(FIndex);
end;

{ TCustomBindCompList }

constructor TCustomBindingsList.Create(AOwner: TComponent);
begin
  inherited;
  FDependencyList := TDependencyList.Create(Self);
  FBindComps := TObjectList<TContainedBindComponent>.Create(True); // Owns
  FMethods := TMethods.Create(Self);
  FOutputConverters := TOutputConverters.Create(Self);
  FUseAppManager := True;
  FBindingsManager := nil;
  FPromptDeleteUnused := True;
end;

destructor TCustomBindingsList.Destroy;
begin
  FDependencyList := nil;
  FBindComps.Free;
  FBindComps := nil;
  FMethods.Free;
  FOutputConverters.Free;
  inherited;
end;

function TCustomBindingsList.GetBindComp(
  Index: Integer): TContainedBindComponent;
begin
  Result := FBindComps[Index];

end;

function TCustomBindingsList.GetBindCompCount: Integer;
begin
  Result := FBindComps.Count;
end;

function TCustomBindingsList.GetEnumerator: TBindingsListEnumerator;
begin
  Result := TBindingsListEnumerator.Create(Self);
end;

function TCustomBindingsList.GetUseAppManager: Boolean;
begin
  Result := FUseAppManager;
end;

procedure TCustomBindingsList.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  LBindComp: TContainedBindComponent;
begin
  for LBindComp in FBindComps do
  begin
    if LBindComp.Owner = Root then Proc(LBindComp);
  end;
end;

procedure TCustomBindingsList.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent is TContainedBindComponent then
    begin
      if Assigned(FBindComps) and FBindComps.Contains(TContainedBindComponent(AComponent)) then
        RemoveBindComp(TContainedBindComponent(AComponent));
    end;
end;

procedure TCustomBindingsList.Notify(const AObject: TObject;
  const AProperty: string);
var
  Intf: IBindingNotifier;
begin
  Intf := TBindings.CreateNotifier(AObject, FBindingsManager);
  Intf.Notify(AProperty);
end;

function TCustomBindingsList.GetOutputConverter: IValueRefConverter;
begin
  if FOutputConverter = nil then
    FOutputConverter := TValueRefConverterFactory.GetConverter(GetOutputConverterNames);
  Result := FOutputConverter;
end;

function TCustomBindingsList.GetOutputConverterNames: TArray<string>;
var
  I: Integer;
  UseConverters: TList<string>;
  ExcludedList: TList<string>;
  ConvDesc: TConverterDescription;
begin
  UseConverters := TList<string>.Create;
  ExcludedList := TList<string>.Create;
  try
    for I := 0 to Self.OutputConverters.Count - 1 do
    begin
      if Self.OutputConverters.Items[I].State = eaInclude then
      begin
        if not UseConverters.Contains(Self.OutputConverters.Items[I].ID) then
          UseConverters.Add(Self.OutputConverters.Items[I].ID)
      end
      else
        ExcludedList.Add(Self.OutputConverters.Items[I].ID);
    end;
    //now add converters enabled by default unless explicitly excluded
    for ConvDesc in TValueRefConverterFactory.GetConverterDescriptions do
      if ConvDesc.DefaultEnabled and (not ExcludedList.Contains(ConvDesc.ID)) then
        if not UseConverters.Contains(ConvDesc.ID) then
          UseConverters.Add(ConvDesc.ID);
    Result := UseConverters.ToArray;
  finally
    ExcludedList.Free;
    UseConverters.Free;
  end;
end;

function TCustomBindingsList.GetMethodsScope: IScope;
var
  I: Integer;
  UseMethods: TList<string>;
  ExcludedList: TList<string>;
  MethodDesc: TMethodDescription;
begin
  if FMethodsScope = nil then
  begin
    UseMethods := TList<string>.Create;
    ExcludedList := TList<string>.Create;
    try
      for I := 0 to Self.Methods.Count - 1 do
      begin
        if Self.Methods.Items[I].State = eaInclude then
        begin
          if not UseMethods.Contains(Self.Methods.Items[I].ID) then
            UseMethods.Add(Self.Methods.Items[I].ID)
        end
        else
          ExcludedList.Add(Self.Methods.Items[I].ID);
      end;
      //now add methods enabled by default unless explicitly excluded
      for MethodDesc in TBindingMethodsFactory.GetRegisteredMethods do
        if MethodDesc.DefaultEnabled and (not ExcludedList.Contains(MethodDesc.ID)) then
          if not UseMethods.Contains(MethodDesc.ID) then
            UseMethods.Add(MethodDesc.ID);
      FMethodsScope := TBindingMethodsFactory.GetMethodScope(UseMethods.ToArray);
    finally
      ExcludedList.Free;
      UseMethods.Free;
    end;
  end;
  Result := FMethodsScope;
end;

procedure TCustomBindingsList.SetBindComp(Index: Integer;
  const Value: TContainedBindComponent);
begin
  FBindComps[Index].Assign(Value);
end;

procedure TCustomBindingsList.SetOutputConverters(const Value: TOutputConverters);
begin
  FOutputConverters.Assign(Value);
end;

procedure TCustomBindingsList.SetUseAppManager(Value: Boolean);
begin
  if Value then
  begin
    //Helper function will use AppManager when a nil manager is
    // passed into CreateManagedBinding
    if Assigned(FBindingsManager) then
      FBindingsManager.Free;
    FBindingsManager := nil;
    FUseAppManager := True;
  end
  else
  begin
    FUseAppManager := False;
    FBindingsManager.Free;
    FBindingsManager := TBindingManagerFactory.CreateManager(nil);
  end;
end;

procedure TCustomBindingsList.SetMethods(const Value: TMethods);
begin
  FMethods.Assign(Value);
end;

procedure TCustomBindingsList.AddBindComp(ABindComp: TContainedBindComponent);
begin
  FBindComps.Add(ABindComp);
  ABindComp.FBindingsList := Self;
  ABindComp.FreeNotification(Self);
end;

procedure TCustomBindingsList.RemoveBindComp(ABindComp: TContainedBindComponent);
begin
  if FBindComps.Contains(ABindComp)  then
  begin
    FBindComps.Extract(ABindComp);
    ABindComp.RemoveFreeNotification(Self);
    ABindComp.FBindingsList := nil;
  end;
end;

{ TCommonBindComponent }


constructor TCommonBindComponent.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TCommonBindComponent.Destroy;
begin
  inherited;
end;


procedure TCommonBindComponent.DoOnActivated;
begin
  if Assigned(FOnActivated) then
    FOnActivated(Self);

end;

procedure TCommonBindComponent.DoOnActivating;
begin
  if Assigned(FOnActivating) then
    FOnActivating(Self);
end;

procedure TCommonBindComponent.DoOnAssigningValue(AssignValueRec: TBindingAssignValueRec; var Value: TValue; var Handled: Boolean);
begin
  if Assigned(FOnAssigningValue) then
    FOnAssigningValue(Self, AssignValueRec, Value, Handled);
end;

procedure TCommonBindComponent.DoOnDeactivated;
begin
//
end;

procedure TCommonBindComponent.DoOnDeactivating;
begin
//
end;

procedure TCommonBindComponent.DoOnAssignedValue(AssignValueRec: TBindingAssignValueRec; const Value: TValue);
begin
  if Assigned(FOnAssignedValue) then
    FOnAssignedValue(Self, AssignValueRec, Value);
end;

procedure TCommonBindComponent.DoOnEvalError(AException: Exception);
var
  LException: TBindCompException;
begin
  if Assigned(FOnEvalError) then
    FOnEvalError(Self, AException)
  else
  begin
    LException := TBindCompException.CreateFmt(
       sComponentEvalError, [GetDisplayName, AException.Message]);
    LException.SetInnerException;
    raise LException;
  end;
end;

procedure TCommonBindComponent.DoOnLocationUpdated(AOldLocation,
  ANewLocation: ILocation);
begin
  if Assigned(FOnLocationUpdated) then
    FOnLocationUpdated(AOldLocation, ANewLocation);
end;

procedure TCommonBindComponent.SetControlComponent(const Value: TComponent);
begin
  if FControlComponent <> Value then
  begin
    if (Value <> nil) and (Value = FSourceComponent) then
      raise TBindCompException.CreateFmt(sSameSourceAndControlComponent, [GetDisplayName]);
    if FControlComponent <> nil then
      FControlComponent.RemoveFreeNotification(Self);
    try
      UpdateControlChanging;
    finally
      FControlComponent := Value;
    end;
    if FControlComponent <> nil then
      FControlComponent.FreeNotification(Self);
    UpdateControlChanged;
  end;
end;

procedure TCommonBindComponent.SetOnActivated(const Value: TNotifyEvent);
begin
  FOnActivated := Value;
end;

procedure TCommonBindComponent.SetOnActivating(const Value: TNotifyEvent);
begin
  FOnActivating := Value;
end;

procedure TCommonBindComponent.SetOnAssignedValue(
  const Value: TBindCompAssignedValueEvent);
begin
  FOnAssignedValue := Value;
end;

procedure TCommonBindComponent.SetOnAssigningValue(
  const Value: TBindCompAssigningValueEvent);
begin
  FOnAssigningValue := Value;
end;

procedure TCommonBindComponent.SetOnEvalError(
  const Value: TBindCompEvalErrorEvent);
begin
  FOnEvalError := Value;
end;

procedure TCommonBindComponent.SetOnLocationUpdated(
  const Value: TBindingLocationUpdatedEvent);
begin
  FOnLocationUpdated := Value;
end;

function TCommonBindComponent.GetControlComponent: TComponent;
begin
  Result := FControlComponent;
end;

procedure TCommonBindComponent.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    try
      if AComponent = ControlComponent then
        ControlComponent := nil;
    finally
      if AComponent = SourceComponent then
        SourceComponent := nil;
    end;
  end;
end;

procedure TCommonBindComponent.SetSourceComponent(const Value: TComponent);
begin
  if FSourceComponent <> Value then
  begin
    if (Value <> nil) and (Value = FControlComponent) then
      raise TBindCompException.CreateFmt(sSameSourceAndControlComponent, [GetDisplayName]);
    if FSourceComponent <> nil then
    begin
      FSourceComponent.RemoveFreeNotification(Self);
    end;
    try
      UpdateSourceChanging;
    finally
      FSourceComponent := Value;
    end;
    if FSourceComponent <> nil then
    begin
      FSourceComponent.FreeNotification(Self);
    end;
    UpdateSourceChanged;
  end;
end;

procedure TCommonBindComponent.SetSourceMemberName(const Value: string);
begin
  if Value <> FSourceMemberName then
  begin
    try
      UpdateSourceMemberChanging;
    finally
      FSourceMemberName := Value;
    end;
    UpdateSourceMemberChanged;
  end;
end;


procedure TCommonBindComponent.UpdateControlChanging;
begin

end;

procedure TCommonBindComponent.UpdateControlChanged;
begin

end;

procedure TCommonBindComponent.UpdateExpressions;
begin

end;

procedure TCommonBindComponent.UpdateSourceChanging;
begin

end;

procedure TCommonBindComponent.UpdateSourceChanged;
begin

end;

procedure TCommonBindComponent.UpdateSourceMemberChanging;
begin

end;

procedure TCommonBindComponent.UpdateSourceMemberChanged;
begin

end;

procedure TCommonBindComponent.ExecuteAssignToControlExpression(const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
   AType: TBindCompExpressionType);
var
  LExpression: TBindingExpression;
begin
  LExpression := TBindings.CreateUnmanagedBinding(
    GetSourceScopes,
    ASourceExpression,
    GetcontrolScopes,       //Output destination(s)
    AControlExpression,
    GetOutputConverter,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue, DoOnAssignedValue, DoOnLocationUpdated),
    []  // Execute
  );
  try
    ACallback(LExpression.Evaluate);
  finally
    LExpression.Free;
  end;
end;

procedure TCommonBindComponent.ExecuteAssignToSourceExpression(const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
var
  LExpression: TBindingExpression;
begin
  LExpression := TBindings.CreateUnmanagedBinding(
    GetcontrolScopes,
    AControlExpression,
    GetSourceScopes,   //Output destination(s)
    ASourceExpression,
    GetOutputConverter,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue, DoOnAssignedValue, DoOnLocationUpdated),
    []  // Execute
  );
  try
    ACallback(LExpression.Evaluate);
  finally
    LExpression.Free;
  end;
end;

procedure TCommonBindComponent.EvaluateControlExpression(
  AEditorScope: IScope; const AEditorExpression: string; ACallback: TProc<IValue>);
var
  LExpression: TBindingExpression;
  LValue: IValue;
begin
  LExpression := TBindings.CreateExpression(
    GetComponentScopes(AEditorScope),
    AEditorExpression,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
  try
    LValue := LExpression.Evaluate;
    ACallback(LValue);
  finally
    LExpression.Free;
  end;
end;


procedure TCommonBindComponent.EvaluateControlExpression(const AExpression: string; ACallback: TProc<IValue>;
 AType: TBindCompExpressionType);
var
  LExpression: TBindingExpression;
  LScopes: TArray<IScope>;
  LValue: IValue;
begin
  LScopes := GetControlScopes;
  LExpression := TBindings.CreateExpression(
    LScopes, //Input scopes
    AExpression,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
  try
    LValue := LExpression.Evaluate;
    ACallback(LValue);
  finally
    LExpression.Free;
  end;

end;

function TCommonBindComponent.GetSourceComponent: TComponent;
begin
  Result := FSourceComponent;
end;

function TCommonBindComponent.GetSourceMemberName: string;
begin
  Result := FSourceMemberName;
end;

function TCommonBindComponent.GetSourceScopes: TArray<IScope>;
begin
  if FSourceMemberName = sWildcard then
    Result := GetComponentScopes(FSourceComponent, '')
  else
    Result := GetComponentScopes(FSourceComponent, FSourceMemberName)
end;

procedure TCommonBindComponent.MemberRemoved(AComponent: TComponent;
  const AMemberName: string);
begin

end;

procedure TCommonBindComponent.MemberRenamed(AComponent: TComponent;
  const ACurMemberName, APrevMemberName: string);
begin

end;

procedure TCommonBindComponent.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  if ACurMemberName <> '' then
    if AComponent = FSourceComponent then
      if FSourceMemberName = ACurMemberName then
        FSourceMemberName := ANewMemberName;
end;

function TCommonBindComponent.GetControlScopes: TArray<IScope>;
begin
  Result := GetComponentScopes(FControlComponent);
end;

procedure TCommonBindComponent.EvaluateSourceExpression(const AExpression: string; ACallback: TProc<IValue>;
 AType: TBindCompExpressionType);
var
  LExpression: TBindingExpression;
  LScopes: TArray<IScope>;
begin
  case  AType of
    exprPosSource,
    exprPosControl,
    exprFormatControl:
      LScopes := GetComponentScopes(FSourceComponent, '');
  else
    LScopes := GetSourceScopes;
  end;

  LScopes := GetSourceScopes;
  LExpression := TBindings.CreateExpression(
    LScopes, //Input scopes
    AExpression,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
  try
    ACallback(LExpression.Evaluate);
  finally
    LExpression.Free;
  end;

end;

procedure TCommonBindComponent.EvaluateSourceExpression(
  ASourceScope: IScope; const AEnumExpression: string; ACallback: TProc<IValue>);
var
  LExpression: TBindingExpression;
begin
  LExpression := TBindings.CreateExpression(
    GetComponentScopes(ASourceScope),
    AEnumExpression,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
  try
    ACallback(LExpression.Evaluate);
  finally
    LExpression.Free;
  end;
end;

procedure TCommonBindComponent.FreeExpressionsObjects;
begin

end;

function TCommonBindComponent.GetUseEvalShortcuts: Boolean;
begin
  Result := False;
end;

function TCommonBindComponent.GetComponentScope(AComponent: TComponent; const AMemberName: string): IScope;
var
  LBoundScope: IScope;
  LScopeComponent: IScopeComponent;
begin
  if AComponent = nil then
    Exit(nil);
  if Supports(AComponent, IScopeComponent, LScopeComponent) then
    if AMemberName <> '' then
      LBoundScope := LScopeComponent.GetMemberScope(AMemberName)
    else
      LBoundScope := LScopeComponent.GetScope
  else
    LBoundScope := WrapObject(AComponent);
  Result := LBoundScope;
end;

function TCommonBindComponent.GetComponentScopes(AComponent: TComponent; const AMemberName: string): TArray<IScope>;
begin
  Result := GetComponentScopes(GetComponentScope(AComponent, AMemberName));
end;

function TCommonBindComponent.GetComponentScopes(AComponentScope: IScope): TArray<IScope>;
begin
  if AComponentScope <> nil then
    Result := TArray<IScope>.Create(AComponentScope, GetMethodsScope)
  else
    Result := TArray<IScope>.Create(GetMethodsScope);
end;

function TCommonBindComponent.GetOutputConverter: IValueRefConverter;
var
  UseConverters: TList<string>;
  ConvDesc: TConverterDescription;
begin
  if Assigned(BindingsList) then
    Result := BindingsList.GetOutputConverter
  else
  begin
    UseConverters := TList<string>.Create;
    try
      // add converters enabled by default
      for ConvDesc in TValueRefConverterFactory.GetConverterDescriptions do
        if ConvDesc.DefaultEnabled  then
          UseConverters.Add(ConvDesc.ID);
      Result := TValueRefConverterFactory.GetConverter(UseConverters.ToArray);
    finally
      UseConverters.Free;
    end;
  end;
end;

function TCommonBindComponent.GetMethodsScope: IScope;
begin
  if Assigned(BindingsList) then
  begin
   Result := BindingsList.GetMethodsScope;
  end
  else
    Result := TBindingMethodsFactory.GetMethodScope;
end;

procedure TCommonBindComponent.FreeExpressionObjects(AList: TList<TBindingExpression>);
{$IFNDEF NEXTGEN}
var
  LExpression: TBindingExpression;
{$ENDIF}
begin
  try
    {$IFNDEF NEXTGEN}
    for LExpression in AList do
      LExpression.Free;
    {$ENDIF}
  finally
    AList.Clear;
  end;
end;

{ TBaseBindExpression }


constructor TBaseBindExpression.Create(AOwner: TComponent);
begin
  inherited;
  FManaged := True;
end;

destructor TBaseBindExpression.Destroy;
begin
  inherited;
end;


procedure TBaseBindExpression.Loaded;
begin
  try
    inherited;
    if CanActivate then
      LoadActivate;
  except
    // Don't raise exception when loading
  end;
end;

procedure TBaseBindExpression.SetActive(Value: Boolean);
begin
  if Designing then
    Exit;

  if FActive <> Value then
  begin
    if Loading then
    begin
      FDeferActive := Value
    end
    else
    begin
      try
        if not Value then
          if (ControlComponent <> nil) and
              (not (csDestroying in ControlComponent.ComponentState)) then
          if (SourceComponent <> nil) and
              (not (csDestroying in SourceComponent.ComponentState)) then
            EvaluateClear();
      finally
        if Value then
          DoOnActivating
        else
          DoOnDeactivating;
        FActive := Value;
        if FActive then
        begin
          try
            FreeExpressionsObjects;
            UpdateExpressions;
            EvaluateFormat;
          finally
            DoOnActivated;
          end;
        end
        else
        begin
          FreeExpressionsObjects;
          DoOnDeactivated;
        end;
      end;
    end;
  end;
end;

procedure TBaseBindExpression.SetManaged(const Value: Boolean);
begin
  if FManaged <> Value then
  begin
    SetActive(False);
    FManaged := Value;
  end;
end;

procedure TBaseBindExpression.SetNotifyOutputs(const Value: Boolean);
begin
  if FNotifyOutputs <> Value then
  begin
    SetActive(False);
    FNotifyOutputs := Value;
  end;
end;

procedure TBaseBindExpression.EvaluateFormat;
begin

end;

procedure TBaseBindExpression.EvaluateClear;
begin

end;

function TBaseBindExpression.GetActive: Boolean;
begin
  Result := FActive;
end;


{ TExpressionItem }

procedure TExpressionItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TExpressionItem then
  begin
    TExpressionItem(Dest).ControlExpression := ControlExpression;
    TExpressionItem(Dest).SourceExpression := SourceExpression;
    TExpressionItem(Dest).Custom := Custom;
  end
  else
    inherited;
end;

function TExpressionItem.GetDisplayName: string;
begin
  Result := '';
end;

function TExpressionItem.GetExpressions: TExpressions;
begin
  Result := TExpressions(Collection);
end;

{ TExpressionItemDir }

procedure TExpressionItemDir.AssignTo(Dest: TPersistent);
begin
  if Dest is TExpressionItemDir then
  begin
    inherited;
    TExpressionItemDir(Dest).Direction := Direction;
  end
  else
    inherited;
end;

{ TExpressions }

function TExpressions.AddExpression: TExpressionItem;
begin
  Result := Add as TExpressionItem;
  Result.Custom := True;  // Default
end;

function TExpressions.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

function TExpressions.GetItem(Index: Integer): TExpressionItem;
begin
  Result := TExpressionItem(inherited Items[Index]);
end;

function TExpressions.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sNameAttr;
    1: Result := sControlAttr;
    2: Result := sSourceAttr;
  else
    Result := ''; { do not localize }
  end;
end;

function TExpressions.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TExpressions.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: begin
         Result := IntToStr(ItemIndex);
       end;
    1: Result := Items[ItemIndex].ControlExpression;
    2: Result := Items[ItemIndex].SourceExpression;
  else
    Result := '';
  end;
end;

procedure TExpressions.SetItem(Index: Integer; const Value: TExpressionItem);
begin
  inherited SetItem(Index, TCollectionItem(Value));

end;

{ TExpressionsDir }

function TExpressionsDir.AddExpression: TExpressionItemDir;
begin
  Result := Add as TExpressionItemDir;
  Result.Custom := True;
end;

function TExpressionsDir.GetEnumerator: TExpressionDirEnumerator;
begin
  Result := TExpressionDirEnumerator.Create(Self);
end;

function TExpressionsDir.GetItem(Index: Integer): TExpressionItemDir;
begin
  Result := TExpressionItemDir(inherited Items[Index]);
end;

function TExpressionsDir.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sNameAttr;
    1: Result := sControlAttr;
    2: Result := sSourceAttr;
  else
    Result := ''; { do not localize }
  end;
end;

function TExpressionsDir.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TExpressionsDir.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: begin
         Result := IntToStr(ItemIndex);
       end;
    1: Result := Items[ItemIndex].ControlExpression;
    2: Result := Items[ItemIndex].SourceExpression;
  else
    Result := '';
  end;
end;

procedure TExpressionsDir.SetItem(Index: Integer; const Value: TExpressionItemDir);
begin
  inherited SetItem(Index, TCollectionItem(Value));

end;

{ TCustomBindScope }

constructor TCustomBindScope.Create(AOwner: TComponent);
begin
  FAutoActivate := True;
  inherited;
end;

destructor TCustomBindScope.Destroy;
begin
  inherited;
end;

function TCustomBindScope.GetActive: Boolean;
begin
  Result := FActive;
end;

type
  TEnumerableWrapper = class(TInterfacedObject, IScopeRecordEnumerator)
  private
    FEnumerating: Boolean;
    FObject: TObject;
    FContext: TRttiContext;
    FRttiType: TRttiType;
    FEnumerator: TObject;
    FParentScope: IScope;
    function GetEnumerator: TObject;
  public
    constructor Create(AObject: TObject; AParentScope: IScope = nil);
    destructor Destroy; override;
    procedure First;
    function GetCurrent: IScope;
    function GetMemberCurrent(const AMemberName: string): IScope;
    function MoveNext: Boolean;
    function GetRecordCount: Integer;
    property Current: IScope read GetCurrent;
    property RecordCount: Integer read GetRecordCount;
  end;

function TCustomBindScope.GetEnumerator(
  const AMemberName: string; ABufferCount: Integer): IScopeRecordEnumerator;
begin
    if Assigned(Component) then
      Result := TEnumerableWrapper.Create(Component, AddScopeMappings(nil))
    else if Assigned(DataObject) then
      Result := TEnumerableWrapper.Create(DataObject, AddScopeMappings(nil))
    else
      Result := nil;
end;

function TCustomBindScope.GetValue: TObject;
begin
  if FComponent <> nil then
    Result := FComponent
  else if FDataObject <> nil then
    Result := FDataObject
  else
  begin
    Assert(Owner <> nil);
    Result := Owner;
  end;
end;

procedure TCustomBindScope.Loaded;
begin
  try
    inherited;
    if FDeferActive then
    begin
      FDeferActive := False;
      SetActive(True)
    end
    else if AutoActivate then
      SetActive(True)
  except
    // Do not raise exception while loading
  end;
end;

procedure TCustomBindScope.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    if csLoading in ComponentState then
      FDeferActive := Value
    else
    begin
      FActive := Value;
      ActivateExpressions(FActive);
    end;
  end;
end;

procedure TCustomBindScope.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent = FComponent then
    begin
      FComponent := nil;
    end;
end;

procedure TCustomBindScope.UpdateDataChanging;
begin
  Active := False;
end;

procedure TCustomBindScope.UpdateDataChanged;
begin
  if AutoActivate then
    if CanActivate then
      Active := True;
end;

procedure TCustomBindScope.SetComponent(const Value: TComponent);
begin
  if Value <> FComponent then
  begin
    UpdateDataChanging;
    FComponent := Value;
    if Assigned(Value) and Assigned(DataObject) then
      DataObject := nil;
    UpdateDataChanged;
  end;
end;

function TCustomBindScope.CanActivate: Boolean;
begin
  Result := Assigned(DataObject) or Assigned(Component);
end;

procedure TCustomBindScope.SetDataObject(const Value: TObject);
begin
  if Value <> FComponent then
  begin
    UpdateDataChanging;
    FDataObject := Value;
    if Assigned(Value) and Assigned(Component) then
      Component := nil;
    UpdateDataChanged;
  end;
end;

procedure TCustomBindScope.SetAutoActivate(const Value: Boolean);
begin
  if FAutoActivate <> Value then
  begin
    FAutoActivate := Value;
    if not (csLoading in ComponentState) then
      if (csDesigning in ComponentState) then
        // While designing, active when enable
        Active := FAutoActivate;
  end;
end;

{ TBaseScopeComponent }

procedure TBaseBindScopeComponent.ActivateExpressions(AValue: Boolean);
var
  LBindComp: TBasicBindComponent;
  LBindLink: IBindLink;
  LBindPosition: IBindPosition;
  LBindActivate: IBindActivate;
begin
  if Expressions <> nil then

  for LBindComp in Expressions do
  begin
    if Supports(LBindComp, IBindActivate, LBindActivate) then
    begin
      LBindActivate.SetActive(AValue);
    end
    else if Supports(LBindComp, IBindLink, LBindLink) then
    begin
      LBindLink.Active := AValue;
    end
    else if Supports(LBindComp, IBindPosition, LBindPosition) then
    begin
      LBindPosition.Active := AValue;
    end
  end;
end;

procedure TBaseBindScopeComponent.AddExpression(
  AExpression: TBasicBindComponent);
begin
  Assert(not FExpressions.Contains(AExpression));
  AExpression.FreeNotification(Self);
  FExpressions.Add(AExpression);
end;

constructor TBaseBindScopeComponent.Create(AOwner: TComponent);
begin
  inherited;
  FExpressions := TList<TBasicBindComponent>.Create;
  FScopeMappings := TScopeMappings.Create(Self, TScopeMappingItem);
end;

destructor TBaseBindScopeComponent.Destroy;
begin
  FreeAndNil(FExpressions);
  FreeAndNil(FScopeMappings);
  inherited;
end;

function TBaseBindScopeComponent.GetMemberScope(
  const AMemberName: string): IScope;
var
  LMember: TObject;
begin
  LMember := GetMember(AMemberName);
  if LMember <> nil then
  begin
    Result := WrapObject(LMember);
    Result := AddScopeMappings(Result);
  end
  else
    Result := nil;
end;


function TBaseBindScopeComponent.GetPosLock: Boolean;
begin
  Result := FPosLock > 0;
end;

function TBaseBindScopeComponent.GetScope: IScope;
var
  LObject: TObject;
begin
  LObject := GetValue;
  if LObject = nil then
    Result := nil
  else
  begin
    Result := WrapObject(LObject);
    Result := AddScopeMappings(Result);
  end;
end;

function TBaseBindScopeComponent.GetScopeObject: TObject;
begin
  Result := GetValue;
end;

function TBaseBindScopeComponent.AddScopeMappings(AScope: IScope): IScope;
var
  LDictScope: TDictionaryScope;
  LScopeMappingItem: TScopeMappingItem;
begin
  if FScopeMappings.Count > 0 then
  begin
    LDictScope := TDictionaryScope.Create;
    for LScopeMappingItem in FScopeMappings do
    begin
      if (LScopeMappingItem.Name = '') or LDictScope.Map.ContainsKey(LScopeMappingItem.Name) then
        continue;
     if LScopeMappingItem.ValComponent <> nil then
        LDictScope.Map.Add(LScopeMappingItem.Name, WrapObject(LScopeMappingItem.ValComponent))
      else if LScopeMappingItem.ValObject <> nil then
        LDictScope.Map.Add(LScopeMappingItem.Name, WrapObject(LScopeMappingItem.ValObject))
      else if Assigned(LScopeMappingItem.ValNotifyEvent) then
        LDictScope.Map.Add(LScopeMappingItem.Name, TValueWrapper.Create(TValue.From<TNotifyEvent>(LScopeMappingItem.ValNotifyEvent)))
      else if LScopeMappingItem.ValVariant <> Unassigned then
        LDictScope.Map.Add(LScopeMappingItem.Name, TValueWrapper.Create(TValue.From<Variant>(LScopeMappingItem.ValVariant)))
      else
        LDictScope.Map.Add(LScopeMappingItem.Name, TValueWrapper.Create(TValue.Empty))
    end;
    if AScope <> nil then
      //make sure Self scope comes last to ensure proper evaluation (inner looked up first)
      Result := TNestedScope.Create(AScope, LDictScope)
    else
      Result := LDictScope;
  end
  else
    Result := AScope;
end;

function TBaseBindScopeComponent.GetValue: TObject;
begin
  Result := Self;
end;

function TBaseBindScopeComponent.GetMember(const AMemberName: string): TObject;
begin
  Result := nil;
end;


procedure TBaseBindScopeComponent.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    if AComponent is TBasicBindComponent then
      if FExpressions <> nil then
        if FExpressions.Contains(TBasicBindComponent(AComponent)) then
          FExpressions.Remove(TBasicBindComponent(AComponent));
    if ScopeMappings <> nil then
      for I := ScopeMappings.Count - 1 downto 0 do
        if AComponent = ScopeMappings[I].ValComponent then
          ScopeMappings.Delete(I);
  end;
end;

procedure TBaseBindScopeComponent.PosLockEnter;
begin
  Inc(FPosLock);
end;

procedure TBaseBindScopeComponent.PosLockLeave;
begin
  Dec(FPosLock);
  Assert(FPosLock >= 0);
end;

procedure TBaseBindScopeComponent.RemoveExpression(
  AExpression: TBasicBindComponent);
begin
  if FExpressions <> nil then
    if FExpressions.Contains(AExpression) then
    begin
      AExpression.RemoveFreeNotification(Self);
      FExpressions.Remove(AExpression);
    end;
end;


procedure TBaseBindScopeComponent.SetScopeMappings(const Value: TScopeMappings);
begin
  if (Value.Count <> 0) or (FScopeMappings.Count <> 0) then
  begin
    FScopeMappings := Value;
  end;
end;


{ TScopeMappingItem }

procedure TScopeMappingItem.ClearValue;
begin
  FValValue := TValue.Empty;
  FValObject := nil;
  FValNotifyEvent := nil;
  FValComponent := nil;
  FValVariant := Unassigned;
end;

procedure TScopeMappingItem.SetValComponent(const Value: TComponent);
begin
  ClearValue;
  FValComponent := Value;
end;

procedure TScopeMappingItem.SetValObject(const Value: TObject);
begin
  ClearValue;
  FValObject := Value;
end;

procedure TScopeMappingItem.SetValNotifyEvent(const Value: TNotifyEvent);
begin
  ClearValue;
  FValNotifyEvent := Value;
end;

procedure TScopeMappingItem.SetValVariant(const Value: Variant);
begin
  ClearValue;
  FValVariant := Value;
end;

procedure TScopeMappingItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TScopeMappingItem then
  begin
    TScopeMappingItem(Dest).Name := Name;
    TScopeMappingItem(Dest).ClearValue;
    TScopeMappingItem(Dest).FValComponent := ValComponent;
    TScopeMappingItem(Dest).FValNotifyEvent := ValNotifyEvent;
    TScopeMappingItem(Dest).FValObject := ValObject;
    TScopeMappingItem(Dest).FValVariant := ValVariant;
  end
  else
    inherited;
end;

function TScopeMappingItem.GetDisplayName: string;
begin
  Result := '';
end;

function TScopeMappingItem.GetScopeMappings: TScopeMappings;
begin
  Result := TScopeMappings(Collection);
end;

{ TScopeMappingsEnumerator }

function TScopeMappingsEnumerator.GetCurrent: TScopeMappingItem;
begin
  Result := TScopeMappingItem(inherited GetCurrent);
end;

{ TScopeMappings }

function TScopeMappings.AddExpression: TScopeMappingItem;
begin
  Result := Add as TScopeMappingItem;
end;

function TScopeMappings.GetEnumerator: TScopeMappingsEnumerator;
begin
  Result := TScopeMappingsEnumerator.Create(Self);
end;

function TScopeMappings.GetItem(Index: Integer): TScopeMappingItem;
begin
  Result := TScopeMappingItem(inherited Items[Index]);
end;

function TScopeMappings.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sIDAttr;
    1: Result := sNameAttr;
    2: Result := sValueAttr;
  else
    Result := ''; { do not localize }
  end;
end;

function TScopeMappings.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TScopeMappings.GetItemAttr(Index, ItemIndex: Integer): string;
var
  LMethod: TMethod;
  LRoot: TComponent;
begin
  Result := '';
  case Index of
    0: begin
         Result := IntToStr(ItemIndex);
       end;
    1: Result := Items[ItemIndex].Name;
    2: begin
         if Items[ItemIndex].ValComponent <> nil then
           Result := Items[ItemIndex].ValComponent.Name
         else if Items[ItemIndex].ValVariant <> Unassigned then
           try
             Result := Items[ItemIndex].ValVariant
           except
             Result := '';
           end
         else
         begin
           LMethod := TMethod(Items[ItemIndex].ValNotifyEvent);
           if LMethod.Code <> nil then
           begin
             LRoot := Owner as TComponent;
             if LRoot <> nil then
               while LRoot.Owner <> nil do
                 LRoot := LRoot.Owner;
             if (LRoot <> nil) and (LMethod.Data = LRoot) then
               Result := LRoot.MethodName(LMethod.Code)
             else
               Result := '';
           end;
         end;
       end;
  end;
end;

procedure TScopeMappings.SetItem(Index: Integer; const Value: TScopeMappingItem);
begin
  inherited SetItem(Index, TCollectionItem(Value));
end;

{ TCustomBindLink }

function TCustomBindLink.GetCanModify: Boolean;
var
  Intf: IScopeEditLink;
begin
  if SourceComponent = nil then  // Don't prevent selection in listbox when only filling
    Exit(True);
  if FParseExpressions.Count = 0 then
    Exit(False);  // Don't allow editing if not bidi
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Result := Intf.GetCanModify(Self)
  else
    Result := False;
end;

procedure TCustomBindLink.ClearModified;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.ClearModified(Self)
end;

procedure TCustomBindLink.UpdateRecord;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.UpdateRecord(Self)
end;

procedure TCustomBindLink.BeginUpdate;
begin
  Inc(FUpdateCounter);
end;

procedure TCustomBindLink.CheckEditingLink;
begin
  FControlObserver.Component := ControlComponent;
  FControlObserver.EnsureObserving(TControlObserver.IDEditLinkObserver,
    function: IObserver
    var
      LObserver: TBindEditLinkObserver;
    begin
      LObserver := TBindEditLinkObserver.Create(Self);
      LObserver.SetTrack(Self.Track);
      Result := LObserver;
    end);
end;

procedure TCustomBindLink.ClearEditingLink;
begin
  FControlObserver.Component := nil;
end;

constructor TCustomBindLink.Create(AOwner: TComponent);
begin
  inherited;
  FControlObserver := TControlObserver.Create;
  FUpdateCounter := 0;
end;

destructor TCustomBindLink.Destroy;
begin
  ClearEditingLink;
  FControlObserver.Free;
  inherited;
end;

procedure TCustomBindLink.Loaded;
begin
  try
    inherited;
    if CanActivate then
      LoadActivate;
  except
    // Don't raise exception when loading
  end;
end;

procedure TCustomBindLink.SetModified;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.SetModified(Self)
end;

function TCustomBindLink.GetIsModified: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Result := Intf.GetIsModified(Self)
  else
    Result := False;
end;

function TCustomBindLink.GetUpdating: Boolean;
begin
  Result := FUpdateCounter > 0;
end;

function TCustomBindLink.RequiresControlHandler: Boolean;
begin
  Result := FParseExpressions.Count > 0;
end;

procedure TCustomBindLink.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Loading then
    begin
      if not Designing then
        FDeferActive := Value
    end
    else
    begin
      ClearModified;
      try
        if not Value then
          if (ControlComponent <> nil) and
              (not (csDestroying in ControlComponent.ComponentState)) then
            EvaluateClear('');
      finally
        if Value then
          DoOnActivating
        else
          DoOnDeactivating;

        FActive := Value;
        if FActive then
        begin
          try
            FreeExpressionsObjects;
            UpdateExpressions;
            if not Designing then
              if RequiresControlHandler then
              begin
                // Check here after the link is activated, so that we
                // have binding expressions
                CheckEditingLink;
                if not FControlObserver.TrySetActive(True) then
                  raise TBindCompException.CreateFmt(sNoControlObserverSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);
              end;
            EvaluateFormat('');
          finally
            DoOnActivated;
          end;
        end
        else
        begin
          FControlObserver.TrySetActive(False);
          FreeExpressionsObjects;
          DoOnDeactivated;
        end;
      end;
    end;
  end;
end;

function TCustomBindLink.GetActive: Boolean;
begin
  Result := FActive;
end;

function TCustomBindLink.GetBindComp: TComponent;
begin
  Result := Self;
end;

function TCustomBindLink.IsRequired: Boolean;
var
  LScopeEditor: IScopeEditor;
begin
  Result := False;
  if Supports(SourceComponent, IScopeEditor, LScopeEditor) then
  begin
    Result := LScopeEditor.IsRequired(SourceMemberName);
  end;
end;

procedure TCustomBindLink.SetIsReadOnly(Value: Boolean);
var
  LScopeEditLink: IScopeEditLink;
begin
  if Supports(SourceComponent, IScopeEditLink, LScopeEditLink) then
    LScopeEditLink.SetReadOnly(Self, Value);
end;

function TCustomBindLink.IsValidChar(AKey: Char): Boolean;
var
  LScopeEditor: IScopeEditor;
begin
  Result := True;
  if Supports(SourceComponent, IScopeEditor, LScopeEditor) then
  begin
    Result := LScopeEditor.IsValidChar(SourceMemberName, AKey);
  end;
end;

function TCustomBindLink.GetSourceScopes: TArray<IScope>;
begin
  Result := inherited GetSourceScopes;
end;

function TCustomBindLink.GetTrack: Boolean;
begin
  Result := FTrack;
end;

procedure TCustomBindLink.UpdateExpressions;
var
  LExpressionItem: TExpressionItem;
  LBindingExpression: TBindingExpression;
begin
  Assert(FFormatExpressionObjects.Count = 0);
  Assert(FClearExpressionObjects.Count = 0);
  Assert(FParseExpressionObjects.Count = 0);
  Assert(FControlExpressionObject = nil);


  for LExpressionItem in FFormatExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      GetSourceScopes,
      LExpressionItem.SourceExpression,
      GetcontrolScopes, //Output destination(s)
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );

    AddDependency(LBindingExpression,
      procedure(ABinding: TExpressionsBindComponent)
      begin
        assert(ABinding is TCustomBindLink);
        if not TCustomBindLink(ABinding).GetUpdating then
          TCustomBindLink(ABinding).EvaluateFormat('');
      end,
      SourceComponent, SourceMemberName, '', ControlComponent);
    FFormatExpressionObjects.Add(LBindingExpression);
  end;


  for LExpressionItem in FClearExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      GetSourceScopes,
      LExpressionItem.SourceExpression,
      GetControlScopes,
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FClearExpressionObjects.Add(LBindingExpression);

  end;

  for LExpressionItem in FParseExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      GetControlScopes,
      LExpressionItem.ControlExpression,
      GetSourceScopes,
      LExpressionItem.SourceExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    AddDependency(LBindingExpression,
      procedure(ABinding: TExpressionsBindComponent)
      begin
        assert(ABinding is TCustomBindLink);
        if not TCustomBindLink(ABinding).GetUpdating then
          TCustomBindLink(ABinding).EvaluateParse('');
      end,
      ControlComponent, '', LExpressionItem.ControlExpression, SourceComponent);
    FParseExpressionObjects.Add(LBindingExpression);
  end;

  FControlExpressionObject := TBindings.CreateExpression(
    GetControlScopes, //Input scopes
    'Self',
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
end;

procedure TCustomBindLink.UpdateTrack;
var
  LObserver: IObserver;
begin
  if FControlObserver <> nil then
  begin
    LObserver := FControlObserver.GetObserver(TObserverMapping.EditLinkID);
    if LObserver is TBindEditLinkObserver then
      TBindEditLinkObserver(LObserver).SetTrack(FTrack);
  end;
end;

procedure TCustomBindLink.SetTrack(const Value: Boolean);
begin
  if FTrack <> Value then
  begin
    FTrack := Value;
    UpdateTrack;
  end;
end;

procedure TCustomBindLink.UpdateControlChanging;
begin
  inherited; // Set active false
  ClearEditingLink;
end;

procedure TCustomBindLink.Reset;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.Reset(Self)
end;

procedure TCustomBindLink.EvaluateParse(const AMemberName: string);
var
  LExpression: TBindingExpression;
begin
  if Active then
    for LExpression in FParseExpressionObjects do
    begin
      if LExpression.Compiled then
        LExpression.Evaluate;
    end;
end;

function TCustomBindLink.EvaluateControl: IValue;
begin
  Result := nil;
  if FControlExpressionObject <> nil then
  begin
    if FControlExpressionObject.Compiled then
      Result := FControlExpressionObject.Evaluate;
  end;

end;

function TCustomBindLink.Edit: Boolean;
var
  Intf: IScopeEditLink;
begin
  if SourceComponent = nil then  // Don't prevent selection in listbox when only filling
    Exit(True);
  if FParseExpressions.Count = 0 then
    Exit(False);  // Don't allow editing if not bidi
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Result := Intf.Edit(Self)
  else
    Result := True;
end;

procedure TCustomBindLink.EndUpdate;
begin
  Dec(FUpdateCounter);
  if FUpdateCounter < 0 then
    FUpdateCounter := 0;
end;

function TCustomBindLink.GetIsEditing: Boolean;
var
  Intf: IScopeEditLink;
begin
  if FParseExpressions.Count = 0 then
    Exit(False);  // Don't allow editing if not bidi
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Result := Intf.GetIsEditing(Self)
  else
    Result := False;
end;

procedure TCustomBindLink.EvaluateClear(const AMemberName: string);
var
  LExpression: TBindingExpression;
begin
  if Active then
    BeginUpdate;
    try
      for LExpression in FClearExpressionObjects do
      begin
        if LExpression.Compiled then  // In case binding manager has been destroyed
          LExpression.Evaluate;
      end;
    finally
      EndUpdate;
    end;
end;

procedure TCustomBindLink.EvaluateFormat(const AMemberName: string);
var
  LExpression: TBindingExpression;
begin
  if Active then
  begin
    BeginUpdate; // Ignore changes while setting a control
    try
      for LExpression in FFormatExpressionObjects do
      begin
        if LExpression.Compiled then  // In case binding manager has been destroyed
        begin
          LExpression.Evaluate;
          NotifyDependentOutputs(LExpression);
        end;
      end;
    finally
      EndUpdate;
    end;
  end;
end;


{ TBindArtifacts }

function TBindArtifacts.GetItem(Index: Integer): TBindArtifactItem;
begin
  Result := TBindArtifactItem(inherited Items[Index]);
end;


constructor TBindArtifacts.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TBindArtifactItem);
end;

function TBindArtifacts.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sIDAttr;
    1: Result := sStateAttr;
  else
    Result := ''; { do not localize }
  end;
end;

function TBindArtifacts.GetAttrCount: Integer;
begin
  Result := 2;
end;

function TBindArtifacts.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: begin
         Result := Items[ItemIndex].ID;
       end;
    1: Result := GetEnumName(TypeInfo(TBindArtifactState), Integer(Items[ItemIndex].State));
  else
    Result := '';
  end;
end;

procedure TBindArtifacts.SetItem(Index: Integer; const Value: TBindArtifactItem);
begin
  inherited SetItem(Index, TCollectionItem(Value));

end;


{ TBindArtifactItem }

procedure TBindArtifactItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TBindArtifactItem then
  begin
    TBindArtifactItem(Dest).ID := ID;
    TBindArtifactItem(Dest).State := State;
  end
  else
    inherited;
end;

constructor TBindCompDesignExpression.Create(const AName, AControlScope, AControlExpression: string;
  const ASourceScope, ASourceExpression: string;
  AExecuteAssignToControl, AExecuteAssignToSource: TExecuteDesignExpression2;
  AExecuteControl, AExecuteSource: TExecuteDesignExpression;
  ASaveControl, ASaveSource: TSaveDesignExpression; ACollectionItem: TCollectionItem;
  const ACollectionName: string;
  AParentCollectionItem: TCollectionItem;
  AExpressionType: TBindCompDesignerExpressionType);
begin
  FName := AName;
  FCollectionName := ACollectionName;
  FControlScope := AControlScope;
  FControlExpression := AControlExpression;
  FSourceScope := ASourceScope;
  FSourceExpression := ASourceExpression;
  FExecuteAssignToSourceProc := AExecuteAssignToSource;
  FExecuteAssignToControlProc := AExecuteAssignToControl;
  FExecuteControlProc := AExecuteControl;
  FExecuteSourceProc := AExecuteSource;
  FSaveControlProc := ASaveControl;
  FSaveSourceProc := ASaveSource;
  FCollectionItem := ACollectionItem;
  FParentCollectionItem := AParentCollectionItem;
  FExpressionType := AExpressionType;
end;

procedure TCustomBindList.UpdateControlChanging;
begin
  inherited;  // Set active false
  BindListEditor := nil; // Release editor
end;

procedure TCustomBindList.ClearList;
var
  LEditor: IBindListEditorCommon;
begin
  LEditor := GetBindListEditor;
  LEditor.BeginUpdate;
  try
    LEditor.ClearList;
    EvaluateClearControl;
  finally
    LEditor.EndUpdate;
  end;
end;

function TCustomBindList.GetActive: Boolean;
begin
  Result := FActive;
end;

function TCustomBindList.GetBindListEditor: IBindListEditorCommon;
begin
  CheckControlComponent;
  if not TryGetBindListEditor(Result) then
    if Editor = '' then
      raise TBindCompException.CreateFmt(sNoListEditor, [Self.GetDisplayName, SafeClassName(ControlComponent)])
    else
      raise TBindCompException.CreateFmt(sNoNamedListEditor, [Self.GetDisplayName, SafeClassName(ControlComponent), Editor]);
end;


function TCustomBindList.TryGetBindListEditor(out AEditor: IBindListEditorCommon): Boolean;
begin
  AEditor := nil;
  if (ControlComponent <> nil) and
    (not (csDestroying in ControlComponent.ComponentState)) then
     Supports(GetBindEditor(ControlComponent, IBindListEditorCommon, Self.Editor), IBindListEditorCommon, AEditor);
  Result := AEditor <> nil;
end;



function TCustomBindList.IsLinked: Boolean;
begin
  Result := False;
end;

procedure TCustomBindList.EvaluateFormatControl;
var
  LExpression: TBindingExpression;
begin
  for LExpression in FFormatControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

procedure TCustomBindList.InsertItem(Select: Boolean);
var
  LEditor: IBindListEditor;
  LScope: IScope;
begin
  if not Supports(GetBindListEditor, IBindListEditor, LEditor) then
    raise TBindCompException.CreateFmt(sNoInsertItem, [Self.GetDisplayName, ControlComponent.ClassName]);
  if LEditor <> nil then
  begin
    LScope := LEditor.InsertItem(Select);
    if LScope <> nil then
    begin
      FillListItem(LEditor, inherited GetComponentScope(SourceComponent, SourceMemberName), LScope,
        TFillItemMode.fmInsert);
    end
    else
      raise TBindCompException.CreateFmt(sNoInsertItem, [Self.GetDisplayName, SourceComponent.ClassName]);
  end
end;

procedure TCustomBindList.AddItem(Select: Boolean);
var
  LEditor: IBindListEditor;
  LScope: IScope;
begin
  if not Supports(GetBindListEditor, IBindListEditor, LEditor) then
    raise TBindCompException.CreateFmt(sNoInsertItem, [Self.GetDisplayName, ControlComponent.ClassName]);
  if LEditor <> nil then
  begin
    LScope := LEditor.AddItem(Select);
    if LScope <> nil then
    begin
      FillListItem(LEditor, inherited GetComponentScope(SourceComponent, SourceMemberName), LScope,
        TFillItemMode.fmAdd);
    end
    else
      raise TBindCompException.CreateFmt(sNoEnumerator, [Self.GetDisplayName, SourceComponent.ClassName]);
  end
end;

procedure TCustomBindList.EvaluateClearControl;
var
  LExpression: TBindingExpression;
begin
  for LExpression in FClearControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

procedure TCustomBindList.FillListItem(const AEditor: IBindListEditor; const ASourceScope, AEditorScope: IScope;
  AMode: TFillItemMode);
var
  LExpression: TExpressionItem;
begin
  DoFillingListItem(AEditor);
  try
    for LExpression in FFormatExpressions do
    begin
      EvaluateExpressionItem(LExpression, AEditorScope, ASourceScope);
    end;
  finally
    DoFilledListItem(AEditor);
  end;
end;

procedure TCustomBindList.FillList;
var
  LEditorCommon: IBindListEditorCommon;
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
  LVirtualEditor: IBindListVirtualEditor;
begin
  DoFillingList;
  try
    EvaluateFormatControl;
    LEditorCommon := GetBindListEditor;
    if Supports(LEditorCommon, IBindListEditor, LEditor) then
    begin
      LEnumerator := GetScopeRecordEnumerator(SourceComponent, SourceMemberName, IsLinked);
      if LEnumerator <> nil then
      begin
        LEditor.FillList(LEnumerator,
          procedure(const ASourceScope, AEditorScope: IScope)
          begin
            FillListItem(LEditor, ASourceScope, AEditorScope, TFillItemMode.fmFill);
          end)
      end
    end
    else if Supports(LEditorCommon, IBindListVirtualEditor, LVirtualEditor) then
    begin
      Assert(False);
    end;
  finally
    DoFilledList;
  end;
end;

procedure TCustomBindList.EvaluateExpressionItem(AItem: TExpressionItem; AEditorScope: IScope;
  AEnumScope: IScope);
begin
  EvaluateExpressions(AEditorScope, AItem.ControlExpression, AEnumScope, AItem.SourceExpression);
end;

procedure TCustomBindList.EvaluateExpressions(AEditorScope: IScope; const AEditorExpression: string;
  AEnumScope: IScope; const AEnumExpression: string);
var
  LExpression: TBindingExpression;
begin
  LExpression := TBindings.CreateUnmanagedBinding(
    inherited GetComponentScopes(AEnumScope),
    AEnumExpression,
    inherited GetComponentScopes(AEditorScope), //Output destination(s)
    AEditorExpression,
    GetOutputConverter,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
    []  // Execute
  );
  try
    LExpression.Evaluate;
  finally
    LExpression.Free;
  end;
end;


constructor TCustomBindList.Create(AOwner: TComponent);
begin
  inherited;
  FFormatExpressions := TExpressions.Create(Self, TExpressionItem);
  FFormatControlExpressions := TExpressions.Create(Self, TExpressionItem);
  FClearControlExpressions := TExpressions.Create(Self, TExpressionItem);

  FFormatControlExpressionObjects := TList<TBindingExpression>.Create;
  FClearControlExpressionObjects := TList<TBindingExpression>.Create;
  FDeprecatedBufferCount := -1;
  FAutoFill := True;

end;

type
  TReadBufferProperties = class
  private
    procedure ReadBoolean(Reader: TReader);
    procedure ReadInteger(Reader: TReader);
  end;

var
  FReadBufferProperties: TReadBufferProperties;

procedure ReadBufferProperties(Filer: TFiler);
begin
  if FReadBufferProperties = nil then
    FReadBufferProperties := TReadBufferProperties.Create;

  Filer.DefineProperty('AutoBufferCount', FReadBufferProperties.ReadBoolean, nil, False);
  Filer.DefineProperty('BufferCount', FReadBufferProperties.ReadInteger, nil, False);
end;

procedure TCustomBindList.DefineProperties(Filer: TFiler);
begin
  inherited;
  // For backwards compatibility
  ReadBufferProperties(Filer);
end;

destructor TCustomBindList.Destroy;
begin
  BindListEditor := nil; // Release editor
  FreeExpressionsObjects;
  FFormatExpressions.Free;
  FFormatControlExpressions.Free;
  FClearControlExpressions.Free;

  FFormatControlExpressionObjects.Free;
  FClearControlExpressionObjects.Free;
  inherited;
end;

procedure TCustomBindList.DoFilledList;
begin
  if Assigned(FOnFilledList) then
    FOnFilledList(Self);
end;

procedure TCustomBindList.DoFilledListItem(const AEditor: IBindListEditor);
var
  LItem: IBindListEditorItem;
begin
  if Assigned(FOnFilledListItem) then
    if Supports(AEditor, IBindListEditorItem, LItem) then
      FOnFilledListItem(Self, LItem);

end;

procedure TCustomBindList.DoFillingList;
begin
  if Assigned(FOnFillingList) then
    FOnFillingList(Self);
end;

procedure TCustomBindList.DoFillingListItem(const AEditor: IBindListEditor);
var
  LItem: IBindListEditorItem;
begin
  if Assigned(FOnFillingListItem) then
    if Supports(AEditor, IBindListEditorItem, LItem) then
      FOnFillingListItem(Self, LItem);
end;

function TCustomBindList.CanInsert: Boolean;
var
  LEditor: IBindListEditor;
begin
  if Supports(GetBindListEditor, IBindListEditor, LEditor) then
    Result := LEditor.CanInsertItem
  else
    Result := False;
end;

function TCustomBindList.CanUpdate: Boolean;
var
  LEditor: IBindListEditor;
begin
  if Supports(GetBindListEditor, IBindListEditor, LEditor) then
    Result := LEditor.CurrentItem <> nil
  else
    Result := False;
end;

procedure TCustomBindList.EvaluateControlExpression(
  const AExpression: string; ACallback: TProc<IValue>; AType: TBindCompExpressionType);
var
  LEditor: IBindListEditor;
  LScope: IScope;
begin
  if AType = TBindCompExpressionType.exprFill then
  begin
    Supports(GetBindListEditor, IBindListEditor, LEditor);
    if LEditor <> nil then
    begin
      // Get an item to evaluate
      LScope := LEditor.CurrentItem;
      if LScope = nil then
      begin
        if LEditor.MoveNext then
          LScope := LEditor.CurrentItem
        else
          LScope := LEditor.AddItem;
      end;
      begin
        EvaluateControlExpression(LScope, AExpression, ACallback);
      end;
    end;
  end
  else
  begin
    inherited EvaluateControlExpression(AExpression, ACallback, AType);
  end;

end;

procedure TCustomBindList.ExecuteAssignToControlExpression(
  const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
var
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
  LScope: IScope;
begin
  Supports(GetBindListEditor, IBindListEditor, LEditor);
  if LEditor <> nil then
  begin
    if AType = TBindCompExpressionType.exprFill then
     begin
      LEnumerator := GetScopeRecordEnumerator(SourceComponent, SourceMemberName, IsLinked);
      if LEnumerator <> nil then
      begin
        LEditor.BeginUpdate;
        try
          if LEnumerator.MoveNext then
          begin

            LScope := LEditor.CurrentItem;
            if LScope = nil then
            begin
              if LEditor.MoveNext then
                LScope := LEditor.CurrentItem
              else
                LScope := LEditor.AddItem;
            end;
            EvaluateExpressions(LScope, AControlExpression, LEnumerator.Current, ASourceExpression);
          end;
        finally
          LEditor.EndUpdate;
        end;
      end
    end
    else
    begin
        LScope := LEditor.CurrentItem;
        if LScope = nil then
        begin
          if LEditor.MoveNext then
            LScope := LEditor.CurrentItem
          else
            LScope := LEditor.AddItem;
        end;

        EvaluateExpressions(LScope, AControlExpression,
          inherited GetComponentScope(SourceComponent, SourceMemberName),
          ASourceExpression);
    end
  end;

end;

procedure TCustomBindList.ExecuteAssignToSourceExpression(const AControlExpression, ASourceExpression: string;
  ACallback: TProc<IValue>; AType: TBindCompExpressionType);
begin
  // Can't set output
  Assert(False);
end;

procedure TCustomBindList.UpdateItem;
var
  LEditor: IBindListEditor;
  LScope: IScope;
begin
  Supports(GetBindListEditor, IBindListEditor, LEditor);
  if LEditor <> nil then
  begin
    LScope := LEditor.CurrentItem;
    if LScope <> nil then
    begin
      FillListItem(LEditor, inherited GetComponentScope(SourceComponent, SourceMemberName), LScope,
        TFillItemMode.fmUpdate);
    end
    else
      raise TBindCompException.CreateFmt(sNoEnumerator, [Self.GetDisplayName, SourceComponent.ClassName]);
  end
end;

procedure TCustomBindList.EvaluateSourceExpression(
  const AExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
var
  LEnumerator: IScopeRecordEnumerator;
  LScope: IScope;
begin
  if AType = TBindCompExpressionType.exprFill then
  begin
    LEnumerator := GetScopeRecordEnumerator(SourceComponent, SourceMemberName, IsLinked);
    if LEnumerator <> nil then
    begin
      if LEnumerator.MoveNext then
        LScope := LEnumerator.Current
      else
        LScope := nil;
      EvaluateSourceExpression(LEnumerator.Current, AExpression, ACallback);
    end
    else
      inherited EvaluateSourceExpression(AExpression, ACallback, AType);
  end
  else
    inherited;
end;

procedure TCustomBindList.FreeExpressionsObjects;
begin
  FreeAndNil(FControlExpressionObject);
  FreeExpressionObjects(FClearControlExpressionObjects);
  FreeExpressionObjects(FFormatControlExpressionObjects);
end;

procedure TCustomBindList.Loaded;
begin
  try
    inherited;
    if FDeferActive then
    begin
      FDeferActive := False;
      SetActive(True);
    end
    else
      if CanActivate then
        LoadActivate;
  except
    // Don't raise exception when loading
  end;
end;

procedure TCustomBindList.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
end;

procedure TCustomBindList.ResetList;
begin
  if Active then
  begin
    if AutoFill then
      FillList;
  end;
end;

procedure TCustomBindList.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Loading then
    begin
      if not Designing then
        FDeferActive := Value
    end
    else
    begin
      if Value then
        DoOnActivating
      else
        DoOnDeactivating;

      FActive := Value;
      if FActive then
      begin
        try
          FreeExpressionsObjects;
          UpdateExpressions;
          if AutoFill then
            FillList;
        finally
          DoOnActivated;
        end;
      end
      else
      begin
        try
          if AutoFill then
            if (ControlComponent <> nil) and
              (not (csDestroying in ControlComponent.ComponentState)) then
              ClearList;
        finally
          FreeExpressionsObjects;
          DoOnDeactivated;
        end;
      end;
    end;
  end;

end;

procedure TCustomBindList.SetAutoFill(const Value: Boolean);
begin
  if FAutoFill <> Value then
  begin
    FAutoFill := Value;
    if Active then
      if FAutoFill then
        FillList
      else if Designing then
        ClearList;
  end;
end;

procedure TCustomBindList.SetBindListEditor(
  const AEditor: IBindListEditorCommon);
begin
  if FBindListEditor <> AEditor then
  begin
    if Supports(FBindListEditor, IBindListVirtualEditor) then
      // Need to discard editor that has callback references
      ReleaseBindEditor(FBindListEditor);
    FBindListEditor := AEditor;
  end;
end;

procedure TCustomBindList.SetFormatExpressions(const Value: TExpressions);
begin
  FFormatExpressions.Assign(Value);
end;

procedure TCustomBindList.SetFormatControlExpressions(const Value: TExpressions);
begin
  FFormatControlExpressions.Assign(Value);
end;

procedure TCustomBindList.SetClearControlExpressions(const Value: TExpressions);
begin
  FClearControlExpressions.Assign(Value);
end;

procedure TCustomBindList.SetEditor(const Value: string);
begin
  if FEditor <> Value then
  begin
    FEditor := Value;
    if Active then
    begin
      Active := False;
      BindListEditor := nil;
      DesignAutoActivateOnPropertyChange;
    end;
  end;
end;

procedure TCustomBindList.UpdateExpressions;
var
  LExpressionItem: TExpressionItem;
  LBindingExpression: TBindingExpression;
begin
  Assert(FControlExpressionObject = nil);
  Assert(FFormatControlExpressionObjects.Count = 0);
  Assert(FClearControlExpressionObjects.Count = 0);

  if ControlComponent = nil then
    Exit;
  if SourceComponent = nil then
    Exit;


  for LExpressionItem in FClearControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );

    FClearControlExpressionObjects.Add(LBindingExpression);
  end;


  for LExpressionItem in FFormatControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent),  // output
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent), // input
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FFormatControlExpressionObjects.Add(LBindingExpression);
  end;

  FControlExpressionObject := TBindings.CreateExpression(
    inherited GetComponentScopes(ControlComponent), //Input scopes
    'Self',
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );


end;

{ TCustomBindPosition }

procedure TCustomBindPosition.CheckEditingLink;
var
  LObservers: TObservers;
  LPositionObserver: IPositionLinkObserver;
begin
  if (GetControlComponent <> nil) and (not Assigned(FPositionObserver)) then
  begin
    LObservers := GetControlComponent.Observers;
    if LObservers.CanObserve(TObserverMapping.PositionLinkID) then
    begin
      LPositionObserver := TBindPositionLinkObserver.Create(Self);
      LObservers.AddObserver(TObserverMapping.PositionLinkID, LPositionObserver);
      FPositionObserver := LPositionObserver;
    end;
  end;
end;

procedure TCustomBindPosition.ClearEditingLink;
begin
  try
    if Assigned(ControlComponent) then
    begin
      if FPositionObserver <> nil then
        ControlComponent.Observers.RemoveObserver(TObserverMapping.PositionLinkID, FPositionObserver);
    end;
  finally
    FPositionObserver := nil;
  end;
end;

constructor TCustomBindPosition.Create(AOwner: TComponent);
begin
  inherited;
  FPosSourceExpressions := TExpressions.Create(Self, TExpressionItem);
  FPosControlExpressions := TExpressions.Create(Self, TExpressionItem);
  FPosClearExpressions := TExpressions.Create(Self, TExpressionItem);

  FPosControlExpressionObjects := TList<TBindingExpression>.Create;
  FPosSourceExpressionObjects := TList<TBindingExpression>.Create;
  FPosClearExpressionObjects := TList<TBindingExpression>.Create;
end;

destructor TCustomBindPosition.Destroy;
begin
  ClearEditingLink;
  FreeExpressionsObjects;
  FPosSourceExpressions.Free;
  FPosControlExpressions.Free;
  FPosClearExpressions.Free;

  FPosControlExpressionObjects.Free;
  FPosSourceExpressionObjects.Free;
  FPosClearExpressionObjects.Free;
  inherited;
end;

procedure TCustomBindPosition.FreeExpressionsObjects;
begin
  FreeExpressionObjects(FPosControlExpressionObjects);
  FreeExpressionObjects(FPosSourceExpressionObjects);
  FreeExpressionObjects(FPosClearExpressionObjects);
  FreeAndNil(FControlExpressionObject);
end;

function TCustomBindPosition.GetActive: Boolean;
begin
  Result := FActive;
end;

procedure TCustomBindPosition.Loaded;
begin
  try
    inherited;
    if FDeferActive then
    begin
      FDeferActive := False;
      SetActive(True);
    end
    else
      if CanActivate then
        LoadActivate;
  except
    // Don't raise exception when loading
  end;
end;

procedure TCustomBindPosition.PosChanged;
begin
//
  EvaluatePosSource;

end;

procedure TCustomBindPosition.PosChanging;
var
  LScopeEditLink: IScopeEditLink;
begin
  if Supports(SourceComponent, IScopeEditLink, LScopeEditLink) then
    LScopeEditLink.PosChanging(Self);
end;

function TCustomBindPosition.RequiresControlHandler: Boolean;
begin
  Result := FPosSourceExpressions.Count > 0;
end;

procedure TCustomBindPosition.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Loading then
    begin
      if not Designing then
        FDeferActive := Value
    end
    else
    begin
      if Value then
        DoOnActivating
      else
        DoOnDeactivating;
      FActive := Value;
      if FActive then
      begin
        try
          FreeExpressionsObjects;
          UpdateExpressions;
          if not Designing then
            if RequiresControlHandler then
            begin
              CheckEditingLink;
              if not Assigned(FPositionObserver) then
                raise TBindCompException.CreateFmt(sNoControlObserverSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);
            end;
          EvaluatePosControl;
        finally
          DoOnActivated;
        end;
      end
      else
      begin
        try
          if (ControlComponent <> nil) and
            (not (csDestroying in ControlComponent.ComponentState)) then
            EvaluatePosClear;
        finally
          FreeExpressionsObjects;
          DoOnDeactivated;
        end;
      end;
    end;
  end;

end;

procedure TCustomBindPosition.SetControlComponent(const Value: TComponent);
begin
  inherited;

end;

procedure TCustomBindPosition.EvaluatePosClear;
var
  LExpression: TBindingExpression;
begin
  for LExpression in FPosClearExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

procedure TCustomBindPosition.EvaluatePosControl;
var
  LExpression: TBindingExpression;
begin
  for LExpression in FPosControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

procedure TCustomBindPosition.EvaluatePosSource;
var
  LExpression: TBindingExpression;
  LScopeLocks: IScopeLocks;
begin
  Supports(Self.SourceComponent, IScopeLocks, LScopeLocks);
  if LScopeLocks <> nil then
    LScopeLocks.PosLockEnter;
  try
    for LExpression in FPosSourceExpressionObjects do
    begin
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.Evaluate;
    end;
  finally
    if LScopeLocks <> nil then
      LScopeLocks.PosLockLeave;
  end;
end;

function TCustomBindPosition.GetBindComp: TComponent;
begin
  Result := Self;
end;

procedure TCustomBindPosition.UpdateControlChanging;
begin
  inherited; //Set active false
  ClearEditingLink;
end;

procedure TCustomBindPosition.SetPosSourceExpressions(const Value: TExpressions);
begin
  FPosSourceExpressions.Assign(Value);
end;

procedure TCustomBindPosition.SetPosClearExpressions(const Value: TExpressions);
begin
  FPosClearExpressionObjects.Free;
end;

procedure TCustomBindPosition.SetPosControlExpressions(const Value: TExpressions);
begin
  FPosControlExpressions.Assign(Value);
end;

procedure TCustomBindPosition.UpdateExpressions;
var
  LExpressionItem: TExpressionItem;
  LBindingExpression: TBindingExpression;
begin
  Assert(FPosSourceExpressionObjects.Count = 0);
  Assert(FPosControlExpressionObjects.Count = 0);
  Assert(FPosClearExpressionObjects.Count = 0);
  Assert(FControlExpressionObject = nil);

  if ControlComponent = nil then
    Exit;
  if SourceComponent = nil then
    Exit;

  for LExpressionItem in FPosControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent, SourceMemberName),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );

    FPosControlExpressionObjects.Add(LBindingExpression);
  end;

  for LExpressionItem in FPosClearExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent, SourceMemberName),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );

    FPosClearExpressionObjects.Add(LBindingExpression);
  end;


  for LExpressionItem in FPosSourceExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(ControlComponent), // input
      LExpressionItem.ControlExpression,
      inherited GetComponentScopes(SourceComponent, SourceMemberName),  // output
      LExpressionItem.SourceExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FPosSourceExpressionObjects.Add(LBindingExpression);
  end;


  FControlExpressionObject := TBindings.CreateExpression(
    inherited GetComponentScopes(ControlComponent), //Input scopes
    'Self',
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );


end;

{ TCustomBindControlValue }

function TCustomBindControlValue.CanSetControlComponent(
  Value: TComponent): Boolean;
begin
  Result := False;
  if Value <> nil then
  begin
    Result := Value.Observers.CanObserve(TObserverMapping.ControlValueID);
  end;
end;

procedure TCustomBindControlValue.CheckEditingLink;
var
  LObservers: TObservers;
  LControlValueObserver: IControlValueObserver;
begin
  if (GetControlComponent <> nil) and (not Assigned(FControlValueObserver)) then
  begin
    LObservers := GetControlComponent.Observers;
    if LObservers.CanObserve(TObserverMapping.ControlValueID) then
    begin
      LControlValueObserver := TBindControlValueLinkObserver.Create(Self);
      LObservers.AddObserver(TObserverMapping.ControlValueID, LControlValueObserver);
      FControlValueObserver := LControlValueObserver;
      UpdateTrack;
    end;
  end;
end;

procedure TCustomBindControlValue.ClearEditingLink;
begin
  try
    if Assigned(ControlComponent) then
    begin
      if FControlValueObserver <> nil then
        ControlComponent.Observers.RemoveObserver(TObserverMapping.ControlValueID, FControlValueObserver);
    end;
  finally
    FControlValueObserver := nil;
  end;
end;

constructor TCustomBindControlValue.Create(AOwner: TComponent);
begin
  inherited;
  FUpdateCounter := 0;
end;

destructor TCustomBindControlValue.Destroy;
begin
  ClearEditingLink;
  inherited;
end;

function TCustomBindControlValue.GetActive: Boolean;
begin
  Result := FActive;
end;

function TCustomBindControlValue.GetTrack: Boolean;
begin
  Result := FTrack;
end;

procedure TCustomBindControlValue.Loaded;
begin
  try
    inherited;
    if FDeferActive then
    begin
      FDeferActive := False;
      SetActive(True);
    end
    else
      if CanActivate then
        LoadActivate;
  except
    // Don't raise exception when loading
  end;
end;

procedure TCustomBindControlValue.ValueChanged;
begin
  if not GetUpdating then  // Prevent a cycle
    EvaluateFormat;
end;

function TCustomBindControlValue.RequiresControlHandler: Boolean;
begin
  Result := FFormatExpressions.Count > 0;
end;

procedure TCustomBindControlValue.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Loading then
    begin
      if not Designing then
        FDeferActive := Value
    end
    else
    begin
      if Value then
        DoOnActivating
      else
        DoOnDeactivating;
      FActive := Value;
      if FActive then
      begin
          FreeExpressionsObjects;
          UpdateExpressions;
          if not Designing then
            if Value and RequiresControlHandler then
            begin
              CheckEditingLink;
              if not Assigned(FControlValueObserver) then
                raise TBindCompException.CreateFmt(sNoControlObserverSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);
            end;
          try
            EvaluateParse;
          finally
            // Ignore error on parse, which happens when the propery value
            // can't be converted to the value of a control
            DoOnActivated;
          end;
      end
      else
      begin
        try
          if (ControlComponent <> nil) and
            (not (csDestroying in ControlComponent.ComponentState)) then
            EvaluateClear;
        finally
          FreeExpressionsObjects;
          DoOnDeactivated;
        end;
      end;
    end;
  end;

end;

procedure TCustomBindControlValue.EvaluateParse;
var
  LExpression: TBindingExpression;
begin
  BeginUpdate;
  try
    for LExpression in FParseExpressionObjects do
    begin
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.Evaluate;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomBindControlValue.EvaluateClear;
var
  LExpression: TBindingExpression;
begin
  BeginUpdate;
  try
    for LExpression in FClearExpressionObjects do
    begin
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.Evaluate;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomBindControlValue.EvaluateFormat;
var
  LExpression: TBindingExpression;
begin
  BeginUpdate;
  try
    for LExpression in FFormatExpressionObjects do
    begin
      if LExpression.Compiled then  // In case binding manager has been destroyed
      begin
        LExpression.Evaluate;
        NotifyDependentOutputs(LExpression);
      end;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomBindControlValue.BeginUpdate;
begin
  Inc(FUpdateCounter);
end;

procedure TCustomBindControlValue.EndUpdate;
begin
  Dec(FUpdateCounter);
  if FUpdateCounter < 0 then
    FUpdateCounter := 0;
end;

function TCustomBindControlValue.GetUpdating: Boolean;
begin
  Result := FUpdateCounter > 0;
end;

procedure TCustomBindControlValue.UpdateControlChanging;
begin
  inherited; //Set active false
  ClearEditingLink;
end;

procedure TCustomBindControlValue.UpdateTrack;
begin
  if FControlValueObserver <> nil then
    if FControlValueObserver is TBindControlValueLinkObserver then
      TBindControlValueLinkObserver(FControlValueObserver).SetTrack(FTrack);
end;

procedure TCustomBindControlValue.SetTrack(const Value: Boolean);
begin
  if FTrack <> Value then
  begin
    FTrack := Value;
    UpdateTrack;
  end;
end;

procedure TCustomBindControlValue.UpdateExpressions;
var
  LExpressionItem: TExpressionItem;
  LBindingExpression: TBindingExpression;
begin
  Assert(FFormatExpressionObjects.Count = 0);
  Assert(FParseExpressionObjects.Count = 0);
  Assert(FClearExpressionObjects.Count = 0);
  Assert(FControlExpressionObject = nil);

  if ControlComponent = nil then
    Exit;
  if SourceComponent = nil then
    Exit;

  for LExpressionItem in FParseExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent, SourceMemberName),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );

    FParseExpressionObjects.Add(LBindingExpression);
  end;

  for LExpressionItem in FClearExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent, SourceMemberName),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );

    FClearExpressionObjects.Add(LBindingExpression);
  end;

  for LExpressionItem in FFormatExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(ControlComponent), // input
      LExpressionItem.ControlExpression,
      inherited GetComponentScopes(SourceComponent, SourceMemberName),  // output
      LExpressionItem.SourceExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );

    AddDependency(LBindingExpression,
      procedure(ABinding: TExpressionsBindComponent)
      begin
        assert(ABinding is TCustomBindControlValue);
        if not TCustomBindControlValue(ABinding).GetUpdating then
          TCustomBindControlValue(ABinding).EvaluateFormat;
      end,
      ControlComponent, '', LExpressionItem.ControlExpression, SourceComponent);
    FFormatExpressionObjects.Add(LBindingExpression);
  end;


  FControlExpressionObject := TBindings.CreateExpression(
    inherited GetComponentScopes(ControlComponent), //Input scopes
    'Self',
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );


end;


{ TExpressionDirEnumerator }

function TExpressionDirEnumerator.GetCurrent: TExpressionItemDir;
begin
  Result := TExpressionItemDir(inherited GetCurrent);
end;

procedure RegisterBindEditorFactory(AFactories: array of TBindEditorFactoryClass);
var
  LClass: TBindEditorFactoryClass;
begin
  for LClass in AFactories do
    FEditorFactories.Add(LClass);
end;

procedure UnregisterBindEditorFactory(AFactories: array of TBindEditorFactoryClass);
var
  LClass: TBindEditorFactoryClass;
begin
  for LClass in AFactories do
      FEditorFactories.Remove(LClass);
end;

procedure RegisterObservableMember(AClass: TClass; const APropertyName: string; const AFrameworkExt: string); overload;
var
  LValuePropertyNameRec: TValuePropertyNameRec;
begin
  if FValuePropertyNames.TryGetValue(AClass, LValuePropertyNameRec) then
  begin
    LValuePropertyNameRec.FPropertyName := APropertyName;
    LValuePropertyNameRec.FFrameworkExt := AFrameworkExt;
    Include(LValuePropertyNameRec.FOptions, vpObservable);
    FValuePropertyNames[AClass] := LValuePropertyNameRec;
  end
  else
    FValuePropertyNames.Add(AClass, TValuePropertyNameRec.Create(APropertyName, AFrameworkExt, [vpObservable]));
end;

procedure RegisterObservableMember(AClasses: TArray<TClass>; const APropertyName: string; const AFrameworkExt: string);
var
  LClass: TClass;
begin
  for LClass in AClasses do
  begin
    RegisterObservableMember(LClass, APropertyName, AFrameWorkExt);
  end;
end;


procedure RegisterObservableMemberOptions(AClass: TClass; AOptions: TObservableMemberOptions); overload;
var
  LValuePropertyNameRec: TValuePropertyNameRec;
  LValuePropertyOptions: TValuePropertyOptions;
begin
  LValuePropertyOptions := [];
  if TObservableMemberOption.moTrack in AOptions then
    Include(LValuePropertyOptions, vpTrack);
  if FValuePropertyNames.TryGetValue(AClass, LValuePropertyNameRec) then
  begin
    LValuePropertyNameRec.FOptions := LValuePropertyNameRec.FOptions + LValuePropertyOptions;
    FValuePropertyNames[AClass] := LValuePropertyNameRec;
  end
  else
    FValuePropertyNames.Add(AClass, TValuePropertyNameRec.Create('', '', LValuePropertyOptions));
end;

procedure RegisterObservableMemberOptions(AClasses: TArray<TClass>; AOptions: TObservableMemberOptions);
var
  LClass: TClass;
begin
  for LClass in AClasses do
  begin
    RegisterObservableMemberOptions(LClass, AOptions);
  end;
end;


procedure RegisterValuePropertyName(AClass: TClass; const APropertyName: string; const AFrameWorkExt: string); overload;
begin
  if not FValuePropertyNames.ContainsKey(AClass) then
    FValuePropertyNames.Add(AClass, TValuePropertyNameRec.Create(APropertyName, AFrameWorkExt, [])); // Not observerable
end;

procedure RegisterValuePropertyName(AClasses: TArray<TClass>; const APropertyName: string; const AFrameWorkExt: string);
var
  LClass: TClass;
begin
  for LClass in AClasses do
  begin
    RegisterValuePropertyName(LClass, APropertyName, AFrameWorkExt);
  end;
end;

procedure UnregisterValuePropertyName(AClasses: TArray<TClass>);
var
  LClass: TClass;
begin
  for LClass in AClasses do
  begin
    try
      if FValuePropertyNames.ContainsKey(LClass) then
        FValuePropertyNames.Remove(LClass);
    except
      // ignore so that we unregister all classes
    end;
  end;
end;

procedure UnregisterObservableMember(AClasses: TArray<TClass>);
var
  LClass: TClass;
begin
  for LClass in AClasses do
  begin
    try
      if FValuePropertyNames.ContainsKey(LClass) then
        FValuePropertyNames.Remove(LClass);
    except
      // Continue unregistering
    end;
  end;
end;

procedure UnregisterObservableMemberOptions(AClasses: TArray<TClass>);
var
  LClass: TClass;
  LValuePropertyNameRec: TValuePropertyNameRec;
begin
  for LClass in AClasses do
  begin
    try
      if FValuePropertyNames.TryGetValue(LClass, LValuePropertyNameRec) then
        // Let UnregisterObservableMember remove it
        if not (vpObservable in LValuePropertyNameRec.FOptions) then
          FValuePropertyNames.Remove(LClass);
    except
      // ignore so that we unregister all classes
    end;
  end;
end;


procedure RegisterListItemValueExpression(AClass: TClass; const AExpression: string;
  const AHeaderExpression: string); overload;
begin
  Assert(not FListItemValueExpressions.ContainsKey(AClass));
  FListItemValueExpressions.AddOrSetValue(AClass, TListItemExpressionRec.Create(AExpression,
    AHeaderExpression));
end;

procedure RegisterListItemValueExpression(AClasses: TArray<TClass>; const AExpression: string;
  const AHeaderExpression: string);
var
  LClass: TClass;
begin
  for LClass in AClasses do
    RegisterListItemValueExpression(LClass, AExpression, AHeaderExpression);
end;

procedure UnregisterListItemValueExpression(AClasses: TArray<TClass>);
var
  LClass: TClass;
begin
  for LClass in AClasses do
  begin
    try
      Assert(FListItemValueExpressions.ContainsKey(LClass));
      FListItemValueExpressions.Remove(LClass);
    except
      // ignore so that we unregister all classes
    end;
  end;
end;

{ TBindEditorFactory }

constructor TBindEditorFactory.Create;
begin
//
end;

function TBindEditorFactory.CreateNamedEditor(AIntf: TGuid; const AName: string;
  AObject: TObject): IInterface;
begin
  if AName = '' then
    Result := CreateEditor(AIntf, AObject)
  else
    raise EBindCompError.CreateFmt(sUnknownEditor, [AName]);
end;

function TBindEditorFactory.ReleaseEditor(const AEditor: IInterface): Boolean;
begin
  // Ancestor may override
  Result := False;
end;

function TBindEditorFactory.GetNames: TArray<string>;
begin
  Result := nil;
end;

function TBindEditorFactory.HasNamedEditor(const AName: string): Boolean;
begin
  Result := AName = '';
end;

{ TBindEventListT }

procedure TBindEventListT.InternalAdd(AEvent: TNotifyEvent);
begin
  FList.Add(AEvent);
end;

constructor TBindEventListT.Create;
begin
  FList := TList<TNotifyEvent>.Create;
end;

destructor TBindEventListT.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TBindEventListT.InternalRemove(AEvent: TNotifyEvent);
begin
  FList.Remove(AEvent);
end;

{ TBindCompDesignExpressionCollection }

constructor TBindCompDesignExpressionCollection.Create(const AName: string;
  ACollection: TCollection; AParentCollectionItem: TCollectionItem;
  ACollectionType: TBindCompDesignerCollectionType);
begin
  FName := AName;
  FCollection := ACollection;
  FParentCollectionItem := AParentCollectionItem;
  FCollectionType := ACollectionType;
end;

{ TCustomBindGridList }

constructor TCustomBindGridList.Create(AOwner: TComponent);
begin
  inherited;
  FBreakGroups := TFillBreakGroups.Create(Self, TFillBreakGroupItem);
  FColumnExpressions := TColumnFormatExpressions.Create(Self, TColumnFormatExpressionItem);

  FFormatControlExpressions := TExpressions.Create(Self, TExpressionItem);
  FClearControlExpressions := TExpressions.Create(Self, TExpressionItem);

  FFormatControlExpressionObjects := TList<TBindingExpression>.Create;
  FClearControlExpressionObjects := TList<TBindingExpression>.Create;
  FAutoFill := True;
  FDeprecatedBufferCount := -1;
end;

procedure TCustomBindGridList.DefineProperties(Filer: TFiler);
begin
  inherited;
  // For backwards compatibility
  ReadBufferProperties(Filer);
end;

destructor TCustomBindGridList.Destroy;
begin
  BindListEditor := nil; // Release editor
  FBreakGroups.Free;
  FreeExpressionsObjects;
  FColumnExpressions.Free;

  FFormatControlExpressions.Free;
  FClearControlExpressions.Free;

  FFormatControlExpressionObjects.Free;
  FClearControlExpressionObjects.Free;
  inherited;
end;


procedure TCustomBindGridList.DoFilledRecord(const AEditor: IBindListEditor);
var
  LItem: IBindListEditorItem;
begin
  if Assigned(FOnFilledRecord) then
    if Supports(AEditor, IBindListEditorItem, LItem) then
      FOnFilledRecord(Self, LItem);
end;

procedure TCustomBindGridList.DoFilledRecords;
begin
  if Assigned(FOnFilledRecords) then
    FOnFilledRecords(Self);
end;

procedure TCustomBindGridList.DoFillingRecord(const AEditor: IBindListEditor);
var
  LItem: IBindListEditorItem;
begin
  if Assigned(FOnFillingRecord) then
    if Supports(AEditor, IBindListEditorItem, LItem) then
      FOnFillingRecord(Self, LItem);
end;


procedure TCustomBindGridList.DoFillingRecords;
begin
  if Assigned(FOnFillingRecords) then
    FOnFillingRecords(Self);
end;

function TCustomBindGridList.GetActive: Boolean;
begin
  Result := FActive;
end;

function TCustomBindGridList.GetBindListEditor: IBindListEditorCommon;
begin
  CheckControlComponent;
  if not TryGetBindListEditor(Result) then
    if ListItemStyle = '' then
      raise TBindCompException.CreateFmt(sNoListEditor, [Self.GetDisplayName, SafeClassName(ControlComponent)])
    else
      raise TBindCompException.CreateFmt(sNoNamedListEditor, [Self.GetDisplayName, SafeClassName(ControlComponent), ListItemStyle]);
end;

function TCustomBindGridList.TryGetBindListEditor(out AEditor: IBindListEditorCommon): Boolean;
var
  LEditor: IInterface;
begin
  AEditor := nil;
  if (ControlComponent <> nil) and
    Supports(GetBindEditor(ControlComponent, IBindListEditorCommon, Self.ListItemStyle), IBindListEditorCommon, LEditor) then
    AEditor := LEditor as IBindListEditorCommon;
  Result := AEditor <> nil;
end;

function TCustomBindGridList.GetScopeRecordEnumerator: IScopeRecordEnumerator;
begin
  Result := Data.Bind.Components.GetScopeRecordEnumerator(SourceComponent, IsLinked);
end;

procedure TCustomBindGridList.FillList;
var
  LEditor: IBindListEditor;
  LSynchEditor: IBindListSynchEditor;
begin
  DoFillingRecords;
  try
    Supports(GetBindListEditor, IBindListEditor, LEditor);
    if LEditor <> nil then
    begin
      EvaluateFormatControl;
      FormatColumns;
      FillRecords(LEditor);
      if Supports(LEditor, IBindListSynchEditor, LSynchEditor) then
      begin
        // Be sure the ItemIndex is in range before applying filter
        // This code will set ListView.ItemIndex to valid value, if it is out of range
        LSynchEditor.SynchIndex := LSynchEditor.SynchIndex;

        LSynchEditor.ApplyFilter;
      end;
    end
  finally
    DoFilledRecords;
  end;
end;

function TCustomBindGridList.CanInsert: Boolean;
var
  LEditor: IBindListEditor;
begin
  if Supports(GetBindListEditor, IBindListEditor, LEditor) then
    Result := LEditor.CanInsertItem
  else
    Result := False;
end;

function TCustomBindGridList.CanUpdate: Boolean;
var
  LEditor: IBindListEditor;
begin
  if Supports(GetBindListEditor, IBindListEditor, LEditor) then
    Result := LEditor.CurrentItem <> nil
  else
    Result := False;
end;

procedure TCustomBindGridList.InsertItem(Select: Boolean);
var
  LEditor: IBindListEditor;
  LScope: IScope;
begin
  if not Supports(GetBindListEditor, IBindListEditor, LEditor) then
    raise TBindCompException.CreateFmt(sNoInsertItem, [Self.GetDisplayName, ControlComponent.ClassName]);
  if LEditor <> nil then
  begin
    LEditor.BeginUpdate;
    try
      LScope := LEditor.InsertItem(Select);
      if LScope <> nil then
      begin
        FillRecord2(LEditor);
      end
      else
        raise TBindCompException.CreateFmt(sNoInsertItem, [Self.GetDisplayName, SourceComponent.ClassName]);
    finally
      LEditor.EndUpdate;
    end;

  end
end;

function TCustomBindGridList.IsLinked: Boolean;
begin
  Result := False;
end;

procedure TCustomBindGridList.AddItem(Select: Boolean);
var
  LEditor: IBindListEditor;
  LScope: IScope;
begin
  if not Supports(GetBindListEditor, IBindListEditor, LEditor) then
    raise TBindCompException.CreateFmt(sNoInsertItem, [Self.GetDisplayName, ControlComponent.ClassName]);
  if LEditor <> nil then
  begin
    LScope := LEditor.AddItem(Select);
    if LScope <> nil then
      if LScope <> nil then
      begin
        FillRecord2(LEditor);
      end
    else
      raise TBindCompException.CreateFmt(sNoEnumerator, [Self.GetDisplayName, SourceComponent.ClassName]);
  end
end;

procedure TCustomBindGridList.UpdateItem;
var
  LEditor: IBindListEditor;
  LScope: IScope;
begin
  Supports(GetBindListEditor, IBindListEditor, LEditor);
  if LEditor <> nil then
  begin
    LScope := LEditor.CurrentItem;
    if LScope <> nil then
    begin
      FillRecord2(LEditor);
    end
    else
      raise TBindCompException.CreateFmt(sNoEnumerator, [Self.GetDisplayName, SourceComponent.ClassName]);
  end
end;

procedure TCustomBindGridList.GetBindingExpressions(const AEnumerator: IScopeRecordEnumerator; const AEditor: IBindListEditor;
  ACallback: TProc<TArrayListCellExpression>);
var
  LColumnLinkExpressionItem: TColumnFormatExpressionItem;
  LBindingExpressions: TObjectList<TList<TEvalEnumeratorToEditor>>;
  LList: TList<TEvalEnumeratorToEditor>;
  LExpressions: TExpressions;
  LExpression: TExpressionItem;
begin
  LBindingExpressions := TObjectList<TList<TEvalEnumeratorToEditor>>.Create();
  try
    for LColumnLinkExpressionItem in FColumnExpressions do
    begin
      LList := TObjectList<TEvalEnumeratorToEditor>.Create;
      LBindingExpressions.Add(LList);
      if LColumnLinkExpressionItem.FormatCellExpressions.Count > 0 then
        LExpressions := LColumnLinkExpressionItem.FormatCellExpressions
      else
        LExpressions := nil;
      if LExpressions <> nil then
      begin
        for LExpression in LExpressions do
        begin
          LList.Add(
            TEvalEnumeratorToEditor.Create(
              GetUseEvalShortcuts,
              AEnumerator,
              //LExpression.SourceExpression,
              LColumnLinkExpressionItem.SourceMemberName,
              AEditor, //Output destination(s)
              LExpression.ControlExpression,
              LExpression.Custom,
              DoOnEvalError,
            TBindings.CreateUnmanagedBinding(
              GetComponentScopes(AEnumerator.GetMemberCurrent(LColumnLinkExpressionItem.SourceMemberName)),
              LExpression.SourceExpression,
              inherited GetComponentScopes(AEditor.CurrentItem), //Output destination(s)
              LExpression.ControlExpression,
              GetOutputConverter,
              TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
              [])));
        end;
      end;

    end;
    ACallback(LBindingExpressions.ToArray);
  finally
    LBindingExpressions.Free;
  end;
end;

const
  // Scripting object to access current break item
  sFillBreakGroupItem = 'FillBreakGroup';

type
  TCurrentFillBreakGroupItem = class
  private
    FItem: TFillBreakGroupItem;
    function GetItem: TFillBreakGroupItem;
    function GetDisplayText: string;
  public
    property Item: TFillBreakGroupItem read GetItem;
    property DisplayText: string read GetDisplayText;
  end;
procedure TCustomBindGridList.GetBindingExpressions(const AEnumerator: IScopeRecordEnumerator; const AEditor: IBindListEditor;
  ACallback: TProc<TArrayListCellExpression, TArrayListCellExpression, TEvalEnumerator,
    TObject>);

  procedure Add(AColumnLinkExpressionItem: TColumnFormatExpressionItem;
    AExpressions: TExpressions; LList: TList<TEvalEnumeratorToEditor>; const AItemScope: IScope;
    AFillBreakGroupItem: TObject);
  var
    LExpression: TExpressionItem;
    LScopes: TArray<IScope>;
    LScope: TDictionaryScope;
  begin
    if AExpressions <> nil then
    begin
      for LExpression in AExpressions do
      begin
        LScopes :=
          GetComponentScopes(AEnumerator.GetMemberCurrent(AColumnLinkExpressionItem.SourceMemberName));
        if AFillBreakGroupItem <> nil then
        begin
          // Add object to access current FillBreakItem
          LScope := TDictionaryScope.Create;
          LScope.Map.Add(sFillBreakGroupItem, WrapObject(AFillBreakGroupItem));
          SetLength(LScopes, Length(LScopes)+1);
          LScopes[Length(LScopes)-1] := LScope;
        end;

        LList.Add(
          TEvalEnumeratorToEditor.Create(
          GetUseEvalShortcuts,
          AEnumerator,
          AColumnLinkExpressionItem.SourceMemberName,
          // LExpression.SourceExpression,
          AEditor,
          LExpression.ControlExpression,
          LExpression.Custom,
          DoOnEvalError,
          TBindings.CreateUnmanagedBinding(
            LScopes,
            LExpression.SourceExpression,
            inherited GetComponentScopes(AItemScope),
            LExpression.ControlExpression,
            GetOutputConverter,
            TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
            [])));
      end;
    end;
  end;
var
  LColumnLinkExpressionItem: TColumnFormatExpressionItem;
  LBindingExpressions: TObjectList<TList<TEvalEnumeratorToEditor>>;
  LHeaderBindingExpressions: TObjectList<TList<TEvalEnumeratorToEditor>>;
  LList: TList<TEvalEnumeratorToEditor>;
  LBreakExpression: TEvalEnumerator;
  LBindingExpressionArray: TArrayListCellExpression;
  LHeaderBindingExpressionArray: TArrayListCellExpression;
  LBindFillControlMembers: IBindFillControlMembers;
  LCurrentFillBreakItem: TCurrentFillBreakGroupItem;
begin
  LHeaderBindingExpressions := nil;
  LBindingExpressions := nil;
  LBreakExpression := nil;
  if (not DisableBreakGroups) and (Self.BreakGroups.Count > 0) and ((FBreakMemberName <> '') or (BreakExpression <> '')) then
    LCurrentFillBreakItem := TCurrentFillBreakGroupItem.Create
  else
    LCurrentFillBreakItem := nil;

  Supports(AEditor, IBindFillControlMembers, LBindFillControlMembers);
  try
    for LColumnLinkExpressionItem in FColumnExpressions do
    begin
      if LColumnLinkExpressionItem.FormatCellExpressions.Count > 0 then
      begin
        if LBindingExpressions = nil then
        begin
          LBindingExpressions := TObjectList<TList<TEvalEnumeratorToEditor>>.Create();
        end;
        LList := TObjectList<TEvalEnumeratorToEditor>.Create;
        LBindingExpressions.Add(LList);
        Add(LColumnLinkExpressionItem, LColumnLinkExpressionItem.FormatCellExpressions, LList,
          AEditor.CurrentItem, nil);
      end;
      if (LColumnLinkExpressionItem.FormatCellHeaderExpressions.Count > 0) and
        (LBindFillControlMembers <> nil) then
      begin
        if LHeaderBindingExpressions = nil then
        begin
          LHeaderBindingExpressions := TObjectList<TList<TEvalEnumeratorToEditor>>.Create();
        end;
        LList := TObjectList<TEvalEnumeratorToEditor>.Create;
        LHeaderBindingExpressions.Add(LList);
        Add(LColumnLinkExpressionItem, LColumnLinkExpressionItem.FormatCellHeaderExpressions, LList,
          LBindFillControlMembers.CurrentHeaderItem,
            LCurrentFillBreakItem);
      end;
    end;
    if (FBreakMemberName <> '') or (BreakExpression <> '') then
    begin
                                     
      Assert(FBreakMemberName <> sWildcard);
      Assert(BreakExpression <> '');
      LBreakExpression := TEvalEnumerator.Create(
            GetUseEvalShortcuts,
            AEnumerator,
            FBreakMemberName,
            FBreakCustom,
            DoOnEvalError,
            TBindings.CreateExpression(
            GetComponentScopes(AEnumerator.GetMemberCurrent(FBreakMemberName)),
            BreakExpression,
            TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)));
    end;
    if LHeaderBindingExpressions <> nil then
      LHeaderBindingExpressionArray := LHeaderBindingExpressions.ToArray
    else
      LHeaderBindingExpressionArray := nil;
    if LBindingExpressions <> nil then
      LBindingExpressionArray := LBindingExpressions.ToArray
    else
      LBindingExpressionArray := nil;

    ACallback(LBindingExpressionArray, LHeaderBindingExpressionArray, LBreakExpression,
      LCurrentFillBreakItem);
  finally
    LBindingExpressions.Free;
    LHeaderBindingExpressions.Free;
    LBreakExpression.Free;
    LCurrentFillBreakItem.Free;
  end;
end;

procedure LocalFill(AExpressions: TCustomBindGridList.TArrayListCellExpression);
var
  LExpression: TEvalEnumeratorToEditor;
  LExpressions: TList<TEvalEnumeratorToEditor>;
begin
  for LExpressions in  AExpressions do
    for LExpression in LExpressions do
      LExpression.Evaluate;
end;

procedure TCustomBindGridList.FillRecords(const AEditor: IBindListEditor);
  function GetEnumerator: IScopeRecordEnumerator;
  begin
    Result := GetScopeRecordEnumerator;
  end;
var
  LEnumerator: IScopeRecordEnumerator;
  LGroupEditor: IBindListGroupEditor;
  LPrevValue: TValue;
  LBOF: Boolean;
begin
  LBOF := True;
  LEnumerator := GetEnumerator; // GetScopeRecordEnumerator;
  try
  if LEnumerator <> nil then
  begin
    Supports(AEditor, IBindListGroupEditor, LGroupEditor);
    if LGroupEditor <> nil then
    begin
      GetBindingExpressions(LEnumerator, AEditor,
        procedure(AExpressions, AHeaderExpressions: TArrayListCellExpression;     // Callback
          ABreakExpression: TEvalEnumerator;
          ACurrentBreakGroupItem: TObject)
        var
          LFormatCallback: TFormatCallback;
        begin
          if ABreakExpression = nil then
            AEditor.FillList(LEnumerator,
              procedure(const ASourceScope, AEditorScope: IScope)
              begin
                Assert(AEditorScope <> nil);
                FillRecord(AEditor,
                  procedure()
                  begin
                    LocalFill(AExpressions);
                  end);
              end)
          else
          begin
            LFormatCallback :=
                procedure(const ASourceScope, AEditorScope: IScope)
                begin
                  Assert(AEditorScope <> nil);
                  FillRecord(AEditor,
                    procedure()
                    begin
                      LocalFill(AExpressions);
                    end);
                end;
            if (Length(AHeaderExpressions) > 0) and
                (Length(AExpressions) = 0) then
                LFormatCallback := nil; // Only headers

            LGroupEditor.FillGroupList(LEnumerator,
                LFormatCallback,                                       // AFormatProc
                procedure(const ASourceScope, AEditorScope: IScope)    // AFormatHeaderProc
                begin
                  Assert(AEditorScope <> nil);
                  FillHeaderRecord(AEditor,
                    procedure()
                    begin
                      LocalFill(AHeaderExpressions);
                    end);
                 end,
                function(const ASourceScope: IScope): Boolean          // AQueryBreakProc
                var
                  LValueGetValue: TValue;
                  LHaveValue: Boolean;
                  LString, LPrevString: string;
                  LNextItem: TFillBreakGroupItem;
                begin
                  Result := False;
                  if Assigned(ABreakExpression) then
                  begin
                      LHaveValue := ABreakExpression.Evaluate([TScopeMemberType.mtInteger, TScopeMemberType.mtFloat, TScopeMemberType.mtText], LValueGetValue);
                      if LHaveValue and (LValueGetValue.IsObject) then
                         if LValueGetValue.AsObject is TStrings then
                           TConverterUtils.StringsToString(LValueGetValue, LValueGetValue)
                         else
                           if LValueGetValue.AsObject is TPersistent then
                             TConverterUtils.PersistentToString(LValueGetValue,  LValueGetValue)
                           else
                             LHaveValue := False;

                      if ACurrentBreakGroupItem <> nil then
                      begin
                        if not LHaveValue then
                          LNextItem :=
                            BreakGroups.FindItem(
                              TValue.Empty)
                        else
                          LNextItem :=
                            BreakGroups.FindItem(
                              LValueGetValue);
                        Result := TCurrentFillBreakGroupItem(ACurrentBreakGroupItem).FItem <> LNextItem;
                        TCurrentFillBreakGroupItem(ACurrentBreakGroupItem).FItem := LNextItem;
                      end
                      else
                      begin
                        if LHaveValue then
                        begin
                          if LValueGetValue.TryAsType<string>(LString) then
                          begin
                            if LPrevValue.TryAsType<string>(LPrevString) then
                            begin
                              // Case sensitive compare
                              Result := not SameStr(LString, LPrevString);
                            end
                            else
                              Result := True;
                            if Result then
                              LPrevValue := LString;
                          end
                          else
                          begin
                            LString := LValueGetValue.ToString;
                            LPrevString := LPrevValue.ToString;
                            Result := not SameStr(LString, LPrevString);
                            if Result then
                              LPrevValue := LString;
                          end;
                        end
                        else
                          LPrevValue := TValue.Empty;
                      end;
                  end;
                  LBOF := False;
                end
                )
          end;
        end);
    end
    else
    begin
      GetBindingExpressions(LEnumerator, AEditor,
        procedure(AExpressions: TArrayListCellExpression)
        begin
          AEditor.FillList(LEnumerator,
            procedure(const ASourceScope, AEditorScope: IScope)
            begin
              Assert(AEditorScope <> nil);
              FillRecord(AEditor,
                procedure()
                begin
                  LocalFill(AExpressions);
                end);
            end);
        end);
    end;
  end
  else
    Assert(False);
  finally
    LEnumerator := nil;
  end;
end;

procedure TCustomBindGridList.FillRecord2(const AEditor: IBindListEditor);
var
  LEnumerator: IScopeRecordEnumerator;
begin
  LEnumerator := GetScopeRecordEnumerator;
  if LEnumerator <> nil then
    GetBindingExpressions(LEnumerator, AEditor,
      procedure(AExpressions: TArrayListCellExpression)
      begin
            FillRecord(AEditor,
              procedure()
              begin
                LocalFill(AExpressions);
              end);
      end);
end;


procedure TCustomBindGridList.FormatColumns;
var
  LExpression: TExpressionItem;
  LColumnExpressionItem: TColumnFormatExpressionItem;
  I: Integer;
  LExpressions: TExpressions;
  LEditorScope: IScope;
begin
  for I := 0 to FColumnExpressions.Count - 1 do
  begin
    LColumnExpressionItem := FColumnExpressions[I];
    LEditorScope := GetComponentScope(Self.ControlComponent);
    if LColumnExpressionItem.FormatColumnExpressions.Count > 0 then
      LExpressions := LColumnExpressionItem.FormatColumnExpressions
    else
      LExpressions := nil;
    if LExpressions <> nil then
    begin
      for LExpression in LExpressions do
        EvaluateExpressions(LColumnExpressionItem,
           LEditorScope, LExpression.FControlExpression,
           GetComponentScope(SourceComponent, LColumnExpressionItem.SourceMemberName), LExpression.FSourceExpression
           );
    end;
  end;
end;

procedure TCustomBindGridList.FillRecord(
  const AEditor: IBindListEditor; //AEditorScope: IScope;
  AEvaluate: TProc);
begin
  DoFillingRecord(AEditor);
  try
    AEvaluate;
  finally
    DoFilledRecord(AEditor);
  end;
end;

procedure TCustomBindGridList.FillHeaderRecord(
  const AEditor: IBindListEditor; //AEditorScope: IScope;
  AEvaluate: TProc);
begin
  DoFillingRecord(AEditor);
  try
    AEvaluate;
  finally
    DoFilledRecord(AEditor);
  end;
end;

procedure TCustomBindGridList.EvaluateExpressionItem(AColumnExpressionItem: TColumnFormatExpressionItem; AItem: TExpressionItem; AEditorScope: IScope;
  AEnumScope: IScope);
begin
  EvaluateExpressions(AColumnExpressionItem, AEditorScope, AItem.ControlExpression, AEnumScope, AItem.SourceExpression);
end;

procedure TCustomBindGridList.EvaluateExpressions(AColumnExpressionItem: TColumnFormatExpressionItem; AEditorScope: IScope; const AEditorExpression: string;
  AEnumScope: IScope; const AEnumExpression: string);
var
  LExpression: TBindingExpression;
begin
                                                     
  LExpression := TBindings.CreateUnmanagedBinding(
    GetComponentScopes(AEnumScope),
    AEnumExpression,
    inherited GetComponentScopes(AEditorScope), //Output destination(s)
    AEditorExpression,
    GetOutputConverter,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
    []  // Execute
  );
  try
    LExpression.Evaluate;
  finally
    LExpression.Free;
  end;
end;

procedure TCustomBindGridList.ClearList;
var
  LEditor: IBindListEditorCommon;
begin
  LEditor := GetBindListEditor;
  LEditor.BeginUpdate;
  try
    LEditor.ClearList;
    EvaluateClearControl;
  finally
    LEditor.EndUpdate;
  end;
end;

procedure TCustomBindGridList.EvaluateControlExpression(AColumnExpressionItem: TColumnFormatExpressionItem;
  const AExpression: string; ACallback: TProc<IValue>; AType: TBindCompExpressionType);
var
  LEditor: IBindListEditor;
  LScope: IScope;
begin
  if AType = TBindCompExpressionType.exprFormatColumn then
  begin
    inherited EvaluateControlExpression(AExpression, ACallback, AType);
  end
  else
  begin
    Supports(GetBindListEditor, IBindListEditor, LEditor);
    if LEditor <> nil then
    begin
      LScope := LEditor.CurrentItem;
      if LScope = nil then
      begin
        if LEditor.MoveNext then
          LScope := LEditor.CurrentItem
        else
          LScope := LEditor.AddItem;
      end;
      Assert(LScope <> nil);
      if LScope <> nil then
      begin
        EvaluateControlExpression(LScope, AExpression, ACallback);
      end;
    end;
  end;
end;

procedure TCustomBindGridList.ExecuteAssignToControlExpression(AColumnExpressionItem: TColumnFormatExpressionItem;
  const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
var
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
  LEditorScope: IScope;
  LScope: IScope;
begin
  if AType = TBindCompExpressionType.exprFormatColumn then
  begin
    LEditorScope := GetComponentScope(ControlComponent);
    LScope := GetComponentScope(SourceComponent, AColumnExpressionItem.SourceMemberName);
    EvaluateExpressions(AColumnExpressionItem, LEditorScope, AControlExpression, LScope, ASourceExpression);
  end
  else
  begin
    Supports(GetBindListEditor, IBindListEditor, LEditor);
    if LEditor <> nil then
    begin
      LEditor.BeginUpdate;
      try
        LEnumerator := GetScopeRecordEnumerator;
        if LEnumerator <> nil then
        begin
          if LEnumerator.MoveNext then
          begin

            LScope := LEditor.CurrentItem;
            if LScope = nil then
            begin
              if LEditor.MoveNext then
                LScope := LEditor.CurrentItem
              else
                LScope := LEditor.AddItem;
            end;
            if LEditorScope <> nil then
            begin
              EvaluateExpressions(AColumnExpressionItem, LEditorScope, AControlExpression, LEnumerator.Current, ASourceExpression);
            end;
          end;
        end
        else
          Assert(False);
      finally
        LEditor.EndUpdate;
      end;
    end;
  end
end;

procedure TCustomBindGridList.EvaluateSourceExpression(AColumnExpressionItem: TColumnFormatExpressionItem;
  const AExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
var
  LEnumerator: IScopeRecordEnumerator;
begin
  if AType = TBindCompExpressionType.exprFormatColumn then
  begin

  end
  else
  begin
    LEnumerator := GetScopeRecordEnumerator;
    if LEnumerator <> nil then
    begin
      if LEnumerator.MoveNext then
      begin
        EvaluateSourceExpression(
          LEnumerator.GetMemberCurrent(AColumnExpressionItem.SourceMemberName), AExpression,
            ACallback);
      end;
    end
    else
      Assert(False);
  end
end;

procedure TCustomBindGridList.EvaluateSourceExpression(
  AEnumScope: IScope; const AEnumExpression: string; ACallback: TProc<IValue>);
var
  LExpression: TBindingExpression;
begin
  LExpression := TBindings.CreateExpression(
    inherited GetComponentScopes(AEnumScope),
    AEnumExpression,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
  try
    ACallback(LExpression.Evaluate);
  finally
    LExpression.Free;
  end;
end;

procedure TCustomBindGridList.ExecuteAssignToSourceExpression(AColumnExpressionItem: TColumnFormatExpressionItem;
  const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>; AType: TBindCompExpressionType);
var
  LExpression: TBindingExpression;
begin
  LExpression := TBindings.CreateUnmanagedBinding(
    GetcontrolScopes(AColumnExpressionItem),
    AControlExpression,
    GetSourceScopes(AColumnExpressionItem),  //Output destination(s)
    ASourceExpression,
    GetOutputConverter,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
    []  // Execute
  );
  try
    ACallback(LExpression.Evaluate);
  finally
    LExpression.Free;
  end;
end;

function TCustomBindGridList.GetSourceScopes(AColumnExpressionItem: TColumnFormatExpressionItem): TArray<IScope>;
begin
  Result := inherited GetComponentScopes(SourceComponent, AColumnExpressionItem.SourceMemberName);
end;

function TCustomBindGridList.GetControlScopes(AColumnExpressionItem: TColumnFormatExpressionItem): TArray<IScope>;
begin
  Result := inherited GetComponentScopes(ControlComponent);
end;

procedure TCustomBindGridList.Loaded;
begin
  try
    inherited;
    if FDeferActive then
    begin
      FDeferActive := False;
      SetActive(True);
    end
    else
      if CanActivate then
        LoadActivate
  except
    // Don't raise exception when loading
  end;

end;

procedure TCustomBindGridList.ResetList;
begin
  if Active then
  begin
    if AutoFill then
      FillList;
  end;
end;

procedure TCustomBindGridList.FreeExpressionsObjects;
begin
  FreeExpressionObjects(FClearControlExpressionObjects);
  FreeExpressionObjects(FFormatControlExpressionObjects);
  FreeAndNil(FControlExpressionObject);
end;

procedure TCustomBindGridList.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Loading then
    begin
      if not Designing then
        FDeferActive := Value
    end
    else
    begin
      if Value then
        DoOnActivating
      else
        DoOnDeactivating;

      FActive := Value;
      if FActive then
      begin
        try
          FreeExpressionsObjects;
          UpdateExpressions;
          if AutoFill then
            FillList;
        finally
          DoOnActivated;
        end;
      end
      else
      begin
        try
          if AutoFill then
            if (ControlComponent <> nil) and
              (not (csDestroying in ControlComponent.ComponentState)) then
              ClearList;
        finally
          FreeExpressionsObjects;
          DoOnDeactivated;
        end;
      end;
    end;
  end;
end;

procedure TCustomBindGridList.UpdateExpressions;
var
  LExpressionItem: TExpressionItem;
  LBindingExpression: TBindingExpression;
begin
  Assert(FFormatControlExpressionObjects.Count = 0);
  Assert(FClearControlExpressionObjects.Count = 0);

  if ControlComponent = nil then
    Exit;
  if SourceComponent = nil then
    Exit;

  for LExpressionItem in FClearControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );

    FClearControlExpressionObjects.Add(LBindingExpression);
  end;


  for LExpressionItem in FFormatControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent),  // output
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent), // input
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FFormatControlExpressionObjects.Add(LBindingExpression);
  end;


  FControlExpressionObject := TBindings.CreateExpression(
    inherited GetComponentScopes(ControlComponent), //Input scopes
    'Self',
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );


end;

procedure TCustomBindGridList.SetAutoFill(const Value: Boolean);
begin
  if FAutoFill <> Value then
  begin
    FAutoFill := Value;
  end;
end;

procedure TCustomBindGridList.UpdateControlChanged;
begin
  inherited;
end;

procedure TCustomBindGridList.UpdateControlChanging;
begin
  inherited;  // Set active false
  BindListEditor := nil; // Release editor
end;

procedure TCustomBindGridList.SetColumnExpressions(
  const Value: TColumnFormatExpressions);
begin
  FColumnExpressions.Assign(Value);
end;

procedure TCustomBindGridList.SetListItemStyle(const Value: string);
begin
  if FListItemStyle <> Value then
  begin
    FListItemStyle := Value;
    if Active then
    begin
      Active := False;
      BindListEditor := nil;
      DesignAutoActivateOnPropertyChange;
    end;
  end;
end;

procedure TCustomBindGridList.SetFormatControlExpressions(
  const Value: TExpressions);
begin
  FFormatControlExpressions.Assign(Value);
end;

procedure TCustomBindGridList.SetBindListEditor(
  const Value: IBindListEditorCommon);
begin
  if FBindListEditor <> Value then
  begin
    if Supports(FBindListEditor, IBindListVirtualEditor) then
      // Need to discard editor that has callback references
      ReleaseBindEditor(FBindListEditor);
    FBindListEditor := Value;
  end;
end;

procedure TCustomBindGridList.SetBreakGroups(const Value: TFillBreakGroups);
begin
  FBreakGroups.Assign(Value);
end;

procedure TCustomBindGridList.SetClearControlExpressions(const Value: TExpressions);
begin
  FClearControlExpressions.Assign(Value);
end;

procedure TCustomBindGridList.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
var
  LItem: TColumnFormatExpressionItem;
begin
  inherited;
  if ACurMemberName <> '' then
    if AComponent = Self.SourceComponent then
      for LItem in  Self.ColumnExpressions do
      begin
        if LItem.FSourceMemberName = ACurMemberName then
          LItem.FSourceMemberName := ANewMemberName;
      end;
end;

{ TCustomBindColumns }


constructor TCustomBindGridLink.Create(AOwner: TComponent);
begin
  inherited;
  FControlObserver := TControlObserver.Create;
  FUpdateCounter := 0;
  FColumnExpressions := TColumnLinkExpressions.Create(Self, TColumnLinkExpressionItem);

  FPosSourceExpressions := TExpressions.Create(Self, TExpressionItem);
  FPosControlExpressions := TExpressions.Create(Self, TExpressionItem);
  FFormatControlExpressions := TExpressions.Create(Self, TExpressionItem);
  FClearControlExpressions := TExpressions.Create(Self, TExpressionItem);

  FPosControlExpressionObjects := TList<TBindingExpression>.Create;
  FPosSourceExpressionObjects := TList<TBindingExpression>.Create;
  FFormatControlExpressionObjects := TList<TBindingExpression>.Create;
  FClearControlExpressionObjects := TList<TBindingExpression>.Create;
  FEditColumnIndex := -1;
  FAutoFill := True;
  FDeprecatedBufferCount := -1;
end;

procedure TCustomBindGridLink.DefineProperties(Filer: TFiler);
begin
  inherited;
  // For backwards compatibility
  ReadBufferProperties(Filer);
end;

destructor TCustomBindGridLink.Destroy;
begin
  BindListEditor := nil; // Release editor
  SetActive(False);
  ClearEditingLink;
  FControlObserver.Free;
  FreeExpressionsObjects;

  FColumnExpressions.Free;

  FPosSourceExpressions.Free;
  FPosControlExpressions.Free;
  FFormatControlExpressions.Free;
  FClearControlExpressions.Free;

  FPosControlExpressionObjects.Free;
  FPosSourceExpressionObjects.Free;
  FFormatControlExpressionObjects.Free;
  FClearControlExpressionObjects.Free;
  FControlExpressionObject.Free;
  inherited;
end;

procedure TCustomBindGridLink.DoFilledRecord(const AEditor: IBindListEditor);
var
  LItem: IBindListEditorItem;
begin
  if Assigned(FOnFilledRecord) then
    if Supports(AEditor, IBindListEditorItem, LItem) then
      FOnFilledRecord(Self, LItem);
end;

procedure TCustomBindGridLink.DoFillingRecord(const AEditor: IBindListEditor);
var
  LItem: IBindListEditorItem;
begin
  if Assigned(FOnFillingRecord) then
    if Supports(AEditor, IBindListEditorItem, LItem) then
      FOnFillingRecord(Self, LItem);
end;

function TCustomBindGridLink.FindColumnExpressionItem(AIndex: Integer; AName: string): TColumnLinkExpressionItem;
var
  LItem: TColumnLinkExpressionItem;
  I: Integer;
begin
  Result := nil;
  for I := 0 to FColumnExpressions.Count - 1 do
  begin
    LItem := FColumnExpressions[I];
    if (AName = '') then
    begin
      if AIndex <> -1 then
      begin
// Note: ColumnIndex is always 0
//         if LItem.ColumnIndex = AIndex then
         if LItem.Index = AIndex then
           Exit(LItem);
      end
    end
    else
      if SameText(LItem.ColumnName, AName) then
        Exit(LItem);
  end;
end;


procedure TCustomBindGridLink.EvaluateParse(const AMemberName: string);
var
  LItem: TColumnLinkExpressionItem;
  LExpressionItem: TExpressionItem;
  LBindingExpression: TBindingExpression;
begin
  if not Active then
    Exit;
  UpdateColumnCurrent;
  LItem := FindColumnExpressionItem(FEditColumnIndex, FEditColumnName);
  if LItem <> nil then
  begin
    for LExpressionItem in LItem.ParseCellExpressions do
    begin
      LBindingExpression := TBindings.CreateUnmanagedBinding(
        GetControlScopes(LItem),
        LExpressionItem.ControlExpression,
        GetSourceScopes(LItem),
        LExpressionItem.SourceExpression,
        GetOutputConverter,
        TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
        []  // Execute
      );
      try
        LBindingExpression.Evaluate;
      finally
        LBindingExpression.Free;
      end;
    end;
  end;
end;

procedure TCustomBindGridLink.EvaluatePosClear;
begin
  // Do nothing, control will take care of this when cleared
end;

procedure TCustomBindGridLink.EvaluatePosControl;
var
  LExpression: TBindingExpression;
begin
  if FLockPosControl <> 0 then
    Exit;
  for LExpression in FPosControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

procedure TCustomBindGridLink.EvaluateClearControl;
var
  LExpression: TBindingExpression;
begin
  for LExpression in FClearControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;


procedure TCustomBindGridLink.EvaluatePosSource;
var
  LExpression: TBindingExpression;
  LScopeLocks: IScopeLocks;
begin
  Supports(Self.SourceComponent, IScopeLocks, LScopeLocks);
  if LScopeLocks <> nil then
    LScopeLocks.PosLockEnter;
  try
    for LExpression in FPosSourceExpressionObjects do
    begin
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.Evaluate;
    end;
  finally
    if LScopeLocks <> nil then
      LScopeLocks.PosLockLeave;
  end;
end;

procedure TCustomBindGridLink.EvaluateFormatControl;
var
  LExpression: TBindingExpression;
begin
  for LExpression in FFormatControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

procedure TCustomBindGridList.EvaluateFormatControl;
var
  LExpression: TBindingExpression;
begin
  for LExpression in FFormatControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

procedure TCustomBindGridList.EvaluateClearControl;
var
  LExpression: TBindingExpression;
begin
  for LExpression in FClearControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

function TCustomBindGridLink.GetCanModify: Boolean;
var
  LScopeEditor: IScopeEditor;
  LFieldName: string;
  Intf: IScopeEditLink;
  LItem: TColumnLinkExpressionItem;
begin
  Result := True;
  LFieldName := UpdateColumnCurrent;
  LItem := FindColumnExpressionItem(FEditColumnIndex, FEditColumnName);
  if LItem <> nil then
    if LItem.ParseCellExpressions.Count = 0 then
      // Can't update data so don't allow editing
      Exit(False);
  if LFieldName = '' then
  begin
    if Supports(Sourcecomponent, IScopeEditLink, Intf) then
      Result := Intf.GetCanModify(Self)
    else
      Result := False;
  end
  else
    if Supports(SourceComponent, IScopeEditor, LScopeEditor) then
      // Use #0 to find out if field is read only
      Result := LScopeEditor.IsValidChar(LFieldName, #0); 

end;

procedure TCustomBindGridLink.ClearModified;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.ClearModified(Self);
end;

function TCustomBindGridLink.GetActive: Boolean;
begin
  Result := FActive;
end;

function TCustomBindGridLink.GetBindComp: TComponent;
begin
  Result := Self;
end;

function TCustomBindGridLink.GetBindListEditor: IBindListEditorCommon;
begin
  CheckControlComponent;
  if not TryGetBindListEditor(Result) then
    raise TBindCompException.CreateFmt(sNoListEditor, [Self.GetDisplayName, ControlComponent.ClassName]);
end;

procedure TCustomBindGridLink.EvaluateFormatCallback(ACol, ARow: Integer; AEditorScope: IScope; ACanCacheExpressions: Boolean);
var
  LExpressions: TExpressions;
  LScopeGetRecord: IScopeGetRecord;
  LColumnExpressionItem: TColumnLinkExpressionItem;
begin
  if Supports(SourceComponent, IScopeGetRecord, LScopeGetRecord) then
  begin
    LExpressions := nil;
    LColumnExpressionItem := nil;
    if FColumnExpressions.Count > ACol then
    begin
      LColumnExpressionItem := FColumnExpressions[ACol];
      if LColumnExpressionItem.FormatCellExpressions.Count > 0 then
        LExpressions := LColumnExpressionItem.FormatCellExpressions
    end;
    if (LExpressions <> nil) then //and (LExpressions.Count >= 1) then
    begin
      LScopeGetRecord.GetRecord(ARow, LColumnExpressionItem.SourceMemberName,
        procedure(AScope: IScope)
        var
          LExpression: TExpressionItem;
          LBindingExpression: TBindingExpression;
          LUnmanagedExpressions: TList<TBindingExpression>;
        begin
          if ACanCacheExpressions then
          begin
            if FUnmanagedColumnExpressions = nil then
              FUnmanagedColumnExpressions := TObjectDictionary<Integer, TList<TBindingExpression>>.Create([doOwnsValues]);
            if not FUnmanagedColumnExpressions.TryGetValue(ACol, LUnmanagedExpressions) then
            begin
              LUnmanagedExpressions := TObjectList<TBindingExpression>.Create;
              FUnmanagedColumnExpressions.Add(ACol, LUnmanagedExpressions);
              for LExpression in LExpressions do
                LUnmanagedExpressions.Add(CreateUnmanagedExpressionItem(LColumnExpressionItem, LExpression, AEditorScope,
                 AScope));
            end;
            for LBindingExpression in LUnmanagedExpressions do
              LBindingExpression.Evaluate;
          end
          else
          begin
            for LExpression in LExpressions do
              EvaluateExpressionItem(LColumnExpressionItem, LExpression, AEditorScope,
               AScope);
              end;
        end);
    end;
  end
  else
    Assert(False);
end;

function TCustomBindGridLink.TryGetBindListEditor(out AEditor: IBindListEditorCommon): Boolean;
var
  LEditor: IInterface;
  LVirtualEditor: IBindListVirtualEditor;
  LVirtualEditorScope: IBindListVirtualEditorScope;
  LCanCache: Boolean;
begin
  if BindListEditor <> nil then
    AEditor := BindListEditor
  else
  begin
    AEditor := nil;
    if ControlComponent <> nil then
    begin
      LEditor := GetBindEditor(ControlComponent, IBindListEditor);
      if LEditor = nil then
      begin
        LEditor := GetBindEditor(ControlComponent, IBindListVirtualEditor);
        if LEditor <> nil then
          LEditor := GetBindEditor(ControlComponent, IBindListEditorCommon);
      end;
      if LEditor <> nil then
        AEditor := LEditor as IBindListEditorCommon;
    end;
    Supports(AEditor, IBindListVirtualEditor, LVirtualEditor); // Virtual editor must stick around
    if LVirtualEditor <> nil then
    begin
      LCanCache := Supports(LVirtualEditor, IBindListVirtualEditorScope, LVirtualEditorScope) and
        LVirtualEditorScope.CanCache;
      // Can't use virtual grid with unidirectional data source
      CheckUnidirectionalDataSource(Self.SourceComponent, Self);
      BindListEditor := AEditor;  // Keep it around
      LVirtualEditor.SetOnCallbackEvaluateFormat(
        procedure(ACol, ARow: Integer; AEditorScope: IScope)
        begin
          EvaluateFormatCallback(ACol, ARow, AEditorScope, LCanCache);
        end);
    end;
  end;
  Result := AEditor <> nil;
end;

function TCustomBindGridLink.GetScopeRecordEnumerator: IScopeRecordEnumerator;
begin
  Result := Data.Bind.Components.GetScopeRecordEnumerator(SourceComponent, IsLinked);
end;

function TCustomBindGridLink.GetScopeCurrentRecord(AColumnExpressionItem: TColumnLinkExpressionItem): IScope;
var
  LIntf: IScopeCurrentRecord;
begin
  if Supports(SourceComponent, IScopeCurrentRecord, LIntf) then
    Result := LIntf.GetCurrentRecord(AColumnExpressionItem.SourceMemberName)
  else
    Result := nil;
end;

procedure TCustomBindGridLink.GetBindingExpressions(const AEnumerator: IScopeRecordEnumerator; const AEditor: IBindListEditor;
  ACallback: TProc<TArrayListCellExpression>);
var
  LColumnLinkExpressionItem: TColumnLinkExpressionItem;
  LBindingExpressions: TObjectList<TList<TEvalEnumeratorToEditor>>;
  LList: TList<TEvalEnumeratorToEditor>;
  LExpressions: TExpressions;
  LExpression: TExpressionItem;
begin
  LBindingExpressions := TObjectList<TList<TEvalEnumeratorToEditor>>.Create();
  try
    for LColumnLinkExpressionItem in FColumnExpressions do
    begin
      LList := TObjectList<TEvalEnumeratorToEditor>.Create;
      LBindingExpressions.Add(LList);
      if LColumnLinkExpressionItem.FormatCellExpressions.Count > 0 then
        LExpressions := LColumnLinkExpressionItem.FormatCellExpressions
      else
        LExpressions := nil;
      if LExpressions <> nil then
      begin
        for LExpression in LExpressions do
          LList.Add(
            TEvalEnumeratorToEditor.Create(
            GetUseEvalShortcuts,
            AEnumerator,
            LColumnLinkExpressionItem.SourceMemberName,
           AEditor,
            LExpression.ControlExpression,
            LExpression.Custom,
            DoOnEvalError,
            TBindings.CreateUnmanagedBinding(
              GetComponentScopes(AEnumerator.GetMemberCurrent(LColumnLinkExpressionItem.SourceMemberName)),
              LExpression.SourceExpression,
              inherited GetComponentScopes(AEditor.CurrentItem), //Output destination(s)
              LExpression.ControlExpression,
              GetOutputConverter,
              TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
              [])));
      end;

    end;
    ACallback(LBindingExpressions.ToArray);
  finally
    LBindingExpressions.Free;
  end;
end;


procedure TCustomBindGridLink.FillGrid;
  function RecordCount(const AEnumerator: IScopeRecordEnumerator): Integer;
  var
    LCount: IScopeRecordEnumeratorCount;
  begin
    Result := 0;
    if Supports(AEnumerator, IScopeRecordEnumeratorCount, LCount) then
      Result := LCount.RecordCount
    else
    begin
      Assert(False);
    end;
  end;
var
  LEditorCommon: IBindListEditorCommon;
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
  LVirtualEditor: IBindListVirtualEditor;
begin
  BeginUpdate;
  try
    Inc(FLockPosControl);
    try
      LEditorCommon := GetBindListEditor;
      if LEditorCommon <> nil then
      begin
        EvaluateFormatControl;
        FormatColumns;
        LEnumerator := GetScopeRecordEnumerator;
        if LEnumerator <> nil then
        begin
          if Supports(LEditorCommon, IBindListVirtualEditor, LVirtualEditor) then
            LVirtualEditor.SetRowCount(RecordCount(LEnumerator))
          else if Supports(LEditorCommon, IBindListEditor, LEditor) then
          begin
            GetBindingExpressions(LEnumerator, LEditor,
              procedure(AExpressions: TArrayListCellExpression)
              begin
                LEditor.FillList(LEnumerator,
                  procedure(const ASourceScope, AEditorScope: IScope)
                  begin
                    Assert(AEditorScope <> nil);
                    FillRecord(LEditor,
                      procedure()
                      var
                        LExpression: TEvalEnumeratorToEditor;
                        LExpressions: TList<TEvalEnumeratorToEditor>;
                      begin
                        for LExpressions in  AExpressions do
                          for LExpression in LExpressions do
                            LExpression.Evaluate;
                      end);
                  end);
              end);

          end;
        end
      end;
    finally
      Dec(FLockPosControl);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomBindGridLink.FormatColumns;
var
  LExpression: TExpressionItem;
  LColumnExpressionItem: TColumnLinkExpressionItem;
  I: Integer;
  LExpressions: TExpressions;
  LEditorScope: IScope;
begin
  for I := 0 to FColumnExpressions.Count - 1 do
  begin
    LColumnExpressionItem := FColumnExpressions[I];
    if LColumnExpressionItem.FormatColumnExpressions.Count > 0 then
      LExpressions := LColumnExpressionItem.FormatColumnExpressions
    else
      LExpressions := nil;
    if LExpressions <> nil then
    begin
      for LExpression in LExpressions do
      begin
        if LEditorScope = nil then
          LEditorScope := GetComponentScope(Self.ControlComponent);
        EvaluateExpressions(LColumnExpressionItem,
           LEditorScope, LExpression.FControlExpression,
           GetComponentScope(SourceComponent, LColumnExpressionItem.SourceMemberName), LExpression.FSourceExpression
           );
      end;
    end;
  end;
end;



procedure TCustomBindGridLink.FillRecord(const AEditor: IBindListEditor; //const AEditorScope: IScope;
  AEvaluate: TProc);
begin
  DoFillingRecord(AEditor);
  try
    AEvaluate;
  finally
    DoFilledRecord(AEditor);
  end;
end;

procedure TCustomBindGridLink.EvaluateExpressionItem(AColumnExpressionItem: TColumnLinkExpressionItem; AItem: TExpressionItem; AEditorScope: IScope;
  AEnumScope: IScope);
begin
  EvaluateExpressions(AColumnExpressionItem, AEditorScope, AItem.ControlExpression, AEnumScope, AItem.SourceExpression);
end;

function TCustomBindGridLink.CreateUnmanagedExpressionItem(AColumnExpressionItem: TColumnLinkExpressionItem; AItem: TExpressionItem; AEditorScope: IScope;
  AEnumScope: IScope): TBindingExpression;
begin
  Result := CreateUnmanagedExpression(AColumnExpressionItem, AEditorScope, AItem.ControlExpression, AEnumScope, AItem.SourceExpression);
end;

procedure TCustomBindGridLink.EvaluateExpressions(AColumnExpressionItem: TColumnLinkExpressionItem; AEditorScope: IScope; const AEditorExpression: string;
  AEnumScope: IScope; const AEnumExpression: string);
var
  LExpression: TBindingExpression;
begin
  LExpression := CreateUnmanagedExpression(AColumnExpressionItem, AEditorScope, AEditorExpression,
    AEnumScope, AEnumExpression);
  try
    LExpression.Evaluate;
  finally
    LExpression.Free;
  end;
end;

function TCustomBindGridLink.CreateUnmanagedExpression(AColumnExpressionItem: TColumnLinkExpressionItem; AEditorScope: IScope; const AEditorExpression: string;
  AEnumScope: IScope; const AEnumExpression: string): TBindingExpression;
begin
  Result := TBindings.CreateUnmanagedBinding(
    GetComponentScopes(AEnumScope),
    AEnumExpression,
    inherited GetComponentScopes(AEditorScope), //Output destination(s)
    AEditorExpression,
    GetOutputConverter,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
    []  // Execute
  );
end;

procedure TCustomBindGridLink.UpdateRow(AEditor: IBindListVirtualEditor);
var
  LColumnExpressionItem: TColumnLinkExpressionItem;
  I: Integer;
  LExpressions: TExpressions;
begin
    for I := 0 to FColumnExpressions.Count - 1 do
    begin
      LColumnExpressionItem := FColumnExpressions[I];
      if LColumnExpressionItem.FormatCellExpressions.Count > 0 then
      begin
        LExpressions := LColumnExpressionItem.FormatCellExpressions;
        if LExpressions.Count > 0 then
          AEditor.UpdateCell(LColumnExpressionItem.ColumnIndex);
      end;
    end;
end;

procedure TCustomBindGridLink.EvaluateFormat(const AMemberName: string);
var
  LEditorCommon: IBindListEditorCommon;
  LEditorScope: IScope;
  LScopeCurrentRecord: IScopeCurrentRecord;
  LBindListVirtualEditor: IBindListVirtualEditor;
  LEditor: IBindListEditor;
  LScopeLocks: IScopeLocks;
begin
  if not Active then
    Exit;
  if Supports(SourceComponent, IScopeLocks, LScopeLocks) and LScopeLocks.PosLock then
    if not GetUpdating then
      // Don't refresh grid if just scrolling
      Exit;
  LEditorCommon := GetBindListEditor;
  if LEditorCommon <> nil then
  begin
    if Supports(LEditorCommon, IBindListVirtualEditor, LBindListVirtualEditor) then
    begin
      UpdateRow(LBindListVirtualEditor);
    end
    else if Supports(LEditorCommon, IBindListEditor, LEditor) then
    begin
      Supports(SourceComponent, IScopeCurrentRecord, LScopeCurrentRecord);
      if LScopeCurrentRecord <> nil then
      begin
        LEditorCommon.BeginUpdate;
        try
          LEditorScope := LEditor.CurrentItem;
          Assert(LEditorScope <> nil);
          if LEditorScope <> nil then
            FillRecord(LEditor, //LEditorScope,
              procedure() //AItem: TColumnLinkExpressionItem)
              var
                LExpression: TExpressionItem;
                LExpressions: TExpressions;
                I: Integer;
                LColumnExpressionItem: TColumnLinkExpressionItem;
              begin

                for I := 0 to FColumnExpressions.Count - 1 do
                begin
                  LColumnExpressionItem := FColumnExpressions[I];
                  if LColumnExpressionItem.FormatCellExpressions.Count > 0 then
                    LExpressions := LColumnExpressionItem.FormatCellExpressions
                  else
                    LExpressions := nil;
                  if LExpressions <> nil then
                  begin
                    for LExpression in LExpressions do
                      EvaluateExpressionItem(LColumnExpressionItem, LExpression, LEditorScope,
                       LScopeCurrentRecord.GetCurrentRecord(LColumnExpressionItem.SourceMemberName));
                  end;
                end;

              end);
        finally
          LEditorCommon.EndUpdate;
        end;
      end
      else
        Assert(False);
    end;
  end
  else
    Assert(False);
end;

procedure TCustomBindGridLink.BeginUpdate;
begin
  Inc(FUpdateCounter);
end;

function TCustomBindGridLink.CanSetControlComponent(
  AControl: TComponent): Boolean;
begin
  Result := GetBindEditor(AControl, IBindListEditor) <> nil;
  if not Result then
    Result := GetBindEditor(AControl, IBindListVirtualEditor) <> nil;
end;

procedure TCustomBindGridLink.CheckEditingLink;
begin
  FControlObserver.Component := ControlComponent;
  FControlObserver.EnsureObserving(TControlObserver.IDEditGridLinkObserver,
    function: IObserver
    begin
      Result := TBindEditGridLinkObserver.Create(Self);
    end);
  FControlObserver.EnsureObserving(TControlObserver.IDPositionLinkObserver,
    function: IObserver
    begin
      Result := TBindPositionLinkObserver.Create(Self);
    end);
end;

procedure TCustomBindGridLink.ClearEditingLink;
begin
  FControlObserver.Component := nil;
end;

procedure TCustomBindGridLink.ClearGrid;
var
  LEditor: IBindListEditorCommon;
begin
  BeginUpdate;
  try
    LEditor := GetBindListEditor;
    LEditor.BeginUpdate;
    try
      LEditor.ClearList;
      EvaluateClearControl;
    finally
      LEditor.EndUpdate;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomBindGridLink.EvaluateControlExpression(AColumnExpressionItem: TColumnLinkExpressionItem;
  const AExpression: string; ACallback: TProc<IValue>; AType: TBindCompExpressionType);
var
  LEditor: IBindListEditor;
  LScope: IScope;
begin

  if AType = TBindCompExpressionType.exprFormatColumn then
  begin
    inherited EvaluateControlExpression(AExpression, ACallback, AType);
  end
  else
  begin
    Supports(GetBindListEditor, IBindListEditor, LEditor);
    if LEditor <> nil then
    begin
      LScope := LEditor.CurrentItem;
      if LScope = nil then
      begin
        if LEditor.MoveNext then
          LScope := LEditor.CurrentItem
        else
          LScope := LEditor.AddItem;
      end;
      if LScope <> nil then
      begin
        EvaluateControlExpression(LScope, AExpression, ACallback);
      end;
    end;
  end
end;

procedure TCustomBindGridLink.ExecuteAssignToControlExpression(AColumnExpressionItem: TColumnLinkExpressionItem;
  const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
var
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
  LEditorScope: IScope;
  LScope: IScope;
begin
  if AType = TBindCompExpressionType.exprFormatColumn then
  begin
    LEditorScope := GetComponentScope(ControlComponent);
    LScope := GetComponentScope(SourceComponent, AColumnExpressionItem.SourceMemberName);
    EvaluateExpressions(AColumnExpressionItem, LEditorScope, AControlExpression, LScope, ASourceExpression);
  end
  else
  begin
    Supports(GetBindListEditor, IBindListEditor, LEditor);
    if LEditor <> nil then
    begin
      LEditor.BeginUpdate;
      try
        LEnumerator := GetScopeRecordEnumerator;
        if LEnumerator <> nil then
        begin
          if LEnumerator.MoveNext then
          begin
            LEditorScope := LEditor.AddItem;
            Assert(LEditorScope <> nil);
            if LEditorScope <> nil then
            begin
              EvaluateExpressions(AColumnExpressionItem, LEditorScope, AControlExpression, LEnumerator.Current, ASourceExpression);
            end;
          end;
        end
        else
          Assert(False);
      finally
        LEditor.EndUpdate;
      end;
    end;
  end

end;

procedure TCustomBindGridLink.EvaluateSourceExpression(AColumnExpressionItem: TColumnLinkExpressionItem;
  const AExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
var
  LEnumerator: IScopeRecordEnumerator;
  LEditorScope: IScope;
begin
  if AType = TBindCompExpressionType.exprFill then
  begin
    LEnumerator := GetScopeRecordEnumerator;
    if LEnumerator <> nil then
    begin
      if LEnumerator.MoveNext then
      begin
        EvaluateSourceExpression(
          LEnumerator.GetMemberCurrent(AColumnExpressionItem.SourceMemberName), AExpression,
          ACallback);
      end;
    end
  end
  else
  begin
    LEditorScope := GetScopeCurrentRecord(AColumnExpressionItem);
    if LEditorScope <> nil then
    begin
        EvaluateSourceExpression(
          LEditorScope, AExpression, ACallback);
    end
  end;
end;

procedure TCustomBindGridLink.EvaluateSourceExpression(
  AEnumScope: IScope; const AEnumExpression: string; ACallback: TProc<IValue>);
var
  LExpression: TBindingExpression;
begin
  LExpression := TBindings.CreateExpression(
    inherited GetComponentScopes(AEnumScope),
    AEnumExpression,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
  try
    ACallback(LExpression.Evaluate);
  finally
    LExpression.Free;
  end;
end;

procedure TCustomBindGridLink.ExecuteAssignItemToSourceExpression(AColumnExpressionItem: TColumnLinkExpressionItem;
  const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
var
  LExpression: TBindingExpression;
begin
  LExpression := TBindings.CreateUnmanagedBinding(
    GetcontrolScopes(AColumnExpressionItem),
    AControlExpression,
    GetSourceScopes(AColumnExpressionItem),   //Output destination(s)
    ASourceExpression,
    GetOutputConverter,
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
    []  // Execute
  );
  try
    ACallback(LExpression.Evaluate);
  finally
    LExpression.Free;
  end;
end;

function TCustomBindGridLink.GetSourceScopes(AColumnExpressionItem: TColumnLinkExpressionItem): TArray<IScope>;
begin
  Result := inherited GetComponentScopes(SourceComponent, AColumnExpressionItem.SourceMemberName);
end;

function TCustomBindGridLink.GetUpdating: Boolean;
begin
  Result := FUpdateCounter > 0;
end;

function TCustomBindGridLink.IsLinked: Boolean;
begin
  Result := True;
end;

function TCustomBindGridLink.IsRequired: Boolean;
var
  LScopeEditor: IScopeEditor;
begin
  Result := False;
  if Supports(SourceComponent, IScopeEditor, LScopeEditor) then
  begin
    Result := LScopeEditor.IsRequired(SourceMemberName);
  end;
end;

procedure TCustomBindGridLink.SetIsReadOnly(Value: Boolean);
var
  LScopeEditLink: IScopeEditLink;
begin
  if Supports(SourceComponent, IScopeEditLink, LScopeEditLink) then
    LScopeEditLink.SetReadOnly(Self, Value);
end;

function TCustomBindGridLink.IsValidChar(AKey: Char): Boolean;
var
  LScopeEditor: IScopeEditor;
  LFieldName: string;
begin
  Result := True;
  LFieldName := UpdateColumnCurrent;
  if LFieldName = '' then
    raise TBindCompException.CreateFmt(sLinkFieldNotFound, [GetDisplayName]);
  if Supports(SourceComponent, IScopeEditor, LScopeEditor) then
    Result := LScopeEditor.IsValidChar(LFieldName, AKey);
end;

function TCustomBindGridLink.GetControlScopes(AColumnExpressionItem: TColumnLinkExpressionItem): TArray<IScope>;
begin
  Result := inherited GetComponentScopes(ControlComponent);
end;

function TCustomBindGridLink.GetEditColumnIndex: Integer;
begin
  Result := FEditColumnIndex;
end;

function TCustomBindGridLink.GetEditColumnName: string;
begin
  Result := FEditColumnName;
end;

procedure TCustomBindGridLink.Loaded;
begin
  try
    inherited;
    if CanActivate then
      LoadActivate;
  except
    // Don't raise exception when loading
  end;
end;

procedure TCustomBindGridLink.SetModified;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.SetModified(Self)
end;

function TCustomBindGridLink.GetIsModified: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Result := Intf.GetIsModified(Self)
  else
    Result := False;
end;

procedure TCustomBindGridLink.PosChanged;
begin
  if FUpdateCounter > 0 then
    Exit;
  Inc(FLockPosControl);
  try
      EvaluatePosSource;
  finally
    Dec(FLockPosControl);
  end;
end;

procedure TCustomBindGridLink.PosChanging;
var
  LScopeEditLink: IScopeEditLink;
begin
  //if FLockPosControl <> 0 then
  //  Exit;
  if Supports(SourceComponent, IScopeEditLink, LScopeEditLink) then
    LScopeEditLink.PosChanging(Self);
end;

function TCustomBindGridLink.RequiresControlHandler: Boolean;
var
  LColumnExpressionItem: TColumnLinkExpressionItem;
  I: Integer;
begin
  if PosSourceExpressions.Count > 0 then
    Exit(True);
  for I := 0 to FColumnExpressions.Count - 1 do
  begin
    LColumnExpressionItem := FColumnExpressions[I];
    if LColumnExpressionItem.ParseCellExpressions.Count > 0 then
      Exit(True);
  end;
  Result := False;
end;

procedure TCustomBindGridLink.Reset;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.Reset(Self)
end;

procedure TCustomBindGridLink.FreeExpressionsObjects;
begin
  FreeExpressionObjects(FPosControlExpressionObjects);
  FreeExpressionObjects(FPosSourceExpressionObjects);
  FreeExpressionObjects(FFormatControlExpressionObjects);
  FreeExpressionObjects(FClearControlExpressionObjects);
  FreeAndNil(FControlExpressionObject);
  FreeAndNil(FUnmanagedColumnExpressions);
end;

procedure TCustomBindGridLink.ResetColumns;
begin
  if Active then
  begin
    try
      FreeExpressionsObjects;
      UpdateExpressions;
      Inc(FLockPosControl);
      try
        if AutoFill then
          FillGrid;
      finally
        Dec(FLockPosControl);
      end;
      EvaluatePosControl;
    except
    end;
  end
end;


procedure TCustomBindGridLink.ResetGrid;
var
  LExpression: TBindingExpression;
begin
  if Active then
  begin
    if AutoFill then
    begin
      BeginUpdate;
      try
        FillGrid;
      finally
        EndUpdate;
      end;
    end;
    // Always position, even if FLockPosControl
    for LExpression in FPosControlExpressionObjects do
    begin
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.Evaluate;
    end;
  end;
end;

procedure TCustomBindGridLink.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Loading then
    begin
      if not Designing then
        FDeferActive := Value
    end
    else
    begin
      ClearModified;
      if Value then
        DoOnActivating
      else
        DoOnDeactivating;

      FActive := Value;
      if FActive then
      begin
        try
          FreeExpressionsObjects;
          UpdateExpressions;
          if not Designing then
            if RequiresControlHandler then
            begin
              CheckEditingLink;
              if not FControlObserver.TrySetActive(True) then
                raise TBindCompException.CreateFmt(sNoControlObserverSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);
            end;
          if AutoFill then
            FillGrid;
          EvaluatePosControl;
        finally
          DoOnActivated;
        end;
      end
      else
      begin
        try
          if AutoFill then
            if (ControlComponent <> nil) and
              (not (csDestroying in ControlComponent.ComponentState)) then
              ClearGrid;
        finally
          FControlObserver.TrySetActive(False);
          FreeExpressionsObjects;
          DoOnDeactivated;
        end;
      end;
    end;
  end;
end;

procedure TCustomBindGridLink.UpdateExpressions;
var
  LExpressionItem: TExpressionItem;
  LBindingExpression: TBindingExpression;
begin
  Assert(FFormatControlExpressionObjects.Count = 0);
  Assert(FClearControlExpressionObjects.Count = 0);
  Assert(FPosSourceExpressionObjects.Count = 0);
  Assert(FPosControlExpressionObjects.Count = 0);

  if ControlComponent = nil then
    Exit;
  if SourceComponent = nil then
    Exit;

  for LExpressionItem in FPosControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FPosControlExpressionObjects.Add(LBindingExpression);
  end;

  for LExpressionItem in FFormatControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FFormatControlExpressionObjects.Add(LBindingExpression);
  end;

  for LExpressionItem in FClearControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FClearControlExpressionObjects.Add(LBindingExpression);
  end;


  for LExpressionItem in FPosSourceExpressions do
  begin
    CheckUnidirectionalDataSource(SourceComponent, Self);
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(ControlComponent), // input
      LExpressionItem.ControlExpression,
      inherited GetComponentScopes(SourceComponent),  // output
      LExpressionItem.SourceExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FPosSourceExpressionObjects.Add(LBindingExpression);
  end;

  FControlExpressionObject := TBindings.CreateExpression(
    inherited GetComponentScopes(ControlComponent), //Input scopes
    'Self',
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
end;

procedure TCustomBindGridLink.UpdateList;

  function RecordCount(const AEnumerator: IScopeRecordEnumerator): Integer;
  var
    LCount: IScopeRecordEnumeratorCount;
  begin
    Result := 0;
    if Supports(AEnumerator, IScopeRecordEnumeratorCount, LCount) then
      Result := LCount.RecordCount
    else
    begin
      Assert(False);        
    end;
  end;

var
  LEditorCommon: IBindListEditorCommon;
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
  LVirtualEditor: IBindListVirtualEditor;
begin
  LEditorCommon := GetBindListEditor;
  if LEditorCommon <> nil then
  begin
    if Supports(LEditorCommon, IBindListVirtualEditor, LVirtualEditor) then
    begin
      LEnumerator := GetScopeRecordEnumerator;
      LVirtualEditor.SetRowCount(RecordCount(LEnumerator))
    end
    else if Supports(LEditorCommon, IBindListEditor, LEditor) then
    begin
      LEnumerator := GetScopeRecordEnumerator;
      if LEditor.UpdateNeeded(LEnumerator) then
      begin
        if LEnumerator <> nil then
        begin
          GetBindingExpressions(LEnumerator, LEditor,
            procedure(AExpressions: TArrayListCellExpression)
            begin
              LEditor.UpdateList(LEnumerator,
                procedure(const ASourceScope, AEditorScope: IScope)
                begin
                  Assert(AEditorScope <> nil);
                  FillRecord(LEditor,
                    procedure()
                    var
                      LExpression: TEvalEnumeratorToEditor;
                      LExpressions: TList<TEvalEnumeratorToEditor>;
                    begin
                      for LExpressions in  AExpressions do
                        for LExpression in LExpressions do
                          LExpression.Evaluate;
                    end);
                end);
            end);

        end
        else
          Assert(False);
      end
      else
      begin
        if LEditorCommon.RowCount > 0 then
          EvaluateFormat('');
      end;
    end;
  end
  else
    Assert(False);
end;

procedure TCustomBindGridLink.UpdateRecord;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.UpdateRecord(Self)
end;

function TCustomBindGridLink.UpdateColumnCurrent: string;
var
  LItem: TCollectionItem;
  LEditGridLinkObserver: IEditGridLinkObserver;
begin
  Result := '';
  LEditGridLinkObserver := FControlObserver.EditGridLinkObserver;
  if Assigned(LEditGridLinkObserver) then
  begin
    FEditColumnCurrent := LEditGridLinkObserver.Current;
    case FEditColumnCurrent.VType of
      vtInteger:
        begin
          for LItem in ColumnExpressions do
          begin
            FEditColumnIndex := TColumnLinkExpressionItem(LItem).Index;
            if TColumnLinkExpressionItem(LItem).Index = FEditColumnCurrent.VInteger then
            begin
              Result := TColumnLinkExpressionItem(LItem).SourceMemberName;
              break;
            end;
          end;
        end
      else raise TBindCompException.CreateFmt(sLinkUnexpectedGridCurrentType, [GetDisplayName]);
    end;
  end;
end;

procedure TCustomBindGridLink.SetAutoFill(const Value: Boolean);
begin
  if FAutoFill <> Value then
  begin
    FAutoFill := Value;
  end;
end;

procedure TCustomBindGridLink.SetBindListEditor(
  const Value: IBindListEditorCommon);
begin
  if FBindListEditor <> Value then
  begin
    if Supports(FBindListEditor, IBindListVirtualEditor) then
      // Need to discard editor that has callback references
      ReleaseBindEditor(FBindListEditor);
    FBindListEditor := Value;
  end;
end;

procedure TCustomBindGridLink.UpdateControlChanging;
begin
  inherited;  // Set active false
  BindListEditor := nil; // Release editor
  ClearEditingLink;
end;

procedure TCustomBindGridLink.SetClearControlExpressions(
  const Value: TExpressions);
begin
  FClearControlExpressions.Assign(Value);
end;

procedure TCustomBindGridLink.SetColumnExpressions(
  const Value: TColumnLinkExpressions);
begin
  FColumnExpressions.Assign(Value);
end;

procedure TCustomBindGridLink.SetEditColumn(const AName: string;
  AIndex: Integer);
begin
  FEditColumnIndex := AIndex;
end;

procedure TCustomBindGridLink.SetFormatControlExpressions(
  const Value: TExpressions);
begin
  FFormatControlExpressions.Assign(Value);
end;

procedure TCustomBindGridLink.SetPosControlExpressions(
  const Value: TExpressions);
begin
  FPosControlExpressions.Assign(Value);
end;

procedure TCustomBindGridLink.SetPosSourceExpressions(const Value: TExpressions);
begin
  FPosSourceExpressions.Assign(Value);
end;

function TCustomBindGridLink.Edit: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
  begin
    Result := Intf.Edit(Self)
  end
  else
    Result := True;
end;

procedure TCustomBindGridLink.EndUpdate;
begin
  Dec(FUpdateCounter);
  if FUpdateCounter < 0 then
    FUpdateCounter := 0;
end;

function TCustomBindGridLink.GetIsEditing: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
  begin
    Result := Intf.GetIsEditing(Self)
  end
  else
    Result := True;
end;

procedure TCustomBindGridLink.EvaluateClear(const AMemberName: string);
var
  LEditor: IBindListEditorCommon;
begin
  if Active then
  begin
    // Just like ClearGrid except don't clear the control
    LEditor := GetBindListEditor;
    LEditor.BeginUpdate;
    try
      LEditor.ClearList;
    finally
      LEditor.EndUpdate;
    end;
  end;
end;

procedure TCustomBindGridLink.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
var
  LItem: TColumnLinkExpressionItem;
begin
  if ACurMemberName <> '' then
    if AComponent = Self.SourceComponent then
      for LItem in  Self.ColumnExpressions do
      begin
        if LItem.FSourceMemberName = ACurMemberName then
          LItem.FSourceMemberName := ANewMemberName;
      end;
end;


{ TColumnFormatExpressionItem }

procedure TColumnFormatExpressionItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TColumnLinkExpressionItem then
  begin
    TColumnLinkExpressionItem(Dest).Name := Name;
    TColumnLinkExpressionItem(Dest).SourceMemberName := SourceMemberName;
    TColumnLinkExpressionItem(Dest).FormatCellExpressions := FormatCellExpressions;
    TColumnLinkExpressionItem(Dest).FormatColumnExpressions := FormatColumnExpressions;
    TColumnLinkExpressionItem(Dest).ColumnName := ColumnName;
    TColumnLinkExpressionItem(Dest).ColumnIndex := ColumnIndex;
  end
  else
    inherited;
end;

constructor TColumnFormatExpressionItem.Create(Collection: TCollection);
begin
  inherited;
  FColumnIndex := -1;
  FFormatCellExpressions := TExpressions.Create(Self, TExpressionItem);
  FFormatCellHeaderExpressions := TExpressions.Create(Self, TExpressionItem);
  FFormatColumnExpressions := TExpressions.Create(Self, TExpressionItem);
end;

destructor TColumnFormatExpressionItem.Destroy;
begin
  FFormatCellExpressions.Free;
  FFormatCellHeaderExpressions.Free;
  FFormatColumnExpressions.Free;
  inherited;
end;

function TColumnFormatExpressionItem.GetColumnExpressions: TColumnFormatExpressions;
begin
  Result := TColumnFormatExpressions(Collection);
end;

function TColumnFormatExpressionItem.GetColumnIndex: Integer;
begin
  if FColumnIndex = -1 then
    Result := Index
  else
    Result := FColumnIndex;
end;

function TColumnFormatExpressionItem.GetDisplayName: string;
begin
  Result := Name;
  if Result = '' then
    Result := SourceMemberName;
end;

function TColumnFormatExpressionItem.GetName: string;
begin
  Result := FName;
end;

procedure TColumnFormatExpressionItem.SetColumnIndex(Value: Integer);
begin
  if Value = Index then
    FColumnIndex := -1
  else
    FColumnIndex := Value;
end;

procedure TColumnFormatExpressionItem.SetFormatCellExpressions(const Value: TExpressions);
begin
  FFormatCellExpressions.Assign(Value);
end;

procedure TColumnFormatExpressionItem.SetFormatCellHeaderExpressions(
  const Value: TExpressions);
begin
  FFormatCellHeaderExpressions.Assign(Value);
end;

procedure TColumnFormatExpressionItem.SetFormatColumnExpressions(const Value: TExpressions);
begin
  FFormatColumnExpressions.Assign(Value);
end;

procedure TColumnFormatExpressionItem.SetName(const Value: string);
begin
  FName := Value;
end;

{ TColumnLinkExpressionItem }

procedure TColumnLinkExpressionItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TColumnLinkExpressionItem then
  begin
    TColumnLinkExpressionItem(Dest).Name := Name;
    TColumnLinkExpressionItem(Dest).SourceMemberName := SourceMemberName;
    TColumnLinkExpressionItem(Dest).ParseCellExpressions := ParseCellExpressions;
    TColumnLinkExpressionItem(Dest).FormatCellExpressions := FormatCellExpressions;
    TColumnLinkExpressionItem(Dest).FormatColumnExpressions := FormatColumnExpressions;
    TColumnLinkExpressionItem(Dest).ColumnName := ColumnName;
    TColumnLinkExpressionItem(Dest).ColumnIndex := ColumnIndex;
  end
  else
    inherited;
end;

constructor TColumnLinkExpressionItem.Create(Collection: TCollection);
begin
  inherited;
  FColumnIndex := -1;
  FParseCellExpressions := TExpressions.Create(Self, TExpressionItem);
  FFormatCellExpressions := TExpressions.Create(Self, TExpressionItem);
  FFormatColumnExpressions := TExpressions.Create(Self, TExpressionItem);
end;

destructor TColumnLinkExpressionItem.Destroy;
begin
  FParseCellExpressions.Free;
  FFormatCellExpressions.Free;
  FFormatColumnExpressions.Free;
  inherited;
end;

function TColumnLinkExpressionItem.GetColumnExpressions: TColumnLinkExpressions;
begin
  Result := TColumnLinkExpressions(Collection);
end;

function TColumnLinkExpressionItem.GetColumnIndex: Integer;
begin
  if FColumnIndex = -1 then
    Result := Index
  else
    Result := FColumnIndex;
end;

function TColumnLinkExpressionItem.GetDisplayName: string;
begin
  Result := Name;
  if Result = '' then
    Result := SourceMemberName;
end;

function TColumnLinkExpressionItem.GetName: string;
begin
  Result := FName;
end;

procedure TColumnLinkExpressionItem.SetColumnIndex(Value: Integer);
begin
  if Value = Index then
    FColumnIndex := -1
  else
    FColumnIndex := Value;
end;

procedure TColumnLinkExpressionItem.SetFormatCellExpressions(const Value: TExpressions);
begin
  FFormatCellExpressions.Assign(Value);
end;

procedure TColumnLinkExpressionItem.SetFormatColumnExpressions(const Value: TExpressions);
begin
  FFormatColumnExpressions.Assign(Value);
end;

procedure TColumnLinkExpressionItem.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TColumnLinkExpressionItem.SetParseExpressions(const Value: TExpressions);
begin
  FParseCellExpressions.Assign(Value);
end;

procedure TColumnLinkExpressionItem.SetSourceMemberName(const Value: string);
begin
  FSourceMemberName := Value;
  if FColumnName = '' then
    FColumnName := FSourceMemberName;
end;

{ TColumnFormatExpressions }

function TColumnFormatExpressions.AddExpression: TColumnFormatExpressionItem;
begin
  Result := Add as TColumnFormatExpressionItem;
end;

function TColumnFormatExpressions.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sNameAttr;
  else
    Result := ''; { do not localize }
  end;
end;

function TColumnFormatExpressions.GetAttrCount: Integer;
begin
  Result := 1;
end;

function TColumnFormatExpressions.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

function TColumnFormatExpressions.GetItem(Index: Integer): TColumnFormatExpressionItem;
begin
  Result := TColumnFormatExpressionItem(inherited Items[Index]);
end;

function TColumnFormatExpressions.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: begin
         Result := Items[ItemIndex].Name;
         if Result = '' then Result := IntToStr(ItemIndex);
       end;
  else
    Result := '';
  end;
end;

procedure TColumnFormatExpressions.SetItem(Index: Integer; const Value: TColumnFormatExpressionItem);
begin
  inherited SetItem(Index, TCollectionItem(Value));

end;

{ TColumnLinkExpressions }

function TColumnLinkExpressions.AddExpression: TColumnLinkExpressionItem;
begin
  Result := Add as TColumnLinkExpressionItem;
end;

function TColumnLinkExpressions.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sNameAttr;
  else
    Result := ''; { do not localize }
  end;
end;

function TColumnLinkExpressions.GetAttrCount: Integer;
begin
  Result := 1; // 3;
end;

function TColumnLinkExpressions.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

function TColumnLinkExpressions.GetItem(Index: Integer): TColumnLinkExpressionItem;
begin
  Result := TColumnLinkExpressionItem(inherited Items[Index]);
end;

function TColumnLinkExpressions.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: begin
         Result := Items[ItemIndex].Name;
         if Result = '' then Result := IntToStr(ItemIndex);
       end;
  else
    Result := '';
  end;
end;

procedure TColumnLinkExpressions.SetItem(Index: Integer; const Value: TColumnLinkExpressionItem);
begin
  inherited SetItem(Index, TCollectionItem(Value));

end;

{ TBindEventList1<T> }

procedure TBindEventList1<T>.Add(AEvent: TBindNotifyEvent1<T>);
begin
  InternalAdd(TNotifyEvent(AEvent));
end;

procedure TBindEventList1<T>.Remove(AEvent: TBindNotifyEvent1<T>);
begin
  InternalRemove(TNotifyEvent(AEvent));
end;

procedure TBindEventList1<T>.Send(Sender: TObject; const P: T);
var
  Handler: TNotifyEvent;
begin
  for Handler in FList do
    TBindNotifyEvent1<T>(Handler)(Sender, P);
end;

{ TBindEventList }

procedure TBindEventList.Add(AEvent: TNotifyEvent);
begin
  InternalAdd(AEvent);
end;

procedure TBindEventList.Remove(AEvent: TNotifyEvent);
begin
  InternalRemove(AEvent);
end;

procedure TBindEventList.Send(Sender: TObject);
var
  Handler: TNotifyEvent;
begin
  {$IFDEF NEXTGEN_TODO}
  Handler := nil;
  {$ENDIF}
  for Handler in FList do
    Handler(Sender);
end;

{ TBindComponentScope }

function TBindComponentScope.DoLookup(const Name: String): IInterface;
var
  Comp: TComponent;
begin
  Result := nil;
  if MappedObject is TComponent then
  begin
    Comp := TComponent(MappedObject);
    if Comp.FindComponent(Name) <> nil then
      Result := TCustomWrapper.Create(MappedObject, MetaClass, Name, cwtProperty,
        function (ParentObject: TObject; const MemberName: String; Args: TArray<TValue>): TValue
        begin
          // ParentObject points to the same object as MappedObject
          Result := TComponent(ParentObject).FindComponent(MemberName);
        end);
  end;
end;


{ TBindScopeComponentScope }

function TBindScopeComponentScope.DoLookup(const Name: String): IInterface;
var
  ScopeComp: TBaseBindScopeComponent;
begin
  Result := nil;
  if MappedObject is TBaseBindScopeComponent then
  begin
    ScopeComp := TBaseBindScopeComponent(MappedObject);
    if ScopeComp.Owner <> nil then
      if ScopeComp.Owner.FindComponent(Name) <> nil then
      begin
        Result := TCustomWrapper.Create(ScopeComp.Owner, ScopeComp.Owner.ClassType, Name, cwtProperty,
          function (ParentObject: TObject; const MemberName: String; Args: TArray<TValue>): TValue
          begin
            Result := TComponent(ParentObject).FindComponent(MemberName);
          end);
      end;
  end;
  if Result = nil then
    Result := inherited;
end;

{ TCustomBindExpression }

function TCustomBindExpression.CanActivate: Boolean;
begin
  Result := inherited and (FControlExpression <> '') and
    (FSourceExpression <> '');
end;

constructor TCustomBindExpression.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCustomBindExpression.Destroy;
begin
  FExpressionObject.Free;
  FReverseExpressionObject.Free;
  inherited;
end;

procedure TCustomBindExpression.UpdateExpressions;
var
  LControlScopes: TArray<IScope>;
  LSourceScopes: TArray<IScope>;
  OutputConverters: IValueRefConverter;
  LManager: TBindingManager;
  LOptions: TBindings.TCreateOptions;
begin
  Assert(FExpressionObject = nil);
  Assert(FReverseExpressionObject = nil);
  Assert(SourceComponent <> nil);

  LControlScopes := GetControlScopes;

  LSourceScopes := GetSourceScopes;

  OutputConverters := GetOutputConverter;

  if (not Designing) and Managed then
  begin
    // Participate in notifications

    if NotifyOutputs then
      LOptions := [TBindings.TCreateOption.coNotifyOutput]
    else
      LOPtions := [];
    if not Assigned(BindingsList) then
      LManager := nil
    else
      LManager := BindingsList.FBindingsManager;
    case Direction of
      dirSourceToControl:
        FExpressionObject := TBindings.CreateManagedBinding(
          LSourceScopes,
          FSourceExpression,
          LControlScopes,
          FControlExpression, //Output destination(s)
          OutputConverters,
          TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
          LManager,
          LOptions //do not evaluate here
        );
      dirControlToSource:
        FExpressionObject := TBindings.CreateManagedBinding(
          LControlScopes,
          FControlExpression,
          LSourceScopes,
          FSourceExpression,
          OutputConverters,
          TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
          LManager,
          LOptions //do not evaluate here
        );
      dirBidirectional:
      begin
        FExpressionObject := TBindings.CreateManagedBinding(
          LSourceScopes,
          FSourceExpression,
          LControlScopes,
          FControlExpression, //Output destination(s)
          OutputConverters,
          TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
          LManager,
          LOptions //do not evaluate here
        );
        FReverseExpressionObject := TBindings.CreateManagedBinding(
          LControlScopes,
          FControlExpression,
          LSourceScopes,
          FSourceExpression,
          OutputConverters,
          TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
          LManager,
          LOptions //do not evaluate here
        );
      end
    else
      Assert(False);
    end;
  end
  else
    case Direction of
      dirSourceToControl,
      dirBidirectional: // Same as SourceToControl if only one direction
        FExpressionObject := TBindings.CreateUnManagedBinding(
          LSourceScopes,
          FSourceExpression,
          LControlScopes,
          FControlExpression, //Output destination(s)
          OutputConverters,
          TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
          [] //do not evaluate here
        );
      dirControlToSource:
        FExpressionObject := TBindings.CreateUnManagedBinding(
          LControlScopes,
          FControlExpression,
          LSourceScopes,
          FSourceExpression,
          OutputConverters,
          TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
          [] //do not evaluate here
        );
    else
      Assert(False);
    end;

end;

procedure TCustomBindExpression.SetSourceExpression(const Value: string);
begin
  if FSourceExpression <> Value then
  begin
    Active := False;
    FSourceExpression := Value;
  end;
end;

procedure TCustomBindExpression.SetControlExpression(const Value: string);
begin
  if FControlExpression <> Value then
  begin
    Active := False;
    FControlExpression := Value;
  end;
end;

procedure TCustomBindExpression.EvaluateFormat;
begin
  Evaluate;
end;

procedure TCustomBindExpression.EvaluateWithoutNotify;
var
  LControlScopes: TArray<IScope>;
  LSourceScopes: TArray<IScope>;
  OutputConverters: IValueRefConverter;
  LExpressionObject: TBindingExpression;
begin
  if Managed then
  begin
    LControlScopes := GetControlScopes;
    LSourceScopes := GetSourceScopes;
    OutputConverters := GetOutputConverter;
    LExpressionObject := nil;
    try
      case Direction of
        dirSourceToControl,
        dirBidirectional: 
          LExpressionObject := TBindings.CreateUnManagedBinding(
            LSourceScopes,
            FSourceExpression,
            LControlScopes,
            FControlExpression, //Output destination(s)
            OutputConverters,
            TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
            [] //do not evaluate here
          );
        dirControlToSource:
          LExpressionObject := TBindings.CreateUnManagedBinding(
            LControlScopes,
            FControlExpression,
            LSourceScopes,
            FSourceExpression,
            OutputConverters,
            TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
            [] //do not evaluate here
          );
      end;
      LExpressionObject.Evaluate;
    finally
      LExpressionObject.Free;
    end;
  end
  else
    if FExpressionObject.Compiled then  // In case binding manager has been destroyed
      FExpressionObject.Evaluate;

end;

procedure TCustomBindExpression.Evaluate;
begin
  if not Active then
    try
      FreeExpressionsObjects;
      UpdateExpressions;
      EvaluateWithoutNotify;
    finally
      FreeExpressionsObjects;
    end
  else
    EvaluateWithoutNotify;

end;

procedure TCustomBindExpression.FreeExpressionsObjects;
begin
  FExpressionObject.DisposeOf;
  FExpressionObject := nil;
  FReverseExpressionObject.DisposeOf;
  FReverseExpressionObject := nil;
end;

procedure TCustomBindExpression.Recompile;
begin
  if FExpressionObject <> nil then
  begin
    if FExpressionObject.Compiled then  // In case binding manager has been destroyed
      FExpressionObject.ReCompile;
  end;

  if FReverseExpressionObject <> nil then
  begin
    if FReverseExpressionObject.Compiled then  // In case binding manager has been destroyed
      FReverseExpressionObject.ReCompile;
  end;

end;


{ TCustomBindExprItems }

constructor TCustomBindExprItems.Create(AOwner: TComponent);
begin
  inherited;
  FFormatExpressions := TExpressionsDir.Create(Self, TExpressionItemDir);
  FClearExpressions := TExpressionsDir.Create(Self, TExpressionItemDir);
  FFormatExpressionObjects := TList<TBindingExpression>.Create;
  FReverseFormatExpressionObjects := TList<TBindingExpression>.Create;
  FClearExpressionObjects := TList<TBindingExpression>.Create;

end;

destructor TCustomBindExprItems.Destroy;
begin
  FFormatExpressions.Free;
  FFormatExpressionObjects.Free;
  FReverseFormatExpressionObjects.Free;
  FClearExpressions.Free;
  FClearExpressionObjects.Free;
  inherited;
end;

procedure TCustomBindExprItems.UpdateExpressions;
var
  LExpressionItem: TExpressionItemDir;
  LBindingExpression: TBindingExpression;
  LManager: TBindingManager;
  LOptions: TBindings.TCreateOptions;
begin
  Assert(FFormatExpressionObjects.Count = 0);
  Assert(FReverseFormatExpressionObjects.Count = 0);
  Assert(FClearExpressionObjects.Count = 0);

  if ControlComponent = nil then
    Exit;
  if SourceComponent = nil then
    Exit;
  LBindingExpression := nil;

  for LExpressionItem in FFormatExpressions do
  begin
    if (not Designing) and Managed then
    begin
      if NotifyOutputs then
        LOptions := [TBindings.TCreateOption.coNotifyOutput]
      else
        LOPtions := [];
      if not Assigned(BindingsList) then
        LManager := nil
      else
        LManager := BindingsList.FBindingsManager;
      case LExpressionItem.Direction of
        dirBidirectional, dirSourceToControl:
        begin
          LBindingExpression := TBindings.CreateManagedBinding(
            inherited GetComponentScopes(SourceComponent),
            LExpressionItem.SourceExpression,
            inherited GetComponentScopes(ControlComponent),
            LExpressionItem.ControlExpression,
            GetOutputConverter,
            TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
            LManager,
            LOptions
          );
         FFormatExpressionObjects.Add(LBindingExpression);
        end;
        dirControlToSource:
        begin
          LBindingExpression := TBindings.CreateManagedBinding(
            inherited GetComponentScopes(ControlComponent),
            LExpressionItem.ControlExpression,
            inherited GetComponentScopes(SourceComponent),
            LExpressionItem.SourceExpression,
            GetOutputConverter,
            TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
            LManager,
            LOptions
          );
         FReverseFormatExpressionObjects.Add(LBindingExpression);
        end;
      else
        Assert(False);
      end;
      case LExpressionItem.Direction of
        dirBidirectional:
        begin
          LBindingExpression := TBindings.CreateManagedBinding(
            inherited GetComponentScopes(ControlComponent),
            LExpressionItem.ControlExpression,
            inherited GetComponentScopes(SourceComponent),
            LExpressionItem.SourceExpression,
            GetOutputConverter,
            TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
            LManager,
            LOptions
          );
          FReverseFormatExpressionObjects.Add(LBindingExpression);
        end;
      end;
    end
    else
    begin
      LBindingExpression := TBindings.CreateUnmanagedBinding(
        inherited GetComponentScopes(SourceComponent),
        LExpressionItem.SourceExpression,
        inherited GetComponentScopes(ControlComponent),
        LExpressionItem.ControlExpression,
        GetOutputConverter,
        TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
        []  // Execute
      );


      FFormatExpressionObjects.Add(LBindingExpression);
    end;
  end;

  for LExpressionItem in FClearExpressions do
  begin
       case LExpressionItem.Direction of
        dirSourceToControl,
        dirBidirectional:
          LBindingExpression := TBindings.CreateUnmanagedBinding(
            inherited GetComponentScopes(SourceComponent),
            LExpressionItem.SourceExpression,
            inherited GetComponentScopes(ControlComponent),
            LExpressionItem.ControlExpression,
            GetOutputConverter,
            TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
            []  // Execute
          );
        dirControlToSource:
          LBindingExpression := TBindings.CreateUnmanagedBinding(
            inherited GetComponentScopes(ControlComponent),
            LExpressionItem.ControlExpression,
            inherited GetComponentScopes(SourceComponent),
            LExpressionItem.SourceExpression,
            GetOutputConverter,
            TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
            []  // Execute
          );
       else
         Assert(False);
       end;

       FClearExpressionObjects.Add(LBindingExpression);

  end;

end;

procedure TCustomBindExprItems.SetClearExpressions(const Value: TExpressionsDir);
begin
  FClearExpressions.Assign(Value);
end;

procedure TCustomBindExprItems.SetFormatExpressions(Value: TExpressionsDir);
begin
  FFormatExpressions.Assign(Value);
end;

procedure TCustomBindExprItems.EvaluateWithoutNotify;
var
  LExpressionItem: TExpressionItemDir;
  LBindingExpression: TBindingExpression;
begin
  if Managed then
  begin
    for LExpressionItem in FFormatExpressions do
    begin
      case LExpressionItem.Direction of
        dirSourceToControl,
        dirBidirectional:
        begin
          LBindingExpression := TBindings.CreateUnmanagedBinding(
              inherited GetComponentScopes(SourceComponent),
              LExpressionItem.SourceExpression,
              inherited GetComponentScopes(ControlComponent),
              LExpressionItem.ControlExpression,
              GetOutputConverter,
              TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
              []  // Execute
            );
          try
            LBindingExpression.Evaluate;
          finally
            LBindingExpression.Free;
          end;
        end;
      end;
  end;
  end
  else
  begin
    if FFormatExpressionObjects <> nil then
      for LBindingExpression in FFormatExpressionObjects do
        if LBindingExpression.Compiled then  // In case binding manager has been destroyed
          LBindingExpression.Evaluate;
  end;

end;

procedure TCustomBindExprItems.EvaluateFormat;
begin
  if not Active then
  begin
    FreeExpressionsObjects;
    UpdateExpressions;
  end;
  try
    EvaluateWithoutNotify;
  finally
    if not Active then
      FreeExpressionsObjects;
  end;
end;

procedure TCustomBindExprItems.EvaluateClear;
var
  LExpression: TBindingExpression;
begin
  if not Active then
  begin
    FreeExpressionsObjects;
    UpdateExpressions;
  end;
  try
    if FClearExpressionObjects <> nil then
      for LExpression in FClearExpressionObjects do
        if LExpression.Compiled then  // In case binding manager has been destroyed
          LExpression.Evaluate;
  finally
    if not Active then
      FreeExpressionsObjects;
  end;
end;

procedure TCustomBindExprItems.FreeExpressionsObjects;
begin
  inherited FreeExpressionObjects(FFormatExpressionObjects);
  inherited FreeExpressionObjects(FReverseFormatExpressionObjects);
  inherited FreeExpressionObjects(FClearExpressionObjects);
end;

procedure TCustomBindExprItems.Recompile;
var
  LExpression: TBindingExpression;
begin
  if FFormatExpressionObjects <> nil then
    for LExpression in FFormatExpressionObjects do
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.ReCompile;
  if FReverseFormatExpressionObjects <> nil then
    for LExpression in FReverseFormatExpressionObjects do
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.ReCompile;
  if FClearExpressionObjects <> nil then
    for LExpression in FClearExpressionObjects do
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.ReCompile;
end;

{ TCustomBindListLink }

constructor TCustomBindListLink.Create(AOwner: TComponent);
begin
  inherited;
  FControlObserver := TControlObserver.Create;
  FUpdateCounter := 0;
  FParseExpressions := TExpressions.Create(Self, TExpressionItem);
  FPosSourceExpressions := TExpressions.Create(Self, TExpressionItem);
  FPosControlExpressions := TExpressions.Create(Self, TExpressionItem);
  FParseExpressionObjects := TList<TBindingExpression>.Create;
  FPosControlExpressionObjects := TList<TBindingExpression>.Create;
  FPosSourceExpressionObjects := TList<TBindingExpression>.Create;
  FAutoFill := True;
  FDeprecatedBufferCount := -1;
end;

destructor TCustomBindListLink.Destroy;
begin
  SetActive(False);
  ClearEditingLink;
  FControlObserver.Free;
  FPosSourceExpressions.Free;
  FPosControlExpressions.Free;
  FParseExpressions.Free;
  inherited;
  FPosControlExpressionObjects.Free;
  FPosSourceExpressionObjects.Free;
  FParseExpressionObjects.Free;
end;

procedure TCustomBindListLink.EvaluatePosClear;
begin
  // No nothing.  Clear list will remove position
end;

procedure TCustomBindListLink.EvaluatePosSource;
var
  LExpression: TBindingExpression;
  LScopeLocks: IScopeLocks;
begin
  Supports(Self.SourceComponent, IScopeLocks, LScopeLocks);
  if LScopeLocks <> nil then
    LScopeLocks.PosLockEnter;
  try
    for LExpression in FPosSourceExpressionObjects do
    begin
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.Evaluate;
    end;
  finally
    if LScopeLocks <> nil then
      LScopeLocks.PosLockLeave;
  end;
end;

procedure TCustomBindListLink.ExecuteAssignToSourceExpression(
  const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
begin
  inherited;

end;

function TCustomBindListLink.GetCanModify: Boolean;
var
  Intf: IScopeEditLink;
begin
                                      
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Result := Intf.GetCanModify(Self)
  else
    Result := False;
end;

function TCustomBindListLink.GetActive: Boolean;
begin
  Result := FActive;
end;

function TCustomBindListLink.GetBindComp: TComponent;
begin
  Result := Self;
end;

function TCustomBindListLink.Edit: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
  begin
    Result := Intf.Edit(Self)
  end
  else
    Result := True;
end;

procedure TCustomBindListLink.BeginUpdate;
begin
  Inc(FUpdateCounter);
end;

procedure TCustomBindListLink.EndUpdate;
begin
  Dec(FUpdateCounter);
  if FUpdateCounter < 0 then
    FUpdateCounter := 0;
end;

procedure TCustomBindListLink.ClearEditingLink;
begin
  FControlObserver.Component := nil;
end;

procedure TCustomBindListLink.EvaluateClear(const AMemberName: string);
var
  LEditor: IBindListEditorCommon;
begin
  if Active then
  begin
    // Just like clear list except don't clear control
    LEditor := GetBindListEditor;
    LEditor.BeginUpdate;
    try
      LEditor.ClearList;
    finally
      LEditor.EndUpdate;
    end;
  end;
end;

procedure TCustomBindListLink.EvaluateFormat(const AMemberName: string);
var
  LEditor: IBindListEditor;
  LEditorScope: IScope;
  LScopeCurrentRecord: IScopeCurrentRecord;
  LScopeLocks: IScopeLocks;
begin
  if not Active then
    Exit;
  if Supports(SourceComponent, IScopeLocks, LScopeLocks) and LScopeLocks.PosLock then
    if not GetUpdating then
      Exit;
  Supports(GetBindListEditor, IBindListEditor, LEditor);
  if LEditor <> nil then
  begin
    Supports(SourceComponent, IScopeCurrentRecord, LScopeCurrentRecord);
    if LScopeCurrentRecord <> nil then
    begin
      LEditor.BeginUpdate;
      try
        LEditorScope := LEditor.CurrentItem;
        //Assert(LEditorScope <> nil);
        if LEditorScope <> nil then
          FillRecord(LScopeCurrentRecord.GetCurrentRecord(SourceMemberName), LEditorScope);
      finally
        LEditor.EndUpdate;
      end;
    end
    else
      Assert(False);
  end
  else
    Assert(False);

end;

procedure TCustomBindListLink.FillRecord(const ASourceScope, AEditorScope: IScope);
var
  LExpression: TExpressionItem;
begin
  for LExpression in FFormatExpressions do
  begin
    EvaluateExpressionItem(LExpression, AEditorScope, ASourceScope);
  end;
end;

procedure TCustomBindListLink.EvaluateParse(const AMemberName: string);
var
  LExpression: TBindingExpression;
begin
  if not Active then
    Exit;
    for LExpression in FParseExpressionObjects do
    begin
      if LExpression.Compiled then
        LExpression.Evaluate;
    end;
end;

procedure TCustomBindListLink.EvaluatePosControl;
var
  LExpression: TBindingExpression;
begin
  if FLockPosControl <> 0 then
    Exit;
  for LExpression in FPosControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

procedure TCustomBindListLink.FreeExpressionsObjects;
begin
  inherited;
  FreeExpressionObjects(FPosControlExpressionObjects);
  FreeExpressionObjects(FPosSourceExpressionObjects);
  FreeExpressionObjects(FParseExpressionObjects);
  FreeAndNil(FControlExpressionObject);
end;

function TCustomBindListLink.GetIsEditing: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
  begin
    Result := Intf.GetIsEditing(Self)
  end
  else
    Result := True;
end;

function TCustomBindListLink.GetIsModified: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Result := Intf.GetIsModified(Self)
  else
    Result := False;
end;

function TCustomBindListLink.GetUpdating: Boolean;
begin
  Result := FUpdateCounter > 0;
end;

function TCustomBindListLink.IsLinked: Boolean;
begin
  Result := True;
end;

function TCustomBindListLink.IsRequired: Boolean;
var
  LScopeEditor: IScopeEditor;
begin
  Result := False;
  if Supports(SourceComponent, IScopeEditor, LScopeEditor) then
  begin
    Result := LScopeEditor.IsRequired(SourceMemberName);
  end;
end;

procedure TCustomBindListLink.SetIsReadOnly(Value: Boolean);
var
  LScopeEditLink: IScopeEditLink;
begin
  if Supports(SourceComponent, IScopeEditLink, LScopeEditLink) then
    LScopeEditLink.SetReadOnly(Self, Value);
end;

function TCustomBindListLink.IsValidChar(AKey: Char): Boolean;
var
  LScopeEditor: IScopeEditor;
  LFieldName: string;
begin
  Result := True;
  LFieldName := SourceMemberName;
  if LFieldName = '' then
    raise TBindCompException.CreateFmt(sLinkFieldNotFound, [GetDisplayName]);
  if Supports(SourceComponent, IScopeEditor, LScopeEditor) then
    Result := LScopeEditor.IsValidChar(LFieldName, AKey);
end;

procedure TCustomBindListLink.PosChanged;
begin
  Inc(FLockPosControl);
  try
    EvaluatePosSource;
  finally
    Dec(FLockPosControl);
  end;
end;

procedure TCustomBindListLink.PosChanging;
var
  LScopeEditLink: IScopeEditLink;
begin
  if Supports(SourceComponent, IScopeEditLink, LScopeEditLink) then
    LScopeEditLink.PosChanging(Self);
end;

procedure TCustomBindListLink.Reset;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.Reset(Self)
end;

procedure TCustomBindListLink.ResetList;
begin
  if Active then
  begin
    if AutoFill then
      FillList;
    EvaluatePosControl;
  end;
end;

procedure TCustomBindListLink.ClearModified;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.ClearModified(Self);
end;

function TCustomBindListLink.RequiresControlHandler: Boolean;
begin
  if PosSourceExpressions.Count > 0 then
    Exit(True);
  if ParseExpressions.Count > 0 then
    Exit(True);
  Result := False;
end;

procedure TCustomBindListLink.CheckEditingLink;
begin
  FControlObserver.Component := ControlComponent;
  if ParseExpressions.Count > 0 then
    FControlObserver.EnsureObserving(TControlObserver.IDEditGridLinkObserver,
      function: IObserver
      begin
        Result := TBindEditGridLinkObserver.Create(Self);
      end);
  FControlObserver.EnsureObserving(TControlObserver.IDPositionLinkObserver,
    function: IObserver
    begin
      Result := TBindPositionLinkObserver.Create(Self);
    end);
end;

procedure TCustomBindListLink.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Loading then
    begin
      if not Designing then
        FDeferActive := Value
    end
    else
    begin
      ClearModified;
      if Value then
        DoOnActivating
      else
        DoOnDeactivating;

      FActive := Value;
      if FActive then
      begin
        try
          FreeExpressionsObjects;
          UpdateExpressions;
          if not Designing then
            if RequiresControlHandler then
            begin
              CheckEditingLink;
              if not FControlObserver.TrySetActive(True) then
                raise TBindCompException.CreateFmt(sNoControlObserverSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);
            end;
          if AutoFill then
            FillList;
          EvaluatePosControl;
        finally
          DoOnActivated;
        end;
      end
      else
      begin
        try
          if AutoFill then
            if (ControlComponent <> nil) and
              (not (csDestroying in ControlComponent.ComponentState)) then
              ClearList;
        finally
          FControlObserver.TrySetActive(False);
          FreeExpressionsObjects;
          DoOnDeactivated;
        end;
      end;
    end;
  end;
end;

procedure TCustomBindListLink.SetModified;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.SetModified(Self)
end;

procedure TCustomBindListLink.SetParseExpressions(const Value: TExpressions);
begin
  FParseExpressions.Assign(Value);
end;

procedure TCustomBindListLink.SetPosControlExpressions(
  const Value: TExpressions);
begin
  FPosControlExpressions.Assign(Value);
end;

procedure TCustomBindListLink.SetPosSourceExpressions(
  const Value: TExpressions);
begin
  FPosSourceExpressions.Assign(Value);
end;

procedure TCustomBindListLink.UpdateExpressions;
var
  LExpressionItem: TExpressionItem;
  LBindingExpression: TBindingExpression;
begin
  inherited;
  Assert(FPosSourceExpressionObjects.Count = 0);
  Assert(FPosControlExpressionObjects.Count = 0);
  Assert(FParseExpressionObjects.Count = 0);

  if ControlComponent = nil then
    Exit;
  if SourceComponent = nil then
    Exit;

  for LExpressionItem in FPosControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FPosControlExpressionObjects.Add(LBindingExpression);
  end;


  for LExpressionItem in FPosSourceExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(ControlComponent), // input
      LExpressionItem.ControlExpression,
      inherited GetComponentScopes(SourceComponent),  // output
      LExpressionItem.SourceExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FPosSourceExpressionObjects.Add(LBindingExpression);
  end;

  for LExpressionItem in FParseExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(ControlComponent), // input
      LExpressionItem.ControlExpression,
      inherited GetComponentScopes(SourceComponent, SourceMemberName),  // output
      LExpressionItem.SourceExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FParseExpressionObjects.Add(LBindingExpression);

  end;

  FControlExpressionObject := TBindings.CreateExpression(
    inherited GetComponentScopes(ControlComponent), //Input scopes
    'Self',
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
end;

procedure TCustomBindListLink.UpdateList;
var
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
begin
  Inc(FLockPosControl);
  try
    Supports(GetBindListEditor, IBindListEditor, LEditor);
    if LEditor <> nil then
    begin
      LEnumerator := GetScopeRecordEnumerator(SourceComponent, IsLinked);
      if LEnumerator <> nil then
        if LEditor.UpdateNeeded(LEnumerator) then
        begin
          LEditor.UpdateList(LEnumerator,
            procedure(const ASourceScope, AEditorScope: IScope)
            begin
              FillRecord(ASourceScope, AEditorScope);
            end);
        end
        else
        begin
          if LEditor.RowCount > 0 then
            EvaluateFormat('');
        end;
    end
    else
      Assert(False);
  finally
    Dec(FLockPosControl);
  end;
end;

procedure TCustomBindListLink.UpdateRecord;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.UpdateRecord(Self)
end;

procedure TCustomBindListLink.UpdateControlChanging;
begin
  inherited;  // Set active false
  Assert(BindListEditor = nil); // should have been released
  ClearEditingLink;
end;

{ TCustomBindGridListLink }

constructor TCustomBindGridListLink.Create(AOwner: TComponent);
begin
  inherited;
  FControlObserver := TControlObserver.Create;
  FUpdateCounter := 0;
  FParseExpressions := TExpressions.Create(Self, TExpressionItem);
  FPosSourceExpressions := TExpressions.Create(Self, TExpressionItem);
  FPosControlExpressions := TExpressions.Create(Self, TExpressionItem);
  FParseExpressionObjects := TList<TBindingExpression>.Create;
  FPosControlExpressionObjects := TList<TBindingExpression>.Create;
  FPosSourceExpressionObjects := TList<TBindingExpression>.Create;
  FAutoFill := True;
  FDeprecatedBufferCount := -1;
end;

destructor TCustomBindGridListLink.Destroy;
begin
  SetActive(False);
  ClearEditingLink;
  FControlObserver.Free;
  FPosSourceExpressions.Free;
  FPosControlExpressions.Free;
  FParseExpressions.Free;
  inherited;
  FPosControlExpressionObjects.Free;
  FPosSourceExpressionObjects.Free;
  FParseExpressionObjects.Free;
end;

procedure TCustomBindGridListLink.EvaluatePosClear;
begin
  // No nothing.  Clear list will remove position
end;

procedure TCustomBindGridListLink.EvaluatePosSource;
var
  LExpression: TBindingExpression;
  LScopeLocks: IScopeLocks;
begin
  Supports(Self.SourceComponent, IScopeLocks, LScopeLocks);
  if LScopeLocks <> nil then
    LScopeLocks.PosLockEnter;
  try
    for LExpression in FPosSourceExpressionObjects do
    begin
      if LExpression.Compiled then  // In case binding manager has been destroyed
        LExpression.Evaluate;
    end;
  finally
    if LScopeLocks <> nil then
      LScopeLocks.PosLockLeave;
  end;
end;

function TCustomBindGridListLink.GetCanModify: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Result := Intf.GetCanModify(Self)
  else
    Result := False;
end;

function TCustomBindGridListLink.GetActive: Boolean;
begin
  Result := FActive;
end;

function TCustomBindGridListLink.GetBindComp: TComponent;
begin
  Result := Self;
end;

function TCustomBindGridListLink.Edit: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
  begin
    Result := Intf.Edit(Self)
  end
  else
    Result := True;
end;

procedure TCustomBindGridListLink.BeginUpdate;
begin
  Inc(FUpdateCounter);
end;

procedure TCustomBindGridListLink.EndUpdate;
begin
  Dec(FUpdateCounter);
  if FUpdateCounter < 0 then
    FUpdateCounter := 0;
end;

procedure TCustomBindGridListLink.ClearEditingLink;
begin
  FControlObserver.Component := nil;
end;

procedure TCustomBindGridListLink.EvaluateClear(const AMemberName: string);
var
  LEditor: IBindListEditorCommon;
begin
  if Active then
  begin
    // Just like clear list except don't clear control
    LEditor := GetBindListEditor;
    LEditor.BeginUpdate;
    try
      LEditor.ClearList;
    finally
      LEditor.EndUpdate;
    end;
  end;
end;

procedure TCustomBindGridListLink.EvaluateFormat(const AMemberName: string);
var
  LEditor: IBindListEditor;
  LEditorScope: IScope;
  LScopeCurrentRecord: IScopeCurrentRecord;
  LScopeLocks: IScopeLocks;
begin
  if not Active then
    Exit;
  if Supports(SourceComponent, IScopeLocks, LScopeLocks) and LScopeLocks.PosLock then
    if not GetUpdating then
      Exit;
  Supports(GetBindListEditor, IBindListEditor, LEditor);
  if LEditor <> nil then
  begin
    Supports(SourceComponent, IScopeCurrentRecord, LScopeCurrentRecord);
    if LScopeCurrentRecord <> nil then
    begin
      LEditor.BeginUpdate;
      try
        LEditorScope := LEditor.CurrentItem;
        if LEditorScope <> nil then
          FillRecord(LEditor,
              procedure()
              var
                LExpression: TExpressionItem;
                LColumnExpressionItem: TColumnFormatExpressionItem;
                LExpressions: TExpressions;
              begin
                  //Assert(FColumnExpressions.Count > 0);
                  for LColumnExpressionItem in FColumnExpressions do
                  begin
                    if LColumnExpressionItem.FormatCellExpressions.Count > 0 then
                      LExpressions := LColumnExpressionItem.FormatCellExpressions
                    else
                      LExpressions := nil;
                    if LExpressions <> nil then
                    begin
                      for LExpression in LExpressions do
                        EvaluateExpressionItem(LColumnExpressionItem, LExpression, LEditorScope,
                         LScopeCurrentRecord.GetCurrentRecord(LColumnExpressionItem.SourceMemberName));
                  end;
                end;
              end);
      finally
        LEditor.EndUpdate;
      end;
    end
    else
      Assert(False);
  end
  else
    Assert(False);

end;

procedure TCustomBindGridListLink.EvaluateParse(const AMemberName: string);
var
  LExpression: TBindingExpression;
begin
  if not Active then
    Exit;
    for LExpression in FParseExpressionObjects do
    begin
      if LExpression.Compiled then
        LExpression.Evaluate;
    end;
end;

procedure TCustomBindGridListLink.EvaluatePosControl;
var
  LExpression: TBindingExpression;
begin
  if FLockPosControl <> 0 then
    Exit;
  for LExpression in FPosControlExpressionObjects do
  begin
    if LExpression.Compiled then  // In case binding manager has been destroyed
      LExpression.Evaluate;
  end;
end;

procedure TCustomBindGridListLink.FreeExpressionsObjects;
begin
  inherited;
  FreeExpressionObjects(FPosControlExpressionObjects);
  FreeExpressionObjects(FPosSourceExpressionObjects);
  FreeExpressionObjects(FParseExpressionObjects);
  FreeAndNil(FControlExpressionObject);
end;

function TCustomBindGridListLink.GetIsEditing: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
  begin
    Result := Intf.GetIsEditing(Self)
  end
  else
    Result := True;
end;

function TCustomBindGridListLink.GetIsModified: Boolean;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Result := Intf.GetIsModified(Self)
  else
    Result := False;
end;

function TCustomBindGridListLink.GetUpdating: Boolean;
begin
  Result := FUpdateCounter > 0;
end;

function TCustomBindGridListLink.IsLinked: Boolean;
begin
  Result := True;
end;

function TCustomBindGridListLink.IsRequired: Boolean;
var
  LScopeEditor: IScopeEditor;
begin
  Result := False;
  if Supports(SourceComponent, IScopeEditor, LScopeEditor) then
  begin
    Result := LScopeEditor.IsRequired(SourceMemberName);
  end;
end;

procedure TCustomBindGridListLink.SetIsReadOnly(Value: Boolean);
var
  LScopeEditLink: IScopeEditLink;
begin
  if Supports(SourceComponent, IScopeEditLink, LScopeEditLink) then
    LScopeEditLink.SetReadOnly(Self, Value);
end;

function TCustomBindGridListLink.IsValidChar(AKey: Char): Boolean;
var
  LScopeEditor: IScopeEditor;
  LFieldName: string;
begin
  Result := True;
  LFieldName := SourceMemberName;
  if LFieldName = '' then
    raise TBindCompException.CreateFmt(sLinkFieldNotFound, [GetDisplayName]);
  if Supports(SourceComponent, IScopeEditor, LScopeEditor) then
    Result := LScopeEditor.IsValidChar(LFieldName, AKey);
end;

procedure TCustomBindGridListLink.PosChanged;
begin
  Inc(FLockPosControl);
  try
    EvaluatePosSource;
  finally
    Dec(FLockPosControl);
  end;
end;

procedure TCustomBindGridListLink.PosChanging;
var
  LScopeEditLink: IScopeEditLink;
begin
  if Supports(SourceComponent, IScopeEditLink, LScopeEditLink) then
    LScopeEditLink.PosChanging(Self);
end;

procedure TCustomBindGridListLink.Reset;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.Reset(Self)
end;

procedure TCustomBindGridListLink.ResetList;
begin
  if Active then
  begin
    if AutoFill then
      //FillList;
      FillList;
    EvaluatePosControl;
  end;
end;

procedure TCustomBindGridListLink.ClearModified;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.ClearModified(Self);
end;

function TCustomBindGridListLink.RequiresControlHandler: Boolean;
begin
  if PosSourceExpressions.Count > 0 then
    Exit(True);
  if ParseExpressions.Count > 0 then
    Exit(True);
  Result := False;
end;

procedure TCustomBindGridListLink.CheckEditingLink;
begin
  FControlObserver.Component := ControlComponent;
  if ParseExpressions.Count > 0 then
    FControlObserver.EnsureObserving(TControlObserver.IDEditGridLinkObserver,
      function: IObserver
      begin
        Result := TBindEditGridLinkObserver.Create(Self);
      end);
  FControlObserver.EnsureObserving(TControlObserver.IDPositionLinkObserver,
    function: IObserver
    begin
      Result := TBindPositionLinkObserver.Create(Self);
    end);
end;

procedure TCustomBindGridListLink.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Loading then
    begin
      if not Designing then
        FDeferActive := Value
    end
    else
    begin
      ClearModified;
      if Value then
        DoOnActivating
      else
        DoOnDeactivating;

      FActive := Value;
      if FActive then
      begin
        try
          FreeExpressionsObjects;
          UpdateExpressions;
          if not Designing then
            if RequiresControlHandler then
            begin
              CheckEditingLink;
              if not FControlObserver.TrySetActive(True) then
                raise TBindCompException.CreateFmt(sNoControlObserverSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);
            end;
          if AutoFill then
            FillList;
          EvaluatePosControl;
        finally
          DoOnActivated;
        end;
      end
      else
      begin
        try
          if AutoFill then
            if (ControlComponent <> nil) and
              (not (csDestroying in ControlComponent.ComponentState)) then
              ClearList;
        finally
          FControlObserver.TrySetActive(False);
          FreeExpressionsObjects;
          DoOnDeactivated;
        end;
      end;
    end;
  end;
end;

procedure TCustomBindGridListLink.SetModified;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.SetModified(Self)
end;

procedure TCustomBindGridListLink.SetParseExpressions(const Value: TExpressions);
begin
  FParseExpressions.Assign(Value);
end;

procedure TCustomBindGridListLink.SetPosControlExpressions(
  const Value: TExpressions);
begin
  FPosControlExpressions.Assign(Value);
end;

procedure TCustomBindGridListLink.SetPosSourceExpressions(
  const Value: TExpressions);
begin
  FPosSourceExpressions.Assign(Value);
end;

procedure TCustomBindGridListLink.UpdateExpressions;
var
  LExpressionItem: TExpressionItem;
  LBindingExpression: TBindingExpression;
begin
  inherited;
  Assert(FPosSourceExpressionObjects.Count = 0);
  Assert(FPosControlExpressionObjects.Count = 0);
  Assert(FParseExpressionObjects.Count = 0);

  if ControlComponent = nil then
    Exit;
  if SourceComponent = nil then
    Exit;

  for LExpressionItem in FPosControlExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(SourceComponent),
      LExpressionItem.SourceExpression,
      inherited GetComponentScopes(ControlComponent),
      LExpressionItem.ControlExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FPosControlExpressionObjects.Add(LBindingExpression);
  end;


  for LExpressionItem in FPosSourceExpressions do
  begin
    CheckUnidirectionalDataSource(SourceComponent, Self);
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(ControlComponent), // input
      LExpressionItem.ControlExpression,
      inherited GetComponentScopes(SourceComponent),  // output
      LExpressionItem.SourceExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FPosSourceExpressionObjects.Add(LBindingExpression);
  end;

  for LExpressionItem in FParseExpressions do
  begin
    LBindingExpression := TBindings.CreateUnmanagedBinding(
      inherited GetComponentScopes(ControlComponent), // input
      LExpressionItem.ControlExpression,
      inherited GetComponentScopes(SourceComponent, SourceMemberName),  // output
      LExpressionItem.SourceExpression,
      GetOutputConverter,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated),
      []  // Execute
    );
    FParseExpressionObjects.Add(LBindingExpression);

  end;

  FControlExpressionObject := TBindings.CreateExpression(
    inherited GetComponentScopes(ControlComponent), //Input scopes
    'Self',
    TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
  );
end;

procedure TCustomBindGridListLink.UpdateList;
var
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
begin
  Inc(FLockPosControl);
  try
    Supports(GetBindListEditor, IBindListEditor, LEditor);
    if LEditor <> nil then
    begin
      LEnumerator := GetScopeRecordEnumerator;
      if LEnumerator <> nil then
        if LEditor.UpdateNeeded(LEnumerator) then
        begin
          GetBindingExpressions(LEnumerator, LEditor,
            procedure(AExpressions: TArrayListCellExpression)
            begin
            LEditor.UpdateList(LEnumerator,
              procedure(const ASourceScope, AEditorScope: IScope)
              begin
                FillRecord(LEditor, //AEditorScope,
                  procedure()//AItem: TColumnFormatExpressionItem)
                  var
                    LExpression: TEvalEnumeratorToEditor;
                    LExpressions: TList<TEvalEnumeratorToEditor>;
                  begin
                    for LExpressions in  AExpressions do
                      for LExpression in LExpressions do
                        LExpression.Evaluate;
                  end);
              end);
            end);
        end
        else
        begin
          if LEditor.RowCount > 0 then
            EvaluateFormat('');
        end;
    end
    else
      Assert(False);
  finally
    Dec(FLockPosControl);
  end;
end;

procedure TCustomBindGridListLink.UpdateRecord;
var
  Intf: IScopeEditLink;
begin
  if Supports(Sourcecomponent, IScopeEditLink, Intf) then
    Intf.UpdateRecord(Self)
end;

procedure TCustomBindGridListLink.UpdateControlChanging;
begin
  inherited;  // Set active false
  Assert(BindListEditor = nil); // Should have been release
  ClearEditingLink;
end;


{ TActivatedContainedBindComponent }

procedure TActivatedContainedBindComponent.BindActivate(Value: Boolean);
begin
  if Active <> Value then
  begin
    if Value then
    begin
      if GetAutoActivate and CanActivate and ((not Designing) or CanDesignActivate)then
        SetActive(True)
    end
    else
      SetActive(False)
  end;
end;

procedure TActivatedContainedBindComponent.LoadActivate;
begin
  ApplyComponents;
  // No Check for CanActivate
  if AutoActivate and ((not Designing) or CanDesignActivate) then
  begin
    if not ActivateFromSource then
      SetActive(True);
  end;
end;

function TActivatedContainedBindComponent.ActivateFromSource: Boolean;
var
  LScopeActive: IScopeActive;
begin
  Result := Supports(SourceComponent, IScopeActive, LScopeActive);
  if Result then
    SetActive(LScopeActive.Active);
end;

function TActivatedContainedBindComponent.CanActivate: Boolean;
begin
  Result := (SourceComponent <> nil) and (GetControlComponent <> nil) and
    not (csDestroying in SourceComponent.ComponentState) and
    not (csDestroying in GetControlComponent.ComponentState);
end;

function TActivatedContainedBindComponent.CanDesignActivate: Boolean;
var
  LScopeActive: IScopeActive;
begin
  Result := (ControlComponent <> nil)
  and (SourceComponent <> nil);
  if Result  then
    if Supports(SourceComponent, IScopeActive, LScopeActive) then
      Result := LScopeActive.Active;
end;

constructor TActivatedContainedBindComponent.Create(AOwner: TComponent);
begin
  inherited;
  FAutoActivate := True;
end;

function TActivatedContainedBindComponent.GetAutoActivate: Boolean;
begin
  Result := FAutoActivate;
end;

procedure TActivatedContainedBindComponent.RemoveScopeExpressions;
var
  LScopeExpressions: IScopeExpressions;
begin
  if Supports(SourceComponent, IScopeExpressions, LScopeExpressions) then
    LScopeExpressions.RemoveExpression(Self);
end;

procedure TActivatedContainedBindComponent.SetAutoActivate(AValue: Boolean);
begin
  if FAutoActivate <> AValue then
  begin
    UpdateEnableChanging;
    FAutoActivate := AValue;
    UpdateEnableChanged;
  end;
end;

procedure TActivatedContainedBindComponent.DesignAutoActivateOnPropertyChange;
var
  LScopeActive: IScopeActive;
begin
  if not (csDestroying in ComponentState) then
  begin
    Supports(SourceComponent, IScopeActive, LScopeActive);
    if (LScopeActive = nil) or (LScopeActive.Active) then
      if (not Active) and (not Loading) and Designing and CanDesignActivate and AutoActivate then
        if CanActivate then
          SetActive(True);
  end;
end;

procedure TActivatedContainedBindComponent.UpdateSourceChanged;
begin
  inherited;
  if SourceComponent <> nil then
    AddScopeExpressions;
  if not Loading then
    ApplyComponents;
  DesignAutoActivateOnPropertyChange;
end;

procedure TActivatedContainedBindComponent.UpdateSourceChanging;
begin
  inherited;
  if SourceComponent <> nil then
    RemoveScopeExpressions;
  if GetActive then
    SetActive(False);
end;

procedure TActivatedContainedBindComponent.UpdateControlChanged;
begin
  inherited;
  if not Loading  then
    ApplyComponents;
  DesignAutoActivateOnPropertyChange;
end;

procedure TActivatedContainedBindComponent.UpdateControlChanging;
begin
  inherited;
  if GetActive then
    SetActive(False);
end;

procedure TActivatedContainedBindComponent.UpdateSourceMemberChanged;
begin
  inherited;
  if not Loading then
    ApplyComponents;
  DesignAutoActivateOnPropertyChange;
end;

procedure TActivatedContainedBindComponent.UpdateSourceMemberChanging;
begin
  inherited;
  if GetActive and (not CanActivate) then
    SetActive(False);
end;

procedure TActivatedContainedBindComponent.UpdateEnableChanging;
begin

end;

procedure TActivatedContainedBindComponent.UpdateEnableChanged;
begin
  if (not Loading) and  Designing and CanDesignActivate then
    SetActive(AutoActivate);
end;


procedure TActivatedContainedBindComponent.AddScopeExpressions;
var
  LScopeExpressions: IScopeExpressions;
begin
  if Supports(SourceComponent, IScopeExpressions, LScopeExpressions) then
    LScopeExpressions.AddExpression(Self);
end;

procedure TActivatedContainedBindComponent.ApplyComponents;
begin
//
end;

{ TMethods }

procedure TMethods.Update(Item: TCollectionItem);
begin
  if Owner is TCustomBindingsList then
    TCustomBindingsList(Owner).FMethodsScope := nil;
end;

{ TOutputConverters }

procedure TOutputConverters.Update(Item: TCollectionItem);
begin
  if Owner is TCustomBindingsList then
    TCustomBindingsList(Owner).FOutputConverter := nil;
end;


{ TEnumerableWrapper }

constructor TEnumerableWrapper.Create(AObject: TObject; AParentScope: IScope);
begin
  FObject := AObject;
  FParentScope := AParentScope;
  FRttiType := FContext.GetType(FObject.ClassType);
end;

destructor TEnumerableWrapper.Destroy;
begin
  FEnumerator.Free;
  inherited;
end;

procedure TEnumerableWrapper.First;
begin
  if FEnumerating then
  begin
    FreeAndNil(FEnumerator);
    FEnumerating := False;
  end;
end;

function TEnumerableWrapper.GetEnumerator: TObject;
var
  LMethod: TRttiMethod;
  LArgs: TArray<TValue>;
  LValue: TValue;
begin
  if FEnumerator = nil then
  begin
    LMethod := FRttiType.GetMethod('GetEnumerator');
    if Assigned(LMethod) then
    begin
      LValue := LMethod.Invoke(FObject, LArgs);
      if LValue.IsObject then
        FEnumerator := LValue.AsObject
    end
    else
      FEnumerator := nil;
  end;
  Result := FEnumerator;
end;

function TEnumerableWrapper.GetCurrent: IScope;
var
  LEnumerator: TObject;
begin
  LEnumerator := GetEnumerator;
  if LEnumerator = nil then
    Exit(nil);
  Result := WrapObject(LEnumerator);
  if FParentScope <> nil then
    Result := TNestedScope.Create(Result, FParentScope)

end;

function TEnumerableWrapper.GetMemberCurrent(const AMemberName: string): IScope;
begin
  Result := GetCurrent;
end;

function TEnumerableWrapper.GetRecordCount: Integer;
begin
  Result := 2;
end;

function TEnumerableWrapper.MoveNext: Boolean;
var
  LMethod: TRttiMethod;
  LArgs: TArray<TValue>;
  LValue: TValue;
  LRttiType: TRttiType;
  LEnumerator: TObject;
begin
  LEnumerator := GetEnumerator;
  if LEnumerator = nil then
    Exit(False);
  LRttiType := FContext.GetType(LEnumerator.ClassType);
  LMethod := LRttiType.GetMethod('MoveNext');
  Result := False;
  try
    if Assigned(LMethod) then
    begin
      LValue := LMethod.Invoke(LEnumerator, LArgs);
      if LValue.IsType<Boolean>  then
        Result := LValue.AsBoolean
      else
        Result := False;
    end
    else
      Result := False;
  finally
    if Result then
      FEnumerating := True;
  end;
end;

{ TControlObservers }

function TControlObserver.EnsureObserving(const ID: Integer;
  AFunc: TFunc<IObserver>): Boolean;
begin
  Result := IsObserving(ID);
  if not Result then
  begin
    Result := AddObserver(ID, AFunc);
  end;
end;

function TControlObserver.GetEditGridLink: IEditGridLinkObserver;
begin
  Supports(GetObserver(IDEditGridLinkObserver), IEditGridLinkObserver, Result);
end;

function TControlObserver.GetEditLink: IEditLinkObserver;
begin
  Supports(GetObserver(IDEditLinkObserver), IEditLinkObserver, Result);
end;

function TControlObserver.GetPositionLinkObserver: IPositionLinkObserver;
begin
  Supports(GetObserver(IDPositionLinkObserver), IPositionLinkObserver, Result);
end;

function TControlObserver.GetControlValueObserver: IControlValueObserver;
begin
  Supports(GetObserver(IDControlValueObserver), IControlValueObserver, Result);
end;

function TControlObserver.GetObserver(const ID: Integer): IObserver;
begin
  if not FDictionary.TryGetValue(ID, Result) then
    Result := nil;
end;

function TControlObserver.IsObserving(const ID: Integer): Boolean;
begin
  Result := FDictionary.ContainsKey(ID);
end;

function TControlObserver.AddObserver(const ID: Integer;
  AFunc: TFunc<IObserver>): Boolean;
var
  LObservers: TObservers;
  LIntf: IObserver;
begin
  Result := False;
  if FComponent <> nil then
  begin
    LObservers := FComponent.Observers;
    if LObservers.CanObserve(ID) then
    begin
      LIntf := AFunc;  // Will be released if not added
      if LIntf <> nil then
      begin
        LObservers.AddObserver(ID, LIntf);
        Result := True;
        FDictionary.Add(ID, LIntf);
      end;
    end;
  end;
end;

procedure TControlObserver.RemoveObserver(const ID: Integer);
var
  LObservers: TObservers;
  LIntf: IObserver;
begin
  if FDictionary.TryGetValue(ID, LIntf) then
  try
    if (LIntf <> nil) and (FComponent <> nil) then
    begin
      LObservers := FComponent.Observers;
      LObservers.RemoveObserver(ID, LIntf);
    end;
  finally
    FDictionary.Remove(ID);
  end;
end;

procedure TControlObserver.SetComponent(const Value: TComponent);
begin
  if FComponent <> Value then
  begin
    Clear;
    FComponent := Value;
  end;
end;

function TControlObserver.TrySetActive(AValue: Boolean): Boolean;
var
  LPair: TPair<Integer, IObserver>;
begin
  Result := False;
  for LPair in FDictionary do
  begin
    if LPair.Value <> nil then
    begin
      LPair.Value.Active := AValue;
      Result := True;
    end;
  end;
end;

procedure TControlObserver.Clear;
begin
  RemoveObservers;
end;

procedure TControlObserver.RemoveObservers;
var
  LID: Integer;
begin
  try
    // Use toarray because RemoveObserver modifies FDictionary
    for LID in FDictionary.Keys.ToArray do
    begin
      RemoveObserver(LID);
    end;
  finally
    FDictionary.Clear;
  end;
end;

constructor TControlObserver.Create;
begin
  FDictionary := TDictionary<Integer, IObserver>.Create;
end;

destructor TControlObserver.Destroy;
begin
  Clear;
  FDictionary.Free;
  inherited;
end;

type
  TInternalBindLink = class(TCustomBindLink)
  private
    [weak] FBindComponentDelegate: TBindComponentDelegate;
    procedure RegenerateExpressions;
  protected
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName,
      ANewMemberName: string); override;
    function GetUseEvalShortcuts: Boolean; override;
    function GetSourceScopes: TArray<IScope>; override;
    procedure ApplyComponents; override;
    function GetBindingsList: TCustomBindingsList; override;
    function CanActivate: Boolean; override;
    function RequiresControlHandler: Boolean; override;
    function GetDisplayName: string; override;
    function Designing: Boolean; override;
    function Loading: Boolean; override;
    procedure DoOnActivating; override;
    procedure DoOnActivated; override;
    procedure DoOnDeactivated; override;
  public
    constructor Create(ABindDBControlLink: TBindComponentDelegate); reintroduce;
  end;

  TInternalBindGridListLookup = class(TCustomBindGridListLookup, IBindListRefreshing)
  private
    [weak] FBindComponentDelegate: TBindComponentDelegate;
    FListRefreshing: TNotifyEvent;
    FDeactivating: Boolean;
    procedure RegenerateExpressions;
  protected
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName,
      ANewMemberName: string); override;
    procedure ApplyComponents; override;
    function GetBindingsList: TCustomBindingsList; override;
    function CanActivate: Boolean; override;
    function GetDisplayName: string; override;
    function Designing: Boolean; override;
    function Loading: Boolean; override;
    procedure DoOnActivating; override;
    procedure DoOnDeactivated; override;
    procedure DoOnDeactivating; override;
    procedure DoOnActivated; override;
    procedure ResetList; override;
    function GetUseEvalShortcuts: Boolean; override;
    { IBindListRefreshing }
    function GetListRefreshing: TNotifyEvent;
    procedure SetListRefreshing(AEvent: TNotifyEvent);
  public
    constructor Create(ABindComponentDelegate: TBindComponentDelegate); reintroduce;
    procedure FillList; override;
    procedure ClearList; override;
  end;

  TInternalBindGridListLink = class(TCustomBindGridListLink, IBindLink, IBindListRefresh, IBindListRefreshing)
  private
    [weak] FBindComponentDelegate: TLinkControlToFieldDelegate;
    FListRefreshing: TNotifyEvent;
    FDeactivating: Boolean;
    procedure RegenerateExpressions;
    function BindLinkGetSourceMemberName: string;
  protected
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName,
      ANewMemberName: string); override;
    procedure ApplyComponents; override;
    function GetBindingsList: TCustomBindingsList; override;
    function CanActivate: Boolean; override;
    function GetDisplayName: string; override;
    function Designing: Boolean; override;
    function Loading: Boolean; override;
    procedure DoOnActivating; override;
    procedure DoOnDeactivated; override;
    procedure DoOnDeactivating; override;
    procedure DoOnActivated; override;
    function IBindLink.GetSourceMemberName = BindLinkGetSourceMemberName;
    procedure ResetList; override;
    { IBindListRefresh }
    procedure RefreshList;
    function RefreshNeeded: Boolean;
    { IBindListRefreshing }
    function GetListRefreshing: TNotifyEvent;
    procedure SetListRefreshing(AEvent: TNotifyEvent);
    function GetUseEvalShortcuts: Boolean; override;
  public
    constructor Create(ABindDBControlLink: TLinkControlToFieldDelegate); reintroduce;
    procedure FillList; override;
    procedure ClearList; override;
  end;

  TInternalBindControlValue = class(TCustomBindControlValue)
  private
    [weak] FBindComponentDelegate: TLinkControlDelegate;
    procedure RegenerateExpressions;
  protected
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName,
      ANewMemberName: string); override;
    procedure ApplyComponents; override;
    function GetBindingsList: TCustomBindingsList; override;
    function CanActivate: Boolean; override;
    function RequiresControlHandler: Boolean; override;
    function GetDisplayName: string; override;
    function Designing: Boolean; override;
    function Loading: Boolean; override;
    procedure DoOnActivating; override;
    procedure DoOnActivated; override;
    procedure DoOnDeactivated; override;
  public
    constructor Create(ABindDBControlLink: TCustomLinkControlToProperty); reintroduce; overload;
    constructor Create(ABindDBControlLink: TCustomLinkControlToField); reintroduce; overload;
  end;


{ TInternalBindLink }

function TInternalBindLink.CanActivate: Boolean;
begin
  Result := inherited and FBindComponentDelegate.CanActivate(Self);
end;

function TInternalBindLink.GetBindingsList: TCustomBindingsList;
begin
  Assert(FBindComponentDelegate <> nil);
  Result := FBindComponentDelegate.BindingsList;
end;

function TInternalBindLink.Loading: Boolean;
begin
  Assert(FBindComponentDelegate <> nil);
 Result := csLoading in FBindComponentDelegate.ComponentState;
end;

function TInternalBindLink.RequiresControlHandler: Boolean;
begin
  Assert(FBindComponentDelegate <> nil);
  Result := FBindComponentDelegate.RequiresControlHandler;
end;

constructor TInternalBindLink.Create(ABindDBControlLink: TBindComponentDelegate);
begin
  inherited Create(nil);
  FBindComponentDelegate := ABindDBControlLink;
end;

function TInternalBindLink.Designing: Boolean;
begin
  Result := csDesigning in FBindComponentDelegate.ComponentState;
end;

function TInternalBindLink.GetDisplayName: string;
begin
  Assert(FBindComponentDelegate <> nil);
  Result := FBindComponentDelegate.Name;
end;

function TInternalBindLink.GetSourceScopes: TArray<IScope>;
begin
  Assert(FBindComponentDelegate <> nil);
  Result := inherited GetSourceScopes;
  Result := FBindComponentDelegate.GetSourceScopes(Self, Result);
end;

procedure TInternalBindLink.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
  Assert(FBindComponentDelegate <> nil);
  FBindComponentDelegate.MemberRenaming(Self, AComponent, ACurMemberName, ANewMemberName);
end;

procedure TInternalBindLink.DoOnActivated;
begin
  // Must generate expression when dataset is active in
  // order to retrieve fields
  Assert(FBindComponentDelegate <> nil);
  FBindComponentDelegate.Activated(Self);
  inherited;
end;

procedure TInternalBindLink.DoOnActivating;
begin
  // Must generate expression when dataset is active in
  // order to retrieve fields
  RegenerateExpressions;
  inherited;
end;

function TInternalBindLink.GetUseEvalShortcuts: Boolean;
begin
  Result := False;
end;

procedure TInternalBindLink.RegenerateExpressions;
begin
  // Must generate expression when dataset is active in
  // order to retrieve fields
  Assert(FBindComponentDelegate <> nil);
  FBindComponentDelegate.ClearGeneratedExpressions(Self);
  if not (csDestroying in FBindComponentDelegate.ComponentState) then
    FBindComponentDelegate.GenerateExpressions(Self);
end;

procedure TInternalBindLink.DoOnDeactivated;
begin
  Assert(FBindComponentDelegate <> nil);
  FBindComponentDelegate.ClearGeneratedExpressions(Self);
  inherited;
end;

procedure Reactivate(AComponent: TContainedBindComponent; AIsActive: TFunc<Boolean>;
  ASetActive: TProc<Boolean>; ASetAutoActivate: TProc<Boolean>); forward;

procedure TInternalBindLink.ApplyComponents;
begin
  Assert(FBindComponentDelegate <> nil);
  if FBindComponentDelegate.GetActive then
  begin
    if not Loading then
      if FBindComponentDelegate.CanActivate(Self) then
        FBindComponentDelegate.Reactivate;
  end;

  inherited;
end;


{ TInternalBindGridListLookup }

function TInternalBindGridListLookup.CanActivate: Boolean;
begin
  Result := (inherited CanActivate) and
    FBindComponentDelegate.CanActivate(Self);
end;

procedure TInternalBindGridListLookup.ClearList;
begin
  if (not Active) and (not FDeactivating) then
    Self.FBindComponentDelegate.GenerateExpressions(Self);
  inherited;
  if (not Active) and (not FDeactivating) then
    Self.FBindComponentDelegate.ClearGeneratedExpressions(Self);
end;

function TInternalBindGridListLookup.GetBindingsList: TCustomBindingsList;
begin
  Result := FBindComponentDelegate.BindingsList;
end;

function TInternalBindGridListLookup.Loading: Boolean;
begin
  Result := csLoading in FBindComponentDelegate.ComponentState;
end;

constructor TInternalBindGridListLookup.Create(ABindComponentDelegate: TBindComponentDelegate);
begin
  inherited Create(nil);
  FBindComponentDelegate := ABindComponentDelegate;
end;

function TInternalBindGridListLookup.Designing: Boolean;
begin
  Result := csDesigning in FBindComponentDelegate.ComponentState;
end;

function TInternalBindGridListLookup.GetDisplayName: string;
begin
  Result := FBindComponentDelegate.Name;
end;

function TInternalBindGridListLookup.GetUseEvalShortcuts: Boolean;
begin
  Result := FBindComponentDelegate.GetUseEvalShortcuts;
end;

procedure TInternalBindGridListLookup.DoOnActivated;
begin
  FBindComponentDelegate.Activated(Self);
  inherited;
end;

procedure TInternalBindGridListLookup.DoOnActivating;
begin
  FDeactivating := False;
  // Must generate expression when dataset is active in
  // order to retrieve fields
  RegenerateExpressions;
  inherited;
end;

procedure TInternalBindGridListLookup.RegenerateExpressions;
begin
  // Must generate expression when dataset is active in
  // order to retrieve fields
  FBindComponentDelegate.ClearGeneratedExpressions(Self);
  if not (csDestroying in FBindComponentDelegate.ComponentState) then
    FBindComponentDelegate.GenerateExpressions(Self);
end;

procedure TInternalBindGridListLookup.DoOnDeactivated;
begin
  try
    FBindComponentDelegate.ClearGeneratedExpressions(Self);
    inherited;
  finally
    FDeactivating := False;
  end;
end;

procedure TInternalBindGridListLookup.DoOnDeactivating;
begin
 inherited;
 FDeactivating := True;
end;

procedure TInternalBindGridListLookup.FillList;
begin
  // Filling/FilledList events fired by ancestor
  if not Active then
    Self.FBindComponentDelegate.GenerateExpressions(Self);
  try
    inherited;
  finally
    if not Active then
      Self.FBindComponentDelegate.ClearGeneratedExpressions(Self);
  end;
end;

procedure TInternalBindGridListLookup.ApplyComponents;
begin
  if FBindComponentDelegate.GetActive then
    if not Loading then
      FBindComponentDelegate.Reactivate;

  inherited;
end;

procedure TInternalBindGridListLookup.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
  FBindComponentDelegate.MemberRenaming(Self, AComponent, ACurMemberName, ANewMemberName);
end;

procedure TInternalBindGridListLookup.SetListRefreshing(AEvent: TNotifyEvent);
begin
  FListRefreshing := AEvent;
end;

function TInternalBindGridListLookup.GetListRefreshing: TNotifyEvent;
begin
  Result := FListRefreshing;
end;

procedure TInternalBindGridListLookup.ResetList;
begin
  inherited;
end;

{ TInternalBindGridListLink }

function TInternalBindGridListLink.BindLinkGetSourceMemberName: string;
begin
  if FBindComponentDelegate.GetDisplaysMultipleSourceMembers then
    // Causes list item to be reformatted when any field changes
    Result := ''
  else
    // Causes list item to be reformatted when SourceMemberName changes
    Result := Self.SourceMemberName;
end;

function TInternalBindGridListLink.CanActivate: Boolean;
begin
  Result := (inherited CanActivate) and FBindComponentDelegate.CanActivate(Self);
end;

procedure TInternalBindGridListLink.ClearList;
begin
  if (not Active) and (not FDeactivating) then
    Self.FBindComponentDelegate.GenerateExpressions(Self);
  inherited;
  if (not Active) and (not FDeactivating) then
    Self.FBindComponentDelegate.ClearGeneratedExpressions(Self);
end;

function TInternalBindGridListLink.GetBindingsList: TCustomBindingsList;
begin
  Result := FBindComponentDelegate.BindingsList;
end;

function TInternalBindGridListLink.Loading: Boolean;
begin
  Result := csLoading in FBindComponentDelegate.ComponentState;
end;

constructor TInternalBindGridListLink.Create(ABindDBControlLink: TLinkControlToFieldDelegate);
begin
  inherited Create(nil);
  FBindComponentDelegate := ABindDBControlLink;
end;

function TInternalBindGridListLink.Designing: Boolean;
begin
  Result := csDesigning in FBindComponentDelegate.ComponentState;
end;

function TInternalBindGridListLink.GetDisplayName: string;
begin
  Result := FBindComponentDelegate.Name;
end;

function TInternalBindGridListLink.GetUseEvalShortcuts: Boolean;
begin
  Result := FBindComponentDelegate.GetUseEvalShortcuts;
end;

procedure TInternalBindGridListLink.DoOnActivated;
begin
  FBindComponentDelegate.Activated(Self);
  inherited;
end;

procedure TInternalBindGridListLink.DoOnActivating;
begin
  FDeactivating := False;
  // Must generate expression when dataset is active in
  // order to retrieve fields
  RegenerateExpressions;
  inherited;
end;

procedure TInternalBindGridListLink.RegenerateExpressions;
begin
  // Must generate expression when dataset is active in
  // order to retrieve fields
  FBindComponentDelegate.ClearGeneratedExpressions(Self);
  if not (csDestroying in FBindComponentDelegate.ComponentState) then
    FBindComponentDelegate.GenerateExpressions(Self);
end;

procedure TInternalBindGridListLink.DoOnDeactivated;
begin
  try
    FBindComponentDelegate.ClearGeneratedExpressions(Self);
    inherited;
  finally
    FDeactivating := False;
  end;
end;

procedure TInternalBindGridListLink.DoOnDeactivating;
begin
  inherited;
  FDeactivating := True;
end;

procedure TInternalBindGridListLink.FillList;
begin
  if not Active then
    Self.FBindComponentDelegate.GenerateExpressions(Self);
  try
    inherited;
  finally
    if not Active then
      Self.FBindComponentDelegate.ClearGeneratedExpressions(Self);
  end;
end;

procedure TInternalBindGridListLink.ApplyComponents;
begin
  if FBindComponentDelegate.GetActive then
    if not Loading then
      if FBindComponentDelegate.CanActivate(Self) then
        FBindComponentDelegate.Reactivate;

  inherited;
end;

procedure TInternalBindGridListLink.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
  FBindComponentDelegate.MemberRenaming(Self, AComponent, ACurMemberName, ANewMemberName);
end;

procedure TInternalBindGridListLink.ResetList;
begin
  if Assigned(FListRefreshing) then
    FListRefreshing(Self);
  inherited;
end;

procedure TInternalBindGridListLink.RefreshList;
begin
  ResetList;
end;

function TInternalBindGridListLink.RefreshNeeded: Boolean;
var
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
begin
  Result := False;
  if (ControlComponent <> nil)  then
    Supports(GetBindEditor(ControlComponent, IBindListEditor), IBindListEditor, LEditor)
  else
    LEditor := nil;
  if LEditor <> nil then
    LEnumerator := GetScopeRecordEnumerator;
  if (LEditor <> nil) and (LEnumerator <> nil) then
    Result := LEditor.RefreshNeeded(LEnumerator);
end;

procedure TInternalBindGridListLink.SetListRefreshing(AEvent: TNotifyEvent);
begin
  FListRefreshing := AEvent;
end;

function TInternalBindGridListLink.GetListRefreshing: TNotifyEvent;
begin
  Result := FListRefreshing;
end;

{ TInternalBindControlValue }

function TInternalBindControlValue.CanActivate: Boolean;
begin
  Result := (inherited CanActivate) and FBindComponentDelegate.CanActivate(Self);
end;

function TInternalBindControlValue.GetBindingsList: TCustomBindingsList;
begin
  Result := FBindComponentDelegate.BindingsList;
end;

function TInternalBindControlValue.Loading: Boolean;
begin
  Result := csLoading in FBindComponentDelegate.ComponentState;
end;

function TInternalBindControlValue.RequiresControlHandler: Boolean;
begin
  Result := FBindComponentDelegate.RequiresControlHandler;
end;

constructor TInternalBindControlValue.Create(ABindDBControlLink: TCustomLinkControlToField);
begin
  inherited Create(nil);
  FBindComponentDelegate := ABindDBControlLink;
end;

constructor TInternalBindControlValue.Create(ABindDBControlLink: TCustomLinkControlToProperty);
begin
  inherited Create(nil);
  FBindComponentDelegate := ABindDBControlLink;
end;

function TInternalBindControlValue.Designing: Boolean;
begin
  Result := csDesigning in FBindComponentDelegate.ComponentState;
end;

function TInternalBindControlValue.GetDisplayName: string;
begin
  Result := FBindComponentDelegate.Name;
end;

procedure TInternalBindControlValue.DoOnActivating;
begin
  // Must generate expression when dataset is active in
  // order to retrieve fields
  RegenerateExpressions;
  inherited;
end;

procedure TInternalBindControlValue.DoOnActivated;
begin
  FBindComponentDelegate.Activated(Self);
  inherited;
end;

procedure TInternalBindControlValue.RegenerateExpressions;
begin
  // Must generate expression when dataset is active in
  // order to retrieve fields
  FBindComponentDelegate.ClearGeneratedExpressions(Self);
  if not (csDestroying in FBindComponentDelegate.ComponentState) then
    FBindComponentDelegate.GenerateExpressions(Self);
end;

procedure TInternalBindControlValue.DoOnDeactivated;
begin
  FBindComponentDelegate.ClearGeneratedExpressions(Self);
  inherited;
end;

procedure TInternalBindControlValue.ApplyComponents;
begin
  if FBindComponentDelegate.GetActive then
    if not Loading then
      if FBindComponentDelegate.CanActivate(Self) then
        FBindComponentDelegate.Reactivate;

  inherited;
end;

procedure TInternalBindControlValue.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
  FBindComponentDelegate.MemberRenaming(Self, AComponent, ACurMemberName, ANewMemberName);
end;

{ TCustomLinkControlToField }

function TCustomLinkControlToField.AllowBidirectional: Boolean;
begin
  Result := LookupDataSource = nil;
end;

function TCustomLinkControlToField.RequiresControlHandler: Boolean;
begin
  // Always establish link so that non-bidirectional controls are read only
  Result := True;
end;

function TCustomLinkControlToField.CheckAllowBidirectional: Boolean;
begin
  Result := True;
  if LookupDataSource <> nil then
    raise TBindCompException.Create(sNoBidiLookup);
end;

function CheckActiveScope(AScopeComponent: TComponent): Boolean;
var
  LScopeActive: IScopeActive;
begin
  Result := True;
  if Supports(AScopeComponent, IScopeActive, LScopeActive) then
    Result := LScopeActive.Active
end;


function TCustomLinkControlToField.CanActivate(Sender: TComponent): Boolean;
begin
  Result := (GetControlComponent <> nil) and (DataSource <> nil) and (FieldName <> '') and
    not (csDestroying in ComponentState) and
    not (csDestroying in GetControlComponent.ComponentState) and
    not (csDestroying in DataSource.ComponentState);
  if Result then
    Result := CheckActiveScope(LookupDataSource);
end;


constructor TCustomLinkControlToField.Create(AOwner: TComponent);
var
  LBinding: TInternalLinkControlToFieldBinding;
begin
  FUseEvalShortcuts := True;
  LBinding := TInternalLinkControlToFieldBinding.Create(Self);
  FBinding := LBinding;
  inherited;
  LBinding.CheckInternalBindComponents;
end;


destructor TCustomLinkControlToField.Destroy;
begin
  FBinding.DisposeOf; // Scope component may be holding reference
  inherited;
end;

const
  sLookupDataSource = '_lds';
function TCustomLinkControlToField.GetSourceScopes(Sender: TComponent;
  AScopes: TArray<IScope>): TArray<IScope>;
var
  LList: TList<IScope>;
  LScope: TDictionaryScope;
begin
  if UsingLookup then
  begin
    LList := TList<IScope>.Create;
    try
      LList.AddRange(AScopes);
      LScope := TDictionaryScope.Create;
      LScope.Map.Add(sLookupDataSource, WrapObject(FLookupDataSource));
      LList.Add(LScope);
      Result := LList.ToArray;
    finally
      LList.Free;
    end;
  end
  else
    Result := AScopes;
end;

procedure TCustomLinkControlToField.MemberRenaming(Sender: TComponent; AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  if AComponent = FLookupDataSource then
  begin
    if FLookupValueFieldName = ACurMemberName then
      FLookupValueFieldName := ANewMemberName;
    if FLookupKeyFieldName = ACurMemberName then
      FLookupKeyFieldName := ANewMemberName;
  end;
end;

procedure TCustomLinkControlToField.ClearExpressionProperties;
begin
  FieldName := '';
  CustomFormat := '';
  CustomParse := '';
  LookupKeyFieldName := '';
  LookupValueFieldName := '';
end;

procedure TCustomLinkControlToField.ClearGeneratedExpressions(Sender: TComponent);
begin
  inherited;
  FBinding.ParseExpressions.Clear;
  FBinding.FormatExpressions.Clear;
  FBinding.ClearExpressions.Clear;
end;

function TCustomLinkControlToField.GetActive: Boolean;
begin
  Result := Binding.Active;
end;

function TCustomLinkControlToField.GetDelegates: TArray<TCommonBindComponent>;
begin
  Assert(FBinding <> nil);
  Result := TArray<TCommonBindComponent>.Create(FBinding);
end;

function TCustomLinkControlToField.GetDirection: TLinkControlToFieldDirection;
begin
                                                                        
//  if not AllowBidirectional then
//    Result := linkDataToControl
//  else
    Result := FDirection;

end;

function TCustomLinkControlToField.GetUseEvalShortcuts: Boolean;
begin
  Result := FUseEvalShortcuts;
end;

function TCustomLinkControlToField.GetTrack: Boolean;
var
  LBind: IBindTrack;
begin
  if Supports(FBinding, IBindTrack, LBind) then
    Result := LBind.Track
  else
    Result := False;
end;

function TCustomLinkControlToField.GetAutoActivate: Boolean;
begin
  Result := FBinding.AutoActivate
end;

procedure TCustomLinkControlToField.Loaded;
begin
  inherited;
  FBinding.Loaded;
end;

procedure TCustomLinkControlToField.SetActive(Value: Boolean);
begin
  FBinding.Active := Value and (DataSource <> nil);
end;

procedure TCustomLinkControlToField.SetAutoActivate(const Value: Boolean);
begin
  FBinding.AutoActivate := Value
end;

procedure TCustomLinkControlToField.SetCustomFormat(const Value: string);
begin
  if FCustomFormat <> Value then
  begin
    FCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkControlToField.SetCustomParse(const Value: string);
begin
  if FCustomParse <> Value then
  begin
    FCustomParse := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkControlToField.SetDirection(
  const Value: TLinkControlToFieldDirection);
var
  LNeedNew: Boolean;
  LNeedReactivate: Boolean;
  LActive: Boolean;
  LBinding: TInternalLinkControlToFieldBinding;
begin
  if FDirection <>  Value then
  begin
    LNeedNew := (Value = linkControlToData) or (FDirection = linkControlToData);
    LNeedReactivate := not Loading;
    if Designing and (not Loading) then
      case Value of
        linkBidirectional:
          if not CheckAllowBidirectional then
            exit;
      end;
    // Delegate may have changed based on direction
    if LNeedNew then
    begin
      LActive := FBinding.Active;
      FBinding.Active := False;
      LBinding := TInternalLinkControlToFieldBinding.Create(Self);
      LBinding.Assign(FBinding);
      FBinding.Free;
      FDirection := Value;
      FBinding := LBinding;
      LBinding.CheckInternalBindComponents;
      LBinding.Active := LActive;
      LNeedReactivate := False;
    end
    else
      FDirection := Value;
    if LNeedReactivate then
      Reactivate;
  end;
end;

procedure TCustomLinkControlToField.SetTrack(const Value: Boolean);
var
  LBindTrack: IBindTrack;
begin
  if Supports(FBinding, IBindTrack, LBindTrack) then
    LBindTrack.Track := Value;
end;

procedure TCustomLinkControlToField.SetUseEvalShortcuts(const Value: Boolean);
begin
  if FUseEvalShortCuts <> Value then
  begin
    FUseEvalShortCuts := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure Reactivate(AComponent: TContainedBindComponent; AIsActive: TFunc<Boolean>;
  ASetActive: TProc<Boolean>; ASetAutoActivate: TProc<Boolean>);
begin
  Assert(not AComponent.Loading);
  if AIsActive then
  begin
    try
      // Regenerate expressions
      ASetActive(False);
      ASetActive(True);
    except
      if AComponent.Designing then
      begin
        if not AIsActive then
          ASetAutoActivate(False);
        raise;
      end
      else
        raise;
    end;
  end
end;

procedure TCustomLinkControlToField.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    if AComponent = FLookupDataSource then
      LookupDataSource := nil;
  end;
end;

type
  TBindMemberChange = class(TBasicBindComponent, IBindMemberChange, IBindActivate)
  private
    FMemberRenaming: TProc<TComponent, string, string>;
    FSetActive: TProc<Boolean>;
  protected
    procedure MemberRenamed(AComponent: TComponent; const ACurMemberName, APrevMemberName: string); virtual;
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName, ANewMemberName: string); virtual;
    procedure MemberRemoved(AComponent: TComponent; const AMemberName: string); virtual;
    procedure SetActive(AValue: Boolean);
  end;


procedure TBindMemberChange.MemberRenamed(AComponent: TComponent; const ACurMemberName, APrevMemberName: string);
begin
end;

procedure TBindMemberChange.MemberRenaming(AComponent: TComponent; const ACurMemberName, ANewMemberName: string);
begin
  if Assigned(FMemberRenaming) then
    FMemberRenaming(AComponent, ACurMemberName, ANewMemberName);
end;

procedure TBindMemberChange.MemberRemoved(AComponent: TComponent; const AMemberName: string);
begin
end;

procedure TBindMemberChange.SetActive(AValue: Boolean);
begin
  if Assigned(FSetActive) then
    FSetActive(AValue);
end;

procedure TCustomLinkControlToField.SetLookupDataSource(
  const Value: TBaseLinkingBindSource);
var
  LUsingLookup: Boolean;
begin
  if FLookupMemberChange = nil then
  begin
    FLookupMemberChange := TBindMemberChange.Create(Self);
    TBindMemberChange(FLookupMemberChange).FMemberRenaming :=
      procedure(AComponent: TComponent;  ACurMemberName, ANewMemberName: string)
      begin
        MemberRenaming(Self, AComponent, ACurMemberName, ANewMemberName);
      end;
    TBindMemberChange(FLookupMemberChange).FSetActive :=
      procedure(AValue: Boolean)
      begin
        // Activate when LookupDataSource is activated after DataSource
          if CheckActiveScope(DataSource) then
            if DataSource <> Value then
              DataSource.ActivateExpressions(AValue);
      end;
  end;
  if FLookupDataSource <> Value then
  begin
    LUsingLookup := UsingLookup;
    if FLookupDataSource <> nil then
    begin
      FLookupDataSource.RemoveExpression(FLookupMemberChange);
      FLookupDataSource.RemoveFreeNotification(Self);
    end;
    FLookupDataSource := Value;
    if FLookupDataSource <> nil then
    begin
      FLookupDataSource.AddExpression(FLookupMemberChange);
      FLookupDataSource.FreeNotification(Self);
    end;
    if UsingLookup or LUsingLookup then
      if not Loading then
        Reactivate;
  end;
end;

function TCustomLinkControlToField.UsingLookup: Boolean;
begin
  Result := (FLookupDataSource <> nil) and
    (FLookupKeyFieldName <> '') and (FLookupValueFieldName <> '');
end;

procedure TCustomLinkControlToField.SetLookupKeyFieldName(const Value: string);
var
  LUsingLookup: Boolean;
begin
  if FLookupKeyFieldName <> Value then
  begin
    LUsingLookup := UsingLookup;
    FLookupKeyFieldName := Value;
    if UsingLookup or LUsingLookup then
      if not Loading then
        Reactivate;
  end;
end;

procedure TCustomLinkControlToField.SetLookupValueFieldName(
  const Value: string);
var
  LUsingLookup: Boolean;
begin
  if FLookupValueFieldName <> Value then
  begin
    LUsingLookup := UsingLookup;
    FLookupValueFieldName := Value;
    if UsingLookup or LUsingLookup then
      if not Loading then
        Reactivate;
  end;
end;

procedure TCustomLinkControlToField.Reactivate;
begin
  Data.Bind.Components.Reactivate(Self,
    function: Boolean begin Result := Active end,
    procedure(AValue: Boolean) begin Active := AValue end,
    procedure(AValue: Boolean) begin AutoActivate := AValue end);
end;

function TCustomLinkControlToField.GetControlExpression: string;
begin
  Result := '';
  assert(Binding <> nil);
  if Binding.ControlComponent <> nil then
  begin
    GetControlValuePropertyName(Binding.ControlComponent, Result);
    Assert(Result <> '');
  end;
end;

procedure TCustomLinkControlToField.GenerateExpressions(Sender: TComponent);
var
  LItem: TExpressionItem;
  LControlValuePropertyName: string;
  LMemberGetter: string;
  LMemberSetter: string;
begin
  try
    Assert(Binding.ParseExpressions.Count = 0);
    Assert(Binding.FormatExpressions.Count = 0);
    Assert(Binding.ClearExpressions.Count = 0);

    LControlValuePropertyName := GetControlExpression;

    assert(Binding <> nil);
    if (Binding.SourceComponent <> nil) and (Self.FieldName <> '') then
      GetFieldValueMemberNames(Binding.SourceComponent, Self.FieldName,  LMemberGetter, LMemberSetter);
    if (LControlValuePropertyName <> '') and
      ((LMemberSetter <> '') or (FCustomParse <> '')) then
      case Direction of
        linkDataToControl: ;
        linkControlToData, linkBidirectional:
        begin
          LItem := Binding.ParseExpressions.AddExpression;
          if FCustomParse <> '' then
            LItem.ControlExpression := Format(FCustomParse, [LControlValuePropertyName])
          else
            LItem.ControlExpression := LControlValuePropertyName;
         LItem.SourceExpression := LMemberSetter;
         LItem.Custom := FCustomParse <> '';
        end;
      else
        Assert(False);
      end;

    if (LMemberGetter <> '') and UsingLookup then
    begin
      if (FLookupKeyFieldName <> '') and (FLookupValueFieldName <> '') then
        LMemberGetter := Format('Lookup(%s, "%s", %s, "%s")',
          [sLookupDataSource,
            FLookupKeyFieldName, LMemberGetter, FLookupValueFieldName])
      else
        LMemberGetter := '';
    end;

    if (LControlValuePropertyName <> '') and
      (LMemberGetter <> '') or (FCustomFormat <> '') then
    begin
      LItem := Binding.FormatExpressions.AddExpression;
      LItem.ControlExpression := LControlValuePropertyName;


      if LMemberGetter = '' then
        LMemberGetter := 'nil'; // Do not localize
      if FCustomFormat <> '' then
        LItem.SourceExpression := Format(FCustomFormat, [LMemberGetter])
      else
        LItem.SourceExpression := LMemberGetter;
      LItem.Custom := FCustomFormat <> '';
    end;

    if (LControlValuePropertyName <> '') then
    begin
      LItem := Binding.ClearExpressions.AddExpression;
      LItem.ControlExpression := LControlValuePropertyName;
      LItem.SourceExpression := 'nil';
      LItem.Custom := False;
    end;
  except
    ClearGeneratedExpressions(Sender);
    raise;
  end;
end;


{ TCustomLinkFillControlToField }

constructor TCustomLinkFillControlToField.Create(AOwner: TComponent);
var
  LListRefreshing: IBindListRefreshing;
begin
  inherited;
  FBindList := TInternalBindGridListLookup.Create(Self);
  if Supports(Self.FBindList, IBindListRefreshing, LListRefreshing) then
     LListRefreshing.OnListRefreshing := OnListRefreshing;
  FFillExpressions  := TFormatExpressions.Create(Self);
  FFillExpressions.OnUpdate := FillExpressionsUpdate;
  FFillHeaderExpressions  := TFormatExpressions.Create(Self);
  FFillHeaderExpressions.OnUpdate := FillExpressionsUpdate;
end;

procedure TCustomLinkFillControlToField.OnListRefreshing(Sender: TObject);
begin
  // Previously used to update buffer count
end;

procedure TCustomLinkFillControlToField.FillExpressionsUpdate(AItem: TCollectionItem);
begin
  if not Loading then
    Reactivate;
end;

procedure TCustomLinkFillControlToField.MemberRenaming(Sender, AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
  if AComponent = FillDataSource then
    FFillExpressions.SourceMemberRenaming(ACurMemberName, ANewMemberName);
end;

procedure TCustomLinkFillControlToField.DefineProperties(Filer: TFiler);
begin
  inherited;
  // For backwards compatibility
  ReadBufferProperties(Filer);
end;

destructor TCustomLinkFillControlToField.Destroy;
begin
  FBindList.DisposeOf; // Scope component may be holding reference
  FFillExpressions.Free;
  FFillHeaderExpressions.Free;
  inherited;
end;

function TCustomLinkFillControlToField.GetDelegates: TArray<TCommonBindComponent>;
begin
  Assert(FBindList <> nil);
  Result := TArray<TCommonBindComponent>.Create(Binding, FBindList)
end;

function TCustomLinkFillControlToField.GetListItemStyle: string;
begin
  Result := FBindList.ListItemStyle;
end;

function TCustomLinkFillControlToField.GetOnFilledList: TNotifyEvent;
begin
  Result := FBindList.OnFilledRecords;
end;

function TCustomLinkFillControlToField.GetOnFilledListItem: TFillListItemEvent;
begin
  Result := FBindList.OnFilledRecord;
end;

function TCustomLinkFillControlToField.GetOnFillingList: TNotifyEvent;
begin
  Result := FBindList.OnFillingRecords;
end;

function TCustomLinkFillControlToField.GetOnFillingListItem: TFillListItemEvent;
begin
  Result := FBindList.OnFillingRecord;
end;

procedure TCustomLinkFillControlToField.SetAutoActivate(
  const Value: Boolean);
begin
  if Value then
  begin
    FBindList.AutoActivate := Value;
    inherited;
  end
  else
  begin
    inherited;
    FBindList.AutoActivate := Value;
  end;
end;

function TCustomLinkFillControlToField.CanActivate(Sender: TComponent): Boolean;
var
  LBinding: TExpressionsBindComponent;
begin
  if (Binding is TInternalLinkControlToFieldBinding) then
    LBinding := TInternalLinkControlToFieldBinding(Binding).BindComponent
  else
    LBinding := Binding;
  Result := True;
  Assert(LBinding <> nil);
  Assert(BindList <> nil);
  // Can't activate if destroying
  if csDestroying in ComponentState then
    Result := False
  else if (LBinding.ControlComponent <> nil) and
    (csDestroying in LBinding.ControlComponent.ComponentState) then
    Result := False
  else if (BindList.ControlComponent <> nil) and
    (csDestroying in BindList.ControlComponent.ComponentState) then
    Result := False;
  if Result then
  begin
    if (Sender <> nil) and (Sender = LBinding) then
    begin
      Result := (LBinding.ControlComponent <> nil) and (BindList.Active or (FillDataSource = nil));   // Activate link after list
      if Result then
        Result := CheckActiveScope(DataSource);
    end
    else if Sender = BindList then
      Result := CheckActiveScope(FillDataSource) and (BindList.ControlComponent <> nil)
    else
    begin
      Result := ((DataSource = nil) or CheckActiveScope(DataSource)) and ((FillDataSource = nil) or CheckActiveScope(FillDataSource)) and
        ((FillDataSource = nil) or (BindList.ControlComponent <> nil))
    end;
  end;
end;

function TCustomLinkFillControlToField.CanSetControlComponent(
  Value: TComponent): Boolean;
var
  LIsLookup: Boolean;
begin
  Result := IsLinkFillControl(Value, LIsLookup);
end;

procedure TCustomLinkFillControlToField.Activated(Sender: TComponent);
begin
  if CanActivate(Binding) then
  begin
    if Binding.CanActivate then
      Binding.Active := True;
  end;
end;

function TCustomLinkFillControlToField.GetActive: Boolean;
begin
  Result := inherited or FBindList.Active;
end;

function TCustomLinkFillControlToField.GetAutoFill: Boolean;
begin
  Result := FBindList.AutoFill;
end;

function TCustomLinkFillControlToField.GetBufferCount: Integer;
begin
  Result := FBindList.BufferCount;
end;

function TCustomLinkFillControlToField.UsingLookupProperties: Boolean;
begin
  Result := (FillDataSource <> nil) and
    (FillValueFieldName <> '');
end;

function TCustomLinkFillControlToField.GetControlEditorName(
  const AGuid: TGuid): string;
begin
  if AGuid = IBindListEditorCommon then
    Result := ListItemStyle
  else
    Result := '';
end;

const
  sSelectedValueExpression = 'SelectedValue(Self)';
function TCustomLinkFillControlToField.GetControlExpression: string;
begin
  Result := inherited;
  if Result = '' then
    Result := sSelectedValueExpression;  // Supports lookup and non-lookup lists
end;

function TCustomLinkFillControlToField.GetFillDataSource: TBaseLinkingBindSource;
begin
  Result := FBindList.SourceComponent as TBaseLinkingBindSource;
end;

function TCustomLinkFillControlToField.GetFillDisplayFieldName: string;
begin
  Result := FBindList.SourceMemberName;
end;

function TCustomLinkFillControlToField.GetFillBreakGroups: TFillBreakGroups;
begin
  Result := FBindList.BreakGroups;
end;

function TCustomLinkFillControlToField.GetFillValueFieldName: string;
begin
  Result := FBindList.LookupValueSourceMemberName;
end;

procedure TCustomLinkFillControlToField.Loaded;
begin
  inherited;
  FBindList.Loaded;
end;

procedure TCustomLinkFillControlToField.SetActive(Value: Boolean);
begin
  if Value then
  begin
    FBindList.Active := Value and (FillDataSource <> nil);
    inherited;
  end
  else
  begin
    inherited;
    FBindList.Active := Value;
  end;
end;

procedure TCustomLinkFillControlToField.SetAutoFill(const Value: Boolean);
begin
  FBindList.AutoFill := Value;
end;


procedure TCustomLinkFillControlToField.SetBufferCount(const Value: Integer);
begin
  FBindList.BufferCount := Value;
end;

procedure TCustomLinkFillControlToField.SetControlComponent(
  const AValue: TComponent);
begin
  FBindList.ControlComponent := AValue;
  inherited;                                 
end;

procedure TCustomLinkFillControlToField.SetListItemStyle(const Value: string);
begin
  if Value <> ListItemStyle then
  begin
    FBindList.ListItemStyle := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToField.SetOnFilledList(
  const Value: TNotifyEvent);
begin
  FBindList.OnFilledRecords := Value;
end;

procedure TCustomLinkFillControlToField.SetOnFilledListItem(
  const Value: TFillListItemEvent);
begin
  FBindList.OnFilledRecord := Value;
end;

procedure TCustomLinkFillControlToField.SetOnFillingList(
  const Value: TNotifyEvent);
begin
  FBindList.OnFillingRecords := Value;
end;

procedure TCustomLinkFillControlToField.SetOnFillingListItem(
  const Value: TFillListItemEvent);
begin
  FBindList.OnFillingRecord := Value;
end;

procedure TCustomLinkFillControlToField.SetFillDisplayCustomFormat(
  const Value: string);
begin
  if FFillDisplayCustomFormat <> Value then
  begin
    FFillDisplayCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToField.SetFillValueCustomFormat(
  const Value: string);
begin
  if FFillValueCustomFormat <> Value then
  begin
    FFillValueCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToField.SetFillDataSource(
  const Value: TBaseLinkingBindSource);
begin
  FBindList.SourceComponent := Value;
end;

procedure TCustomLinkFillControlToField.SetFillDisplayFieldName(const Value: string);
begin
  FBindList.SourceMemberName := Value;
end;

procedure TCustomLinkFillControlToField.SetFillExpressions(
  const Value: TFormatExpressions);
begin
  FFillExpressions.Assign(Value);
end;

procedure TCustomLinkFillControlToField.SetFillHeaderExpressions(
  const Value: TFormatExpressions);
begin
  FFillHeaderExpressions.Assign(Value);
end;

procedure TCustomLinkFillControlToField.SetFillBreakCustomFormat(
  const Value: string);
begin
  if FFillBreakCustomFormat <> Value then
  begin
    FFillBreakCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToField.SetFillBreakFieldName(
  const Value: string);
begin
  if FFillBreakFieldName <> Value then
  begin
    FFillBreakFieldName := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToField.SetFillHeaderCustomFormat(
  const Value: string);
begin
  if FFillHeaderCustomFormat <> Value then
  begin
    FFillHeaderCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToField.SetFillHeaderFieldName(
  const Value: string);
begin
  if FFillHeaderFieldName <> Value then
  begin
    FFillHeaderFieldName := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToField.SetFillBreakGroups(
  const Value: TFillBreakGroups);
begin
  FBindList.BreakGroups := Value;
end;

procedure TCustomLinkFillControlToField.SetFillValueFieldName(const Value: string);
begin
  FBindList.LookupValueSourceMemberName := Value;
end;

procedure TCustomLinkFillControlToField.ClearExpressionProperties;
begin
  inherited;
  FillValueFieldName := '';
  FillDisplayFieldName := '';
  FillDisplayCustomFormat := '';
  FillValueCustomFormat := '';
  FillExpressions.Clear;
  FillHeaderExpressions.Clear;
  FillBreakFieldName := '';
  FillBreakCustomFormat := '';
  FillHeaderFieldName := '';
  FillHeaderCustomFormat := '';
end;

procedure TCustomLinkFillControlToField.ClearGeneratedExpressions(Sender: TComponent);
begin
  if Sender = FBindList then
  begin
    FBindList.FormatControlExpressions.Clear;
    FBindList.ColumnExpressions.Clear;
    FBindList.ClearControlExpressions.Clear;
    FBindList.LookupValueSourceExpression := '';
    FBindList.BreakExpression := '';
  end
  else
    inherited;
end;

procedure GenerateFillExpressions(ABindComponent: TContainedBindComponent;
  BindList: TCustomBindGridList;
  AFillExpressions, AFillHeaderExpressions: TFormatExpressions);

  function GetAllExpressions: TArray<TFormatExpressionItem>;
  var
    LList: TList<TFormatExpressionItem>;
    LItem: TFormatExpressionItem;
  begin
    LList := TList<TFormatExpressionItem>.Create;
    try
      if AFillExpressions <> nil then
        for LItem in AFillExpressions do
          LList.Add(LItem);
      if AFillHeaderExpressions <> nil then
        for LItem in AFillHeaderExpressions do
          LList.Add(LItem);
      Result := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

var
  LItem: TExpressionItem;
  LMemberGetter: string;
  LMemberSetter: string;
  LColumnItem: TColumnFormatExpressionItem;
  LSourceExpression: string;
  LFillExpressionItem: TFormatExpressionItem;
  LControlExpression: string;
  LBindFillControlMembers: IBindFillControlMembers;
  LEditor: IBindListEditorCommon;
  LAllExpressions: TArray<TFormatExpressionItem>;
begin
  LAllExpressions := GetAllExpressions;
  if Length(LAllExpressions) > 0 then
  begin
    if BindList.TryGetBindListEditor(LEditor) then
      Supports(LEditor, IBindFillControlMembers, LBindFillControlMembers);
    for LFillExpressionItem in LAllExpressions do // FFillExpressions do
    begin
      LColumnItem := BindList.ColumnExpressions.AddExpression;
      LColumnItem.SourceMemberName := BindList.SourceMemberName;


      LMemberGetter := '';
      LMemberSetter := '';
      if BindList.SourceComponent <> nil then
      begin
        if LFillExpressionItem.SourceMemberName <> '' then
        begin
          if LFillExpressionItem.SourceMemberName <> sWildCard then
          begin
            LColumnItem.SourceMemberName := LFillExpressionItem.SourceMemberName;
            if not GetFieldValueMemberNames(BindList.SourceComponent, LFillExpressionItem.SourceMemberName,
              LMemberGetter, LMemberSetter) then
              raise TBindCompException.CreateFmt(sMemberNotFound, [LFillExpressionItem.SourceMemberName,
                BindList.SourceComponent.Name, ABindComponent.GetDisplayName]);
          end
          else
            LColumnItem.SourceMemberName := '';
        end
        else if BindList.SourceMemberName <> '' then
          if BindList.SourceMemberName <> sWildCard then
            GetFieldValueMemberNames(BindList.SourceComponent, BindList.SourceMemberName,
              LMemberGetter, LMemberSetter);
      end;
      if LMemberGetter = '' then
        LMemberGetter := 'nil'; // Do not localize
      if LFillExpressionItem.CustomFormat <> '' then
        LSourceExpression := Format(LFillExpressionItem.CustomFormat, [LMemberGetter])
      else
        LSourceExpression := LMemberGetter;
      if (LSourceExpression <> '') and (LFillExpressionItem.ControlMemberName <> '') then
      begin
        if LFillExpressionItem.Collection = AFillExpressions then
          LItem := LColumnItem.FormatCellExpressions.AddExpression
        else if LFillExpressionItem.Collection = AFillHeaderExpressions then
          LItem := LColumnItem.FormatCellHeaderExpressions.AddExpression
        else
        begin
          Assert(False);
          LItem := nil;
        end;

        if LItem <> nil then
        begin
          LItem.SourceExpression := LSourceExpression;
          if LBindFillControlMembers <> nil then
          begin
            if LFillExpressionItem.Collection = AFillExpressions then
              LControlExpression := LBindFillControlMembers.GetItemMemberNameExpression(LFillExpressionItem.ControlMemberName)
            else if LFillExpressionItem.Collection = AFillHeaderExpressions then
              LControlExpression := LBindFillControlMembers.GetHeaderMemberNameExpression(LFillExpressionItem.ControlMemberName);
            if LControlExpression = '' then
              LControlExpression := LFillExpressionItem.ControlMemberName;
          end
          else
            LControlExpression := LFillExpressionItem.ControlMemberName;
          LItem.ControlExpression := LControlExpression;
          LItem.Custom := LFillExpressionItem.CustomFormat <> '';
          Assert(not System.StrUtils.StartsStr('Item.', LItem.ControlExpression)); // Do not localize
          Assert(not System.StrUtils.StartsStr('Break', LItem.ControlExpression)); // Do not localize
          Assert(not System.StrUtils.StartsStr('ItemHeader.', LItem.ControlExpression)); // Do not localize
        end;
      end;
    end;
  end
end;


procedure GenerateBindListExpressions(ABindComponent: TContainedBindComponent;
  ABindList: TCustomBindGridList;
  AFillExpressions, AFillHeaderExpressions: TFormatExpressions;
  const AFillDisplayCustomFormat, AFillValueFieldName, AFillValueCustomFormat: string;
  const AFillBreakFieldName, AFillBreakCustomFormat: string;
  AFillHeaderFieldName, AFillHeaderCustomFormat: string;
  AFillBreakGroups: TFillBreakGroups = nil);
var
  LItem: TExpressionItem;
  LControlValuePropertyName: string;
  LHeaderValuePropertyName: string;
  LMemberGetter: string;
  LMemberSetter: string;
  LColumnItem: TColumnFormatExpressionItem;
  LWildCardSourceMemberName: Boolean;
  LSourceExpression: string;
  LControlExpression: string;
  LBindFillControlMembers: IBindFillControlMembers;
  LBindListLookup: TCustomBindGridListLookup;
  LEditor: IBindListEditorCommon;
  LUseFillBreakGroups: Boolean;
  LFillBreakFieldName: string;
  LFillBreakCustomFormat: string;
begin
  if ABindList is TCustomBindGridListLookup then
    LBindListLookup := TCustomBindGridListLookup(ABindList)
  else
    LBindListLookup := nil;
  Assert(ABindList.FormatControlExpressions.Count = 0);
  Assert(ABindList.ColumnExpressions.Count = 0);
  Assert(ABindList.ClearControlExpressions.Count = 0);
  if LBindListLookup <> nil then
    Assert(LBindListLookup.LookupValueSourceExpression = '');
  Assert(ABindList.BreakExpression = '');

  if ABindList.ControlComponent <> nil then
  begin
    GetListItemValueExpression(ABindList.ControlComponent,
      LControlValuePropertyName, LHeaderValuePropertyName);
  end;
  LWildCardSourceMemberName := ABindList.SourceMemberName = sWildCard;

  if (not LWildCardSourceMemberName) and (ABindList.SourceComponent <> nil) and (ABindList.SourceMemberName <> '') then
    GetFieldValueMemberNames(ABindList.SourceComponent, ABindList.SourceMemberName,
      LMemberGetter, LMemberSetter);

  if (LControlValuePropertyName <> '') and
    ((LMemberGetter <> '') or (AFillDisplayCustomFormat <> '')) then
  begin
    if ABindList.SourceMemberName <> '' then
    begin
      LColumnItem := ABindList.ColumnExpressions.AddExpression;
      if not LWildCardSourceMemberName then
        LColumnItem.SourceMemberName := ABindList.SourceMemberName;
      if LMemberGetter = '' then
        LMemberGetter := 'nil'; // Do not localize
      if AFillDisplayCustomFormat <> '' then
        LSourceExpression := Format(AFillDisplayCustomFormat, [LMemberGetter])
      else
        LSourceExpression := LMemberGetter;
      LItem := LColumnItem.FormatCellExpressions.AddExpression;
      LItem.ControlExpression := LControlValuePropertyName;
      LItem.SourceExpression := LSourceExpression;
      LItem.Custom := AFillDisplayCustomFormat <> '';
       Assert(LItem.SourceExpression <> '');
      Assert(not System.StrUtils.StartsStr('Item.', LItem.ControlExpression)); // Do not localize
      Assert(not System.StrUtils.StartsStr('Break', LItem.ControlExpression)); // Do not localize
      Assert(not System.StrUtils.StartsStr('ItemHeader.', LItem.ControlExpression)); // Do not localize
    end;
  end;

                                                                    
  LMemberGetter := '';
  if (AFillHeaderFieldName <> sWildcard) and (ABindList.SourceComponent <> nil) and (AFillHeaderFieldName <> '') then
    GetFieldValueMemberNames(ABindList.SourceComponent, AFillHeaderFieldName,
      LMemberGetter, LMemberSetter);
  LUseFillBreakGroups := (AFillBreakGroups <> nil) and (AFillBreakGroups.Count > 0) and
    ((AFillBreakFieldName <> '') or (AFillBreakCustomFormat <> ''));
  ABindList.DisableBreakGroups := not LUseFillBreakGroups;
  if (LHeaderValuePropertyName <> '') and
    (LUseFillBreakGroups or (LMemberGetter <> '') or (AFillHeaderCustomFormat <> '')) then
  begin
    if ABindList.TryGetBindListEditor(LEditor) then
      Supports(LEditor, IBindFillControlMembers, LBindFillControlMembers);
    if LBindFillControlMembers <> nil then
      LControlExpression := LBindFillControlMembers.GetHeaderMemberNameExpression(LHeaderValuePropertyName)
    else
      LControlExpression := LHeaderValuePropertyName;
    if LControlExpression <> '' then
    begin
      LColumnItem := ABindList.ColumnExpressions.AddExpression;
      if AFillHeaderFieldName <> sWildcard then
        LColumnItem.SourceMemberName := AFillHeaderFieldName;
      if LMemberGetter = '' then
        LMemberGetter := 'nil'; // Do not localize
      if AFillHeaderCustomFormat <> '' then
        LSourceExpression := Format(AFillHeaderCustomFormat, [LMemberGetter])
      else
        LSourceExpression := LMemberGetter;
      if LUseFillBreakGroups then
        // Use group display text
        LMemberGetter := sFillBreakGroupItem + '.DisplayText';
      if AFillHeaderCustomFormat <> '' then
        LSourceExpression := Format(AFillHeaderCustomFormat, [LMemberGetter])
      else
        LSourceExpression := LMemberGetter;
      if not LUseFillBreakGroups then
      begin
        // Default break expression
        LFillBreakFieldName := AFillHeaderFieldName;
        LFillBreakCustomFormat := LSourceExpression;
      end;

      LItem := LColumnItem.FormatCellHeaderExpressions.AddExpression;
      LItem.SourceExpression := LSourceExpression;
      Assert(LItem.SourceExpression <> '');
      LItem.ControlExpression := LControlExpression;
      LItem.Custom := LUseFillBreakGroups or (AFillHeaderCustomFormat <> '');
    end;
  end;

  GenerateFillExpressions(ABindComponent, ABindList, AFillExpressions,
    AFillHeaderExpressions);

  if (ABindList.SourceComponent <> nil) and ((AFillValueFieldName <> '') or (AFillValueCustomFormat <> '')) then
  begin
    Assert(LBindListLookup <> nil);
    GetFieldValueMemberNames(ABindList.SourceComponent, AFillValueFieldName,
      LMemberGetter, LMemberSetter);
    if (LMemberGetter <> '') and (LBindListLookup <> nil) then
    begin
      if AFillValueCustomFormat <> '' then
        LBindListLookup.LookupValueSourceExpression := Format(AFillValueCustomFormat, [LMemberGetter])
      else
        LBindListLookup.LookupValueSourceExpression := LMemberGetter;
      end;
  end;
  if ((AFillBreakFieldName <> '') or (AFillBreakCustomFormat <> '')) then
  begin
    LFillBreakFieldName := AFillBreakFieldName;
    LFillBreakCustomFormat := AFillBreakCustomFormat;
  end;

  if (ABindList.SourceComponent <> nil) and ((LFillBreakFieldName <> '') or (LFillBreakCustomFormat <> '')) then
  begin
    LMemberGetter := '';
    if LFillBreakFieldName <> '' then
    begin
      if LFillBreakFieldName <> sWildcard then
      begin
        ABindList.BreakMemberName := LFillBreakFieldName;
          GetFieldValueMemberNames(ABindList.SourceComponent, LFillBreakFieldName,
          LMemberGetter, LMemberSetter)
      end
      else
        ABindList.BreakMemberName := '';
    end;
    if LFillBreakCustomFormat <> '' then
      ABindList.BreakExpression := Format(LFillBreakCustomFormat, [LMemberGetter])
    else
      ABindList.BreakExpression := LMemberGetter;
    ABindList.FBreakCustom := AFillBreakCustomFormat <> '';
  end
  else
  begin
    ABindList.BreakExpression := '';
    ABindList.BreakMemberName := '';
  end;

end;

procedure TCustomLinkFillControlToField.GenerateExpressions(Sender: TComponent);
begin
  try
    if Sender = FBindList then
      GenerateBindListExpressions(Self, FBindList,
        FFillExpressions, FFillHeaderExpressions,
        FFillDisplayCustomFormat, FillValueFieldName, FFillValueCustomFormat,
        FFillBreakFieldName, FFillBreakCustomFormat,
        FFillHeaderFieldName, FFillHeaderCustomFormat,
        Self.FillBreakGroups)
    else
      inherited;
  except
    ClearGeneratedExpressions(Sender);
    raise;
  end;
end;

function TCustomLinkFillControlToField.GetControlComponentMemberName: string;
begin
  Result := GetControlExpression;
end;

{ TCustomLinkFillControlToProperty }

constructor TCustomLinkFillControlToProperty.Create(AOwner: TComponent);
var
  LListRefreshing: IBindListRefreshing;
begin
  inherited;
  FBindList := TInternalBindGridListLookup.Create(Self);
  if Supports(Self.FBindList, IBindListRefreshing, LListRefreshing) then
     LListRefreshing.OnListRefreshing := OnListRefreshing;
  FFillExpressions  := TFormatExpressions.Create(Self);
  FFillExpressions.OnUpdate := FillExpressionsUpdate;
  FFillHeaderExpressions  := TFormatExpressions.Create(Self);
  FFillHeaderExpressions.OnUpdate := FillExpressionsUpdate;
end;

procedure TCustomLinkFillControlToProperty.OnListRefreshing(Sender: TObject);
begin
  // Previously used to update buffer count
end;

procedure TCustomLinkFillControlToProperty.FillExpressionsUpdate(AItem: TCollectionItem);
begin
  if not Loading then
    Reactivate;
end;

procedure TCustomLinkFillControlToProperty.DefineProperties(Filer: TFiler);
begin
  inherited;
  // For backwards compatibility
  ReadBufferProperties(Filer);
end;

destructor TCustomLinkFillControlToProperty.Destroy;
begin
  FBindList.DisposeOf; // Scope component may be holding reference
  FFillExpressions.Free;
  FFillHeaderExpressions.Free;
  inherited;
end;

procedure TCustomLinkFillControlToProperty.MemberRenaming(Sender, AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
  if AComponent = FillDataSource then
    FFillExpressions.SourceMemberRenaming(ACurMemberName, ANewMemberName);
end;


function TCustomLinkFillControlToProperty.GetActive: Boolean;
begin
  Result := inherited or FBindList.Active;
end;

function TCustomLinkFillControlToProperty.GetAutoFill: Boolean;
begin
  Result := FBindList.AutoFill;
end;

function TCustomLinkFillControlToProperty.GetBufferCount: Integer;
begin
  Result := FBindList.BufferCount;
end;

function TCustomLinkFillControlToProperty.UsingLookupProperties: Boolean;
begin
  Result := (FillDataSource <> nil) and
    (FillValueFieldName <> '');
end;

function TCustomLinkFillControlToProperty.CanSetControlComponent(
  Value: TComponent): Boolean;
var
  LIsLookup: Boolean;
begin
  Result := IsLinkFillControl(Value, LIsLookup);
end;

function TCustomLinkFillControlToProperty.GetControlEditorName(const AGuid: TGuid): string;
begin
  if AGuid = IBindListEditorCommon then
    Result := ListItemStyle
  else
    Result := '';
end;

function TCustomLinkFillControlToProperty.GetControlExpression: string;
begin
  Result := inherited;
  if Result = '' then
    Result := sSelectedValueExpression;  // Supports lookup and non-lookup lists
end;

function TCustomLinkFillControlToProperty.GetDelegates: TArray<TCommonBindComponent>;
begin
  Assert(FBindList <> nil);
  Result := TArray<TCommonBindComponent>.Create(FBindLink, FBindList);
end;

function TCustomLinkFillControlToProperty.GetFillDataSource: TBaseLinkingBindSource;
begin
  Result := FBindList.SourceComponent as TBaseLinkingBindSource;
end;

function TCustomLinkFillControlToProperty.GetFillDisplayFieldName: string;
begin
  Result := FBindList.SourceMemberName;
end;

function TCustomLinkFillControlToProperty.GetFillBreakGroups: TFillBreakGroups;
begin
  Result := FBindList.BreakGroups;
end;

function TCustomLinkFillControlToProperty.GetFillValueFieldName: string;
begin
  Result := FBindList.LookupValueSourceMemberName;
end;

function TCustomLinkFillControlToProperty.GetListItemStyle: string;
begin
  Result := FBindList.ListItemStyle;
end;

procedure TCustomLinkFillControlToProperty.Loaded;
begin
  inherited;
  FBindList.Loaded;
end;

procedure TCustomLinkFillControlToProperty.SetActive(Value: Boolean);
begin
  if Value then
  begin
    FBindList.Active := Value and (FillDataSource <> nil);
    inherited;
  end
  else
  begin
    inherited;
    FBindList.Active := Value;
  end;
end;

procedure TCustomLinkFillControlToProperty.SetAutoActivate(
  const Value: Boolean);
begin
  if Value then
  begin
    FBindList.AutoActivate := Value;
    inherited;
  end
  else
  begin
    inherited;
    FBindList.AutoActivate := Value;
  end;
end;

procedure TCustomLinkFillControlToProperty.SetAutoFill(const Value: Boolean);
begin
  FBindList.AutoFill := Value;
end;

procedure TCustomLinkFillControlToProperty.SetBufferCount(const Value: Integer);
begin
  FBindList.BufferCount := Value;
end;

procedure TCustomLinkFillControlToProperty.SetControlComponent(
  const AValue: TComponent);
begin
  FBindList.ControlComponent := AValue;
  inherited;
end;

procedure TCustomLinkFillControlToProperty.SetFillDisplayCustomFormat(
  const Value: string);
begin
  if FFillDisplayCustomFormat <> Value then
  begin
    FFillDisplayCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToProperty.SetFillValueCustomFormat(
  const Value: string);
begin
  if FFillValueCustomFormat <> Value then
  begin
    FFillValueCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToProperty.SetFillDataSourceName(
  const Value: TBaseLinkingBindSource);
begin
  FBindList.SourceComponent := Value as TBaseLinkingBindSource;
end;

procedure TCustomLinkFillControlToProperty.SetFillDisplayFieldName(const Value: string);
begin
  FBindList.SourceMemberName := Value;
end;

procedure TCustomLinkFillControlToProperty.SetFillValueField(const Value: string);
begin
  FBindList.LookupValueSourceMemberName := Value;
end;

procedure TCustomLinkFillControlToProperty.SetListItemStyle(const Value: string);
begin
  if Value <> ListItemStyle then
  begin
    FBindList.ListItemStyle := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToProperty.SetFillExpressions(
  const Value: TFormatExpressions);
begin
  FFillExpressions.Assign(Value);
end;

procedure TCustomLinkFillControlToProperty.SetFillHeaderExpressions(
  const Value: TFormatExpressions);
begin
  FFillHeaderExpressions.Assign(Value);
end;

procedure TCustomLinkFillControlToProperty.SetFillBreakCustomFormat(
  const Value: string);
begin
  if FFillBreakCustomFormat <> Value then
  begin
    FFillBreakCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToProperty.SetFillBreakFieldName(
  const Value: string);
begin
  if FFillBreakFieldName <> Value then
  begin
    FFillBreakFieldName := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToProperty.SetFillHeaderCustomFormat(
  const Value: string);
begin
  if FFillHeaderCustomFormat <> Value then
  begin
    FFillHeaderCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToProperty.SetFillHeaderFieldName(
  const Value: string);
begin
  if FFillHeaderFieldName <> Value then
  begin
    FFillHeaderFieldName := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkFillControlToProperty.SetFillBreakGroups(
  const Value: TFillBreakGroups);
begin
  FBindList.BreakGroups := Value;
end;

procedure TCustomLinkFillControlToProperty.ClearExpressionProperties;
begin
  inherited;
  FillValueFieldName := '';
  FillDisplayFieldName := '';
  FillDisplayCustomFormat := '';
  FillValueCustomFormat := '';
  FillExpressions.Clear;
  FillHeaderExpressions.Clear;
  FillBreakFieldName := '';
  FillBreakCustomFormat := '';
  FillHeaderFieldName := '';
  FillHeaderCustomFormat := '';
end;

procedure TCustomLinkFillControlToProperty.ClearGeneratedExpressions(Sender: TComponent);
begin
  inherited;
  FBindList.FormatControlExpressions.Clear;
  FBindList.ColumnExpressions.Clear;
  FBindList.ClearControlExpressions.Clear;
  FBindList.LookupValueSourceExpression := '';
  FBindList.BreakExpression := '';
end;

function TCustomLinkFillControlToProperty.CanActivate(Sender: TComponent): Boolean;
begin
  Result := True;
  // Can't activate if destroying
  Assert(BindControlValue <> nil);
  Assert(BindList <> nil);
  if csDestroying in ComponentState then
    Result := False
  else if (BindControlValue.ControlComponent <> nil) and
    (csDestroying in BindControlValue.ControlComponent.ComponentState) then
    Result := False
  else if (BindList.ControlComponent <> nil) and
    (csDestroying in BindList.ControlComponent.ComponentState) then
    Result := False;
  if Result then
  begin
    if Sender = BindControlValue then
      Result := BindList.Active  or (FillDataSource = nil)// Activate link after list
    else if Sender = BindList then
      Result := CheckActiveScope(FillDataSource) and (BindList.ControlComponent <> nil)
    else
      Result := (CheckActiveScope(FillDataSource) or (FillDataSource = nil)) and
        ((FillDataSource = nil) or (BindList.ControlComponent <> nil));
  end;



end;

procedure TCustomLinkFillControlToProperty.Activated(Sender: TComponent);
begin
  if CanActivate(BindControlValue) then
    if BindControlValue.CanActivate then
       BindControlValue.Active := True;
end;

procedure TCustomLinkFillControlToProperty.GenerateExpressions(Sender: TComponent);
begin
  try
    if Sender = FBindList then
      GenerateBindListExpressions(Self, FBindList,
        FFillExpressions, FFillHeaderExpressions,
        FFillDisplayCustomFormat, FillValueFieldName, FFillValueCustomFormat,
        FFillBreakFieldName, FFillBreakCustomFormat,
        FFillHeaderFieldName, FFillHeaderCustomFormat)
    else
      inherited;
  except
    ClearGeneratedExpressions(Sender);
    raise;
  end;
end;


function TCustomLinkFillControlToProperty.GetControlComponentMemberName: string;
begin
  Result := GetControlExpression;
end;


{ TCustomLinkListControlToField }

function TCustomLinkListControlToField.CanActivate(Sender: TComponent): Boolean;
begin
  Result := (GetControlComponent <> nil) and (DataSource <> nil) and ((FieldName <> '') or
    (FillExpressions.Count > 0) or (FillHeaderExpressions.Count > 0));
end;

constructor TCustomLinkListControlToField.Create(AOwner: TComponent);
var
  LListRefreshing: IBindListRefreshing;
begin
  FUseEvalShortcuts := True;
  FDirection := linkDataToControl;
  FBindListLink := TInternalBindGridListLink.Create(Self);
  if Supports(Self.FBindListLink, IBindListRefreshing, LListRefreshing) then
     LListRefreshing.OnListRefreshing := OnListRefreshing;
  FFillExpressions  := TFormatExpressions.Create(Self);
  FFillExpressions.OnUpdate := FillExpressionsUpdate;
  FFillHeaderExpressions  := TFormatExpressions.Create(Self);
  FFillHeaderExpressions.OnUpdate := FillExpressionsUpdate;
  inherited;
end;

procedure TCustomLinkListControlToField.DefineProperties(Filer: TFiler);
begin
  inherited;
  // For backwards compatibility
  ReadBufferProperties(Filer);
end;

destructor TCustomLinkListControlToField.Destroy;
begin
  FBindListLink.DisposeOf; // Scope component may be holding reference
  FFillExpressions.Free;
  FFillHeaderExpressions.Free;
  inherited;
end;

procedure TCustomLinkListControlToField.FillExpressionsUpdate(AItem: TCollectionItem);
begin
  if not Loading then
    Reactivate;
end;

procedure TCustomLinkListControlToField.FillList;
begin
  FBindListLink.FillList;
end;

procedure TCustomLinkListControlToField.ClearExpressionProperties;
begin
  inherited;
  FieldName := '';
  CustomFormat := '';
  CustomParse := '';
  FillExpressions.Clear;
  FillHeaderExpressions.Clear;
  FillBreakFieldName := '';
  FillBreakCustomFormat := '';
  FillHeaderFieldName := '';
  FillHeaderCustomFormat := '';
end;

procedure TCustomLinkListControlToField.ClearGeneratedExpressions(Sender: TComponent);
begin
  inherited;
  FBindListLink.ParseExpressions.Clear;
  FBindListLink.ColumnExpressions.Clear;
  FBindListLink.PosControlExpressions.Clear;
  FBindListLink.PosSourceExpressions.Clear;
  FBindListLink.BreakExpression := '';
end;

function TCustomLinkListControlToField.GetActive: Boolean;
begin
  Result := BindLink.Active;
end;

function TCustomLinkListControlToField.GetDelegates: TArray<TCommonBindComponent>;
begin
  Assert(FBindListLink <> nil);
  Result := TArray<TCommonBindComponent>.Create(FBindListLink);
end;

function TCustomLinkListControlToField.GetDisplaysMultipleSourceMembers: Boolean;
begin
  Result := FillExpressions.Count > 0;
end;

function TCustomLinkListControlToField.GetUseEvalShortcuts: Boolean;
begin
  Result := FUseEvalShortcuts;
end;

function TCustomLinkListControlToField.GetFillBreakGroups: TFillBreakGroups;
begin
  Result := FBindListLink.BreakGroups;
end;

function TCustomLinkListControlToField.GetListItemStyle: string;
begin
  Result := FBindListLink.ListItemStyle;
end;

function TCustomLinkListControlToField.GetOnFilledList: TNotifyEvent;
begin
  Result := FBindListLink.OnFilledRecords;
end;

function TCustomLinkListControlToField.GetOnFilledListItem: TFillListItemEvent;
begin
  Result := FBindListLink.OnFilledRecord;
end;

function TCustomLinkListControlToField.GetOnFillingList: TNotifyEvent;
begin
  Result := FBindListLink.OnFillingRecords;
end;

function TCustomLinkListControlToField.GetOnFillingListItem: TFillListItemEvent;
begin
  Result := FBindListLink.OnFillingRecord;
end;

function TCustomLinkListControlToField.GetAutoActivate: Boolean;
begin
  Result := FBindListLink.AutoActivate;
end;

function TCustomLinkListControlToField.GetBufferCount: Integer;
begin
  Result := FBindListLink.BufferCount;
end;

procedure TCustomLinkListControlToField.Loaded;
begin
  inherited;
  FBindListLink.Loaded;
end;

function TCustomLinkListControlToField.GetControlEditorName(
  const AGuid: TGuid): string;
begin
  if AGuid = IBindListEditorCommon then
    Result := ListItemStyle
  else
    Result := '';
end;

function TCustomLinkListControlToField.RequiresControlHandler: Boolean;
begin
  Result := True; // Always require so that we can prevent editing of controls without
end;

procedure TCustomLinkListControlToField.SetActive(Value: Boolean);
begin
  BindLink.Active := Value;
end;

procedure TCustomLinkListControlToField.SetAutoActivate(const Value: Boolean);
begin
  FBindListLink.AutoActivate := Value;
end;

procedure TCustomLinkListControlToField.SetBufferCount(const Value: Integer);
begin
  FBindListLink.BufferCount := Value;
end;

procedure TCustomLinkListControlToField.SetCustomFormat(const Value: string);
begin
  if FCustomFormat <> Value then
  begin
    FCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkListControlToField.SetCustomParse(const Value: string);
begin
  if FCustomParse <> Value then
  begin
    FCustomParse := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkListControlToField.SetFillExpressions(
  const Value: TFormatExpressions);
begin
  FFillExpressions.Assign(Value);
end;

procedure TCustomLinkListControlToField.SetFillHeaderExpressions(
  const Value: TFormatExpressions);
begin
  FFillHeaderExpressions.Assign(Value);
end;

procedure TCustomLinkListControlToField.SetFieldName(const AName: string);
begin
  if AName <> FieldName then
  begin
    inherited SetSourceMember(AName);
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkListControlToField.SetFillBreakCustomFormat(
  const Value: string);
begin
  if FFillBreakCustomFormat <> Value then
  begin
    FFillBreakCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkListControlToField.SetFillBreakFieldName(
  const Value: string);
begin
  if FFillBreakFieldName <> Value then
  begin
    FFillBreakFieldName := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkListControlToField.SetFillHeaderCustomFormat(
  const Value: string);
begin
  if FFillHeaderCustomFormat <> Value then
  begin
    FFillHeaderCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkListControlToField.SetFillHeaderFieldName(
  const Value: string);
begin
  if FFillHeaderFieldName <> Value then
  begin
    FFillHeaderFieldName := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkListControlToField.SetFillBreakGroups(
  const Value: TFillBreakGroups);
begin
  FBindListLink.BreakGroups := Value;
end;

procedure TCustomLinkListControlToField.SetListItemStyle(const Value: string);
begin
  FBindListLink.ListItemStyle := Value;
end;

procedure TCustomLinkListControlToField.SetOnFilledList(
  const Value: TNotifyEvent);
begin
  FBindListLink.OnFilledRecords := Value;
end;

procedure TCustomLinkListControlToField.SetOnFilledListItem(
  const Value: TFillListItemEvent);
begin
  FBindListLink.OnFilledRecord := Value;
end;

procedure TCustomLinkListControlToField.SetOnFillingList(
  const Value: TNotifyEvent);
begin
  FBindListLink.OnFillingRecords := Value;
end;

procedure TCustomLinkListControlToField.SetOnFillingListItem(
  const Value: TFillListItemEvent);
begin
  FBindListLink.OnFillingRecord := Value;
end;

procedure TCustomLinkListControlToField.SetUseEvalShortcuts(
  const Value: Boolean);
begin
  if FUseEvalShortCuts <> Value then
  begin
    FUseEvalShortCuts := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkListControlToField.Reactivate;
begin
  Data.Bind.Components.Reactivate(Self,
    function: Boolean begin Result := Active end,
    procedure(AValue: Boolean) begin Active := AValue end,
    procedure(AValue: Boolean) begin AutoActivate := AValue end);
end;

function TCustomLinkListControlToField.GetControlComponentMemberName: string;
begin
  Result := inherited;
end;

procedure TCustomLinkListControlToField.GenerateExpressions(Sender: TComponent);

  function MakeGetter(LGetterBase, LSetterBase: Integer; LGetterName: string): string;
  begin
    if LGetterBase > LSetterBase then
      Result := LGetterName + '-' + IntToStr(LGetterBase - LSetterBase)
    else if LGetterBase < LSetterBase then
      Result := LGetterName + '+' + IntToStr(LSetterBase - LGetterBase)
    else
      Result := LGetterName;
  end;


var
  LItem: TExpressionItem;
  LControlValuePropertyName: string;
  LMemberGetter: string;
  LMemberSetter: string;
  LEditor: IBindListEditorCommon;
  LWildCardSourceMemberName: Boolean;
  LScopeMemberScripting: IScopeMemberScripting;
  LSourcePositionGetter: string;
  LSourcePositionGetterBase: Integer;
  LSourcePositionSetter: string;
  LSourcePositionSetterBase: Integer;
  LControlPositionGetter: string;
  LControlPositionGetterBase: Integer;
  LControlPositionSetter: string;
  LControlPositionSetterBase: Integer;
begin
  try
    Assert(BindLink.ParseExpressions.Count = 0);
    Assert(BindLink.ColumnExpressions.Count = 0);
    Assert(BindLink.FormatControlExpressions.Count = 0);
    Assert(BindLink.PosControlExpressions.Count = 0);
    Assert(BindLink.PosSourceExpressions.Count = 0);
    Assert(BindLink.ClearControlExpressions.Count = 0);

    LWildCardSourceMemberName := Self.FieldName = sWildcard;
    if BindLink.ControlComponent <> nil then
      GetListItemValueExpression(BindLink.ControlComponent, LControlValuePropertyName);
    if (not LWildCardSourceMemberName) and (BindLink.SourceComponent <> nil) and (Self.FieldName <> '') then
      GetFieldValueMemberNames(BindLink.SourceComponent, Self.FieldName,  LMemberGetter, LMemberSetter);

    if (LControlValuePropertyName <> '') or (FCustomParse <> '') then
      case Direction of
        linkDataToControl: ;
        linkControlToData, linkBidirectional:
        begin
          if LMemberSetter <> '' then
          begin
            LItem := BindLink.ParseExpressions.AddExpression;
            if FCustomParse <> '' then
              LItem.ControlExpression := Format(FCustomParse, [LControlValuePropertyName])
            else
              LItem.ControlExpression := LControlValuePropertyName;
            LItem.SourceExpression := LMemberSetter;
            LItem.Custom := FCustomParse <> '';
          end;
        end;
      else
        Assert(False);
      end;
    GenerateBindListExpressions(Self, FBindListLink,
        FFillExpressions, FFillHeaderExpressions,
        FCustomFormat, '', '',
        FFillBreakFieldName, FFillBreakCustomFormat,
        FFillHeaderFieldName, FFillHeaderCustomFormat);

    // Set defaults in case IScopeMemberScripting is not implemented
    LControlPositionSetterBase := 0;
    LControlPositionGetterBase := 0;
    LSourcePositionSetterBase := 0;
    LSourcePositionGetterBase := 0;
    if BindLink.TryGetBindListEditor(LEditor) then
    begin
       LEditor.GetPositionGetter(LControlPositionGetter, LControlPositionGetterBase);
       LEditor.GetPositionSetter(LControlPositionSetter, LControlPositionSetterBase);
    end;

    if Supports(BindLink.SourceComponent, IScopeMemberScripting, LScopeMemberScripting) then
    begin
       LScopeMemberScripting.GetPositionGetter(LSourcePositionGetter, LSourcePositionGetterBase);
       LScopeMemberScripting.GetPositionSetter(LSourcePositionSetter, LSourcePositionSetterBase);
    end;

    if (LSourcePositionGetter <> '') and (LControlPositionSetter <> '')  then
    begin
      CheckUnidirectionalDataSource(Self.DataSource, Self);
      LItem := BindLink.PosControlExpressions.AddExpression;
      LItem.ControlExpression := LControlPositionSetter;
      LItem.SourceExpression := MakeGetter(LSourcePositionGetterBase, LControlPositionSetterBase, LSourcePositionGetter);
      LItem.Custom := True;

      LItem := BindLink.PosSourceExpressions.AddExpression;
      LItem.ControlExpression := MakeGetter(LControlPositionGetterBase, LSourcePositionSetterBase, LControlPositionGetter);
      LItem.SourceExpression := LSourcePositionSetter;
      LItem.Custom := True;
    end;
  except
    ClearGeneratedExpressions(Sender);
    raise;
  end;
end;

procedure TCustomLinkListControlToField.OnListRefreshing(Sender: TObject);
begin
  // Previously used to update buffer count
end;


{ TCustomQuickBindPropertyLink }

function TCustomLinkPropertyToField.CanActivate(Sender: TComponent): Boolean;
begin
  Result := (GetControlComponent <> nil) and (DataSource <> nil) and (FieldName <> '');
  if Result then
    Result := CheckActiveScope(LookupDataSource)
end;

constructor TCustomLinkPropertyToField.Create(AOwner: TComponent);
begin
  FBindLink := TInternalBindLink.Create(Self);
  inherited;
end;


destructor TCustomLinkPropertyToField.Destroy;
begin
  FBindLink.DisposeOf; // Scope component may be holding reference
  inherited;
end;

function TCustomLinkPropertyToField.GetSourceScopes(Sender: TComponent;
  AScopes: TArray<IScope>): TArray<IScope>;
var
  LList: TList<IScope>;
  LScope: TDictionaryScope;
begin
  if UsingLookup then
  begin
    LList := TList<IScope>.Create;
    try
      LList.AddRange(AScopes);
      LScope := TDictionaryScope.Create;
      LScope.Map.Add(sLookupDataSource, WrapObject(FLookupDataSource));
      LList.Add(LScope);
      Result := LList.ToArray;
    finally
      LList.Free;
    end;
  end
  else
    Result := AScopes;
end;

procedure TCustomLinkPropertyToField.MemberRenaming(Sender: TComponent; AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
  if AComponent = FLookupDataSource then
  begin
    if FLookupValueFieldName = ACurMemberName then
      FLookupValueFieldName := ANewMemberName;
    if FLookupKeyFieldName = ACurMemberName then
      FLookupKeyFieldName := ANewMemberName;
  end;
end;

procedure TCustomLinkPropertyToField.ClearGeneratedExpressions(Sender: TComponent);
begin
  inherited;
  FBindLink.ParseExpressions.Clear;
  FBindLink.FormatExpressions.Clear;
  FBindLink.ClearExpressions.Clear;
end;

procedure TCustomLinkPropertyToField.GenerateExpressions(Sender: TComponent);
var
  LItem: TExpressionItem;
  LMemberGetter: string;
  LMemberSetter: string;
begin
  try
  Assert(BindLink.ParseExpressions.Count = 0);
  Assert(BindLink.FormatExpressions.Count = 0);
  Assert(BindLink.ClearExpressions.Count = 0);

  if (BindLink.SourceComponent <> nil) and (Self.FieldName <> '') and (Self.FieldName <> sWildcard) then
    GetFieldValueMemberNames(BindLink.SourceComponent, Self.FieldName,  LMemberGetter, LMemberSetter);

  if (LMemberGetter <> '') and UsingLookup then
  begin
    if (FLookupKeyFieldName <> '') and (FLookupValueFieldName <> '') then
      LMemberGetter := Format('Lookup(%s, "%s", %s, "%s")',     // Do not localize
        [sLookupDataSource,
          FLookupKeyFieldName, LMemberGetter, FLookupValueFieldName])
    else
      LMemberGetter := '';
  end;

  if (LMemberGetter <> '') or (FCustomFormat <> '') then
  begin
    LItem := BindLink.FormatExpressions.AddExpression;
    LItem.ControlExpression := ComponentProperty;

    if LMemberGetter = '' then
      LMemberGetter := 'nil'; // Do not localize
    if FCustomFormat <> '' then
      LItem.SourceExpression := Format(FCustomFormat, [LMemberGetter])
    else
      LItem.SourceExpression := LMemberGetter;
    LItem.Custom := FCustomFormat <> '';

    LItem := BindLink.ClearExpressions.AddExpression;
    LItem.ControlExpression := ComponentProperty;
    LItem.SourceExpression := 'nil';
    LItem.Custom := True;
  end;
  except
    ClearGeneratedExpressions(Sender);
    raise;
  end;

end;

function TCustomLinkPropertyToField.GetActive: Boolean;
begin
  Result := BindLink.Active;
end;

function TCustomLinkPropertyToField.GetDelegates: TArray<TCommonBindComponent>;
begin
  Assert(FBindLink <> nil);
  Result := TArray<TCommonBindComponent>.Create(FBindLink);
end;

function TCustomLinkPropertyToField.GetAutoActivate: Boolean;
begin
  Result := FBindLink.AutoActivate;
end;

procedure TCustomLinkPropertyToField.Loaded;
begin
  inherited;
  FBindLink.Loaded;
end;

function TCustomLinkPropertyToField.RequiresControlHandler: Boolean;
begin
                          
  Result := False;
end;

procedure TCustomLinkPropertyToField.SetActive(Value: Boolean);
begin
  BindLink.Active := Value and (DataSource <> nil);
end;

procedure TCustomLinkPropertyToField.SetAutoActivate(const Value: Boolean);
begin
  FBindLink.AutoActivate := Value;
end;

procedure TCustomLinkPropertyToField.SetCustomFormat(const Value: string);
begin
  if FCustomFormat <> Value then
  begin
    FCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;

end;

procedure TCustomLinkPropertyToField.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    if AComponent = FLookupDataSource then
      LookupDataSource := nil;
  end;
end;

procedure TCustomLinkPropertyToField.SetLookupDataSource(
  const Value: TBaseLinkingBindSource);
var
  LUsingLookup: Boolean;
begin
  if FLookupMemberChange = nil then
  begin
    FLookupMemberChange := TBindMemberChange.Create(Self);
    TBindMemberChange(FLookupMemberChange).FMemberRenaming :=
      procedure(AComponent: TComponent;  ACurMemberName, ANewMemberName: string)
      begin
        MemberRenaming(Self, AComponent, ACurMemberName, ANewMemberName);
      end;
  end;
  if FLookupDataSource <> Value then
  begin
    LUsingLookup := UsingLookup;
    if FLookupDataSource <> nil then
    begin
      FLookupDataSource.RemoveExpression(FLookupMemberChange);
      FLookupDataSource.RemoveFreeNotification(Self);
    end;
    FLookupDataSource := Value;
    if FLookupDataSource <> nil then
    begin
      FLookupDataSource.AddExpression(FLookupMemberChange);
      FLookupDataSource.FreeNotification(Self);
    end;
    if UsingLookup or LUsingLookup then
      if not Loading then
        Reactivate;
  end;
end;


function TCustomLinkPropertyToField.UsingLookup: Boolean;
begin
  Result := (FLookupDataSource <> nil);
end;

procedure TCustomLinkPropertyToField.SetLookupKeyFieldName(const Value: string);
var
  LUsingLookup: Boolean;
begin
  if FLookupKeyFieldName <> Value then
  begin
    LUsingLookup := UsingLookup;
    FLookupKeyFieldName := Value;
    if UsingLookup or LUsingLookup then
      if not Loading then
        Reactivate;
  end;
end;

procedure TCustomLinkPropertyToField.SetLookupValueFieldName(
  const Value: string);
var
  LUsingLookup: Boolean;
begin
  if FLookupValueFieldName <> Value then
  begin
    LUsingLookup := UsingLookup;
    FLookupValueFieldName := Value;
    if UsingLookup or LUsingLookup then
      if not Loading then
        Reactivate;
  end;
end;

procedure TCustomLinkPropertyToField.Reactivate;
begin
  Data.Bind.Components.Reactivate(Self,
    function: Boolean begin Result := Active end,
    procedure(AValue: Boolean) begin Active := AValue end,
    procedure(AValue: Boolean) begin AutoActivate := AValue end);
end;

{ TBindComponentDelegate }


procedure TBindComponentDelegate.Activated(Sender: TComponent);
begin
//
end;

function TBindComponentDelegate.GetSourceScopes(Sender: TComponent;
  AScopes: TArray<IScope>): TArray<IScope>;
begin
  Result := AScopes;
end;

procedure TBindComponentDelegate.MemberRenaming(Sender, AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin

end;

function TBindComponentDelegate.GetUseEvalShortcuts: Boolean;
begin
  Result := False;
end;

function TBindComponentDelegate.GetOnActivated: TNotifyEvent;
begin
  Result := GetDelegates[0].OnActivated;
end;

function TBindComponentDelegate.GetOnActivating: TNotifyEvent;
begin
  Result := GetDelegates[0].OnActivating;
end;

function TBindComponentDelegate.GetOnAssigningValue: TBindCompAssigningValueEvent;
begin
  Result := GetDelegates[0].OnAssigningValue;
end;

function TBindComponentDelegate.GetOnEvalError: TBindCompEvalErrorEvent;
begin
  Result := GetDelegates[0].OnEvalError;
end;

function TBindComponentDelegate.GetOnAssignedValue: TBindCompAssignedValueEvent;
begin
  Result := GetDelegates[0].OnAssignedValue;
end;

procedure TBindComponentDelegate.SetOnActivated(const Value: TNotifyEvent);
var
  LDelegate: TCommonBindComponent;
begin
  for LDelegate in GetDelegates do
    LDelegate.OnActivated := Value;
end;

procedure TBindComponentDelegate.SetOnActivating(const Value: TNotifyEvent);
var
  LDelegate: TCommonBindComponent;
begin
  for LDelegate in GetDelegates do
    LDelegate.OnActivating := Value;
end;

procedure TBindComponentDelegate.SetOnAssigningValue(
  const Value: TBindCompAssigningValueEvent);
var
  LDelegate: TCommonBindComponent;
begin
  for LDelegate in GetDelegates do
    LDelegate.OnAssigningValue := Value;
end;

procedure TBindComponentDelegate.SetOnEvalError(
  const Value: TBindCompEvalErrorEvent);
var
  LDelegate: TCommonBindComponent;
begin
  for LDelegate in GetDelegates do
    LDelegate.OnEvalError := Value;
end;

procedure TBindComponentDelegate.SetOnAssignedValue(
  const Value: TBindCompAssignedValueEvent);
var
  LDelegate: TCommonBindComponent;
begin
  for LDelegate in GetDelegates do
    LDelegate.OnAssignedValue := Value;
end;

{ TLinkControlDelegate }

function TLinkControlDelegate.CanSetControlComponent(
  Value: TComponent): Boolean;
begin
  Result := GetDelegates[0].CanSetControlComponent(Value);
end;

function TLinkControlDelegate.GetControlComponent: TComponent;
begin
  Result := GetDelegates[0].ControlComponent;
end;

function TLinkControlDelegate.GetControlComponentMemberName: string;
begin
  if GetControlComponent <> nil then
    GetControlValuePropertyName(GetControlComponent, Result)
  else
    Result := '';

end;

procedure TLinkControlDelegate.SetActive(AValue: Boolean);
begin
//
end;

procedure TLinkControlDelegate.BindActivate(AValue: Boolean);
begin
  SetActive(AValue);
end;

procedure TLinkControlDelegate.SetControlComponent(const Value: TComponent);
begin
  GetDelegates[0].ControlComponent := Value;
end;



{ TLinkControlToFieldDelegate }

function TLinkControlToFieldDelegate.GetDataSource: TBaseLinkingBindSource;
begin
  if (GetDelegates[0] <> nil) and (GetDelegates[0].SourceComponent <> nil) then
    Result := GetDelegates[0].SourceComponent as TBaseLinkingBindSource
  else
    Result := nil;
end;

function TLinkControlToFieldDelegate.GetDisplaysMultipleSourceMembers: Boolean;
begin
  Result := False;
end;

function TLinkControlToFieldDelegate.GetSourceMember: string;
begin
  if GetDelegates[0] = nil then
    Result := ''
  else
    Result := GetDelegates[0].SourceMemberName;
end;

procedure TLinkControlToFieldDelegate.SetDataSource(
  const Value: TBaseLinkingBindSource);
begin
  GetDelegates[0].SourceComponent := Value;
end;

procedure TLinkControlToFieldDelegate.SetSourceMember(const Value: string);
begin
  GetDelegates[0].SourceMemberName := Value;

end;

{ TLinkPropertyToFieldDelegate }


function TLinkPropertyToFieldDelegate.GetControlComponent: TComponent;
begin
  Result := GetDelegates[0].ControlComponent;
end;

function TLinkPropertyToFieldDelegate.GetDataSource: TBaseLinkingBindSource;
begin
  if GetDelegates[0].SourceComponent <> nil then
    Result := GetDelegates[0].SourceComponent as TBaseLinkingBindSource
  else
    Result := nil;
end;

function TLinkPropertyToFieldDelegate.GetSourceMember: string;
begin
  Result := GetDelegates[0].SourceMemberName;
end;

procedure TLinkPropertyToFieldDelegate.SetActive(AValue: Boolean);
begin
//
end;

procedure TLinkPropertyToFieldDelegate.BindActivate(AValue: Boolean);
begin
  SetActive(AValue);
end;

procedure TLinkPropertyToFieldDelegate.SetComponentProperty(
  const Value: string);
begin
  FComponentProperty := Value;

end;

procedure TLinkPropertyToFieldDelegate.SetControlComponent(const Value: TComponent);
begin
  GetDelegates[0].ControlComponent := Value;
end;

procedure TLinkPropertyToFieldDelegate.SetDataSource(
  const Value: TBaseLinkingBindSource);
begin
  GetDelegates[0].SourceComponent := Value;
end;

procedure TLinkPropertyToFieldDelegate.SetSourceMember(const Value: string);
begin
  GetDelegates[0].SourceMemberName := Value;
end;


{ TCustomBindControlToProperty }

function TCustomLinkControlToProperty.CanActivate(Sender: TComponent): Boolean;
begin
  Result := (GetControlComponent <> nil) and (GetSourceComponent <> nil)
    and (ComponentProperty <> ''); // and (FieldName <> '');
end;

constructor TCustomLinkControlToProperty.Create(AOwner: TComponent);
begin
  FBindLink := TInternalBindControlValue.Create(Self);
  FInitializeControlValue := True;
  inherited;
end;


destructor TCustomLinkControlToProperty.Destroy;
begin
  if FBindingsList <> nil then
    if not (csDestroying in FBindingsList.ComponentState) then
      FBindingsList.FDependencyList.Remove(FDependency);
  FBindLink.DisposeOf; // Scope component may be holding reference
  inherited;
end;

procedure TCustomLinkControlToProperty.ClearExpressionProperties;
begin
  ComponentProperty := '';
  CustomFormat := '';
  CustomParse := '';
end;

procedure TCustomLinkControlToProperty.ClearGeneratedExpressions(Sender: TComponent);
begin
  inherited;
  FBindLink.FormatExpressions.Clear;
  FBindLink.ParseExpressions.Clear;
  FBindLink.ClearExpressions.Clear;
end;

function TCustomLinkControlToProperty.GetActive: Boolean;
begin
  Result := BindControlValue.Active;
end;

function TCustomLinkControlToProperty.GetDelegates: TArray<TCommonBindComponent>;
begin
  Assert(FBindLink <> nil);
  Result := TArray<TCommonBindComponent>.Create(FBindLink);
end;

function TCustomLinkControlToProperty.GetAutoActivate: Boolean;
begin
  Result := FBindLink.AutoActivate;
end;

procedure TCustomLinkControlToProperty.Loaded;
begin
  inherited;
  FBindLink.Loaded;
end;

function TCustomLinkControlToProperty.RequiresControlHandler: Boolean;
begin
                          
  Result := True;
end;

procedure TCustomLinkControlToProperty.SetActive(Value: Boolean);
begin
  BindControlValue.Active := Value;
end;

procedure TCustomLinkControlToProperty.SetAutoActivate(const Value: Boolean);
begin
  FBindLink.AutoActivate := Value;
end;

function TCustomLinkControlToProperty.GetSourceComponent: TComponent;
begin
  if GetDelegates[0] = nil then
    Result := nil
  else
    Result := GetDelegates[0].SourceComponent;
end;

function TCustomLinkControlToProperty.GetTrack: Boolean;
begin
  Result := FBindLink.Track;
end;

procedure TCustomLinkControlToProperty.SetSourceComponent(
  const Value: TComponent);
begin
  if (Value = nil) or (Control = nil) or (Control <> Value) then
    GetDelegates[0].SourceComponent := Value
  else
    raise TBindCompException.CreateFmt(sSameSourceAndControlComponent, [GetDisplayName]);
end;

procedure TCustomLinkControlToProperty.SetTrack(const Value: Boolean);
begin
  FBindLink.Track := Value;
end;

procedure TCustomLinkControlToProperty.SetComponentProperty(
  const Value: string);
begin
  FComponentProperty := Value;
end;

procedure TCustomLinkControlToProperty.SetControlComponent(
  const Value: TComponent);
begin
  if (Value = nil) or (Component = nil) or (Component <> Value) then
    inherited SetControlComponent(Value)
  else
    raise TBindCompException.CreateFmt(sSameSourceAndControlComponent, [GetDisplayName]);
end;


procedure TCustomLinkControlToProperty.SetCustomFormat(const Value: string);
begin
  if FCustomFormat <> Value then
  begin
    FCustomFormat := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkControlToProperty.SetCustomParse(const Value: string);
begin
  if FCustomParse <> Value then
  begin
    FCustomParse := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkControlToProperty.SetInitializeControlValue(
  const Value: Boolean);
begin
  if FInitializeControlValue <> Value then
  begin
    FInitializeControlValue := Value;
    if not Loading then
      Reactivate;
  end;
end;

procedure TCustomLinkControlToProperty.Reactivate;
begin
  Data.Bind.Components.Reactivate(Self,
    function: Boolean begin Result := Active end,
    procedure(AValue: Boolean) begin Active := AValue end,
    procedure(AValue: Boolean) begin AutoActivate := AValue end);
end;

function TCustomLinkControlToProperty.GetControlExpression: string;
begin
  Result := '';
  if BindControlValue.ControlComponent <> nil then
  begin
    GetControlValuePropertyName(BindControlValue.ControlComponent, Result);
    Assert(Result <> '');
  end;
end;

procedure TCustomLinkControlToProperty.GenerateExpressions(Sender: TComponent);
var
  LItem: TExpressionItem;
  LControlExpression: string;
begin
  try
    Assert(BindControlValue.FormatExpressions.Count = 0);
    Assert(BindControlValue.ParseExpressions.Count = 0);
    Assert(BindControlValue.ClearExpressions.Count = 0);

    LControlExpression := GetControlExpression;

    if InitializeControlValue then
    begin
      LItem := BindControlValue.ParseExpressions.AddExpression;
      LItem.ControlExpression := LControlExpression;
      if FCustomParse <> '' then
        LItem.SourceExpression := Format(FCustomParse, [ComponentProperty])
      else
        LItem.SourceExpression := ComponentProperty;
      LItem.Custom := FCustomParse <> '';
    end;

    LItem := BindControlValue.FormatExpressions.AddExpression;
    if FCustomFormat <> '' then
      LItem.ControlExpression := Format(FCustomFormat, [LControlExpression])
    else
      LItem.ControlExpression := LControlExpression;
    LItem.SourceExpression := ComponentProperty;
    LItem.Custom := FCustomFormat <> '';

    if InitializeControlValue then
    begin
      LItem := BindControlValue.ClearExpressions.AddExpression;
      LItem.ControlExpression := LControlExpression;
      LItem.SourceExpression := 'nil';
      LItem.Custom := True;
    end;
  except
    ClearGeneratedExpressions(Sender);
    raise;
  end;

end;

{ TDependencyList }

function TDependencyList.Add(ADependency: TDependency): TDependency;
begin
  Assert(ADependency <> nil);
  FList.Add(ADependency);
  Result := ADependency;
end;

procedure TDependencyList.ClearLink(ALocation: ILocation);
begin
  if FLocationDict.ContainsKey(ALocation) then
    FLocationDict.Remove(ALocation);
end;

constructor TDependencyList.Create(ABindCompList: TCustomBindingsList);
begin
  inherited Create;
  FBindingsList := ABindCompList;
  FList := TObjectList<TDependency>.Create;
  FNotified := TObjectDictionary<TComponent,TList<string>>.Create([doOwnsValues]);
  FLocationDict := TDictionary<ILocation, TComponent>.Create;
end;

destructor TDependencyList.Destroy;
begin
  FLocationDict.Free;
  FNotified.Free;
  FList.Free;
  inherited;
end;

function TDependencyList.GetLink(ALocation: ILocation): TComponent;
begin
  if FLocationDict.ContainsKey(ALocation) then
    Result := FLocationDict.Items[ALocation]
  else
    Result := nil;
end;

procedure TDependencyList.Link(AComponent: TComponent; ALocation: ILocation);
begin
  FLocationDict.AddOrSetValue(ALocation, AComponent);
end;

procedure TDependencyList.Notify(ASender: TObject; ALocation: ILocation;
  const AExpr: string);
begin
  if FLocationDict.ContainsKey(ALocation) then
    Notify(ASender, FLocationDict.Items[ALocation], AExpr);
end;

procedure TDependencyList.Notify(ASender: TObject; AComponent: TComponent; const AValue: string);
var
  LDependency: TDependency;
begin
  if (AValue = '') then
    Exit;
  if AComponent = nil then
    Exit;
  if FNotified.ContainsKey(AComponent) then
  begin
    if FNotified.Items[AComponent].Contains(AValue) then
      Exit;
  end;

  for LDependency in FList do
  begin
    if LDependency.Owner <> ASender then
      if (LDependency.Component = AComponent)
        and (SameText(LDependency.Member, AValue) or SameText(LDependency.Expr, AValue)) then
      begin
        if not FNotified.ContainsKey(AComponent) then
          FNotified.Add(AComponent, TList<string>.Create);
        FNotified.Items[AComponent].Add(AValue);
        LDependency.NotifyDependent;
      end;
  end;
  FNotified.Clear;
end;

procedure TDependencyList.Remove(ADependency: TDependency);
begin
  if ADependency <> nil then
    FList.Remove(ADependency);
end;

{ TDependency }

constructor TDependency.Create(AOwner: TObject; AComponent: TComponent;
  const AMember, AExpr: string);
begin
  FOwner := AOwner;
  FMember := AMember;
  FComponent := AComponent;
  FExpr := AExpr;
end;

procedure TDependency.NotifyDependent;
begin
  Assert(False);
end;


{ TCustomBindListLookup }

procedure TCustomBindListLookup.FillListItem(const AEditor: IBindListEditor; const ASourceScope,
  AEditorScope: IScope; AMode: TFillItemMode);
var
  LValue: IValue;
  LExpression: TBindingExpression;
  LExpressionItem: TExpressionItem;
  LLookupEditor: IBindListLookupEditor;
begin
  DoFillingListItem(AEditor);
  try
    if (LookupValueSourceExpression <> '') then
    begin

      LExpression := TBindings.CreateExpression(
        GetComponentScopes(inherited GetComponentScope(SourceComponent, LookupValueSourceMemberName)),
        LookupValueSourceExpression,
        TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue,  DoOnAssignedValue, DoOnLocationUpdated)
      );
      try
        LValue := LExpression.Evaluate;
      finally
        LExpression.Free;
      end;
    end;
    for LExpressionItem in FFormatExpressions do
    begin
      EvaluateExpressionItem(LExpressionItem, AEditorScope, ASourceScope);
    end;
    if (LookupValueSourceExpression <> '') then
    begin
      if Supports(AEditor, IBindListLookupEditor, LLookupEditor) then
      begin
        Assert(LLookupEditor.UseLookups = True); // Should have been set
        if LValue <> nil then
          LLookupEditor.LookupValue[AEditorScope] := LValue.GetValue
        else
          LLookupEditor.LookupValue[AEditorScope] := TValue.Empty
      end
      else
         raise TBindCompException.CreateFmt(sErrorNoLookupSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);

    end;
  finally
    DoFilledListItem(AEditor);
  end;
end;

function TCustomBindListLookup.GetSelectedValue: TValue;
var
  LEditor: IBindListEditorCommon;
begin
  Result := TValue.Empty;
  if Supports(BindListEditor, IBindListEditorCommon, LEditor) then
  begin
    Result := LEditor.SelectedValue
  end;
end;

procedure TCustomBindListLookup.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
  if ACurMemberName <> '' then
    if AComponent = SourceComponent then
      if FLookupValueSourceMemberName = ACurMemberName then
        FLookupValueSourceMemberName := ANewMemberName;
end;

procedure TCustomBindListLookup.CheckLookupList;
var
  LEditorCommon: IBindListEditorCommon;
begin
  // Error will be detected later at runtime
  if Designing then
    if Self.ControlComponent <> nil then
      if Self.TryGetBindListEditor(LEditorCommon) then
        if not Supports(LEditorCommon, IBindListLookupEditor) then
          raise TBindCompException.CreateFmt(sNoLookupSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);
end;

procedure TCustomBindListLookup.SetLookupValueSourceExpression(
  const Value: string);
begin
  FLookupValueSourceExpression := Value;
end;

procedure TCustomBindListLookup.SetLookupValueSourceMemberName(
  const Value: string);
begin
  if Value <> '' then
    CheckLookupList;
  if Value <> FLookupValueSourceMemberName then
  begin
    try
      UpdateSourceMemberChanging;
    finally
      FLookupValueSourceMemberName := Value;
    end;
    UpdateSourceMemberChanged;
  end;
end;

function TCustomBindListLookup.TryGetBindListEditor(
  out AEditor: IBindListEditorCommon): Boolean;
begin
  AEditor := BindListEditor;
  if AEditor <> nil then
    Result := True
  else
  begin
    Result := inherited TryGetBindListEditor(AEditor);
    BindListEditor := AEditor; // Keep it around for keys and values
  end;
end;

{ TCustomBindGridListLookup }

procedure TCustomBindGridListLookup.FillRecords(const AEditor: IBindListEditor);
var
  LLookupEditor: IBindListLookupEditor;
begin
  if (LookupValueSourceExpression <> '') then
  begin
    if not Supports(AEditor, IBindListLookupEditor, FLookupEditor) then
       raise TBindCompException.CreateFmt(sErrorNoLookupSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);
    FLookupEditor.UseLookups := True;
                                  
    FLookupExpression := TBindings.CreateExpression(
      GetComponentScopes(inherited GetComponentScope(SourceComponent, LookupValueSourceMemberName)),
      LookupValueSourceExpression,
      TBindingEventRec.Create(DoOnEvalError, DoOnAssigningValue, DoOnAssignedValue, DoOnLocationUpdated)
    );
  end
  else if Supports(AEditor, IBindListLookupEditor, LLookupEditor) then
  begin
    LLookupEditor.UseLookups := False;
  end;
  try
    inherited;
  finally
    FreeAndNil(FLookupExpression);
    FLookupEditor := nil;
  end;
end;

function TCustomBindGridListLookup.GetSelectedValue: TValue;
var
  LEditor: IBindListEditorCommon;
begin
  Result := TValue.Empty;
  if Supports(BindListEditor, IBindListEditorCommon, LEditor) then
  begin
    Result := LEditor.SelectedValue
  end;
end;

procedure TCustomBindGridListLookup.FillRecord(const AEditor: IBindListEditor;
  AEvaluate: TProc);
var
  LValue: IValue;
  LScope: IScope;
begin

  if FLookupExpression <> nil then
  begin
    LValue := FLookupExpression.Evaluate;
  end;
  inherited;
  if FLookupExpression <> nil then
  begin
    Assert(FLookupEditor <> nil);
    LScope := AEditor.CurrentItem;
    if LScope <> nil then

      if LValue <> nil then
        FLookupEditor.LookupValue[LScope] := LValue.GetValue
      else
        FLookupEditor.LookupValue[LScope] := TValue.Empty
  end;
end;

procedure TCustomBindGridListLookup.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  inherited;
  if ACurMemberName <> '' then
    if AComponent = SourceComponent then
      if FLookupValueSourceMemberName = ACurMemberName then
        FLookupValueSourceMemberName := ANewMemberName;
end;

procedure TCustomBindGridListLookup.CheckLookupList;
var
  LEditorCommon: IBindListEditorCommon;
begin
  // Error will be detected later at runtime
  if Designing then
    if Self.ControlComponent <> nil then
      if Self.TryGetBindListEditor(LEditorCommon) then
        if not Supports(LEditorCommon, IBindListLookupEditor) then
          raise TBindCompException.CreateFmt(sNoLookupSupport, [Self.GetDisplayName, SafeClassName(ControlComponent)]);
end;

procedure TCustomBindGridListLookup.SetLookupValueSourceExpression(
  const Value: string);
begin
  FLookupValueSourceExpression := Value;
end;

procedure TCustomBindGridListLookup.SetLookupValueSourceMemberName(
  const Value: string);
begin
  if Value <> '' then
    CheckLookupList;
  if Value <> FLookupValueSourceMemberName then
  begin
    try
      UpdateSourceMemberChanging;
    finally
      FLookupValueSourceMemberName := Value;
    end;
    UpdateSourceMemberChanged;
  end;
end;

function TCustomBindGridListLookup.TryGetBindListEditor(
  out AEditor: IBindListEditorCommon): Boolean;
begin
  AEditor := BindListEditor;
  if AEditor <> nil then
    Result := True
  else
  begin
    Result := inherited TryGetBindListEditor(AEditor);
    BindListEditor := AEditor; // Keep it around for keys and values
  end;
end;


{ TCollectionEnumerator }

constructor TCollectionEnumerator<T>.Create(ACollection: TCollection);
begin
  FCollectionEnumerator := TCollectionEnumerator.Create(ACollection);
end;

destructor TCollectionEnumerator<T>.Destroy;
begin
  FCollectionEnumerator.Free;
  inherited;
end;

function TCollectionEnumerator<T>.DoGetCurrent: T;
begin
  Result := T(FCollectionEnumerator.GetCurrent);
end;

function TCollectionEnumerator<T>.DoMoveNext: Boolean;
begin
  Result := FCollectionEnumerator.MoveNext;
end;

{ TFormatExpressionItem }

procedure TFormatExpressionItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TFormatExpressionItem then
  begin
    TFormatExpressionItem(Dest).FSourceMemberName := FSourceMemberName;
    TFormatExpressionItem(Dest).FControlMemberName := FControlMemberName;
    TFormatExpressionItem(Dest).CustomFormat := CustomFormat;
    TFormatExpressionItem(Dest).Changed(False);
  end
  else
    inherited;
end;

constructor TFormatExpressionItem.Create(Collection: TCollection;
  const AControlMemberName, ASourceMemberName, ACustomFormat: string);
begin
  inherited Create(Collection);
  FControlMemberName := AControlMemberName;
  FSourceMemberName := ASourceMemberName;
  FCustomFormat := ACustomFormat;
end;

{ TFormatExpressions }

function TFormatExpressions.AddExpression: TFormatExpressionItem;
begin
  Result := Add as TFormatExpressionItem;
end;

function TFormatExpressions.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

function TFormatExpressions.GetItem(Index: Integer): TFormatExpressionItem;
begin
  Result := TFormatExpressionItem(inherited Items[Index]);
end;

constructor TFormatExpressions.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TFormatExpressionItem);
end;

function TFormatExpressions.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sControlMember;
    1: Result := sSourceMember;
    2: Result := sCustomFormat;
  else
    Result := ''; { do not localize }
  end;
end;

function TFormatExpressions.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TFormatExpressions.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Items[ItemIndex].ControlMemberName;
    1: Result := Items[ItemIndex].SourceMemberName;
    2: Result := Items[ItemIndex].CustomFormat;
  else
    Result := '';
  end;
end;

procedure TFormatExpressions.SetItem(Index: Integer; const Value: TFormatExpressionItem);
begin
  inherited SetItem(Index, TCollectionItem(Value));

end;

procedure TFormatExpressions.SourceMemberRenaming(const ACurMemberName,
  ANewMemberName: string);
var
  LItem: TFormatExpressionItem;
  LUpdateNeeded: Boolean;
begin
  LUpdateNeeded := False;
  for LItem in Self do
    if SameText(LItem.FSourceMemberName, ACurMemberName) then
    begin
      LUpdateNeeded := True;
      LItem.FSourceMemberName := ANewMemberName;
    end;
  if LUpdateNeeded then
    Update(nil);  // Update all
  
end;

procedure TFormatExpressions.Update(AItem: TCollectionItem);
begin
  if Assigned(FOnUpdate) then
    FOnUpdate(AItem);
end;

function TFormatExpressionItem.GetDisplayName: string;
begin
  Result := ControlMemberName;
  
end;

procedure TFormatExpressionItem.SetControlMemberName(const Value: string);
begin
  FControlMemberName := Value;
  Changed(False);
end;

procedure TFormatExpressionItem.SetCustomFormat(const Value: string);
begin
  FCustomFormat := Value;
  Changed(False);
end;

procedure TFormatExpressionItem.SetSourceMemberName(const Value: string);
begin
  FSourceMemberName := Value;
  Changed(False);
end;

{ TFillBreakGroupItem }

procedure TFillBreakGroupItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TFillBreakGroupItem then
  begin
    TFillBreakGroupItem(Dest).DisplayText := DisplayText;
    TFillBreakGroupItem(Dest).MinValue := MinValue;
    TFillBreakGroupItem(Dest).MaxValue := MaxValue;
  end
  else
    inherited;
end;

function TFillBreakGroupItem.GetDisplayName: string;
begin
  Result := DisplayText;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

{ TFillBreakGroups }

function TFillBreakGroups.AddItem: TFillBreakGroupItem;
begin
  Result := Add as TFillBreakGroupItem;
end;

function TFillBreakGroups.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

function TFillBreakGroups.GetItem(Index: Integer): TFillBreakGroupItem;
begin
  Result := TFillBreakGroupItem(inherited Items[Index]);
end;

procedure TFillBreakGroups.SetItem(Index: Integer; const Value: TFillBreakGroupItem);
begin
  inherited SetItem(Index, TCollectionItem(Value));

end;

function TFillBreakGroups.FindItem(const AValue: TValue): TFillBreakGroupItem;
var
  LItem: TFillBreakGroupItem;
  S: string;
  I: Integer;
  D: Double;
  LOtherItem: TFillBreakGroupItem;
  LItems: TList<TFillBreakGroupItem>;
begin
  LOtherItem := nil;
                   
  Result := nil;
  LItems := TList<TFillBreakGroupItem>.Create;
  try
    for LItem in Self do
    begin
      if (LItem.MinValue <> '') and
        (LItem.MaxValue <> '') then
      begin
        LItems.Add(LItem);
      end
      else if LOtherItem = nil then
        LOtherItem := LItem;
    end;
    if AValue.TryAsType<Integer>(I) then
    begin
      for LItem in LItems do
      begin
        if (I >= StrToInt(LItem.MinValue)) and
          (I <= StrToInt(LItem.MaxValue)) then
        begin
          Result := LItem;
          break;
        end;
      end;
    end
    else if AValue.TryAsType<double>(D) then
    begin
      for LItem in LItems do
      begin
        if (D >= StrToFloat(LItem.MinValue)) and
          (D <= StrToFloat(LItem.MaxValue)) then
        begin
          Result := LItem;
          break;
        end;
      end;
    end
    else if AValue.TryAsType<string>(S) then
    begin
      for LItem in LItems do
      begin
        if (S >= LItem.MinValue) and
          (S <= LItem.MaxValue) then
        begin
          Result := LItem;
          break;
        end;
      end;
    end;

    if Result = nil then
      Result := LOtherItem; // May be nil
  finally
    LItems.Free;
  end;
end;

function TFillBreakGroups.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sDisplayTextAttr;
    1: Result := sMinValueAttr;
    2: Result := sMaxValueAttr;
  else
    Result := ''; { do not localize }
  end;
end;

function TFillBreakGroups.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TFillBreakGroups.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: begin
         Result := Items[ItemIndex].DisplayText;
         if Result = '' then Result := IntToStr(ItemIndex);
       end;
    1: Result := Items[ItemIndex].MinValue;
    2: Result := Items[ItemIndex].MaxValue;
  else
    Result := '';
  end;
end;

{ TCurrentFillBreakGroupItem }

function TCurrentFillBreakGroupItem.GetDisplayText: string;
begin
  if Item <> nil then
    Result := Item.DisplayText
  else
    Result := '';
end;

function TCurrentFillBreakGroupItem.GetItem: TFillBreakGroupItem;
begin
  Result := FItem;
end;

{ TInternalLinkControlToFieldBinding }

constructor TInternalLinkControlToFieldBinding.Create(
  ALinkControlToField: TCustomLinkControlToField);
begin
  inherited Create(nil);
  FAutoActivate := True;
  FTrack := False;
  FLinkComponent := ALinkControlToField;
  FControl := nil;
  FSource := nil;
  FMember := '';
  FBindLink := nil;
  FBindControlValue := nil;
end;

destructor TInternalLinkControlToFieldBinding.Destroy;
begin
  FBindLink.DisposeOf; // Scope component may be holding reference
  FBindControlValue.DisposeOf; // Scope component may be holding reference
  inherited;
end;

function TInternalLinkControlToFieldBinding.GetActive: Boolean;
begin
  if Assigned(FBindControlValue) then
    Result := FBindControlValue.GetActive
  else if Assigned(FBindLink) then
    Result := FBindLink.GetActive
  else
    Result := False;
end;

function TInternalLinkControlToFieldBinding.GetAutoActivate: Boolean;
begin
  if Assigned(FBindControlValue) then
    Result := FBindControlValue.AutoActivate
  else if Assigned(FBindLink) then
    Result := FBindLink.AutoActivate
  else
    Result := FAutoActivate;
end;

function TInternalLinkControlToFieldBinding.GetBindComponent: TExpressionsBindComponent;
begin
  if FLinkComponent.Direction = linkControlToData then
    Result := FBindControlValue
  else
    Result := FBindLink;
end;

function TInternalLinkControlToFieldBinding.GetClearExpressions: TExpressions;
begin
  if Assigned(FBindControlValue) then
    Result := FBindControlValue.ClearExpressions
  else if Assigned(FBindLink) then
    Result := FBindLink.ClearExpressions
  else
    Result := inherited;
end;

function TInternalLinkControlToFieldBinding.GetControlComponent: TComponent;
begin
  if Assigned(FBindControlValue) then
    Result := FBindControlValue.ControlComponent
  else if Assigned(FBindLink) then
    Result := FBindLink.ControlComponent
  else
    Result := FControl;
end;

function TInternalLinkControlToFieldBinding.GetFormatExpressions: TExpressions;
begin
  if Assigned(FBindControlValue) then
    Result := FBindControlValue.FormatExpressions
  else if Assigned(FBindLink) then
    Result := FBindLink.FormatExpressions
  else
    Result := inherited;
end;

function TInternalLinkControlToFieldBinding.GetParseExpressions: TExpressions;
begin
  if (FLinkComponent.Direction = linkControlToData) and Assigned(FBindControlValue) then
    Result := FBindControlValue.ParseExpressions
  else if (FLinkComponent.Direction <> linkControlToData) and Assigned(FBindLink) then
    Result := FBindLink.ParseExpressions
  else
    Result := inherited;
end;

function TInternalLinkControlToFieldBinding.GetSourceComponent: TComponent;
begin
  if Assigned(FBindControlValue) then
    Result := FBindControlValue.SourceComponent
  else if Assigned(FBindLink) then
    Result := FBindLink.SourceComponent
  else
    Result := FSource;
end;

function TInternalLinkControlToFieldBinding.GetSourceMemberName: string;
begin
  if Assigned(FBindControlValue) then
    Result := FBindControlValue.SourceMemberName
  else if Assigned(FBindLink) then
    Result := FBindLink.SourceMemberName
  else
    Result := FMember;
end;

function TInternalLinkControlToFieldBinding.GetTrack: Boolean;
begin
  if Assigned(FBindControlValue) then
    Result := FBindControlValue.Track
  else if Assigned(FBindLink) then
    Result := FBindLink.Track
  else
    Result := FTrack;
end;

procedure TInternalLinkControlToFieldBinding.AssignTo(APersistent: TPersistent);
var
  LBinding: TInternalLinkControlToFieldBinding;
begin
  if APersistent is TInternalLinkControlToFieldBinding then
  begin
    LBinding := TInternalLinkControlToFieldBinding(APersistent);
    LBinding.SourceComponent := SourceComponent;
    LBinding.SourceMemberName := SourceMemberName;
    LBinding.ControlComponent := ControlComponent;
    LBinding.Track := Track;
    LBinding.OnAssigningValue := OnAssigningValue;
    LBinding.OnAssignedValue := OnAssignedValue;
    LBinding.OnEvalError := OnEvalError;
    LBinding.OnLocationUpdated := OnLocationUpdated;
    LBinding.OnActivating := OnActivating;
    LBinding.OnActivated := OnActivated;
    LBinding.Active := Active;
  end
  else
    inherited;
end;

procedure TInternalLinkControlToFieldBinding.CheckInternalBindComponents;
begin
  if (FBindControlValue <> nil) or (FBindLink <> nil) then
    Exit;
  if FLinkComponent.Direction = linkControlToData then
  begin
    FBindControlValue := TInternalBindControlValue.Create(FLinkComponent);
    FBindControlValue.AutoActivate := FAutoActivate;
    FBindControlValue.SourceComponent := FSource;
    FBindControlValue.SourceMemberName := FMember;
    FBindControlValue.ControlComponent := FControl;
    FBindControlValue.Track := FTrack;
    FBindControlValue.SetParseExpressions(inherited GetParseExpressions);
    FBindControlValue.SetClearExpressions(inherited GetClearExpressions);
    FBindControlValue.SetFormatExpressions(inherited GetFormatExpressions);
    FBindControlValue.OnAssigningValue := OnAssigningValue;
    FBindControlValue.OnAssignedValue := OnAssignedValue;
    FBindControlValue.OnEvalError := OnEvalError;
    FBindControlValue.OnLocationUpdated := OnLocationUpdated;
    FBindControlValue.OnActivating := OnActivating;
    FBindControlValue.OnActivated := OnActivated;
    //FBindControlValue.Loaded;
  end
  else
  begin
    FBindLink := TInternalBindLink.Create(FLinkComponent);
    FBindLink.AutoActivate := FAutoActivate;
    FBindLink.SourceComponent := FSource;
    FBindLink.SourceMemberName := FMember;
    FBindLink.ControlComponent := FControl;
    FBindLink.Track := FTrack;
    FBindLink.SetParseExpressions(inherited GetParseExpressions);
    FBindLink.SetClearExpressions(inherited GetClearExpressions);
    FBindLink.SetFormatExpressions(inherited GetFormatExpressions);
    FBindLink.OnAssigningValue := OnAssigningValue;
    FBindLink.OnAssignedValue := OnAssignedValue;
    FBindLink.OnEvalError := OnEvalError;
    FBindLink.OnLocationUpdated := OnLocationUpdated;
    FBindLink.OnActivating := OnActivating;
    FBindLink.OnActivated := OnActivated;
    //FBindLink.Loaded;
  end;
end;

procedure TInternalLinkControlToFieldBinding.Loaded;
begin
  inherited;
  if FBindLink <> nil then
    FBindLink.Loaded
  else if FBindControlValue <> nil then
    FBindControlValue.Loaded;
end;

procedure TInternalLinkControlToFieldBinding.SetActive(AValue: Boolean);
begin
  if Assigned(FBindControlValue) then
    FBindControlValue.Active := AValue
  else if Assigned(FBindLink) then
    FBindLink.Active := AValue;
end;

procedure TInternalLinkControlToFieldBinding.SetAutoActivate(AValue: Boolean);
begin
  FAutoActivate := AValue;
  if Assigned(FBindControlValue) then
    FBindControlValue.AutoActivate := AValue
  else if Assigned(FBindLink)  then
    FBindLink.AutoActivate := AValue
end;

procedure TInternalLinkControlToFieldBinding.SetClearExpressions(
  const Value: TExpressions);
begin
  inherited SetClearExpressions(Value);
  if Assigned(FBindControlValue) then
    FBindControlValue.SetClearExpressions(Value);
  if Assigned(FBindLink) then
    FBindLink.SetClearExpressions(Value);
end;

procedure TInternalLinkControlToFieldBinding.SetControlComponent(
  const Value: TComponent);
begin
  FControl := Value;
  if Assigned(FBindControlValue) then
    FBindControlValue.ControlComponent := Value;
  if Assigned(FBindLink) then
    FBindLink.ControlComponent := Value;
end;

procedure TInternalLinkControlToFieldBinding.SetFormatExpressions(
  const Value: TExpressions);
begin
  inherited SetFormatExpressions(Value);
  if Assigned(FBindControlValue) then
    FBindControlValue.SetFormatExpressions(Value);
  if Assigned(FBindLink) then
    FBindLink.SetFormatExpressions(Value);
end;

procedure TInternalLinkControlToFieldBinding.SetOnActivated(
  const Value: TNotifyEvent);
begin
  inherited;
  if Assigned(FBindControlValue) then
    FBindControlValue.OnActivated := Value;
  if Assigned(FBindLink) then
    FBindLink.OnActivated := Value;
end;

procedure TInternalLinkControlToFieldBinding.SetOnActivating(
  const Value: TNotifyEvent);
begin
  inherited;
  if Assigned(FBindControlValue) then
    FBindControlValue.OnActivating := Value;
  if Assigned(FBindLink) then
    FBindLink.OnActivating := Value;
end;

procedure TInternalLinkControlToFieldBinding.SetOnAssignedValue(
  const Value: TBindCompAssignedValueEvent);
begin
  inherited;
  if Assigned(FBindControlValue) then
    FBindControlValue.OnAssignedValue := Value;
  if Assigned(FBindLink) then
    FBindLink.OnAssignedValue := Value;
end;

procedure TInternalLinkControlToFieldBinding.SetOnAssigningValue(
  const Value: TBindCompAssigningValueEvent);
begin
  inherited;
  if Assigned(FBindControlValue) then
    FBindControlValue.OnAssigningValue := Value;
  if Assigned(FBindLink) then
    FBindLink.OnAssigningValue := Value;
end;

procedure TInternalLinkControlToFieldBinding.SetOnEvalError(
  const Value: TBindCompEvalErrorEvent);
begin
  inherited;
  if Assigned(FBindControlValue) then
    FBindControlValue.OnEvalError := Value;
  if Assigned(FBindLink) then
    FBindLink.OnEvalError := Value;
end;

procedure TInternalLinkControlToFieldBinding.SetOnLocationUpdated(
  const Value: TBindingLocationUpdatedEvent);
begin
  inherited;
  if Assigned(FBindControlValue) then
    FBindControlValue.OnLocationUpdated := Value;
  if Assigned(FBindLink) then
    FBindLink.OnLocationUpdated := Value;
end;

procedure TInternalLinkControlToFieldBinding.SetParseExpressions(
  const Value: TExpressions);
begin
  inherited SetParseExpressions(Value);
  if Assigned(FBindControlValue) then
    FBindControlValue.SetParseExpressions(Value);
  if Assigned(FBindLink) then
    FBindLink.SetParseExpressions(Value);
end;

procedure TInternalLinkControlToFieldBinding.SetSourceComponent(
  const Value: TComponent);
begin
  FSource := Value;
  if Assigned(FBindControlValue) then
    FBindControlValue.SourceComponent := Value;
  if Assigned(FBindLink) then
    FBindLink.SourceComponent := Value;
end;

procedure TInternalLinkControlToFieldBinding.SetSourceMemberName(const Value: string);
begin
  FMember := Value;
  if Assigned(FBindControlValue) then
    FBindControlValue.SourceMemberName := Value;
  if Assigned(FBindLink) then
    FBindLink.SourceMemberName := Value;
end;

procedure TInternalLinkControlToFieldBinding.SetTrack(const Value: Boolean);
begin
  FTrack := Value;
  if Assigned(FBindControlValue) then
    FBindControlValue.Track := Value;
  if Assigned(FBindLink) then
    FBindLink.Track := Value;
end;

{ TExpressionsBindComponent }

procedure TExpressionsBindComponent.SetFormatExpressions(const Value: TExpressions);
begin
  FFormatExpressions.Assign(Value);
end;

procedure TExpressionsBindComponent.SetParseExpressions(const Value: TExpressions);
begin
  FParseExpressions.Assign(Value);
end;

procedure TExpressionsBindComponent.SetClearExpressions(const Value: TExpressions);
begin
  FClearExpressions.Assign(Value);
end;

procedure TExpressionsBindComponent.AddDependency(
  ABindingExpression: TBindingExpression; ANotifyProc: TProc<TExpressionsBindComponent>; ASourceComponent: TComponent;
  ASourceMemberName, AExpression: string;
  AOutputComponent: TComponent);
var
  LLocation: ILocation;
begin
  if BindingsList <> nil then
  begin
    FDependencies.Add(BindingsList.DependencyList.Add(
      TQuickBindProcDependency.Create(Self, ANotifyProc, ASourceComponent, ASourceMemberName, AExpression)));

    for LLocation in ABindingExpression.Outputs.Destinations.Keys do
    begin
      if ABindingExpression.Outputs.Destinations[LLocation].Key = nil then
        BindingsList.DependencyList.Link(AOutputComponent, LLocation);
    end;
  end;
end;

procedure TExpressionsBindComponent.CleanDependencies;
var
  LDependency: TDependency;
  LLocation: ILocation;
begin
  if BindingsList <> nil then
    if not (csDestroying in BindingsList.ComponentState) then
    begin
      for LDependency in FDependencies do
        BindingsList.DependencyList.Remove(LDependency);
      for LLocation in FDependencyLinks do
        BindingsList.DependencyList.ClearLink(LLocation);
    end;
  FDependencies.Clear;
  FDependencyLinks.Clear;
end;

constructor TExpressionsBindComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDependencies := TList<TDependency>.Create;
  FDependencyLinks := TList<ILocation>.Create;

  FParseExpressions := TExpressions.Create(Self, TExpressionItem);
  FClearExpressions := TExpressions.Create(Self, TExpressionItem);
  FFormatExpressions := TExpressions.Create(Self, TExpressionItem);

  FClearExpressionObjects := TList<TBindingExpression>.Create;
  FParseExpressionObjects := TList<TBindingExpression>.Create;
  FFormatExpressionObjects := TList<TBindingExpression>.Create;
end;

destructor TExpressionsBindComponent.Destroy;
begin
  FreeExpressionsObjects;
  FFormatExpressions.Free;
  FParseExpressions.Free;
  FClearExpressions.Free;

  FParseExpressionObjects.Free;
  FFormatExpressionObjects.Free;
  FClearExpressionObjects.Free;

  FDependencies.Free;
  FDependencyLinks.Free;
  inherited;
end;

procedure TExpressionsBindComponent.DoOnAssignedValue(
  AssignValueRec: TBindingAssignValueRec; const Value: TValue);
begin
  inherited;
end;

procedure TExpressionsBindComponent.DoOnLocationUpdated(AOldLocation,
  ANewLocation: ILocation);
var
  LComponent: TComponent;
begin
  inherited;
  if BindingsList <> nil then
  begin
    Assert(BindingsList.DependencyList <> nil);
    // Update LocationRecs (if any) as they are recompiled and recreated
    // every time the expression is evaluated and assigned.
    LComponent := BindingsList.DependencyList.GetLink(AOldLocation);
    if LComponent <> nil then
    begin
      BindingsList.DependencyList.ClearLink(AOldLocation);
      BindingsList.DependencyList.Link(LComponent, ANewLocation);
    end;
  end;
end;

procedure TExpressionsBindComponent.FreeExpressionsObjects;
begin
  inherited;
  CleanDependencies;
  FreeExpressionObjects(FFormatExpressionObjects);
  FreeExpressionObjects(FParseExpressionObjects);
  FreeExpressionObjects(FClearExpressionObjects);
  FreeAndNil(FControlExpressionObject);
end;

function TExpressionsBindComponent.GetClearExpressions: TExpressions;
begin
  Result := FClearExpressions;
end;

function TExpressionsBindComponent.GetFormatExpressions: TExpressions;
begin
  Result := FFormatExpressions;
end;

function TExpressionsBindComponent.GetParseExpressions: TExpressions;
begin
  Result := FParseExpressions;
end;

procedure TExpressionsBindComponent.NotifyDependentOutputs(
  ABindingExpression: TBindingExpression);
var
  LLocation: ILocation;
  LOutPair: TBindingOutput.TOutputPair;
begin
  if BindingsList <> nil then
    for LLocation in ABindingExpression.Outputs.Destinations.Keys do
    begin
      LOutPair := ABindingExpression.Outputs.Destinations[LLocation];
      if LOutPair.Key is TComponent then
        BindingsList.DependencyList.Notify(Self, TComponent(LOutPair.Key), LOutPair.Value)
      else
        BindingsList.DependencyList.Notify(Self, LLocation, LOutPair.Value)
    end;
end;

{ TQuickBindProcDependency }

constructor TQuickBindProcDependency.Create(
  ABinding: TExpressionsBindComponent; ANotifyProc: TProc<TExpressionsBindComponent>;
  AComponent: TComponent; const AMember, AExpr: string);
begin
  inherited Create(ABinding, AComponent, AMember, AExpr);
  FBinding := ABinding;
  FNotifyProc := ANotifyProc;
end;

procedure TQuickBindProcDependency.NotifyDependent;
begin
  if Assigned(FNotifyProc) then
    FNotifyProc(FBinding);
end;

function IsUnidirectionalDataSource(ADataSource: TComponent): Boolean;
var
  LScopeUnidirectional: IScopeUnidirectional;
begin
  Result := Supports(ADataSource, IScopeUnidirectional, LScopeUnidirectional) and
    LScopeUnidirectional.IsUnidirection;;
end;

procedure CheckUnidirectionalDataSource(ADataSource: TComponent; ABindComponent: TContainedBindComponent);
begin
  if IsUnidirectionalDataSource(ADataSource) then
    raise TBindCompException.CreateFmt(SDataSourceUnidirectional, [ABindComponent.GetDisplayName]);
end;

{ TReadBufferProperties }

procedure TReadBufferProperties.ReadBoolean(Reader: TReader);
begin
  Reader.ReadBoolean;
end;

procedure TReadBufferProperties.ReadInteger(Reader: TReader);
begin
  Reader.ReadInteger;
end;

{ TEvalEnumeratorToEditor }

constructor TEvalEnumeratorToEditor.Create(AUseEvalShortcuts: Boolean;
  const ASource: IScopeRecordEnumerator; const ASourceMemberName: string;
  const AEditor: IBindListEditor; const AEditorMemberName: string; ACustom: Boolean;
  const AOnEvalError: TOnEvalErrorEvent;
  const ABindingExpression: TBindingExpression);
begin
  FUseEvalShortcuts := AUseEvalShortcuts;
  FBindingExpression := ABindingExpression;
  FSource := ASource;
  FSourceMemberName := ASourceMemberName;
  FEditor := AEditor;
  FCustom := ACustom;
  FOnEvalError := AOnEvalError;

  FEditorMemberName := AEditorMemberName;
end;

destructor TEvalEnumeratorToEditor.Destroy;
begin
  FEvalShortcut.Free;
  FBindingExpression.Free;
  inherited;
end;

procedure TEvalEnumeratorToEditor.Evaluate;
begin
  if FUseEvalShortcuts then
    CheckEvalShortcut;
  if FEvalShortcut <> nil then
    FEvalShortcut.Evaluate(Self)
  else
    FBindingExpression.Evaluate;
end;

procedure TEvalEnumeratorToEditor.CheckEvalShortcut;
begin
  if not FHaveEvalShortcut then
  begin
    TEvalShortcutFactories.Instance.Supports(Self, FEvalShortcut);
    FHaveEvalShortcut := True;
  end;
end;

{ TEvalEnumerator }

constructor TEvalEnumerator.Create(AUseEvalShortcuts: Boolean;
  const ASource: IScopeRecordEnumerator; const ASourceMemberName: string;
  ACustom: Boolean;
  const AOnEvalError: TOnEvalErrorEvent;
  const ABindingExpression: TBindingExpression);
begin
  FUseEvalShortcuts := AUseEvalShortcuts;
  FBindingExpression := ABindingExpression;
  FSource := ASource;
  FSourceMemberName := ASourceMemberName;
  FCustom := ACustom;
  FOnEvalError := AOnEvalError;

end;

destructor TEvalEnumerator.Destroy;
begin
  FEvalShortcut.Free;
  FBindingExpression.Free;
  inherited;
end;

procedure TEvalEnumerator.CheckEvalShortcut;
begin
  if not FHaveEvalShortcut then
  begin
    TEvalShortcutFactories.Instance.Supports(Self, FEvalShortcut);
    FHaveEvalShortcut := True;
  end;
end;

function TEvalEnumerator.Evaluate(const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean;
var
  LValue: IValue;
begin
  Result := False;
  if FUseEvalShortcuts then
    CheckEvalShortcut;
  if FEvalShortcut <> nil then
  begin
    CheckEvalShortcut;
    if FEvalShortcut <> nil then
      Result := FEvalShortcut.Evaluate(Self, ATypes, AValue)
    else
    begin
      LValue := FBindingExpression.Evaluate;
      Result := LValue <> nil;
      AValue := LValue.GetValue;
    end;
  end
  else
  begin
    LValue := FBindingExpression.Evaluate;
    Result := LValue <> nil;
    AValue := LValue.GetValue;
  end;
end;

{ TEvalShortcutFactories }

constructor TEvalShortcutFactories.Create;
begin
  FList := TObjectList<TEvalShortcutFactory>.Create;

end;

destructor TEvalShortcutFactories.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TEvalShortcutFactories.Register(
  const AFactory: TEvalShortcutFactory);
begin
  FList.Insert(0, AFactory);   // LIFO
end;

function TEvalShortcutFactories.Supports(
  const AExpression: TEvalEnumeratorToEditor; out AEvalShortcut: TEvalShortcutEnumeratorToEditor): Boolean;
var
  AFactory: TEvalShortcutFactory;
begin
  for AFactory in FList do
  begin
    Result := AFactory.Supports(AExpression, AEvalShortcut);
    if Result then
      Exit;
  end;
  Result := False;
end;

function TEvalShortcutFactories.Supports(
  const AExpression: TEvalEnumeratorToEditor): Boolean;
var
  AFactory: TEvalShortcutFactory;
begin
  for AFactory in FList do
  begin
    Result := AFactory.Supports(AExpression);
    if Result then
      Exit;
  end;
  Result := False;
end;

function TEvalShortcutFactories.Supports(
  const AExpression: TEvalEnumerator; out AEvalShortcut: TEvalShortcutEnumerator): Boolean;
var
  AFactory: TEvalShortcutFactory;
begin
  for AFactory in FList do
  begin
    Result := AFactory.Supports(AExpression, AEvalShortcut);
    if Result then
      Exit;
  end;
  Result := False;
end;

function TEvalShortcutFactories.Supports(
  const AExpression: TEvalEnumerator): Boolean;
var
  AFactory: TEvalShortcutFactory;
begin
  for AFactory in FList do
  begin
    Result := AFactory.Supports(AExpression);
    if Result then
      Exit;
  end;
  Result := False;
end;

procedure TEvalShortcutFactories.Unregister(
  var AFactory: TEvalShortcutFactory);
begin
  FList.Remove(AFactory);
  AFactory := nil;
end;

{ TEvalShortcutFactory }

function TEvalShortcutFactory.Supports(
  const AExpression: TEvalEnumeratorToEditor): Boolean;
var
  AValue: TEvalShortcutEnumeratorToEditor;
begin
  AValue := nil;
  Result := Supports(AExpression, AValue);
  AValue.Free;
end;

function TEvalShortcutFactory.Supports(
  const AExpression: TEvalEnumerator): Boolean;
var
  AValue: TEvalShortcutEnumerator;
begin
  AValue := nil;
  Result := Supports(AExpression, AValue);
  AValue.Free;
end;


type
  TStandardEvalShortcutFactory = class(TEvalShortcutFactory)
  public
    function Supports(const AExpression: TEvalEnumeratorToEditor; out AEvalShortcut: TEvalShortcutEnumeratorToEditor): Boolean; override;
    function Supports(const AExpression: TEvalEnumerator; out AEvalShortcut: TEvalShortcutEnumerator): Boolean; override;
  end;

  TStandardEvalShortcutEnumeratorToEditor = class(TEvalShortcutEnumeratorToEditor)
  public type
    TOnEvalErrorEvent = procedure(E: Exception) of object;
  private
    FGet: IScopeRecordEnumeratorEvalShortcut;
    FSet: IBindListEditorEvalShortcut;
    FType: TScopeMemberType;
    FOnEvalError: TOnEvalErrorEvent;
  public
    constructor Create(const AGet: IScopeRecordEnumeratorEvalShortcut; const ASet: IBindListEditorEvalShortcut;
      AType: TScopeMemberType; const AOnEvalError: TOnEvalErrorEvent);
    procedure Evaluate(const AExpression: TEvalEnumeratorToEditor); override;
  end;

  TStandardEvalShortcutEnumerator = class(TEvalShortcutEnumerator)
  public type
    TOnEvalErrorEvent = procedure(E: Exception) of object;
  private
    FGet: IScopeRecordEnumeratorEvalShortcut;
    FOnEvalError: TOnEvalErrorEvent;
  public
    constructor Create(const AGet: IScopeRecordEnumeratorEvalShortcut; const AOnEvalError: TOnEvalErrorEvent);
    function Evaluate(const AExpression: TEvalEnumerator; const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean; override;
  end;

{ TStandardEvalShortcutFactory }

function TStandardEvalShortcutFactory.Supports(const AExpression: TEvalEnumeratorToEditor;
  out AEvalShortcut: TEvalShortcutEnumeratorToEditor): Boolean;
var
  LGet: IScopeRecordEnumeratorEvalShortcut;
  LSet: IBindListEditorEvalShortcut;
  LType: TScopeMemberType;
begin
  Result := not AExpression.Custom;
  if Result then
    Result :=
      System.SysUtils.Supports(AExpression.Source, IScopeRecordEnumeratorEvalShortcut, LGet) and
      System.SysUtils.Supports(AExpression.Editor, IBindListEditorEvalShortcut, LSet);

  if Result then
    Result := LSet.CanSetCurrentValue(AExpression.EditorMemberName, LType) and
      LGet.CanGetMemberValue(AExpression.SourceMemberName, LType);

  if Result then
    AEvalShortcut := TStandardEvalShortcutEnumeratorToEditor.Create(LGet, LSet, LType, AExpression.OnEvalError);
end;

function TStandardEvalShortcutFactory.Supports(const AExpression: TEvalEnumerator;
  out AEvalShortcut: TEvalShortcutEnumerator): Boolean;
var
  LGet: IScopeRecordEnumeratorEvalShortcut;
begin
  Result := not AExpression.Custom;

  if Result then
    Result :=
      System.SysUtils.Supports(AExpression.Source, IScopeRecordEnumeratorEvalShortcut, LGet);

  if Result then
    Result := LGet.CanGetMemberValue(AExpression.SourceMemberName, TScopeMemberType.mtText);                                 

  if Result then
    AEvalShortcut := TStandardEvalShortcutEnumerator.Create(LGet, AExpression.OnEvalError);
end;

{ TStandardEvalShortcutEnumeratorToEditor }

constructor TStandardEvalShortcutEnumeratorToEditor.Create(
  const AGet: IScopeRecordEnumeratorEvalShortcut;
  const ASet: IBindListEditorEvalShortcut;
  AType: TScopeMemberType;
  const AOnEvalError: TOnEvalErrorEvent);
begin
  FSet := ASet;
  FGet := AGet;
  FType := AType;
  FOnEvalError := AOnEvalError;
end;

procedure TStandardEvalShortcutEnumeratorToEditor.Evaluate(const AExpression: TEvalEnumeratorToEditor);
begin
  Assert(FGet <> nil);
  Assert(FSet <> nil);
  FGet.GetMemberValue(AExpression.SourceMemberName, FType,
    procedure(const AValue: TValue; AType: TScopeMemberType)
    begin
      try
        FSet.SetCurrentValue(AExpression.EditorMemberName, AValue, AType);
      except
        on E: Exception do
          if Assigned(FOnEvalError) then
            FOnEvalError(E)
          else
            raise;
      end;
    end);
end;

{ TStandardEvalShortcutEnumerator }

constructor TStandardEvalShortcutEnumerator.Create(
  const AGet: IScopeRecordEnumeratorEvalShortcut;
  const AOnEvalError: TOnEvalErrorEvent);
begin
  FGet := AGet;
  FOnEvalError := AOnEvalError;
end;

function TStandardEvalShortcutEnumerator.Evaluate(const AExpression: TEvalEnumerator; const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean;
begin
  Assert(FGet <> nil);
  try
    Result := FGet.GetMemberValue(AExpression.SourceMemberName, ATypes, AValue);
  except
    on E: Exception do
    begin
      if Assigned(FOnEvalError) then
        FOnEvalError(E); // Should raise
      raise;
    end;
  end;
end;

initialization
  FEditorFactories := TList<TBindEditorFactoryClass>.Create;
  FValuePropertyNames := TDictionary<TClass, TValuePropertyNameRec>.Create;
  FListItemValueExpressions := TDictionary<TClass, TListItemExpressionRec>.Create;
  // Custom scopes to support lookup using component names.
  TBindingScopeFactory.RegisterScope(TComponent, TBindComponentScope);
  TBindingScopeFactory.RegisterScope(TBaseBindScopeComponent, TBindScopeComponentScope);
  TEvalShortcutFactories.FInstance := TEvalShortcutFactories.Create;
  TEvalShortcutFactories.Instance.Register(TStandardEvalShortcutFactory.Create);

finalization
  TBindingScopeFactory.UnRegisterScope(TBindComponentScope);
  TBindingScopeFactory.UnRegisterScope(TBindScopeComponentScope);
  FEditorFactories.Free;
  FValuePropertyNames.Free;
  FListItemValueExpressions.Free;
  FReadBufferProperties.Free;
  TEvalShortcutFactories.FInstance.Free;
end.



