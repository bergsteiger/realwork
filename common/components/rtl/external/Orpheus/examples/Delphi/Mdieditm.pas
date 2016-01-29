unit Mdieditm;

interface

uses WinTypes, WinProcs, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, Printers, OvcData,
  OvcBase, OvcEdit, ShellAPI, OvcConst;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Panel1: TPanel;
    Window1: TMenuItem;
    Cascade1: TMenuItem;
    Tile1: TMenuItem;
    ArrangeIcons1: TMenuItem;
    OpenDialog1: TOpenDialog;
    MinimizeAll1: TMenuItem;
    SpeedPanel: TPanel;
    OpenBtn: TSpeedButton;
    SaveBtn: TSpeedButton;
    CutBtn: TSpeedButton;
    CopyBtn: TSpeedButton;
    PasteBtn: TSpeedButton;
    ExitBtn: TSpeedButton;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N7: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    N8: TMenuItem;
    SaveAs1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    New1: TMenuItem;
    Edit1: TMenuItem;
    SelectAll1: TMenuItem;
    N9: TMenuItem;
    Delete1: TMenuItem;
    Paste2: TMenuItem;
    Paste1: TMenuItem;
    Copy2: TMenuItem;
    Copy1: TMenuItem;
    Cut2: TMenuItem;
    Cut1: TMenuItem;
    N10: TMenuItem;
    Redo2: TMenuItem;
    Redo1: TMenuItem;
    Undo2: TMenuItem;
    Undo1: TMenuItem;
    Search1: TMenuItem;
    Gotoline1: TMenuItem;
    N11: TMenuItem;
    Findnext1: TMenuItem;
    Replace1: TMenuItem;
    Find1: TMenuItem;
    Options1: TMenuItem;
    WordStarCommands1: TMenuItem;
    WrapatColumn1: TMenuItem;
    WraptoWindow1: TMenuItem;
    Wordwrap1: TMenuItem;
    N12: TMenuItem;
    Tabs1: TMenuItem;
    TabSize1: TMenuItem;
    N13: TMenuItem;
    Smarttabs1: TMenuItem;
    Realtabs1: TMenuItem;
    Fixedtabs1: TMenuItem;
    N14: TMenuItem;
    Font1: TMenuItem;
    Createbackupfile1: TMenuItem;
    Autoindentation1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog1: TSaveDialog;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    FontDialog1: TFontDialog;
    FindDialog1: TFindDialog;
    ReplaceDialog1: TReplaceDialog;
    MainController: TOvcController;
    N2: TMenuItem;
    Split1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure UpdateButtons(Sender: TObject);
    procedure Tile1Click(Sender: TObject);
    procedure ArrangeIcons1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure CutClick(Sender: TObject);
    procedure CopyClick(Sender: TObject);
    procedure PasteClick(Sender: TObject);
    procedure MinimizeAll1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PrintSetup1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure UndoClick(Sender: TObject);
    procedure RedoClick(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Window1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Autoindentation1Click(Sender: TObject);
    procedure Createbackupfile1Click(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure TabTypeClick(Sender: TObject);
    procedure TabSize1Click(Sender: TObject);
    procedure Wordwrap1Click(Sender: TObject);
    procedure WraptoWindow1Click(Sender: TObject);
    procedure WrapatColumn1Click(Sender: TObject);
    procedure WordStarCommands1Click(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure Gotoline1Click(Sender: TObject);
    procedure Find1Click(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure FindNext1Click(Sender: TObject);
    procedure Replace1Click(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
    procedure Split1Click(Sender: TObject);
  private
    { Private declarations }
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure CreateMDIChild(const Name: string; NewFile: Boolean);
    procedure ShowHint(Sender: TObject);
    procedure WMNCLButtonDblClk(var Message: TWMNCLButtonDblClk);
      message WM_NCLButtonDblClk;
  public
    { Public declarations }
    TabSize : Integer;
    WrapColumn : Integer;
    OptionSet : TSearchOptionSet;
    FontIsSet : Boolean;
    NoNameSet : set of Byte;
    procedure UpdateStatusLine;
    procedure UpdateChildOptions;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses MdiEditC, MdiEditA;

procedure TMainForm.AppMessage(var Msg: TMsg; var Handled: Boolean);
var
  hDrop : THandle;
  DroppedName : array[0..79] of Char;
  FileName : TFileName;
  I, J, NumFiles : Integer;
  AlreadyOpen : Boolean;
begin
  if Msg.Message = WM_DROPFILES then begin
    Handled := True;
    hDrop := Msg.wParam;
    NumFiles := DragQueryFile(hDrop, Cardinal(-1), DroppedName, SizeOf(DroppedName)); {!!.10}
    for J := 0 to NumFiles -1 do begin
      AlreadyOpen := False;
      DragQueryFile(hDrop, J, DroppedName, SizeOf(DroppedName));
      FileName := StrPas(DroppedName);
      for I := 0 to MDIChildCount - 1 do
        if MDIChildren[I].Caption = FileName then begin
          AlreadyOpen := True;
          MDIChildren[I].BringToFront;
          MDIChildren[I].SetFocus;
        end;
      if not AlreadyOpen then
        CreateMDIChild(FileName, False);
    end;
    DragFinish(hDrop);
    if IsIconic(Application.Handle) then
      ShowWindow(Application.Handle, sw_ShowNormal)
    else
      BringWindowToTop(Handle);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
  Screen.OnActiveFormChange := UpdateButtons;
  TabSize := 8;
  WrapColumn := 80;
  FontIsSet := False;
  DragAcceptFiles(Application.Handle, True);
  DragAcceptFiles(Handle, True);
  Application.OnMessage := AppMessage;
  NoNameSet := [];
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  if Application.Hint <> '' then begin
    Panel1.Caption := Application.Hint;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
    Panel7.Visible := False;
  end else begin
    Panel7.Visible := True;
    Panel6.Visible := True;
    Panel5.Visible := True;
    Panel4.Visible := True;
    Panel3.Visible := True;
    Panel2.Visible := True;
  end;
end;

procedure TMainForm.CreateMDIChild(const Name: string; NewFile: Boolean);
var
  Child: TMDIChild;
begin
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.Caption := Name;
  Child.Editor1.Filename := Name;
  Child.Editor1.IsOpen := not(NewFile);
end;

procedure TMainForm.New1Click(Sender: TObject);
var
  I, AvailNum : Integer;
begin
  AvailNum := 1;
  for I := 1 to 255 do begin
    if not (I in NoNameSet) then begin
      AvailNum := I;
      Include(NoNameSet, I);
      Break;
    end;
  end;
  CreateMDIChild('NONAME' + IntToStr(AvailNum), True);
end;

procedure TMainForm.Open1Click(Sender: TObject);
var
  I, J : Integer;
  AlreadyOpen : Boolean;
begin
  AlreadyOpen := False;
  OpenDialog1.FileName := '';
  if OpenDialog1.Execute then begin
    for I := 0 to OpenDialog1.Files.Count - 1 do begin
      for J := 0 to MDIChildCount - 1 do
        if MDIChildren[J].Caption = OpenDialog1.Files[I] then begin
          AlreadyOpen := True;
          MDIChildren[J].BringToFront;
          MDIChildren[J].SetFocus;
        end;
      if not AlreadyOpen then
        CreateMDIChild(OpenDialog1.Files[I], False);
    end;
  end;
end;

procedure TMainForm.Save1Click(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
  with TMDIChild(ActiveMDIChild) do begin
    if Pos('NONAME', Editor1.FileName) = 1 then
      SaveAs1Click(Self)
    else
      Editor1.SaveToFile(Editor1.FileName);
  end;
end;

procedure TMainForm.SaveAs1Click(Sender: TObject);
var
  NoNameNum : Integer;
  Temp : string;
begin
  NoNameNum := 0;
  if ActiveMDIChild <> nil then
  with TMDIChild(ActiveMDIChild) do begin
    SaveDialog1.Title := 'Save ' + ExtractFileName(Editor1.FileName) + ' As';
    SaveDialog1.Filter := OpenDialog1.Filter;
    if Pos('NONAME', Editor1.FileName) <> 1 then
      SaveDialog1.FileName := Editor1.FileName
    else begin
      Temp := Caption;
      Delete(Temp, 1, 6);
      NoNameNum := StrToInt(Temp);
    end;
    if SaveDialog1.Execute then begin
      Editor1.SaveToFile(SaveDialog1.FileName);
      Editor1.FileName := SaveDialog1.FileName;
      Caption := SaveDialog1.Filename;
    if Pos('NONAME', Editor1.FileName) <> 1 then
      Exclude(NoNameSet, NoNameNum);
    end;
  end;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.CutClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    TMDIChild(ActiveMDIChild).ActiveEditor.CutToClipboard;
end;

procedure TMainForm.CopyClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    TMDIChild(ActiveMDIChild).ActiveEditor.CopyToClipboard;
end;

procedure TMainForm.PasteClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    TMDIChild(ActiveMDIChild).ActiveEditor.PasteFromClipboard;
end;

procedure TMainForm.Cascade1Click(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.Tile1Click(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.ArrangeIcons1Click(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.MinimizeAll1Click(Sender: TObject);
var
  I: Integer;
begin
  { Must be done backwards through the MDIChildren array }
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

procedure TMainForm.UpdateButtons(Sender: TObject);
var
  StartLine, StopLine : LongInt;
  StartCol, StopCol : Integer;
  IsSelected : Boolean;
begin
  SaveBtn.Enabled := MDIChildCount > 0;
  if ActiveMDIChild <> nil then begin
    with TMDIChild(ActiveMDIChild) do begin
      IsSelected := ActiveEditor.GetSelection(StartLine, StartCol, StopLine, StopCol);
      CutBtn.Enabled := IsSelected;
      CopyBtn.Enabled := IsSelected;
      OpenClipboard(Handle);
      PasteBtn.Enabled := GetClipboardData(cf_Text) <> 0;
      CloseClipboard;
    end;
  end else begin
    CutBtn.Enabled := False;
    CopyBtn.Enabled := False;
    PasteBtn.Enabled := False;
  end;
  UpdateStatusLine;
end;

procedure TMainForm.UpdateChildOptions;
var
  I : Integer;
begin
  for I := 0 to MDIChildCount - 1 do
    TMDIChild(MDIChildren[I]).UpdateOptions;
end;

procedure TMainForm.UpdateStatusLine;
var
  LineNum : LongInt;
  ColNum : Integer;
begin
  if ActiveMDIChild <> nil then
    with TMDIChild(ActiveMDIChild) do begin
      LineNum := ActiveEditor.GetCaretPosition(ColNum);
      Panel2.Caption := IntToStr(LineNum) + ':' + IntToStr(ColNum);
      Panel2.Update;
      if ActiveEditor.Modified then
        Panel3.Caption := 'Modified'
      else
        Panel3.Caption := '';
      Panel4.Caption := 'Total: ' + IntToStr(ActiveEditor.LineCount);
      Panel5.Caption := 'Top: ' + IntToStr(ActiveEditor.TopLine);
      Panel5.Update;
      Panel6.Caption := 'Bytes: ' + IntToStr(ActiveEditor.TextLength);
      if ActiveEditor.InsertMode then
        Panel7.Caption := 'Insert'
      else
        Panel7.Caption := 'Overwrite';
      Edit1Click(Self);
    end
  else begin
    Panel2.Caption := '';
    Panel3.Caption := '';
    Panel4.Caption := '';
    Panel5.Caption := '';
    Panel6.Caption := '';
    Panel7.Caption := '';
  end;
end;

procedure TMainForm.WMNCLButtonDblClk(var Message: TWMNCLButtonDblClk);
var
  ScreenPt, ClientPt: TPoint;
begin
  ScreenPt.X := Message.XCursor;
  ScreenPt.Y := Message.YCursor;
  ClientPt := ScreenToClient(ScreenPt);
  if (Message.HitTest = HTMENU)
    and (ClientPt.X < GetSystemMetrics(SM_CYMENU))
    and (ActiveMDIChild <> nil)
    and (ActiveMDIChild.WindowState = wsMaximized)
  then begin
    ActiveMDIChild.Close;
    Message.Result := 0;
  end else inherited;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
  DragAcceptFiles(Application.Handle, False);
  DragAcceptFiles(Handle, False);
end;

procedure TMainForm.PrintSetup1Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TMainForm.Print1Click(Sender: TObject);
var
  Line: LongInt;
  Buf: array[0..1023] of Char;
  StartLine, StopLine: LongInt;
  StartCol, StopCol: Integer;
  PrintText: System.Text;
begin
  if TMDIChild(ActiveMDIChild).ActiveEditor.GetSelection(StartLine, StartCol, StopLine, StopCol) then
    PrintDialog1.Options := PrintDialog1.Options + [poSelection]
  else PrintDialog1.Options := PrintDialog1.Options - [poSelection];
  if PrintDialog1.Execute then begin
    AssignPrn(PrintText);
    try
      Rewrite(PrintText);
      Printer.Canvas.Font := TMDIChild(ActiveMDIChild).Editor1.FixedFont.Font;
      case PrintDialog1.PrintRange of
        prAllPages :
          for Line := 1 to TMDIChild(ActiveMDIChild).Editor1.LineCount do begin
            TMDIChild(ActiveMDIChild).Editor1.GetPrintableLine(Line, Buf, SizeOf(Buf));
            Writeln(PrintText, Buf);
          end;
        prSelection :
          for Line := StartLine to StopLine do begin
            TMDIChild(ActiveMDIChild).ActiveEditor.GetPrintableLine(Line, Buf, SizeOf(Buf));
            if Line = StartLine then
              FillChar(Buf, StartCol, #32);
            if Line = StopLine then
              Buf[StopCol] := #0;
            Writeln(PrintText, Buf);
          end;
      end;
    finally
      System.Close(PrintText);
    end;
  end;
end;

procedure TMainForm.File1Click(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    with TMDIChild(ActiveMDIChild) do begin
      Print1.Enabled := Editor1.TextLength > 0;
      Save1.Enabled := Editor1.TextLength > 0;
      SaveAs1.Enabled := Editor1.TextLength > 0;
    end
  else begin
    Print1.Enabled := False;
    Save1.Enabled := False;
    SaveAs1.Enabled := False;
  end;
end;

procedure TMainForm.UndoClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    TMDIChild(ActiveMDIChild).ActiveEditor.Undo;
end;

procedure TMainForm.RedoClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    TMDIChild(ActiveMDIChild).ActiveEditor.Redo;
end;

procedure TMainForm.Delete1Click(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    TMDIChild(ActiveMDIChild).ActiveEditor.ProcessCommand(ccDel, 0);
end;

procedure TMainForm.SelectAll1Click(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
  with TMDIChild(ActiveMDIChild) do begin
    if ActiveEditor.LineCount = -1 then Exit;
    ActiveEditor.SelectAll(False);
  end;
end;

procedure TMainForm.Edit1Click(Sender: TObject);
var
  StartLine, StopLine : LongInt;
  StartCol, StopCol : Integer;
  IsSelected : Boolean;
begin
  if ActiveMDIChild <> nil then begin
    with TMDIChild(ActiveMDIChild) do begin
      IsSelected := ActiveEditor.GetSelection(StartLine, StartCol, StopLine, StopCol);
      Undo1.Enabled := ActiveEditor.CanUndo;
      Undo2.Enabled := ActiveEditor.CanUndo;
      Redo1.Enabled := ActiveEditor.CanRedo;
      Redo2.Enabled := ActiveEditor.CanRedo;
      Copy1.Enabled := IsSelected;
      Copy2.Enabled := IsSelected;
      Cut1.Enabled := IsSelected;
      Cut2.Enabled := IsSelected;
      OpenClipboard(Handle);
      Paste1.Enabled := GetClipboardData(cf_Text) <> 0;
      CloseClipboard;
      Paste2.Enabled := Paste1.Enabled;
      SelectAll1.Enabled := Editor1.TextLength > 0;
    end;
  end else begin
    Undo1.Enabled := False;
    Undo2.Enabled := False;
    Redo1.Enabled := False;
    Redo2.Enabled := False;
    Copy1.Enabled := False;
    Copy2.Enabled := False;
    Cut1.Enabled := False;
    Cut2.Enabled := False;
    Paste1.Enabled := False;
    Paste2.Enabled := False;
    SelectAll1.Enabled := False;
  end;
end;

procedure TMainForm.Window1Click(Sender: TObject);
begin
  Cascade1.Enabled := MDIChildCount > 0;
  Tile1.Enabled := MDIChildCount > 0;
  ArrangeIcons1.Enabled := MDIChildCount > 0;
  MinimizeAll1.Enabled := MDIChildCount > 0;
  Split1.Enabled := ActiveMDIChild <> nil;
  if ActiveMDIChild <> nil then
    Split1.Checked := TMDIChild(ActiveMDIChild).WindowIsSplit
  else
    Split1.Checked := False;
end;

procedure TMainForm.About1Click(Sender: TObject);
begin
  MdiAbout.ShowModal;
end;

procedure TMainForm.Autoindentation1Click(Sender: TObject);
begin
  AutoIndentation1.Checked := not(AutoIndentation1.Checked);
  UpdateChildOptions;
end;

procedure TMainForm.Createbackupfile1Click(Sender: TObject);
begin
  CreateBackupFile1.Checked := not(CreateBackupFile1.Checked);
  UpdateChildOptions;
end;

procedure TMainForm.Font1Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(TMDIChild(ActiveMDIChild).Editor1.FixedFont.Font);
  if FontDialog1.Execute then begin
    FontIsSet := True;
    UpdateChildOptions;
  end;
end;

procedure TMainForm.Options1Click(Sender: TObject);
begin
  Font1.Enabled := ActiveMDIChild <> nil;
end;

procedure TMainForm.TabTypeClick(Sender: TObject);
begin
  FixedTabs1.Checked := False;
  RealTabs1.Checked := False;
  SmartTabs1.Checked := False;
  TMenuItem(Sender).Checked := True;
  UpdateChildOptions;
end;

procedure TMainForm.TabSize1Click(Sender: TObject);
var
  S : string;
begin
  S := IntToStr(TabSize);
  if InputQuery('Tab Size', 'Enter Tab Size', S) then try
    TabSize := StrToInt(S);
    UpdateChildOptions;
  except
    Exit;
  end;
end;

procedure TMainForm.Wordwrap1Click(Sender: TObject);
begin
  WordWrap1.Checked := not(WordWrap1.Checked);
  UpdateChildOptions;
end;

procedure TMainForm.WraptoWindow1Click(Sender: TObject);
begin
  WraptoWindow1.Checked := not(WraptoWindow1.Checked);
  WrapatColumn1.Enabled := not(WraptoWindow1.Checked);
  UpdateChildOptions;
end;

procedure TMainForm.WrapatColumn1Click(Sender: TObject);
var
  S : string;
begin
  S := IntToStr(WrapColumn);
  if InputQuery('Word Wrap Column', 'Word Wrap at Column:', S) then try
    WrapColumn := StrToInt(S);
    UpdateChildOptions;
  except
    Exit;
  end;
end;

procedure TMainForm.WordStarCommands1Click(Sender: TObject);
begin
  with WordStarCommands1 do begin
    Checked := not(Checked);
    MainController.EntryCommands.Table[0].IsActive := Checked;
  end;
end;

procedure TMainForm.Search1Click(Sender: TObject);
begin
  if ActiveMDIChild <> nil then begin
    Find1.Enabled := TMDIChild(ActiveMDIChild).Editor1.TextLength > 0;
    Replace1.Enabled := TMDIChild(ActiveMDIChild).Editor1.TextLength > 0;
    FindNext1.Enabled := (TMDIChild(ActiveMDIChild).Editor1.TextLength > 0)
      and (FindDialog1.FindText <> '');
    GoToLine1.Enabled := TMDIChild(ActiveMDIChild).Editor1.TextLength > 0;
  end else begin
    Find1.Enabled := False;
    Replace1.Enabled := False;
    FindNext1.Enabled := False;
    GotoLine1.Enabled := False;
  end;
end;

procedure TMainForm.Gotoline1Click(Sender: TObject);
var
  S : string;
begin
  S := '1';
  if InputQuery('Go to Line Number', 'Enter Line Number (1 to ' +
    IntToStr(TMDIChild(ActiveMDIChild).ActiveEditor.LineCount) + ')', S) then begin
    try
      TMDIChild(ActiveMDIChild).ActiveEditor.SetCaretPosition(StrToInt(S), 1);
    except
      Exit;
    end;
  end;
end;

procedure TMainForm.Find1Click(Sender: TObject);
begin
  FindDialog1.Position := Point(150, 150);
  FindDialog1.Execute;
end;

procedure TMainForm.FindDialog1Find(Sender: TObject);
begin
  with TFindDialog(Sender) do begin
    OptionSet := [];
    with FindDialog1 do begin
      if not(frDown in Options) then
        OptionSet := OptionSet + [soBackward];
      if frMatchCase in Options then
        OptionSet := OptionSet + [soMatchCase];
      if frWholeWord in Options then
        OptionSet := OptionSet + [soWholeWord];
    end;
    if not (Sender is TReplaceDialog) then CloseDialog;
    if soReplace in OptionSet then
      OptionSet := OptionSet - [soReplace];
    if soReplaceAll in OptionSet then
      OptionSet := OptionSet - [soReplaceAll];
    if not TMDIChild(ActiveMDIChild).ActiveEditor.Search(FindText, OptionSet) then
      MessageDlg('Search string ''' + FindText + ''' not found',
        mtInformation, [mbOk], 0);
    if Sender is TReplaceDialog then
      {Copy string to FindDialog so FindNext menu item will work}
      FindDialog1.FindText := ReplaceDialog1.FindText;
  end;
  Search1Click(Self);
end;

procedure TMainForm.FindNext1Click(Sender: TObject);
begin
  if soReplace in OptionSet then
    OptionSet := OptionSet - [soReplace];
  if soReplaceAll in OptionSet then
    OptionSet := OptionSet - [soReplaceAll];
  if not TMDIChild(ActiveMDIChild).ActiveEditor.Search(FindDialog1.FindText, OptionSet) then
    MessageDlg('Search string ''' + FindDialog1.FindText +
      ''' not found', mtInformation, [mbOk], 0);
end;

procedure TMainForm.Replace1Click(Sender: TObject);
begin
  ReplaceDialog1.Position := Point(150, 150);
  if ReplaceDialog1.Execute then begin
    OptionSet := [];
    with ReplaceDialog1 do begin
      if frMatchCase in Options then
        OptionSet := OptionSet + [soMatchCase];
      if frWholeWord in Options then
        OptionSet := OptionSet + [soWholeWord];
    end;
  end;
end;

procedure TMainForm.ReplaceDialog1Replace(Sender: TObject);
begin
  if frReplaceAll in ReplaceDialog1.Options then
    OptionSet := OptionSet + [soReplaceAll]
  else OptionSet := OptionSet + [soReplace];
  if TMDIChild(ActiveMDIChild).ActiveEditor.Replace(ReplaceDialog1.FindText,
    ReplaceDialog1.ReplaceText, OptionSet) = -1 then
      MessageDlg('Search string ''' + ReplaceDialog1.FindText +
        ''' not found', mtInformation, [mbOk], 0);
end;

procedure TMainForm.Split1Click(Sender: TObject);
begin
  TMDIChild(ActiveMDIChild).SplitWindow;
end;

end.
