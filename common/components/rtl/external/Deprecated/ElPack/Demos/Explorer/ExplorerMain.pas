{====================================================}
{                                                    }
{   EldoS Shell Components Example                   }
{                                                    }
{   1998-2003, EldoS Corporation                     }
{                                                    }
{====================================================}

unit ExplorerMain;
{$B-,O-,D+}

{
 todo:
   - форма настроек
   - кнопа фильтров, обновить, ?истории?
   - ...
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ElACtrls, ElShellCtl, ExtCtrls, ElPanel, ElToolbar, ElSplit,
  ElTools, ShellAPI, ElShellUtils, ShlObj, ElXPThemedControl, ElTree, ElPopBtn, Menus,
  ElStatBar, ElMenus, ElCLabel, ElLabel, ElImgLst;

type
  TfrmElShellExplorer = class(TForm)
    Tree: TElShellTree;
    List: TElShellList;
    Splitter: TElSplitter;
    MainMenu: TElMainMenu;
    ElMenuItem_File: TElMenuItem;
    ElMenuItem_File_Close: TElMenuItem;
    Toolbar_StdBtns: TElToolBar;
    Toolbar_StdBtns_Up: TElToolButton;
    ElSB: TElStatusBar;
    ElMenuItem_Help: TElMenuItem;
    ElMenuItem_Edit: TElMenuItem;
    ElMenuItem_Tools: TElMenuItem;
    ElMenuItem_View: TElMenuItem;
    ElMenuItem_Help_About: TElMenuItem;
    ElMenuItem_Tools_FolderOptions: TElMenuItem;
    ElMenuItem_View_Toolbars: TElMenuItem;
    ElMenuItem_View_Toolbars_DefBth: TElMenuItem;
    ElMenuItem_View_Toolbars_AdressBar: TElMenuItem;
    ElMenuItem_View_Toolbars_Line: TElMenuItem;
    ElMenuItem_View_Toolbars_Lock: TElMenuItem;
    ElMenuItem_View_Toolbars_Cust: TElMenuItem;
    ElMenuItem_View_Toolbars_Statusbar: TElMenuItem;
    ElMenuItem_View_Toolbars_ExplorBar: TElMenuItem;
    ElMenuItem_VTE_Folders: TElMenuItem;
    ElMenuItem_VTE_Files: TElMenuItem;
    ElMenuItem_View_Line1: TElMenuItem;
    ElMenuItem_View_Sort: TElMenuItem;
    ElMenuItem_View_Line2: TElMenuItem;
    ElMenuItem_View_Refresh: TElMenuItem;
    ElMenuItem_View_Line3: TElMenuItem;
    ElMenuItem_View_List: TElMenuItem;
    ElMenuItem_View_Details: TElMenuItem;
    ToolBar_Address: TElToolBar;
    lbAddress: TElLabel;
    Combo: TElShellComboBox;
    ElToolButton_Go: TElToolButton;
    Img20x20: TElImageList;
    Img20x20Hot: TElImageList;
    Img24x24: TElImageList;
    Img24x24Disabled: TElImageList;
    Toolbar_StdBtns_Back: TElToolButton;
    Toolbar_StdBtns_Next: TElToolButton;
    ElToolButton3: TElToolButton;
    Toolbar_StdBtns_Search: TElToolButton;
    Toolbar_StdBtns_Folders: TElToolButton;
    Toolbar_StdBtns_Delete: TElToolButton;
    ElToolButton7: TElToolButton;
    Toolbar_StdBtns_View: TElToolButton;
    pm_View: TElPopupMenu;
    pm_View_Detail: TElMenuItem;
    pm_View_List: TElMenuItem;
    ElMenuItem_View_Sort_Def: TElMenuItem;
    ElMenuItem_View_Sort_Name: TElMenuItem;
    ElMenuItem_View_Sort_Size: TElMenuItem;
    ElMenuItem_View_Sort_Type: TElMenuItem;
    ElMenuItem_View_Sort_Modified: TElMenuItem;
    ElMenuItem_View_Sort_Creation: TElMenuItem;
    ElMenuItem_View_Sort_Accessing: TElMenuItem;
    ElMenuItem_View_Sort_L1: TElMenuItem;
    ElMenuItem_VTE_CheckChild: TElMenuItem;
    ElMenuItem_VTE_ClearOnCollapse: TElMenuItem;
    ElMenuItem_VTE_AutoExpand: TElMenuItem;
    ElMenuItem1: TElMenuItem;
    ElMenuItem2: TElMenuItem;
    ElMenuItem3: TElMenuItem;
    ElMenuItem4: TElMenuItem;
    ElMenuItem5: TElMenuItem;
    ElMenuItem6: TElMenuItem;
    ElMenuItem7: TElMenuItem;
    ElMenuItem8: TElMenuItem;
    ElMenuItem9: TElMenuItem;
    ElMenuItem10: TElMenuItem;
    ElMenuItem11: TElMenuItem;
    ElMenuItem12: TElMenuItem;
    ElMenuItem13: TElMenuItem;
    ElMenuItem14: TElMenuItem;
    ElMenuItem15: TElMenuItem;
    ElMenuItem16: TElMenuItem;
    ElMenuItem17: TElMenuItem;
    ElMenuItem18: TElMenuItem;
    ElMenuItem19: TElMenuItem;
    ElMenuItem20: TElMenuItem;
    pm_List: TElPopupMenu;
    pm_List_View: TElMenuItem;
    pm_List_CustomizeFolder: TElMenuItem;
    pm_List_L2: TElMenuItem;
    pm_List_Refresh: TElMenuItem;
    pm_List_Arange: TElMenuItem;
    pm_List_L1: TElMenuItem;
    pm_List_Properties: TElMenuItem;
    pm_List_New: TElMenuItem;
    pm_List_L4: TElMenuItem;
    pm_List_PasteShortcut: TElMenuItem;
    pm_List_Paste: TElMenuItem;
    pm_List_L3: TElMenuItem;
    ElMenuItem35: TElMenuItem;
    ElMenuItem36: TElMenuItem;
    ElMenuItem28: TElMenuItem;
    ElMenuItem_View_ShowFolders: TElMenuItem;
    procedure Toolbar_StdBtns_UpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeItemFocused(Sender: TObject);
    procedure ElMenuItem_File_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ElMenuItem_VTE_FilesClick(Sender: TObject);
    procedure SplitterPositionChanged(Sender: TObject);
    procedure ElMenuItem_VTE_FoldersClick(Sender: TObject);
    procedure ElMenuItem_View_ListClick(Sender: TObject);
    procedure ElMenuItem_View_DetailsClick(Sender: TObject);
    procedure ListItemFocused(Sender: TObject);
    procedure ElMenuItem_View_Toolbars_StatusbarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Toolbar_StdBtns_FoldersClick(Sender: TObject);
    procedure ElMenuItem_View_Toolbars_DefBthClick(Sender: TObject);
    procedure ElMenuItem_View_Toolbars_AdressBarClick(Sender: TObject);
    procedure Toolbar_StdBtns_ViewClick(Sender: TObject);
    procedure ElToolButton_GoClick(Sender: TObject);
    procedure ElMenuItem_View_RefreshClick(Sender: TObject);
    procedure ElMenuItem_View_Sort_Click(Sender: TObject);
    procedure ElMenuItem_VTE_CheckChildClick(Sender: TObject);
    procedure ElMenuItem_VTE_ClearOnCollapseClick(Sender: TObject);
    procedure ElMenuItem_VTE_AutoExpandClick(Sender: TObject);
    procedure pm_List_PropertiesClick(Sender: TObject);
    procedure ElMenuItem_View_ShowFoldersClick(Sender: TObject);
  private
    { Private declarations }
    FTreeSaveWProportion :Double;
    procedure ShowFolders(Visible, NeedResize: Boolean);
  public
    { Public declarations }
  end;

var
  frmElShellExplorer: TfrmElShellExplorer;

implementation

{$R *.dfm}

procedure TfrmElShellExplorer.FormCreate(Sender: TObject);
  var
    PIDL :PItemIDList;
    Item :TElShellTreeItem;
begin
  TreeItemFocused(Sender);

  PIDL := GetFolderPIDL(sfoMyComputer, '');
  if Assigned(PIDL) then
  begin
    Item := Tree.GetItemForPIDL(PIDL);
    if Assigned(Item) then
      Item.Expand(False);
    FreeIDList(PIDL);
  end;
  ElMenuItem_View_ShowFolders.Checked := List.ShowFolders;
end;

// calculate form caption:
procedure TfrmElShellExplorer.TreeItemFocused(Sender: TObject);
 var
   sCap:String;
begin
  if Tree.ItemFocused <> nil then
  begin
    sCap := Tree.ItemFocused.FullName;
    if pos('::{', sCap)=1 then
      scap := Tree.ItemFocused.Text;
    Caption := 'EldoS Explorer - ' + sCap;
  end
  else
    Caption := 'EldoS Explorer';
  Toolbar_StdBtns_Up.Enabled := not IsDesktopPIDL(List.RootPIDL);
end;

procedure TfrmElShellExplorer.ListItemFocused(Sender: TObject);
 var
   sCap:String;
begin
  if List.ItemFocused <> nil then
  begin
    //List.ItemFocused.Expanded := true;
    sCap := List.ItemFocused.FullName;
    if pos('::{', sCap)=1 then
      scap := List.ItemFocused.Text;
    Caption := 'EldoS Explorer - ' + sCap;
  end
  else
    Caption := 'EldoS Explorer';
  Toolbar_StdBtns_Up.Enabled := not IsDesktopPIDL(List.RootPIDL);
end;

procedure TfrmElShellExplorer.Toolbar_StdBtns_UpClick(Sender: TObject);
begin
  List.BackToParentPIDL;
end;

procedure TfrmElShellExplorer.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  (*
  if (Key=VK_TAB) and (ssCtrl in Shift) and ( ([ssShift, ssAlt] * Shift)=[]) {and
     (not Combo.Focused){}
  then
  begin
    // Alternative to <Shift Tab> like system Explorer
    // ...
    Key := 0;
  end;
  //*)
end;

procedure TfrmElShellExplorer.ElMenuItem_File_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmElShellExplorer.ElMenuItem_VTE_FilesClick(Sender: TObject);
begin
  Tree.ShowFiles := not Tree.ShowFiles;
  ElMenuItem_VTE_Files.Checked := Tree.ShowFiles;
end;

procedure TfrmElShellExplorer.SplitterPositionChanged(Sender: TObject);
begin
  if Splitter.SnappedLeft then
  begin
    ShowFolders( False, False);
  end
  else
  begin
    if ElMenuItem_VTE_Folders.Checked then
      ShowFolders( True, False);
  end;
end;

procedure TfrmElShellExplorer.ShowFolders(Visible, NeedResize: Boolean);
begin
  if Visible then
  begin
    List.ShellTreeView  := Tree;
    Combo.ShellTreeView := Tree;
    Tree.ShellListView  := List;
    Tree.ShellComboBox  := Combo;
    // set caption manager:
    List.OnItemFocused  := nil;
    Tree.OnItemFocused  := TreeItemFocused;
    // visible managment:
    if NeedResize then
    begin
      Splitter.Visible  := True;
      Tree.Visible      := True;
      if (Splitter.SizeBeforeSnap>Width) then
      begin
        Splitter.SizeBeforeSnap := Trunc(Width*FTreeSaveWProportion);
        if Splitter.SizeBeforeSnap = 0 then
          Splitter.SizeBeforeSnap := Width div 4;
      end;
    end;
  end
  else
  begin
    Tree.ShellListView  := nil;
    Tree.ShellComboBox  := nil;
    List.ShellTreeView  := nil;
    Combo.ShellTreeView := nil;
    // set caption manager:
    Tree.OnItemFocused  := nil;
    List.OnItemFocused  := ListItemFocused;
    // visible managment:
    if NeedResize then
    begin
      FTreeSaveWProportion := Tree.Width/Width;
      Tree.Visible      := False;
      Splitter.Visible  := False;
    end;
  end;
end;

procedure TfrmElShellExplorer.ElMenuItem_VTE_FoldersClick(Sender: TObject);
begin
  ElMenuItem_VTE_Folders.Checked := not ElMenuItem_VTE_Folders.Checked;
  ShowFolders( ElMenuItem_VTE_Folders.Checked, True);
  Toolbar_StdBtns_Folders.AllowAllUp := not ElMenuItem_VTE_Folders.Checked;
  Toolbar_StdBtns_Folders.Down := ElMenuItem_VTE_Folders.Checked;
end;

procedure TfrmElShellExplorer.Toolbar_StdBtns_FoldersClick(Sender: TObject);
begin
  ElMenuItem_VTE_FoldersClick(Sender);
end;

procedure TfrmElShellExplorer.ElMenuItem_View_ListClick(Sender: TObject);
begin
  if List.ShowColumns then
  begin
    ElMenuItem_View_List.Checked    := True;
    pm_View_List.Checked    := True;
    List.ShowColumns := False;
  end;
end;

procedure TfrmElShellExplorer.ElMenuItem_View_DetailsClick(Sender: TObject);
begin
  if not List.ShowColumns then
  begin
    ElMenuItem_View_Details.Checked := True;
    pm_View_Detail.Checked    := True;
    List.ShowColumns := True;
  end;
end;

procedure TfrmElShellExplorer.ElMenuItem_View_Toolbars_StatusbarClick(Sender: TObject);
begin
  ElSB.Visible := not ElSB.Visible;
  ElMenuItem_View_Toolbars_Statusbar.Checked := ElSB.Visible;
end;

procedure TfrmElShellExplorer.FormResize(Sender: TObject);
begin
  Combo.Width := ToolBar_Address.ClientWidth - ElToolButton_Go.Width - Combo.Left - 10;
end;

procedure TfrmElShellExplorer.ElMenuItem_View_Toolbars_DefBthClick(Sender: TObject);
begin
  Toolbar_StdBtns.Visible := not Toolbar_StdBtns.Visible;
  ElMenuItem_View_Toolbars_DefBth.Checked := Toolbar_StdBtns.Visible;
end;

procedure TfrmElShellExplorer.ElMenuItem_View_Toolbars_AdressBarClick(Sender: TObject);
begin
  ToolBar_Address.Visible := not Toolbar_StdBtns.Visible;
  ElMenuItem_View_Toolbars_AdressBar.Checked := ToolBar_Address.Visible;
end;

procedure TfrmElShellExplorer.Toolbar_StdBtns_ViewClick(Sender: TObject);
begin
  if pm_View_List.Checked then
    ElMenuItem_View_DetailsClick(Sender)
  else
    ElMenuItem_View_ListClick(Sender);
end;

procedure TfrmElShellExplorer.ElToolButton_GoClick(Sender: TObject);
  var
    sGo: String;
begin
  sGo := Combo.EditorText;
  if Length(sGo)<2 then
    exit;

  if ElMenuItem_VTE_Folders.Checked and Tree.Visible then
    Tree.SetSelectionPath(sGo, ptFolderOrFile)
  else
    Combo.SetSelectionPath(sGo);
end;

procedure TfrmElShellExplorer.ElMenuItem_View_RefreshClick(
  Sender: TObject);
begin
  List.RefreshList(True);
  if ElMenuItem_VTE_Folders.Checked and Tree.Visible then
    Tree.RefreshTree(Tree.ItemFocused, 0);
end;

procedure TfrmElShellExplorer.ElMenuItem_View_Sort_Click(Sender: TObject);
  var
    mItem :TElMenuItem absolute Sender;
begin
  if ElMenuItem_VTE_Folders.Checked and Tree.Visible and Tree.ShowFiles and Tree.Focused then
    Tree.SortType := TElShellSortType(mItem.Tag)
  else
    List.SortType := TElShellSortType(mItem.Tag);
end;

procedure TfrmElShellExplorer.ElMenuItem_VTE_CheckChildClick(Sender: TObject);
begin
  Tree.CheckForChildren := not Tree.CheckForChildren;
  ElMenuItem_VTE_CheckChild.Checked := Tree.CheckForChildren;
end;

procedure TfrmElShellExplorer.ElMenuItem_VTE_ClearOnCollapseClick(
  Sender: TObject);
begin
  Tree.ClearOnCollapse := not Tree.ClearOnCollapse;
  ElMenuItem_VTE_ClearOnCollapse.Checked := Tree.ClearOnCollapse;
end;

procedure TfrmElShellExplorer.ElMenuItem_VTE_AutoExpandClick(Sender: TObject);
begin
  Tree.AutoExpand := not Tree.AutoExpand;
  ElMenuItem_VTE_AutoExpand.Checked := Tree.AutoExpand;
end;

procedure TfrmElShellExplorer.pm_List_PropertiesClick(Sender: TObject);
begin
  // not implemented
  // ...
end;

procedure TfrmElShellExplorer.ElMenuItem_View_ShowFoldersClick(
  Sender: TObject);
begin
 List.ShowFolders := not List.ShowFolders;
 ElMenuItem_View_ShowFolders.Checked := List.ShowFolders;
end;

end.
