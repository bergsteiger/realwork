{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit treeinsp;

interface
{$I dc.inc}

uses
  Windows, Classes, Graphics, Controls, Forms,  menus, Buttons, ExtCtrls, ComCtrls,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  typinfo, Grids, dcstdctl,dcpalet, {$IFNDEF D3}dcmenu,{$ENDIF}
  oinspect, dctree, dctslite, dcdtree, dctsrc,dcgen,dccommon,dcsystem,dcconsts;

type
  TTreeInspForm = class(TForm)
    DCSplitPanel1: TDCSplitPanel;
    ToolPanel: TPanel;
    TreeView: TDCTreeView;
    StatusBar1: TStatusBar;
    RefrBut: TSpeedButton;
    UpBut: TSpeedButton;
    NewBut: TSpeedButton;
    NewSubButton: TSpeedButton;
    DeleteButton: TSpeedButton;
    TabControl1: TDCTabControl;
    Inspector: TObjectInspector;
    DCPropStore1: TDCPropStore;
    procedure RefrButClick(Sender: TObject);
    procedure UpButClick(Sender: TObject);
    procedure NewButClick(Sender: TObject);
    procedure NewSubButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure TreeViewSelectionChanged(Sender: TObject;
      Node: TTreeNode);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TabControl1Change(Sender: TObject);
  private
    { Private declarations }
    FEditObject : TObject;
    procedure SelectInspector(AList : TList);
    procedure DesignerSelectComponent;
    procedure AllowButtons(ObjId:integer);
  public
    { Public declarations }
  end;
  TDCModalTreeEdit=Class(TClassProperty)
  public
    function  GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TModalCollectEdit = class(TDCModalTreeEdit)
  public
    function  GetValue : string; override;
    procedure Edit; override;
  end;

procedure ShowIDEInspector;
procedure InitializeIdeInspector;
function  EditTreeSource(ASource : TTreeSource):TTreeInspForm;
procedure _ModalEdit(EditObject:TComponent; const PropName:string;AClass:TTreeSourceClass);
function GetEditForm(EditObject:TComponent;  const PropName:string;AClass:TTreeSourceClass):TTreeInspForm;
var
  TreeInspForm: TTreeInspForm;

implementation

{$R *.DFM}

{------------------------------------------------------------------}

procedure TTreeInspForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  SetFlatPropToAll(Self,true);

  //Caption := SModalTreeEdit;
  RefrBut.Hint :=          SRefresh;
  UpBut.Hint :=            SLevelUp;
  NewBut.Hint :=           SAddItem;
  NewSubButton.Hint :=     SAddSubItem;
  DeleteButton.Hint :=     SDeleteItem;
  TabControl1.Tabs.Text := SInspectorTabs;
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := CaFree;
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.FormShow(Sender: TObject);
begin
  if Assigned(TreeView.Source) then
    with TreeView.Source do
    begin
      TreeView.MultiSelect:=ActionAllowed(0,acMultiSelect);
      ToolPanel.Visible:=ActionAllowed(0,acShowToolBar);
      TreeView.ShowLines:=ActionAllowed(0,acShowLines);
      TreeView.ShowRoot:=TreeView.ShowLines;
    end;
  AllowButtons(0);
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #27) and not(TreeView.IsEditing)then
  begin
    Close;
    key := #0;
  end;
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.RefrButClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
      TreeView.RefreshTree;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.UpButClick(Sender: TObject);
var
  Sel : TTreeNode;
begin
  with TreeView,Items do
    if Assigned(Selected) and  Assigned(Selected.Parent) then
    begin
      Sel := Selected;
      DeselectAllItems;
      Selected := Sel.Parent;
    end;
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.NewButClick(Sender: TObject);
begin
  with TReeView,Items do
    Add(Selected,'')
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.NewSubButtonClick(Sender: TObject);
begin
  with TreeView,Items do
    AddChild(Selected,'');
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.DeleteButtonClick(Sender: TObject);
begin
  SelectInspector(nil);
  TreeView.DeleteSelectedItems;
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.TreeViewSelectionChanged(Sender: TObject; Node: TTreeNode);
begin
  DesignerSelectComponent;
  if  Assigned(Node)  then
    AllowButtons(TDCTreeNode(Node).ObjId)
  else
    AllowButtons(0);
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.TreeViewKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if not TreeView.IsEditing and (Key = Vk_Delete) and (DeleteButton.Enabled) then
    DeleteButtonClick(Self);
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.TabControl1Change(Sender: TObject);
begin
  If TabControl1.TabIndex = 0 then
    Inspector.Filter:=tkAny-tkMethods
  else
    Inspector.Filter:=tkmethods;

end;

{------------------------------------------------------------------}

procedure TTreeInspForm.SelectInspector(AList : TList);
begin
  if Assigned(TreeView.Source)  and TreeView.Source.ActionAllowed(0,acSelectInspector) then
    Inspector.CurrentControls := AList
  else
    Inspector.CurrentControl := nil;
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.DesignerSelectComponent;
begin
  SelectInspector(TreeView.InspectorControls)
end;

{------------------------------------------------------------------}

procedure TTreeInspForm.AllowButtons(ObjId:integer);
begin
  if TreeView.Source<> nil then
    with TreeView.Source do
    begin
      NewBut.Enabled:=ActionAllowed(ObjId,acCanAdd);
      NewSubButton.Enabled := ActionAllowed(ObjId,acCanAddChild);
      DeleteButton.Enabled := TreeView.CanDeleteSelection;
      StatusBar1.Panels[0].Text:=GetStatusLine(ObjId);
    end
  else
    StatusBar1.Panels[0].Text := '';
  with TreeView ,Items do
  begin
    DeleteButton.Enabled:=DeleteButton.Enabled and (Count>0 );
    UpBut.Enabled  := Assigned(Selected) and Assigned(Selected.Parent);
   end
end;

{------------------------------------------------------------------}

type
  TMSource = class(TTreeSource);


function GetEditForm(EditObject:TComponent;  const PropName:string;AClass:TTreeSourceClass):TTreeInspForm;
var
  Source:TTreeSource;
  S:string;
begin
  result := nil;
  if AClass = nil then
    AClass:=GetRegisteredTreeSource(EditObject.ClassType,PropName);
  if (Aclass = nil) or (EditObject = nil) then
    exit;
  result := TTreeInspForm.Create(Application);
  Source:=AClass.Create(result);
  TMSource(Source).SetTreeLink(EditObject);
  if Source is TDCPersistentSource then
    TDCPersistentSource(Source).PropName:=PropName;
  Source.ValidSource;
  with result do
  begin
    TreeView.Source := Source;
    S := EditObject.Name;
    if S = '' then
      S:= PropName
    else
      S:=S + '.'+PropName;
    Caption := S;
    FEditObject := EditObject;
  end;
end;

{------------------------------------------------------------------}

function  _InspectEdit(EditObject:TComponent; const PropName:string;AClass:TTreeSourceClass):TTreeInspForm;
var
  i:integer;
  F:TCustomForm;
begin
  for i:= 0 to ScreenFormCount-1 do
  begin
    F:= ScreenForms(i) ;
    if (F is TTreeInspForm) and (TTreeInspForm(F).FEditObject = EditObject) then
    begin
      result := TTreeInspForm(F) ;
      F.Show;
      exit;
    end;
  end;
  result := GetEditForm(EditObject,PropName,AClass);
  if result <> nil then
  begin
    result.KeyPreview := false;
    result.Show;
  end;
end;

{------------------------------------------------------------------}

function  EditTreeSource(ASource : TTreeSource):TTreeInspForm;
var
  i : integer;
  F : TcustomForm;
begin
  for i:= 0 to ScreenFormCount-1 do
  begin
    F:= ScreenForms(i) ;
    if (F is TTreeInspForm) and (TTreeInspForm(F).FEditObject = ASource) then
    begin
      result := TTreeInspForm(F) ;
      F.Show;
      exit;
    end;
  end;
  result := TTreeInspForm.Create(Application);
  with  result do
  begin
    TreeView.Source := ASource;
    Caption := ASource.Name;
    FEditObject := ASource;
    Show;
  end;
end;

{------------------------------------------------------------------}

procedure _ModalEdit(EditObject:TComponent; const PropName:string;AClass:TTreeSourceClass);
var
  F: TTreeInspForm;
begin
  F:= GetEditForm(EditObject,PropName,AClass);
  if F <> nil then
  try
    F.ShowModal;
  finally
    F.Free;
  end;
end;

{--------------TIDEExpert--------------------------------------------}

function  _FindForm(F:TCustomForm) : boolean;
var
  i :integer;
begin
  result := false;
  for i:= 0 to ScreenFormCount-1 do
    if ScreenForms(i) = F then
    begin
      result := true;
      break;
    end;
end;

{--------------------TDCModalTreeEdit--------------------------------}

function  TDCModalTreeEdit.GetAttributes : TPropertyAttributes;
begin
  result := [paReadOnly,paDialog];
end;

{------------------------------------------------------------------}

procedure TDCModalTreeEdit.Edit;
begin
  _ModalEdit(TComponent(GetComponent(0)),GetName,nil);
end;

{------------------------------------------------------------------}

function  TModalCollectEdit.GetValue : string;
begin
   result:='('+ GetPropType^.name+')';
end;

{------------------------------------------------------------------}

procedure TModalCollectEdit.Edit;
var
  F: TTreeInspForm;
begin
  F:= GetEditForm(TComponent(GetComponent(0)),GetName,TDCCollectSource);
  if F<> nil then
    with F do
    try
      //{$IFNDEF D3}
      Inspector.Designer := GetFormDesigner(GetComponent(0));
     // {$ENDIF}
      ShowModal;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

var
   WHook:THandle = 0;
   TreeForm : TTreeInspForm;

function  CallWndProcHook(code,Wparam,Lparam:integer):hresult;stdcall;
begin
  result:=CallNextHookEx(Whook,code,Wparam,Lparam);

  if (Code = HC_ACTION)  and (word(wParam) = word('Z')) and
     (KeyDataToShiftState(lParam) = [ssCtrl, ssAlt]) then
       TreeForm := _InspectEdit(Application,SVerbIdeInspector,nil);
end;

{------------------------------------------------------------------}

procedure ShowIDEInspector;
begin
  TreeForm  :=_InspectEdit(Application,SVerbIdeInspector,nil);
end;

{------------------------------------------------------------------}

procedure InitializeIdeInspector;
begin
  WHook := SetWindowsHookEx(WH_KEYBOARD, @CallWndProcHook, 0, GetCurrentThreadId);
end;

{------------------------------------------------------------------}

procedure FinalizeIdeInspector;
begin
  if not (CsDestroying in Application.ComponentState) and   _FindForm(TreeForm) then
    TreeForm.Free;
  if WHook <> 0 then
    UnhookWindowsHookEx(WHook);
end;

{------------------------------------------------------------------}
//BeginSkipConst
procedure _InstantRegister;
begin
  RegisterPropertyEditor(TypeInfo(TListItems),nil,'',TDCModalTreeEdit);
  RegisterPropertyEditor(TypeInfo(TListColumns),nil,'',TModalCollectEdit);
  RegisterPropertyEditor(TypeInfo(TTreeNodes),nil,'',TDCModalTreeEdit);
  RegisterVisualProperty(SVerbItemsEditor,TTreeView,'Items');
  RegisterVisualProperty(SVerbItemsEditor,TListView,'Items');

end;
//EndSkipConst
{------------------------------------------------------------------}

const
  VerbArray:Array[0..0] of TVerbData=(
    (Name:'Tools.IDEInspector';GetState:nil;Execute:ShowIDEInspector)); //don't resource

procedure _Register;
begin
  RegisterVerbArray(VerbArray);
end;

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
  RegisterForInstant(_InstantRegister);
end;

{------------------------------------------------------------------}

initialization
  RunRegister;
finalization
  FinalizeIdeInspector;
end.
