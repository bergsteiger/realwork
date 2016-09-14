unit DictMetaForm;

{ $Id: DictMetaForm.pas,v 1.45 2016/09/14 11:35:37 dinishev Exp $ }

interface

uses
  SysUtils,
  WinTypes,
  WinProcs,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  BtnDlg,
  ComCtrls,

  vtForm,
  vtDialogs,
  vtlister,
  vtOutliner,
  vtHeader,
  vtCtrls,
  vtStatusBar,

  l3DatLst,

  Buttons,
  ExtCtrls,
  StdCtrls,
  OvcBase,

  daTypes,

  Dt_Const,
  DT_Types,
  dt_AttrSchema, 
  DT_Dict, 
  
  VConst,

  Mask, 
  ToolEdit,

  TB97ctls, 
  
  afwControl, 
  afwInputControl, ActnList, afwControlPrim, afwBaseControl,

  arTypes;

type
  TDictShowMode = (dmShow, dmEdit);

  TDictMetaForm = class(TBtnDlg)
    DictOutliner: TvtOutliner;
    Panel1: TPanel;
    tbCollapseBranch: TSpeedButton;
    tbCollapseBranchLevel: TSpeedButton;
    tbExpandBranchLevel: TSpeedButton;
    tbExpandBranch: TSpeedButton;
    cbSearch: TvtComboBox;
    sbSearch: TSpeedButton;
    menuDictions: TMainMenu;
    miDictions: TMenuItem;
    miAdd: TMenuItem;
    miEdit: TMenuItem;
    miDel: TMenuItem;
    Footer: TvtStatusBar;
    DictEditActionList: TActionList;
    acNew: TAction;
    acEdit: TAction;
    acDel: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    //procedure WMWinSetBtn(var Message: TMessage); message wm_WinSetBtn;
    procedure WMWinAddClick(var Message: TMessage); message wm_WinAddClick;
    procedure WMWinEditClick(var Message: TMessage); message wm_WinEditClick;
    procedure WMWinDelClick(var Message: TMessage); message wm_WinDelClick;

    //procedure FormDestroy(Sender: TObject);
    procedure DictOutlinerActionElement(Sender: TObject; Index : Longint);
    procedure sbSaveToFile(Sender: TObject);
    procedure SortLevel; virtual;
    procedure DictOutlinerCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
    procedure tbCollapseBranchClick(Sender: TObject);
    procedure tbCollapseBranchLevelClick(Sender: TObject);
    procedure tbExpandBranchLevelClick(Sender: TObject);
    procedure tbExpandBranchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbSearchClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure OKClick(Sender: TObject);

    procedure DictOutlinerSelectChange(Sender: TObject;
                                       Index: Integer;
                                       var SelectedState: Integer);

    procedure acAddClick(Sender: TObject);
    procedure acDelClick(Sender: TObject);
    procedure acEditClick(Sender: TObject);
    procedure DictOutlinerCountChanged(Sender: TObject; NewCount: Integer);
  private
    fShowMode : TDictShowMode;
    fDictID   : TdaDictionaryType;
    fReadOnly : Boolean;
    procedure WMServerStatusChanged(var Message: TMessage); message WM_SERVERSTATUSCHANGED;
  protected
    fAllowSelNonLeaf : Boolean;
    function CheckMayBeSelected(aIndex : Integer) : Boolean; virtual;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;

    procedure AddItem;                     virtual;
    procedure DeleteItem;                  virtual;
    procedure EditItem(aIndex : Longint);  virtual;
    procedure SaveToFile;                  virtual;

    procedure SetReadOnly(aValue : Boolean);

  public
    constructor Create(aOwner : TComponent; aDictID : TdaDictionaryType; aShowMode : TDictShowMode); reintroduce;

    procedure   SetSpeedButton(Enabled : Boolean); override;
    property    DictID : TdaDictionaryType read fDictID;
    property    ShowMode : TDictShowMode read fShowMode;
    property    ReadOnly : Boolean read fReadOnly write SetReadOnly;
  end;

implementation

{$R *.DFM}

uses
  Windows,

  l3Types,
  l3Base, 
  l3MinMax,
  l3String,
  l3TreeInterfaces,
  l3Filer,
  l3IniFile, 
  l3Nodes,l3Tree_TLB,
  l3TreeSupport,
     
  StrShop, 
  ResShop,
  ObjList,

  DT_Serv, 
  Dt_Link,

  IniShop, 
  DictsSup,

  Main, 

  d_NameEd, 
  d_DelRpl,

  ArchiUserRequestManager;

