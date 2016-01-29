unit Main;

// $Id: Main.pas,v 1.16 2008/05/20 10:52:06 lulin Exp $

// $Log: Main.pas,v $
// Revision 1.16  2008/05/20 10:52:06  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.15  2006/02/08 17:30:38  lulin
// - cleanup.
//
// Revision 1.14  2005/05/27 14:44:29  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.13  2005/05/26 17:49:39  lulin
// - базовая канва вывода переехала из Эвереста в L3.
//
// Revision 1.12  2005/03/02 09:11:23  lulin
// - new build.
//
// Revision 1.11  2004/12/23 11:47:11  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.10  2003/10/13 15:06:42  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.9  2003/09/16 12:04:57  law
// - bug fix: для слоя ev_sbtMark выставляем флаги.
//
// Revision 1.8  2002/07/26 16:02:09  law
// - new: добавлено оглавление и кнопки открытия уровней.
//
// Revision 1.7  2001/09/25 06:43:48  law
// - new feature: сделана печать.
//
// Revision 1.6  2001/09/14 13:08:11  law
// - new behavior: сделано запоминание режима показа блоков.
//
// Revision 1.5  2001/09/14 12:51:23  law
// - new behavior: добавлена возможность показы структуры документа и работа с дополнительными форматами.
//
// Revision 1.4  2001/09/14 12:34:34  law
// - change: вставлены директивы CVS.
//

interface

{$I evDefine.inc }

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, l3Types, l3InterfacedComponent, l3ProgressComponent, evTextSource, evTextSource,
  evEditorWindow, OvcBase, evMemo,  evEditor, l3Filer, ExtCtrls, W95Meter,
  StdCtrls, evInternalInterfaces, evMenu, DdeMan, l3Forms, evAppForm,
  evLoadDocumentManager, RXSplit, vtLister, vtOutliner, TB97Ctls, evButton,
  TB97, TB97Tlbr, evToolPanel, evLinkedToolPanel, evSubPn, evEdit;

type
  TMainForm = class(TevAppForm, IevMonikerSink)
    MainMenu: TMainMenu;
    miFile: TMenuItem;
    miFileExit: TMenuItem;
    OvcController: TOvcController;
    TextSource: TevTextSource;
    Viewer : TevEditor;
    URL : TevEdit;
    pnStatus: TPanel;
    Meter: TvtW95Meter;
    HScrollBar: TScrollBar;
    miMRUBreak: TMenuItem;
    miMRU: TMenuItem;
    OpenDialog: TOpenDialog;
    miExitBreak: TMenuItem;
    miFileOpen: TMenuItem;
    miFileNew: TMenuItem;
    miText: TMenuItem;
    miTextSelectAll: TevMenuItem;
    miTextHideSelection: TevMenuItem;
    Everest: TDdeServerConv;
    miSelectBreak: TMenuItem;
    miTextSearch: TevMenuItem;
    miTextSearchAgain: TevMenuItem;
    miView: TMenuItem;
    miViewShowDocumentStructure: TevMenuItem;
    PrintDialog: TPrintDialog;
    miFilePrintBreak: TMenuItem;
    miFilePrint: TevMenuItem;
    LoadDocumentManager: TevLoadDocumentManager;
    Contents: TvtOutliner;
    Dock971: TDock97;
    Toolbar971: TToolbar97;
    evButton1: TevButton;
    evButton2: TevButton;
    evButton3: TevButton;
    evButton4: TevButton;
    evButton5: TevButton;
    evButton6: TevButton;
    evButton7: TevButton;
    evButton8: TevButton;
    VSubPanel: TevSubPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    SubDescriptors: TevSubDescriptors;
    procedure miFileExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure URLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miFileOpenClick(Sender: TObject);
    procedure miFileNewClick(Sender: TObject);
    procedure MeterSetStr(const aStr: String);
    procedure EverestExecuteMacro(Sender: TObject; Msg: TStrings);
    function ViewerGetMonikerSink(Sender: TObject;
      out theMonikerSink: IevMonikerSink): Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ContentsActionElement(Sender: TObject; Index: Integer);
  private
    { Private declarations }
    function  MakeMRUItem(aParent: TMenuItem; i : Long): TMenuItem;
      {-}
    procedure UpdateMRU;
      {-}
    procedure miMRUClick(Sender: TObject);
      {-}
    procedure LoadIni;
      {-}
    procedure SaveIni;
      {-}
    procedure RegisterFiles;
      {-}
    function  JumpTo(const aMoniker: IevMoniker): Bool;
      {-}
    procedure GotoSub(const aSub: IevSub);
      {-}
  public
    { Public declarations }
    procedure LoadFile(aFileName: TFileName);
      {-}
  end;

