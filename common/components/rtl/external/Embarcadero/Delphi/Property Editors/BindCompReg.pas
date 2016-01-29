{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompReg;

interface

uses System.Classes, System.SysUtils, Data.Bind.Components, DesignEditors, DesignIntf, ColnEdit,
   Vcl.ActnList, System.Generics.Collections, Data.Bind.ObjectScope, ValueEdit, StringsEdit;

type
  TDataBindingFactory = class(TInterfacedObject, IBindCompFactory)
  private
  protected
    FCategory: string;
    FClass: TContainedBindCompClass;
    function Enabled(AContext: IBindCompFactoryContext): Boolean; virtual;
    function GetCommandText(AContext: IBindCompFactoryContext): string;  virtual;
    procedure Execute(AContext: IBindCompFactoryExecuteContext);  virtual;
  public
    constructor Create(ACategory: string; AClass: TContainedBindCompClass);
  end;

  TRttiUnitSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TCustomBindCompListSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TBaseDataGeneratorSelectionEditor = class(TSelectionEditor)
  protected
    function GetDataGenerator(AComponent: TComponent): TCustomDataGeneratorAdapter; virtual;
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TDataGeneratorSelectionEditor = TBaseDataGeneratorSelectionEditor;

  TPrototypeBindSourceDataGeneratorSelectionEditor = class(TBaseDataGeneratorSelectionEditor)
  protected
    function GetDataGenerator(AComponent: TComponent): TCustomDataGeneratorAdapter; override;
  end;

  TBindCompExpressionEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TBindingComponentPropertyEditor = class(TStringProperty)
  protected
    function GetBindComponent: TContainedBindComponent;
    function GetComponentProperty(const AName: string): TComponent;
    function GetStringProperty(const AName: string): string;
  public
    procedure GetValueList(List: TStrings); virtual; abstract;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TSourceMemberNamePropertyEditor = class(TBindingComponentPropertyEditor)
  private
    function GetSourceComponent: TComponent;
  protected
    procedure GetMemberNames(ASourceComponent: TComponent; List: TStrings); virtual;
    function GetSourceComponentName: string; virtual;
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TFieldNamePropertyEditor = class(TSourceMemberNamePropertyEditor)
  protected
    function GetSourceComponentName: string; override;
  end;

  TFillFieldNamePropertyEditor = class(TFieldNamePropertyEditor)
//  protected
//    function GetSourceComponentName: string; override;
  end;

  TFillItemFieldNamePropertyEditor = class(TSourceMemberNamePropertyEditor)
  protected
    function GetSourceComponentName: string; override;
  end;

  TEditorNamePropertyEditor = class(TBindingComponentPropertyEditor)
  private
    function GetControlComponent: TComponent;
  protected
    procedure GetEditorNames(AControlComponent: TComponent; List: TStrings); virtual;
    function GetControlComponentName: string; virtual;
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValueList(List: TStrings); override;
  end;

  TLinkingControlPropertyEditor = class(TComponentProperty)
  private
    FProc: TGetStrProc;
    procedure InternalStrProc(const S: string);
  protected
    function IsValidControl(AComponent: TComponent): Boolean; virtual;
  public
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TLinkingFillControlPropertyEditor = class(TLinkingControlPropertyEditor)
  protected
    function IsValidControl(AComponent: TComponent): Boolean; override;
  end;

  TFillCustomFormatPropertyEditor = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;


  TControlMembersPropertyEditor = class(TBindingComponentPropertyEditor)
  private
    function GetControlComponent: TComponent;
    function GetEditorName: string;
  protected
    function GetEditor(AControlComponent: TComponent;
      const AEditor: string): IInterface; virtual;
    procedure GetItemMemberNames(AControlComponent: TComponent; const AEditor: string; AList: TStrings); virtual;
    function GetControlComponentName: string; virtual;
    function GetEditorPropertyName: string; virtual;
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TLookupFieldNamePropertyEditor = class(TSourceMemberNamePropertyEditor)
  protected
    function GetSourceComponentName: string; override;
  end;

  TLookupKeyFieldNamePropertyEditor = class(TLookupFieldNamePropertyEditor)
  protected
    procedure GetMemberNames(ASourceComponent: TComponent; List: TStrings); override;
  end;

  TGeneratorNamePropertyEditor = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValueList: TArray<string>; virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TFormatExpressionSourceMemberEditor = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValueList: TArray<string>; virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TUseDataGeneratorPropertyEditor = class(TBoolProperty)
  const
    sName = 'UseDataGenerator';
  public
    procedure SetValue(const Value: string); override;
  end;

  TAdapterPropertyEditor = class(TComponentProperty)
  const
    sName = 'Adapter';
  public
    procedure SetValue(const Value: string); override;
  end;

  TLinkingBindScopePropertyEditor = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TLBComponentFilterFunc = TFunc<TComponent,string,Boolean>;
  TLBVisualizationPropertyManager = class
  private class var
    FInstance: TLBVisualizationPropertyManager;
  private
    FProcs: TList<TLBComponentFilterFunc>;
    class function Instance: TLBVisualizationPropertyManager;
  public
    constructor Create;
    destructor Destroy; override;
    class procedure AddComponentFilter(AFilterFunc: TLBComponentFilterFunc);
    class procedure RemoveComponentFilter(AFilterFunc: TLBComponentFilterFunc);
    class function GetComponentFiltersFuncArray: TArray<TLBComponentFilterFunc>;
  end;

  TLBVisualizationPropertyFilter = class(TSelectionEditor, ISelectionPropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionProperties: IInterfaceList);
  end;
  TAddDataBindingsPropertyFilter = class(TSelectionEditor, ISelectionPropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionProperties: IInterfaceList);
  end;

  TBindCompFactorySelectionEditor = class(TSelectionEditor)
  private
    FTempStringList: TStrings;
    FActions: TList<TCustomAction>;
    class procedure AddDataBindingAction(AFactory: IBindCompFactory;
      Info: Pointer);
    procedure AddFactoryActions(AList: TList<TCustomAction>);
    procedure AddTempString(const S: string);
    procedure CreateDataBindingFactoryContext(Sender: TObject;
      ABindCompList: TCustomBindingsList;
      out AContext: IBindCompFactoryContext);
    procedure CreateNewDataBindingFactory(Sender: TObject;
      DataBindingFactory: IBindCompFactory; BindingsList: TCustomBindingsList);
    function CreateDataBindingFactoryExecuteContext(
      ABindCompList: TCustomBindingsList): IBindCompFactoryExecuteContext;
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer; const List: IDesignerSelections); override;
    constructor Create(const ADesigner: IDesigner); override;
    destructor Destroy; override;
  end;

  TAddBindScopeSelectionEditor = class(TSelectionEditor)
  private
    function CanHaveBindScope(AComponent: TComponent): Boolean;
    procedure CreateBindScope(AComponent: TComponent);
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer; const List: IDesignerSelections); override;
  end;

  TComponentPropertyNamesProperty = class(TStringProperty)
  public
    class function GetComponentPropertyNames(AComponent: TComponent): TArray<string>; overload; static;
    class function HasComponentPropertyName(AComponent: TComponent; const AName: string): Boolean; overload; static;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetPropertyComponent: TComponent; virtual;
    function GetValueList: TArray<string>; virtual;
  end;

  TLinkControlToPropertyNamesEditor = class(TComponentPropertyNamesProperty)
  public
    function GetPropertyComponent: TComponent; override;
  end;

  TLinkPropertyToFieldPropertyNamesEditor = class(TComponentPropertyNamesProperty)
  public
    function GetPropertyComponent: TComponent; override;
  end;

  TBaseLinkingBindScopeEditor = class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TScopeAdapterFieldsEditor = class(TBaseLinkingBindScopeEditor)
  private
    function GetCollection: TCollection;
    function GetPropertyName: string;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TGetDesignerComponents = class
  type
    TComponentPropertyClass = class(TComponent)
    private
      FComponent: TComponent;
    published
      property Component: TComponent read FComponent write FComponent;
    end;
  private
    class var FCounter: Integer;
  private var
    FDesigner: IDesigner;
    FComponentProc: TProc<TComponent, string>;
    procedure ComponentNameProc(const RootName: string);
  public
    constructor Create(const ADesigner: IDesigner);
    function IsExternalComponent(AComponent: TComponent): Boolean;
    procedure GetDesignerComponents(AProc: TProc<TComponent, string>);
  end;

type
  TPersistentPair = TPair<string, TPersistent>;

function GetDataSourceMemberNames(AComponent: TComponent; AList: TStrings): Boolean; overload;
function GetDataSourceMemberNames(AComponent: TComponent): TArray<TPersistentPair>; overload;
function IsDataSourceMemberName(AComponent: TComponent; const AMemberName: string): Boolean;
function IsDataSourceComponent(AComponent: TComponent): Boolean;
function CreateBindingsList(AOwner: TComponent): TBindingsList;
function FindBindingsList(AOwner: TComponent): TBindingsList;
procedure GetComponentPropertyNames(AComponent: TComponent; AList: TList<string>);
procedure GetBindComponentsOfControl(AComponent: TComponent; AFunc: TFunc<TContainedBindComponent, Boolean>);
procedure GetBindComponentsOfComponentProperty(AComponent: TComponent; const AProperty: string; AFunc: TFunc<TContainedBindComponent, Boolean>);
function FindBindComponentsLinkToControl(const AControl: TComponent): TArray<TContainedBindComponent>;
function ConfirmDeleteBindComponents(const ADesigner: IDesigner; AComponents: TArray<TContainedBindComponent>;
  ANewClass: TComponentClass = nil): Boolean;
procedure DeleteBindComponents(const ADesigner: IDesigner; AComponents: TArray<TContainedBindComponent>);
function FindBindComponentsLinkToComponentProperty(const AComponent: TComponent; const APropertyName: string): TArray<TContainedBindComponent>;
function DefaultTrackControl(AControl: TComponent): Boolean;
function ShowLiveBindingsWizard: Boolean;
function BindScopeOfDataSourceComponent(const ADesigner: IDesigner; AComponent: TComponent): TComponent;
function CreateUniqueComponentName(AOwner: TComponent; const APrefix, AMemberName: string): string;
procedure GetOwnedAndLinkedComponents(ADesigner: IDesigner; AProc: TProc<TComponent, string>);
function GetOwnedAndLinkedComponentsList(ADesigner: IDesigner): TArray<TComponent>;
function IntroducedInAncestor(AComponent: TComponent): Boolean;

procedure Register;

implementation

uses DsnConst, Vcl.Forms, Winapi.Windows,Vcl.Controls,
  Vcl.Themes, Winapi.UxTheme, VisualizationServicesAPI,
  BindCompEdit, BindCompDsnResStrs, Vcl.Graphics, Vcl.ComCtrls, Vcl.Menus,
  System.Math, ComponentDesigner,  Vcl.GraphUtil,System.TypInfo,
  DesignConst, TreeIntf, BindCompBasePropEditor, System.StrUtils, System.Types,
  ToolsAPI, PropInspApi, BindCompProperties, BindMethodsFormU,
  BindOutputConvertersFormU, System.Bindings.EvalProtocol, System.Bindings.Methods, System.Bindings.Outputs,
  BindCompExprEdit, Data.Bind.Consts, Data.Bind.DBLinks, System.Bindings.ObjEval,
  // initialization
  Data.Bind.DBScope, Data.Bind.EngExt, Vcl.Dialogs, Proxies, System.Rtti, Data.Db, BindNewFieldDlg,
  BindAdapterFieldColnEdit, Data.Bind.Grid, LiveBindingsGenOptFrame, StdConst,
  Data.Bind.GenData, System.RTLConsts, System.Character; // Register

{ TBindCompListEditor }