constructor TDictMetaForm.Create(aOwner : TComponent; aDictID : TdaDictionaryType; aShowMode : TDictShowMode);
begin
 inherited Create(aOwner);
 fShowMode := aShowMode;
 fDictID := aDictID;
 case fShowMode of
  dmShow : begin
            ButtonPanel.Visible := True;
            Caption := 'ÑËÎÂÀÐÜ "' + GetDictName(fDictID) + '"';
           end;

  dmEdit : begin
            ButtonPanel.Visible := False;
            Caption := 'ÄÈÇÀÉÍÅÐ ÑËÎÂÀÐß "' + GetDictName(fDictID) + '"';
           end;
 end;
 MainForm.SetDictEditorEnable(fDictID, False);
end;

procedure TDictMetaForm.FormShow(Sender: TObject);
begin
 UserConfig.Section := PrefSectName;
 if fShowMode = dmEdit then
 begin
  try
   FormStyle := fsMDIChild;
   //Visible := True;
  except
  end;
  try
   UserConfig.ReadFormPlace(DictMDIFormPlaceName,Self);
  except
  end;
 end
 else
  try
   UserConfig.ReadFormPlace(DictFormPlaceName,Self);
  except
  end;
 MainForm.CheckServer(True);
 Perform(WM_SERVERSTATUSCHANGED, 0, 0); 
end;

procedure TDictMetaForm.CMDialogKey(var Message: TCMDialogKey);
begin
 if not((GetKeyState(VK_SHIFT) >= 0) and
    (GetKeyState(VK_CONTROL) >= 0) and
    (GetKeyState(VK_MENU) >= 0) and
    (Message.CharCode = vk_Return) and
    (ActiveControl = cbSearch)) then
 inherited;
end;

procedure TDictMetaForm.FormCreate(Sender: TObject);
begin
 cbSearch.Items.Clear;
 UserConfig.Section := FindHistorySectName;
 UserConfig.ReadParamList(FindHistorySectName, cbSearch.Items);
end;

procedure TDictMetaForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose := True;
 UserConfig.Section := FindHistorySectName;
 UserConfig.WriteParamList(FindHistorySectName, cbSearch.Items);

 UserConfig.Section := PrefSectName;

 if fShowMode = dmEdit then 
  UserConfig.WriteFormPlace(DictMDIFormPlaceName, Self)
 else 
  UserConfig.WriteFormPlace(DictFormPlaceName, Self);
end;

procedure TDictMetaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if fShowMode = dmEdit then 
  Action := caFree
 else 
  Action := caHide;
 MainForm.SetDictEditorEnable(fDictID, True);
 MainForm.CheckCurrChild(Self);
end;

procedure TDictMetaForm.SetSpeedButton(Enabled : Boolean);
begin
 acNew                     .Enabled := Enabled and not ReadOnly and (fShowMode = dmEdit);
 acEdit                    .Enabled := Enabled and not ReadOnly and (fShowMode = dmEdit);
 acDel                     .Enabled := Enabled and not ReadOnly and (fShowMode = dmEdit);
 MainForm.acDictAdd        .Enabled := Enabled and not ReadOnly and (fShowMode = dmEdit);
 MainForm.acDictEdit       .Enabled := Enabled and not ReadOnly and (fShowMode = dmEdit);
 MainForm.acDictDelete     .Enabled := Enabled and not ReadOnly and (fShowMode = dmEdit);
 MainForm.acDictSaveToFile .Enabled := Enabled and not ReadOnly and (fShowMode = dmEdit);
 MainForm.acDictSort       .Enabled := Enabled and not ReadOnly and (fShowMode = dmEdit);
end;

procedure TDictMetaForm.SortLevel;
begin
 (DictOutliner.GetCurrentNode As Il3Node).SortChilds;
end;

procedure TDictMetaForm.AddItem;
begin
end;

procedure TDictMetaForm.DeleteItem;
begin
end;

procedure TDictMetaForm.EditItem(aIndex : Longint);
begin
end;

procedure TDictMetaForm.WMWinAddClick(var Message: TMessage);
begin
 if not MainForm.CheckServer then
  Exit;
 AddItem;
end;

procedure TDictMetaForm.WMWinDelClick(var Message: TMessage);
begin
 if not MainForm.CheckServer then
  Exit;
 DeleteItem;
end;

procedure TDictMetaForm.WMWinEditClick(var Message: TMessage);
begin
 if not MainForm.CheckServer then
  Exit;
 EditItem(DictOutliner.Current);
end;

procedure TDictMetaForm.DictOutlinerActionElement(Sender: TObject; Index : Longint);
begin
 if (not ArchiRequestManager.ServerOnline) or (not MainForm.CheckServer) then
  Exit;
 EditItem(Index);
end;

procedure TDictMetaForm.acAddClick(Sender: TObject);
begin
 if not MainForm.CheckServer then
  Exit;
 AddItem;
end;

procedure TDictMetaForm.acDelClick(Sender: TObject);
begin
 if not MainForm.CheckServer then
  Exit;
 DeleteItem;
end;

procedure TDictMetaForm.acEditClick(Sender: TObject);
begin
 if not MainForm.CheckServer then
  Exit;
 EditItem(DictOutliner.Current);
