unit DictMetaForm;

{ $Id: DictMetaForm.pas,v 1.5 2015/07/02 11:41:03 lukyanets Exp $ }

interface

uses
  SysUtils, WinTypes, WinProcs, Messages,
  Classes, Graphics, Controls,
  Forms, Dialogs, vtForm, vtDialogs,
  l3DatLst,
  Buttons, ExtCtrls, StdCtrls, OvcBase, Vlister, VOtliner,
  Dt_Const, DT_Types, DT_Dict, vtHeader,
  VConst,
  Mask, ToolEdit, TB97ctls, VCtrls,  Menus, BtnDlg, vtCtrls,
  afwTextControlPrim, afwTextControl, vtPanel, afwControlPrim,
  afwBaseControl, afwControl, afwInputControl, vtLister, vtOutliner;

type
  TDictShowMode = (dmShow, dmEdit);

  TDictMetaForm = class(TBtnDlg)
    DictOutliner: TvtOutliner;
    Footer: TvtHeader;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    //procedure WMWinSetBtn(var Message: TMessage); message wm_WinSetBtn;
    procedure WMWinAddClick(var Message: TMessage); message wm_WinAddClick;
    procedure WMWinEditClick(var Message: TMessage); message wm_WinEditClick;
    procedure WMWinDelClick(var Message: TMessage); message wm_WinDelClick;

    //procedure FormDestroy(Sender: TObject);
    procedure DictOutlinerActionElement(Sender: TObject; Index : Longint);
    procedure sbSaveToFile(Sender: TObject);
    procedure SortLevel; virtual;
    procedure DictOutlinerCurrentChanged(Sender: TObject; NewCurrent: Longint);
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

    procedure miAddClick(Sender: TObject);
    procedure miDelClick(Sender: TObject);
    procedure miEditClick(Sender: TObject);
  private
    fShowMode : TDictShowMode;
    fDictID   : integer;
    fReadOnly : Boolean;
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
    constructor Create(aOwner : TComponent; aDictID : integer; aShowMode : TDictShowMode); reintroduce;

    procedure   SetSpeedButton(Enabled : Boolean); override;
    property    DictID : Integer read fDictID;
    property    ShowMode : TDictShowMode read fShowMode;
    property    ReadOnly : Boolean read fReadOnly write SetReadOnly;
  end;

implementation

{$R *.DFM}
Uses Windows,
     l3Types,
     l3Base, l3MinMax,
     l3String,
     Str_Man,
     StrShop, IconShop,
     ObjList,
     DT_Serv, Dt_Link,
     l3Filer,
     l3IniFile, IniShop, DictsSup,
     l3Nodes,l3Tree_TLB,
     l3TreeSupport,
     Main, d_NameEd, {d_TrSave,} d_DelRpl, d_GetSrc, dShowEqI;

constructor TDictMetaForm.Create(aOwner : TComponent; aDictID : integer; aShowMode : TDictShowMode);
 begin
  Inherited Create(aOwner);
  fShowMode := aShowMode;
  fDictID := aDictID;

  Case fShowMode of
   dmShow : begin
             ButtonPanel.Visible := True;
             Caption := 'ÑËÎÂÀÐÜ "' + GetAttrName(fDictID) + '"';
            end;

   dmEdit : begin
             ButtonPanel.Visible := False;
             Caption := 'ÄÈÇÀÉÍÅÐ ÑËÎÂÀÐß "' + GetAttrName(fDictID) + '"';
            end;
  end;

  MainForm.SetDictEditorEnable(fDictID, False {Enable});
 end;

procedure TDictMetaForm.FormShow(Sender: TObject);
 begin
  UserConfig.Section := PrefSectName;
  If fShowMode = dmEdit
   then
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
    Try
     UserConfig.ReadFormPlace(DictFormPlaceName,Self);
    except
    end;
 end;

procedure TDictMetaForm.CMDialogKey(var Message: TCMDialogKey);
 begin
  If (GetKeyState(VK_SHIFT) >= 0) and
     (GetKeyState(VK_CONTROL) >= 0) and
     (GetKeyState(VK_MENU) >= 0) and
     (Message.CharCode = vk_Return) and
     (ActiveControl = cbSearch)
   then

   else inherited;
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

  If fShowMode = dmEdit
   then UserConfig.WriteFormPlace(DictMDIFormPlaceName, Self)
   else UserConfig.WriteFormPlace(DictFormPlaceName, Self);

  //DictServ.DictRootNode[TdaDictionaryType(fDictID)].Save;
 end;

procedure TDictMetaForm.FormClose(Sender: TObject; var Action: TCloseAction);
 begin
  If fShowMode = dmEdit
   then Action := caFree
   else Action := caHide;
  MainForm.SetDictEditorEnable(fDictID, True {Enable});
 end;

procedure TDictMetaForm.SetSpeedButton(Enabled : Boolean);
 begin
  MainForm.acDictAdd        .Enabled := Enabled and not ReadOnly;
  MainForm.acDictEdit       .Enabled := Enabled and not ReadOnly;
  MainForm.acDictDelete     .Enabled := Enabled and not ReadOnly;
  MainForm.acDictSaveToFile .Enabled := Enabled and not ReadOnly;
  MainForm.acDictSort       .Enabled := Enabled and not ReadOnly and (fShowMode = dmEdit);
 end;