type
  TBindCompListEditor = class(TComponentEditor)
  private
    procedure ExecuteNewBindingsDlg;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TBindFillListExpressionEditor = class(TBindCompExpressionEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TBindFillGridLinkExpressionEditor = class(TBindCompExpressionEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TBindFillGridListExpressionEditor = class(TBindCompExpressionEditor)
  private
    function GetBindList: TCustomBindGridList;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TBindEvaluateExpressionEditor = class(TBindCompExpressionEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TBindEvaluateExprItemsEditor = class(TBindCompExpressionEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TAddActionInfo = record
    FContext: IBindCompFactoryContext;
    FBindingsList: TCustomBindingsList;
    FList: TList<TCustomAction>;
  end;

  PAddActionInfo = ^TAddActionInfo;

  TFactoryAction = class(TCustomAction)
  private
    FBindingsList: TCustomBindingsList;
    FFactory: IBindCompFactory;
  public
    constructor Create(const ACaption: string; ABindingsList: TCustomBindingsList;  AFactory: IBindCompFactory); reintroduce;
    function Execute: Boolean; override;
  end;

  TVerbAction = class(TCustomAction)
  private
    FVerb: Integer;
    FDesigner: IDesigner;
    FComponent: TComponent;
  public
    constructor Create(const ACaption: string; AComponent: TComponent;  AVerb: integer;
      ADesigner: IDesigner); reintroduce;
    function Execute: Boolean; override;
  end;

  TDataBindingFactoryContext = class(TInterfacedObject, IBindCompFactoryContext)
  private
    FBindCompList: TCustomBindingsList;
    FControlComponent: TComponent;
    FDesigner: IDesigner;
  protected
    function GetOwner: TComponent;
    function GetBindingsList: TCustomBindingsList;
    function GetControlComponent: TComponent;
    function GetDesigner: IInterface;
  public
    constructor Create(ADesigner: IDesigner; ABindCompList: TCustomBindingsList;
      AControlComponent: TComponent);
  end;

  TDataBindingFactoryExecuteContext = class(TDataBindingFactoryContext, IBindCompFactoryExecuteContext)
  protected
    function UniqueName(const ABaseName: string): string; virtual;
    procedure BindCompCreated(AComponent: TComponent); virtual;
  end;

  TDataLinkProperty = class(TObject)
  protected
    function GetOwner: TComponent; virtual; abstract;
  public
    property Owner: TComponent read GetOwner;
  end;

{ TBindCompListView }

  TNewDataBindingEvent = procedure(Sender: TObject; const Category: string;
    DataBindingClass: TContainedBindCompClass; BindingsList: TCustomBindingsList) of object;
  TNewDataBindingFactoryEvent = procedure(Sender: TObject;
    DataBindingFactory: IBindCompFactory; BindingsList: TCustomBindingsList) of object;
  TCreateDataBindingFactoryContext = procedure(Sender: TObject; BindingsList: TCustomBindingsList;
    var AContext: IBindCompFactoryContext) of object;
  TSelectDataBindingEvent = procedure(Sender: TObject; DataBinding: TContainedBindComponent) of object;

  TBindCompListViewOption = (dblvSelect, dblvDelete, dblvCreateNew, dblvCreateNewFactory, dblvSelectExisting);
  TBindCompListViewOptions = set of TBindCompListViewOption;

  TBindCompListView = class(TCustomListView)
  private const
    FDefItemHeight = 17;
  private
    FSelectComponentItem: TListItem;
    FDeleteComponentItem: TListItem;
    FActionsDictionary: TDictionary<TListItem, TCustomAction>;
    FDesigner: IDesigner;
    FImageList: TImageList;
    FTempStringList: TStrings;
    FOnNewDataBinding: TNewDataBindingEvent;
    FOnNewDataBindingFactory: TNewDataBindingFactoryEvent;
    FOnSelectDataBindingProperty: TSelectDataBindingEvent;
    FOnSelectDataBindingComponent: TNotifyEvent;
    FOnDeleteDataBinding: TNotifyEvent;
    FOptions: TBindCompListViewOptions;
    FDataBindingComponentName: string;
    FCreateDataBindingFactoryContext: TCreateDataBindingFactoryContext;
    FControlComponent: TComponent;
    FCustomActions: TArray<TCustomAction>;
    procedure AddTempString(const S: string);
    procedure RebuildListView;
    procedure SetDesigner(const Value: IDesigner);
    procedure AddFactoryActions(AList: TList<TCustomAction>);
    class procedure AddDataBindingAction(AFactory: IBindCompFactory; Info: Pointer);
    class procedure AddVerbActions(AComponent: TComponent;
      AList: TList<TCustomAction>; ADesigner: IDesigner);
  protected
    procedure CreateWnd; override;
    function CustomDrawItem(Item: TListItem; State: TCustomDrawState;
      Stage: TCustomDrawStage): Boolean; override;
    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    property CustomActions: TArray<TCustomAction> read FCustomActions write FCustomActions;
    property ControlComponent: TComponent read FControlComponent write FControlComponent;
    property Options: TBindCompListViewOptions read FOptions write FOptions;
    property DataBindingComponentName: string read FDataBindingComponentName write FDataBindingComponentName;
    property Designer: IDesigner read FDesigner write SetDesigner;
    property OnNewDataBinding: TNewDataBindingEvent read FOnNewDataBinding write FOnNewDataBinding;
    property OnNewDataBindingFactory: TNewDataBindingFactoryEvent read FOnNewDataBindingFactory write FOnNewDataBindingFactory;
    property OnCreateDataBindingFactoryContext: TCreateDataBindingFactoryContext read FCreateDataBindingFactoryContext write FCreateDataBindingFactoryContext;
    property OnDeleteDataBinding: TNotifyEvent read FOnDeleteDataBinding write FOnDeleteDataBinding;
    property OnSelectDataBindingProperty: TSelectDataBindingEvent read FOnSelectDataBindingProperty write FOnSelectDataBindingProperty;
    property OnSelectDataBindingComponent: TNotifyEvent read FOnSelectDataBindingComponent write FOnSelectDataBindingComponent;
  end;

  TProxyComponent = class;

  TBindArtifactsPropertyEditor = class(TClassProperty)
  protected
    procedure ShowForm(AComponent: TComponent; AMethods: TBindArtifacts); virtual; abstract;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;


  TMethodsPropertyEditor = class(TBindArtifactsPropertyEditor)
  protected
    procedure ShowForm(AComponent: TComponent; AArtifacts: TBindArtifacts); override;
  end;

  TOutputConvertersPropertyEditor = class(TBindArtifactsPropertyEditor)
  protected
    procedure ShowForm(AComponent: TComponent; AArtifacts: TBindArtifacts); override;
  end;


  TCustomBindCompListSprig = class(TComponentSprig)
  end;

  TCustomDataBindingSprig = class(TComponentSprig)
  public
    procedure FigureParent; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    function ItemIndex: Integer; override;
  end;

  TCustomAssociatedDataBindingSprig = class(TComponentSprig)
  public
    procedure FigureParent; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    function ItemIndex: Integer; override;
  end;

  TDataBindingCategorySprig = class(TTransientCollectionSprig)
  private
    FBindCompList: TCustomBindingsList;
    FCategory: string;
  public
    function UniqueName: string; override;
    function Caption: string; override;
    procedure FigureParent; override;
    function SortByIndex: Boolean; override;
  end;

  TComponentDataBindingsSprig = class(TTransientCollectionSprig)
  private
    FComponent: TComponent;
  public
    function UniqueName: string; override;
    function Caption: string; override;
    procedure FigureParent; override;
    function SortByIndex: Boolean; override;
  end;

  TVGSyntheticPropertyGroup = class;
  TVGSyntheticProperty = class(TCustomSyntheticProperty)
  private var
    FGroup: TVGSyntheticPropertyGroup;
  public
    property Group: TVGSyntheticPropertyGroup read FGroup write FGroup;
  end;

  TVGVisibleSyntheticProperty = class(TVGSyntheticProperty,
    IProperty, IProperty80)
  protected
    procedure SetValue(const Value: string); override;
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce;
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TVGLayersNodeSyntheticProperty = class(TVGSyntheticProperty,
    IProperty, IProperty80)
  const
    sMixedCollection = '(Collection)';
  private
    FNodeId: Integer;
  protected
    procedure SetId(AId: Integer);
    procedure GetProperties(Proc: TGetPropProc); override;
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce;
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
  end;

  TVGSyntheticPropertyGroup = class(TCustomSyntheticProperty, IProperty80)
  private var
    FRoot: TComponent;
    FComponents: TArray<TComponent>;
    function GetComponents: TArray<TComponent>;
    procedure SetComponents(const Values: TArray<TComponent>);
  protected
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce;
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetProperties(Proc: TGetPropProc); override;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    property SelectedComponents: TArray<TComponent> read GetComponents write SetComponents;
  end;

  TDataBindingSyntheticProperty = class(TCustomSyntheticProperty, IProperty80, IShowReferenceProperty)
  private
    const
      sName = 'LiveBindings';
  private var
    FComponent: TComponent;
    FBindCompListView: TBindCompListView;
    FHost: IPropertyHost;
    procedure CreateDataBindingFactoryContext(Sender: TObject;
      ABindCompList: TCustomBindingsList;
      var AContext: IBindCompFactoryContext);
    function CreateDataBindingFactoryExecuteContext(
      ABindCompList: TCustomBindingsList): IBindCompFactoryExecuteContext;
    procedure CreateNewDataBindingFactory(Sender: TObject;
      DataBindingFactory: IBindCompFactory;
      BindingsList: TCustomBindingsList);
    procedure SelectDataBindingProperty(Sender: TObject;
      DataBinding: TContainedBindComponent);
  protected
    // IShowReferenceProperty (show events)
    function ShowReferenceProperty: Boolean;
    // IProperty80
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce;

    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetProperties(Proc: TGetPropProc); override;
    property ControlComponent: TComponent read FComponent;
  public
    property Component: TComponent read FComponent write FComponent;
    destructor Destroy; override;
  end;

  // Provide published property which can be used to dynamicall add DataBinding components under a
  // DataBindingsPropery
  TProxyComponent = class(TComponent)
  private
    // List of databinding components that will get deleted
    class var FPendingFreeList: TList<TComponent>;
    class constructor Create;
    var
    FComponent: TComponent;
    FDesigner: IDesigner;
    //FFreeComponent: Boolean;
  public
    class destructor Destroy;
  published
    property ComponentProperty: TComponent read FComponent;
    constructor Create(AOwner: TComponent; ADesigner: IDesigner); reintroduce;
    destructor Destroy; override;
  end;

  TBindVisuallyViewFactory = class(TInterfacedObject, IBindCompFactory)
  private
  protected
    function Enabled(AContext: IBindCompFactoryContext): Boolean;
    function GetCommandText(AContext: IBindCompFactoryContext): string;
    procedure Execute(AContext: IBindCompFactoryExecuteContext);
  end;

  TNewBindCompWizardFactory = class(TInterfacedObject, IBindCompFactory)
  private
  protected
    function GetCategory: string;
    function Enabled(AContext: IBindCompFactoryContext): Boolean;
    function GetCommandText(AContext: IBindCompFactoryContext): string;
    procedure Execute(AContext: IBindCompFactoryExecuteContext);
  end;

procedure GetOwnedAndLinkedComponents(ADesigner: IDesigner; AProc: TProc<TComponent, string>);
begin
  with TGetDesignerComponents.Create(ADesigner) do
  try
    // Support data modules
    GetDesignerComponents(
      procedure(ADesignerComponent: TComponent; ARootName: string)
      begin
        AProc(ADesignerComponent, ARootName);
      end);
  finally
    Free;
  end;
end;

function GetOwnedAndLinkedComponentsList(ADesigner: IDesigner): TArray<TComponent>;
var
  LList: TList<TComponent>;
begin
  LList := TList<TComponent>.Create;
  try
    GetOwnedAndLinkedComponents(ADesigner,
      procedure (AComponent: TComponent; AName: string)
      begin
        Assert(not LList.Contains(AComponent));
        LList.Add(AComponent);
      end);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

// Get components owned by this form, including components in frames
procedure GetOwnedComponents(AOwner: TComponent;
  AProc: TProc<TComponent>);
var
  I: Integer;
  LComponent: TComponent;
begin
  for I := 0 to AOwner.ComponentCount - 1 do  // Find components under a root
  begin
    LComponent := AOwner.Components[I];
    AProc(LComponent);
    if csInline in LComponent.ComponentState then
      GetOwnedComponents(LComponent, AProc);
  end;
end;

function GetRootOwner(AComponent: TComponent): TComponent; forward;

procedure GetBindComponentsOfControlOwner(AOwner: TComponent; AComponent: TComponent; AFunc: TFunc<TContainedBindComponent, Boolean>);
begin
  if AOwner <> nil then
    GetOwnedComponents(AOwner,
      procedure(AOwnedComponent: TComponent)
      begin
        if csDestroying in AOwnedComponent.ComponentState then
        begin
          // Skip
        end
        else if AOwnedComponent is TContainedBindComponent then
          if TContainedBindComponent(AOwnedComponent).ControlComponent = AComponent then
            if not AFunc(TContainedBindComponent(AOwnedComponent)) then
              Exit;
      end);
end;

procedure GetBindComponentsOfControl(AComponent: TComponent; AFunc: TFunc<TContainedBindComponent, Boolean>);
var
  LRoot: TComponent;
begin
  GetBindComponentsOfControlOwner(AComponent.Owner, AComponent, AFunc);
  LRoot := GetRootOwner(AComponent);
  if LRoot <> AComponent.Owner then
    GetBindComponentsOfControlOwner(LRoot, AComponent, AFunc);
end;

procedure GetBindComponentsOfComponentPropertyOwner(AOwner: TComponent; AComponent: TComponent; const AProperty: string; AFunc: TFunc<TContainedBindComponent, Boolean>);
var
  C: TRttiContext;
  T: TRttiType;
  P: TRttiProperty;
begin
  AOwner := GetRootOwner(AComponent);
  if AOwner <> nil then
    GetOwnedComponents(AOwner,
      procedure(AOwnedComponent: TComponent)
      begin
        if csDestroying in AOwnedComponent.ComponentState then
        begin
          // Skip
        end
        else if AOwnedComponent is TContainedBindComponent then
        begin
          try
            T := C.GetType(AOwnedComponent.ClassInfo);
            if Assigned(T) then
            begin
              P := T.GetProperty('ComponentProperty');
              if Assigned(P) and (P.PropertyType.TypeKind = tkUString) then
                if P.GetValue(AOwnedComponent).ToString = AProperty then
                begin
                  P := T.GetProperty('Component');
                  if Assigned(P) and (P.PropertyType.IsInstance) then
                    if P.GetValue(AOwnedComponent).AsObject = AComponent then
                      if not AFunc(TContainedBindComponent(AOwnedComponent)) then
                        Exit;

                end;
            end;
          except
            // Ignore RTTI exceptions
          end;
        end;
      end);
end;

procedure GetBindComponentsOfComponentProperty(AComponent: TComponent; const AProperty: string; AFunc: TFunc<TContainedBindComponent, Boolean>);
var
  LRoot: TComponent;
begin
  GetBindComponentsOfComponentPropertyOwner(AComponent.Owner, AComponent, AProperty, AFunc);
  LRoot := GetRootOwner(AComponent);
  if LRoot <> AComponent.Owner then
    GetBindComponentsOfComponentPropertyOwner(LRoot, AComponent, AProperty, AFunc);
end;

function FindBindComponentsLinkToControl(const AControl: TComponent): TArray<TContainedBindComponent>;
var
  LList: TList<TContainedBindComponent>;
begin
  LList := TList<TContainedBindComponent>.Create;
  try
    GetBindComponentsOfControl(AControl,
      function(ABindComponent: TContainedBindComponent): Boolean
      begin
        LList.Add(ABindComponent);
        Result := True;
      end);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

resourcestring
  sDeleteBindComponents = 'Delete %s?';
  sDeleteCreateBindComponents = 'Delete %0:s and create new %1:s?';
function ConfirmDeleteBindComponents(const ADesigner: IDesigner; AComponents: TArray<TContainedBindComponent>;
  ANewClass: TComponentClass): Boolean;
var
  LComponent: TComponent;
  LMessage: string;
//  S: string;
begin
  if Length(AComponents) = 0 then
    Exit(True);
  LMessage := '';
  for LComponent in AComponents do
  begin
    if LComponent <> nil then
      if LMessage = '' then
        LMessage := LComponent.Name
      else
        LMessage := LMessage + ', ' + LComponent.Name;
  end;
  if LMessage = '' then
    Exit(True);
  if ANewClass <> nil then
    LMessage := Format(sDeleteCreateBindComponents, [LMessage, ANewClass.ClassName])
  else
    LMessage := Format(sDeleteBindComponents, [LMessage]);
  Result := MessageDlg(LMessage, mtConfirmation, mbYesNoCancel, 0) = idYes;
end;

function IntroducedInAncestor(AComponent: TComponent): Boolean;
begin
  Assert(AComponent <> nil);
  Result := ((AComponent.Owner <> nil) and (csInline in AComponent.Owner.ComponentState)) or
    (csAncestor in AComponent.ComponentState);
end;

procedure DeleteBindComponents(const ADesigner: IDesigner; AComponents: TArray<TContainedBindComponent>);
var
  LComponent: TContainedBindComponent;
  LBindActivate: IBindActivate;
  LDesignerSelections: IDesignerSelections;
begin
  LDesignerSelections := CreateSelectionList;
  for LComponent in AComponents do
    if LComponent <> nil then
    begin
      if IntroducedInAncestor(LComponent) then
        raise EDesignPropertyError.CreateRes(@SCantDeleteAncestor); // NonAirException
      try
        Assert(LComponent.Owner = ADesigner.Root);
        LDesignerSelections.Add(LComponent);
        if Supports(LComponent, IBindActivate, LBindActivate) then
        begin
          LBindActivate.SetActive(False);
          LBindActivate := nil;
        end;

      except
        // Ignore errors deactivating
      end;
    end;
  AComponents := nil;
  if LDesignerSelections.Count > 0 then
  begin
    ADesigner.SetSelections(LDesignerSelections);
    ADesigner.DeleteSelection(True);
  end;
end;

function FindBindComponentsLinkToComponentProperty(const AComponent: TComponent; const APropertyName: string): TArray<TContainedBindComponent>;
var
  LList: TList<TContainedBindComponent>;
begin
  LList := TList<TContainedBindComponent>.Create;
  try
    GetBindComponentsOfComponentProperty(AComponent, APropertyName,
      function(ABindComponent: TContainedBindComponent): Boolean
      begin
        LList.Add(ABindComponent);
        Result := True;
      end);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function IsDataSourceComponent(AComponent: TComponent): Boolean;
begin
  Result := False;
  if AComponent is TBindSourceAdapter then
    Result := True
  else if Supports(AComponent, IScopeMemberNames) then
    Result := True
  else if TCustomBindSourceDB.IsDataComponent(AComponent) then
    Result := True;

end;

function IsDataSourceMemberName(AComponent: TComponent; const AMemberName: string): Boolean;
var
  LList: TStrings;
begin
  Result := False;
  if IsDataSourceComponent(AComponent) then
    if AMemberName <> '' then
    begin
      LList := TStringList.Create;
      try
        GetDataSourceMemberNames(AComponent, LList);
        Result := LList.IndexOf(AMemberName) >= 0;
      finally
        LList.Free;
      end;
    end;
end;

function CreateBindingsList(AOwner: TComponent): TBindingsList;
begin
  Result := TBindingsList.Create(nil);
  if Assigned(AOwner) then
  begin
    //Place BindingsList in top left corner of parent (Low Word = Left, High Word = Top)
    Result.DesignInfo := (5 shl 16) + 20;
    AOwner.InsertComponent(Result);
  end;
end;

function FindBindingsList(AOwner: TComponent): TBindingsList;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to AOwner.ComponentCount - 1 do  // Ignores components in frames
  begin
    if AOwner.Components[I] is TBindingsList then
    begin
      Result := TBindingsList(AOwner.Components[I]);
      break;
    end;
  end;
end;

function BindScopeOfDataComponent(const ADesigner: IDesigner; AComponent: TComponent): TCustomBindSourceDB;
var
  LResult: TCustomBindSourceDB;
begin
  LResult := nil;
  with TGetDesignerComponents.Create(ADesigner) do
  try
    // Support data modules
    GetDesignerComponents(
      procedure(ADesignerComponent: TComponent; ARootName: string)
      begin
        if LResult <> nil then
          Exit;
        if ADesignerComponent is TCustomBindSourceDB then
        begin
          with TCustomBindSourceDB(ADesignerComponent) do
          begin
            if AComponent = DataComponent then
              LResult := TCustomBindSourceDB(ADesignerComponent);
          end;
        end;
      end);
  finally
    Free;
  end;
  Result := LResult;
end;

function BindScopeOfAdapter(const ADesigner: IDesigner; AComponent: TComponent): TBaseObjectBindSource;
var
  LResult: TBaseObjectBindSource;
begin
  LResult := nil;
  with TGetDesignerComponents.Create(ADesigner) do
  try
    // Support data modules
    GetDesignerComponents(
      procedure(ADesignerComponent: TComponent; ARootName: string)
      begin
        if LResult <> nil then
          Exit;
        if ADesignerComponent is TBaseObjectBindSource then
        begin
          with TBaseObjectBindSource(ADesignerComponent) do
          begin
            if InternalAdapter <> nil then
              if InternalAdapter = AComponent then
                LResult := TBaseObjectBindSource(ADesignerComponent);
          end;
        end
      end);
  finally
    Free;
  end;
  Result := LResult;
end;

function BindScopeOfDataSourceComponent(const ADesigner: IDesigner; AComponent: TComponent): TComponent;
begin
  Result := nil;
  if AComponent is TBindSourceAdapter then
  begin
    Result := BindScopeOfAdapter(ADesigner, AComponent);
  end;
  if TCustomBindSourceDB.IsDataComponent(AComponent) then
  begin
    Result := BindScopeOfDataComponent(ADesigner, AComponent);
  end;
end;

type
  TDBScope = TBindSourceDB;

function GetDataSourceMemberNames(AComponent: TComponent): TArray<TPersistentPair>;
  function GetMemberNames(AScope: TComponent): TArray<TPersistentPair>;
  var
    LMemberNames: IScopeMemberNames;
    LList: TStrings;
    LArray: TList<TPersistentPair>;
    I: Integer;
    LObject: TObject;
  begin
    Result := nil;
    LList := nil;
    try
      if Supports(AScope, IScopeMemberNames, LMemberNames) then
      begin
        LList := TStringList.Create;
        LMemberNames.GetMemberNames(LList);
        LMemberNames := nil;
      end;
      if LList <> nil then
      begin
        LArray := TList<TPersistentPair>.Create;
        try
          for I := 0 to LList.Count - 1 do
          begin
            LObject := LList.Objects[I];
            if not (LObject is TPersistent) then
              LObject := nil
            else if (LObject is TComponent) and (TComponent(LObject).Name = '') then
              // Don't reference components with no name, such as non persistent TFields in an active TDataSet
              LObject := nil;
            LArray.Add(TPair<string, TPersistent>.Create(LList[I], TPersistent(LObject)));
          end;
          Result := LArray.ToArray;
        finally
          LArray.Free;
        end;
      end;
    finally
      LList.Free;
    end;
  end;

var
  LBindScope: TCustomAdapterBindSource;
  LBindScopeDB: TCustomBindSourceDB;
begin
  Result := nil;
  if AComponent is TBindSourceAdapter then
  begin
    begin
      LBindScope := TAdapterBindSource.Create(nil);
      try
        LBindScope.Adapter := TBindSourceAdapter(AComponent);
        Result := GetMemberNames(LBindScope);
      finally
        LBindScope.Free;
      end;
    end
  end
  else if Supports(AComponent, IScopeMemberNames) then
  begin
    Result := GetMemberNames(AComponent)
  end
  else if TCustomBindSourceDB.IsDataComponent(AComponent) then
  begin
      LBindScopeDB := TDBScope.Create(nil);
      try
        LBindScopeDB.DataComponent := AComponent;
        Result := GetMemberNames(LBindScopeDB);
      finally
        LBindScopeDB.Free;
      end;
  end;
end;

function GetDataSourceMemberNames(AComponent: TComponent; AList: TStrings): Boolean;

  procedure GetMemberNames(AScope: TComponent);
  var
    LMemberNames: IScopeMemberNames;
  begin
    if Supports(AScope, IScopeMemberNames, LMemberNames) then
    begin
      LMemberNames.GetMemberNames(AList);
      LMemberNames := nil;
    end;
  end;

var
  LBindScope: TCustomAdapterBindSource;
  LBindScopeDB: TCustomBindSourceDB;
begin
  Result := False;
  if AComponent is TBindSourceAdapter then
  begin
    Result := True;
    LBindScope := TAdapterBindSource.Create(nil);
    try
      LBindScope.Adapter := TBindSourceAdapter(AComponent);
      GetMemberNames(LBindScope);
    finally
      LBindScope.Free;
    end;
  end
  else if Supports(AComponent, IScopeMemberNames) then
  begin
    Result := True;
    GetMemberNames(AComponent)
  end
  else if TCustomBindSourceDB.IsDataComponent(AComponent) then
  begin
    Result := True;
    LBindScopeDB := TDBScope.Create(nil);
    try
      LBindScopeDB.DataComponent := AComponent;
      GetMemberNames(LBindScopeDB);
    finally
      LBindScopeDB.Free;
    end;
  end;
end;

function GenerateComponentName(const APrefix, AMemberName: string;
   Number: Integer): string;
  function Alpha(C: Char): Boolean; inline;
  begin
    Result := C.IsLetter or (C = '_');
  end;

  function AlphaNumeric(C: Char): Boolean; inline;
  begin
    Result := C.IsLetterOrDigit or (C = '_');
  end;

  function CrunchFieldName(const AMemberName: string): string;
  var
    I: Integer;
  begin
    Result := AMemberName;
    I := 1;
    while I <= Length(Result) do
    begin
      if AlphaNumeric(Result[I]) then
        Inc(I)
      else
        Delete(Result, I, 1);
    end;
  end;

var
  LFmt: string;
  LMemberName: string;
begin
  LMemberName := CrunchFieldName(APrefix + AMemberName);
  if (LMemberName = '') or not Alpha(LMemberName[1]) then
    LMemberName := CrunchFieldName(APrefix + 'Field' + AMemberName);
  if Number < 2 then
    LFmt := '%s'
  else
    LFmt := '%s%d';
  Result := Format(LFmt, [LMemberName, Number]);
end;

function CreateUniqueComponentName(AOwner: TComponent;
  const APrefix, AMemberName: string): string;
var
  I: Integer;

  function IsUnique(const AName: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    with AOwner do
      for I := 0 to ComponentCount - 1 do  // ignores components in frames
        if CompareText(AName, Components[I].Name) = 0 then
          Exit;
    Result := True;
  end;

begin
  for I := 1 to MaxInt do
  begin
    Result := GenerateComponentName(APrefix, AMemberName, I);
    if IsUnique(Result) then Exit;
  end;
end;


{ TBindCompListEditor }

procedure TBindCompListEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowBindCompListDesigner(Designer, (Component as TBindingsList));
    1: ExecuteNewBindingsDlg;
  else
    Assert(False);
  end;
end;

procedure TBindCompListEditor.ExecuteNewBindingsDlg;
var
  LBindingsList: TBindingsList;
begin
  LBindingsList := Component as TBindingsList;
  with TExecuteNewDataBinding.Create(LBindingsList,
    Designer) do
  begin
    Execute(
      procedure
      begin
      end,
      procedure(ACategory: string; ADataBinding: TContainedBindComponent)
      begin
        ADataBinding.Name := Designer.UniqueName(System.Copy(ADataBinding.ClassName, 2, MaxInt));

        ADataBinding.Category := ACategory;
        ADataBinding.BindingsList := LBindingsList;
        Designer.Modified;
        Designer.SelectComponent(ADataBinding);
      end,
      procedure
      begin
        //FocusDataBinding(LDataBinding)
      end,
      function(AClass: TContainedBindCompClass): Boolean
      begin
        Result := True;
      end);
  end;
end;

function TBindCompListEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SBindCompListEdit;
    1: Result := SNewBindingDlgCommand;
  else
    Assert(False);
  end;
end;

function TBindCompListEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TAddBindComponentEditor }

constructor TBindCompFactorySelectionEditor.Create(const ADesigner: IDesigner);
begin
  inherited;
end;

destructor TBindCompFactorySelectionEditor.Destroy;
begin
  FActions.Free;
  inherited;
end;

procedure TBindCompFactorySelectionEditor.ExecuteVerb(Index: Integer; const List: IDesignerSelections);
var
  LFactoryAction: TFactoryAction;
begin
  // Create actions on demand rather than in constructor to improve
  // performance of code insite
  AddFactoryActions(FActions);
  LFactoryAction := FActions[Index] as TFactoryAction;
  CreateNewDataBindingFactory(LFactoryAction, LFactoryAction.FFactory,
    LFactoryAction.FBindingsList);

  // Reselect to update verbs
//  DesignNotificationSelectionChanged(Designer, CreateSelectionList);
//  DesignNotificationSelectionChanged(Designer, List);
end;

function TBindCompFactorySelectionEditor.GetVerb(Index: Integer): string;
begin
  // Create actions on demand rather than in constructor to improve
  // performance of code insite
  AddFactoryActions(FActions);
  Result := FActions[Index].Caption;
end;

procedure TBindCompFactorySelectionEditor.CreateNewDataBindingFactory(Sender: TObject;
  DataBindingFactory: IBindCompFactory; BindingsList: TCustomBindingsList);
var
  LContext: IBindCompFactoryExecuteContext;
  LBindCompList: TBindingsList;
begin
  LBindCompList := nil;
  LContext := CreateDataBindingFactoryExecuteContext(BindingsList);
  Assert(LContext <> nil);
  if LContext.BindingsList = nil then
  begin
    LBindCompList := BindCompReg.CreateBindingsList(LContext.Owner);
    LBindCompList.Name := LContext.UniqueName(LBindCompList.ClassType.ClassName
     );
    (LContext as TDataBindingFactoryExecuteContext).FBindCompList := LBindCompList;
  end;
  if LContext <> nil then
    DataBindingFactory.Execute(LContext);
  if LBindCompList <> nil then
  begin
    if LBindCompList.BindCompCount = 0 then
      // Free compononent we've create because no binding components created
      LBindCompList.Free;
  end;

end;

class procedure TBindCompFactorySelectionEditor.AddDataBindingAction(
  AFactory: IBindCompFactory; Info: Pointer);
var
  LInfo: PAddActionInfo;
  LAction: TFactoryAction;
begin
  LInfo := PAddActionInfo(Info);
  if AFactory.Enabled(LInfo.FContext) then
  begin
    LAction := TFactoryAction.Create(
      AFactory.GetCommandText(LInfo.FContext), LInfo.FBindingsList, AFactory);
    LInfo.FList.Add(LAction);
  end;
end;

function TBindCompFactorySelectionEditor.GetVerbCount: Integer;
begin
  // Create actions on demand rather than in constructor to improve
  // performance of code insite
  AddFactoryActions(FActions);
  Result := FActions.Count;
end;

procedure TBindCompFactorySelectionEditor.CreateDataBindingFactoryContext(Sender: TObject; ABindCompList: TCustomBindingsList;
  out AContext: IBindCompFactoryContext);
var
  LComponent: TComponent;
  List: IDesignerSelections;
begin
  AContext := nil;
  List := CreateSelectionList;
  Designer.GetSelections(List);
  if (List.Count > 0) and (List[0] is TComponent) then
    LComponent := TComponent(List[0])
  else
    LComponent := nil;
  if LComponent <> nil then
  begin
    AContext := TDataBindingFactoryContext.Create(Designer, ABindCompList,
      LComponent); //FComponent);
  end
  else
    AContext := nil;
end;

type
  TBindCompFactorySelectionEditorExecuteContext = class(TDataBindingFactoryExecuteContext)
  public
    procedure BindCompCreated(AComponent: TComponent); override;

  end;

function TBindCompFactorySelectionEditor.CreateDataBindingFactoryExecuteContext(ABindCompList: TCustomBindingsList): IBindCompFactoryExecuteContext;
var
  LComponent: TComponent;
  List: IDesignerSelections;
begin
  Result := nil;
  List := CreateSelectionList;
  Designer.GetSelections(List);
  if (List.Count > 0) and (List[0] is TComponent) then
    LComponent := TComponent(List[0])
  else
    LComponent := nil;
  if LComponent <> nil then
  begin
    Result := TBindCompFactorySelectionEditorExecuteContext.Create(Designer, ABindCompList,
      LComponent); //FComponent);
  end;
end;

procedure TBindCompFactorySelectionEditor.AddTempString(const S: string);
begin
  FTempStringList.Add(S);
end;


procedure TBindCompFactorySelectionEditor.AddFactoryActions(AList: TList<TCustomAction>);
var
  LBindCompList: TCustomBindingsList;
  I: Integer;
  LBindCompLists: TList<TCustomBindingsList>;
  LDataBindingFactoryContext: IBindCompFactoryContext;
  LInfo: TAddActionInfo;
begin
  // Create actions on demand rather than in constructor to improve
  // performance of code insite
  // Don't need parameter anymore, but for updates must not change signature
  Assert(AList = FActions);
  if FActions <> nil then
    Exit;
  FActions := TObjectList<TCustomAction>.Create;
  AList := FActions;
  LBindCompLists := TList<TCustomBindingsList>.Create;
  try
    // Build list of ActionLists
    FTempStringList := TStringList.Create;
    try
      Designer.GetComponentNames(GetTypeData(TypeInfo(TBindingsList)), AddTempString);
      for I := 0 to FTempStringList.Count - 1 do
      begin
        Assert(Designer.GetComponent(FTempStringList[I]) is TBindingsList);
        LBindCompLists.Add(TBindingsList(Designer.GetComponent(FTempStringList[I])));
      end;
    finally
      FreeAndNil(FTempStringList);
    end;
    // Build menus even if no databinding list, factory will create one
    if LBindCompLists.Count = 0 then
      LBindCompLists.Add(nil);
    // Build popupmenus for actionlists and standard actions
    for LBindCompList in LBindCompLists do
    begin
      CreateDataBindingFactoryContext(Self, nil, LDataBindingFactoryContext);
      if LDataBindingFactoryContext <> nil then
      begin
        Assert(LDataBindingFactoryContext <> nil);
        LInfo.FContext := LDataBindingFactoryContext;
        LInfo.FBindingsList := LBindCompList;
        LInfo.FList := AList;
        if Assigned(EnumRegisteredBindCompFactoriesProc) then
          EnumRegisteredBindCompFactories(AddDataBindingAction, @LInfo);
      end;

      // Note: only create one verb for the first bindings list...
      break;
    end;
  finally
    LBindCompLists.Free;
  end;
end;

{ TBindCompExpressionEditor }

procedure TBindCompExpressionEditor.ExecuteVerb(Index: Integer);
begin
  ShowBindCompExprDesigner(Designer, (Component as TContainedBindComponent));
end;

function TBindCompExpressionEditor.GetVerb(Index: Integer): string;
begin
  Result := SBindCompExpressionEdit;
end;

function TBindCompExpressionEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

//{ TBaseLinkingBindScopeEditor }

resourcestring
  SAddNavigator = 'Add Navigator';
  SAddBindScope = 'Add BindSource';


{ TBindFillListExpressionEditor }

procedure TBindFillListExpressionEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
  LList: TCustomBindList;
begin
  LList := Component as TCustomBindList;
  Assert(LList <> nil);
  I := inherited GetVerbCount;
  if Index < I then
    inherited
  else if LList <> nil then
    case Index - I of
      0: LList.FillList;
      1: LList.ClearList;
    end;
end;

function TBindFillListExpressionEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then
    Result := inherited
  else
    case Index - I of
      0: Result := SBindFillList;
      1: Result := SBindClearList;
    end;
end;

function TBindFillListExpressionEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 2;
end;

{ TBindEvaluateExpressionEditor }

procedure TBindEvaluateExpressionEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then
    inherited
  else
    case Index - I of
      0: (Component as TCustomBindExpression).EvaluateFormat;
    end;
end;

function TBindEvaluateExpressionEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then
    Result := inherited
  else
    case Index - I of
      0: Result := SEvaluate;
    end;
end;

function TBindEvaluateExpressionEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1;
end;

{ TBindEvaluateExprItemsEditor }

procedure TBindFillGridLinkExpressionEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
begin
  Assert(Component is TCustomBindGridLink);
  I := inherited GetVerbCount;
  if Index < I then
    inherited
  else
    case Index - I of
      0: (Component as TCustomBindGridLink).FillGrid;
      1: (Component as TCustomBindGridLink).ClearGrid;
    end;
end;

function TBindFillGridLinkExpressionEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then
    Result := inherited
  else
    case Index - I of
      0: Result := SBindFillGrid;
      1: Result := SBindClearGrid;
    end;
end;

function TBindFillGridLinkExpressionEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 2;
end;

{ TBindFillGridListExpressionEditor }

function TBindFillGridListExpressionEditor.GetBindList: TCustomBindGridList;
var
  LBindComponent: TCommonBindComponent;
begin
  Result := nil;
  if Component is TCustomBindGridList then
    Result := TCustomBindGridList(Component)
  else if Component is TBindComponentDelegate then
  begin
    for LBindComponent in TBindComponentDelegate(Component).GetDelegates do
      if LBindComponent is TCustomBindGridList then
      begin
        Result := TCustomBindGridList(LBindComponent);
        break;
      end;
  end;
end;

procedure TBindFillGridListExpressionEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
  LList: TCustomBindGridList;
begin
  I := inherited GetVerbCount;
  LList := GetBindList;
  Assert(LList <> nil);
  if Index < I then
    inherited
  else if LList <> nil then
    case Index - I of
      0: LList.FillList;
      1: LList.ClearList;
    end;
end;

function TBindFillGridListExpressionEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then
    Result := inherited
  else
    case Index - I of
      0: Result := SBindFillList;
      1: Result := SBindClearList;
    end;
end;

function TBindFillGridListExpressionEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 2;
end;

{ TBindEvaluateExprItemsEditor }

procedure TBindEvaluateExprItemsEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then
    inherited
  else
    case Index - I of
      0: (Component as TCustomBindExprItems).EvaluateFormat;
      1: (Component as TCustomBindExprItems).EvaluateClear;
    end;
end;

function TBindEvaluateExprItemsEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then
    Result := inherited
  else
    case Index - I of
      0: Result := SEvaluateFormat;
      1: Result := SEvaluateClear;
    end;
end;

function TBindEvaluateExprItemsEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 2;
end;

{ TBindCompListView }

constructor TBindCompListView.Create(AOwner: TComponent);
begin
  inherited;
  FActionsDictionary := TDictionary<TListItem, TCustomAction>.Create;
  FImageList := TImageList.Create(nil);
  FTempStringList := TStringList.Create;
  BorderStyle := bsNone;
  Columns.Add;
  Height := FDefItemHeight;
  ReadOnly := True;
  RowSelect := True;
  ShowColumnHeaders := False;
  SmallImages := FImageList;
  ViewStyle := vsReport;
  Width := 200;
end;

destructor TBindCompListView.Destroy;
begin
  FreeAndNil(FImageList);
  FreeAndNil(FActionsDictionary);
  inherited;
end;

procedure TBindCompListView.AddTempString(const S: string);
begin
  FTempStringList.Add(S);
end;

procedure TBindCompListView.Click;
var
  P: TPoint;
  Item: TListItem;
  LAction: TCustomAction;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  Item := GetItemAt(P.X, P.Y);

  if Item <> nil then
  begin
    if (Item.Data = Self) then
    begin
      if  Assigned(FOnSelectDataBindingProperty) then
        FOnSelectDataBindingProperty(Self, TContainedBindComponent(Item.Data));
    end
    else if (Item.Data <> nil) then
    begin
        if  Assigned(FOnSelectDataBindingProperty) then
          FOnSelectDataBindingProperty(Self, TContainedBindComponent(Item.Data))
    end
    else
    begin
      if Item = FSelectComponentItem then
      begin
        if  Assigned(FOnSelectDataBindingComponent) then
          FOnSelectDataBindingComponent(Self)
      end
      else if Item = FDeleteComponentItem then
      begin
        if Assigned(FOnDeleteDataBinding) then
          FOnDeleteDataBinding(Self)
      end
      else if FActionsDictionary.TryGetValue(Item, LAction) then
        if LAction is TFactoryAction then
        begin
          if Assigned(FOnNewDataBindingFactory) then
            FOnNewDataBindingFactory(Self,
              TFactoryAction(LAction).FFactory, TFactoryAction(LAction).FBindingsList)
        end
        else
          LAction.Execute;
    end
  end
  else
    if Assigned(FOnSelectDataBindingProperty) then
      FOnSelectDataBindingProperty(Self, nil);
end;

procedure TBindCompListView.CreateWnd;
begin
  inherited;
  if Designer.Root <> nil then
    RebuildListView;
end;

function TBindCompListView.CustomDrawItem(Item: TListItem;
  State: TCustomDrawState; Stage: TCustomDrawStage): Boolean;
var
  LRect: TRect;
begin
  Result := True;
  Canvas.Brush.Style := bsClear;
  LRect := Item.DisplayRect(drLabel);

  case Stage of
    cdPrePaint:
      // Draw separator
      if Item.Caption = '' then
      begin
        Canvas.Pen.Color := clSilver;
        Canvas.MoveTo(LRect.Left, LRect.Top + (LRect.Bottom - LRect.Top) div 2);
        Canvas.LineTo(LRect.Right - LRect.Left, LRect.Top + (LRect.Bottom - LRect.Top) div 2);
        Result := False; // Prevent default drawing of highlight bar
      end;
    cdPostPaint:
      // Draw arrow for New Action and New Standard Action items
//      if ((Item.Index <= 1) and (FNewStdActnPopupMenu.Items.Count > 1)) and
//         (((Item.Index = 0) and (FNewActnPopupMenu.Items.Count > 1)) or
//         ((Item.Index = 1) and (FNewStdActnPopupMenu.Items.Count > 1))) then
//      if Item.Data = FNewStdActnPopupMenu then
//
//      begin
//        LRect.Left := LRect.Right - 20;
//        if ThemeServices.ThemesEnabled and (Win32MajorVersion >= 6) then
//          DrawThemeBackground(ThemeServices.Theme[teMenu], Canvas.Handle,
//            MENU_POPUPSUBMENU, MSM_NORMAL, LRect, nil)
//        else
//          DrawArrow(Canvas, sdRight, Point(LRect.Right - 15,
//            LRect.Top + ((LRect.Bottom - LRect.Top - 8) div 2)), 4);
//      end;
  end;
end;

function TBindCompListView.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  Result := (Stage = cdPrePaint) or (Stage = cdPostPaint);
end;

procedure TBindCompListView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      if  (Selected <> nil) then
      begin
        if Selected.Data <> nil then
        begin
          if Assigned(FOnSelectDataBindingProperty) then
            FOnSelectDataBindingProperty(Self, TContainedBindComponent(Selected.Data));
        end
        else
          if Assigned(FOnDeleteDataBinding) then
            FOnDeleteDataBinding(Self);

      end;
    VK_RIGHT:
      if Selected <> nil then
      begin
//        if Selected.Data = FNewStdActnPopupMenu then
//          ShowPopupMenu(Selected, FNewStdActnPopupMenu);
      end;
  else
    inherited;
  end;
end;

procedure TBindCompListView.RebuildListView;
var
  LRect: TRect;
  ListItem: TListItem;
  LDataBinding: TContainedBindComponent;
  I, LWidth, MinWidth: Integer;
  LItemIndex: Integer;
  LExistingDataBindingCount: Integer;
  LAction: TCustomAction;
begin
  FDeleteComponentItem := nil;
  FSelectComponentItem := nil;
  FActionsDictionary.Clear;
  LExistingDataBindingCount := 0;
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      FImageList.Clear;

      // Set initial max width
      MinWidth := 0; // Max(Width, Canvas.TextWidth(SCreateNewDataBinding) + 25);

      if TBindCompListViewOption.dblvSelectExisting in FOptions then
      begin
        // Find all actions
        FTempStringList.Clear;
        Designer.GetComponentNames(GetTypeData(TypeInfo(TContainedBindComponent)), AddTempString);
        for I := 0 to FTempStringList.Count - 1 do
        begin
          LDataBinding := TContainedBindComponent(Designer.GetComponent(FTempStringList[I]));
          if LDataBinding.ControlComponent <> Self.ControlComponent then
            Continue;

          ListItem := Items.Add;
          ListItem.Caption := FTempStringList[I];
          ListItem.Data := LDataBinding;
          ListItem.ImageIndex := -1;
          Inc(LExistingDataBindingCount);
          MinWidth := Max(MinWidth, Canvas.TextWidth(ListItem.Caption));

        end;

        // Sort list items before adding "special" items
        CustomSort(nil, 0);
      end;

      LItemIndex := 0;

      if TBindCompListViewOption.dblvDelete in FOptions then
      begin
        // Delete data binding item
        ListItem := Items.Insert(LItemIndex);
        FDeleteComponentItem := ListItem;
        ListItem.Caption := Format(SDeleteDataBinding, [FDataBindingComponentName]);
        ListItem.ImageIndex := -1;
        ListItem.Data := nil;
        MinWidth := Max(MinWidth, Canvas.TextWidth(ListItem.Caption));
        Inc(LItemIndex);
      end;

      if TBindCompListViewOption.dblvSelect in FOptions then
      begin
        // Delete data binding item
        ListItem := Items.Insert(LItemIndex);
        FSelectComponentItem := ListItem;
        ListItem.Caption := Format(SSelectDataBinding, [FDataBindingComponentName]);
        ListItem.ImageIndex := -1;
        ListItem.Data := nil;
        MinWidth := Max(MinWidth, Canvas.TextWidth(ListItem.Caption));
        Inc(LItemIndex);
      end;

      if LExistingDataBindingCount > 0 then
        if TBindCompListViewOption.dblvSelectExisting in FOptions then
        begin
          // Add dummy item for divider line
          //if LItemIndex > 2 then
          begin
            // Add existing DataBinding instances
            ListItem := Items.Insert(LItemIndex);
            ListItem.ImageIndex := -1;
          end;
        end;

      if Length(FCustomActions) > 0 then
        for LAction in FCustomActions do
        begin
          if LAction.Enabled and LAction.Visible then
          begin
            ListItem := Items.Insert(LItemIndex);
            ListItem.Caption := LAction.Caption;
            ListItem.ImageIndex := -1;
            ListItem.Data := nil;
            FActionsDictionary.Add(ListItem, LAction);
            MinWidth := Max(MinWidth, Canvas.TextWidth(ListItem.Caption) + FImageList.Width);
            Inc(LItemIndex);
          end;
        end;
    finally
      Items.EndUpdate;
    end;

    LWidth := 0;
//    if LExistingDataBindingCount > 0 then
//      if TBindCompListViewOption.dblvSelectExisting in FOptions then
      begin
        // Set Height to fit 14 items
        if Items.Count > 14 then
        begin
          I := 14;
          LWidth := GetSystemMetrics(SM_CXVSCROLL);
        end
        else
          I := Items.Count;
        if Items.Count > 0 then
        begin
          LRect := Items[0].DisplayRect(drBounds);
          Height := LRect.Bottom * I;
        end
        else
          Height := FDefItemHeight
      end;
    // Set width to widest + space gutters (20 pixels each side)
    Self.Width := MinWidth + LWidth + 40; //+ FImageList.Width;
    Columns[0].Width := Width - LWidth;
  end
//  else
//    Height := FDefItemHeight;
end;



class procedure TBindCompListView.AddDataBindingAction(
  AFactory: IBindCompFactory; Info: Pointer);
var
  LInfo: PAddActionInfo;
  LAction: TFactoryAction;
begin
  LInfo := PAddActionInfo(Info);
  if AFactory.Enabled(LInfo.FContext) then
  begin
    LAction := TFactoryAction.Create(
      AFactory.GetCommandText(LInfo.FContext), LInfo.FBindingsList, AFactory);
    LInfo.FList.Add(LAction);
  end;
end;

procedure TBindCompListView.AddFactoryActions(AList: TList<TCustomAction>);
var
  LBindCompList: TCustomBindingsList;
  I: Integer;
  LBindCompLists: TList<TCustomBindingsList>;
  LDataBindingFactoryContext: IBindCompFactoryContext;
  LInfo: TAddActionInfo;
begin
  LBindCompLists := TList<TCustomBindingsList>.Create;
  try
    // Build list of ActionLists
    FTempStringList.Clear;
    Designer.GetComponentNames(GetTypeData(TypeInfo(TBindingsList)), AddTempString);
    for I := 0 to FTempStringList.Count - 1 do
    begin
      Assert(Designer.GetComponent(FTempStringList[I]) is TBindingsList);
      LBindCompLists.Add(TBindingsList(Designer.GetComponent(FTempStringList[I])));
    end;
    // Build menus even if no databinding list, factory will create one
    if LBindCompLists.Count = 0 then
      LBindCompLists.Add(nil);
    // Build popupmenus for actionlists and standard actions
    for LBindCompList in LBindCompLists do
    begin
      FCreateDataBindingFactoryContext(Self, nil, LDataBindingFactoryContext);
      Assert(LDataBindingFactoryContext <> nil);
      LInfo.FContext := LDataBindingFactoryContext;
      LInfo.FBindingsList := LBindCompList;
      LInfo.FList := AList;
      if Assigned(EnumRegisteredBindCompFactoriesProc) then
        EnumRegisteredBindCompFactories(AddDataBindingAction, @LInfo);
    end;
  finally
    LBindCompLists.Free;
  end;
end;

class procedure TBindCompListView.AddVerbActions(AComponent: TComponent; AList: TList<TCustomAction>;
   ADesigner: IDesigner);
var
  LAction: TVerbAction;
  LEditor: IComponentEditor;
  I: Integer;
  LText: string;
begin
  LEditor := GetComponentEditor(AComponent, ADesigner);
  if LEditor <> nil then
  begin
    for I := 0 to LEditor.GetVerbCount - 1 do
    begin
      LText := LEditor.GetVerb(I);
      LText := ReplaceStr(LText, '&', '');
      LAction := TVerbAction.Create(
        LText, AComponent, I, ADesigner);
      AList.Add(LAction);
    end;

  end;
end;


procedure TBindCompListView.SetDesigner(const Value: IDesigner);
begin
  if Value <> FDesigner then
  begin
    FDesigner := Value;

    // Set initial height based on default item height
    FTempStringList.Clear;
    Designer.GetComponentNames(GetTypeData(TypeInfo(TContainedBindComponent)), AddTempString);
    if FTempStringList.Count > 0 then
      Height := (Min(FTempStringList.Count, 11) + 3) * FDefItemHeight
    else
      Height := FDefItemHeight;

    // Rebuild popup menus and listview
    //RebuildPopupMenus;
    if HandleAllocated then
      RebuildListView;
  end;
end;

{ TCustomDataBindingSprig }

function TCustomDataBindingSprig.DragDropTo(AItem: TSprig): Boolean;
begin
  Result := False;

         
//  if AItem is TActionCategorySprig then
//  begin
//    Result := not AnsiSameText(TActionCategorySprig(AItem).FCategory, TContainedAction(Item).Category);
//    if Result then
//      TContainedAction(Item).Category := TActionCategorySprig(AItem).FCategory;
//  end
//
//  else if AItem is TContainedActionSprig then
//  begin
//    Result := True;
//    TContainedAction(Item).Index := TContainedAction(AItem.Item).Index;
//    if not AnsiSameText(TContainedAction(Item).Category, TContainedAction(AItem.Item).Category) then
//      TContainedAction(Item).Category := TContainedAction(AItem.Item).Category;
//    Parent.SetIndexOf(AItem, TContainedAction(AItem.Item).Index);
//  end;
end;

function TCustomDataBindingSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := False;        
//  Result := ((AItem is TActionCategorySprig) and
//             (TActionCategorySprig(AItem).FActionList = TContainedAction(Item).ActionList)) or
//            ((AItem is TContainedActionSprig) and
//             (TContainedAction(AItem.Item).ActionList = TContainedAction(Item).ActionList));
end;

const
  CDataBindingCategoryPrefix = '<DataBindingCategory>';

function DataBindingCategorySprigName(const ACategory: string): string;
begin
  Result := Format('%s.%s', [CDataBindingCategoryPrefix, ACategory]);
end;

function ComponentDataBindingsSprigName: string;
begin
  Result := 'LiveBindings';
end;

procedure TCustomDataBindingSprig.FigureParent;
var
  LListSprig, LCatSprig: TSprig;
begin
  with TContainedBindComponent(Item) do
  begin
    LListSprig := SeekParent(BindingsList, False);
    if Assigned(LListSprig) then
    begin
      LCatSprig := LListSprig.Find(DataBindingCategorySprigName(Category), False);
      if not Assigned(LCatSprig) then
      begin
        LCatSprig := LListSprig.Add(TDataBindingCategorySprig.Create(nil));
        TDataBindingCategorySprig(LCatSprig).FBindCompList := BindingsList;
        TDataBindingCategorySprig(LCatSprig).FCategory := Category;
      end;
      LCatSprig.Add(Self);
    end;
  end;
end;

function TCustomDataBindingSprig.ItemIndex: Integer;
begin
  Result := TContainedBindComponent(Item).Index;
end;

{ TCustomAssociatedDataBindingSprig }

function TCustomAssociatedDataBindingSprig.DragDropTo(AItem: TSprig): Boolean;
begin
  Result := False;
end;

function TCustomAssociatedDataBindingSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := False;
end;

procedure TCustomAssociatedDataBindingSprig.FigureParent;
var
  LListSprig, LCatSprig: TSprig;
begin
  with TContainedBindComponent(Item) do
  begin
    if ControlComponent <> nil then
    begin
      LListSprig := SeekParent(ControlComponent, False);
      if Assigned(LListSprig) then
      begin
        LCatSprig := LListSprig.Find(ComponentDataBindingsSprigName, False);
        if not Assigned(LCatSprig) then
        begin
          LCatSprig := LListSprig.Add(TComponentDataBindingsSprig.Create(nil));
          TComponentDataBindingsSprig(LCatSprig).FComponent := ControlComponent;
        end;
        LCatSprig.Add(Self);
        //LListSprig.Add(Self);
      end;
    end;
  end;
end;

function TCustomAssociatedDataBindingSprig.ItemIndex: Integer;
begin
  //Result := TContainedBindComponent(Item).Index;
  Result := inherited;
end;

{ TDataBindingCategorySprig }

function TDataBindingCategorySprig.Caption: string;
begin
  Result := FCategory;
  if Result = '' then
    Result := SDataBindingCategoryNone;
end;

procedure TDataBindingCategorySprig.FigureParent;
begin
  SeekParent(FBindCompList, False);
end;

function TDataBindingCategorySprig.SortByIndex: Boolean;
begin
  Result := True;
end;

function TDataBindingCategorySprig.UniqueName: string;
begin
  Result := DataBindingCategorySprigName(FCategory);
end;

{ TComponentDataBindingsSprig }

function TComponentDataBindingsSprig.Caption: string;
begin
//  Result := FCategory;
//  if Result = '' then
//    Result := SDataBindingCategoryNone;
  Result := ComponentDataBindingsSprigName;
end;

procedure TComponentDataBindingsSprig.FigureParent;
begin
  SeekParent(FComponent, False);
end;

function TComponentDataBindingsSprig.SortByIndex: Boolean;
begin
  // Result := True;
  Result := inherited;
end;

function TComponentDataBindingsSprig.UniqueName: string;
begin
  // Result := DataBindingCategorySprigName(FCategory);
  Result := ComponentDataBindingsSprigName;
end;

type

  TPrototypeBindSourceFactory = class(TBindScopeFactory)
  public
    function GetEnabled: Boolean; override;
    function BindScopeClass: TComponentClass; override;
    function CreateNewBindScopeManager(AOwner: TComponent): INewBindScopeManager; override;
    function CreateBindScopeEditor(AOwner: TComponent; AScope: TComponent): IBindScopeEditor; override;
  end;

  TDataGeneratorAdapterFactory = class(TBindScopeFactory)
  public
    function GetEnabled: Boolean; override;
    function CanCreate: Boolean; override;
    function BindScopeClass: TComponentClass; override;
    function CreateNewBindScopeManager(AOwner: TComponent): INewBindScopeManager; override;
    function CreateBindScopeEditor(AOwner: TComponent; AScope: TComponent): IBindScopeEditor; override;
  end;

  TBaseNewGeneratorScopeManager = class(TNewBindScopeManager)
  private
    FOwner: TComponent;
    FDesigner: IDesigner;
    procedure ValidateNewField(Sender: TObject; var AValid: Boolean);
    function FieldExists(const AFieldName: string): Boolean;
    procedure ExistingFieldName(Sender: TObject; const AFieldName: string;
      var AExists: Boolean);
  protected
    function GetAdapter: TCustomDataGeneratorAdapter; virtual; abstract;
    //function InternalDataSource: TComponent; override;
    function AddField: string; override;
    function CanAddFields: Boolean; override;
    function CanRemoveField(const AFieldName: string): Boolean; override;
    function RemoveField(const AFieldName: string): Boolean; override;
    //function CreateScope: TBaseLinkingBindSource; override;
  public
    constructor Create(AOwner: TComponent; const ADesigner: IDesigner);
    destructor Destroy; override;

  end;

  TNewPrototypeBindSourceManager = class(TBaseNewGeneratorScopeManager)
  private
    FDataSource: TCustomPrototypeBindSource;
  protected
    function InternalDataSource: TComponent; override;
    function CreateScope: TBaseLinkingBindSource; override;
    function GetAdapter: TCustomDataGeneratorAdapter; override;
  public
    destructor Destroy; override;
  end;


  TDataGeneratorAdapterEditor = class(TBindScopeEditor)
  private
    FDataSource: TCustomDataGeneratorAdapter;
    FOwner: TComponent;
    FDesigner: IDesigner;
    FNewFields: TList<TGeneratorFieldDef>;
    function FindNewField(const AFieldName: string): Integer;
    procedure ValidateNewField(Sender: TObject; var AValid: Boolean);
    function FieldExists(const AFieldName: string): Boolean;
    procedure ExistingFieldName(Sender: TObject; const AFieldName: string;
      var AExists: Boolean);
  protected
    function CanAddFields: Boolean; override;
    function AddField: TArray<string>; override;
    function CanRemoveField(const AFieldName: string): Boolean; override;
    function RemoveField(const AFieldName: string): Boolean; override;
    procedure GetMembers(AList: TStrings); override;
    function Changed: Boolean; override;
    function ApplyChanges: TArray<TPersistentPair>; override;
  public
    constructor Create(AOwner: TComponent; ADataSource: TCustomDataGeneratorAdapter; const ADesigner: IDesigner);
    destructor Destroy; override;

  end;

  TPrototypeBindSourceEditor = class(TDataGeneratorAdapterEditor)
  private
    FDataSource: TCustomPrototypeBindSource;
  protected
    constructor Create(AOwner: TComponent; ADataSource: TCustomPrototypeBindSource; const ADesigner: IDesigner);
  end;


  TGeneratorFieldDefsPropertyEditor = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure TGeneratorFieldDefsPropertyEditor.Edit;
begin
  ShowCollectionEditorClass(Designer, TBindAdapterColumnsEditor,
    GetComponent(0) as TComponent, TCollection(GetOrdValue), GetName);
end;

function TGeneratorFieldDefsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly{$IFDEF LINUX}, paVCL{$ENDIF}];
end;

{ TDataGeneratorAdapterFactory }

function TDataGeneratorAdapterFactory.CanCreate: Boolean;
begin
  Result := False;
end;

function TDataGeneratorAdapterFactory.CreateBindScopeEditor(
  AOwner: TComponent; AScope: TComponent): IBindScopeEditor;
begin
  Assert(AScope is TCustomDataGeneratorAdapter);
  Result := TDataGeneratorAdapterEditor.Create(AOwner, AScope as TCustomDataGeneratorAdapter, Designer);
end;

function TDataGeneratorAdapterFactory.CreateNewBindScopeManager(AOwner: TComponent): INewBindScopeManager;
begin
  Assert(False);
  Result := nil;
end;

function TDataGeneratorAdapterFactory.GetEnabled: Boolean;
begin
  Result := True;
end;

function TDataGeneratorAdapterFactory.BindScopeClass: TComponentClass;
begin
  Result := TDataGeneratorAdapter;
end;

{ TPrototypeBindSourceFactory }

function TPrototypeBindSourceFactory.CreateBindScopeEditor(
  AOwner: TComponent; AScope: TComponent): IBindScopeEditor;
begin
  Assert(AScope is TCustomPrototypeBindSource);
  Result := TPrototypeBindSourceEditor.Create(AOwner, AScope as TCustomPrototypeBindSource, Designer);
end;

function TPrototypeBindSourceFactory.CreateNewBindScopeManager(AOwner: TComponent): INewBindScopeManager;
begin
  Result := TNewPrototypeBindSourceManager.Create(AOwner, Designer);
end;

function TPrototypeBindSourceFactory.GetEnabled: Boolean;
begin
  Result := True;
end;

function TPrototypeBindSourceFactory.BindScopeClass: TComponentClass;
begin
  Result := TPrototypeBindSource;
end;

{ TDataGeneratorAdapterEditor }

resourcestring
  sEnterAFieldName = 'Enter a field name';
  sDuplicateFieldName = 'Field name is not unique';

const
  sFieldName = 'Field%d';

procedure TDataGeneratorAdapterEditor.ValidateNewField(Sender: TObject; var AValid: Boolean);
var
  LDialog: TNewObjectBindScopeField;
  LFieldName: string;
  LFieldNames: TArray<string>;
begin
  LDialog := Sender as TNewObjectBindScopeField;
  if LDialog.AllowMultiSelect then
    LFieldNames := LDialog.FieldNames
  else
    LFieldNames := TArray<string>.Create(LDialog.FieldName);
  for LFieldName in LFieldNames do
  begin
    if LFieldName = '' then
    begin
      AValid := False;
      MessageDlg(sEnterAFieldName, mtError, [mbOK], 0);
    end;
    if FieldExists(LFieldName) then
    begin
      AValid := False;
      MessageDlg(sDuplicateFieldName, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TDataGeneratorAdapterEditor.ExistingFieldName(Sender: TObject;
  const AFieldName: string; var AExists: Boolean);
begin
  AExists := FieldExists(AFieldName);
end;

function TDataGeneratorAdapterEditor.FieldExists(const AFieldName: string): Boolean;
begin
  Result := False;
  if FDataSource <> nil then
  begin
    if (FindNewField(AFieldName) <> -1) or (FDataSource.FindField(AFieldName) <> nil) then
    begin
      Result := True;
    end;
  end;
end;

function TDataGeneratorAdapterEditor.AddField: TArray<string>;
var
  LDialog: TNewObjectBindScopeField;
  LBindFieldDef: TGeneratorFieldDef;
  I: Integer;
  LFieldNames: TArray<string>;
  LResult: TList<string>;
begin
  LResult := TList<string>.Create;
  try
    Assert(FDataSource <> nil);
    if FDataSource <> nil then
    begin
      LDialog := TNewObjectBindScopeField.Create(FOwner);
      try
        I := 1;
        while FieldExists(Format(sFieldName, [I])) do
          Inc(I);
        LDialog.FieldName := Format(sFieldName, [I]);
        LDialog.OnValidate := ValidateNewField;
        LDialog.OnExistingFieldName := ExistingFieldName;
        LDialog.Initialize;
        LDialog.AllowMultiSelect := True;
        if LDialog.ShowModal = mrOK then
        begin
          LFieldNames := LDialog.FieldNames;
          for I := 0 to Length(LFieldNames) - 1 do
          begin
            LBindFieldDef := TGeneratorFieldDef.Create(nil, LFieldNames[I], 0);
            LBindFieldDef.Name := LFieldNames[I];
            LBindFieldDef.FieldType := LDialog.FieldTypes[I];
            LBindFieldDef.Options := LDialog.Options;
            LBindFieldDef.Generator := LDialog.Generators[I];
            FNewFields.Add(LBindFieldDef);
            LResult.Add(LBindFieldDef.Name);
          end;
        end;
      finally
        LDialog.Free;
      end;
    end;
    Result := LResult.ToArray;
  finally
    LResult.Free;
  end;
end;

function TDataGeneratorAdapterEditor.CanAddFields: Boolean;
begin
  Result := FDataSource <> nil;
end;

function TDataGeneratorAdapterEditor.CanRemoveField(
  const AFieldName: string): Boolean;
begin
  Result := (FDataSource <> nil) and
    (FindNewField(AFieldName) <> -1)
end;

constructor TDataGeneratorAdapterEditor.Create(AOwner: TComponent; ADataSource: TCustomDataGeneratorAdapter; const ADesigner: IDesigner);
begin
  FOwner := AOwner;
  FDataSource := ADatasource;
  FDesigner := ADesigner;
  FNewFields := TObjectList<TGeneratorFieldDef>.Create;
end;

function TDataGeneratorAdapterEditor.Changed: Boolean;
begin
  Result := FNewFields.Count > 0;
end;

function TDataGeneratorAdapterEditor.ApplyChanges: TArray<TPersistentPair>;
var
  LFieldDef: TGeneratorFieldDef;
  LBindFieldDef: TGeneratorFieldDef;
  LAdapter: TCustomDataGeneratorAdapter;
  LResult: TList<TPersistentPair>;
  LActive: Boolean;
begin
  LResult := TList<TPersistentPair>.Create;
  try
    if FDataSource <> nil then
    begin
      for LFieldDef in  FNewFields do
      begin
        LAdapter := TCustomDataGeneratorAdapter(FDataSource);
        LActive := LAdapter.Active;
        LAdapter.Active := False;
        LBindFieldDef := LAdapter.FieldDefs.AddFieldDef;
        LBindFieldDef.Assign(LFieldDef);
        LResult.Add(TPersistentPair.Create(LBindFieldDef.Name, LBindFieldDef));
        try
          LAdapter.Active := LActive;
        except
          // Conversion exceptions may occur when activate
          Application.HandleException(Self);
        end;
      end;
      FNewFields.Clear;
      FDesigner.Modified;
    end
    else
      Assert(False);
    Result := LResult.ToArray;
  finally
    LResult.Free;
  end;
end;

destructor TDataGeneratorAdapterEditor.Destroy;
begin
  inherited;
  FNewFields.Free;
end;

function TDataGeneratorAdapterEditor.RemoveField(const AFieldName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  I := FindNewField(AFieldName);
  if I <> -1 then
  begin
    FNewFields.Delete(I);
    Exit(True);
  end
  else
    Assert(False);  // Not found
end;

function TDataGeneratorAdapterEditor.FindNewField(const AFieldName: string): Integer;
var
  I: Integer;
begin
  for I := 0 to FNewFields.Count - 1 do
  begin
    if FNewFields[I].Name = AFieldName then
    begin
      Exit(I);
    end;
  end;
  Result := -1;
end;

procedure TDataGeneratorAdapterEditor.GetMembers(AList: TStrings);
var
  LBindFieldDef: TGeneratorFieldDef;
  LItem: TCollectionItem;
begin
  AList.Clear;
  for LItem in FDataSource.FieldDefs do
    AList.Add(TGeneratorFieldDef(LItem).Name);

  for LBindFieldDef in FNewFields do
    AList.Add(LBindFieldDef.Name);


end;

{ TPrototypeBindSourceEditor }

constructor TPrototypeBindSourceEditor.Create(AOwner: TComponent;
  ADataSource: TCustomPrototypeBindSource; const ADesigner: IDesigner);
begin
  FDataSource := ADataSource;
  inherited Create(AOwner, FDataSource.DataGenerator as TCustomDataGeneratorAdapter, ADesigner);
end;



{ TNewPrototypeBindSourceManager }

procedure TBaseNewGeneratorScopeManager.ValidateNewField(Sender: TObject; var AValid: Boolean);
var
  LDialog: TNewObjectBindScopeField;
  LFieldNames: TArray<string>;
  LFieldName: string;
begin
  LDialog := Sender as TNewObjectBindScopeField;
  if LDialog.AllowMultiSelect then
    LFieldNames := LDialog.FieldNames
  else
    LFieldNames := TArray<string>.Create(LDialog.FieldName);
  for LFieldName in LFieldNames do
  begin
    if LFieldName = '' then
    begin
      AValid := False;
      MessageDlg(sEnterAFieldName, mtError, [mbOK], 0);
    end;
    if FieldExists(LFieldName) then
    begin
      AValid := False;
      MessageDlg(sDuplicateFieldName, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TBaseNewGeneratorScopeManager.ExistingFieldName(Sender: TObject;
  const AFieldName: string; var AExists: Boolean);
begin
  AExists := FieldExists(AFieldName);
end;

function TBaseNewGeneratorScopeManager.FieldExists(const AFieldName: string): Boolean;
begin
  Result := False;
  if GetAdapter is TCustomDataGeneratorAdapter then
  begin
    if (GetAdapter.FindField(AFieldName) <> nil) then
    begin
      Result := True;
    end;
  end;
end;

function TBaseNewGeneratorScopeManager.AddField: string;
var
  LDialog: TNewObjectBindScopeField;
  LBindFieldDef: TGeneratorFieldDef;
  LAdapter: TCustomDataGeneratorAdapter;
  I: Integer;
  LFieldNames: TArray<string>;
begin
  Result := '';
  LDialog := TNewObjectBindScopeField.Create(FOwner);
  try
    I := 1;
    Assert(Format(sFieldName,[1]) <> Format(sFieldName, [2]));
    while FieldExists(Format(sFieldName, [I])) do
      Inc(I);
    LDialog.FieldName := Format(sFieldName, [I]);
    LDialog.OnValidate := ValidateNewField;
    LDialog.OnExistingFieldName := ExistingFieldName;
    LDialog.AllowMultiSelect := True;
    LDialog.Initialize;
    if LDialog.ShowModal = mrOK then
    begin
      InternalDataSource;
      if GetAdapter is TCustomDataGeneratorAdapter then
      begin
        LAdapter := TCustomDataGeneratorAdapter(GetAdapter);

        LFieldNames := LDialog.FieldNames;
        for I := 0 to Length(LFieldNames) - 1 do
        begin
          LBindFieldDef := LAdapter.FieldDefs.AddFieldDef;
          LBindFieldDef.Name := LFieldNames[I];
          LBindFieldDef.FieldType := LDialog.FieldTypes[I];
          LBindFieldDef.Options := LDialog.Options;
          LBindFieldDef.Generator := LDialog.Generators[I];
          Result := LBindFieldDef.Name;
        end;


      end
      else
        Assert(False);
    end;
  finally
    LDialog.Free;
  end;
end;

function TBaseNewGeneratorScopeManager.CanAddFields: Boolean;
begin
  InternalDataSource;
  Result := GetAdapter is TCustomDataGeneratorAdapter;
end;

function TBaseNewGeneratorScopeManager.CanRemoveField(
  const AFieldName: string): Boolean;
begin
  InternalDataSource;
  Result := GetAdapter is TCustomDataGeneratorAdapter;
end;

constructor TBaseNewGeneratorScopeManager.Create(AOwner: TComponent; const ADesigner: IDesigner);
begin
  FOwner := AOwner;
  FDesigner := ADesigner;
end;


destructor TBaseNewGeneratorScopeManager.Destroy;
begin
  inherited;
end;

function TBaseNewGeneratorScopeManager.RemoveField(const AFieldName: string): Boolean;
var
  LBindFieldDef: TGeneratorFieldDef;
  LAdapter: TCustomDataGeneratorAdapter;
begin
  Result := False;
  InternalDataSource;
  if GetAdapter is TCustomDataGeneratorAdapter then
  begin
    LAdapter := TCustomDataGeneratorAdapter(GetAdapter);
    LBindFieldDef := LAdapter.FieldDefs.Find(AFieldName);
    if LBindFieldDef <> nil then
    begin
      LAdapter.FieldDefs.Delete(LBindFieldDef.Index);
      Exit(True);
    end;
  end
  else
    Assert(False);
end;


{ TNewPrototypeBindSourceManager }


function TNewPrototypeBindSourceManager.GetAdapter: TCustomDataGeneratorAdapter;
begin
  Assert(FDataSource <> nil);
  Result := TCustomPrototypeBindSource(FDataSource).DataGenerator;
end;

function TNewPrototypeBindSourceManager.CreateScope: TBaseLinkingBindSource;
var
  LInternalScope: TCustomPrototypeBindSource;
  LNewScope: TCustomPrototypeBindSource;
begin
  LNewScope := FDesigner.CreateComponent(TPrototypeBindSource, FDesigner.Root, 0, 0, 0, 0) as TCustomPrototypeBindSource;
  try
    LInternalScope := FDataSource;
    if LInternalScope <> nil then
    begin
      TCustomDataGeneratorAdapter(LNewScope.DataGenerator).FieldDefs.Assign(
            TCustomDataGeneratorAdapter(LInternalScope.DataGenerator).FieldDefs);
    end;
    Result := LNewScope;
  except
    LNewScope.Free;
    raise;
  end;
end;

destructor TNewPrototypeBindSourceManager.Destroy;
begin
  inherited;
  FDataSource.Free;
end;

function TNewPrototypeBindSourceManager.InternalDataSource: TComponent;
var
  LScope: TPrototypeBindSource;
begin
  if FDataSource = nil then
  begin
    LScope := TPrototypeBindSource.Create(nil);
    FDataSource := LScope;
  end;
  Result := FDataSource;
end;

{ TGetDesignerComponents }

procedure TGetDesignerComponents.ComponentNameProc(const RootName: string);
var
  LComponent: TComponent;
begin
  LComponent := FDesigner.GetComponent(RootName);
  Assert(Assigned(FComponentProc));
  if Assigned(FComponentProc) then
    FComponentProc(LComponent, RootName);
end;

// Get components available to a designer, even from linked data modules
constructor TGetDesignerComponents.Create(const ADesigner: IDesigner);
begin
  FDesigner := ADesigner;
end;

procedure TGetDesignerComponents.GetDesignerComponents(AProc: TProc<TComponent, string>);
var
  PropInfo: PPropInfo;
begin
  Assert(FCounter = 0); // Make sure we don't reenter
  Inc(FCounter);
  try
    PropInfo := System.TypInfo.GetPropInfo(TypeInfo(TComponentPropertyClass), 'Component');
    Assert(PropInfo <> nil);
    Assert(not Assigned(FComponentProc));
    FComponentProc := AProc;
    try
      FDesigner.GetComponentNames(PropInfo.PropType^.TypeData, ComponentNameProc);
    finally
      FComponentProc := nil;
    end;
  finally
    Dec(FCounter);
  end;
end;

function GetRootOwner(AComponent: TComponent): TComponent;
begin
  Result := AComponent.Owner;
  while (Result <> nil) and (csInline in Result.ComponentState) do
    Result := Result.Owner;
end;

function TGetDesignerComponents.IsExternalComponent(
  AComponent: TComponent): Boolean;
var
  LResult: Boolean;
begin
  if GetRootOwner(AComponent) = FDesigner.Root then
    // Short circuit
    Exit(False);
  LResult := False;
  GetDesignerComponents(
    procedure(ADesignerComponent: TComponent; AName: string)
    begin
      if ADesignerComponent = AComponent then
        if Pos('.', AName) > 1 then
        begin
          LResult := True;
        end;
    end);
  Result := LResult;
end;

procedure Register;
const
  sSourceMemberName = 'SourceMemberName';
begin
  RegisterNoIcon([TBindExpression, TBindExprItems, TBindLink, TBindList, TBindGridLink, TBindListLink, TBindGridList, TBindPosition]);
  RegisterNoIcon([TBindControlValue]);
  RegisterNoIcon([TLinkListControlToField, TLinkControlToField, TLinkControlToProperty,
    TLinkPropertyToField, TLinkFillControlToField, TLinkFillControlToProperty]);
  RegisterClasses([TBindExpression, TBindExprItems, TBindLink, TBindList, TBindGridLink, TBindListLink, TBindGridList, TBindPosition, TBindControlValue]);
  RegisterClasses([TBindControlValue]);
  RegisterClasses([TLinkListControlToField, TLinkControlToField, TLinkControlToProperty,
    TLinkPropertyToField, TLinkFillControlToField, TLinkFillControlToProperty]);
  RegisterBindComponents(SDataBindingsCategory_BindingExpressions, [TBindExpression, TBindExprItems]);
  RegisterBindComponents(SDataBindingsCategory_Links, [TBindLink, TBindListLink, TBindGridLink, TBindPosition, TBindControlValue]);
  RegisterBindComponents(SDataBindingsCategory_Lists, [TBindList, TBindGridList]);
  RegisterBindComponents(SQuickBindingsCategory, [TLinkListControlToField, TLinkControlToField, TLinkControlToProperty,
    TLinkPropertyToField, TLinkFillControlToField, TLinkFillControlToProperty]);


  RegisterComponents(SBindingComponentsMiscCategory, [TBindingsList, TBindScope]);
  RegisterComponents(SBindingComponentsMiscCategory, [TDataGeneratorAdapter]);
  RegisterComponents(SBindingComponentsCategory, [TPrototypeBindSource]);
  RegisterComponents(SBindingComponentsMiscCategory, [TAdapterBindSource]);

  RegisterComponentEditor(TCustomBindingsList, TBindCompListEditor);
  RegisterSelectionEditor(TComponent, TLBVisualizationPropertyFilter);
  // Verbs to add data bindings
  RegisterSelectionEditor(TBaseLinkingBindSource, TBindCompFactorySelectionEditor);
  RegisterSelectionEditor(TBindSourceAdapter, TBindCompFactorySelectionEditor);
  RegisterSelectionEditor(TDataSource, TBindCompFactorySelectionEditor);
  RegisterSelectionEditor(TDataSet, TBindCompFactorySelectionEditor);
//  RegisterSelectionEditor(TBaseLinkingBindSource, TAddNavigatorSelectionEditor);
  RegisterSelectionEditor(TDataSet, TAddBindScopeSelectionEditor);
  RegisterSelectionEditor(TBindSourceAdapter, TAddBindScopeSelectionEditor);

  RegisterComponentEditor(TContainedBindComponent, TBindCompExpressionEditor);
//  RegisterComponentEditor(TBaseLinkingBindSource, TBaseLinkingBindScopeEditor);
  RegisterComponentEditor(TCustomBindList, TBindFillListExpressionEditor);
  RegisterComponentEditor(TCustomBindGridLink, TBindFillGridLinkExpressionEditor);
  RegisterComponentEditor(TCustomBindGridLIst, TBindFillGridListExpressionEditor);
  RegisterComponentEditor(TCustomLinkFillControlToField, TBindFillGridListExpressionEditor);
  RegisterComponentEditor(TCustomLinkFillControlToProperty, TBindFillGridListExpressionEditor);
  RegisterComponentEditor(TCustomBindExpression, TBindEvaluateExpressionEditor);
  RegisterComponentEditor(TCustomBindExprItems, TBindEvaluateExprItemsEditor);
  RegisterPropertyEditor(TypeInfo(TMethods), nil, '', TMethodsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TOutputConverters), nil, '', TOutputConvertersPropertyEditor);

  RegisterPropertyEditor(TypeInfo(string), TCommonBindComponent, sSourceMemberName, TSourceMemberNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TColumnLinkExpressionItem, sSourceMemberName, TSourceMemberNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TColumnFormatExpressionItem, sSourceMemberName, TSourceMemberNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkControlToProperty, 'ComponentProperty', TLinkControlToPropertyNamesEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkPropertyToField, 'ComponentProperty', TLinkPropertyToFieldPropertyNamesEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkPropertyToField, 'FieldName', TFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkListControlToField, 'FieldName', TFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkControlToField, 'FieldName', TFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToField, 'FillValueFieldName', TFillFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToField, 'FillDisplayFieldName', TFillFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToField, 'FillHeaderCustomFormat', TFillCustomFormatPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToField, 'FillBreakFieldName', TFillFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToField, 'FillHeaderFieldName', TFillFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToProperty, 'FillValueFieldName', TFillFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToProperty, 'FillDisplayFieldName', TFillFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToProperty, 'FillHeaderCustomFormat', TFillCustomFormatPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToProperty, 'FillBreakFieldName', TFillFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToProperty, 'FillHeaderFieldName', TFillFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TLinkListControlToField, 'FillHeaderCustomFormat', TFillCustomFormatPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TLinkListControlToField, 'FillBreakFieldName', TFillFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TLinkListControlToField, 'FillHeaderFieldName', TFillFieldNamePropertyEditor);

  RegisterPropertyEditor(TypeInfo(string), TCustomLinkPropertyToField, 'LookupKeyFieldName', TLookupKeyFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkPropertyToField, 'LookupValueFieldName', TLookupFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkControlToField, 'LookupKeyFieldName', TLookupKeyFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkControlToField, 'LookupValueFieldName', TLookupFieldNamePropertyEditor);

  RegisterPropertyEditor(TypeInfo(string), TGeneratorFieldDef , 'Generator', TGeneratorNamePropertyEditor);

  RegisterPropertyEditor(TypeInfo(TGeneratorFieldDefs), nil, '', TGeneratorFieldDefsPropertyEditor);

  RegisterComponentEditor(TDataGeneratorAdapter, TScopeAdapterFieldsEditor);
  RegisterComponentEditor(TPrototypeBindSource, TScopeAdapterFieldsEditor);
  RegisterComponentEditor(TBaseLinkingBindSource, TBaseLinkingBindScopeEditor); // Default component editor

  RegisterPropertyEditor(TypeInfo(TBaseLinkingBindSource), TLinkControlToFieldDelegate, 'DataSource', TLinkingBindScopePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TBaseLinkingBindSource), TLinkPropertyToFieldDelegate, 'DataSource', TLinkingBindScopePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TBaseLinkingBindSource), TBaseLinkToDataSource, 'DataSource', TLinkingBindScopePropertyEditor);

  RegisterSprigType(TCustomBindingsList, TCustomBindCompListSprig);
  RegisterSprigType(TContainedBindComponent, TCustomDataBindingSprig);
  RegisterSprigType(TContainedBindComponent, TCustomAssociatedDataBindingSprig);

  RegisterPropertyEditor(TypeInfo(string), TFormatExpressionItem , sSourceMemberName, TFillItemFieldNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TFormatExpressionItem , 'ControlMemberName', TControlMembersPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToField, 'ListItemStyle', TEditorNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkFillControlToProperty, 'ListItemStyle', TEditorNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomLinkListControlToField, 'ListItemStyle', TEditorNamePropertyEditor);

  RegisterPropertyEditor(TypeInfo(TComponent), TCustomLinkControlToField, 'Control', TLinkingControlPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TComponent), TCustomLinkControlToProperty, 'Control', TLinkingControlPropertyEditor);
  // List controls only
  RegisterPropertyEditor(TypeInfo(TComponent), TCustomLinkListControlToField, 'Control', TLinkingFillControlPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TComponent), TCustomLinkFillControlToField, 'Control', TLinkingFillControlPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TComponent), TCustomLinkFillControlToProperty, 'Control', TLinkingFillControlPropertyEditor);
                                   
                                                

  RegisterBindCompFactory(TNewBindCompWizardFactory.Create);

  // Do not show "New LiveBindings component" in object inspector or menu
