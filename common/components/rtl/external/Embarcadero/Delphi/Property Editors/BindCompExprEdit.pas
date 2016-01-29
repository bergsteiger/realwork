{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompExprEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, DesignWindows,
  Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdActns, DesignIntf, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnList,
  Vcl.ImgList, ToolWnds, Vcl.ActnPopup, Vcl.PlatformDefaultStyleActnCtrls,
  Data.Bind.Components, System.Generics.Collections, System.Bindings.EvalProtocol,
  BindCompExprVis, System.Actions;

const
  AM_DeferUpdate = WM_USER + 100;  // avoids break-before-make listview ugliness

type

  TExpressionOrder = (eorOutputValue, eorValueOutput, eorControlSource);

  TSelectedState = record
  private
    FSelectedCollectionIsLeaf: Boolean;
    FSelectedCollection: TCollection;
    FSelectedCollectionItem: TCollectionItem;
    FSelectedExpressionCollectionItem: TCollectionItem;
    FSelectedCollectionOwnerItem: TCollectionItem;
    procedure Validate;
  end;

  TBindCompExprDesigner = class(TToolbarDesignWindow)
    ImageList1: TImageList;
    NewDataBindingsPopup: TPopupMenu;
    PanelTop: TPanel;
    ListView1: TListView;
    PanelExpressionsLabel: TPanel;
    Label2: TLabel;
    DescriptionsAction: TAction;
    PanelDescriptions1: TMenuItem;
    MemosPanel: TPanel;
    MemoControl: TMemo;
    MemoSource: TMemo;
    ButtonEvalControl: TButton;
    ButtonAssignToControl: TButton;
    ButtonEvalSource: TButton;
    LabelSourceScope: TLabel;
    actEvalControl: TAction;
    actApplyControl: TAction;
    actAssignToControl: TAction;
    actEvalSource: TAction;
    actApplySource: TAction;
    MoveCollectionUpCmd: TAction;
    MoveCollectionDownCmd: TAction;
    AddCollectionCmd: TAction;
    DeleteCollectionCmd: TAction;
    ToolButtonMoveSep: TToolButton;
    ToolBarSource: TToolBar;
    ToolButtonApplyValue: TToolButton;
    actCancelSource: TAction;
    actCancelControl: TAction;
    ToolBar4: TToolBar;
    ToolButtonApplyOutput: TToolButton;
    LabelControlScope: TLabel;
    PanelExpressions: TPanel;
    AddExprCmd: TAction;
    DeleteExprCmd: TAction;
    MoveExprUpCmd: TAction;
    MoveExprDownCmd: TAction;
    PanelCollections: TPanel;
    ListBoxCollections: TListBox;
    PanelCollectionsLabel: TPanel;
    Label3: TLabel;
    Splitter5: TSplitter;
    TreeViewCollections: TTreeView;
    actCut: TAction;
    actCopy: TAction;
    actDelete: TAction;
    actPaste: TAction;
    actAddItem: TAction;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Delete1: TMenuItem;
    Paste1: TMenuItem;
    Add1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ButtonAssignToSource: TButton;
    actAssignToSource: TAction;
    PanelExpressionsAndEditors: TPanel;
    actMultilineExpr: TAction;
    Multiline1: TMenuItem;
    procedure ListView1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure SelectedUpdate(Sender: TObject);
    procedure ListView1KeyPress(Sender: TObject; var Key: Char);
    procedure ListView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DescriptionsActionExecute(Sender: TObject);
    procedure ListView1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure ListView1Resize(Sender: TObject);
    procedure actEvalSourceUpdate(Sender: TObject);
    procedure actEvalSourceExecute(Sender: TObject);
    procedure actEvalControlExecute(Sender: TObject);
    procedure actEvalControlUpdate(Sender: TObject);
    procedure actApplySourceExecute(Sender: TObject);
    procedure actApplySourceUpdate(Sender: TObject);
    procedure actApplyControlExecute(Sender: TObject);
    procedure actApplyControlUpdate(Sender: TObject);
    procedure actAssignToControlExecute(Sender: TObject);
    procedure actAssignToControlUpdate(Sender: TObject);
    procedure actCancelSourceExecute(Sender: TObject);
    procedure actCancelSourceUpdate(Sender: TObject);
    procedure actCancelControlExecute(Sender: TObject);
    procedure actCancelControlUpdate(Sender: TObject);
    procedure MemoControlKeyPress(Sender: TObject; var Key: Char);
    procedure MemoControlKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoSourceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoSourceKeyPress(Sender: TObject; var Key: Char);
    procedure AddClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure SelectAll(DoUpdate: Boolean);
    procedure SelectAllCommandUpdate(Sender: TObject);
    procedure CollectionItemSelectionUpdate(Sender: TObject);
    procedure MoveDownClick(Sender: TObject);
    procedure MoveUpClick(Sender: TObject);
    procedure AddExprCmdUpdate(Sender: TObject);
    procedure ListBoxCollectionsClick(Sender: TObject);
    procedure TreeViewCollectionsClick(Sender: TObject);
    procedure AddCollectionCmdExecute(Sender: TObject);
    procedure AddCollectionCmdUpdate(Sender: TObject);
    procedure DeleteCollectionCmdExecute(Sender: TObject);
    procedure MoveCollectionUpCmdExecute(Sender: TObject);
    procedure MoveCollectionUpCmdUpdate(Sender: TObject);
    procedure MoveCollectionDownCmdExecute(Sender: TObject);
    procedure MoveCollectionDownCmdUpdate(Sender: TObject);
    procedure DeleteCollectionCmdUpdate(Sender: TObject);
    procedure actAddItemExecute(Sender: TObject);
    procedure actAddItemUpdate(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actCutExecute(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actAssignToSourceExecute(Sender: TObject);
    procedure actAssignToSourceUpdate(Sender: TObject);
    procedure actMultilineExprExecute(Sender: TObject);
    procedure actMultilineExprUpdate(Sender: TObject);
    procedure MemoControlChange(Sender: TObject);
    procedure MemoSourceChange(Sender: TObject);
  private
    FExpressionOrder: TExpressionOrder;
    FExpressions: TArray<TBindCompDesignExpression>;
    FExpressionTypes: TBindCompDesignerExpressionTypes;
    FExpressionCollections: TArray<TBindCompDesignExpressionCollection>;
    FExpressionDictionary: TDictionary<TListItem, TBindCompDesignExpression>;
    FEditingExpression: TBindCompDesignExpression;
    FEditing: Boolean;
    FStateLock: Integer;
    FSelectionError: Boolean;
    FUpdateCount: Integer;
    FEditCollectionCount: Integer;
    FDragObject: TDragObject;
    FAddedItemIDList: TList;
    FSingleLineHeight: Integer;
    FMultiLineHeight: Integer;
    FShowListBox: Boolean;
    FShowTreeView: Boolean;
    FVisualizer: TBindCompExprVisualizer;
    FMultilineExpressions: Boolean;
    function GetRegKey: string;
    procedure AMDeferUpdate(var Msg); message AM_DeferUpdate;
    function GetDescriptionsVisible: Boolean;
    procedure SetDescriptionsVisible(Value: Boolean);
    procedure UpdateCaption;
    procedure ListExpressions(AUpdateColumns: Boolean);
    procedure GetBindCompExpressions;
    procedure LoadSizes;
    procedure DisplayExpressionText;
    procedure DisplayValue(const AScope, AExpression: string; AValue: IValue);
    function IsMemoControlModified(AExpression: TBindCompDesignExpression): Boolean;
    function IsMemoSourceModified(AExpression: TBindCompDesignExpression): Boolean;
    procedure SaveSizes;
    function TryGetSelectedExpression(
      var LExpression: TBindCompDesignExpression): Boolean;
    function SelectFirstExpression: Boolean;
    procedure SaveExpressions(AExpression: TBindCompDesignExpression); overload;
    procedure SaveControlExpression(AExpression: TBindCompDesignExpression); overload;
    procedure SaveSourceExpression(AExpression: TBindCompDesignExpression); overload;
    procedure CancelControlEdit;
    procedure CancelValueEdit;
    procedure SelectNone(DoUpdate: Boolean);
    procedure GetSelection;
    procedure BeginEditCollection;
    procedure EndEditCollection;
    procedure ListCollections(AUpdateColumns: Boolean);
    procedure SaveMemoEdits;
    function GetCollectionName(ACollection: TCollection; out AIsIndex: Boolean): string;
    function SelectFirstCollection: Boolean;
    procedure ListCollectionsTree(AUpdateColumns: Boolean);
    function SelectCollectionItem(ACollectionItem: TCollectionItem): Boolean;
    procedure DeleteExpression(AConfirmDelete: Boolean = False);
    procedure DeleteCollectionItem(AConfirmDelete: Boolean = False);
    procedure MoveExpressionUp;
    procedure MoveExpressionDown;
    procedure MoveCollectionItemDown;
    procedure MoveCollectionItemUp;
    function GetSelectedState: TSelectedState;
    function SelectTreeViewData(AData: Pointer): Boolean;
    function GetCollectionItemName(ACollectionItem: TCollectionItem;
      out AIsIndex: Boolean): string;
    procedure AddCollectionItem(ACollection: TCollection);
    procedure HideShowControls;
    procedure Copy;
    procedure Cut;
    procedure Delete(AConfirmDelete: Boolean = False);
    procedure Paste;
    function CopyCollectionItem: Boolean;
    function CopyExpression: Boolean;
    procedure PasteCollectionItem;
    procedure PasteExpression;
    procedure AddExpression;
    function GetCollectionType(
      ACollection: TCollection): TBindCompDesignerCollectionType;
    function CanSaveControlExpression(AExpression: TBindCompDesignExpression): Boolean;
    function CanSaveSourceExpression(AExpression: TBindCompDesignExpression): Boolean;
    function IsReadOnly(AExpression: TBindCompDesignExpression): Boolean; overload;
    function IsReadOnly(AItem: TCollectionItem): Boolean; overload;
    function IsReadOnly(ACollection: TCollection): Boolean; overload;
    function CanAddExpression: Boolean;
    procedure LoadVisSizes;
    procedure SetMultilineExpressions(const Value: Boolean);
  protected
    procedure BeginUpdate;
    procedure EndUpdate;
    function SelectExpression(const ACollectionName, AExpressionName: string): Boolean;
    function IndexOfDataBinding(DataBinding: TContainedBindComponent): Integer;
    procedure Activated; override;
    procedure LockState;
    procedure UnlockState;
    property StateLock: Integer read FStateLock;
    property DescriptionsVisible: Boolean read GetDescriptionsVisible write SetDescriptionsVisible;
    property MultilineExpressions: Boolean read FMultilineExpressions write SetMultilineExpressions;
  public
    FBindComp: TContainedBindComponent;
    FBindCompDesigner: IBindCompDesigner;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent); override;
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean); override;
    procedure ItemsModified(const ADesigner: IDesigner); override;
    function GetItemName(Index, ItemIndex: Integer): string;
    procedure SelectionChanged(const Designer: IDesigner;
      const ASelection: IDesignerSelections); override;
    procedure SetSelection;
    procedure UpdateView(AUpdateColumns: Boolean = False);
  end;


  TBindCompExprDesignerClass = class of TBindCompExprDesigner;


procedure ShowBindCompExprDesigner(const ADesigner: IDesigner;
  ABindComp: TContainedBindComponent);

function ShowBindCompExpDesignerClass(const ADesigner: IDesigner;
  DesignerClass: TBindCompExprDesignerClass; ABindComp: TContainedBindComponent): TBindCompExprDesigner;

var
  DesignersList: TList = nil;


implementation

{$R *.dfm}

uses System.Win.Registry, System.TypInfo, Winapi.CommCtrl, StdConst, DsnConst,
  DesignEditors, VCLEditors, BindCompDrag, BindCompDsnResStrs, BindCompNewStd,
  Vcl.Dialogs, DesignConst, System.UITypes;

type
//  TCollectionItemState = class;
  TItemState = class;
//  TItemStateClass = class of TItemState;

  TTreeViewState = class
  private
    FItemKeys: TDictionary<TArray<string>, TItemState>;
  strict private
    FTreeFiles: TTreeView;
    FFirstVisible: TItemState;
    FFocused: TItemState;
    procedure SaveState;
  private
    function SaveItemState(Node: TTreeNode): TItemState;
    function FindNode(AKey: TArray<string>): TTreeNode;
    function GetTreeNodePath(ANode: TTreeNode): TArray<string>;
    function FindNode2(ANode: TTreeNode; AKey: TArray<string>;
      ALevel: Integer): TTreeNode;
  public
    constructor Create(ATree: TTreeView);
    destructor Destroy; override;
    procedure RestoreSelection;
    procedure RestoreTop;
    procedure RestoreExpanded;
    property TreeFiles: TTreeView read FTreeFiles;
  end;

  TItemState = class
  strict private
    FKey: TArray<string>;
    FExpanded: Boolean;
  public
    constructor Create(Owner: TTreeViewState; ANode: TTreeNode); virtual;
    property Key: TArray<string> read FKey write FKey;
    property Expanded: Boolean read FExpanded;
  end;


function ShowBindCompExpDesignerClass(const ADesigner: IDesigner;
  DesignerClass: TBindCompExprDesignerClass;
  ABindComp: TContainedBindComponent): TBindCompExprDesigner;
var
  I: Integer;
begin
  if DesignersList = nil then
    DesignersList := TList.Create;
  for I := 0 to DesignersList.Count - 1 do
  begin
    Result := TBindCompExprDesigner(DesignersList[I]);
    with Result do
      if (Designer = ADesigner) and (FBindComp = ABindComp) then
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
    FBindComp := ABindComp;
    FBindCompDesigner := Data.Bind.Components.GetBindCompDesigner(TContainedBindCompClass(FBindComp.ClassType));
    UpdateView(True);
    SelectFirstCollection;
    if not SelectFirstExpression then
      DisplayExpressionText;
    UpdateCaption;
    Show;
  except
    Free;
  end;
end;

procedure ShowBindCompExprDesigner(const ADesigner: IDesigner;
 ABindComp: TContainedBindComponent);
begin
  ShowBindCompExpDesignerClass(ADesigner, TBindCompExprDesigner, ABindComp);
end;

{ TBindCompExprDesigner }

procedure TBindCompExprDesigner.TreeViewCollectionsClick(Sender: TObject);
begin
  if not FShowTreeView then
    Exit;
  SaveMemoEdits;
  ListExpressions(False);
  if not  SelectFirstExpression then
    DisplayExpressionText;
  SetSelection;
end;

function TBindCompExprDesigner.GetSelectedState: TSelectedState;
var
  LNode: TTreeNode;
  LObject: TObject;
  LIndex: Integer;
begin
  Result.FSelectedCollectionIsLeaf := True;
  Result.FSelectedCollection := nil;
  Result.FSelectedCollectionItem := nil;
  Result.FSelectedExpressionCollectionItem := nil;
  Result.FSelectedCollectionOwnerItem := nil;
  if FShowTreeView then
  begin
    Result.FSelectedCollectionIsLeaf := False;
    LNode := TreeViewCollections.Selected;
    if LNode <> nil then
    begin
      LObject := TObject(LNode.Data);
      if LObject <> nil then
      begin
        if LObject is TCollection then
        begin
          Result.FSelectedCollection := TCollection(LObject);
          //if LNode.getFirstChild = nil then
            Result.FSelectedCollectionIsLeaf :=
              GetCollectionType(Result.FSelectedCollection) = colExpressions;
        end
        else if LObject is TCollectionItem then
        begin
          Result.FSelectedCollectionItem := TCollectionItem(LObject);
          Result.FSelectedCollection := Result.FSelectedCollectionItem.Collection;
        end;
      end;
    end;
  end;
  if FShowListBox then
  begin
    LIndex := ListBoxCollections.ItemIndex;
    if LIndex <> -1 then
      Result.FSelectedCollection := TCollection(ListBoxCollections.Items.Objects[LIndex]);
  end
  else if Length(FExpressionCollections) = 1 then
    Result.FSelectedCollection := FExpressionCollections[0].Collection;
  if ListView1.Selected <> nil then
  begin
    Result.FSelectedExpressionCollectionItem := TCollectionItem(ListView1.Selected.Data);
  end;
  if Result.FSelectedCollection <> nil then
  begin
    if Result.FSelectedCollection.Owner is TCollectionItem then
      Result.FSelectedCollectionOwnerItem := TCollectionItem(Result.FSelectedCollection.Owner);
  end;

  Result.Validate;
end;


function TBindCompExprDesigner.TryGetSelectedExpression(var LExpression: TBindCompDesignExpression): Boolean;
var
  LItem: TListItem;
//  I: Integer;
begin
  LItem := ListView1.Selected;
  if LItem <> nil then
    Result := FExpressionDictionary.TryGetValue(LItem, LExpression)
  else
    Result := False;
end;


procedure TBindCompExprDesigner.actEvalSourceExecute(Sender: TObject);
begin
  if FEditing then
  begin
    if Assigned(FEditingExpression.ExecuteSourceProc) then
    begin
      try
        FEditingExpression.ExecuteSourceProc(FEditingExpression.Name, MemoSource.Text,
        procedure(AValue: IValue)
        begin
          DisplayValue(FEditingExpression.SourceScope, MemoSource.Text, AValue);
        end);
      except
        on E: Exception do
        begin
          MessageDlg(E.Message, TMsgDlgType.mtError, [mbOK], 0);
        end;
      end;
    end;
  end;
end;

procedure TBindCompExprDesigner.actEvalSourceUpdate(Sender: TObject);
begin
  if FEditing then
  begin
    if Assigned(FEditingExpression.ExecuteSourceProc) then
    begin
      TAction(Sender).Enabled := True;
      Exit;
    end;
  end;
  TAction(Sender).Enabled := False;
end;

procedure TBindCompExprDesigner.actApplySourceExecute(Sender: TObject);
begin
  if FEditing then
  begin
    SaveSourceExpression(FEditingExpression);
  end;
end;

function TBindCompExprDesigner.IsMemoControlModified(AExpression: TBindCompDesignExpression): Boolean;
begin
    Result := MemoControl.Modified and
     (MemoControl.Text <> AExpression.ControlExpression);
end;

function TBindCompExprDesigner.IsMemoSourceModified(AExpression: TBindCompDesignExpression): Boolean;
begin
    Result := MemoSource.Modified and
     (MemoSource.Text <> AExpression.SourceExpression);
end;

procedure TBindCompExprDesigner.actApplySourceUpdate(Sender: TObject);
begin
  begin
    if CanSaveSourceExpression(FEditingExpression) and IsMemoSourceModified(FEditingExpression) then
    begin
      TAction(Sender).Enabled := True;
      Exit;
    end;
  end;
  TAction(Sender).Enabled := False;
end;

procedure TBindCompExprDesigner.actAssignToControlExecute(Sender: TObject);
begin
  if FEditing then
  begin
    if Assigned(FEditingExpression.ExecuteAssignToControlProc) then
    begin
      try
        FEditingExpression.ExecuteAssignToControlProc(FEditingExpression.Name,
        Trim(MemoControl.Text), Trim(MemoSource.Text),
        procedure(AValue: IValue)
        begin
          DisplayValue(FEditingExpression.ControlScope, MemoControl.Text, AValue);
        end);
      except
        on E: Exception do
        begin
          MessageDlg(E.Message, TMsgDlgType.mtError, [mbOK], 0);
        end;
      end;
    end;
  end;

end;

procedure TBindCompExprDesigner.actAssignToControlUpdate(Sender: TObject);
begin
  if FEditing then
  begin
    if Assigned(FEditingExpression.ExecuteAssignToControlProc)
    and
      (FEditingExpression.ExpressionType <> exprControlToSource)
        then
    begin
      TAction(Sender).Enabled := True;
      Exit;
    end;
  end;
  TAction(Sender).Enabled := False;
end;

procedure TBindCompExprDesigner.CancelControlEdit;
begin
  if FEditing then
  begin
    MemoControl.Text := FEditingExpression.ControlExpression;
  end;
end;

procedure TBindCompExprDesigner.CancelValueEdit;
begin
  if FEditing then
  begin
    MemoSource.Text := FEditingExpression.SourceExpression;
  end;
end;

procedure TBindCompExprDesigner.actCancelControlExecute(Sender: TObject);
begin
  CancelControlEdit
end;

procedure TBindCompExprDesigner.actCancelControlUpdate(Sender: TObject);
begin
  if FEditing then
  begin
    if IsMemoControlModified(FEditingExpression) then
    begin
      TAction(Sender).Enabled := True;
      Exit;
    end;
  end;
  TAction(Sender).Enabled := False;
end;

procedure TBindCompExprDesigner.actCancelSourceExecute(Sender: TObject);
begin
  CancelValueEdit;
end;

procedure TBindCompExprDesigner.actCancelSourceUpdate(Sender: TObject);
begin
  if FEditing then
  begin
    if IsMemoSourceModified(FEditingExpression) then
    begin
      TAction(Sender).Enabled := True;
      Exit;
    end;
  end;
  TAction(Sender).Enabled := False;
end;

function TBindCompExprDesigner.IsReadOnly(AExpression: TBindCompDesignExpression): Boolean;
begin
  Result := Assigned(FBindCompDesigner) and
    FBindCompDesigner.IsReadOnly(FBindComp, AExpression);
end;

function TBindCompExprDesigner.IsReadOnly(AItem: TCollectionItem): Boolean;
begin
  Result := Assigned(FBindCompDesigner) and
    FBindCompDesigner.IsReadOnly(FBindComp, AItem);
end;

function TBindCompExprDesigner.IsReadOnly(ACollection: TCollection): Boolean;
begin
  Result := Assigned(FBindCompDesigner) and
    FBindCompDesigner.IsReadOnly(FBindComp, ACollection);
end;

function TBindCompExprDesigner.CanSaveControlExpression(AExpression: TBindCompDesignExpression): Boolean;
begin
  Result := not IsReadOnly(AExpression) and Assigned(AExpression.SaveControlProc);

end;


function TBindCompExprDesigner.CanSaveSourceExpression(AExpression: TBindCompDesignExpression): Boolean;
begin
  Result :=  not IsReadOnly(AExpression) and Assigned(AExpression.SaveSourceProc);
end;


procedure TBindCompExprDesigner.SaveExpressions(AExpression: TBindCompDesignExpression);
var
  LModified: Boolean;
begin
  LModified := False;
  if IsMemoControlModified(FEditingExpression) and CanSaveControlExpression(FEditingExpression) then
  begin
    MemoControl.Modified := False;
    AExpression.SaveControlProc(AExpression.Name, Trim(MemoControl.Text));
    LModified := True;
  end;
  if IsMemoSourceModified(FEditingExpression) and CanSaveSourceExpression(FEditingExpression) then
  begin
    MemoSource.Modified := False;
    AExpression.SaveSourceProc(AExpression.Name, Trim(MemoSource.Text));
    LModified := True;
  end;
  if LModified then
    Designer.Modified;
end;

procedure TBindCompExprDesigner.SaveControlExpression(AExpression: TBindCompDesignExpression);
begin
  if IsMemoControlModified(FEditingExpression) and CanSaveControlExpression(FEditingExpression) then
  begin
    AExpression.SaveControlProc(AExpression.Name, Trim(MemoControl.Text));
    MemoControl.Modified := False;
    Designer.Modified;
  end;
end;

procedure TBindCompExprDesigner.SaveSourceExpression(AExpression: TBindCompDesignExpression);
begin
  if IsMemoSourceModified(FEditingExpression) and CanSaveSourceExpression(FEditingExpression) then
  begin
    AExpression.SaveSourceProc(AExpression.Name, Trim(MemoSource.Text));
    MemoSource.Modified := False;
    Designer.Modified;
  end;
end;

procedure TBindCompExprDesigner.actAddItemExecute(Sender: TObject);
begin
  if ListView1.Focused then
    AddExpression
  else if TreeViewCollections.Focused or ListBoxCollections.Focused then
    AddCollectionItem(GetSelectedState.FSelectedCollection);
end;

procedure TBindCompExprDesigner.actAddItemUpdate(Sender: TObject);
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  if ListView1.Focused then
    TAction(Sender).Enabled := CanAddExpression
  else if TreeViewCollections.Focused or ListBoxCollections.Focused then
    TAction(Sender).Enabled := not IsReadOnly(GetSelectedState.FSelectedCollection)
  else
    TAction(Sender).Enabled := False;
 end;

procedure TBindCompExprDesigner.actApplyControlExecute(Sender: TObject);
begin
  if FEditing then
    SaveControlExpression(FEditingExpression);

end;

procedure TBindCompExprDesigner.actApplyControlUpdate(Sender: TObject);
begin
  if FEditing then
  begin
    if CanSaveControlExpression(FEditingExpression) and IsMemoControlModified(FEditingExpression) then
    begin
      TAction(Sender).Enabled := True;
      Exit;
    end;
  end;
  TAction(Sender).Enabled := False;
end;

procedure TBindCompExprDesigner.actEvalControlExecute(Sender: TObject);
begin
  if FEditing then
  begin
    try
      FEditingExpression.ExecuteControlProc(FEditingExpression.Name, MemoControl.Text,
      procedure(AValue: IValue)
      begin
        DisplayValue(FEditingExpression.ControlScope, MemoControl.Text, AValue);
      end);
    except
      On E: Exception do
      begin
        MessageDlg(E.Message, TMsgDlgType.mtError, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TBindCompExprDesigner.actEvalControlUpdate(Sender: TObject);
begin
  if FEditing then
  begin
    if Assigned(FEditingExpression.ExecuteControlProc) then
    begin
      TAction(Sender).Enabled := True;
      Exit;
    end;
  end;
  TAction(Sender).Enabled := False;
end;

procedure TBindCompExprDesigner.Activated;
begin
  Designer.Activate;
  SetSelection;
end;

procedure TBindCompExprDesigner.actMultilineExprExecute(Sender: TObject);
begin
  with actMultilineExpr do
  begin
    Checked := not Checked;
    MultilineExpressions := Checked;
  end;
end;

procedure TBindCompExprDesigner.actMultilineExprUpdate(Sender: TObject);
begin
  with actMultilineExpr do
    Checked := MultilineExpressions;

end;

procedure TBindCompExprDesigner.actPasteExecute(Sender: TObject);
begin
  Paste;

end;

procedure TBindCompExprDesigner.actAssignToSourceExecute(Sender: TObject);
begin
  if FEditing then
  begin
    if Assigned(FEditingExpression.ExecuteAssignToSourceProc) then
    begin
      try
        FEditingExpression.ExecuteAssignToSourceProc(FEditingExpression.Name,
          Trim(MemoControl.Text), Trim(MemoSource.Text),
        procedure(AValue: IValue)
        begin
          DisplayValue(FEditingExpression.SourceScope, MemoSource.Text, AValue);
        end);
      except
        on E: Exception do
        begin
          MessageDlg(E.Message, TMsgDlgType.mtError, [mbOK], 0);
        end;
      end;
    end;
  end;

end;

procedure TBindCompExprDesigner.actAssignToSourceUpdate(Sender: TObject);
begin
  if FEditing then
  begin
    if Assigned(FEditingExpression.ExecuteAssignToSourceProc)
     and  (FEditingExpression.ExpressionType <> exprSourceToControl)
        then
    begin
      TAction(Sender).Enabled := True;
      Exit;
    end;
  end;
  TAction(Sender).Enabled := False;
end;

procedure TBindCompExprDesigner.ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
begin
  if AItem = FBindComp then
  begin
    FBindComp := nil;  // Component is already in its destructor; component is gone
    FBindCompDesigner := nil;
    Close;
  end
end;

procedure TBindCompExprDesigner.DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = ADesigner then
  begin
    FBindComp := nil;
    FBindCompDesigner := nil;
    Close;
  end;
end;

destructor TBindCompExprDesigner.Destroy;
begin
  FExpressionDictionary.Free;
  FVisualizer.Free;
  inherited;
end;

function TBindCompExprDesigner.SelectFirstExpression: Boolean;
begin
  if ListView1.Items.Count > 0 then
  begin
    ListView1.Selected := ListView1.Items[0];
    DisplayExpressionText;
  end;
  Result := ListView1.Selected <> nil;

end;


function TBindCompExprDesigner.SelectFirstCollection: Boolean;
begin
  Result := False;
  if FShowListBox then
    if ListBoxCollections.Count > 1 then
    begin
      // Select first after "All Collections"
      ListBoxCollections.ItemIndex := 1;
      ListExpressions(False);
      Result := True;
    end;

  if FShowTreeView then
    if TreeViewCollections.Items.Count > 1 then
    begin
      // Select first after "All Collections"
      TreeViewCollections.Items[1].Selected := True;
      ListExpressions(False);
      Result := True;
    end;

end;

function TBindCompExprDesigner.SelectExpression(const ACollectionName, AExpressionName: string): Boolean;
var
  I: Integer;
  LExpression: TBindCompDesignExpression;
begin
  if AExpressionName <> '' then
  begin
    for I := 0 to ListView1.Items.Count - 1 do
    begin
      if FExpressionDictionary.TryGetValue(ListView1.Items[I], LExpression) and
        (LExpression.Name = AExpressionName) and (LExpression.CollectionName = ACollectionName) then
      begin
        LockState;
        try
          with ListView1.Items[I] do
          begin
            Selected := True;
            MakeVisible(False);
            DisplayExpressionText;
          end;
        finally
          UnLockState;
        end;
        Exit(True);
      end;
    end;
  end;
  Result := False;
end;

procedure TBindCompExprDesigner.ItemsModified(const ADesigner: IDesigner);
var
  LExpression: TBindCompDesignExpression;
  LHaveExpression: Boolean;
begin
  if (FBindComp <> nil) and (FUpdateCount = 0) then
  begin
    LHaveExpression := (FEditCollectionCount = 0) and TryGetSelectedExpression(LExpression);
    GetBindCompExpressions;
    ListView1.Items.BeginUpdate;
    try
      UpdateView;
      if Designer <> ADesigner then Exit;
      if LHaveExpression then
      begin
        if not SelectExpression(LExpression.CollectionName, LExpression.Name) then
          if not SelectFirstExpression then
            DisplayExpressionText;
      end
      else
        if FEditCollectionCount = 0 then
          if not SelectFirstExpression then
            DisplayExpressionText;
    finally
      ListView1.Items.EndUpdate;
    end;
  end;
  UpdateCaption;
end;

function TBindCompExprDesigner.GetItemName(Index, ItemIndex: Integer): string;
begin
{  with TAccessCollection(Collection) do
    if GetAttrCount < 1 then
      Result := Format('%d - %s',[ItemIndex, Actions.Items[ItemIndex].DisplayName])
    else Result := GetItemAttr(Index, ItemIndex);}
end;

function TBindCompExprDesigner.GetRegKey: string;
begin
  Result := Designer.GetBaseRegKey + '\' + sIniEditorsName + '\BindCompExpress Editor';
end;

function TBindCompExprDesigner.IndexOfDataBinding(DataBinding: TContainedBindComponent): Integer;
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


procedure TBindCompExprDesigner.LockState;
begin
  Inc(FStateLock);
end;

procedure TBindCompExprDesigner.MemoControlChange(Sender: TObject);
begin
  if (not MultilineExpressions) and (Pos(#13, MemoControl.Text) > 0) then
    MultilineExpressions := True;
end;

procedure TBindCompExprDesigner.MemoControlKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  if (Key = VK_RETURN) and (not (ssCtrl in Shift)) and (not (ssCtrl in Shift)) then
//    SaveOutputExpression;
//  if Key = actApplyOutput.ShortCut then
//    if FEditing then
//      SaveOutputExpression(FEditingExpression);

end;

procedure TBindCompExprDesigner.MemoControlKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Key of
    #27:
      CancelControlEdit;
  end;
end;

procedure TBindCompExprDesigner.MemoSourceChange(Sender: TObject);
begin
  if (not MultilineExpressions) and (Pos(#13, MemoSource.Text) > 0) then
    MultilineExpressions := True;

end;

procedure TBindCompExprDesigner.MemoSourceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  if (Key = VK_RETURN) and (not (ssCtrl in Shift)) and (not (ssCtrl in Shift)) then
//    if FEditing then
//      SaveValueExpression(FEditingExpression);
end;

procedure TBindCompExprDesigner.MemoSourceKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Key of
    #27:
      CancelValueEdit;
  end;
end;

procedure TBindCompExprDesigner.SetSelection;
var
  List: IDesignerSelections;
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  List := CreateSelectionList;
  if FSelectionError then Exit;
  try
    if (TreeViewCollections.Focused) or (ListBoxCollections.Focused) or
      (LSelectedState.FSelectedExpressionCollectionItem = nil) then
    begin
      if (LSelectedState.FSelectedCollectionItem <> nil) and
          (Assigned(FBindCompDesigner) and
             not FBindCompDesigner.IsReadOnly(FBindComp, LSelectedState.FSelectedCollectionItem)) then
      begin
        List.Add(LSelectedState.FSelectedCollectionItem);
      end
      else if (LSelectedState.FSelectedCollectionOwnerItem <> nil) and
          (Assigned(FBindCompDesigner) and
             not FBindCompDesigner.IsReadOnly(FBindComp, LSelectedState.FSelectedCollectionOwnerItem)) then
        List.Add(LSelectedState.FSelectedCollectionOwnerItem)
      else
        List.Add(FBindComp);
    end
    else if (LSelectedState.FSelectedExpressionCollectionItem <> nil) and
          (Assigned(FBindCompDesigner) and
             not FBindCompDesigner.IsReadOnly(FBindComp, LSelectedState.FSelectedExpressionCollectionItem)) then
      List.Add(LSelectedState.FSelectedExpressionCollectionItem)
    else
      List.Add(FBindComp);
    if List.Count > 0  then
      Designer.SetSelections(List);
  except
    FSelectionError := True;
    Application.HandleException(ExceptObject);
    Close;
  end;
end;

procedure TBindCompExprDesigner.UnlockState;
begin
  Dec(FStateLock);
end;

procedure TBindCompExprDesigner.UpdateView(AUpdateColumns: Boolean);
begin
  GetBindCompExpressions;
  ListCollections(AUpdateColumns);
  ListCollectionsTree(AUpdateColumns);
  ListExpressions(AUpdateColumns);
  if AUpdateColumns then
  begin
    LoadSizes;
    if (not FShowListBox) and (not FShowTreeView) then
    begin
      PanelCollections.Visible := False;
      Splitter5.Visible := False;
    end;
  end;
end;

procedure TBindCompExprDesigner.SaveMemoEdits;
begin
  if FEditing then
  begin
    SaveExpressions(FEditingExpression);
  end;
end;

procedure TBindCompExprDesigner.ListView1Click(Sender: TObject);
begin
  SaveMemoEdits;
  DisplayExpressionText;
  SetSelection;
end;

procedure TBindCompExprDesigner.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  if Key = #13 then
//    Designer.ModalEdit(#0, Self);
end;

procedure TBindCompExprDesigner.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if Key = VK_PROCESSKEY then
//    Designer.ModalEdit(#0, Self);
end;

procedure TBindCompExprDesigner.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FBindComp <> nil then
  begin
    SaveMemoEdits;
    Designer.SelectComponent(FBindComp);
  end;

  SaveSizes;
  Action := caFree;
  LockState;
end;

procedure TBindCompExprDesigner.FormCreate(Sender: TObject);
begin
  FExpressionOrder := TExpressionOrder.eorControlSource;
  MemoControl.Text := '';
  MemoControl.Enabled := False;
  MemoSource.Text := '';
  MemoSource.Enabled := False;
  DesignersList.Add(Self);
  ToolBar1.HandleNeeded; //! Setting action class touches handle
  FMultilineHeight := MemoControl.Height * 3;
  FSingleLineHeight := MemoControl.Height;
end;

procedure TBindCompExprDesigner.FormDestroy(Sender: TObject);
begin
  if FAddedItemIDList <> Nil then FreeAndNil(FAddedItemIDList);
  if DesignersList <> nil then
    DesignersList.Remove(Self);
end;

procedure TBindCompExprDesigner.FormResize(Sender: TObject);
begin
{  if not ListView1.ShowColumnHeaders then
    ListView1.Column[0].Width := ListView1.ClientWidth;}
end;

procedure TBindCompExprDesigner.ListView1Change(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  Msg: TMsg;
begin
  if (FUpdateCount = 0) and (FStateLock = 0) and (Change = ctState) then
    if not PeekMessage(Msg, Handle, AM_DeferUpdate, AM_DeferUpdate, PM_NOREMOVE) then
      PostMessage(Handle, AM_DeferUpdate, 0, 0);
end;

procedure TBindCompExprDesigner.AMDeferUpdate(var Msg);
begin
  if (FUpdateCount = 0) and (FStateLock = 0)  then
  begin
    SaveMemoEdits;
    DisplayExpressionText;
    SetSelection;
  end
  else
    PostMessage(Handle, AM_DeferUpdate, 0, 0);
end;

procedure TBindCompExprDesigner.UpdateCaption;
var
  NewCaption: string;
begin
  if (FBindComp <> nil) and (FBindComp.Owner <> nil) then
    NewCaption := Format(SDataBindingListEditorCaption, [FBindComp.Owner.Name, DotSep,
    FBindComp.Name]);
  if Caption <> NewCaption then Caption := NewCaption;
end;

function TBindCompExprDesigner.GetDescriptionsVisible: Boolean;
begin
  Result := DescriptionsAction.Checked;
end;

procedure TBindCompExprDesigner.SetDescriptionsVisible(Value: Boolean);
begin
  DescriptionsAction.Checked := Value;
end;


procedure TBindCompExprDesigner.SetMultilineExpressions(const Value: Boolean);
var
  LDiff: Integer;
begin
  if FMultilineExpressions <> Value then
  begin
    FMultilineExpressions := Value;
    if MultilineExpressions then
    begin
      MemoControl.Height := FMultilineHeight;
      MemoSource.Height := FMultilineHeight;
      LDiff := (FMultilineHeight - FSingleLineHeight);
      MemoControl.WordWrap := True;
      MemoSource.WordWrap := True;
    end
    else
    begin
      MemoControl.Height := FSinglelineHeight;
      MemoSource.Height := FSinglelineHeight;
      LDiff := (FSingleLineHeight - FMultiLineHeight);
      MemoControl.WordWrap := False;
      MemoSource.WordWrap := False;
    end;
    Height := Height + (2 * LDiff);
    MemosPanel.Height := MemosPanel.Height + (2 * LDiff);
    LabelSourceScope.Top := LabelSourceScope.Top + LDiff;
    ToolbarSource.Top := ToolbarSource.Top + LDiff;
    MemoSource.Top := MemoSource.Top + LDiff;
  end;
end;

procedure TBindCompExprDesigner.SelectedUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := ListView1.SelCount > 0;
end;


procedure TBindCompExprDesigner.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TBindCompExprDesigner.EndUpdate;
begin
  Dec(FUpdateCount);
end;

procedure TBindCompExprDesigner.BeginEditCollection;
begin
  Inc(FEditCollectionCount);
end;

procedure TBindCompExprDesigner.EndEditCollection;
begin
  Dec(FEditCollectionCount);
end;

procedure TBindCompExprDesigner.SelectionChanged(const Designer: IDesigner;
  const ASelection: IDesignerSelections);
begin
end;

procedure TBindCompExprDesigner.ListView1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if CharInSet(Key, ['!'..'~']) then
  begin
    Designer.ModalEdit(Key, Self);
    Key := #0;
  end;
end;

procedure TBindCompExprDesigner.ListView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_PROCESSKEY then
    Designer.ModalEdit(#0, Self);
end;

procedure TBindCompExprDesigner.DescriptionsActionExecute(Sender: TObject);
begin
  with DescriptionsAction do
  begin
    Checked := not Checked;
    PanelExpressionsLabel.Visible := Checked;
    PanelCollectionsLabel.Visible := Checked;
  end;
end;

procedure TBindCompExprDesigner.ListView1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FDragObject := TDataBindingDragObject.Create(ListView1);
  DragObject := FDragObject;
end;

procedure TBindCompExprDesigner.ListView1DblClick(Sender: TObject);
begin
                                          
end;


procedure TBindCompExprDesigner.ListView1Resize(Sender: TObject);
begin
  ListView1.Columns.BeginUpdate;
  try
    // ListView1.Columns[0].Width := ListView1.ClientWidth - 1;
  finally
    ListView1.Columns.EndUpdate;
  end;
end;

procedure TBindCompExprDesigner.GetBindCompExpressions;
var
  LDesigner: IBindCompDesigner;
  LExpressionCollection: TBindCompDesignExpressionCollection;
begin
  LDesigner := Data.Bind.Components.GetBindCompDesigner(TContainedBindCompClass(FBindComp.ClassType));
  if LDesigner <> nil then
  begin
    FExpressions := LDesigner.GetExpressions(FBindComp, FExpressionTypes);
    FExpressionCollections := LDesigner.GetExpressionCollections(FBindComp);
  end
  else
  begin
    SetLength(FExpressions, 0);
    SetLength(FExpressionCollections, 0);
  end;
  FShowListBox := Length(FExpressionCollections) > 1;
  FShowTreeView := False;
  for LExpressionCollection in FExpressionCollections do
  begin
    if LExpressionCollection.CollectionType = colCollections then
    begin
      FShowTreeView := True;
      FShowListBox := False;
      break;
    end;
  end;
  HideShowControls;
end;

procedure TBindCompExprDesigner.HideShowControls;
begin
  ListBoxCollections.Align := alClient;
  ListBoxCollections.Visible := FShowListBox;
  TreeViewCollections.Visible := FShowTreeView;
  MoveCollectionUpCmd.Visible := FShowTreeView;
  MoveCollectionDownCmd.Visible := FShowTreeView;
  AddCollectionCmd.Visible := FShowTreeView;
  DeleteCollectionCmd.Visible := FShowTreeView;
  ToolButtonMoveSep.Visible := FShowTreeView;
end;

const
  sWidth = 'Width';
  sHeight = 'Height';
  sVisWidth = 'VisWidth';
  sVisHeight = 'VisHeight';
  sDescriptions = 'Descriptions';
  sLargeButtons = 'LargeButtons';
  sVisListWidth = 'VisListWidth';
  sToolbar = 'Toolbar';
  sValueMemoWidth = 'ValueMemoWidth';
  sPanelCollectionsWidth = 'PanelCollectionsWidth';

procedure TBindCompExprDesigner.LoadVisSizes;
var
  LSubKey: string;
begin
  LSubKey := TContainedBindComponent.ClassName;
  with TRegIniFile.Create(GetRegKey) do
  try
    FVisualizer.Width := ReadInteger(LSubKey, sVisWidth, FVisualizer.Width);
    FVisualizer.Height := ReadInteger(LSubKey, sVisHeight, FVisualizer.Height);
    FVisualizer.PanelVisualizerList.Width := ReadInteger(LSubKey, sVisListWidth,
      FVisualizer.PanelVisualizerList.Width);
  finally
    Free;
  end;
end;

procedure TBindCompExprDesigner.LoadSizes;
var
  LIndex: Integer;
  LSubKey: string;
begin
  LSubKey := TContainedBindComponent.ClassName;
  with TRegIniFile.Create(GetRegKey) do
  try
    Width := ReadInteger(LSubKey, sWidth, Width);
    Height := ReadInteger(LSubKey, sHeight, Height);
    if FVisualizer <> nil then
      LoadVisSizes;
    Height := ReadInteger(LSubKey, sHeight, Height);
    DescriptionsVisible := ReadBool(LSubKey, sDescriptions, True);
    for LIndex := 0 to ListView1.Columns.Count - 1 do
      with ListView1.Columns.Items[LIndex] do
        Width := ReadInteger(LSubKey, sWidth+IntToStr(LIndex), Width);
    PanelCollections.Width := ReadInteger(LSubKey, sPanelCollectionsWidth, PanelCollections.Width);
    Splitter1.Top := Toolbar1.Top + Toolbar1.Height;
    Toolbar1.Visible := ReadBool(LSubKey, sToolbar, True);
    Splitter1.Visible := Toolbar1.Visible;
    Toolbar1.HandleNeeded; //! Setting action class touches handle
    LargeButtons := ReadBool(LSubKey, sLargeButtons, False);
    { Load default data binding class }
  finally
    Free;
  end;
end;

procedure TBindCompExprDesigner.SaveSizes;
var
  LIndex: Integer;
  LSubKey: string;
begin
  LSubKey := TContainedBindComponent.ClassName;
  with TRegIniFile.Create(GetRegKey) do
  try
    EraseSection(LSubKey);
    WriteInteger(LSubKey, sWidth, Width);
    WriteInteger(LSubKey, sHeight, Height);
    if FVisualizer <> nil then
    begin
      WriteInteger(LSubKey, sVisWidth, FVisualizer.Width);
      WriteInteger(LSubKey, sVisHeight, FVisualizer.Height);
      WriteInteger(LSubKey, sVisListWidth, FVisualizer.PanelVisualizerList.Width);
    end;
    for LIndex := 0 to ListView1.Columns.Count - 1 do
      with ListView1.Columns.Items[LIndex] do
        WriteInteger(LSubKey, sWidth+IntToStr(LIndex), Width);
    if PanelCollections.Visible then
      WriteInteger(LSubKey, sPanelCollectionsWidth, PanelCollections.Width);
    WriteBool(LSubKey, sDescriptions, DescriptionsVisible);
    WriteBool(LSubKey, sToolbar, Toolbar1.Visible);
    WriteBool(LSubKey, sLargeButtons, LargeButtons);
  finally
    Free;
  end;
end;

procedure TBindCompExprDesigner.ListCollections(AUpdateColumns: Boolean);
var
  LCollection: TBindCompDesignExpressionCollection;
  LIndex: Integer;
begin
  if not FShowListBox then
    Exit;
  ListBoxCollections.Items.BeginUpdate;
  try
    LIndex := ListBoxCollections.ItemIndex;
    ListBoxCollections.Clear;
    for LCollection in FExpressionCollections do
    begin
      ListBoxCollections.Items.AddObject(LCollection.Name, LCollection.Collection);
    end;
    if ListBoxCollections.Count > 1 then
    begin
      ListBoxCollections.Items.Insert(0, sAllCollections);
      if LIndex >= 0 then
      begin
        if LIndex < ListBoxCollections.Count then
          ListBoxCollections.ItemIndex := LIndex;
      end
    end
  finally
    ListBoxCollections.Items.EndUpdate;
  end;
end;

function CollectionItemDisplayName(ACollectionItem: TCollectionItem): string;
begin
  Result := ACollectionItem.DisplayName;
  if Result = '' then
    Result := IntToStr(ACollectionItem.Index);
end;


procedure TBindCompExprDesigner.ListCollectionsTree(AUpdateColumns: Boolean);
  procedure AddChildCollectionItems(AParentNode: TTreeNode; ACollection: TCollection);
  var
    LExpressionCollection: TBindCompDesignExpressionCollection;
    LNode: TTreeNode;
    LList: TList<TBindCompDesignExpressionCollection>;
    LItems: TDictionary<TCollectionItem,
      TList<TBindCompDesignExpressionCollection>>;
    LItem: TPair<TCollectionItem, TList<TBindCompDesignExpressionCollection>>;
  begin
    LItems := TObjectDictionary<TCollectionItem, TList<TBindCompDesignExpressionCollection>>.Create(
      [doOwnsValues]);
    try
      for LExpressionCollection in FExpressionCollections do
      begin
        if (LExpressionCollection.ParentCollectionItem <> nil) and
        (LExpressionCollection.ParentCollectionItem.Collection = ACollection) then
        begin
          if not LItems.TryGetValue(LExpressionCollection.ParentCollectionItem,
            LList) then
          begin
            LList := TList<TBindCompDesignExpressionCollection>.Create;
            LItems.Add(LExpressionCollection.ParentCollectionItem, LList);
          end;
          LList.Add(LExpressionCollection);


        end;
      end;
      for LItem in LItems do
      begin
        begin
          LNode := TreeViewCollections.Items.AddChildObject(AParentNode,
            CollectionItemDisplayName(LItem.Key),
            LItem.Key);
          for LExpressionCollection in LItem.Value do
          begin
            TreeViewCollections.Items.AddChildObject(LNode,
              LExpressionCollection.Name,
              LExpressionCollection.Collection);
          end;
        end;
      end;
    finally
      LItems.Free;
    end;


  end;

var
  LCollection: TBindCompDesignExpressionCollection;
  LNode: TTreeNode;
  LState: TTreeViewState;

begin
  if not FShowTreeView then
    Exit;
  LState := TTreeViewState.Create(TreeViewCollections);
  try
    TreeViewCollections.Items.BeginUpdate;
    try
      TreeViewCollections.Items.Clear;
      for LCollection in FExpressionCollections do
      begin
        if LCollection.ParentCollectionItem = nil then
        begin
          LNode := TreeViewCollections.Items.AddObject(nil, LCollection.Name,
            LCollection.Collection);
          AddChildCollectionItems(LNode, LCollection.Collection);
        end;

      end;
      if TreeViewCollections.Items.Count > 1 then
      begin
        TreeViewCollections.Items.AddFirst(nil, sAllCollections);
      end;
      LState.RestoreExpanded;
      LState.RestoreSelection;
      LState.RestoreTop;
      if TreeViewCollections.Selected = nil then
      begin
        SelectFirstCollection;
        if not SelectFirstExpression then
          DisplayExpressionText;
      end;
    finally
      TreeViewCollections.Items.EndUpdate;
    end;

  finally
    LState.Free;
  end;
end;

function FormatIndex(var AValue: string): Boolean;
var
  S: Char;
begin
  Result := False;
  for s in AValue do
    if (s >= '0') and (s <= '9') then
      Result := True
    else
    begin
      Result := False;
      break;
    end;
  if Result then
    AValue := '[' + AValue + ']';
end;


function TBindCompExprDesigner.GetCollectionName(ACollection: TCollection; out AIsIndex: Boolean): string;
var
  L: TBindCompDesignExpressionCollection;
begin
  Result := '';
  for L in FExpressionCollections do
    if L.Collection = ACollection then
    begin
      Result := L.Name;
      break;
    end;
  AIsIndex := FormatIndex(Result);
end;

function TBindCompExprDesigner.GetCollectionType(ACollection: TCollection): TBindCompDesignerCollectionType;
var
  L: TBindCompDesignExpressionCollection;
begin
  Result := colExpressions;
  for L in FExpressionCollections do
    if L.Collection = ACollection then
    begin
      Result := L.CollectionType;
      break;
    end;
end;

function TBindCompExprDesigner.GetCollectionItemName(ACollectionItem: TCollectionItem; out AIsIndex: Boolean): string;
var
  L: TBindCompDesignExpression;
begin
  Result := '';
  for L in FExpressions do
    if L.CollectionItem = ACollectionItem then
    begin
      Result := L.Name;
      break;
    end;
  if Result = '' then
    Result := CollectionItemDisplayName(ACollectionItem);
  AIsIndex := FormatIndex(Result);
end;

procedure TBindCompExprDesigner.ListExpressions(AUpdateColumns: Boolean);
var
  LSelectedState: TSelectedState;

  function  QualifiedCollectionItemName(AItem: TCollectionItem): string;
  var
    LCollection: TCollection;
    LIsIndex: Boolean;
    LName: string;
    LNeedSep: Boolean;
  begin
    Result := '';
    LNeedSep := False;
    while AItem is TCollectionItem do
    begin
      LName := GetCollectionItemName(AItem, LIsIndex);
      if LNeedSep then
        LName := LName + '.';
      LNeedSep := not LIsIndex;
      Result := LName + Result;
      if AItem = LSelectedState.FSelectedCollectionItem then
        break;
      LCollection := AItem.Collection;
      LName := GetCollectionName(LCollection, LIsIndex);
      if LNeedSep then
        LName := LName + '.';
      LNeedSep := not LIsIndex;
      Result := LName + Result;
      if LCollection = LSelectedState.FSelectedCollection then
        break;
      if LCollection.Owner is TCollectionItem then
      begin
        AItem := TCollectionItem(LCollection.Owner);
      end
      else
        AItem := nil;
    end;
  end;

  function IsChildCollectionItem(AItem: TCollectionItem; ACollection: TCollection): Boolean; overload;
  var
    LOwner: TPersistent;
  begin
    if AItem <> nil then
      if AItem.Collection = ACollection then
        Exit(True);
    LOwner := AItem.Collection.Owner;
    if LOwner is TCollectionItem then
    begin
      Result := IsChildCollectionItem(TCollectionItem(LOwner), ACollection);
    end
    else
      Result := False;
  end;

  function IsChildCollectionItem(AItem: TCollectionItem; ACollectionItem: TCollectionItem): Boolean; overload;
  var
    LOwner: TPersistent;
  begin
    if AItem <> nil then
      if AItem = ACollectionItem then
        Exit(True);
    LOwner := AItem.Collection.Owner;
    if LOwner is TCollectionItem then
    begin
      Result := IsChildCollectionItem(TCollectionItem(LOwner), ACollectionItem);
    end
    else
      Result := False;
  end;

var
  LExpression: TBindCompDesignExpression;
  J: Integer;
  LItem: TListItem;
  LCaption: string;
begin
  LSelectedState := GetSelectedState;
  ListView1.Items.BeginUpdate;
  try
    if FExpressionOrder = eorControlSource then
      if ListView1.Columns.Count = 5 then
        ListView1.Columns.Delete(4);
    ListView1.Items.Clear;
    FExpressionDictionary.Clear;
    for J := 0 to ListView1.Columns.Count  - 1 do
    begin
      if FExpressionOrder = eorOutputValue then
        case J of
          0: LCaption := sCaptionName;
          1: LCaption := sCaptionOutputScope;
          2: LCaption := sCaptionOutputExpr;
          3: LCaption := sCaptionValueScope;
          4: LCaption := sCaptionValueExpr;
        else
          LCaption := '';
        end
      else if FExpressionOrder = eorControlSource then
        case J of
          0: LCaption := sCaptionName;
          1: LCaption := sCaptionControl; //sCaptionOutputScope;
          2: LCaption := sCaptionSource; // CaptionValueScope;
          3: LCaption := sCaptionOperation; //sCaptionOutputExpr;
          4: LCaption := ''; //sCaptionValueExpr;
        else
          LCaption := '';
        end
      else
        case J of
          0: LCaption := sCaptionName;
          3: LCaption := sCaptionOutputScope;
          4: LCaption := sCaptionOutputExpr;
          1: LCaption := sCaptionValueScope;
          2: LCaption := sCaptionValueExpr;
       else
          LCaption := '';
        end;
      ListView1.Columns[J].Caption := LCaption;
    end;
    //I := 0;
    for LExpression in FExpressions do
    begin
      if LSelectedState.FSelectedCollectionItem <> nil then
      begin
        if not IsChildCollectionItem(LExpression.CollectionItem, LSelectedState.FSelectedCollectionItem) then
          continue;
      end
      else if LSelectedState.FSelectedCollection <> nil then
      begin
        if not IsChildCollectionItem(LExpression.CollectionItem, LSelectedState.FSelectedCollection) then
          continue;
      end;
      LItem := ListView1.Items.Add;
      LItem.ImageIndex := -1;
      with LItem do
      begin
        LItem.Data := LExpression.CollectionItem;
        if True then
        begin
          Caption := QualifiedCollectionItemName(LExpression.CollectionItem)
        end
        else
          Caption := LExpression.Name;
        FExpressionDictionary.Add(LItem, LExpression);
        for J := 1 to ListView1.Columns.Count  - 1 do
        begin
          if FExpressionOrder = eorOutputValue then
            case J of
              1: LCaption := LExpression.ControlScope;
              2: LCaption := LExpression.ControlExpression;
              3: LCaption := LExpression.SourceScope;
              4: LCaption := LExpression.SourceExpression;
            else
              LCaption := '';
            end
          else if FExpressionOrder = eorControlSource then
            case J of
              1: LCaption := LExpression.ControlScope + ', ' + LExpression.ControlExpression;
              2: LCaption := LExpression.SourceScope + ', ' + LExpression.SourceExpression;
              3: LCaption := ''; // LExpression.ControlExpression;
              4: LCaption := ''; //LExpression.SourceExpression;
            else
              LCaption := '';
            end
          else
            case J of
              3: LCaption := LExpression.ControlScope;
              4: LCaption := LExpression.ControlExpression;
              1: LCaption := LExpression.SourceScope;
              2: LCaption := LExpression.SourceExpression;
            else
              LCaption := '';
            end;
          if J = 3 then
            if LExpression.ExpressionType = TBindCompDesignerExpressionType.exprSourceToControl then
              LCaption := sAssignToControl
            else if LExpression.ExpressionType = TBindCompDesignerExpressionType.exprBidirectional then
              LCaption := sAssignBidirectional
            else if LExpression.ExpressionType = TBindCompDesignerExpressionType.exprControlToSource then
              LCaption := sAssignToSource
            else
              Assert(False);
            LItem.SubItems.Add(LCaption);
        end;
      end;
    end;
                             
    //if (not LHasExpressionName) and (Length(FExpressions) > 0) then
    //  ListView1.Columns[0].

  finally
    ListView1.Items.EndUpdate;
  end;
end;

procedure TBindCompExprDesigner.DisplayExpressionText;
var
  LExpression: TBindCompDesignExpression;
begin
  if TryGetSelectedExpression(LExpression) then
  begin
    FEditing := True;
    FEditingExpression := LExpression;
    LabelControlScope.Caption := Format(sControlExpressionFor, [LExpression.ControlScope]);
    LabelControlScope.Font.Color := clWindowText;
    LabelSourceScope.Caption := Format(sSourceExpressionFor, [LExpression.SourceScope]);
    LabelSourceScope.Font.Color := clWindowText;
    if not MemoControl.Modified then
      // Don't overwite if user is editing
      MemoControl.Text := LExpression.ControlExpression;
    if not MemoSource.Modified then
      MemoSource.Text := LExpression.SourceExpression;
    MemoSource.Enabled := not (Assigned(FBindCompDesigner) and
             FBindCompDesigner.IsReadOnly(FBindComp, LExpression));
    MemoControl.Enabled := MemoSource.Enabled;
  end
  else
  begin
    FEditing := False;
    LabelControlScope.Caption := sControlExpression;
    LabelControlScope.Font.Color := clGrayText;
    LabelSourceScope.Caption := sSourceExpression;
    LabelSourceScope.Font.Color := clGrayText;
    MemoControl.Text := '';
    MemoSource.Text := '';
    MemoSource.Enabled := False;
    MemoControl.Enabled := False;
  end;
end;


procedure TBindCompExprDesigner.ListBoxCollectionsClick(Sender: TObject);
begin
  if not FShowListBox then
    Exit;
  SaveMemoEdits;
  ListExpressions(False);
  if not SelectFirstExpression then
    DisplayExpressionText;
  SetSelection;
end;


constructor TBindCompExprDesigner.Create(AOwner: TComponent);
begin
  inherited;
  FExpressionDictionary := TDictionary<TListItem, TBindCompDesignExpression>.Create;

end;


procedure TBindCompExprDesigner.DisplayValue(const AScope, AExpression: string; AValue: IValue);
begin
  if FVisualizer = nil then
  begin
    FVisualizer := TBindCompExprVisualizer.Create(Self);
    LoadVisSizes;
  end;
  FVisualizer.DisplayValue(AScope, AExpression, AValue);
  try
    FVisualizer.ShowModal;
  finally
    FVisualizer.DiscardValue;
  end;
end;

procedure TBindCompExprDesigner.actCopyExecute(Sender: TObject);
begin
  Copy;

end;

procedure TBindCompExprDesigner.actCutExecute(Sender: TObject);
begin
  Cut;

end;

procedure TBindCompExprDesigner.actDeleteExecute(Sender: TObject);
begin
  Delete(True);

end;

procedure TBindCompExprDesigner.actDeleteUpdate(Sender: TObject);
begin
  //TAction(Sender).Enabled := CanDelete;

end;

procedure TBindCompExprDesigner.AddClick(Sender: TObject);
begin
 AddExpression;
end;

procedure TBindCompExprDesigner.AddExpression;
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedExpressionCollectionItem <> nil then
    AddCollectionItem(LSelectedState.FSelectedExpressionCollectionItem.Collection)
  else
    AddCollectionItem(LSelectedState.FSelectedCollection);
end;

function TBindCompExprDesigner.CanAddExpression: Boolean;
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedExpressionCollectionItem <> nil then
    Result := not IsReadOnly(LSelectedState.FSelectedExpressionCollectionItem.Collection)
  else
    Result := not IsReadOnly(LSelectedState.FSelectedCollection);
end;

procedure TBindCompExprDesigner.AddCollectionItem(ACollection: TCollection);
var
  Component: TComponent;
  LItem: TCollectionItem;
  LSelectedState: TSelectedState;
begin
  Component := Self.FBindComp;
  LSelectedState := GetSelectedState;
  if ACollection = nil then
    Exit;
  SaveMemoEdits;
  SelectNone(False);
  ACollection.BeginUpdate;
  try
//    PrevCount := Collection.Count + 1;
    LItem := ACollection.Add;
    { Take into account collections that free items }
//    if PrevCount <> Collection.Count then
//      UpdateListBox
//    else
//      ListView1.Selected := ListView1.Items.Add;
  finally
    ACollection.EndUpdate;
  end;
  //SetSelection;
  if csAncestor in Component.ComponentState then
  begin
    if FAddedItemIDList = nil then
      FAddedItemIDList := TList.Create;
    FAddedItemIDList.Add(Pointer(ACollection.Items[ACollection.Count - 1].ID));
  end;
  BeginEditCollection;
  try
    ListView1.Items.BeginUpdate;
    try
      if FShowTreeView then
        TreeViewCollections.Items.BeginUpdate;
      try
        Designer.Modified;
        SelectCollectionItem(LItem);
      finally
        if FShowTreeView then
          TreeViewCollections.Items.EndUpdate;
      end;
    finally
      ListView1.Items.EndUpdate;
    end;

  finally
    EndEditCollection;
  end;
end;

procedure TBindCompExprDesigner.AddCollectionCmdExecute(Sender: TObject);
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  AddCollectionItem(LSelectedState.FSelectedCollection);
end;

procedure TBindCompExprDesigner.AddCollectionCmdUpdate(Sender: TObject);
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  TAction(Sender).Enabled := (LSelectedState.FSelectedCollection <> nil)
    and (not LSelectedState.FSelectedCollectionIsLeaf) and
    (not IsReadOnly(LSelectedState.FSelectedCollection));
end;

function TBindCompExprDesigner.SelectTreeViewData(AData: Pointer): Boolean;
var
  LNode: TTreeNode;
begin
  if TreeViewCollections.Items.Count > 0 then
  begin
    LNode := TreeViewCollections.Items[0];
    while LNode <> nil do
    begin
      if LNode.Data = AData then
      begin
          LNode.MakeVisible;
          TreeViewCollections.Selected := LNode;
          Exit(True);
      end;
      LNode := LNode.GetNext;
    end;
  end;
  Result := False;
end;

function TBindCompExprDesigner.SelectCollectionItem(ACollectionItem: TCollectionItem): Boolean;
var
  I: Integer;
  LNode: TTreeNode;
begin

  if (ACollectionItem <> nil) and FShowTreeView then
  begin
    if TreeViewCollections.Items.Count > 0 then
    begin
      LNode := TreeViewCollections.Items[0];
      while LNode <> nil do
      begin
        if LNode.Data = ACollectionItem then
        begin
            LNode.Expanded := True;
            LNode.MakeVisible;
            TreeViewCollections.Selected := LNode;
            ListExpressions(False);
            Exit(True);
        end;
        LNode := LNode.GetNext;
      end;
    end;

  end;

  if (ACollectionItem <> nil) then
  begin
    for I := 0 to ListView1.Items.Count - 1 do
    begin
      if ListView1.Items[I].Data = ACollectionItem then
      begin
        ListView1.Items[I].Selected := True;
        ListView1.Items[I].MakeVisible(False);
        ListView1.SetFocus;
        //ListExpressions(False);
        DisplayExpressionText;
        Exit(True);
      end;
    end;

  end;

  Result := False;
end;

procedure TBindCompExprDesigner.AddExprCmdUpdate(Sender: TObject);
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  TAction(Sender).Enabled :=
    (LSelectedState.FSelectedCollection <> nil) and
    (LSelectedState.FSelectedCollectionIsLeaf) and
    (not IsReadOnly(LSelectedState.FSelectedCollection));
end;

procedure TBindCompExprDesigner.DeleteClick(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    DeleteExpression(True)
end;

procedure TBindCompExprDesigner.DeleteCollectionCmdExecute(Sender: TObject);
begin
  DeleteCollectionItem(True);
end;

procedure TBindCompExprDesigner.DeleteCollectionCmdUpdate(Sender: TObject);
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  TAction(Sender).Enabled :=
    (LSelectedState.FSelectedCollectionItem <> nil) and
    (not IsReadOnly(LSelectedState.FSelectedCollectionItem));
end;

procedure TBindCompExprDesigner.DeleteCollectionItem(AConfirmDelete: Boolean);
var
  LCollection: TCollection;
  LSelected: TTreeNode;
  LSelectedState: TSelectedState;
  LNext: Pointer;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedCollectionItem = nil then
    Exit;
  if IsReadOnly(LSelectedState.FSelectedCollectionItem) then
    Exit;
  if AConfirmDelete and
    (idYes <> MessageDlg(
      Format(SConfirmDelete, [LSelectedState.FSelectedCollectionItem.DisplayName]), mtConfirmation, mbYesNoCancel, 0)) then
    Exit;
  LCollection := LSelectedState.FSelectedCollectionItem.Collection;
  LCollection.BeginUpdate;
  try
    FreeAndNil(LSelectedState.FSelectedCollectionItem);
  finally
    LCollection.EndUpdate;
  end;
  if FShowTreeView then
  begin
    TreeViewCollections.Items.BeginUpdate;
    try
      LSelected := TreeViewCollections.Selected;
      if LSelected <> nil then      
        if LSelected.getNextSibling <> nil then
          LSelected := LSelected.getNextSibling
        else if LSelected.getPrevSibling <> nil then
          LSelected := LSelected.getPrevSibling
        else
          LSelected := LSelected.Parent;
      LNext := nil;
      if LSelected <> nil then
        LNext := LSelected.Data;
      Designer.Modified;
      if (LSelected = nil) or (not SelectTreeViewData(LNext)) then
        TreeViewCollections.Selected := nil;
      ListExpressions(False);
      if not SelectFirstExpression then
        DisplayExpressionText;
    finally
      TreeViewCollections.Items.EndUpdate;
    end;
  end;
end;

procedure TBindCompExprDesigner.DeleteExpression(AConfirmDelete: Boolean);
var
  Collection: TCollection;
  LSelectedState: TSelectedState;
  LItemIndex: Integer;
  LCount: Integer;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedExpressionCollectionItem = nil then
    Exit;
  if IsReadOnly(LSelectedState.FSelectedExpressionCollectionItem) then
    Exit;
//  Component := Self.FBindComp;
  Collection := LSelectedState.FSelectedExpressionCollectionItem.Collection;
  if Collection = nil then
    Exit;
  if AConfirmDelete and
    (idYes <> MessageDlg(
      Format(sConfirmDelete, [LSelectedState.FSelectedExpressionCollectionItem.DisplayName]),
         mtConfirmation, mbYesNoCancel, 0)) then
    Exit;

  Collection.BeginUpdate;
  try

    FreeAndNil(LSelectedState.FSelectedExpressionCollectionItem);
  finally
    Collection.EndUpdate;
  end;
  BeginEditCollection;
  try
    ListView1.Items.BeginUpdate;
    try
      LItemIndex := ListView1.ItemIndex;
      LCount := ListView1.Items.Count;
      Designer.Modified;
      if ListView1.Items.Count = 1 then
        LItemIndex := 0
      else if ListView1.Items.Count > 1 then
      begin
        if LItemIndex = LCount - 1 then
          LItemIndex := ListView1.Items.Count - 1
      end
      else
        LItemIndex := -1;

      ListView1.ItemIndex := LItemIndex;
      if ListView1.Selected <> nil then
      begin
        ListView1.Selected.MakeVisible(False);
      end
      else
        SetSelection; // When last expression deleted

    finally
      ListView1.Items.EndUpdate;
    end;
    DisplayExpressionText;
  finally
    EndEditCollection;
  end;
end;


procedure TBindCompExprDesigner.CollectionItemSelectionUpdate(Sender: TObject);
var
  Enabled: Boolean;
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  Enabled := False;
  if LSelectedState.FSelectedExpressionCollectionItem <> nil then
  begin
    if Sender = DeleteExprCmd then
      Enabled := not IsReadOnly(LSelectedState.FSelectedExpressionCollectionItem); //coDelete in Options else
    if (Sender = MoveExprUpCmd) or (Sender = MoveExprDownCmd) then
      Enabled := not IsReadOnly(LSelectedState.FSelectedExpressionCollectionItem); //coMove in Options;
  end;
       
  (Sender as TAction).Enabled := Enabled;
end;

procedure TBindCompExprDesigner.SelectAllCommandUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := ListView1.Items.Count > 0;
end;

procedure TBindCompExprDesigner.SelectAll(DoUpdate: Boolean);
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

procedure TBindCompExprDesigner.MoveUpClick(Sender: TObject);
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedExpressionCollectionItem <> nil then
    MoveExpressionUp
  else if LSelectedState.FSelectedCollectionItem <> nil then
    MoveCollectionItemUp;
end;

procedure TBindCompExprDesigner.MoveExpressionUp;
var
  I, InsPos: Integer;
  Collection: TCollection;
  Changed: Boolean;
  LItemIndex: Integer;
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedExpressionCollectionItem = nil then
    Exit;
  Collection := LSelectedState.FSelectedExpressionCollectionItem.Collection;
  if Collection = nil then
    Exit;
  if (ListView1.SelCount = 0) or
    (ListView1.SelCount = Collection.Count) then Exit;
  Changed := False;
  InsPos := 0;
  while not ListView1.Items[InsPos].Selected do
    Inc(InsPos);
  if InsPos > 0 then Dec(InsPos);

  Collection.BeginUpdate;
  try
     for I := 0 to ListView1.Items.Count - 1 do
       if ListView1.Items[I].Selected then
       begin
         if Collection.Items[I].Index <> InsPos then
         begin
           Changed := True;
           Collection.Items[I].Index := InsPos;
         end;
         Inc(InsPos);
       end;
  finally
    Collection.EndUpdate;
  end;
  GetSelection;
  if Changed then
  begin
    BeginEditCollection;
    try
      LItemIndex := ListView1.ItemIndex;
      Designer.Modified;
      ListView1.ItemIndex := LItemIndex - 1;
      ListView1.Selected.MakeVisible(False);
    finally
      EndEditCollection;
    end;
    DisplayExpressionText;
  end;
end;


procedure TBindCompExprDesigner.MoveCollectionItemUp;
var
  InsPos: Integer;
  Collection: TCollection;
  Changed: Boolean;
  LSelected: TTreeNode;
  LSelectedState: TSelectedState;
  LData: Pointer;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedCollectionItem = nil then
    Exit;
  Collection := LSelectedState.FSelectedCollectionItem.Collection;
  if Collection = nil then
    Exit;
  InsPos := LSelectedState.FSelectedCollectionItem.Index;
  if InsPos > 0 then Dec(InsPos);

  Collection.BeginUpdate;
  try
    Changed := True;
    LSelectedState.FSelectedCollectionItem.Index := InsPos;
  finally
    Collection.EndUpdate;
  end;
  GetSelection;
  if Changed then
  begin
    BeginEditCollection;
    try
      LSelected := TreeViewCollections.Selected;
      LData := nil;
      if LSelected <> nil then
        LData := LSelected.Data;
      Designer.Modified;
      if (LSelected = nil) or (not SelectTreeViewData(LData)) then
        TreeViewCollections.Selected := nil;
    finally
      EndEditCollection;
    end;
  end;
end;


procedure TBindCompExprDesigner.MoveDownClick(Sender: TObject);
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedExpressionCollectionItem <> nil then
    MoveExpressionDown
  else if LSelectedState.FSelectedCollectionItem <> nil then
    MoveCollectionItemDown;
end;

procedure TBindCompExprDesigner.MoveExpressionDown;
var
  I, InsPos: Integer;
  Collection: TCollection;
  Changed: Boolean;
  LItemIndex: Integer;
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedExpressionCollectionItem = nil then
    Exit;
  Collection := LSelectedState.FSelectedExpressionCollectionItem.Collection;
  if Collection = nil then
    Exit;
  Changed := False;
  if (ListView1.SelCount = 0) or
    (ListView1.SelCount = Collection.Count) then Exit;

  InsPos := ListView1.Items.Count - 1;
  while not ListView1.Items[InsPos].Selected do
    Dec(InsPos);
  if InsPos < (ListView1.Items.Count -1) then Inc(InsPos);

  Collection.BeginUpdate;
  try
     for I := ListView1.Items.Count - 1 downto 0 do
       if ListView1.Items[I].Selected then
       begin
         if Collection.Items[I].Index <> InsPos then
         begin
           Changed := True;
           Collection.Items[I].Index := InsPos;
         end;
         Dec(InsPos);
       end;
  finally
    Collection.EndUpdate;
  end;
  GetSelection;
  if Changed then
  begin
    BeginEditCollection;
    try
      LItemIndex := ListView1.ItemIndex;
      Designer.Modified;
      ListView1.ItemIndex := LItemIndex + 1;
      ListView1.Selected.MakeVisible(False);
    finally
      EndEditCollection;
    end;
    DisplayExpressionText;
  end;
end;

procedure TBindCompExprDesigner.MoveCollectionDownCmdExecute(Sender: TObject);
begin
  MoveCollectionItemDown;

end;

procedure TBindCompExprDesigner.MoveCollectionUpCmdUpdate(Sender: TObject);
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  TAction(Sender).Enabled :=
    (LSelectedState.FSelectedCollectionItem <> nil) and
    (not IsReadOnly(LSelectedState.FSelectedCollectionItem));
end;

procedure TBindCompExprDesigner.MoveCollectionUpCmdExecute(Sender: TObject);
begin
  MoveCollectionItemUp;

end;

procedure TBindCompExprDesigner.MoveCollectionDownCmdUpdate(Sender: TObject);
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  TAction(Sender).Enabled :=
    (LSelectedState.FSelectedCollectionItem <> nil) and
    (not IsReadOnly(LSelectedState.FSelectedCollectionItem));
end;

procedure TBindCompExprDesigner.MoveCollectionItemDown;
var
  InsPos: Integer;
  Collection: TCollection;
  Changed: Boolean;
  LSelected: TTreeNode;
  LData: Pointer;
var
  LSelectedState: TSelectedState;
begin
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedCollectionItem = nil then
    Exit;

  Collection := LSelectedState.FSelectedCollectionItem.Collection;
  if Collection = nil then
    Exit;
  InsPos := LSelectedState.FSelectedCollectionItem.Index;
  if InsPos < (Collection.Count -1) then Inc(InsPos);

  Collection.BeginUpdate;
  try
    Changed := True;
    LSelectedState.FSelectedCollectionItem.Index := InsPos;
  finally
    Collection.EndUpdate;
  end;
  GetSelection;
  if Changed then
  begin
    BeginEditCollection;
    try
      LSelected := TreeViewCollections.Selected;
      LData := nil;
      if LSelected <> nil then
        LData := LSelected.Data;
      Designer.Modified;
      if (LSelected = nil) or (not SelectTreeViewData(LData)) then
        TreeViewCollections.Selected := nil;
    finally
      EndEditCollection;
    end;
  end;
end;

procedure TBindCompExprDesigner.SelectNone(DoUpdate: Boolean);
var
  I: Integer;
begin
  LockState;
  ListView1.Items.BeginUpdate;
  try
    for I := 0 to Listview1.Items.Count-1 do
      Listview1.Items[I].Selected := False;
  finally
    ListView1.Items.EndUpdate;
    UnlockState;
    if DoUpdate then SetSelection;
  end;
end;

procedure TBindCompExprDesigner.GetSelection;
begin
end;

procedure TBindCompExprDesigner.Cut;
begin
  if MemoControl.Focused then
    MemoControl.CutToClipboard
  else if MemoSource.Focused then
    MemoSource.CutToClipboard
  else if ListView1.Focused or TreeViewCollections.Focused or
          ListBoxCollections.Focused then
  else if ListView1.Focused then
  begin
     if CopyExpression then
       DeleteExpression
  end
  else if TreeViewCollections.Focused or
          ListBoxCollections.Focused then
    if CopyCollectionItem then
      DeleteCollectionItem;
end;

procedure TBindCompExprDesigner.Delete(AConfirmDelete: Boolean);
begin
  if MemoControl.Focused then
    MemoControl.ClearSelection
  else if MemoSource.Focused then
    MemoSource.ClearSelection
  else if ListView1.Focused then
  begin
     DeleteExpression(AConfirmDelete)
  end
  else if TreeViewCollections.Focused or
          ListBoxCollections.Focused then
    DeleteCollectionItem(AConfirmDelete);
end;

procedure TBindCompExprDesigner.Copy;
begin
  if MemoControl.Focused then
    MemoControl.CopyToClipboard
  else if MemoSource.Focused then
    MemoSource.CopyToClipboard
  else if ListView1.Focused or TreeViewCollections.Focused or
          ListBoxCollections.Focused then
  else if ListView1.Focused then
  begin
     CopyExpression
  end
  else if TreeViewCollections.Focused or
          ListBoxCollections.Focused then
    CopyCollectionItem
end;

function TBindCompExprDesigner.CopyCollectionItem: Boolean;
var
//  ComponentList: IDesignerSelections;
  LSelectedState: TSelectedState;
begin
  Result := False;
  LSelectedState := GetSelectedState;
  if (LSelectedState.FSelectedCollectionItem <> nil) then
  begin
                                      
//    ComponentList := CreateSelectionList;
//    ComponentList.Add(LSelectedState.FSelectedCollectionItem);
//    CopyComponents(FBindComp.Owner, ComponentList);
//    Result := True;
  end;
end;

function TBindCompExprDesigner.CopyExpression: Boolean;
var
//  I: Integer;
//  ComponentList: IDesignerSelections;
  LSelectedState: TSelectedState;
begin
  Result := False;
  LSelectedState := GetSelectedState;
  if LSelectedState.FSelectedExpressionCollectionItem <> nil then
  begin
                                      
//    ComponentList := CreateSelectionList;
//    ComponentList.Add(LSelectedState.FSelectedExpressionCollectionItem);
//    CopyComponents(FBindComp.Owner, ComponentList);
//    Result := True;
  end;
end;

procedure TBindCompExprDesigner.Paste;
begin
  if MemoControl.Focused then
    MemoControl.PasteFromClipboard
  else if MemoSource.Focused then
    MemoSource.PasteFromClipboard
  else if ListView1.Focused or TreeViewCollections.Focused or
          ListBoxCollections.Focused then
  else if ListView1.Focused then
  begin
     PasteExpression
  end
  else if TreeViewCollections.Focused or
          ListBoxCollections.Focused then
    PasteCollectionItem

end;

procedure TBindCompExprDesigner.PasteExpression;
begin
                                                          
end;

procedure TBindCompExprDesigner.PasteCollectionItem;
begin
                                                          
end;

//procedure TBindCompExprDesigner.Paste;
//var
//  I, C: Integer;
//  ComponentList: TList;
//  Action: TContainedBindComponent;
//  Item: TListItem;
//begin
//  ComponentList := TList.Create;
//  try
//    C := -1;
//    with ListView1 do
//      if (Selected <> nil) and (Selected.Index <> -1) and (Items.Count > 0) then
//        C := Selected.Index;
//    try
////!      Designer.BeginDesign;
//      try
//        { Try to convert TMenuItem, TControl, and TWinControl to TAction }
//        LoadFromClipboard(FDataBindingList.Owner, FDataBindingList, ComponentList);
//      finally
////!        Designer.EndDesign;
//      end;
//    finally
//      UpdateView
//    end;
//    try
//      ListView1.Selected := nil;
//      Item := nil;
//      for I := ComponentList.Count - 1 downto 0 do
//        if TObject(ComponentList[I]) is TBasicAction then
//        begin
//          Action := TContainedBindComponent(ComponentList[I]);
//          if C <> -1 then Action.Index := C;
//  //        Item := ListView1.FindCaption(0, Action.Name, False, True, False);
//          Item := ListView1.Items[C];
//          if Item <> nil then Item.Selected := True;
//        end;
//      if Item <> nil then
//        Item.Focused := True;
//    finally
//  //!    UpdateView;
//      GetSelection;
//      Designer.Modified;
//    end;
//  finally
//    ComponentList.Free;
//  end;
//end;

{ TTreeViewState }

constructor TTreeViewState.Create(ATree: TTreeView);
begin
  inherited Create;
  FTreeFiles := ATree;
  FItemKeys := TObjectDictionary<TArray<string>, TItemState>.Create([doOwnsValues]);
  SaveState;

end;

function TTreeViewState.SaveItemState(Node: TTreeNode): TItemState;
var
  Key: TArray<string>;
begin
  Key := GetTreeNodePath(Node);
  if not FItemKeys.TryGetValue(Key, Result) then
  begin
    Result := TItemState.Create(Self, Node);
    Result.Key := Key;
    FItemKeys.Add(Key, Result);
  end
end;

procedure TTreeViewState.SaveState;
var
  Node: TTreeNode;
begin
  Node := TreeFiles.TopItem;
  if Node <> nil then
    FFirstVisible := SaveItemState(Node);
  Node := TreeFiles.Selected;
  if Node <> nil then
    FFocused := SaveItemState(Node);
  if TreeFiles.Items.Count > 0 then
  begin
    Node := TreeFiles.Items[0];
    while Node <> nil do
    begin
      SaveItemState(Node);
      Node := Node.GetNext;
    end;
  end;
end;

destructor TTreeViewState.Destroy;
begin
  FItemKeys.Free;
  inherited;
end;

procedure TTreeViewState.RestoreExpanded;
var
  LPair: TPair<TArray<string>, TItemState>;
  LNode: TTreeNode;
  LNodes: TList<TTreeNode>;
begin
  LNodes := TList<TTreeNode>.create;
  try
    for LPair in FItemKeys do
    begin
      LNode := FindNode(LPair.Key);
      if LNode <> nil then
      begin
        LNodes.Add(LNode);
        if LPair.Value.Expanded then
          LNode.Expanded := True;
      end;
    end;
    // Expand nodes if we don't know the state
    LNode := TreeFiles.Items[0];
    while LNode <> nil do
    begin
      if not LNodes.Contains(LNode)then
        LNode.Expanded := True;
      LNode := LNode.GetNext;
    end;
  finally
    LNodes.Free;
  end;
end;

procedure TTreeViewState.RestoreSelection;
var
  Node: TTreeNode;
begin
  if FFocused <> nil then
  begin
    Node := FindNode(FFocused.Key);
    if Node <> nil then
      TreeFiles.Selected := Node;
  end;

end;

procedure TTreeViewState.RestoreTop;
var
  Node: TTreeNode;
begin
  if FFirstVisible <> nil then
  begin
    Node := FindNode(FFirstVisible.Key);
    if Node <> nil then
      TreeFiles.TopItem := Node;
  end;
end;

function TTreeViewState.GetTreeNodePath(ANode: TTreeNode): TArray<string>;
var
  LList: TList<string>;
begin
  LList := TList<string>.create;
  try
    while ANode <> nil do
    begin
      LList.Insert(0, ANode.Text);
      ANode := ANode.Parent;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TTreeViewState.FindNode(AKey: TArray<string>): TTreeNode;
begin
  if Length(AKey) > 0 then
    Result := FindNode2(TreeFiles.Items[0], AKey, 0)
  else
  begin
    Assert(False);
    Result := nil;
  end;
end;

function TTreeViewState.FindNode2(ANode: TTreeNode; AKey: TArray<string>; ALevel: Integer): TTreeNode;
var
  LMatch: TTreeNode;
  LKey: string;
begin
  LMatch := nil;
  LKey := AKey[ALevel];
  while ANode <> nil do
  begin
    if ANode.Text = LKey then
    begin
      LMatch := ANode;
      break;
    end;
    ANode := ANode.GetNextSibling;
  end;
  if LMatch <> nil then
  begin
    if ALevel < Length(AKey) - 1 then
      Result := FindNode2(LMatch.GetFirstChild, AKey, ALevel+1)
    else
      Result := LMatch;
  end
  else
    Exit(nil);


end;


{ TItemState }

constructor TItemState.Create(Owner: TTreeViewState; ANode: TTreeNode);
begin
  FExpanded := ANode.Expanded;
end;


{ TSelectedState }

procedure TSelectedState.Validate;
begin
  Assert((FSelectedCollection = nil) or (FSelectedCollection is TCollection));
  Assert((FSelectedCollectionItem = nil) or (FSelectedCollectionItem is TCollectionItem));
  Assert((FSelectedExpressionCollectionItem = nil) or (FSelectedExpressionCollectionItem is TCollectionItem));
  Assert((FSelectedCollectionOwnerItem = nil) or (FSelectedCollectionOwnerItem is TCollectionItem));
end;

initialization
  //BindCompEdit.NotifyDataBindingListChange := NotifyDataBindingListChangeImpl;

finalization
//  BindCompEdit.NotifyDataBindingListChange := nil;
  FreeAndNil(DesignersList);

end.