end;

procedure TDictMetaForm.sbSaveToFile(Sender: TObject);
begin
 SaveToFile;
end;

procedure TDictMetaForm.SetReadOnly(aValue : Boolean);
begin
 if fReadOnly <> aValue then
 begin
  fReadOnly := aValue;
  if MainForm.ActiveMDIChild = Self then SetSpeedButton(Enabled);
 end;
end;

procedure TDictMetaForm.SaveToFile;
var
 l_FileName: AnsiString;
begin
 if vtExecuteSaveDialog(l_FileName, sidTXTDlgFilter) then
  DictOutliner.CTree.PrintTreeList(l_FileName, True, 0, '    ');
end;

procedure TDictMetaForm.DictOutlinerCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
begin
 Footer.Panels[0].Text := Format(scFmtFuterCounter, [Succ(aNewCurrent),DictOutliner.Total]);
end;

procedure TDictMetaForm.DictOutlinerCountChanged(Sender: TObject; NewCount: Integer);
begin
 Footer.Panels[0].Text := Format(scFmtFuterCounter, [Succ(DictOutliner.Current), NewCount]);
end;

procedure TDictMetaForm.tbCollapseBranchClick(Sender: TObject);
var
 l_Node : Il3SimpleNode;
begin
 l_Node := DictOutliner.GetCurrentNode;

 if not DictOutliner.TreeStruct.IsExpanded(l_Node) then
  l_Node := DictOutliner.TreeStruct.RootNode;

 DictOutliner.ExpandNodeOnDeep(l_Node, False, 0);
end;

procedure TDictMetaForm.tbCollapseBranchLevelClick(Sender: TObject);
var
 l_Node : Il3SimpleNode;
begin
 l_Node := DictOutliner.GetCurrentNode;

 if not DictOutliner.TreeStruct.IsExpanded(l_Node) then
  l_Node := l_Node.Parent;

 DictOutliner.ExpandNodeOnDeep(l_Node, False, 1);
end;

procedure TDictMetaForm.tbExpandBranchLevelClick(Sender: TObject);
begin
 DictOutliner.ExpandNodeOnDeep(DictOutliner.GetCurrentNode, True, 1);
end;

procedure TDictMetaForm.tbExpandBranchClick(Sender: TObject);
begin
 DictOutliner.ExpandNodeOnDeep(DictOutliner.GetCurrentNode, True, 0);
end;

procedure TDictMetaForm.sbSearchClick(Sender: TObject);
var
 lFindNode : Il3Node;
 lFromNode : Il3Node;
begin
 if Length(cbSearch.Text) = 0 then Exit;

 if cbSearch.Text[1] = '#' then
 begin
  lFindNode := l3FindNodeByHandle(DictOutliner.CTree.CRootNode,
                                  StrToInt(System.Copy(cbSearch.Text, 2, 255)),
                                  imNoSubRoot,
                                  DictOutliner.GetNode(DictOutliner.Current) As Il3Node);

  DictOutliner.GotoOnNode(lFindNode As Il3SimpleNode);
 end
 else          
 begin
  Screen.Cursor := crHourGlass;
  try
   DictOutliner.SearchOccurStr(cbSearch.Text, True);
  finally
   Screen.Cursor := crDefault;
  end;
 end;
 Application.ProcessMessages;
 cbSearch.AddToHistory;
end;

procedure TDictMetaForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (Key = VK_RETURN) and (ActiveControl = cbSearch) then
  sbSearchClick(Self);
end;

function TDictMetaForm.CheckMayBeSelected(aIndex : Integer) : Boolean;
 var
  PN : Il3SimpleNode;
 begin
  try
   PN := DictOutliner.TreeStruct.Nodes[aIndex];
   if DictOutliner.TreeStruct.RootNode.IsSame(PN) then
   begin
    Result := False;
    Exit;
   end;

   Result := fAllowSelNonLeaf;
   if not Result then
    Result := not PN.HasChild;
  except
  Result := False;
 end;
end;

procedure TDictMetaForm.OKClick(Sender: TObject);
begin
 if not (DictOutliner.MultiSelect or CheckMayBeSelected(DictOutliner.Current)) then
  ModalResult := mrNone;
end;

procedure TDictMetaForm.DictOutlinerSelectChange(Sender: TObject;
                                                 Index: Integer;
                                                 var SelectedState: Integer);
begin
 if (SelectedState <> 0) then
  SelectedState := Ord(CheckMayBeSelected(Index));
end;

procedure TDictMetaForm.WMServerStatusChanged(var Message: TMessage);
var
 l_Online: Boolean;
begin
 l_Online := ArchiRequestManager.ServerOnline;
 SetSpeedButton(l_Online);
end;

procedure TDictMetaForm.FormDestroy(Sender: TObject);
begin
 MainForm.CheckCurrChild(Self);
end;


end.