//  RegisterBindCompFactory(TNewBindCompDialogFactory.Create);

  RegisterBindCompFactory(TBindVisuallyViewFactory.Create);

  // Add 'Live Bindings' property to components
  // RegisterSelectionEditor(TComponent, TAddDataBindingsPropertyFilter);

  // Add RTTI unit to uses list
  RegisterSelectionEditor(TCommonBindComponent, TRttiUnitSelectionEditor);
  RegisterSelectionEditor(TBindComponentDelegate, TRttiUnitSelectionEditor);

  // Add BindingsList used methods/converters required units to the uses list
  RegisterSelectionEditor(TCustomBindingsList, TCustomBindCompListSelectionEditor);
  RegisterSelectionEditor(TCustomBindingsList, TBindCompFactorySelectionEditor);

  // Add "DataBindings" property to object inspector
  RegisterBoundComponents([TComponent], [dbcoptAddDataBindingsProperty, dbcoptApplyToDescendents]);

  // RegisterControlFrameFactory(TObjectBindScopeFactory);
  RegisterControlFrameFactory(TPrototypeBindSourceFactory);
  RegisterControlFrameFactory(TDataGeneratorAdapterFactory);
  RegisterSelectionEditor(TCustomDataGeneratorAdapter, TDataGeneratorSelectionEditor);
