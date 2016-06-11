{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit BindCompEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, DesignWindows,
  Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdActns, DesignIntf, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnList,
  Vcl.ImgList, ToolWnds, Vcl.ActnPopup, Vcl.PlatformDefaultStyleActnCtrls,
  Data.Bind.Components, System.Actions,
  BindCompRelationships;

const
  AM_DeferUpdate = WM_USER + 100;  // avoids break-before-make listview ugliness

type
//{$DEFINE RELATIONSHIPSDLG}

  TCategoryKind = (ckCategory, ckNone, ckAll);

  TDataBindingListDesigner = class;

  TDataBindingListDesigner = class(TToolbarDesignWindow)
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    SelectAllItem: TMenuItem;
    N2: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    DeleteItem: TMenuItem;
    RemoveBindComp: TAction;
    MoveUp: TAction;
    MoveDown: TAction;
    ImageList1: TImageList;
    SelectAllAction: TAction;
    AddCommon1: TMenuItem;
    NewDataBindingsPopup: TPopupMenu;
    CategoryPanel: TPanel;
    ListBox1: TListBox;
    Panel3: TPanel;
    Label1: TLabel;
    ActionPanel: TPanel;
    ListView1: TListView;
    Panel4: TPanel;
    Label2: TLabel;
    NewDataBinding1: TMenuItem;
    NewBindCompDialog: TAction;
    NewStandardDataBinding1: TMenuItem;
    EditCopy1: TEditCopy;
    EditCut1: TEditCut;
    EditPaste1: TEditPaste;
    DescriptionsAction: TAction;
    PanelDescriptions1: TMenuItem;
    Splitter2: TSplitter;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    N3: TMenuItem;
    NewCommonDataBinding: TAction;
    ListPanel: TPanel;
    BindCompWizard: TAction;
    Wizard1: TMenuItem;
    RelationshipsAction: TAction;
    ChangeRight1: TMenuItem;
    NewRelationshipAction: TAction;
    NewRelationshipAction1: TMenuItem;
    procedure DeleteClick(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MoveUpClick(Sender: TObject);
    procedure ListView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MoveDownClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure SelectAllItemClick(Sender: TObject);
    procedure PasteItemClick(Sender: TObject);
    procedure CopyItemClick(Sender: TObject);
    procedure CutItemClick(Sender: TObject);
    procedure SelectedUpdate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure NewBindCompDialogExecute(Sender: TObject);
    procedure ListView1KeyPress(Sender: TObject; var Key: Char);
    procedure ListView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SelectAllActionUpdate(Sender: TObject);
    procedure NewDataBindingsPopupPopup(Sender: TObject);
    procedure DescriptionsActionExecute(Sender: TObject);
    procedure ListView1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ListView1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ListView1DblClick(Sender: TObject);
    procedure NewCommonDataBindingExecute(Sender: TObject);
    procedure MoveUpUpdate(Sender: TObject);
    procedure MoveDownUpdate(Sender: TObject);
    procedure ListView1Resize(Sender: TObject);
//    procedure GraphTabSheetShow(Sender: TObject);
    procedure BindCompWizardExecute(Sender: TObject);
    procedure RelationshipsActionExecute(Sender: TObject);
    procedure RelationshipsActionUpdate(Sender: TObject);
    procedure NewRelationshipActionExecute(Sender: TObject);
    procedure NewRelationshipActionUpdate(Sender: TObject);
  private
{$IFDEF RELATIONSHIPSDLG}
    FBindRelationshipsDlg: TBindRelationshipsDlg;
    FBindNewRelationshipsDlg: TBindNewRelationshipsDlg;
{$ENDIF}
    FDataBindingListClassName: string;
    FCategory: string;
    FCategoryKind: TCategoryKind;
    FCommonDataBindingClass: TContainedBindCompClass;
    FItemIDList: TList;
    FStateLock: Integer;
    FSelectionError: Boolean;
    FFixups: TList;
    FUpdateCount: Integer;
    FDragObject: TDragObject;
//    FDeclsView: TDeclsViewer;
    function GetRegKey: string;
    procedure AMDeferUpdate(var Msg); message AM_DeferUpdate;
    procedure Copy;
    procedure Cut;
    procedure Paste;
    procedure Remove;
    procedure SelectAll(DoUpdate: Boolean = True);
    procedure SelectNone(DoUpdate: Boolean = True);
    function GetDataBindingIndex(ListIndex: Integer): Integer;
    function GetDescriptionsVisible: Boolean;
    procedure SetDescriptionsVisible(Value: Boolean);
    procedure SetCommonDataBindingClass(Value: TContainedBindCompClass);
    procedure UpdateCaption;
    procedure ComponentRead(Component: TComponent);
    procedure ReaderSetName(Reader: TReader; Component: TComponent;
      var Name: string);
    procedure ReaderSetName2(Reader: TReader; Component: TComponent;
      var Name: string);
    procedure LoadFromClipboard(AOwner, AParent: TComponent; Components: TList);
    procedure ReadStream(Stream: TStream; AOwner, AParent: TComponent; Components: TList);
    procedure NotifyDataBindingListChange;
    procedure CategoryOfClassEnumProc(const Category: string;
      BindCompClass: TContainedBindCompClass;
      Info: TEnumBindCompProcInfo);
    function CategoryOfClass(AClass: TContainedBindCompClass): string;
//    procedure UpdateGraphView;
//    procedure OnDotNodeClick(Sender: TDotViewer; const NodeComment: string);
//    function DumpDescriptions(ABindings: TArray<TContainedBindComponent>): string;
{$IFDEF RELATIONSHIPSDLG}
    function SelectedBindComponent: TComponent;
    procedure OnRelationshipsDestroy(Sender: TObject);
    procedure OnNewRelationshipsDestroy(Sender: TObject);
{$ENDIF}
  protected
    function DataBindingVisible(DataBinding: TContainedBindComponent): Boolean;
    procedure BeginUpdate;
    procedure BuildNewDataBindings; virtual;
    procedure EndUpdate;
    procedure FocusDataBinding(DataBinding: TContainedBindComponent);
    function IndexOfDataBinding(DataBinding: TContainedBindComponent): Integer;
    procedure Activated; override;
    procedure DoNewDataBinding(const Category: string; DataBinding: TContainedBindComponent);
    procedure Clear;
    procedure LockState;
    function UniqueName(Component: TComponent): string; override;
    procedure UnlockState;
    property StateLock: Integer read FStateLock;
    property DescriptionsVisible: Boolean read GetDescriptionsVisible write SetDescriptionsVisible;
  public
    FDataBindingList: TCustomBindingsList;
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent); override;
    function EditAction(Action: TEditAction): Boolean; override;
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean); override;
    procedure ItemsModified(const ADesigner: IDesigner); override;
    function GetEditState: TEditState; override;
    function GetItemName(Index, ItemIndex: Integer): string;
    procedure GetSelection;
    procedure SelectionChanged(const Designer: IDesigner;
      const ASelection: IDesignerSelections); override;
    procedure SetSelection;
    procedure UpdateView(AUpdateColumns: Boolean = False);
    property CommonDataBindingClass: TContainedBindCompClass read FCommonDataBindingClass
      write SetCommonDataBindingClass;
  end;

  TExecuteNewDataBinding = class
  private
    FBindingsList: TCustomBindingsList;
    FDesigner: IDesigner;
  public
    destructor Destroy; override;
    constructor Create(ABindingsList: TCustomBindingsList;
      ADesigner: IDesigner);
    function Execute(ABeforeCreate: TProc;
      ACreated: TProc<string, TContainedBindComponent>; AAfterCreate: TProc;
      AAllowClass: TFunc<TContainedBindCompClass, Boolean>): Boolean;
  end;

  TExecuteNewDataBindingWizard = class
  private
    FBindingsList: TCustomBindingsList;
    FDesigner: IDesigner;
    FComponentContext: TComponent;
  public
    destructor Destroy; override;
    constructor Create(AContext: IBindCompFactoryExecuteContext); overload;
    constructor Create(ABindingsList: TCustomBindingsList; ADesigner: IDesigner); overload;
    function Execute(ABeforeCreate: TProc;
      ACreated: TProc<string, TContainedBindComponent, TComponent>; AAfterCreate: TProc;
      AAllowClass: TFunc<TContainedBindCompClass, Boolean>): Boolean;
  end;

  TWizardControlFrame = class;

  TControlFactory = class
  private
    FDesigner: IDesigner;
  protected
    function GetEnabled: Boolean; virtual;
    property Designer: IDesigner read FDesigner;
  public
    constructor Create(ADesigner: IDesigner);
    property Enabled: Boolean read GetEnabled;
  end;

  TControlClassFactory = class(TControlFactory)
  const
    // Property names
    sSuffix = 'Suffix';
    sLabelCaption = 'Caption';
  type
    TOption = (optLabel, optSuffix, optNoLabel);
    TOptions = set of TOption;
    TControlTypes = class
    public
      const sStandard = 'Standard';
      const sGrid = 'Grid';
    end;
  public
    function ControlClasses: TArray<TComponentClass>; virtual; abstract;
    function IsControl(AComponent: TComponent): Boolean; virtual; abstract;
    function GetControlType(AComponentClass: TComponentClass): string; virtual; abstract;
    function CreateControl(AClass: TComponentClass; AOptions: TOptions = []; AProperties: TStrings = nil): TComponent; virtual; abstract;
    function SupportsOption(AClass: TComponentClass; AOption: TControlClassFactory.TOption): Boolean; virtual; abstract;
  end;

  TNavigatorFactory = class(TControlFactory)
  private
    FBindScope: TBaseLinkingBindSource;
  public
    function IsNavigatorFor(AComponent1, AComponent2: TComponent): Boolean; virtual; abstract;
    function CreateControl(AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent; virtual; abstract;
    property BindScope: TBaseLinkingBindSource read FBindScope write FBindScope;
  end;


  TWizardFrame = class;

  INewBindScopeManager = interface
    ['{82E4CD1C-8E1B-4835-9121-5FFE16659C73}']
    function GetFrame: TWizardFrame;
    function InternalDataSource: TComponent;
    function CanAddFields: Boolean;
    function AddField: string;
    function CanRemoveField(const AFieldName: string): Boolean;
    function RemoveField(const AFieldName: string): Boolean;
    property Frame: TWizardFrame read GetFrame;
    function CreateScope: TBaseLinkingBindSource;
  end;

  IBindScopeEditor = interface
    ['{98CBB557-1219-49B8-8CC2-B8CFE3E11970}']
    function CanAddFields: Boolean;
    function AddField: TArray<string>;
    function CanRemoveField(const AFieldName: string): Boolean;
    function RemoveField(const AFieldName: string): Boolean;
    procedure GetMembers(AList: TStrings);
    function Changed: Boolean;
    function ApplyChanges: TArray<TPersistentPair>;
  end;

  TBindScopeFactory = class(TControlFactory)
  public
    function BindScopeTitle: string; virtual;
    function BindScopeClass: TComponentClass; virtual; abstract;
    function CanCreate: Boolean; virtual;
    function CanEdit: Boolean; virtual;
    function CreateNewBindScopeManager(AOwner: TComponent): INewBindScopeManager; virtual; abstract;
    function CreateBindScopeEditor(AOwner: TComponent; AScope: TComponent): IBindScopeEditor; virtual; abstract;
  end;

  TNewBindScopeManager = class(TInterfacedObject, INewBindScopeManager)
  protected
    function InternalDataSource: TComponent; virtual; abstract;
    function AddField: string; virtual;
    function CanAddFields: Boolean; virtual;
    function CanRemoveField(const AFieldName: string): Boolean; virtual;
    function RemoveField(const AFieldName: string): Boolean; virtual;
    function GetFrame: TWizardFrame; virtual;
    function CreateFrame(AOwner: TComponent): TWizardFrame; virtual;
    function CreateScope: TBaseLinkingBindSource; virtual; abstract;
  end;

  TBindScopeEditor = class(TInterfacedObject, IBindScopeEditor)
  protected
    function CanAddFields: Boolean; virtual; abstract;
    function AddField: TArray<string>; virtual; abstract;
    function CanRemoveField(const AFieldName: string): Boolean; virtual; abstract;
    function RemoveField(const AFieldName: string): Boolean; virtual; abstract;
    procedure GetMembers(AList: TStrings); virtual; abstract;
    function Changed: Boolean; virtual; abstract;
    function ApplyChanges: TArray<TPersistentPair>; virtual; abstract;
  end;

  TWizardFrame = class
  private
    FMemberName: string;
    FOnFrameChange: TNotifyEvent;
  protected
    function GetFrame: TFrame; virtual; abstract;
  public
    procedure CreateFrame(InitProc: TProc<TFrame>); virtual; abstract;
    function Validate: Boolean; virtual; abstract;
    function IsComplete: Boolean; virtual; abstract;
    function GetInfo(var AInfo: string): Boolean; virtual; abstract;
    property Frame: TFrame read GetFrame;
    property MemberName: string read FMemberName write FMemberName;
    property OnFrameChange: TNotifyEvent read FOnFrameChange write FOnFrameChange;
  end;


  TWizardControlFrame = class(TWizardFrame)
  public
    function CreateControl: TComponent; virtual; abstract;
  end;


  TControlFactoryClass = class of TControlFactory;
//  TControlFrameFactoryClass = class of TControlFrameFactory;
  TNavigatorFactoryClass = class of TNavigatorFactory;
  TBindScopeFactoryClass = class of TBindScopeFactory;
  TComponentClassFactoryClass = class of TControlClassFactory;
  TDataBindingListDesignerClass = class of TDataBindingListDesigner;

  TNotifyDataBindingListChange = procedure;
//
var
  NotifyDataBindingListChange: TNotifyDataBindingListChange = nil;

const
  CategoryKinds: array[0..2] of TCategoryKind = (ckCategory, ckNone, ckAll);

procedure ShowBindCompListDesigner(const ADesigner: IDesigner;
  ADataBindingList: TCustomBindingsList);

function ShowDataBindingListDesignerClass(const ADesigner: IDesigner;
  DesignerClass: TDataBindingListDesignerClass; ADataBindingList: TCustomBindingsList): TDataBindingListDesigner;

procedure RegisterControlFrameFactory(AClass: TControlFactoryClass);
function CreateComponentClassFactory(ADesigner: IDesigner): TControlClassFactory;
function CreateNavigatorFactory(const ADesigner: IDesigner): TNavigatorFactory;
function CreateNavigator(const ADesigner: IDesigner; AScope: TBaseLinkingBindSource): TComponent;
function CreateAdapterFactories(const ADesigner: IDesigner): TArray<TBindScopeFactory>;
function CanCreateNavigator(const ADesigner: IDesigner): Boolean;
function DataSourceHasNavigator(const ADesigner: IDesigner; AComponent: TComponent): Boolean;


var
  DesignersList: TList = nil;
  ControlFrameFactoriesList: TList = nil;
  ControlFactoriesList: TList = nil;


implementation

{$R *.dfm}

uses System.Win.Registry, System.TypInfo, Winapi.CommCtrl, StdConst, DsnConst,
  DesignEditors, VCLEditors, BindCompDrag, BindCompDsnResStrs, BindCompNewStd,
  Vcl.Dialogs, Generics.Collections, BindExpertsUIUnit, System.UITypes;

procedure RegisterControlFrameFactory(AClass: TControlFactoryClass);
begin
  if ControlFrameFactoriesList = nil then
    ControlFrameFactoriesList := TList.Create;
  ControlFrameFactoriesList.Add(AClass);
end;

function CreateComponentClassFactory(ADesigner: IDesigner): TControlClassFactory;
var
  I: Integer;
begin
  if ControlFrameFactoriesList <> nil then
    for I := ControlFrameFactoriesList.Count - 1 downto 0 do
    begin
      if TClass(ControlFrameFactoriesList[I]).InheritsFrom(TControlClassFactory) then
      begin
        Result := TComponentClassFactoryClass(ControlFrameFactoriesList[I]).Create(ADesigner);
        if Result.Enabled then
          Exit
        else
          FreeAndNil(Result);
      end;
    end;
end;


function CreateNavigatorFactory(const ADesigner: IDesigner): TNavigatorFactory;
var
  I: Integer;
begin
  if ControlFrameFactoriesList <> nil then
    for I := ControlFrameFactoriesList.Count - 1 downto 0 do
    begin
       if TClass(ControlFrameFactoriesList[I]).InheritsFrom(TNavigatorFactory) then
      begin
        Result := TNavigatorFactoryClass(ControlFrameFactoriesList[I]).Create(ADesigner);
        if Result.Enabled then
          Exit
        else
          FreeAndNil(Result);
      end;
    end;
end;

function CreateNavigator(const ADesigner: IDesigner; AScope: TBaseLinkingBindSource): TComponent;
var
  LFactory: TNavigatorFactory;
  LOptions: TControlClassFactory.TOptions;
  LProperties: TStrings;
begin
  LFactory := CreateNavigatorFactory(ADesigner);
  LFactory.BindScope := AScope;

  LOptions := [];
  LProperties := TStringList.Create;
  try
    if True then  // Always name navigator
    begin
      Include(LOptions, TControlClassFactory.TOption.optSuffix);
      LProperties.Values[TControlClassFactory.sSuffix] :=
        AScope.Name;
    end;

    Result := LFactory.CreateControl(LOptions, LProperties);
  finally
    LProperties.Free;
  end;
end;

function CreateAdapterFactories(const ADesigner: IDesigner): TArray<TBindScopeFactory>;
var
  I: Integer;
  LAdapterFactory: TBindScopeFactory;
  LList: TList<TBindScopeFactory>;
begin
  LList := TList<TBindScopeFactory>.Create;
  try
  if ControlFrameFactoriesList <> nil then
    for I := ControlFrameFactoriesList.Count - 1 downto 0 do
    begin
       if TClass(ControlFrameFactoriesList[I]).InheritsFrom(TBindScopeFactory) then
      begin
        LAdapterFactory := TBindScopeFactoryClass(ControlFrameFactoriesList[I]).Create(ADesigner);
        if LAdapterFactory.Enabled then
        begin
          LList.Add(LAdapterFactory);
        end
        else
          FreeAndNil(Result);
      end;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function CanCreateNavigator(const ADesigner: IDesigner): Boolean;
var
  LTemp: TObject;
begin
  LTemp := CreateNavigatorFactory(ADesigner);
  try
    Result := LTemp <> nil;
  finally
    LTemp.Free;
  end;
end;


function DataSourceHasNavigator(const ADesigner: IDesigner; AComponent: TComponent): Boolean;
var
  I: Integer;
  LComponent: TComponent;
  LTemp: TNavigatorFactory;
begin
  Result := False;
  LTemp := CreateNavigatorFactory(ADesigner);
  try
    if LTemp <> nil then
      for I := 0 to ADesigner.Root.ComponentCount - 1 do // Ignores components in frames
      begin
        LComponent := ADesigner.Root.Components[I];
        if LTemp.IsNavigatorFor(LComponent, AComponent) then
          Exit(True);

      end;
  finally
    LTemp.Free;
  end;
end;

//type
//  DefDataBindingClass = TBindLink;

procedure NotifyDataBindingListChangeImpl;
var
  I: Integer;
begin
  if DesignersList <> nil then
    for I := 0 to DesignersList.Count - 1 do
      TDataBindingListDesigner(DesignersList[I]).NotifyDataBindingListChange;
end;

function ShowDataBindingListDesignerClass(const ADesigner: IDesigner;
  DesignerClass: TDataBindingListDesignerClass;
  ADataBindingList: TCustomBindingsList): TDataBindingListDesigner;
var
  I: Integer;
begin
  if DesignersList = nil then
    DesignersList := TList.Create;
  for I := 0 to DesignersList.Count - 1 do
  begin
    Result := TDataBindingListDesigner(DesignersList[I]);
    with Result do
      if (Designer = ADesigner) and (FDataBindingList = ADataBindingList) then
      begin
        Show;
        BringToFront;
        Exit;
      end;
  end;
  Result := DesignerClass.Create(Application);
  with Result do
  try
    Designer := ADesigner;
    FDataBindingList := ADataBindingList;
    FDataBindingListClassName := ADataBindingList.ClassName + '1'; // registry key
    UpdateView(True);
    UpdateCaption;
    Show;
  except
    Free;
  end;
end;

procedure ShowBindCompListDesigner(const ADesigner: IDesigner;
 ADataBindingList: TCustomBindingsList);
begin
  ShowDataBindingListDesignerClass(ADesigner, TDataBindingListDesigner, ADataBindingList);
end;

{ TDataBindingListDesigner }

procedure TDataBindingListDesigner.NotifyDataBindingListChange;
begin
  BuildNewDataBindings;
end;

procedure TDataBindingListDesigner.Activated;
begin
  Designer.Activate;
  SetSelection;
end;

procedure TDataBindingListDesigner.ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
begin
  if AItem = FDataBindingList then
  begin
    FDataBindingList := nil;  // Component is already in its destructor; component is gone
    Close;
  end
  else if AItem is TComponent then
    FItemIDList.Remove(TComponent(AItem));
end;

procedure TDataBindingListDesigner.DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = ADesigner then
  begin
    FDataBindingList := nil;
    Close;
  end;
end;

procedure TDataBindingListDesigner.FocusDataBinding(DataBinding: TContainedBindComponent);
var
  I: Integer;
  Category: string;
  CategoryKind: TCategoryKind;
  LUpdateNeeded: Boolean;
begin
  if DataBinding <> nil then
  begin
    { Attempt to use current category }
    Category := DataBinding.Category;
    if Category <> '' then
      CategoryKind := ckCategory else
      CategoryKind := ckNone;
    LUpdateNeeded := False;
    if  FCategoryKind = ckAll then
    begin
      // Leave category
    end
    else if FCategoryKind = ckNone then
    begin
      if CategoryKind <> ckNone then
        LUpdateNeeded := True;
    end
    else if FCategoryKind = ckCategory then
    begin
      if (CategoryKind <> ckCategory) or (not SameText(FCategory, Category)) then
        LUpdateNeeded := True;
    end;
    if LUpdateNeeded then
    begin
      FCategory := Category;
      FCategoryKind := CategoryKind;
      UpdateView;
    end;
    

         
//      if not ((ListBox1.Items.Count > 0) and ((FCategoryKind = ckAll) and
//        (Integer(ListBox1.Items.Objects[ListBox1.Items.Count - 1]) = Ord(ckAll))) or
//        ((FCategoryKind = ckNone) and (Integer(ListBox1.Items.Objects[0]) = Ord(ckNone)) or
//        ((FCategoryKind = ckCategory) and (AnsiCompareText(FCategory, Category) = 0)))) then
//        if (AnsiCompareText(Category, FCategory) <> 0) or (CategoryKind <> FCategoryKind) then
//        begin
//          FCategory := Category;
//          FCategoryKind := CategoryKind;
//          UpdateView;
//        end;
    for I := 0 to ListView1.Items.Count - 1 do
      if Integer(ListView1.Items[I].Data) = DataBinding.Index then
      begin
        LockState;
        try
          with ListView1.Items[I] do
          begin
            Focused := True;
            MakeVisible(False);
          end;
        finally
          UnLockState;
        end;
        Exit;
      end;
  end;
end;

procedure TDataBindingListDesigner.ItemsModified(const ADesigner: IDesigner);
var
  LastFocused: TContainedBindComponent;
begin
  if (FDataBindingList <> nil) and (FUpdateCount = 0) then
  begin
    if (ListView1.ItemFocused <> nil) and (FDataBindingList.BindCompCount > Integer(ListView1.ItemFocused.Data)) then
      LastFocused := FDataBindingList[Integer(ListView1.ItemFocused.Data){+ ListView1.ItemFocused.Index}] else
      LastFocused := nil;
    UpdateView;
    if Designer <> ADesigner then Exit;
    FocusDataBinding(LastFocused);
    GetSelection;
  end;
  UpdateCaption;
end;

function TDataBindingListDesigner.GetItemName(Index, ItemIndex: Integer): string;
begin
{  with TAccessCollection(Collection) do
    if GetAttrCount < 1 then
      Result := Format('%d - %s',[ItemIndex, Actions.Items[ItemIndex].DisplayName])
    else Result := GetItemAttr(Index, ItemIndex);}
end;

function TDataBindingListDesigner.GetRegKey: string;
begin
  Result := Designer.GetBaseRegKey + '\' + sIniEditorsName + '\DataBindings Editor';
end;

function TDataBindingListDesigner.IndexOfDataBinding(DataBinding: TContainedBindComponent): Integer;
var
  I: Integer;
begin
  for I := 0 to ListView1.Items.Count - 1 do
    if Integer(ListView1.Items[I].Data) = DataBinding.Index then
    begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

procedure TDataBindingListDesigner.GetSelection;
var
  I, J: Integer;
  DataBinding: TContainedBindComponent;
  List: IDesignerSelections;

  function IsValidDataBinding(DataBinding: TContainedBindComponent): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to FDataBindingList.BindCompCount - 1 do
      if FDataBindingList[I] = DataBinding then
      begin
        Result := True;
        Break;
      end;
  end;

begin
  LockState;
  try
    ListView1.Selected := nil;
  finally
    UnlockState;
  end;

  List := CreateSelectionList;
  Designer.GetSelections(List);
  if (List.Count = 0) or (List.Count > FDataBindingList.BindCompCount) then Exit;
  if List.Count > ListView1.Items.Count then UpdateView;

  LockState;
  try
    for I := FItemIDList.Count - 1 downto 0 do
    begin
      DataBinding := TContainedBindComponent(FItemIDList[I]);
      if (DataBinding <> nil) and IsValidDataBinding(DataBinding) and DataBindingVisible(DataBinding) then
      begin
        J := IndexOfDataBinding(DataBinding);
        if J >= 0 then
          ListView1.Items[J].Selected := True;
      end
      else
        FItemIDList.Delete(I);
    end;
  finally
    UnlockState;
  end;
{$IFDEF RELATIONSHIPSDLG}
  if FBindRelationshipsDlg <> nil then
    FBindRelationshipsDlg.SetComponent(SelectedBindComponent);
  if FBindNewRelationshipsDlg <> nil then
    FBindNewRelationshipsDlg.ListComponents;

{$ENDIF}
end;

//procedure TDataBindingListDesigner.GraphTabSheetShow(Sender: TObject);
//begin
//  if Self.FGraphViewUpdateNeeded then
//    UpdateGraphView;
//
//end;

procedure TDataBindingListDesigner.LockState;
begin
  Inc(FStateLock);
end;

procedure TDataBindingListDesigner.SetSelection;
var
  I: Integer;
  List: IDesignerSelections;
  DataBinding: TContainedBindComponent;
begin
  if FSelectionError then Exit;
  try
    if ListView1.SelCount > 0 then
    begin
      List := CreateSelectionList;
      FItemIDList.Clear;
      for I := 0 to ListView1.Items.Count - 1 do
        if ListView1.Items[I].Selected then
        begin
          DataBinding := FDataBindingList[{+ I}Integer(ListView1.Items[I].Data)];
          List.Add(DataBinding);
          FItemIDList.Add(DataBinding);
        end;
      Designer.SetSelections(List);
    end
    else
      Designer.SelectComponent(FDataBindingList);
  except
    FSelectionError := True;
    Application.HandleException(ExceptObject);
    Close;
  end;
{$IFDEF RELATIONSHIPSDLG}
  if FBindRelationshipsDlg <> nil then
    FBindRelationshipsDlg.SetComponent(SelectedBindComponent);
  if FBindNewRelationshipsDlg <> nil then
    FBindNewRelationshipsDlg.ListComponents;

{$ENDIF}
end;

procedure TDataBindingListDesigner.UnlockState;
begin
  Dec(FStateLock);
end;

function TDataBindingListDesigner.DataBindingVisible(DataBinding: TContainedBindComponent): Boolean;
begin
  Result := (FCategoryKind = ckAll) or (DataBinding.Category = '') and
    (FCategoryKind in [ckNone, ckAll]) or (FCategoryKind = ckCategory) and
    (AnsiCompareText(DataBinding.Category, FCategory) = 0);
end;

procedure TDataBindingListDesigner.UpdateView(AUpdateColumns: Boolean);

  procedure UpdateSizes;
{  var
    Kind: Integer;}
  var
    LIndex: Integer;
    DefClassName: string;
    DefClass: TPersistentClass;
    DefClass2: TContainedBindCompClass;
  begin
    with TRegIniFile.Create(GetRegKey) do
    try
      Width := ReadInteger(FDataBindingListClassName, 'Width', Width);
      Height := ReadInteger(FDataBindingListClassName, 'Height', Height);
      DescriptionsVisible := ReadBool(FDataBindingListClassName, 'Descriptions', True);
      for LIndex := 0 to ListView1.Columns.Count - 1 do
        with ListView1.Columns.Items[LIndex] do
          Width := ReadInteger(FDataBindingListClassName, 'Width'+IntToStr(LIndex), Width);
{      Kind := ReadInteger(FActionListClassName, 'CategoryKind', Ord(ckNone));
      if not (Kind in [Low(CategoryKinds)..High(CategoryKinds)]) then
        Kind := Ord(ckNone);
      FCategoryKind := CategoryKinds[Kind];
      FCategory := ReadString(FActionListClassName, 'Category', '');}
      CategoryPanel.Width := ReadInteger(FDataBindingListClassName, 'CategoryWidth', CategoryPanel.Width);
      Splitter1.Top := Toolbar1.Top + Toolbar1.Height;
      Toolbar1.Visible := ReadBool(FDataBindingListClassName, 'Toolbar', True);
      Splitter1.Visible := Toolbar1.Visible;
      Toolbar1.HandleNeeded; //! Setting action class touches handle
      LargeButtons := ReadBool(FDataBindingListClassName, 'LargeButtons', False);
      { Load default data binding class }
      DefClassName := ReadString(FDataBindingListClassName, 'DataBindingClass', '');
      if DefClassName = '' then
        DefClass := nil
      else
      begin
        DefClass := GetClass(DefClassName);
        if (DefClass <> nil) and not DefClass.InheritsFrom(TContainedBindComponent) then
          DefClass := nil;
      end;
      if DefClass <> nil then
        DefClass2 := TContainedBindCompClass(DefClass) else
        DefClass2 := nil;
      CommonDataBindingClass := DefClass2;
{+ 
      if ReadBool(FActionListClassName, 'StandardActions', False) then
        ToolButton1.Action := NewStdAction else
        ToolButton1.Action := NewAction;
!}        
    finally
      Free;
    end;
  end;

  procedure UpdateColumns;
  begin
    UpdateSizes;
  end;

  procedure FetchItems(List: TStrings);
  var
    I: Integer;
    DataBinding: TContainedBindComponent;
  begin
    if FDataBindingList <> nil then
      for I := 0 to FDataBindingList.BindCompCount - 1 do
      begin
        DataBinding := FDataBindingList[I];
        if DataBindingVisible(DataBinding) then
          List.AddObject(DataBinding.Name, Pointer(I));
      end;

  end;

  function GetDataBindingDesigner(ADataBinding: TContainedBindComponent): IBindCompDesigner;
  begin
     Result := Data.Bind.Components.GetBindCompDesigner(TContainedBindCompClass(ADataBinding.ClassType));
  end;


  function BindingDescription(ADataBinding: TContainedBindComponent; ADesigner: IBindCompDesigner): string;
  begin
    if ADesigner <> nil then
      Result := ADesigner.GetDescription(ADataBinding)
    else
      Result := '';

  end;


  function ItemsEqual(ListItems: TListItems; Items: TStrings): Boolean;
  var
    I: Integer;
//    Tmp: TContainedBindComponent;
//    ImageIndex: Integer;
  begin
    Result := False;
    if ListItems.Count <> Items.Count then Exit;
    for I := 0 to ListItems.Count - 1 do
    begin
      if ListItems[I].Caption = Items[I] then
      begin
//        Tmp := FDataBindingList[Integer(Items.Objects[I])];
//        if (Tmp is TContainedBindComponent) then
//          ImageIndex := TContainedBindComponent(Tmp).ImageIndex else
//          ImageIndex := -1;
//        if ListItems[I].ImageIndex <> ImageIndex then Exit;
      end
      else
        Exit;
    end;
    Result := True;
  end;

var
  TmpItems: TStringList;
  LItem: TListItem;
  LCaption: string;
  LDesigner: IBindCompDesigner;
  I, J: Integer;
  Categories: TStringList;
  BlankCategoryCount: Integer;
  DataBinding: TContainedBindComponent;
begin
  if FDataBindingList = nil then Exit;
  LockState;
  try
    { Update actions }
    Categories := TStringList.Create;
    try
      Categories.Sorted := True;
      BlankCategoryCount := 0;
      if FDataBindingList <> nil then
        for I := 0 to FDataBindingList.BindCompCount - 1 do
          if FDataBindingList[I].Category <> '' then
            Categories.Add(FDataBindingList[I].Category)
          else if BlankCategoryCount = 0 then
            Inc(BlankCategoryCount);

      { Update categories }
      ListBox1.Items.BeginUpdate;
      try
        ListBox1.Items.Clear;
        ListBox1.Items.Assign(Categories);
        // Always include all
        ListBox1.Items.InsertObject(0, SDataBindingCategoryAll, TObject(Ord(ckAll)));
        if Categories.Count + BlankCategoryCount = 0 then
        begin
          // No components
          
        end
        else if BlankCategoryCount <> 0 then
        begin
          // Some blank categories
          //if Categories.Count > 0 then
          //  ListBox1.Items.InsertObject(0, SDataBindingCategoryAll, TObject(Ord(ckAll)));
          ListBox1.Items.AddObject(SDataBindingCategoryNone, TObject(Ord(ckNone)));
        end
        else if Categories.Count > 1 then
        begin
          // multiple categories
          // ListBox1.Items.InsertObject(0, SDataBindingCategoryAll, TObject(Ord(ckAll)));
        end;
        
        if BlankCategoryCount = 0 then
          if FCategoryKind = ckNone then
          begin
            FCategoryKind := ckAll;
            FCategory := '';
          end;

        { Select category }
        if FCategoryKind = ckCategory then
        begin
          I := ListBox1.Items.IndexOf(FCategory);
          if I < 0 then
          begin
            I := 0;
            FCategoryKind := ckAll;
            FCategory := '';
          end
          else
            FCategory := ListBox1.Items[I];
        end
        else
          I := ListBox1.Items.IndexOfObject(TObject(Ord(FCategoryKind)));
        if I < 0 then
          if ListBox1.Count > 0 then
            I := 0;
        ListBox1.ItemIndex := I;
      finally
        ListBox1.Items.EndUpdate;
      end;

      { Update actions }
      TmpItems := TStringList.Create;
      FetchItems(TmpItems);
      //if (TmpItems.Count = 0) or not ItemsEqual(ListView1.Items, TmpItems) then
      try
        ListView1.Items.BeginUpdate;
        try
          if AUpdateColumns then
            UpdateColumns;
          ListView1.Items.Clear;
          if FDataBindingList <> nil then
            for I := 0 to FDataBindingList.BindCompCount - 1 do
            begin
              DataBinding := FDataBindingList[I];
              LDesigner := GetDataBindingDesigner(DataBinding);
              if DataBindingVisible(DataBinding) then
              begin
                LItem := ListView1.Items.Add;
                with LItem do
                begin
                  Caption := DataBinding.Name;
                  Data := Pointer(I);
                  for J := 1 to ListView1.Columns.Count  - 1 do
                  begin
                    case J of
                      1: LCaption := BindingDescription(DataBinding, LDesigner)
                    else
                      LCaption := '';
                    end;
                    LItem.SubItems.Add(LCaption);
                  end;
                end;
              end;
            end;
        finally
          ListView1.Items.EndUpdate;
        end;
      finally
        TmpItems.Free;
      end;
    finally
      Categories.Free;
    end;
//    if GraphTabSheet.Visible or
//      DotTabSheet1.Visible then
//      UpdateGraphView
//    else
//      Self.FGraphViewUpdateNeeded := True;

  finally
    UnlockState;
  end;
end;

procedure TDataBindingListDesigner.Clear;
begin
  if FDataBindingList <> nil then
    while FDataBindingList.BindCompCount > 0 do
      FDataBindingList[0].Free;
  FItemIDList.Clear;
end;

procedure TDataBindingListDesigner.DoNewDataBinding(const Category: string; DataBinding: TContainedBindComponent);
begin
  try
    DataBinding.BindingsList := FDataBindingList;
    DataBinding.Name := UniqueName(DataBinding);
    with ListView1.Items.Add do
    begin
      Data := Pointer(DataBinding.Index);
      Selected := True;
      Focused := True;
//!      MakeVisible(False);
{+
      Selected := Items.Add;
      ItemFocused := Selected;
      ItemFocused.MakeVisible(False);
!}
    end;
    { Setting the Category causes the Designer to be modified }
    BeginUpdate;
    try
      DataBinding.Category := Category;
    finally
      EndUpdate;
    end;

  except
    DataBinding.Free;
    raise;
  end;
  SetSelection;
  Designer.Modified;
end;

type
  TInfo = record
    FClass: TContainedBindCompClass;
    FFound: Boolean;
    FCategory: string;
  end;

  PInfo = ^TInfo;

procedure TDataBindingListDesigner.CategoryOfClassEnumProc(const Category: string; BindCompClass: TContainedBindCompClass;
    Info: TEnumBindCompProcInfo);
begin
  if BindCompClass =  PInfo(Info).FClass then
  begin
     PInfo(Info).FFound := True;
     PInfo(Info).FCategory := Category;
  end;
end;

//procedure TDataBindingListDesigner.ChangeLeftActionUpdate(Sender: TObject);
//begin
//  inherited;
//{$IFDEF DEVELOPERS}
//{$ELSE}
//  ChangeLeftAction.Visible := False;
//{$ENDIF}
//
//end;

{$IFDEF RELATIONSHIPSDLG}
function TDataBindingListDesigner.SelectedBindComponent: TComponent;
var
  I: Integer;
begin
  Result := nil;
  if ListView1.SelCount <> 1 then
    Exit;
  for I := ListView1.Items.Count - 1 downto 0 do
    if ListView1.Items[I].Selected then
    begin
      Exit(FDataBindingList[Integer(ListView1.Items[I].Data)]);
    end;
end;
{$ENDIF}


function TDataBindingListDesigner.CategoryOfClass(AClass: TContainedBindCompClass): string;
var
  LInfo: TInfo;
begin
  LInfo.FClass := AClass;
  Data.Bind.Components.EnumRegisteredBindComponents(CategoryOfClassEnumProc, TEnumBindCompProcInfo(@LInfo));
  if LInfo.FFound then
    Result := LInfo.FCategory
  else
    Result := '';
end;


procedure TDataBindingListDesigner.DeleteClick(Sender: TObject);
begin
  Remove;
end;

procedure TDataBindingListDesigner.ListView1Click(Sender: TObject);
begin
//  SetSelection;
{$IFDEF RELATIONSHIPSDLG}
  if FBindRelationshipsDlg <> nil then
    FBindRelationshipsDlg.SetComponent(SelectedBindComponent);
{$ENDIF}

end;

procedure TDataBindingListDesigner.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Designer.ModalEdit(#0, Self);
end;

procedure TDataBindingListDesigner.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_PROCESSKEY then
    Designer.ModalEdit(#0, Self);
end;

procedure TDataBindingListDesigner.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  I: Integer;
begin
  if FDataBindingList <> nil then
    Designer.SelectComponent(FDataBindingList);
  with TRegIniFile.Create(GetRegKey) do
  try
    EraseSection(FDataBindingListClassName);
    WriteInteger(FDataBindingListClassName, 'Width', Width);
    WriteInteger(FDataBindingListClassName, 'Height', Height);
    for I := 0 to ListView1.Columns.Count - 1 do
      with ListView1.Columns.Items[I] do
        WriteInteger(FDataBindingListClassName, 'Width'+IntToStr(I), Width);
    WriteBool(FDataBindingListClassName, 'Descriptions', DescriptionsVisible);
    WriteBool(FDataBindingListClassName, 'Toolbar', Toolbar1.Visible);
    WriteInteger(FDataBindingListClassName, 'CategoryWidth', CategoryPanel.Width);
    WriteBool(FDataBindingListClassName, 'LargeButtons', LargeButtons);
    if CommonDataBindingClass <> nil then
      WriteString(FDataBindingListClassName, 'DataBindingClass', CommonDataBindingClass.ClassName);
  finally
    Free;
  end;
  Action := caFree;
  LockState;
end;

function TDataBindingListDesigner.GetDataBindingIndex(ListIndex: Integer): Integer;
begin
  Result := FDataBindingList[Integer(ListView1.Items[ListIndex].Data)].Index;
end;

procedure TDataBindingListDesigner.MoveUpClick(Sender: TObject);
var
  I, InsPos: Integer;
begin
  if (ListView1.SelCount = 0) or
    (ListView1.SelCount = FDataBindingList.BindCompCount) then Exit;

  InsPos := 0;
  while not ListView1.Items[InsPos].Selected do
    Inc(InsPos);
  if InsPos > 0 then Dec(InsPos);

  for I := 0 to ListView1.Items.Count - 1 do
   if ListView1.Items[I].Selected then
   begin
     FDataBindingList[Integer(ListView1.Items[I].Data)].Index := GetDataBindingIndex(InsPos);
     Inc(InsPos);
   end;
  GetSelection;
  Designer.Modified;
end;

procedure TDataBindingListDesigner.MoveDownClick(Sender: TObject);
var
  I, InsPos: Integer;
begin
  if (ListView1.SelCount = 0) or
    (ListView1.SelCount = FDataBindingList.BindCompCount) then Exit;

  InsPos := ListView1.Items.Count - 1;
  while not ListView1.Items[InsPos].Selected do
    Dec(InsPos);
  if InsPos < ListView1.Items.Count - 1 then Inc(InsPos);

  for I := ListView1.Items.Count - 1 downto 0 do
   if ListView1.Items[I].Selected then
   begin
     FDataBindingList[Integer(ListView1.Items[I].Data)].Index := GetDataBindingIndex(InsPos);
     Dec(InsPos);
   end;
  GetSelection;
  Designer.Modified;
end;

procedure TDataBindingListDesigner.ListView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Item: TListItem;
begin
  Item := ListView1.GetItemAt(X, Y);
  Accept := (Item <> nil) {+ and (Source = ListView1)} and
    (not Item.Selected);
end;

procedure TDataBindingListDesigner.ListView1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Item: TListItem;
  I, J, InsPos: Integer;
  L: TList;
begin
  Item := ListView1.GetItemAt(X, Y);
  if Item <> nil then
    InsPos := Item.Index
  else Exit;
  BeginUpdate;
  try
    L := TList.Create;
    try
      for I := 0 to ListView1.Items.Count - 1 do
        if ListView1.Items[I].Selected then
          L.Add(FDataBindingList[{+ I}Integer(ListView1.Items[I].Data)]);

      for I := 0 to L.Count - 1 do
      with TContainedBindComponent(L[I]) do
      begin
        J := Index;
        Index := InsPos;
        if (J > InsPos) and (InsPos < FDataBindingList.BindCompCount) then
          Inc(InsPos);
      end;
    finally
      L.Free;
    end;
  finally
    EndUpdate;
  end;
//!  GetSelection;
  SetSelection;
  Designer.Modified;
end;

procedure TDataBindingListDesigner.FormCreate(Sender: TObject);
begin
  FItemIdList := TList.Create;
  FCategoryKind := ckAll;
  DesignersList.Add(Self);
  BuildNewDataBindings;
  ToolBar1.HandleNeeded; //! Setting action class touches handle
  CommonDataBindingClass := nil; //DefDataBindingClass;


//  // Setup Graph View Control
//  FDeclsView := TDeclsViewer.Create(GraphPanel);
//  FDeclsView.Parent := GraphPanel;
//  FDeclsView.Align := alClient;
//  FDeclsView.OnDotNodeClick := OnDotNodeClick;
end;

//procedure TDataBindingListDesigner.OnDotNodeClick(Sender: TDotViewer; const NodeComment: string);
//begin
//
//end;

{$IFDEF RELATIONSHIPSDLG}
procedure TDataBindingListDesigner.OnRelationshipsDestroy(Sender: TObject);
begin
  FBindRelationshipsDlg := nil;
end;

procedure TDataBindingListDesigner.OnNewRelationshipsDestroy(Sender: TObject);
begin
  FBindNewRelationshipsDlg := nil;
end;
{$ENDIF}

//procedure TDataBindingListDesigner.UpdateGraphView;
//var
//  LList: TList<TContainedBindComponent>;
//  I: Integer;
//  LDataBinding: TContainedBindComponent;
//begin
////  Self.FGraphViewUpdateNeeded := False;
//  LList := TList<TContainedBindComponent>.Create;
//  try
//    if FDataBindingList <> nil then
//    begin
//      for I := 0 to FDataBindingList.BindCompCount - 1 do
//      begin
//        LDataBinding := FDataBindingList[I];
//        if DataBindingVisible(LDataBinding) then
//        begin
//          LList.Add(LDataBinding);
//        end;
//      end;
//    end;
//    FDeclsView.SetDecls(LList.ToArray);
//    FDeclsView.UpdateZoom;
//    Memo1.Lines.Text := FDeclsView.DotString;
//    Memo2.Lines.Text := DumpDescriptions(LList.ToArray);
//  finally
//    LList.Free;
//  end;
//  FDeclsView.Invalidate;
//end;

//function TDataBindingListDesigner.DumpDescriptions(ABindings: TArray<TContainedBindComponent>): string;
//const
//  sIndent = '  ';
//var
//  LList: TStrings;
//
//  function FormatComponentName(const ALabel: string;
//    AComponent: TComponent): string;
//  begin
//    if AComponent = nil then
//      Result := Format('%s = nil', [ALabel])
//    else
//      Result := Format('%s = %s: %s', [ALabel, AComponent.Name, AComponent.ClassName]);
//  end;
//
//  procedure AppendMembers(const ALabel: string;
//    AMembers: TArray<string>);
//  var
//    S: string;
//  begin
//    LList.Append(ALabel);
//    for S in AMembers do
//    begin
//      LList.Append(sIndent + S);
//    end;
//  end;
//var
//  LComponent: TComponent;
//  LDescriptions: TList<TBindRelationshipsDescription>;
//  LDescription: TBindRelationshipsDescription;
//  LRelationship: TBindRelationship;
//begin
//  LList := TStringList.Create;
//  try
//    for LComponent in ABindings do
//    begin
//      LDescriptions := TObjectList<TBindRelationshipsDescription>.Create;
//      try
//      for LDescription in LDescriptions do
//      begin
//        if LDescription <> nil then
//        begin
//          LList.Append(Format('%s: %s', [LComponent.Name, LComponent.ClassName]));
//          Assert(LDescription.BindComponent = LComponent);
//          LList.Append(FormatComponentName('LeftComponent',
//            LDescription.LeftComponent));
//          AppendMembers('LeftMembers',
//            LDescription.LeftMembers);
//          LList.Append(FormatComponentName('RightComponent',
//            LDescription.RightComponent));
//          AppendMembers('RightMembers',
//            LDescription.RightMembers);
//          LList.Append('Relationships');
//          for LRelationship in LDescription.Relationships do
//          begin
//            Assert(LRelationship.Parent = LDescription);
//            LList.Append(sIndent + Format('LeftMemberName: %s',
//              [LRelationship.LeftMemberName]));
//             LList.Append(sIndent + Format('RightMemberName: %s',
//              [LRelationship.RightMemberName]));
//            LList.Append(sIndent + Format('Direction: %s',
//              [GetEnumName(TypeInfo(TRelationshipDirection), Integer(LRelationship.Direction))]));
//          end;
//        end
//        else
//          LList.Append(Format('No description for %s: %s', [LComponent.Name, LComponent.ClassName]));
//        LList.Append('');
//      end;
//      finally
//        LDescriptions.Free;
//      end;
//    end;
//    Result := LList.Text;
//  finally
//    LList.Free;
//  end;
//
//
//end;

procedure TDataBindingListDesigner.FormDestroy(Sender: TObject);
begin
  if DesignersList <> nil then
    DesignersList.Remove(Self);
  FItemIdList.Free;
//  FreeAndNil(FDeclsView);
end;

procedure TDataBindingListDesigner.FormResize(Sender: TObject);
begin
{  if not ListView1.ShowColumnHeaders then
    ListView1.Column[0].Width := ListView1.ClientWidth;}
end;

procedure TDataBindingListDesigner.ListView1Change(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  Msg: TMsg;
begin
  if (FUpdateCount = 0) and (FStateLock = 0) and (Change = ctState) then
    if not PeekMessage(Msg, Handle, AM_DeferUpdate, AM_DeferUpdate, PM_NOREMOVE) then
      PostMessage(Handle, AM_DeferUpdate, 0, 0);
end;

procedure TDataBindingListDesigner.AMDeferUpdate(var Msg);
begin
  if (FUpdateCount = 0) and (FStateLock = 0)  then
    SetSelection
  else
    PostMessage(Handle, AM_DeferUpdate, 0, 0);
end;

procedure TDataBindingListDesigner.SelectAllItemClick(Sender: TObject);
begin
  SelectAll();
end;

function TDataBindingListDesigner.UniqueName(Component: TComponent): string;
begin
  Result := Designer.UniqueName(
    Component.ClassName);
end;

function TDataBindingListDesigner.GetEditState: TEditState;

  function ActionsSelected: Boolean;
  var
    I: Integer;
  begin
    Result := True;
    with ListView1 do
      for I := 0 to Items.Count - 1 do
        if Items[I].Selected then Exit;
    Result := False;
  end;

begin
  Result := [];
  if ClipboardComponents then Result := [esCanPaste];
  if ActionsSelected then Result := Result + [esCanCopy, esCanCut, esCanDelete];
end;

function TDataBindingListDesigner.EditAction(Action: TEditAction): Boolean;
begin
  Result := True;
  case Action of
    eaCut: Cut;
    eaCopy: Copy;
    eaPaste: Paste;
    eaDelete: Remove;
    eaSelectAll: SelectAll();
  else
    Result := False;
  end;
end;

procedure TDataBindingListDesigner.SelectAll(DoUpdate: Boolean);
var
  I: Integer;
begin
  LockState;
  ListView1.Items.BeginUpdate;
  try
    for I := 0 to Listview1.Items.Count-1 do
      Listview1.Items[I].Selected := True;
  finally
    ListView1.Items.EndUpdate;
    UnlockState;
    if DoUpdate then SetSelection;
  end;
end;

procedure TDataBindingListDesigner.SelectNone(DoUpdate: Boolean);
begin
  ListView1.Selected := nil;
  if DoUpdate then SetSelection;
end;

procedure TDataBindingListDesigner.Remove;
var
  NewFocused: Integer;
  I: Integer;
  KillActions: TList;
  LName: string;
  LComponent: TComponent;
  LBindActivate: IBindActivate;
begin
  if assigned(ListView1.ItemFocused) and
  GetComponentEditor(FDataBindingList[Integer(ListView1.ItemFocused.Data)], Designer).IsInInlined then { for Frames }
    raise Exception.CreateRes(@SCantDeleteAncestor);

  BeginUpdate;
  LockState;
  try
    // Deactivate components
    for I := ListView1.Items.Count - 1 downto 0 do
      if ListView1.Items[I].Selected then
      begin
        LComponent := TComponent(FDataBindingList[Integer(ListView1.Items[I].Data)]);
        if Supports(LComponent, IBindActivate, LBindActivate) then
        try
          LBindActivate.SetActive(False);
          LBindActivate := nil;
        except
          // Ignore deactivatation errors
        end;
      end;

    if ListView1.SelCount = FDataBindingList.BindCompCount then
    begin
      SelectNone(False);
      SetSelection;
      Clear;
    end
    else if ListView1.SelCount > 0 then
    begin
      KillActions := nil;
      try
        { Store deleted items for later destruction }
        KillActions := TList.Create;
        for I := ListView1.Items.Count - 1 downto 0 do
          if ListView1.Items[I].Selected then
          begin
            LName := TComponent(FDataBindingList[Integer(ListView1.Items[I].Data)]).Name;
            if (idYes <> MessageDlg(
                Format(sConfirmDelete, [LName]),
                   mtConfirmation, mbYesNoCancel, 0)) then
              Exit;
            KillActions.Add(TObject(ListView1.Items[I].Data));
          end;

        { Find new focused item from current focused item }
        NewFocused := -1;
        if ListView1.ItemFocused <> nil then
        begin
          for I := ListView1.ItemFocused.Index + 1 to ListView1.Items.Count - 1 do
            if not ListView1.Items[I].Selected then
            begin
              NewFocused := I;
              Break;
            end;
          if NewFocused = -1 then
            for I := ListView1.ItemFocused.Index downto 0 do
              if not ListView1.Items[I].Selected then
              begin
                NewFocused := I;
                Break;
              end;
        end;
        SelectNone(False);
        if NewFocused >= 0 then
          ListView1.Items[NewFocused].Selected := True;
        SetSelection;
        { Delete items }
        for I := 0 to KillActions.Count - 1 do
          if (csAncestor in FDataBindingList[Integer(KillActions[I])].ComponentState) then
            raise Exception.CreateRes(@SCantDeleteAncestor);
        for I := 0 to KillActions.Count - 1 do
          FDataBindingList[Integer(KillActions[I])].Free;
      finally
        KillActions.Free;
      end;
    end;
  finally
    UnLockState;
    EndUpdate;
  end;
  UpdateView;
  Designer.Modified;
  { Make sure we have focus }
  for I := 0 to ListView1.Items.Count - 1 do
    if ListView1.Items[I].Selected then
    begin
      FocusDataBinding(FDataBindingList[Integer(ListView1.Items[I].Data)]);
      Break;
    end;
end;

procedure TDataBindingListDesigner.Cut;
begin
  Copy;
  Remove;
end;

procedure TDataBindingListDesigner.Copy;
var
  I: Integer;
  ComponentList: IDesignerSelections;
begin
  ComponentList := CreateSelectionList;
  with ListView1 do
    for I := 0 to Items.Count - 1 do
      if Items[I].Selected then
        ComponentList.Add(FDataBindingList[{+ }Integer(Items[I].Data)]);
  CopyComponents(FDataBindingList.Owner, ComponentList);
end;


procedure TDataBindingListDesigner.Paste;
var
  I, C: Integer;
  ComponentList: TList;
  Action: TContainedBindComponent;
  Item: TListItem;
begin
  ComponentList := TList.Create;
  try
    C := -1;
    with ListView1 do
      if (Selected <> nil) and (Selected.Index <> -1) and (Items.Count > 0) then
        C := Selected.Index;
    try
      try
        { Try to convert TMenuItem, TControl, and TWinControl to TAction }
        LoadFromClipboard(FDataBindingList.Owner, FDataBindingList, ComponentList);
      finally
      end;
    finally
      UpdateView
    end;
    try
      ListView1.Selected := nil;
      Item := nil;
      for I := ComponentList.Count - 1 downto 0 do
        if TObject(ComponentList[I]) is TBasicAction then
        begin
          Action := TContainedBindComponent(ComponentList[I]);
          if C <> -1 then Action.Index := C;
          Item := ListView1.Items[C];
          if Item <> nil then Item.Selected := True;
        end;
      if Item <> nil then
        Item.Focused := True;
    finally
      GetSelection;
      Designer.Modified;
    end;
  finally
    ComponentList.Free;
  end;
end;

procedure TDataBindingListDesigner.UpdateCaption;
var
  NewCaption: string;
begin
  if (FDataBindingList <> nil) and (FDataBindingList.Owner <> nil) then
    NewCaption := Format(SDataBindingListEditorCaption, [FDataBindingList.Owner.Name, DotSep,
    FDataBindingList.Name]);
  if Caption <> NewCaption then Caption := NewCaption;
end;

procedure TDataBindingListDesigner.PasteItemClick(Sender: TObject);
begin
  Paste;
end;

procedure TDataBindingListDesigner.CopyItemClick(Sender: TObject);
begin
  Copy;
end;

procedure TDataBindingListDesigner.CutItemClick(Sender: TObject);
begin
  Cut;
end;

function TDataBindingListDesigner.GetDescriptionsVisible: Boolean;
begin
  Result := DescriptionsAction.Checked;
end;

procedure TDataBindingListDesigner.SetDescriptionsVisible(Value: Boolean);
begin
  DescriptionsAction.Checked := Value;
end;

procedure TDataBindingListDesigner.LoadFromClipboard(AOwner, AParent: TComponent;
  Components: TList);
var
  S: TStream;
begin
  S := GetClipboardStream;
  try
    ReadStream(S, AOwner, AParent, Components);
  finally
    S.Free;
  end;
end;

procedure TDataBindingListDesigner.ReadStream(Stream: TStream; AOwner,
  AParent: TComponent; Components: TList);
var
  M: TMemoryStream;
  R: TReader;
  I: Integer;
  W: TWriter;
begin
  M := TMemoryStream.Create;
  try
    R := TReader.Create(Stream, 1024);
    try
      R.OnSetName := ReaderSetName;
      FFixups := TList.Create;
      try
        R.ReadComponents(AOwner, AParent, ComponentRead);
        W := TWriter.Create(M, 1024);
        try
          W.Root := AOwner;
          for I := 0 to FFixups.Count - 1 do
            if TComponent(FFixups[I]) is TContainedBindComponent then
            begin
              W.WriteSignature;
              W.WriteComponent(TComponent(FFixups[I]));
            end;
          W.WriteListEnd;
        finally
          W.Free;
        end;
      finally
        for I := 0 to FFixups.Count - 1 do TObject(FFixups[I]).Free;
        FFixups.Free;
      end;
    finally
      R.Free;
    end;
    M.Position := 0;
    R := TReader.Create(M, 1024);
    try
      R.OnSetName := ReaderSetName2;
      FFixups := Components;
      R.ReadComponents(AOwner, AParent, ComponentRead);
    finally
      R.Free;
    end;
  finally
    M.Free;
  end;
end;

procedure TDataBindingListDesigner.RelationshipsActionExecute(Sender: TObject);
begin
{$IFDEF RELATIONSHIPSDLG}
  if FBindRelationshipsDlg = nil then
  begin
    FBindRelationshipsDlg := TBindRelationshipsDlg.Create(Self);
    FBindRelationshipsDlg.Designer := Self.Designer;
    FBindRelationshipsDlg.OnDestroy := Self.OnRelationshipsDestroy;
    FBindRelationshipsDlg.PopupMode := pmExplicit;
    FBindRelationshipsDlg.PopupParent := Self;
    FBindRelationshipsDlg.Show;
  end
  else
    FBindRelationshipsDlg.BringToFront;
  FBindRelationshipsDlg.SetComponent(SelectedBindComponent);
{$ENDIF}
end;

procedure TDataBindingListDesigner.RelationshipsActionUpdate(Sender: TObject);
begin
{$IFDEF RELATIONSHIPSDLG}
{$ELSE}
  RelationshipsAction.Visible := False;
{$ENDIF}
end;

procedure TDataBindingListDesigner.ReaderSetName(Reader: TReader; Component: TComponent;
  var Name: string);
begin
  Name := '';
end;

procedure TDataBindingListDesigner.ReaderSetName2(Reader: TReader; Component: TComponent;
  var Name: string);
begin
  Name := UniqueName(Component);
end;

procedure TDataBindingListDesigner.ComponentRead(Component: TComponent);
//var
//  DataBinding: TContainedBindComponent;
begin
  if Component is TContainedBindComponent then
  begin
    FFixups.Add(Component);
  end
  else begin
//    DataBinding := {+ Default}DefDataBindingClass.Create(nil);
//    try
//      try
//        DataBinding.Assign(Component);
//      finally
////!        Component.Free;
//      end;
//    except
//      DataBinding.Free;
//      raise;// Exception.Create(SMenuPasteError);
//    end;
//    FFixups.Add(DataBinding);
//    FFixups.Add(Component);
  end;
end;

procedure TDataBindingListDesigner.SelectedUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := ListView1.SelCount > 0;
end;

procedure TDataBindingListDesigner.SelectAllActionUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := ListView1.Items.Count > 0;
end;

procedure TDataBindingListDesigner.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex >= 0 then
  begin
    FCategoryKind := CategoryKinds[Integer(ListBox1.Items.Objects[ListBox1.ItemIndex])];
    if FCategoryKind = ckCategory then
      FCategory := ListBox1.Items[ListBox1.ItemIndex] else
      FCategory := '';
  end
  else
  begin
    FCategoryKind := ckAll;
    FCategory := '';
  end;
  UpdateView;
  ListView1Resize(nil);
end;

procedure TDataBindingListDesigner.BuildNewDataBindings;
begin
end;

procedure TDataBindingListDesigner.NewBindCompDialogExecute(Sender: TObject);
var
  LDataBinding: TContainedBindComponent;
begin
  if GetComponentEditor(FDataBindingList, Designer).IsInInlined then { for Frames }
    raise Exception.CreateRes(@SCantAddToAncestor);

  with TExecuteNewDataBinding.Create(FDataBindingList, Designer) do
  begin
    Execute(
      procedure
      begin
        SelectNone(False)
      end,
      procedure(ACategory: string; ADataBinding: TContainedBindComponent)
      begin
        LDataBinding := ADataBinding;
        CommonDataBindingClass := TContainedBindCompClass(LDataBinding.ClassType);
        DoNewDataBinding(ACategory, LDataBinding);
      end,
      procedure
      begin
        FocusDataBinding(LDataBinding)
      end,
      function(AClass: TContainedBindCompClass): Boolean
      begin
        // Allow class
        Result := True;
      end)
  end;
end;

procedure TDataBindingListDesigner.BindCompWizardExecute(Sender: TObject);
var
  LDataBinding: TContainedBindComponent;
begin
  if GetComponentEditor(FDataBindingList, Designer).IsInInlined then { for Frames }
    raise Exception.CreateRes(@SCantAddToAncestor);

  with TExecuteNewDataBindingWizard.Create(FDataBindingList, Designer as IDesigner) do
  begin
    Execute(
      procedure
      begin
        SelectNone(False)
      end,
      procedure(ACategory: string; ADataBinding: TContainedBindComponent; ANewControl: TComponent)
      begin
        LDataBinding := ADataBinding;
        //CommonDataBindingClass := TContainedBindCompClass(LDataBinding.ClassType);
        DoNewDataBinding(ACategory, LDataBinding);
      end,
      procedure
      begin
        FocusDataBinding(LDataBinding)
      end,
      function(AClass: TContainedBindCompClass): Boolean
      begin
        // Allow class
        Result := True;
      end)
  end;
end;

procedure TDataBindingListDesigner.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TDataBindingListDesigner.EndUpdate;
begin
  Dec(FUpdateCount);
end;

procedure TDataBindingListDesigner.SelectionChanged(const Designer: IDesigner;
  const ASelection: IDesignerSelections);
var
  I: Integer;
  S: Boolean;
{  LastItem: TListItem;
  SelChanged: Boolean;}

  function InSelection(Component: TComponent): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    if ASelection <> nil then
      with ASelection do
        for I := 0 to Count - 1 do
          if Component = Items[I] then Exit;
    Result := False;
  end;

begin
exit;
  if (FDataBindingList = nil) or (FUpdateCount > 0) or (FStateLock > 0) then Exit;
  if (GetCaptureControl <> nil) and (GetParentForm(GetCaptureControl) = Self) then Exit;
  BeginUpdate;
  LockState;
  try
    with ListView1 do
    begin
      Items.BeginUpdate;
      try
        for I := 0 to Items.Count - 1 do
        begin
          if I >= FDataBindingList.BindCompCount - 1 then Break;
          S := InSelection(FDataBindingList[{+ I}Integer(Items[I].Data)]);
          if Items[I].Selected <> S then
          begin
            Items[I].Selected := S;
          end;
        end;
      finally
        Items.EndUpdate;
      end;
    end;
  finally
    UnLockState;
    EndUpdate;
  end;
end;

procedure TDataBindingListDesigner.ListView1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if CharInSet(Key, ['!'..'~']) then
  begin
    Designer.ModalEdit(Key, Self);
    Key := #0;
  end;
end;

procedure TDataBindingListDesigner.ListView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_PROCESSKEY then
    Designer.ModalEdit(#0, Self);
end;

procedure TDataBindingListDesigner.NewDataBindingsPopupPopup(Sender: TObject);
var
  I: Integer;
begin
  { Sync popup menu's default item to that of the button }
  with (Sender as TPopupMenu) do
    for I := 0 to Items.Count - 1 do
      Items[I].Default := Items[I].Action = ToolButton1.Action;
end;


procedure TDataBindingListDesigner.NewRelationshipActionExecute(Sender: TObject);
begin
{$IFDEF RELATIONSHIPSDLG}
  if FBindNewRelationshipsDlg = nil then
  begin
    FBindNewRelationshipsDlg := TBindNewRelationshipsDlg.Create(Self);
    FBindNewRelationshipsDlg.Designer := Self.Designer;
    FBindNewRelationshipsDlg.OnDestroy := Self.OnNewRelationshipsDestroy;
    FBindNewRelationshipsDlg.PopupMode := pmExplicit;
    FBindNewRelationshipsDlg.PopupParent := Self;
    FBindNewRelationshipsDlg.ListComponents;
    FBindNewRelationshipsDlg.Show;
  end
  else
    FBindNewRelationshipsDlg.BringToFront;
  //FBindNewRelationshipsDlg.SetComponent(SelectedBindComponent);
{$ENDIF}
end;

procedure TDataBindingListDesigner.NewRelationshipActionUpdate(Sender: TObject);
begin
{$IFDEF RELATIONSHIPSDLG}
{$ELSE}
  NewRelationshipAction.Visible := False;
{$ENDIF}
end;

procedure TDataBindingListDesigner.DescriptionsActionExecute(Sender: TObject);
begin
  with DescriptionsAction do
  begin
    Checked := not Checked;
    Panel3.Visible := Checked;
    Panel4.Visible := Checked;
  end;
end;

procedure TDataBindingListDesigner.ListView1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FDragObject := TDataBindingDragObject.Create(ListView1);
  DragObject := FDragObject;
end;

procedure TDataBindingListDesigner.ListView1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  FDragObject.Free;
  FDragObject := nil;
end;

procedure TDataBindingListDesigner.SetCommonDataBindingClass(Value: TContainedBindCompClass);
var
  S: string;
begin
  //if Value = nil then Value := DefDataBindingClass;
  if FCommonDataBindingClass <> Value then
  begin
    FCommonDataBindingClass := Value;
    if FCommonDataBindingClass <> nil then
    begin
      S := Value.ClassName;
      if (Length(S) > 1) and (S[1] = 'T') then
        System.Delete(S, 1, 1);
      NewCommonDataBinding.Caption := Format(SNewDataBinding, [S]);
      NewCommonDataBinding.Hint := Format(SNewDataBindingHint, [S, S]);
    end;
  end;
  NewCommonDataBinding.Visible := FCommonDataBindingClass <> nil; //DefDataBindingClass;
end;

procedure TDataBindingListDesigner.ListView1DblClick(Sender: TObject);
var
  Editor: IComponentEditor;
  DataBinding: TContainedBindComponent;
begin
  { Perform default component editor action }
  if ListView1.ItemFocused <> nil then
  begin
    DataBinding := FDataBindingList[Integer(ListView1.ItemFocused.Data)];
    Editor := GetComponentEditor(DataBinding, Designer);
    if Editor <> nil then Editor.Edit;
  end;
end;

procedure TDataBindingListDesigner.NewCommonDataBindingExecute(Sender: TObject);
var
  DataBinding: TContainedBindComponent;
  LCategory: string;
begin
  if GetComponentEditor(FDataBindingList, Designer).IsInInlined then { for frames }
    raise Exception.CreateRes(@SCantAddToAncestor);

  SelectNone(False);
  LCategory := FCategory;
  if FCategoryKind = TCategoryKind.ckAll then
    LCategory := CategoryOfClass(CommonDataBindingClass);
  DataBinding := CreateBindComponent(Designer.GetRoot, CommonDataBindingClass) as TContainedBindComponent;

  DoNewDataBinding(LCategory, DataBinding);
  FocusDataBinding(DataBinding);//!
end;

procedure TDataBindingListDesigner.MoveUpUpdate(Sender: TObject);
begin 
  inherited;
  (Sender as TCustomAction).Enabled := (ListView1.SelCount > 0) and (ListView1.Items.Count > 1) {and
    (ListView1.Selected.Index > 0)};
end;

procedure TDataBindingListDesigner.MoveDownUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TCustomAction).Enabled := (ListView1.SelCount > 0) and (ListView1.Items.Count > 1){and
    (ListView1.Selected.Index < ListView1.Items.Count - 1)};
end;

procedure TDataBindingListDesigner.ListView1Resize(Sender: TObject);
begin
  ListView1.Columns.BeginUpdate;
  try
    // ListView1.Columns[0].Width := ListView1.ClientWidth - 1;
  finally
    ListView1.Columns.EndUpdate;
  end;
end;

{ TNewDataBindingDialog }

constructor TExecuteNewDataBinding.Create(ABindingsList:
  TCustomBindingsList; ADesigner: IDesigner);
begin
  FBindingsList := ABindingsList;
  FDesigner := ADesigner;
end;

destructor TExecuteNewDataBinding.Destroy;
begin

  inherited;
end;

function TExecuteNewDataBinding.Execute(ABeforeCreate: TProc;
  ACreated: TProc<string, TContainedBindComponent>; AAfterCreate: TProc;
  AAllowClass: TFunc<TContainedBindCompClass, Boolean> ): Boolean;
var
  I: Integer;
  LDataBindingClass: TContainedBindCompClass;
//  LClass: TPersistentClass;
  LCategory: string;
  LBindComp: TContainedBindComponent;
begin
  if GetComponentEditor(FBindingsList, FDesigner).IsInInlined then { for Frames }
    raise Exception.CreateRes(@SCantAddToAncestor);
  with TNewStdDataBindingDlg.Create(Application) do
  try
    AllowClass := AAllowClass;
    DesignerIntf := Self.FDesigner;
    Result := ShowModal = mrOk;
    if Result then
    begin
      ABeforeCreate;
      //SelectNone(False);
      for I := 0 to ActionTree.Items.Count - 1 do
        if ActionTree.Items[I].Selected and Assigned(ActionTree.Items[I].Data) then
        begin
          LDataBindingClass := TContainedBindCompClass(ActionTree.Items[I].Data);
          if LDataBindingClass <> nil then
          begin
            LCategory := ActionTree.Items[I].Parent.Text{ SubItems[0]};
            if AnsiCompareText(LCategory, SDataBindingCategoryNone) = 0 then LCategory := '';
            LBindComp := CreateBindComponent(Self.FDesigner.GetRoot,
              LDataBindingClass) as TContainedBindComponent;
            ACreated(LCategory, LBindComp);
          end;
        end;
      AAfterCreate;
    end;
  finally
    Free;
  end;
end;

{ TExecuteNewDataBindingWizard }

constructor TExecuteNewDataBindingWizard.Create(
  AContext: IBindCompFactoryExecuteContext);
begin
  FBindingsList := AContext.BindingsList;
  FDesigner := AContext.Designer as IDesigner;
  FComponentContext := AContext.ControlComponent;
  // Ignore some contexts
  if FComponentContext = FDesigner.Root then
    FComponentContext := nil;
  if FComponentContext is TCustomBindingsList then
    FComponentContext := nil;
end;

constructor TExecuteNewDataBindingWizard.Create(ABindingsList: TCustomBindingsList;
  ADesigner: IDesigner);
begin
  FBindingsList := ABindingsList;
  FDesigner := ADesigner;
end;

destructor TExecuteNewDataBindingWizard.Destroy;
begin

  inherited;
end;

function TExecuteNewDataBindingWizard.Execute(ABeforeCreate: TProc;
  ACreated: TProc<string, TContainedBindComponent, TComponent>; AAfterCreate: TProc;
  AAllowClass: TFunc<TContainedBindCompClass, Boolean> ): Boolean;
var
  LBindComp: TContainedBindComponent;
  LUIModule: TBindCompWizardUIModule;
  LFinished: Boolean;
  LNewControl: TComponent;
begin
  LFinished := False;
  if GetComponentEditor(FBindingsList, FDesigner).IsInInlined then { for Frames }
    raise Exception.CreateRes(@SCantAddToAncestor);
  LUIModule := TBindCompWizardUIModule.Create(nil);
                           
  try
    LUIModule.Designer := FDesigner;
    LUIModule.ComponentContext := FComponentContext;
                                                                                          
    LUIModule.ExecuteWizard(
      procedure
      var
        LFactory: TBindCompWizardFactory;
      begin
        LFinished := True;
        //SelectNone(False);
        LFactory := LUIModule.Factory;
        Assert(LFactory <> nil);
        if LFactory <> nil then
        begin
          ABeforeCreate;
          LBindComp := LFactory.CreateComponent(LNewControl);
          ACreated(LFactory.Category, LBindComp, LNewControl);
          AAfterCreate;
        end;
      end);
  finally
    LUIModule.Free;
  end;
  Result := LFinished;
end;


{ TControlFactory }

constructor TControlFactory.Create(ADesigner: IDesigner);
begin
  FDesigner := ADesigner;
end;

{ TBindScopeManager }

function TNewBindScopeManager.AddField: string;
begin
  Result := '';
end;

function TNewBindScopeManager.CanAddFields: Boolean;
begin
  Result := False;
end;

function TNewBindScopeManager.CanRemoveField(const AFieldName: string): Boolean;
begin
  Result := False;
end;

function TNewBindScopeManager.CreateFrame(AOwner: TComponent): TWizardFrame;
begin
  Result := nil;
end;

function TNewBindScopeManager.GetFrame: TWizardFrame;
begin
  Result := nil;
end;

function TNewBindScopeManager.RemoveField(const AFieldName: string): Boolean;
begin
  Result := False;
end;

function TControlFactory.GetEnabled: Boolean;
begin
  Result := True;
end;

{ TBindScopeFactory }

function TBindScopeFactory.BindScopeTitle: string;
begin
  Result := BindScopeClass.ClassName;
end;

function TBindScopeFactory.CanCreate: Boolean;
begin
  Result := Enabled;
end;

function TBindScopeFactory.CanEdit: Boolean;
begin
  Result := Enabled;
end;

initialization
  BindCompEdit.NotifyDataBindingListChange := NotifyDataBindingListChangeImpl;

finalization
  BindCompEdit.NotifyDataBindingListChange := nil;
  FreeAndNil(DesignersList);
  FreeAndNil(ControlFrameFactoriesList);

end.