var
  MainForm: TMainForm;

implementation

uses
  ShellAPI,
  Registry,
  
  l3Base,
  l3MinMax,
  l3Units,
  l3Tree_TLB,

  k2Tags,
  
  evTypes,
  evStandardActions,
  evHAFPainter,

  l3IniFile
  ;

{$R *.dfm}

procedure TMainForm.miFileExitClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
(*var
 l_HAFPainter : TevHAFPainter;*)
begin
(* l_HAFPainter := TevHAFPainter.Create(TextSource);
 try
  Viewer.HAFPainter := l_HAFPainter;
 finally
  l3Free(l_HAFPainter);
 end;//try..finally*)
 TextSource.NeedFilterContents := false;
 if (Application.MainForm = nil) OR (Application.MainForm = Self) then begin
  RegisterFiles;
  LoadIni;
  if (ParamCount > 0) then begin
   LoadFile(ParamStr(1));
   Exit;
  end;//ParamCount > 0
 end;
 try
  LoadFile(URL.Text);
 except
  LoadFile('');
 end;//try..except
end;

procedure TMainForm.URLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = vk_Return) then
  LoadFile(URL.Text);
end;

procedure TMainForm.LoadFile(aFileName: TFileName);
  {-}
var
 Ind : Long;  
begin
 if (aFileName = '') then
  TextSource.New
 else begin
  LoadDocumentManager.FileName := aFileName;
  LoadDocumentManager.Load(TextSource);
  Viewer.LMargin := Min( - (evCrtIC.LP2DP(l3PointX(Viewer.Document.rAtom(k2_tiLeftIndent).AsLong)).X - 16), 0);
  with OpenDialog.HistoryList do begin
   Ind := IndexOf(aFileName);
   if (Ind = -1) then Insert(0, aFileName) else Move(Ind, 0);
  end;{with HistoryList}
  Caption := aFileName;
 end;//aFileName = ''
 with Viewer do begin
  if Self.Visible AND HandleAllocated AND Visible then SetFocus;
  Repaint;
 end;//with Viewer
 UpdateMRU;
 URL.Text := aFileName;
end;

function TMainForm.MakeMRUItem(aParent: TMenuItem; i : Long): TMenuItem;
  {-}
var
 l_Name : String;
begin
 l_Name := OpenDialog.HistoryList[i];
 Result := TMenuItem.Create(aParent);
 Result.Caption := l_Name;
 Result.OnClick := miMRUClick;