//  RegisterSelectionEditor(TCustomObjectBindScope, TObjectBindScopeDataGeneratorSelectionEditor);
  RegisterSelectionEditor(TCustomPrototypeBindSource, TPrototypeBindSourceDataGeneratorSelectionEditor);

end;


function GetDataBindingComponents(AControlComponent: TComponent): TArray<TContainedBindComponent>;
var
  LOwner: TComponent;
  LDataBindingComponent: TContainedBindComponent;
  LDesigner: IBindCompDesigner;
  LResult: TArray<TContainedBindComponent>;
begin
  SetLength(LResult, 0);
  LOwner := AControlComponent.Owner;
  if LOwner <> nil then
    GetOwnedComponents(LOwner,
      procedure(LOwnedComponent: TComponent)
      begin
        // Exclude components that are being deleted
        if LOwnedComponent is TContainedBindComponent then
        begin
          LDataBindingComponent := TContainedBindComponent(LOwnedComponent);
          if TProxyComponent.FPendingFreeList.Contains(LDataBindingComponent) then
          begin
            // Skip
          end
          else
          begin
            LDesigner := GetBindCompDesigner(TContainedBindCompClass(LDataBindingComponent.ClassType));
            if LDesigner <> nil then
            begin
              if LDesigner.BindsComponent(LDataBindingComponent, AControlComponent) then
              begin
                SetLength(LResult, Length(LResult) + 1);
                LResult[Length(LResult)-1] := TContainedBindComponent(LOwnedComponent);
              end;

            end;
          end;
        end;
      end);
  Result := LResult;
