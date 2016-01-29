unit Mdieditc;

interface

uses SysUtils, WinTypes, WinProcs, Classes, Graphics, Forms, Controls, OvcEdit,
     ExtCtrls, Dialogs, OvcBase, OvcData, OvcEditU;

type
  TMDIChild = class(TForm)
    Editor1: TOvcTextFileEditor;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditorShowStatus(Sender: TObject; LineNum: Longint; ColNum: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditorEnter(Sender: TObject);
    procedure SplitPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SplitPanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SplitPanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    StoredHeight : Word;
    Editor2 : TOvcTextFileEditor;
    SplitPanel : TPanel;
    SizeStart : Integer;
    LinePos : TPoint;
    Sizing : Boolean;
    NeedsErase : Boolean;
    procedure UpdateEditor(Editor: TOvcTextFileEditor);
  public
    { Public declarations }
    WindowIsSplit : Boolean;
    ActiveEditor : TOvcTextFileEditor;
    procedure UpdateOptions;
    procedure SplitWindow;
  end;

implementation

uses MdiEditM;

{$R *.DFM}


procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Temp : string;
begin
  Action := caFree;
  if Pos('NONAME', Caption) = 1 then begin
    Temp := Caption;
    Delete(Temp, 1, 6);
    Exclude(MainForm.NoNameSet, StrToInt(Temp));
  end;
end;

procedure TMDIChild.SplitWindow;
begin
  WindowIsSplit := not(WindowIsSplit);
  MainForm.Split1.Checked := WindowIsSplit;
  if WindowIsSplit then begin
    Editor1.Align := alBottom;
    Editor1.Height := ClientHeight div 2;
    SplitPanel := TPanel.Create(Self);
    with SplitPanel do begin
      Align := alBottom;
      Height := 5;
      Cursor := crVSplit;
      BorderStyle := bsSingle;
      OnMouseDown := SplitPanelMouseDown;
      OnMouseUp := SplitPanelMouseUp;
      OnMouseMove := SplitPanelMouseMove;
      Parent := Self;
    end;
    Editor2 := TOvcTextFileEditor.Create(Self);
    with Editor2 do begin
      Controller := MainForm.MainController;
      Align := alClient;
      BorderStyle := bsNone;
      HideSelection := False;
      OnEnter := EditorEnter;
      OnShowStatus := EditorShowStatus;
      Parent := Self;
      UpdateOptions;
      Attach(Editor1);
    end;
  end else begin
    ActiveEditor := Editor1;
    Editor2.Free;
    SplitPanel.Free;
    Editor2 := nil;
    SplitPanel := nil;
    Editor1.Align := alClient
  end;
end;

procedure TMDIChild.UpdateEditor(Editor: TOvcTextFileEditor);
begin
  Editor.TabSize := MainForm.TabSize;
  if MainForm.FontIsSet then
    Editor.FixedFont.Assign(MainForm.FontDialog1.Font);
  Editor.WordWrap := MainForm.WordWrap1.Checked;
  Editor.WrapColumn := MainForm.WrapColumn;
  Editor.AutoIndent := MainForm.AutoIndentation1.Checked;
  Editor.MakeBackup := MainForm.CreateBackupFile1.Checked;
  if MainForm.FixedTabs1.Checked then Editor.TabType := ttFixed;
  if MainForm.RealTabs1.Checked then Editor.TabType := ttReal;
  if MainForm.SmartTabs1.Checked then Editor.TabType := ttSmart;
  if MainForm.WraptoWindow1.Checked then
    Editor.WrapColumn := Editor.VisibleColumns;
end;

procedure TMDIChild.UpdateOptions;
begin
  UpdateEditor(Editor1);
  if Assigned(Editor2) then UpdateEditor(Editor2);
end;

procedure TMDIChild.FormResize(Sender: TObject);
begin
  if MainForm.WraptoWindow1.Checked then
    Editor1.WrapColumn := Editor1.VisibleColumns;
  if WindowIsSplit then begin
    SplitPanel.Align := alTop;
    Editor1.Height := MulDiv(Editor1.Height, ClientHeight, StoredHeight);
    SplitPanel.Align := alBottom;
  end;
  StoredHeight := ClientHeight;
end;

procedure TMDIChild.FormCreate(Sender: TObject);
begin
  Editor1.Controller := MainForm.MainController;
  WindowIsSplit := False;
  Editor2 := nil;
  SplitPanel := nil;
  StoredHeight := ClientHeight;
  ActiveEditor := Editor1;
  Sizing := False;
  NeedsErase := False;
  UpdateOptions;
end;

procedure TMDIChild.EditorShowStatus(Sender: TObject; LineNum: Longint; ColNum: Integer);
begin
  MainForm.UpdateStatusLine;
  MainForm.UpdateButtons(Self);
end;

procedure TMDIChild.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  ButtonSelected : Word;
begin
  if Editor1.Modified then
  begin
    ButtonSelected := MessageDlg(Format('%s has changed, do you wish to save?',
      [Self.Caption]), mtInformation, mbYesNoCancel, 0);
    if ButtonSelected in [mrYes] then begin
      BringToFront;                                                    {!!.11}
      SetFocus;                                                        {!!.11}
      MainForm.Save1Click(Self);
      CanClose := True;
    end else
      CanClose := ButtonSelected in [mrNo];
  end;
end;

procedure TMDIChild.FormActivate(Sender: TObject);
begin
  MainForm.Split1.Checked := WindowIsSplit;
end;

procedure TMDIChild.FormDestroy(Sender: TObject);
begin
  Editor2.Free;
  SplitPanel.Free;
end;

procedure TMDIChild.EditorEnter(Sender: TObject);
begin
  ActiveEditor := Sender as TOvcTextFileEditor;
end;

procedure TMDIChild.SplitPanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  SPos : TPoint;
begin
  Sizing := True;
  SPos := SplitPanel.ClientToScreen(Point(X, Y));
  SizeStart := SPos.Y;
  LinePos := SPos;                                                     {!!.10}
end;

procedure TMDIChild.SplitPanelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewHeight : Integer;
  DC : hDC;
begin
  if NeedsErase then begin
    DC := GetDC(0);
    PatBlt(DC, LinePos.X, LinePos.Y, ClientWidth, 1, DstInvert );
    ReleaseDC(0, DC);
    NeedsErase := False;
  end;
  NewHeight := Editor1.Height + SizeStart - LinePos.Y;
  Editor1.Height := NewHeight;
  Sizing := False;
end;

procedure TMDIChild.SplitPanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  DC : HDC;
  SPos, CPos : TPoint;
begin
  if Sizing then begin
    SPos := SplitPanel.ClientToScreen(Point(SplitPanel.Left, Y));
    CPos := ClientOrigin;
    if SPos.Y <= CPos.Y + 3 then Exit;
    if SPos.Y >= CPos.Y + ClientHeight - 3 then Exit;
    if NeedsErase then
    begin
      DC := GetDC(0);
      PatBlt(DC, SPos.X, LinePos.Y, ClientWidth, 1, DstInvert);
      ReleaseDC(0, DC);
      NeedsErase := False;
    end;
    DC := GetDC(0);
    PatBlt(DC, SPos.X, SPos.Y, ClientWidth, 1, DstInvert);
    ReleaseDC(0, DC);
    NeedsErase := True;
    LinePos := SPos;
  end;
end;

end.