(* Case l3StringCase(ExtractFileExt(l_Name),
                   ['.evd', '.doc', '.rtf', '.txt', '.htm', '.html', '.evr'],
                   l3_siCaseUnsensitive) of
  0, 6 : Result.ImageIndex := 227;
  1, 2 : Result.ImageIndex := 229;
  3 : Result.ImageIndex := 228;
  4, 5 : Result.ImageIndex := 1;
 end;//Case l3StringCase*)
 aParent.Add(Result);
end;

procedure TMainForm.UpdateMRU;
var
 i : Long;
 l_Count : Long;
 l_Item  : TMenuItem;
 l_Item1 : TMenuItem;
 l_Start : Long;
begin
 l_Count := Pred(OpenDialog.HistoryList.Count);
 with miMRU do
  while (Count > 0) do Remove(Items[0]);
 l_Start := 0;
 l_Item := miMRU;
 while true do begin
  for i := l_Start to Min(l_Start + 20, l_Count) do MakeMRUItem(l_Item, i);
  l_Start := Min(l_Start + 21, l_Count);
  if (l_Start < l_Count) then begin
   l_Item1 := TMenuItem.Create(miMRU);
   l_Item1.Caption := 'Еще..';
   l_Item.Add(l_Item1);
   l_Item := l_Item1;
  end else
   break;
 end;//while (l_Start < l_Count)
 with miMRU do begin
  Visible := (Count > 0);
  miMRUBreak.Visible := Visible;
 end;//with miMRU
end;

procedure TMainForm.miMRUClick(Sender: TObject);
var
 l_FileName : String;
begin
 l_FileName := (Sender As TMenuItem).Caption;
 {$IfDef Delphi5}
 l_FileName := StripHotKey(l_FileName);
 {$EndIf Delphi5}
 LoadFile(l_FileName);
end;

procedure TMainForm.miFileOpenClick(Sender: TObject);
begin
 with OpenDialog do
  if Execute then
   LoadFile(FileName);
end;

procedure TMainForm.miFileNewClick(Sender: TObject);
begin
 with TMainForm.Create(Application) do begin
  if (Self.WindowState = wsMaximized) then
   WindowState := wsMaximized
  else begin
   Top := Self.Top + 50;
   Left := Self.Left + 50;
  end;//Self.WindowState = wsMaximized
  URL.Text := Self.URL.Text;
  Caption := Self.Caption;
  Viewer.Process(nil, nil, Ord(ev_ccShowDocumentParts), Self.Viewer.TextSource.ShowDocumentParts);
  OpenDialog.HistoryList.Assign(Self.OpenDialog.HistoryList);
  UpdateMRU;
  Show;
  with TextSource do begin
   New;
   Processor.ReadOnly := false;
   try
    InsertFrom(Self.TextSource);
   finally
    Processor.ReadOnly := true;
   end;//try..finally
  end;//with TextSource
  Viewer.Repaint;
 end;//with TMainForm.Create(Application)
end;

procedure TMainForm.MeterSetStr(const aStr: String);
begin
 pnStatus.Caption := aStr;
end;

procedure TMainForm.LoadIni;
  {-}
begin
 if (UserConfig = nil) then UserConfig:=TCfgList.Create('');
 UserConfig.Section := 'OpenHistory';
 if (OpenDialog <> nil) then
  UserConfig.ReadParamList('OpenHistory', OpenDialog.HistoryList);

 UserConfig.Section := 'Preferences\Main';
 if UserConfig.ReadParamBoolDef('MaxOnStart', false) then
  WindowState := wsMaximized;
 URL.Text := UserConfig.ReadParamStrDef ('URL', '');
 UserConfig.Section := 'Preferences\View';
 Viewer.Process(nil, nil, Ord(ev_ccShowDocumentParts), UserConfig.ReadParamBoolDef('ShowDocumentParts', false));
end;

procedure TMainForm.SaveIni;
  {-}
begin
 if (UserConfig = nil) then UserConfig:=TCfgList.Create('');
 UserConfig.Section := 'OpenHistory';
 if (OpenDialog <> nil) then
  UserConfig.WriteParamList('OpenHistory', OpenDialog.HistoryList);

 UserConfig.Section := 'Preferences\Main';
 UserConfig.WriteParamBool('MaxOnStart', (WindowState = wsMaximized));
 UserConfig.WriteParamStr('URL', URL.Text);
 UserConfig.Section := 'Preferences\View';
 UserConfig.WriteParamBool('ShowDocumentParts', miViewShowDocumentStructure.Checked);

 l3Free(UserConfig);
end;

procedure TMainForm.RegisterFiles;
  {-}
var
 R         : TRegistry;
 l_AppName : String;
begin
 l_AppName := ChangeFileExt(ExtractFileName(Application.ExeName), '');
 R := TRegistry.Create;
 try
  with R do begin
   RootKey := HKEY_CLASSES_ROOT;
   if OpenKey('.evh', true) then begin
    WriteString('', 'evrhelp');
    CloseKey;
   end;
   if OpenKey('evrhelp', true) then begin
    WriteString('', 'Everest Help file');
    WriteInteger('EditFlags', $0);
    CloseKey;
   end;
   if OpenKey('evrhelp\Shell', true) then begin
    WriteString('', '');
    CloseKey;
   end;
   if OpenKey('evrhelp\Shell\Open', true) then begin
    WriteInteger('EditFlags', $1);
    CloseKey;
   end;
   if OpenKey('evrhelp\Shell\Open\command', true) then begin
    WriteString('', Application.ExeName);
    CloseKey;
   end;
   if OpenKey('evrhelp\Shell\Open\ddeexec', true) then begin
    WriteString('', '%1');
    CloseKey;
   end;
   if OpenKey('evrhelp\Shell\Open\ddeexec\Application', true) then begin
    WriteString('', l_AppName);
    CloseKey;
   end;
   if OpenKey('evrhelp\Shell\Open\ddeexec\topic', true) then begin
    WriteString('', 'everest');
    CloseKey;
   end;
  end;{with R}
 finally
  l3Free(R);
 end;{try..finally}
end;

procedure TMainForm.EverestExecuteMacro(Sender: TObject; Msg: TStrings);
begin
 LoadFile(Msg[0]);
end;

function TMainForm.JumpTo(const aMoniker: IevMoniker): Bool;
  {-}
var
 l_URLMoniker     : IevURLMoniker;
 l_AddressMoniker : IevAddressMoniker;
 l_URL            : String;
begin
 Result := false;
 if l3IOk(aMoniker.QueryInterface(IevURLMoniker, l_URLMoniker)) then
  try
   l_URL := l_URLMoniker.URL;
   if (l_URL <> '') then begin
    ShellExecute(MainForm.Handle, nil, PChar(l_URL), nil, nil, SW_ShowNormal);
    Result := true;
    Exit;
   end;{l_URL <> ''}
  finally
   l_URLMoniker := nil;
  end;{try..finally}
 if l3IOk(aMoniker.QueryInterface(IevAddressMoniker, l_AddressMoniker)) then
  try
   with l_AddressMoniker.Address do begin
    if (DocID = 0) then begin
     GotoSub(TextSource.Sub[SubID]);
     Result := true;
     Exit;
    end;//DocID = 0
   end;//with l_AddressMoniker
  finally
   l_AddressMoniker := nil;
  end;//try..finally
end;

procedure TMainForm.GotoSub(const aSub: IevSub);
  {-}
begin
 with Viewer do begin
  aSub.Select(Selection);
  SetFocus;
 end;//with Viewer
end;

function TMainForm.ViewerGetMonikerSink(Sender: TObject;
  out theMonikerSink: IevMonikerSink): Boolean;
begin
 Result := true;
 theMonikerSink := Self;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (Application.MainForm <> Self) OR (Screen.FormCount <= 1) then
  SaveIni;
end;

procedure TMainForm.ContentsActionElement(Sender: TObject; Index: Integer);
var
 l_Node : Il3Node;
 l_Sub  : IevSub;
begin
 l_Node := Contents.CTree.Nodes[Index];
 if (l_Node <> nil) AND l3IOk(l_Node.QueryInterface(IevSub, l_Sub)) then
  try
   with Viewer do begin
    l_Sub.Select(Selection);
    SetFocus;
   end;{with Editor}
  finally
   l_Sub := nil;
  end;{try..finally}
end;

end.
