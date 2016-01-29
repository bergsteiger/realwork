{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dctreeed;

interface
{$I dc.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  Buttons,CommCtrl,dcgen,dccommon,menus,dcsystem,
  dcdtree,dcTree,dctsrc, dctslite , dcconsts,dcstdctl, treemod,dcdreamlib;


{------------------------------------------------------------------}

type

  TTreeEditForm = class(TForm)
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    PopupMenu1: TPopupMenu;
    miStayonTop: TMenuItem;
    Panel1: TPanel;
    Panel3: TPanel;
    NewBut: TSpeedButton;
    NewSubButton: TSpeedButton;
    DeleteButton: TSpeedButton;
    StatusBar1: TStatusBar;
    RefrBut: TSpeedButton;
    UpBut: TSpeedButton;
    PopupMenu2: TPopupMenu;
    ListStyle1: TMenuItem;
    SmalIconStyle1: TMenuItem;
    LargeIconStyle1: TMenuItem;
    StayonTop1: TMenuItem;
    N1: TMenuItem;
    InspBut: TSpeedButton;
    SplitterPanel1: TDCSplitPanel;
    TreeView: TDCTreeView;
    DCListView: TDCListView;
    ReportStyle: TMenuItem;
    DCPropStore1: TDCPropStore;
    procedure ToolButtonNewItemClick(Sender: TObject);
    procedure ToolButtonNewSubItemClick(Sender: TObject);
    procedure ToolButtonDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure miStayonTopClick(Sender: TObject);
    procedure RefrButClick(Sender: TObject);
    procedure DCListViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure UpButClick(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure ListStyle1Click(Sender: TObject);
    procedure InspButClick(Sender: TObject);
    procedure DCListViewSelectionChanged(Sender: TObject; Item: TListItem);
  private
    FPropName : string;
    FEditedObject : TObject;
    FListViewVisible : boolean;
    FTreeViewVisible : boolean;
    FDesigner : TFormDesigner;
    procedure SetListViewVisible(Value:boolean);
    procedure SetTreeViewVisible(Value:boolean);
    procedure UpdateCaption(Const Cap:String);
    procedure AllowButtons(ObjId:integer);
    procedure SetActive;
    procedure SelectInspector(ObjId : integer);
    procedure DesignerSelectComponent;
    procedure SetActiveSource(Value :TTreeSource);
    function  GetActiveSource:TTreeSource;
    function  GetActiveCtrl:TControl;
    function _Designer : TFormDesigner;
  protected
    procedure WMACTIVATE(Var M:TMessage); message WM_ACTIVATE;
    procedure CMNAMECHANGED(Var M:TMessage); message CM_NAMECHANGED;
    procedure CMSOURCEEMPTY  (var M:TMessage); message CM_SOURCEEMPTY;
    procedure cmToolBarForm(Var M:TMessage) ;message cm_ToolBarForm;
    procedure CMDESIGNFINISHED (var M:TMessage); message CM_DESIGNFINISHED;
  public
    property ActiveSource :TTreeSource read GetActiveSource write SetActiveSource;
  published
    property ListViewVisible : boolean  read FListViewVisible write SetListViewVisible;
    property TreeViewVisible : boolean  read FTreeViewVisible write SetTreeViewVisible;

  end;


  TCollectEdit = class(TClassProperty)
  public
    procedure Edit; override;
    function  GetAttributes : TPropertyAttributes; override;
    function  GetValue : string; override;
  end;

  TMenuEdit=Class(TClassProperty)
  public
    function  GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;
  
  TWindowList = class(TComponent)
  private
    FVersion : TDCVersion;
  public
    procedure Execute;
  published
    property Version : TDCVersion read FVersion write FVersion stored false;

  end;

var
  TreeEditForm: TTreeEditForm;

function  EditObject(EditObject:TComponent; const PropName:string):TTreeEditForm;
function  EditObjectEx(EditObject:TComponent; const PropName:string;SourceClass :TTreeSourceClass):TTreeEditForm;
function  GetTreeForm(EditObject:TPersistent ; const  PropName :string; var Aexists:boolean):TTreeEditForm;
procedure EditResource(const FileName:string);
procedure SetSource(F:TTreeEditForm;S:TTreeSource);
procedure ShowWindowList;

implementation
{$R *.DFM}


type
 TMTreeView = class(TCustomTreeView);
 TMListView = class(TCustomListView);
 TMSource = Class(TTreeSource);

{---------TCollectEdit---------------------------------------------------}

function  TCollectEdit.GetValue : string;
begin
   result:='('+ GetPropType^.name+')';
end;

{------------------------------------------------------------------}

function  TCollectEdit.GetAttributes : TPropertyAttributes;
begin
  result := [paReadOnly,paDialog];
end;

{------------------------------------------------------------------}

procedure TCollectEdit.Edit;
var
  SourceClass:TTreeSourceClass;
begin
  SourceClass:=GetRegisteredTreeSource(GetComponent(0).ClassType,GetName);
  If SourceClass=nil then
    SourceClass:=TDCCollectSource;
  EditObjectEx(TComponent(GetComponent(0)),GetName,SourceClass);
end;

{---------------TMenuEdit-----------------------------------------}

function  TMenuEdit.GetAttributes : TPropertyAttributes;
begin
  result := [paReadOnly,paDialog];
end;

{------------------------------------------------------------------}

procedure TMenuEdit.Edit;
begin
  EditObject(TComponent(GetComponent(0)),GetName);
end;


{---------TTreeEditForm---------------------------------------------}

procedure TTreeEditForm.cmToolBarForm(Var M:TMessage) ;
begin
  M.Result:=1;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.CMDESIGNFINISHED (var M:TMessage);
begin
  Release;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.UpdateCaption(Const Cap:String);
begin
  if Cap <> '' then
    Caption :=  Cap + '.' + FPropName
  else
    Caption :=  FPropName;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.SetActiveSource(Value :TTreeSource);
begin
  TreeView.Source := Value;
  DcListView.Source := Value;
end;

{------------------------------------------------------------------}

function  TTreeEditForm.GetActiveSource:TTreeSource;
begin
  if GetActiveCtrl = TreeView then
    result := TreeView.Source
  else
    result := DcListView.Source;
end;

{------------------------------------------------------------------}

function  TTreeEditForm.GetActiveCtrl:TControl;
begin
  if TreeView.Focused  or  DcListView.Focused  then
    if TreeView.Focused then
      result :=TreeView
    else
      result :=  DcListView
  else
    if FtreeViewVisible then
      result := TreeView
    else
      result :=  DcListView
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.ToolButtonNewItemClick(Sender: TObject);
begin
  if (GetActiveCtrl = TReeView) then
    with TReeView,Items do
      Add(Selected,'')
  else
  if (DcListView.Items.Root <> -1) then
    DclistView.Items.Add
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.ToolButtonNewSubItemClick(Sender: TObject);
begin
  if FtreeViewVisible then
    with TreeView,Items do
      AddChild(Selected,'');
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.ToolButtonDeleteClick(Sender: TObject);
begin
  if GetActiveCtrl = TreeView then
     TreeView.DeleteSelectedItems
  else
     DcListView.DeleteSelectedItems;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.UpButClick(Sender: TObject);
var
  Sel : TTreeNode;
begin
  if GetActiveCtrl = TreeView then
  begin
    with TreeView,Items do
      if Assigned(Selected) and  Assigned(Selected.Parent) then
      begin
        Sel := Selected;
        DeselectAllItems;
        Selected := Sel.Parent;
      end;
  end
  else
    Dclistview.Items.GetPrevLevel;
end;


{------------------------------------------------------------------}

procedure TTreeEditForm.CMNAMECHANGED(Var M:TMessage);
begin
  if (M.WParam=integer(FEditedObject)) then
    UpdateCaption(Pchar(M.lParam));
end;


{------------------------------------------------------------------}

procedure TTreeEditForm.CMSOURCEEMPTY (var M:TMessage);
  procedure CloseOnCondition(value:boolean);
  begin
    if Value then
    begin
      SelectInspector(0);
      Release;
    end;
  end;
begin
  if FtreeViewVisible then
    CloseOnCondition(integer(TreeView.RootSource) = M.Wparam)
  else
    CloseOnCondition(integer(DcListView.Source) = M.Wparam);
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.SelectInspector(ObjId : integer);
begin
  if Assigned(ActiveSource) and ActiveSource.ActionAllowed(0,acSelectInspector) then
    BroadCastToNotifiers(self, CM_SELECTIONCHANGED, ObjId, integer(_Designer))
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.DesignerSelectComponent;
begin
  if GetActiveCtrl = TreeView then
    SelectInspector(integer(TreeView.InspectorControls))
  else
    SelectInspector(integer(DCListView.InspectorControls));
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  RegisterNotifier(self);
  SetFlatPropToAll(Self,true);
  FTreeViewVisible := true;
  FListViewVisible := true;

  Caption := SObjectExplorer;
  RefrBut.Hint :=            SRefresh;
  UpBut.Hint :=              SLevelUp;
  InspBut.Hint :=            RemoveCharSet(['.'],SVerbProperties);
  NewBut.Hint :=             SAddItem;
  NewSubButton.Hint :=       SAddSubItem;
  DeleteButton.Hint  :=      SDeleteItem;
  LargeIconStyle1.Caption := SLargeIcon;
  SmalIconStyle1.Caption :=  SSmalIcon;
  ListStyle1.Caption :=      SListStyle;
  ReportStyle.Caption :=     SReportStyle;
  miStayonTop.Caption :=     RemoveCharSet(['&'],SVerbStayOnTop);
  StayonTop1.Caption :=       miStayonTop.Caption;
  if ToolFormsOnTop then
    Formstyle := fsStayOnTop
  else
    Formstyle := fsNormal;
  miStayOnTop.Checked:= ToolFormsOnTop;
  StayonTop1.Checked := ToolFormsOnTop;
end;

{------------------------------------------------------------------}


procedure TTreeEditForm.FormDestroy(Sender: TObject);
begin
  UnRegisterNotifier(self);
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.FormShow(Sender: TObject);
begin
  SetActive;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.SetActive;
begin
  if Assigned(ActiveSource) then
    with ActiveSource do
    begin
      TreeView.MultiSelect:=ActionAllowed(0,acMultiSelect);
      DcListView.MultiSelect:=TreeView.MultiSelect;
      Panel1.Visible:=ActionAllowed(0,acShowToolBar);
      TreeView.ShowLines:=ActionAllowed(0,acShowLines);
      TreeView.ShowRoot:=TreeView.ShowLines;
      if not ActionAllowed(0,acCanDrag) then
      begin
        TreeView.DragMode := dmManual;
        DcListView.DragMode := dmManual;
      end;
    end;
  AllowButtons(0);
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.WMACTIVATE(Var M:TMessage);
begin
  inherited;
  if  (LOWORD(M.wParam) <> WA_INACTIVE) then
    DesignerSelectComponent;
end;

{------------------------------------------------------------------}


procedure TTreeEditForm.AllowButtons(ObjId:integer);
begin
  if Assigned(ActiveSource) then
    with ActiveSource do
    begin
      NewBut.Enabled:=ActionAllowed(ObjId,acCanAdd);
      NewSubButton.Enabled:=ActionAllowed(ObjId,acCanAddChild);
      DeleteButton.Enabled:=TreeView.CanDeleteSelection;
      InspBut.Enabled := ActionAllowed(ObjId,AcSelectInspector);
      StatusBar1.Panels[0].Text:=GetStatusLine(ObjId);
    end
  else
    StatusBar1.Panels[0].Text := '';
  if GetActiveCtrl = TreeView then
    with TreeView ,Items do
    begin
      DeleteButton.Enabled:=DeleteButton.Enabled and (Count>0 );
      UpBut.Enabled  := Assigned(Selected) and Assigned(Selected.Parent);
     end
  else
    with Dclistview, Items do
    begin
      DeleteButton.Enabled:=DeleteButton.Enabled and (Count>0 );
      UpBut.Enabled:=false;
    end;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  S:TTreeSource;
begin
  if not FTreeViewVisible then
    exit;
  DesignerSelectComponent;
  S := TreeView.Items.GetSelfSource(Node);
  if  Assigned(Node) and  Assigned(S) then
  begin
    AllowButtons(TDCTreeNode(Node).ObjId);
    if FListViewVisible then
     if  TDCTreeNode(Node).RootId = -1  then
       DCListView.SetSourceWithRoot(S,TDCTreeNode(Node).ObjId)
     else
       DCListView.SetSourceWithRoot(S,0);
  end
  else
  begin
    if FListViewVisible then
      DCListView.Items.Root := -1;
    AllowButtons(0);
  end;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.DCListViewSelectionChanged(Sender: TObject;
  Item: TListItem);
begin
  if not FListViewVisible then
    exit;
  DesignerSelectComponent;
  if  Assigned(Item)  then
    AllowButtons(TDCListItem(Item).ObjId)
  else
    AllowButtons(0);

end;

{------------------------------------------------------------------}

procedure TTreeEditForm.DCListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  with DcListView do
  begin
    if not focused then
      exit;
    DesignerSelectComponent;
    if Assigned(Source) and Assigned(Selected) then
      AllowButtons(TDCListItem(Selected).ObjId)
    else
      AllowButtons(0);
  end;
end;


{------------------------------------------------------------------}

procedure TTreeEditForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SelectInspector(0);
  Action := caFree;
end;


{------------------------------------------------------------------}

procedure TTreeEditForm.RefrButClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    if FTreeViewVisible and FListViewvisible then
    begin
      DCListView.Items.Root:=-1;
      TreeView.RefreshTree;
    end
    else
    if FTreeViewVisible  then
      TreeView.RefreshTree
    else if FlistViewVisible then
      DCListView.RefreshList;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

{------------------------------------------------------------------}


procedure TTreeEditForm.miStayonTopClick(Sender: TObject);
begin
  miStayOnTop.Checked:= not miStayOnTop.Checked;
  StayonTop1.Checked := miStayOnTop.Checked;
  if formstyle =fsStayOnTop then
     formstyle :=fsNormal
  else
     formstyle :=fsStayOnTop;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.PopupMenu2Popup(Sender: TObject);
begin
  with DcListView do
    case ViewStyle of
      vsList      :  ListStyle1.Checked := true;
      vsIcon      :  LargeIconStyle1.Checked := true;
      vsSmallIcon :  SmalIconStyle1.Checked := true;
      vsReport    :  ReportStyle.Checked := true;
    end;
end;

{------------------------------------------------------------------}

function TTreeEditForm._Designer : TFormDesigner;
begin
  if (FDesigner = nil) and (FEditedObject is TPersistent) then
    FDesigner := GetFormDesigner(TPersistent(FEditedObject));
  result := FDesigner;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.InspButClick(Sender: TObject);
begin
  ShowInspector;
  DesignerSelectComponent;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.ListStyle1Click(Sender: TObject);
begin
  with DcListView do
    case TMenuItem(Sender).Tag of
      1: ViewStyle := vsList;
      2: ViewStyle := vsIcon;
      3: ViewStyle := vsSmallIcon;
      4:
        begin
          DCListView.Columns[0].Width :=  DCListView.Width;
          ViewStyle :=  vsReport;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.SetListViewVisible(Value:boolean);
begin
  if FListViewVisible <> value then
  begin
    FListViewVisible:=Value;
    SplitterPanel1.LeftVisible := value;
  end;
    if Value and not FTreeViewVisible then
       Dclistview.RefreshList;
end;

{------------------------------------------------------------------}

procedure TTreeEditForm.SetTreeViewVisible(Value:boolean);
begin
  if FTreeViewVisible <> value then
  begin
    FTreeViewVisible:=Value;
    SplitterPanel1.RightVisible := value;
    if Value then
      TreeView.RefreshTree;
  end;
end;

{------------------------------------------------------------------}

procedure SetSource(F:TTreeEditForm;S:TTreeSource);
var
  ACount : integer;
  i      : integer;
begin
  with  F do
  begin
    S.ValidSource;
    if S.ActionAllowed(0,acShowTreeView) then
      TreeView.Source := S
    else
      TreeViewVisible := false;
    if S.ActionAllowed(0,acShowListView) then
    begin
      if FTreeViewVisible then
        DcListView.SetSourceWithRoot(S,-1)
      else
        DcListView.Source := S;
    end
    else
      ListViewVisible := false;
    if ListViewVisible then
    begin
      ACount := S.GetAttrCount;
      with DcListView do
      begin
        Columns[0].Width := -1;
        for i := 0 to ACount - 1 do
          with Columns.Add do
          begin
            Caption := S.GetAttrName(i);
            Width := -1;
          end;
        ViewStyle := vsReport;
        ShowColumnHeaders := ACount <> 0;
      end;
    end;
    if TMsource(S).GettreeLink is TComponent then
      UpdateCaption(TComponent(TMsource(S).GettreeLink).Name)
    else
      UpdateCaption('');
    Show;
  end;
end;

{------------------------------------------------------------------}

procedure EditResource(const FileName:string);
var
  F:TTreeEditForm;
  Aexists:boolean;
  Source: TDCResViewSource;
begin
  F:=GetTreeForm(nil,FileName,Aexists);
  if not Aexists then
  begin
    Source := TDCResViewSource.Create(F);
    Source.FileName := FileName;
    SetSource(F,Source);
  end
  else
    F.Show;
end;

{------------------------------------------------------------------}

function EditObject(EditObject:TComponent; const PropName:string):TTreeEditForm;
begin
  Result:=EditObjectEx(EditObject,PropName,GetRegisteredTreeSource(EditObject.ClassType,PropName));
end;

{------------------------------------------------------------------}

function EditObjectEx(EditObject:TComponent; const PropName:string;SourceClass :TTreeSourceClass):TTreeEditForm;
var
  Source:TTreeSource;
  aexists:boolean;
begin
  result := nil;
  if SourceClass = nil then
    exit;
  result := GetTreeForm(EditObject,PropName,Aexists);
  if not Aexists then
  begin
    Source:=SourceClass.Create(result);
    TMSource(Source).SetTreeLink(EditObject);
    SetPropValue(Source, 'PropName', PropName); //don't resource
    {If Source is TDCPersistentSource then
      TDCPersistentSource(Source).PropName:=PropName;}
    SetSource(result,Source);
  end
  else
    result.Show;
end;

{------------------------------------------------------------------}

function  GetTreeForm(EditObject:TPersistent ; const  PropName :string;var Aexists:boolean) : TTreeEditForm;
var
  i:integer;
begin
  Aexists:=false;
  for i:=0 to ScreenFormCount-1 do
    If (ScreenForms(i) is TTreeEditForm)  then
      with   TTreeEditForm (ScreenForms(i)) do
         if (FPropName = PropName) and (FEditedObject = EditObject) then
         begin
           result:=TTreeEditForm(ScreenForms(i));
           Aexists := true;
           exit;
         end;
  result := TTreeEditForm.Create(Application);
  with result do
  begin
    FPropName := PropName;
    FEditedObject := EditObject;
    FDesigner := nil;
  end;
end;

{----------TWindowList--------------------------------------}

procedure TWindowList.Execute;
begin
  ShowWindowList;
end;

{------------------------------------------------------------------}

procedure ShowWindowList;
var
  FormSource:TDCFormSource;
  ObjId:integer;
begin
  FormSource:=TDCFormSource.Create(nil);
  try
    ObjId:=EditSourceModal(FormSource,SCapWindowList,0);
    if ObjId <> 0 then
      FormSource.Edit(ObjId);
  finally
    FormSource.Free;
  end;
end;


{------------------------------------------------------------------}

//BeginSkipConst
procedure _Register;
begin
{
  RegisterDefaultTreeSource(TDCMSTreeView,TDCTreeViewSource,'Items');
  RegisterDefaultTreeSource(TDCDrawTreeView,TDCTreeViewSource,'Items');
  RegisterDefaultTreeSource(TDCDrawListView,TDCListViewSource,'Items');
  }
  RegisterDefaultTreeSource(TCustomTreeView,TDCTreeViewSource,'Items');
  RegisterDefaultTreeSource(TCustomListView,TDCListViewSource,'Items');

end;

procedure _InstantRegister;
begin
  RegisterPropertyEditor(TypeInfo(TMenuItem),TMenu,'Items',TMenuEdit);
  RegisterPropertyEditor(TypeInfo(TCollection),TPersistent,'',TCollectEdit);
  RegisterVisualProperty(SVerbMultiSourceEditor,TDCMultiSource,'Sources');
  {$IFDEF D3}
  RegisterVisualProperty(SVerbBandsEditor,TCoolBar,'Bands');
  {$ENDIF}
  //RegisterVisualProperty(SVerbMenuDesigner,TMenu,'Items');
  RegisterVisualProperty(SVerbSectionsEditor,THeader,'Sections');
  RegisterVisualProperty(SVerbSectionsEditor,THeaderControl,'Sections');
  RegisterVisualProperty(SVerbPanelsEditor,TStatusBar,'Panels');
  RegisterVisualProperty(SVerbColumnsEditor,TListView,'Columns');
  //RegisterVisualProperty(SVerbColumnsEditor ,TDCListView,'Columns');
  //RegisterVisualProperty(SVerbColumnsEditor ,TDCDrawListView,'Columns');

end;
//EndSkipConst

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
  RegisterForInstant(_InstantRegister);
end;

initialization
  Runregister;
end.