end;

type
  // Wrapper around a DataBinding component to make it appear in the object inspector under
  // the DataBindingsProperty
  TDataBindingComponentProperty = class(TComponentProperty, IPropertyKind, IProperty, IProperty80)
  private
    FComponentReference: TContainedBindComponent;
    FProxyComponent: TProxyComponent;
    FActionListView: TBindCompListView;
    FHost: IPropertyHost;
    FDataBindingsPropertyNamePath: string;
    FFilterFuncDesigner: IBindCompDesigner;
  protected
    function GetComponentReference: TComponent; override;
    function GetAttributes: TPropertyAttributes; override;
  private
    procedure SetComponent(ACustomDataBinding: TContainedBindComponent);
    { IPropertyKind }
    function GetName: string; override;
    procedure DeleteDataBinding(Sender: TObject);
    procedure SelectDataBindingComponent(Sender: TObject);
    procedure SelectDataBindingsProperty(ADesigner: IDesigner);
    function FilterFunc(const ATestEditor: IProperty): Boolean;
  protected
    // IProperty80
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce; overload;
  public
    destructor Destroy; override;
    procedure GetProperties(Proc: TGetPropProc); override;
  end;


function TDataBindingComponentProperty.GetName: string;
var
  LComponent: TComponent;
begin
  LComponent := GetComponentReference;
  if LComponent <> nil then
    Result := LComponent.Name
  else
    Result := inherited;  // Name of TProxyComponent property
end;

function TDataBindingComponentProperty.GetComponentReference;
begin
    Result := FComponentReference;
end;

procedure TDataBindingComponentProperty.SelectDataBindingsProperty(ADesigner: IDesigner);
begin
  (BorlandIDEServices as IOTAPropInspServices).Expand;
  ADesigner.SelectItemName(FDataBindingsPropertyNamePath);
end;

function TDataBindingComponentProperty.FilterFunc(const ATestEditor: IProperty): Boolean;
begin
  Result := not (paNotNestable in ATestEditor.GetAttributes);
  if Result then
  begin
                                         
    if FFilterFuncDesigner <> nil then
    begin
      // Hide property use to specify the bound component
      if FFilterFuncDesigner.BindsComponentPropertyName(FComponentReference, ATestEditor.GetName) then
        Result := False;
    end;
  end;

end;

procedure TDataBindingComponentProperty.DeleteDataBinding(Sender: TObject);
begin
  FHost.CloseDropDown;
  if (idYes <> MessageDlg(
      Format(sConfirmDelete, [FProxyComponent.FComponent.Name]),
         mtConfirmation, mbYesNoCancel, 0)) then
    Exit;

  TProxyComponent.FPendingFreeList.Add(FProxyComponent.FComponent);
  SelectDataBindingsProperty(FActionListView.Designer);
  // Deep modify, which will handle volatile properties
  (BorlandIDEServices as IOTAPropInspServices).VolatileModified;
end;

procedure TDataBindingComponentProperty.SelectDataBindingComponent(Sender: TObject);
var
  LSelection: IDesignerSelections;
begin
  FHost.CloseDropDown;
  LSelection := TDesignerSelections.Create as IDesignerSelections;
  LSelection.Add(FProxyComponent.FComponent);
  Designer.SetSelections(LSelection);
end;

destructor TDataBindingComponentProperty.Destroy;
begin
  if FActionListView <> nil then
    FreeAndNil(FActionListView);
  FProxyComponent.Free;
  inherited;
end;

function TDataBindingComponentProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited + [paCustomDropDown] - [paValueList, paSortList];
end;

procedure TDataBindingComponentProperty.GetProperties(Proc: TGetPropProc);
var
  LComponents: IDesignerSelections;
  LDesigner: IDesigner;

begin
  LComponents := GetSelections;
  if LComponents <> nil then
  begin
    if not Supports(FindRootDesigner(LComponents[0]), IDesigner, LDesigner) then
      LDesigner := Designer;
    FFilterFuncDesigner := GetBindCompDesigner(TContainedBindCompClass(Self.FComponentReference.ClassType));
    try
      GetComponentProperties(LComponents, tkAny, LDesigner, Proc, FilterFunc);
    finally
      FFilterFuncDesigner := nil;
    end;
  end;
end;

procedure TDataBindingComponentProperty.SetComponent(ACustomDataBinding: TContainedBindComponent);
var
  PropInfo: PPropInfo;
begin
  FProxyComponent := TProxyComponent.Create(nil, Self.Designer);
  FProxyComponent.FComponent := ACustomDataBinding;
  FComponentReference := ACustomDataBinding;
  PropInfo := System.TypInfo.GetPropInfo(FProxyComponent, 'ComponentProperty');
  Self.SetPropEntry(0, FProxyComponent, PropInfo);
  Self.Initialize;
end;

function GetDesignerModel(ADesigner: IDesigner): IVGModel;
var
  LGraph: IVGHandler;
  LModules: TArray<IVGModule>;
  LModule: IVGModule;
begin
  Result := nil;
  if VisualizationService = nil then
    Exit;
  LGraph := VisualizationService.ActiveGraph;
  if LGraph = nil then
    Exit;
  LModules := LGraph.GetModules;
  for LModule in LModules do
    if LModule.Designer = ADesigner then
      Exit(LModule.GetModel);
end;

{ TLBVisualizationPropertyFilter }
procedure TLBVisualizationPropertyFilter.FilterProperties(
  const ASelection: IDesignerSelections;
  const ASelectionProperties: IInterfaceList);
var
  I, J: Integer;
  LComponents: TList<TComponent>;
  LNewProperty: TVGSyntheticPropertyGroup;
  LProperty: IProperty;
  LIndex: Integer;
  LModel: IVGModel;
begin
  LModel := GetDesignerModel(Designer);
  if LModel = nil then
    Exit;

  LComponents := TList<TComponent>.Create;
  try
    for I := 0 to ASelection.Count - 1 do
    begin
      if (ASelection.Items[I] is TComponent) and not (
        ASelection.Items[I] is TContainedBindComponent) then
        LComponents.Add(ASelection.Items[I] as TComponent);
    end;
    if LComponents.Count > 0 then
    begin
      LNewProperty := TVGSyntheticPropertyGroup.Create(Designer, 1);
      LNewProperty.SelectedComponents := LComponents.ToArray;

      LIndex := -1;
      for J := 0 to ASelectionProperties.Count - 1 do
      begin
        if Supports(ASelectionProperties[J], IProperty, LProperty) then
        begin
          if CompareText(LNewProperty.GetName, LProperty.GetName) <= 0  then
          begin
            LIndex := J;
            break;
          end;
        end;
      end;

      if LIndex <> -1 then
        ASelectionProperties.Insert(LIndex, LNewProperty as IProperty)
      else
        ASelectionProperties.Add(LNewProperty);
    end;
  finally
    LComponents.Free;
  end;