procedure TDictMetaForm.SortLevel;
 begin
  DictOutliner.GetCurrentNode.SortChilds;
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

{procedure TDictMetaForm.WMWinSetBtn(var Message: TMessage);
 begin
  //If FShowMode <> smEdit then Exit;
  SetSpeedButton(Boolean(Message.WParam));
 end;
}
procedure TDictMetaForm.WMWinAddClick(var Message: TMessage);
 begin
  AddItem;
 end;              

procedure TDictMetaForm.WMWinDelClick(var Message: TMessage);
 begin
  DeleteItem;
 end;

procedure TDictMetaForm.WMWinEditClick(var Message: TMessage);
 begin
  EditItem(DictOutliner.Current);
 end;

procedure TDictMetaForm.DictOutlinerActionElement(Sender: TObject; Index : Longint);
 begin
  EditItem(Index);
 end;

procedure TDictMetaForm.miAddClick(Sender: TObject);
 begin
  AddItem;
 end;

procedure TDictMetaForm.miDelClick(Sender: TObject);
 begin
  DeleteItem;
 end;

procedure TDictMetaForm.miEditClick(Sender: TObject);
 begin
  EditItem(DictOutliner.Current);
 end;

procedure TDictMetaForm.sbSaveToFile(Sender: TObject);
begin
 SaveToFile;
end;

procedure TDictMetaForm.SetReadOnly(aValue : Boolean);
begin
 If fReadOnly <> aValue then
 begin
  fReadOnly := aValue;
  If MainForm.ActiveMDIChild = Self then SetSpeedButton(Enabled);
 end;
end;

procedure TDictMetaForm.SaveToFile;
 var
  lFileName: string;
 begin
  If vtExecuteSaveDialog(lFileName, sidTXTDlgFilter) then
   DictOutliner.TreeSource.PrintTreeList(lFileName, True {False}, 0, '    ');
 end;

procedure TDictMetaForm.DictOutlinerCurrentChanged(Sender: TObject; NewCurrent: Longint);
 var
  lHNode : Il3HandleNode;
 begin
  Footer.Sections[0] := Format('%d èç %d', [NewCurrent+1,DictOutliner.Total]);
 end;

procedure TDictMetaForm.tbCollapseBranchClick(Sender: TObject);
 var
  lNode : Il3Node;
 begin
  lNode := DictOutliner.GetCurrentNode;

  If not DictOutliner.TreeSource.IsExpanded(lNode) then
   lNode := DictOutliner.TreeSource.RootNode;

  DictOutliner.ExpandNodeOnDeep(lNode, False, 0);
 end;

procedure TDictMetaForm.tbCollapseBranchLevelClick(Sender: TObject);
 var
  lNode : Il3Node;
 begin
  lNode := DictOutliner.GetCurrentNode;

  If not DictOutliner.TreeSource.IsExpanded(lNode) then
   lNode := lNode.ParentNode;

  DictOutliner.ExpandNodeOnDeep(lNode, False, 1);
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
  If Length(cbSearch.Text) = 0 then Exit;

  If cbSearch.Text[1] = '#' then
  begin
   //If FromCurrent
   // then lFromNode := GetNode(Current)
   // else lFromNode := FTreeSource.RootNode;

   lFindNode := l3FindNodeByHandle(DictOutliner.TreeSource.RootNode,
                                   StrToInt(System.Copy(cbSearch.Text,2,255)),
                                   imNoSubRoot,
                                   DictOutliner.GetNode(DictOutliner.Current));

   DictOutliner.GotoOnNode(lFindNode);
  end
  else
  begin
   Screen.Cursor:=crHourGlass;
   try
    DictOutliner.SearchOccurStr(cbSearch.Text, True);
   finally
    Screen.Cursor:=crDefault;
   end;
  end;
  Application.ProcessMessages;
  cbSearch.AddToHistory;
 end;

procedure TDictMetaForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 If (Key = VK_RETURN) and (ActiveControl = cbSearch)
  then
   sbSearchClick(Self);
end;

function TDictMetaForm.CheckMayBeSelected(aIndex : Integer) : Boolean;
 var
  PN : Il3Node;
 begin
  try
   PN := DictOutliner.TreeSource.Nodes[aIndex];
   If (PN as Il3HandleNode).Handle = 0
    then
     begin
      Result := False;
      Exit;
     end;

   Result := fAllowSelNonLeaf;
   If not Result then
    begin
     Result := not PN.HasChild;
    end;
  except
   Result := False;
  end;
 end;

procedure TDictMetaForm.OKClick(Sender: TObject);
 begin
  If not (DictOutliner.MultiSelect or CheckMayBeSelected(DictOutliner.Current))
   then
    ModalResult := mrNone;
 end;

procedure TDictMetaForm.DictOutlinerSelectChange(Sender: TObject;
                                                 Index: Integer;
                                                 var SelectedState: Integer);
begin
 If (SelectedState <> 0)  then SelectedState := Ord(CheckMayBeSelected(Index));
end;

end.