end;

{ TAddDataBindingsPropertyFilter }
procedure TAddDataBindingsPropertyFilter.FilterProperties(
  const ASelection: IDesignerSelections;
  const ASelectionProperties: IInterfaceList);
var
  I, J: Integer;
  LSelectedItem: TPersistent;
  LNewProperty: TDataBindingSyntheticProperty;
  LProperty: IProperty;
  LIndex: Integer;
  LComponent: TComponent;
  LOptions: TBoundComponentOptions;
begin
  if ASelection.Count > 1 then
    // Don't show property if multiple selection
    Exit;

  for I := 0 to ASelection.Count - 1 do
  begin
    LSelectedItem := ASelection[I];
    if (LSelectedItem is TComponent) then
    begin
      LComponent := TComponent(LSelectedItem);
      LOptions := GetBoundComponentOptions(TComponentClass(LComponent.ClassType));
      if not (TBoundComponentOption.dbcoptAddDataBindingsProperty in LOptions) then
        continue;

      LNewProperty := TDataBindingSyntheticProperty.Create(Designer, 1);
      LNewProperty.Component := LComponent;
      LIndex := 0;
      for J := 0 to ASelectionProperties.Count - 1 do
      begin
        if Supports(ASelectionProperties[J], IProperty, LProperty) then
        begin
          if CompareText(LNewProperty.GetName, LProperty.GetName) <= 0  then
          begin
            LIndex := J;
            break;
          end;
        end;
      end;

      ASelectionProperties.Insert(LIndex, LNewProperty as IProperty);
    end;
  end;
end;

procedure TDataBindingComponentProperty.Edit(const Host: IPropertyHost; DblClick: Boolean);
var
  LHost20: IPropertyHost20;
  LCustomActions: TList<TCustomAction>;
begin
  FHost := Host;
  if FActionListView <> nil then
  begin
    FActionListView.Free;
  end;
  LCustomActions := TObjectList<TCustomAction>.Create;
  try

    FActionListView := TBindCompListView.Create(nil);
    FActionListView.Options := [dblvDelete, dblvSelect];
    FActionListView.DataBindingComponentName := FProxyComponent.FComponent.Name;
    if Supports(FHost, IPropertyHost20, LHost20) then
      FActionListView.Width := LHost20.GetDropDownWidth;
    FActionListView.OnDeleteDataBinding := DeleteDataBinding;
    FActionListView.OnSelectDataBindingComponent := SelectDataBindingComponent;
    FActionListView.AddVerbActions(FProxyComponent.FComponent, LCustomActions, Designer);
    FActionListView.CustomActions := LCustomActions.ToArray;
    FActionListView.Designer := Designer;
    FActionListView.Visible := True;
    FHost.DropDownControl(FActionListView);
  finally
    LCustomActions.Free;
  end;
end;

{ TDataBindingSyntheticProperty }

function TDataBindingSyntheticProperty.GetAttributes: TPropertyAttributes;
begin
  // Not nestible so that it won't appear inside expanded component references
  Result := [paSubProperties, paVolatileSubProperties, paCustomDropDown, paReadOnly, paNotNestable];
end;

function TDataBindingSyntheticProperty.GetName: string;
begin
  Result := sName
end;

procedure TDataBindingSyntheticProperty.GetProperties(Proc: TGetPropProc);
var
  LComponents: TArray<TContainedBindComponent>;
  LComponent: TContainedBindComponent;
  LComponentProperty: TDataBindingComponentProperty;
begin
  LComponents := GetDataBindingComponents(FComponent);
  for LComponent in LComponents do
  begin
    LComponentProperty := TDataBindingComponentProperty.Create(Designer, 1);
    LComponentProperty.SetComponent(LComponent);
    //LComponentProperty.FDataBindingsProperty := Self;
    LComponentProperty.FDataBindingsPropertyNamePath := GetName;
    Proc(LComponentProperty as IProperty);
  end;
end;

function TDataBindingSyntheticProperty.GetValue: string;
begin
  Result := GetName; // ReverseString(Component.Name);
end;

procedure TDataBindingSyntheticProperty.SetValue(const Value: string);
begin
  Component.Name := ReverseString(Value);
  Designer.Modified;
end;

function TDataBindingSyntheticProperty.ShowReferenceProperty: Boolean;
begin
  Result := True;
end;

destructor TDataBindingSyntheticProperty.Destroy;
begin
  FBindCompListView.Free;
  FHost := nil;
  inherited;
end;


procedure TDataBindingSyntheticProperty.Edit(const Host: IPropertyHost; DblClick: Boolean);
var
  LHost20: IPropertyHost20;
  LCustomActions: TList<TCustomAction>;
begin
  FHost := Host;
  if FBindCompListView <> nil then
    FBindCompListView.Free;
  LCustomActions := TObjectList<TCustomAction>.Create;
  try
    FBindCompListView := TBindCompListView.Create(nil);
    FBindCompListView.Options := [dblvCreateNewFactory, dblvSelectExisting];
    FBindCompListView.ControlComponent := ControlComponent;
    if Supports(FHost, IPropertyHost20, LHost20) then
      FBindCompListView.Width := LHost20.GetDropDownWidth;
    //FBindCompListView.OnNewDataBinding := CreateNewDataBinding;
    FBindCompListView.OnNewDataBindingFactory := CreateNewDataBindingFactory;
    FBindCompListView.OnCreateDataBindingFactoryContext := CreateDataBindingFactoryContext;
    FBindCompListView.OnSelectDataBindingProperty := SelectDataBindingProperty;
    FBindCompListView.Designer := Designer;
    FBindCompListView.AddFactoryActions(LCustomActions);
    //FBindCompListView.AddVerbActions(ControlComponent, LCustomActions);
    FBindCompListView.CustomActions := LCustomActions.ToArray;
    FBindCompListView.Visible := True;
    FHost.DropDownControl(FBindCompListView);
  finally
    LCustomActions.Free;
  end;
end;

procedure TDataBindingSyntheticProperty.SelectDataBindingProperty(Sender: TObject; DataBinding: TContainedBindComponent);
begin
//  if DataBinding <> nil then
//    SetValue(DataBinding.Owner.Name + DotSep + DataBinding.Name)
//  else
//    SetValue('');
  // Select under Databindings
  FHost.CloseDropDown;
  (BorlandIDEServices as IOTAPropInspServices).Expand;

  Designer.SelectItemName(GetName + '.' + DataBinding.Name);
end;

function TDataBindingSyntheticProperty.CreateDataBindingFactoryExecuteContext(ABindCompList: TCustomBindingsList): IBindCompFactoryExecuteContext;
var
  LComponent: TComponent;
begin
  Result := nil;
  LComponent := ControlComponent;
  if LComponent <> nil then
  begin
    Result := TDataBindingFactoryExecuteContext.Create(Designer, ABindCompList,
      LComponent); //FComponent);
  end;
end;

procedure TDataBindingSyntheticProperty.CreateDataBindingFactoryContext(Sender: TObject; ABindCompList: TCustomBindingsList;
  var AContext: IBindCompFactoryContext);
var
  LComponent: TComponent;
begin
  AContext := nil;
  LComponent := ControlComponent;
  if LComponent <> nil then
  begin
    AContext := TDataBindingFactoryContext.Create(Designer, ABindCompList,
      LComponent); //FComponent);
  end;
end;

procedure TDataBindingSyntheticProperty.CreateNewDataBindingFactory(Sender: TObject;
  DataBindingFactory: IBindCompFactory; BindingsList: TCustomBindingsList);
var
  LContext: IBindCompFactoryExecuteContext;
  LBindCompList: TBindingsList;
begin
  LBindCompList := nil;
  LContext := CreateDataBindingFactoryExecuteContext(BindingsList);
  Assert(LContext <> nil);
  if LContext.BindingsList = nil then
  begin
    LBindCompList := BindCompReg.CreateBindingsList(LContext.Owner);
//    TBindingsList.Create(LContext.Owner);
//    if Assigned(LContext.Owner) then
//    begin
//      //Place BindingsList in top left corner of parent (Low Word = Left, High Word = Top)
//      LBindCompList.DesignInfo := (5 shl 16) + 20;
//      LContext.Owner.InsertComponent(LBindCompList);
//    end;
    LBindCompList.Name := LContext.UniqueName(LBindCompList.ClassType.ClassName
     );
    (LContext as TDataBindingFactoryExecuteContext).FBindCompList := LBindCompList;
  end;
  if FHost <> nil then
    FHost.CloseDropDown;
  if LContext <> nil then
    DataBindingFactory.Execute(LContext);
  if LBindCompList <> nil then
  begin
    if LBindCompList.BindCompCount = 0 then
      // Free compononent we've create because no binding components created
      LBindCompList.Free;
  end;

end;


{ TProxyComponent }

class constructor TProxyComponent.Create;
begin
  FPendingFreeList := TList<TComponent>.Create;
end;

constructor TProxyComponent.Create(AOwner: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AOwner);
  FDesigner := ADesigner;
end;

destructor TProxyComponent.Destroy;
begin
  if FPendingFreeList.Contains(FComponent) then
  begin
    FPendingFreeList.Remove(FComponent);
    FComponent.Free;
    if FDesigner <> nil then
      FDesigner.Modified;
  end;
  inherited;
end;

class destructor TProxyComponent.Destroy;
begin
  FPendingFreeList.Free;
end;


{ TDataBindingFactory }


constructor TDataBindingFactory.Create(ACategory: string; AClass: TContainedBindCompClass);
begin
  FCategory := ACategory;
  FClass := AClass;
end;

function TDataBindingFactory.Enabled(
  AContext: IBindCompFactoryContext): Boolean;
begin
  Result := True;
end;

procedure TDataBindingFactory.Execute(
  AContext: IBindCompFactoryExecuteContext);
var
  LNewDataBinding: TContainedBindComponent;
begin
  LNewDataBinding := CreateBindComponent(AContext.Owner, FClass);
  LNewDataBinding.Name := AContext.UniqueName(LNewDataBinding.ClassType.ClassName);
  LNewDataBinding.Category := FCategory;
  LNewDataBinding.BindingsList := AContext.BindingsList;
  LNewDataBinding.ControlComponent := AContext.ControlComponent;
  AContext.BindCompCreated(LNewDataBinding);
end;

function TDataBindingFactory.GetCommandText(
  AContext: IBindCompFactoryContext): string;
begin
  Result := FClass.ClassName;
end;

{ TDataBindingFactoryContext }

constructor TDataBindingFactoryContext.Create(ADesigner: IDesigner; ABindCompList: TCustomBindingsList;
  AControlComponent: TComponent);
begin
  FDesigner := ADesigner;
  FBindCompList := ABindCompList;
  FControlComponent := AControlComponent;
end;

function TDataBindingFactoryContext.GetControlComponent: TComponent;
begin
  Result := FControlComponent;
end;

function TDataBindingFactoryContext.GetDesigner: IInterface;
begin
  Result := FDesigner;
end;

function TDataBindingFactoryContext.GetBindingsList: TCustomBindingsList;
begin
  Result := FBindCompList;
end;

function TDataBindingFactoryContext.GetOwner: TComponent;
begin
  if FBindCompList = nil then
    Result := FDesigner.Root
  else
    Result := FBindCompList.Owner;
end;


{ TDataBindingFactoryExecuteContext }


procedure TDataBindingFactoryExecuteContext.BindCompCreated(AComponent: TComponent);
begin
  FDesigner.Modified;
  (BorlandIDEServices as IOTAPropInspServices).VolatileModified;
  (BorlandIDEServices as IOTAPropInspServices).Expand;

  // Select under Databindings
  FDesigner.SelectItemName(TDataBindingSyntheticProperty.sName +  '.' + AComponent.Name);

end;


function TDataBindingFactoryExecuteContext.UniqueName(const
  ABaseName: string): string;
var
  LRoot: IRoot;
begin
  if (FBindCompList = nil) or (FBindCompList.Owner = FDesigner.Root) then
    Result := FDesigner.UniqueName(ABaseName)
  else
  begin
    LRoot := ActiveDesigner.FindRoot(FBindCompList.Owner);
    if LRoot <> nil then
      Result := LRoot.GetDesigner.UniqueName(ABaseName)
    else
      raise Exception.CreateResFmt(@SUnableToFindComponent, [FBindCompList.Owner.Name]);
  end;
end;

{ TBindingComponentPropertyEditor }

function TBindingComponentPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TBindingComponentPropertyEditor.SetValue(const Value: string);
begin
  try
    inherited;
  except
    // Call modified even if error in expression evaluation
    Modified;
    raise;
  end;
end;

function TBindingComponentPropertyEditor.GetBindComponent: TContainedBindComponent;
var
  Component: TPersistent;
begin
  Result := nil;
  Component := GetComponent(0);
  if Component is TContainedBindComponent then
    Result := TContainedBindComponent(Component)
  else if Component is TCollectionItem then
  begin
    while Component is TCollectionItem do
    begin
      Component := TCollectionItem(Component).Collection.Owner;
    end;
    if Component is TContainedBindComponent then
      Result := TContainedBindComponent(Component);
  end;
end;


procedure TBindingComponentPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

function TBindingComponentPropertyEditor.GetComponentProperty(const AName: string): TComponent;
var
  PropInfo: PPropInfo;
  LBindComponent: TContainedBindComponent;
begin
  Result := nil;
  LBindComponent := GetBindComponent;
  if LBindComponent = nil then
    Exit;

  PropInfo := System.TypInfo.GetPropInfo(LBindComponent.ClassInfo, AName);  // Do not localize
  Assert(PropInfo <> nil);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
    Result := TObject(GetOrdProp(LBindComponent, PropInfo)) as TComponent;
end;

function TBindingComponentPropertyEditor.GetStringProperty(const AName: string): string;
var
  PropInfo: PPropInfo;
  LBindComponent: TContainedBindComponent;
begin
  Result := '';
  LBindComponent := GetBindComponent;
  if LBindComponent = nil then
    Exit;

  PropInfo := System.TypInfo.GetPropInfo(LBindComponent.ClassInfo, AName);  // Do not localize
  Assert(PropInfo <> nil);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkUString) then
    Result := GetStrProp(LBindComponent, PropInfo);
end;

{ TSourceMemberNamePropertyEditor }

function TSourceMemberNamePropertyEditor.GetSourceComponent: TComponent;
begin
  Result := GetComponentProperty(GetSourceComponentName);
end;

function TSourceMemberNamePropertyEditor.GetSourceComponentName: string;
begin
  Result := 'SourceComponent';
end;

procedure TSourceMemberNamePropertyEditor.GetMemberNames(ASourceComponent: TComponent; List: TStrings);
var
  LScopeMemberNames: IScopeMemberNames;
begin
  if Supports(ASourceComponent, IScopeMemberNames, LScopeMemberNames) then
    LScopeMemberNames.GetMemberNames(List);
end;

procedure TSourceMemberNamePropertyEditor.GetValueList(List: TStrings);
var
  LSourceComponent: TComponent;
begin
  LSourceComponent := GetSourceComponent;
  GetMemberNames(LSourceComponent, List);
end;

{ TEditorNamePropertyEditor }

resourcestring
  sDefault = '(default)';
procedure TEditorNamePropertyEditor.SetValue(const Value: string);
begin
  if SameText(Value, sDefault) then
    inherited SetValue('')
  else
    inherited SetValue(Value);
end;

function TEditorNamePropertyEditor.GetControlComponent: TComponent;
begin
  Result := GetComponentProperty(GetControlComponentName);
end;

function TEditorNamePropertyEditor.GetControlComponentName: string;
begin
  Result := 'Control';
end;

procedure TEditorNamePropertyEditor.GetEditorNames(AControlComponent: TComponent; List: TStrings);
var
  S: string;
begin
  for S in  Data.Bind.Components.GetBindEditorNames(AControlComponent, IBindListEditorCommon) do
    List.Add(S);
end;

function TEditorNamePropertyEditor.GetValue: string;
begin
  Result := inherited GetValue;
  if Result = '' then
    Result := sDefault;
end;

procedure TEditorNamePropertyEditor.GetValueList(List: TStrings);
var
  LControlComponent: TComponent;
begin
  LControlComponent := GetControlComponent;
  GetEditorNames(LControlComponent, List);
  Assert(List.IndexOf('') = -1);
  List.Insert(0, sDefault);
end;

{ TControlMembersPropertyEditor }

function TControlMembersPropertyEditor.GetControlComponent: TComponent;
begin
  Result := GetComponentProperty(GetControlComponentName);
end;

function TControlMembersPropertyEditor.GetEditorName: string;
begin
  Result := GetStringProperty(GetEditorPropertyName);
end;

function TControlMembersPropertyEditor.GetControlComponentName: string;
begin
  Result := 'Control';
end;

function TControlMembersPropertyEditor.GetEditor(AControlComponent: TComponent; const AEditor: string): IInterface;
begin
  Result := GetBindEditor(AControlComponent, IBindListEditorCommon, AEditor);
end;

function TControlMembersPropertyEditor.GetEditorPropertyName: string;
begin
  Result := 'ListItemStyle';
end;

procedure TControlMembersPropertyEditor.GetItemMemberNames(AControlComponent: TComponent; const AEditor: string; AList: TStrings);
var
  LBindFillControlMembers: IBindFillControlMembers;
begin
                                    
  AList.Clear;
  if Supports(GetEditor(AControlComponent, AEditor), IBindFillControlMembers, LBindFillControlMembers) then
    LBindFillControlMembers.GetItemMemberNames(AList)
end;

procedure TControlMembersPropertyEditor.GetValueList(List: TStrings);
var
  LControlComponent: TComponent;
  LEditor: string;
begin
  LControlComponent := GetControlComponent;
  LEditor := GetEditorName;
  GetItemMemberNames(LControlComponent, LEditor, List);
end;

{ TRttiUnitSelectionEditor }

procedure TRttiUnitSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('System.Rtti');
  Proc('System.Bindings.Outputs');
end;

{ TMethodsProperty }

type
  TPersistentCracker = class(TPersistent);

procedure TBindArtifactsPropertyEditor.Edit;
var
  LObj: TPersistent;
  LArtifacts: TBindArtifacts;
begin
  LObj := GetComponent(0);

  while (LObj <> nil) and not (LObj is TComponent) do
    LObj := TPersistentCracker(LObj).GetOwner;
  LArtifacts := TBindArtifacts(GetOrdValue);
  Assert(LArtifacts is TBindArtifacts);
  ShowForm(TComponent(LObj), LArtifacts);
end;


function TBindArtifactsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly, paVCL];
end;

{ TMethodsPropertyEditor }

procedure TMethodsPropertyEditor.ShowForm(AComponent: TComponent; AArtifacts: TBindArtifacts);
var
  LForm: TBindMethodsForm;
begin
  LForm := TBindMethodsForm.Create(Application);
  with LForm do
  try
    LForm.DesignerIntf := Self.Designer;
    LForm.BindArtifacts := AArtifacts;
    if ShowModal = mrOk then
    begin
      LForm.ApplyChanges;
      Self.Designer.Modified;
    end;
  except
    Free;
  end;
end;

{ TOutputConvertersProperty }

procedure TOutputConvertersPropertyEditor.ShowForm(AComponent: TComponent; AArtifacts: TBindArtifacts);
var
  LForm: TBindOutputConvertersForm;
begin
  LForm := TBindOutputConvertersForm.Create(Application);
  with LForm do
  try
    LForm.DesignerIntf := Self.Designer;
    LForm.BindArtifacts := AArtifacts;
    if ShowModal = mrOK then
    begin
      ApplyChanges;
      Self.Designer.Modified;
    end;
  except
    Free;
  end;
end;


{ TCustomBindCompListSelectionEditor }

// This method must be fast or it will slow down code insite.
procedure TCustomBindCompListSelectionEditor.RequiresUnits(Proc: TGetStrProc);
var
  LActiveClassGroup: TPersistentClass;

  function IsActiveFramework(AFrameworkClass: TPersistentClass): Boolean;
  var
    LClassGroup: TPersistentClass;
  begin
    if AFrameworkClass = nil then
      Exit(True);
    LClassGroup := System.Classes.ClassGroupOf(AFrameworkClass);
    Result := LActiveClassGroup.InheritsFrom(LClassGroup);
  end;

  // Detect units with DB dependencies
  function IsDBUnit(const AUnitName: string): Boolean;
  const
    cDB = 'Data.Bind.DB';
  begin
    Result := SameText(cDB, Copy(AUnitName, 1, Length(cDB)));
  end;

  function CanUseUnit(const AUnitName: string): Boolean;
  begin
    Result := (AUnitName <> '') and (not IsDBUnit(AUnitName));

  end;

var
  BindingsList: TCustomBindingsList;
  UseUnits, ExcludedList: TStringList;
  CurUnitName: string;
  MethodDesc: TMethodDescription;
  ConverterDesc: TConverterDescription;
  I, CompNum: Integer;
  LFrameworkClass: TPersistentClass;
begin
  LActiveClassGroup := Designer.ActiveClassGroup;


  UseUnits := TStringList.Create;
  UseUnits.CaseSensitive := True; // Improve IndexOf performance
  ExcludedList := TStringList.Create;
  ExcludedList.CaseSensitive := True;
  try
    for CompNum := 0 to Designer.Root.ComponentCount - 1 do  // Ignore components in frames
    begin
      if Designer.Root.Components[CompNum] is TCustomBindingsList then
      begin
        BindingsList := TCustomBindingsList(Designer.Root.Components[CompNum]);

        //check for method units
        ExcludedList.Clear;
        for I := 0 to BindingsList.Methods.Count - 1 do
        begin
          if BindingsList.Methods.Items[I].State = eaInclude then
          begin
            CurUnitName := TBindingMethodsFactory.GetMethodUnitName(BindingsList.Methods.Items[I].ID);
            if (CurUnitName <> '') and (UseUnits.IndexOf(CurUnitName) = -1)  then
            begin
              LFrameworkClass := TBindingMethodsFactory.GetMethodFrameworkClass(BindingsList.Methods.Items[I].ID);
              if CanUseUnit(CurUnitName) and IsActiveFramework(LFrameworkClass) then
                UseUnits.Add(CurUnitName);
            end;
          end
          else
            ExcludedList.Add(BindingsList.Methods.Items[I].ID);
        end;
        //now add methods enabled by default unless explicitly excluded
        for MethodDesc in TBindingMethodsFactory.GetRegisteredMethods do
          if (MethodDesc.UnitName <> '') and (UseUnits.IndexOf(MethodDesc.UnitName) = -1) then
            if MethodDesc.DefaultEnabled and (ExcludedList.IndexOf(MethodDesc.ID) = -1) then
              if CanUseUnit(MethodDesc.UnitName) and IsActiveFramework(MethodDesc.FrameworkClass) then
                UseUnits.Add(MethodDesc.UnitName);

        //check for output converter units
        ExcludedList.Clear;
        for I := 0 to BindingsList.OutputConverters.Count - 1 do
        begin
          if BindingsList.OutputConverters.Items[I].State = eaInclude then
          begin
            CurUnitName := TValueRefConverterFactory.GetConverterUnitName(BindingsList.OutputConverters.Items[I].ID);
            if (CurUnitName <> '') and  (UseUnits.IndexOf(CurUnitName) = -1) then
            begin
              LFrameworkClass := TValueRefConverterFactory.GetConverterFrameworkClass(BindingsList.OutputConverters.Items[I].ID);
              if CanUseUnit(CurUnitName) and IsActiveFramework(LFrameworkClass) then
                UseUnits.Add(CurUnitName);
            end;
          end
          else
            ExcludedList.Add(BindingsList.OutputConverters.Items[I].ID);
        end;
        //now add converters enabled by default unless explicitly excluded
        for ConverterDesc in TValueRefConverterFactory.GetConverterDescriptions do
          if (ConverterDesc.UnitName <> '') and (UseUnits.IndexOf(ConverterDesc.UnitName) = -1) then
            if ConverterDesc.DefaultEnabled and (ExcludedList.IndexOf(ConverterDesc.ID) = -1) then
              if CanUseUnit(ConverterDesc.UnitName) and IsActiveFramework(ConverterDesc.FrameworkClass) then
                UseUnits.Add(ConverterDesc.UnitName);
      end;
    end;

    for I := 0 to UseUnits.Count - 1 do
      Proc(UseUnits[I]);
  finally
    ExcludedList.Free;
    UseUnits.Free;
  end;
end;

function TBaseDataGeneratorSelectionEditor.GetDataGenerator(AComponent: TComponent): TCustomDataGeneratorAdapter;
begin
  Result := nil;
  if AComponent is TCustomDataGeneratorAdapter then
    Result := TCustomDataGeneratorAdapter(AComponent)
end;

procedure TBaseDataGeneratorSelectionEditor.RequiresUnits(Proc: TGetStrProc);

  function DesignerSupportsExtension(const AExt: string): Boolean;
  const
    sDfm = 'DFM';
    sFmx = 'FMX';
    sVCL = 'VCL';
  var
    LClassGroup: TPersistentClass;
    LUnitScope: string;
  begin
    Assert(AExt <> '');
    LClassGroup := Designer.ActiveClassGroup;
    if LClassGroup <> nil then
    begin
      // Designer.DesignerExtension is .dfm for TDataModule so look at activeclassgroup
      LUnitScope := LClassGroup.UnitScope;
      if SameText(AExt, sDfm) then
        Result := LClassGroup.UnitScope.StartsWith(sVcl, True)
      else if SameText(AExt, sFmx) then
        Result := LClassGroup.UnitScope.StartsWith(sFmx, True)
      else
        Result := False;
    end
    else
      Result := SameText(AExt, Designer.DesignerExtention);
  end;
var
  I: Integer;
  LDataGenerator: TCustomDataGeneratorAdapter;
  LComponent: TComponent;
  LFieldDef: TGeneratorFieldDef;
  LDescriptions: TArray<TPair<string, TValueGeneratorDescription>>;
  LPair: TPair<string, TValueGeneratorDescription>;
begin
  for I := 0 to Designer.Root.ComponentCount - 1 do   // Ignore components in frames
  begin
    LComponent := Designer.Root.Components[I];
    LDataGenerator := GetDataGenerator(LComponent);

    if LDataGenerator <> nil then
    begin
      for LFieldDef in LDataGenerator.FieldDefs do
      begin
        if LFieldDef.Generator <> '' then
        begin
          LDescriptions := FindRegisteredValueGenerators(LFieldDef.Generator, LFieldDef.FieldType);
          for LPair in LDescriptions do
          begin
            if LPair.Value.UnitName <> '' then
              if (LPair.Key = '') or //(SameText(LPair.Key, Designer.DesignerExtention) and
                DesignerSupportsExtension(LPair.Key) then
              begin
                Proc(LPair.Value.UnitName);
                break;
              end;
          end;
        end;
      end;
    end;
  end;
end;

{ TFieldNamePropertyEditor }

function TFieldNamePropertyEditor.GetSourceComponentName: string;
const
  sFillDataSource = 'FillDataSource';
  sDataSource = 'DataSource';
begin
  if System.TypInfo.GetPropInfo(GetBindComponent.ClassInfo, 'FillDataSource') <> nil then
    Result := sFillDataSource
  else
    Result := sDataSource;
end;

{ TFillItemFieldNamePropertyEditor }

function TFillItemFieldNamePropertyEditor.GetSourceComponentName: string;
const
  sFillDataSource = 'FillDataSource';
  sDataSource = 'DataSource';
begin
  if System.TypInfo.GetPropInfo(GetBindComponent.ClassInfo, 'FillDataSource') <> nil then
    Result := sFillDataSource
  else
    Result := sDataSource;
end;

{ TNewBindCompWizardFactory }

function TNewBindCompWizardFactory.Enabled(
  AContext: IBindCompFactoryContext): Boolean;
begin
  //Result := True;
  Result := ShowLiveBindingsWizard;
end;

procedure TNewBindCompWizardFactory.Execute(
  AContext: IBindCompFactoryExecuteContext);
var
  LDataBinding: TContainedBindComponent;
begin
  with TExecuteNewDataBindingWizard.Create(AContext) do
  begin
    Execute(
      // BeforeCreate
      procedure
      begin
        //SelectNone(False)
      end,
      // Created
      procedure(ACategory: string; ADataBinding: TContainedBindComponent; ANewControl: TComponent)
      begin
        if ADatabinding <> nil then
        begin
          LDataBinding := ADataBinding;
          if LDataBinding.Name = '' then
            LDataBinding.Name := AContext.UniqueName(LDataBinding.ClassType.ClassName +
              AContext.ControlComponent.Name);
          LDataBinding.Category := ACategory;
          LDataBinding.BindingsList := AContext.BindingsList;
          //LDataBinding.ControlComponent := AContext.ControlComponent;
          AContext.BindCompCreated(LDataBinding);
                                     
        end;
      end,
      // After create
      procedure
      begin
        //FocusDataBinding(LDataBinding)
      end,
      // Allow class
      function(AClass: TContainedBindCompClass): Boolean
      begin
        Result := True;
//       LDesigner := GetBindCompDesigner(AClass);
//       if LDesigner <> nil then
//          // Allow class
//          Result := LDesigner.CanBindComponent(AClass,
//            AContext.ControlComponent, AContext.Designer)
//       else
//         Result := False;
      end);
  end;
end;

function TNewBindCompWizardFactory.GetCategory: string;
begin
  Result := '';
end;

function TNewBindCompWizardFactory.GetCommandText(
  AContext: IBindCompFactoryContext): string;
begin
  Result := SNewBindingWizard;
end;

{ TFactoryAction }


constructor TFactoryAction.Create(const ACaption: string;
  ABindingsList: TCustomBindingsList; AFactory: IBindCompFactory);
begin
  inherited Create(nil);
  Caption := ACaption;
  FBindingsList := ABindingsList;
  FFactory := AFactory;
end;

function TFactoryAction.Execute: Boolean;
begin
  Assert(False);
  Result := True;

end;

{ TVerbAction }

constructor TVerbAction.Create(const ACaption: string; AComponent: TComponent;
  AVerb: integer; ADesigner: IDesigner);
begin
  inherited Create(nil);
  Caption := ACaption;
  FDesigner := ADesigner;
  FComponent := AComponent;
  FVerb := AVerb;
end;

function TVerbAction.Execute: Boolean;
var
  LEditor: IComponentEditor;
begin
  LEditor := GetComponentEditor(FComponent, FDesigner);
  if LEditor <> nil then
  begin
    if FVerb < LEditor.GetVerbCount then
    begin
      LEditor.ExecuteVerb(FVerb);
    end;

  end;

  Result := True;
end;

{ TBindCompFactorySelectionEditorExecuteContext }

procedure TBindCompFactorySelectionEditorExecuteContext.BindCompCreated(
  AComponent: TComponent);
begin
  FDesigner.Modified;
  (BorlandIDEServices as IOTAPropInspServices).VolatileModified;
//  (BorlandIDEServices as IOTAPropInspServices).Expand;

  // Select under Databindings
  FDesigner.SelectComponent(AComponent);
end;

procedure GetComponentPropertyNames(AComponent: TComponent; AList: TList<string>);
var
  LPropertyNames: TDataBindingComponentPropertyNames;
begin
  LPropertyNames := TDataBindingComponentPropertyNames.Create(AComponent);
  try
    AList.AddRange(LPropertyNames.PropertyNames);
  finally
    LPropertyNames.Free;
  end;
end;

function DefaultTrackControl(AControl: TComponent): Boolean;
var
  LOptions: TObservableMemberOptions;
begin
  Result := GetControlValuePropertyOptions(AControl, LOptions) and
    (TObservableMemberOption.moTrack in LOptions);
end;

function ShowLiveBindingsWizard: Boolean;
begin
  Result := LiveBindingsGenOptFrame.IsOptionEnabled(TLBRegNames.EnableWizardVerb);
end;

{ TPropertyNameProperty }

function TComponentPropertyNamesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList, paRevertable];
end;

function TComponentPropertyNamesProperty.GetValueList: TArray<string>;
var
  LComponent: TComponent;
begin
  LComponent := GetPropertyComponent;
  if LComponent <> nil then
    Result := Self.GetComponentPropertyNames(LComponent)
  else
    Result := TArray<string>.Create();
end;

procedure TComponentPropertyNamesProperty.GetValues(Proc: TGetStrProc);
var
  S: string;
  Values: TArray<string>;
begin
  Values := GetValueList;
  for s in Values do Proc(S);
end;

function TComponentPropertyNamesProperty.GetPropertyComponent: TComponent;
begin
  Assert(False);
  Result := nil;
end;

class function TComponentPropertyNamesProperty.GetComponentPropertyNames(AComponent: TComponent): TArray<string>;
var
  LList: TList<string>;
begin
  LList := TList<string>.Create;
  try
    BindCompReg.GetComponentPropertyNames(AComponent, LList);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

class function TComponentPropertyNamesProperty.HasComponentPropertyName(AComponent: TComponent; const AName: string): Boolean;
var
  LList: TList<string>;
begin
  LList := TList<string>.Create;
  try
    BindCompReg.GetComponentPropertyNames(AComponent, LList);
    Result := LList.IndexOf(AName) >= 0;
  finally
    LList.Free;
  end;
end;

{ TLinkControlToPropertyNamesEditor }

function TLinkControlToPropertyNamesEditor.GetPropertyComponent: TComponent;
var
  LSelected: TCustomLinkControlToProperty;
begin
  LSelected := GetComponent(0) as TCustomLinkControlToProperty;
  if Assigned(LSelected) then
    Result := LSelected.Component
  else
    Result := nil;
end;

{ TLinkPropertyToFieldPropertyNamesEditor }

function TLinkPropertyToFieldPropertyNamesEditor.GetPropertyComponent: TComponent;
var
  LSelected: TCustomLinkPropertyToField;
begin
  LSelected := GetComponent(0) as TCustomLinkPropertyToField;
  if Assigned(LSelected) then
    Result := LSelected.Component
  else
    Result := nil;
end;


{ TVisualizationSyntheticProperty }

constructor TVGSyntheticPropertyGroup.Create(const ADesigner: IDesigner;
  APropCount: Integer);
begin
  inherited Create(ADesigner, APropCount);
  if ADesigner = nil then
    FRoot := nil
  else
    FRoot := ADesigner.Root;
end;

procedure TVGSyntheticPropertyGroup.Edit(const Host: IPropertyHost;
  DblClick: Boolean);
begin
end;

function TVGSyntheticPropertyGroup.GetAttributes: TPropertyAttributes;
begin
  // Not nestible so that it won't appear inside expanded component references
  Result := [paSubProperties, paVolatileSubProperties, paReadOnly, paNotNestable];
end;

function TVGSyntheticPropertyGroup.GetComponents: TArray<TComponent>;
begin
  Result := FComponents;
end;

function TVGSyntheticPropertyGroup.GetName: string;
begin
  Result := sVisualizationGroup;
end;

procedure TVGSyntheticPropertyGroup.GetProperties(Proc: TGetPropProc);
var
  LProperty: TVGSyntheticProperty;
  LComponent: TComponent;
  LModel: IVGModel;
  LNodesOnly: Boolean;
  LId: Integer;
  LElementIDS: TArray<Integer>;
  LShowVisibleProperty, LShowLayersProperty: Boolean;
  LFilterFunc: TLBComponentFilterFunc;
begin
  LModel := GetDesignerModel(Designer);
  if LModel <> nil then
  begin
    // Node Visibility property (only valid for nodes, so only show if selected components contain nothing but nodes)
    LNodesOnly := True;
    LShowVisibleProperty := True;
    LShowLayersProperty := True;
    for LComponent in FComponents do
    begin
      if LComponent = FRoot then
      begin
        LShowVisibleProperty := False;
        LShowLayersProperty := False;
      end
      else
        for LFilterFunc in TLBVisualizationPropertyManager.GetComponentFiltersFuncArray do
        begin
          if (not LShowVisibleProperty) and (not LShowLayersProperty) then
            break;
          if LShowVisibleProperty then
            LShowVisibleProperty := LFilterFunc(LComponent, TVGVisibleSyntheticProperty.ClassName);
          if LShowLayersProperty then
            LShowLayersProperty := LFilterFunc(LComponent, TVGLayersNodeSyntheticProperty.ClassName);
        end;
      LElementIDS := LModel.FindElementIDs(LComponent);
      if Length(LElementIDS) > 0 then
      begin
        LNodesOnly := False;
        for LId in LElementIDS do
          if LModel.FindElement(LId).IsNode then
          begin
            // This component has a node
            LNodesOnly := True;
            break;
          end;
      end;
      if not LNodesOnly then
        break;
    end;

    if LNodesOnly then
    begin
      if LShowVisibleProperty then
      begin
        LProperty := TVGVisibleSyntheticProperty.Create(Designer, 1);
        LProperty.Group := Self;
        Proc(LProperty);
      end;

      if LShowLayersProperty then
      begin
        LProperty := TVGLayersNodeSyntheticProperty.Create(Designer, 1);
        LProperty.Group := Self;
        Proc(LProperty);
      end;
    end;
  end;
end;

function TVGSyntheticPropertyGroup.GetValue: string;
begin
  Result := sVisualizationGroup
end;

procedure TVGSyntheticPropertyGroup.SetComponents(const Values: TArray<TComponent>);
begin
  FComponents := Values;
end;

{ TVisualizationVisibleSyntheticProperty }

procedure TVGVisibleSyntheticProperty.Edit(const Host: IPropertyHost;
  DblClick: Boolean);
var
  LOrigValue: string;
begin
  if DblClick then
  begin
    LOrigValue := GetValue;
    if LOrigValue = '' then // mixed results - set all to enabled
      LOrigValue := BoolToStr(False, True);
    SetValue(BoolToStr(not StrToBool(LOrigValue), True));
  end;
end;

function TVGVisibleSyntheticProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect, paNotNestable, paValueEditable];
end;

function TVGVisibleSyntheticProperty.GetName: string;
begin
  Result := sNodeVisibility;
end;

function TVGVisibleSyntheticProperty.GetValue: string;
var
  LModel: IVGModel;
  LComponent: TComponent;
  LId: Integer;
  LFirst, LLast: Boolean;
  LList: TArray<Integer>;
begin
  LFirst := True;
  LLast := False;
  LModel := GetDesignerModel(Designer);
  if LModel <> nil then
  begin
    for LComponent in Group.SelectedComponents do
    begin
      LList := LModel.FindElementIDs(LComponent);
      for LId in LList do
      begin
        if LFirst then
        begin
          LLast := LModel.IsElementVisible(LId);
          LFirst := False;
        end
        else if LLast <> LModel.IsElementVisible(LId) then
          Exit('');
      end;
    end;
  end;
  Result := BoolToStr(LLast, True);
end;

procedure TVGVisibleSyntheticProperty.GetValues(Proc: TGetStrProc);
begin
  Proc('True');
  Proc('False');
  Proc('Default');  // Do not localize
end;

procedure TVGVisibleSyntheticProperty.SetValue(const Value: string);
var
  LValue: Boolean;
  LModel: IVGModel;
  LComponent: TComponent;
  LList: TArray<Integer>;
  LId: Integer;
  LDefault: Boolean;
begin
  LDefault := SameText(Value, 'Default'); // Do not localize
  if LDefault or TryStrToBool(Value, LValue) then
  begin
    LModel := GetDesignerModel(Designer);
    if LModel <> nil then
    begin
      for LComponent in Group.SelectedComponents do
      begin
        LList := LModel.FindElementIds(LComponent);
        for LId in LList do
        begin
          if LDefault then
            LModel.RestoreDefaultVisibility(LId)
          else if LValue then
            LModel.ShowElement(LId, True)
          else
            LModel.HideElement(LId, True);
        end;
      end;
    end;
  end;
end;

{ TGeneratorNamePropertyEditor }

function TGeneratorNamePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

function TGeneratorNamePropertyEditor.GetValueList: TArray<string>;
var
  LFieldType: TGeneratorFieldType;
  LComponent: TPersistent;
begin
  Result := nil;
  LComponent := GetComponent(0);
  if LComponent is TGeneratorFieldDef then
  begin
    LFieldType := TGeneratorFieldDef(LComponent).FieldType;
    Result := Data.Bind.ObjectScope.GetRegisteredValueGenerators(LFieldType);
  end;
end;

procedure TGeneratorNamePropertyEditor.GetValues(Proc: TGetStrProc);
var
  Values: TArray<string>;
  S: string;
begin
  Values := GetValueList;
  for S in Values do
    Proc(S);
end;

{ TFormatExpressionSourceMemberEditor }

function TFormatExpressionSourceMemberEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

function TFormatExpressionSourceMemberEditor.GetValueList: TArray<string>;
var
  LFieldType: TGeneratorFieldType;
  LComponent: TPersistent;
begin
  Result := nil;
  LComponent := GetComponent(0);
  if LComponent is TGeneratorFieldDef then
  begin
    LFieldType := TGeneratorFieldDef(LComponent).FieldType;
    Result := Data.Bind.ObjectScope.GetRegisteredValueGenerators(LFieldType);
  end;
end;

procedure TFormatExpressionSourceMemberEditor.GetValues(Proc: TGetStrProc);
var
  Values: TArray<string>;
  S: string;
begin
  Values := GetValueList;
  for S in Values do
    Proc(S);
end;


{ TScopeAdapterFieldsEditor }

function CreateBindScopeEditor(AOwner: TComponent; const ADesigner: IDesigner; AComponent: TComponent): IBindScopeEditor;
var
  LBindScopeFactory: TBindScopeFactory;
  LFactories: TArray<TBindScopeFactory>;
begin
  Result := nil;
  LFactories := BindCompEdit.CreateAdapterFactories(ADesigner);
  for LBindScopeFactory in LFactories do
  begin
    if AComponent.InheritsFrom(LBindScopeFactory.BindScopeClass) then
    begin
      if LBindScopeFactory.CanEdit then
        Result := LBindScopeFactory.CreateBindScopeEditor(AOwner, AComponent)
      else
        Result := nil;
      Exit;
    end;
  end;
end;

procedure TScopeAdapterFieldsEditor.ExecuteVerb(Index: Integer);
var
  LEditor: IBindScopeEditor;
  LFields: TArray<TPersistentPair>;
  LField: TPersistentPair;
  LDesignerSelections: IDesignerSelections;
begin
  case Index - inherited GetVerbCount of
    0:
    if GetCollection <> nil then
      ShowCollectionEditorClass(Designer, TBindAdapterColumnsEditor, Component,
        GetCollection,
        GetPropertyName);
    1:
    begin
      LEditor := CreateBindScopeEditor(nil, Designer, Component);
      if (LEditor <> nil) and (LEditor.CanAddFields) then
      begin
        if Length(LEditor.AddField) > 0 then
        begin
          LFields := LEditor.ApplyChanges;
          LDesignerSelections := CreateSelectionList;
          for LField in LFields do
            if LField.Value <> nil then
              LDesignerSelections.Add(LField.Value);
          if LDesignerSelections.Count > 0 then
            Designer.SetSelections(LDesignerSelections);
        end;
      end;
    end
  else
    inherited ExecuteVerb(Index);
  end;
end;

function TScopeAdapterFieldsEditor.GetCollection: TCollection;
begin
  Result := nil;
  if Component is TBaseObjectBindSource then
    if TBaseObjectBindSource(Component).InternalAdapter is TCustomDataGeneratorAdapter then
      Result := TCustomDataGeneratorAdapter(TBaseObjectBindSource(Component).InternalAdapter).FieldDefs;
  if Component is TCustomDataGeneratorAdapter then
    Result := TCustomDataGeneratorAdapter(Component).FieldDefs;
end;

function TScopeAdapterFieldsEditor.GetPropertyName: string;
begin
 Result := 'FieldDefs'; // Do not localize
end;

resourcestring
  sAdapterFieldsEditor = 'Fields Editor...';
  sAddFields = 'Add Field...';

function TScopeAdapterFieldsEditor.GetVerb(Index: Integer): string;
begin
  case Index - inherited GetVerbCount of
    0:
     Result := sAdapterFieldsEditor;
    1:
     Result := sAddFields;
  else
    Result := inherited GetVerb(Index);
  end
end;

function TScopeAdapterFieldsEditor.GetVerbCount: Integer;
var
  LEditor: IBindScopeEditor;
begin
  if GetCollection <> nil then
  begin
    Result := inherited GetVerbCount + 1;
    LEditor := CreateBindScopeEditor(nil, Designer, Component);
    if (LEditor <> nil) and (LEditor.CanAddFields) then
      Result := Result + 1;
  end
  else
    Result := inherited;
end;

procedure UpdateHotCommands(ADesigner: IDesigner; const APropertyName: string);
var
  LList: IDesignerSelections;
begin
  // Force update of hot commands
  LList := CreateSelectionList;
  ADesigner.GetSelections(LList);
  ADesigner.SetSelections(CreateSelectionList);
  ADesigner.SetSelections(LList);
  ADesigner.SelectItemName(APropertyName);
end;
{ TUseGeneratorPropertyEditor }

procedure TUseDataGeneratorPropertyEditor.SetValue(const Value: string);
begin
  try
    inherited;
  except
    Application.HandleException(Self);
  end;
  // Force update of hot commands
  UpdateHotCommands(Designer, 'UseDataGenerator');
end;

procedure TAdapterPropertyEditor.SetValue(const Value: string);
begin
  try
    inherited;
  except
    Application.HandleException(Self);
  end;
  // Force update of hot commands
  UpdateHotCommands(Designer, 'Adapter');
end;

{ TVGLayersNodeSyntheticProperty }

constructor TVGLayersNodeSyntheticProperty.Create(const ADesigner: IDesigner;
  APropCount: Integer);
begin
  inherited;
  FNodeId := -1;
end;

procedure TVGLayersNodeSyntheticProperty.Edit(const Host: IPropertyHost;
  DblClick: Boolean);
var
  LDrawing: IVGDrawing;
  LModel: IVGModel;
  LElement: IVGElement;
  I, LNodeId: Integer;
  LComponent: TComponent;
  LValue: string;
begin
  LModel := GetDesignerModel(Designer);
  if LModel = nil then
    Exit;

  with TStringsEditDlg.Create(Application) do
  try
    CodeEditorItem.Visible := False;
    CodeWndBtn.Visible := False;
    LValue := GetValue;
    if LValue <> sMixedCollection then
      Lines.DelimitedText := LValue;
    repeat
      I := Lines.IndexOf('');
      if I <> -1 then
        Lines.Delete(I);
    until I = -1;
    case ShowModal of
      mrOk,
      mrYes:
        begin
          LDrawing := VisualizationService.GetDrawingControl;
          if LDrawing <> nil then
          begin
            if FNodeId = -1 then
              for LComponent in Group.SelectedComponents do
              begin
                LNodeId := LModel.FindNodeId(LComponent);
                if LNodeId <> -1 then
                begin
                  LModel.FindElement(LNodeId).SetLayerNames(Lines.ToStringArray);
                  LModel.ElementChanged(LComponent);
                  LModel.GetModule.Designer.Modified; //?
                end;
              end
            else
            begin
              LElement := LModel.FindElement(FNodeId);
              if LElement <> nil then
              begin
                LElement.SetLayerNames(Lines.ToStringArray);
                LModel.ElementChanged(LElement.Component);
                LModel.GetModule.Designer.Modified; //?
              end;
            end;
            LDrawing.RefreshLayers;
          end;
        end;
    end;
  finally
    Free;
  end;
end;

function TVGLayersNodeSyntheticProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paReadOnly, paVCL, paDialog, paMultiSelect, paNotNestable, paValueEditable];
  if FNodeId = -1 then
    Result := Result + [paSubProperties, paVolatileSubProperties];
end;

function TVGLayersNodeSyntheticProperty.GetName: string;
var
  LModel: IVGModel;
  LElement: IVGElement;
begin
  Result := sNodeLayerNames;
  if FNodeId <> -1 then
  begin
    LModel := GetDesignerModel(Designer);
    if LModel = nil then
      Result := ''
    else
    begin
      LElement := LModel.FindElement(FNodeId);
      Assert(LElement <> nil);
      if LElement <> nil then
        Result := Format('%s', [LElement.Name])
      else
        Result := '';
    end;
  end;
end;

procedure TVGLayersNodeSyntheticProperty.GetProperties(Proc: TGetPropProc);
var
  LModel: IVGModel;
  LNodeId: Integer;
  LProperty: IProperty;
  LComponent: TComponent;
begin
  assert(FNodeId = -1);
  LModel := GetDesignerModel(Designer);
  if (LModel <> nil) then
  begin
    for LComponent in Group.SelectedComponents do
    begin
      LNodeId := LModel.FindNodeId(LComponent);
      Assert(LNodeId <> -1);
      if LNodeId = -1 then
        continue;
      LProperty := TVGLayersNodeSyntheticProperty.Create(Designer, 1);
      TVGLayersNodeSyntheticProperty(LProperty).Group := Group;
      TVGLayersNodeSyntheticProperty(LProperty).SetId(LNodeId);
      Proc(LProperty);
    end;
  end;
end;

function TVGLayersNodeSyntheticProperty.GetValue: string;
var
  LModel: IVGModel;
  LNodeId: Integer;
  LStr: string;
  LElement: IVGElement;
begin
  Result := '';
  LModel := GetDesignerModel(Designer);
  if LModel <> nil then
  begin
    if (FNodeId <> -1) or (Length(Group.SelectedComponents) = 1) then
    begin
      if FNodeId = -1 then
        LNodeId := LModel.FindNodeId(Group.SelectedComponents[0])
      else
        LNodeId := FNodeId;
      if LNodeId = -1 then
        Exit;
      LElement := LModel.FindElement(LNodeId);
      if LElement = nil then
        Exit;
      for LStr in LElement.LayerNames do
      begin
        if Result = '' then
          Result := LStr
        else
          Result := Format('%s;%s', [LStr, Result]);
      end;
    end
    else
      Result := sMixedCollection;
  end;
end;

procedure TVGLayersNodeSyntheticProperty.SetId(AId: Integer);
begin
  FNodeId := AId;
end;

{ TLookupFieldNamePropertyEditor }

function TLookupFieldNamePropertyEditor.GetSourceComponentName: string;
begin
  Result := 'LookupDataSource'; // Do not localize
end;

{ TLookupKeyFieldNamePropertyEditor }

procedure TLookupKeyFieldNamePropertyEditor.GetMemberNames(
  ASourceComponent: TComponent; List: TStrings);
var
  LScopeLookup: IScopeLookup;
begin
  if Supports(ASourceComponent, IScopeLookup, LScopeLookup) then
    LScopeLookup.GetLookupMemberNames(List);
end;

{ TBaseLinkingBindScopeEditor }

procedure TBaseLinkingBindScopeEditor.Edit;
begin
  if CanCreateNavigator(Designer) and (not DataSourceHasNavigator(Designer, Component)) then
    // Create navigator is not default command
    ExecuteVerb(1)
  else
    inherited;

end;

procedure TBaseLinkingBindScopeEditor.ExecuteVerb(Index: Integer);
begin
  case Index - inherited GetVerbCount of
    0:
      if CanCreateNavigator(Designer) and (not DataSourceHasNavigator(Designer, Component)) then
        // Redundant check in case object inspector shows a disable verb
        CreateNavigator(Designer, Component as TBaseLinkingBindSource);
  else
    inherited;
  end;
end;

function TBaseLinkingBindScopeEditor.GetVerb(Index: Integer): string;
begin
  case Index - inherited GetVerbCount of
    0: Result := SAddNavigator;
  else
    Result := inherited;
  end;
end;

function TBaseLinkingBindScopeEditor.GetVerbCount: Integer;
begin
  if (Component is TBaseLinkingBindSource) and CanCreateNavigator(Designer) and (not DataSourceHasNavigator(Designer, Component)) then
    Result := inherited + 1
  else
    Result := inherited;
end;

{ TAddBindScopeSelectionEditor }

procedure TAddBindScopeSelectionEditor.ExecuteVerb(Index: Integer; const List: IDesignerSelections);
var
  LComponent: TComponent;
begin
  case Index of
    0:
    begin
      if (List.Count > 0) and (List[0] is TComponent) and CanHaveBindScope(TComponent(List[0])) then
        LComponent := TComponent(List[0])
      else
        LComponent := nil;
      if LComponent <> nil then
         CreateBindScope(LComponent);
    end
  else
    inherited;
  end;
end;

procedure TAddBindScopeSelectionEditor.CreateBindScope(AComponent: TComponent);

  procedure SetUniqueName(const ADesigner: IDesigner; AScopeComponent: TComponent);
  var
    LSuffix: string;
    LName: string;
  begin
    LName := AComponent.Name;
    if StartsStr(AComponent.ClassName.Substring(1), LName) then
      LSuffix := LName.SubString(AComponent.ClassName.Length-1);
    if LSuffix.Length > 0 then
    begin
      AScopeComponent.Name := BindCompReg.CreateUniqueComponentName(ADesigner.Root,
        AScopeComponent.ClassName.Substring(1), LSuffix);
    end;


  end;
var
  LScopeComponent: TBaseLinkingBindSource;
  LDesigner: IDesigner;
begin
  if AComponent is TBindSourceAdapter then
  begin
    LDesigner := Designer;  // Selection editor gets destroyed when create a component
    LScopeComponent := Designer.CreateComponent(TAdapterBindSource, Designer.Root, 0, 0, 0, 0) as TBaseLinkingBindSource;
    SetUniqueName(LDesigner, LScopeComponent);
    TAdapterBindSource(LScopeComponent).Adapter := TBindSourceAdapter(AComponent);
    LDesigner.Modified;
  end
  else if TDBScope.IsDataComponent(AComponent) then
  begin
    LDesigner := Designer; // Selection editor gets destroyed when create a component
    LScopeComponent := Designer.CreateComponent(TDBScope, Designer.Root, 0, 0, 0, 0) as TBaseLinkingBindSource;
    SetUniqueName(LDesigner, LScopeComponent);
    TDBScope(LScopeComponent).DataComponent := AComponent;
    LDesigner.Modified;
  end
  else
    Assert(False);
end;

function TAddBindScopeSelectionEditor.CanHaveBindScope(AComponent: TComponent): Boolean;
var
  LResult: Boolean;
begin
  Result := False;
  if AComponent is TBindSourceAdapter then
  begin
    LResult := True;
    GetOwnedComponents(Designer.Root,
      procedure(AOwnedComponent: TComponent)
      begin
        if AOwnedComponent is TBaseObjectBindSource then
          if TBaseObjectBindSource(AOwnedComponent).InternalAdapter = AComponent then
            LResult := False;
      end);
    Result := LResult;
  end
  else if TDBScope.IsDataComponent(AComponent) then
  begin
    LResult := True;
    GetOwnedComponents(Designer.Root,
      procedure(AOwnedComponent: TComponent)
      begin
      if AOwnedComponent is TCustomBindSourceDB then
        if (TCustomBindSourceDB(AOwnedComponent).DataComponent = AComponent) then
          LResult := False;
      end);
    Result := LResult;
  end;
end;

function TAddBindScopeSelectionEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SAddBindScope;
  else
    Result := inherited;
  end;
end;

function TAddBindScopeSelectionEditor.GetVerbCount: Integer;
var
  LComponent: TComponent;
  List: IDesignerSelections;
begin
  Result := 0;
  List := CreateSelectionList;
  Designer.GetSelections(List);
  if (List.Count > 0) and (List[0] is TComponent) and CanHaveBindScope(TComponent(List[0])) then
    LComponent := TComponent(List[0])
  else
    LComponent := nil;
  if LComponent <> nil then
    Result := 1
end;

{ TLinkingBindScopePropertyEditor }

procedure TLinkingBindScopePropertyEditor.GetValues(Proc: TGetStrProc);
var
  LDataSources: TList<TComponent>;
  LComponent: TComponent;
  LAllComponents: TArray<TComponent>;
begin
  inherited;
  LDataSources := TList<TComponent>.Create;
  try
    LAllComponents := GetOwnedAndLinkedComponentsList(Designer);
    for LComponent in LAllComponents do
    begin
      if TDBScope.IsDataComponent(LComponent)
      or (LComponent is TBindSourceAdapter) then
        LDataSources.Add(LComponent);
    end;

    for LComponent in LAllComponents do
    begin
      if LComponent is  TBaseObjectBindSource then
        LDataSources.Remove(TBaseObjectBindSource(LComponent).InternalAdapter)
      else if LComponent is TCustomBindSourceDB then
        LDataSources.Remove(TCustomBindSourceDB(LComponent).DataComponent);
    end;
    for LComponent in LDataSources do
      Proc(LComponent.Name);
  finally
    LDataSources.Free;
  end;

end;

procedure TLinkingBindScopePropertyEditor.SetValue(const Value: string);
var
  Component: TComponent;
  LScopeComponent: TComponent;
begin
  if Value = '' then
    Component := nil
  else
    Component := Designer.GetComponent(Value);
  if Component = nil then
    inherited SetValue('')
  else if Component is TBaseLinkingBindSource then
    inherited SetValue(Value)
  else if TDBScope.IsDataComponent(Component) then
  begin
    LScopeComponent := Designer.CreateComponent(TDBScope, Designer.Root, 0, 0, 0, 0) as TBaseLinkingBindSource;
    TDBScope(LScopeComponent).DataComponent := Component;
    inherited SetValue(LScopeComponent.Name);
  end
  else if Component is TBindSourceAdapter then
  begin
    LScopeComponent := Designer.CreateComponent(TAdapterBindSource, Designer.Root, 0, 0, 0, 0) as TBaseLinkingBindSource;
    TAdapterBindSource(LScopeComponent).Adapter := TBindSourceAdapter(Component);
    inherited SetValue(LScopeComponent.Name);
  end
  else
    Assert(False);
end;

{ TBindVisuallyViewFactory }

function TBindVisuallyViewFactory.Enabled(
  AContext: IBindCompFactoryContext): Boolean;
begin
  Result := VisualizationService <> nil;
end;

procedure TBindVisuallyViewFactory.Execute(
  AContext: IBindCompFactoryExecuteContext);
var
  LDrawing: IVGDrawing;
  LModel: IVGModel;
  LNodeId: Integer;
begin
  if VisualizationService <> nil then
  begin
    VisualizationService.FocusDrawing;
    LDrawing := VisualizationService.GetDrawingControl;
    LModel := VisualizationService.ActiveModel;
    if LModel <> nil then
    begin
      LNodeId := LModel.FindNodeId(AContext.ControlComponent);
      if LNodeId <> -1 then
      begin
        try
          LModel.ShowElement(LNodeId, True);
          LModel.InitNewLink(LNodeId, True);
          if LDrawing <> nil then
            LDrawing.ScrollToElement(LNodeId);
        finally
          if LDrawing <> nil then
            LDrawing.RecolorModel(nil);
        end;
      end;
    end;
  end;
end;

function TBindVisuallyViewFactory.GetCommandText(
  AContext: IBindCompFactoryContext): string;
begin
  Result := SBindVisuallyCommand;
end;

{ TPrototypeBindSourceDataGeneratorSelectionEditor }

function TPrototypeBindSourceDataGeneratorSelectionEditor.GetDataGenerator(
  AComponent: TComponent): TCustomDataGeneratorAdapter;
begin
  Result := inherited;
  if Result = nil then
    if AComponent is TCustomPrototypeBindSource then
      Result := TCustomPrototypeBindSource(AComponent).DataGenerator
end;

{ TLinkingControlPropertyEditor }

procedure TLinkingControlPropertyEditor.GetValues(Proc: TGetStrProc);
begin
  FProc := Proc;
  try
    Designer.GetComponentNames(GetTypeData(GetPropType), InternalStrProc);
  finally
    FProc := nil;
  end;
end;

function TLinkingControlPropertyEditor.IsValidControl(AComponent: TComponent): Boolean;
var
  LPropertyName: string;
  LWritable: Boolean;
begin
  Result := Data.Bind.Components.GetControlValuePropertyName(AComponent, LPropertyName, LWritable) and LWritable;
end;

procedure TLinkingControlPropertyEditor.SetValue(const Value: string);
var
  LComponent: TComponent;
begin
  if Value <> '' then
  begin
    LComponent := Designer.GetComponent(Value);
    if LComponent <> nil then
      if not IsValidControl(LComponent) then
        raise EDesignPropertyError.CreateRes(@SInvalidPropertyValue);
  end;
  inherited SetValue(Value);
end;


procedure TLinkingControlPropertyEditor.InternalStrProc(const S: string);
var
  LComponent: TComponent;
begin
  LComponent := Designer.GetComponent(S);
  if LComponent <> nil then
    if IsValidControl(LComponent) then
      FProc(S);
end;

{ TLBVisualizationPropertyManager }

constructor TLBVisualizationPropertyManager.Create;
begin
  inherited Create;
  FProcs := TList<TLBComponentFilterFunc>.Create;
end;

destructor TLBVisualizationPropertyManager.Destroy;
begin
  FProcs.Free;
  inherited;
end;

class function TLBVisualizationPropertyManager.GetComponentFiltersFuncArray: TArray<TLBComponentFilterFunc>;
begin
  Result := Instance.FProcs.ToArray;
end;

class function TLBVisualizationPropertyManager.Instance: TLBVisualizationPropertyManager;
begin
  if FInstance = nil then
    FInstance := TLBVisualizationPropertyManager.Create;
  Result := FInstance;
end;

class procedure TLBVisualizationPropertyManager.AddComponentFilter(
  AFilterFunc: TLBComponentFilterFunc);
begin
  if not Instance.FProcs.Contains(AFilterFunc) then
    Instance.FProcs.Add(AFilterFunc);
end;

class procedure TLBVisualizationPropertyManager.RemoveComponentFilter(
  AFilterFunc: TLBComponentFilterFunc);
begin
  if Instance.FProcs.Contains(AFilterFunc) then
    Instance.FProcs.Remove(AFilterFunc);
end;

{ TLinkFillCustomFormatPropertyEditor }

procedure TFillCustomFormatPropertyEditor.GetValues(Proc: TGetStrProc);
begin
  Proc('LowerCase(%s)');
  Proc('SubString(%s, 0, 1)');
  Proc('UpperCase(%s)');

end;

function TFillCustomFormatPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueEditable, paValueList, paSortList];
end;

{ TLinkingFillControlPropertyEditor }

function TLinkingFillControlPropertyEditor.IsValidControl(
  AComponent: TComponent): Boolean;
begin
  Result := inherited IsValidControl(AComponent) and
    (GetBindEditor(AComponent, IBindListEditorCommon, '') <> nil)
end;

initialization
  System.Bindings.ObjEval.IsProxyClassProc := Proxies.IsProxyClass;
finalization
  System.Bindings.ObjEval.IsProxyClassProc := nil;
  TLBVisualizationPropertyManager.FInstance.Free;
  TLBVisualizationPropertyManager.FInstance := nil;

end.

