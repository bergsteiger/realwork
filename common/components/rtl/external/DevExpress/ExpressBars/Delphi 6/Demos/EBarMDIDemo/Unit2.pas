unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TChildForm = class(TForm)
    Editor: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FFileName: string;
    procedure SetFileName(Value: string);
  public
    property FileName: string read FFileName write SetFileName;
  end;

implementation

{$R *.DFM}

uses
  Unit1;

procedure TChildForm.SetFileName(Value: string);
var
  I: Integer;
begin
  FFileName := Value;
  Caption := FFileName;
  with MainForm.dxBarListWindows do
  begin
    I := Items.IndexOfObject(Self);
    if (0 <= I) and (I < Items.Count) then Items[I] := FFileName;
  end;
end;

procedure TChildForm.FormCreate(Sender: TObject);
begin
  Inc(MainForm.CreatedMDICount);
  Caption := 'Document' + IntToStr(MainForm.CreatedMDICount);
  Editor.OnChange := MainForm.EditorChange;
  Editor.OnSelectionChange := MainForm.EditorSelectionChange;
  MainForm.dxBarListWindows.Items.AddObject(Caption, Self);
  Editor.Modified;

  if MainForm.MDIChildCount = 1 then MainForm.ShowItems(True);
end;

procedure TChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MainForm.FileName <> '' then
    MainForm.dxBarMRUFiles.AddItem(MainForm.FileName, nil);
  Action := caFree;
end;

procedure TChildForm.FormActivate(Sender: TObject);
begin
  Editor.OnChange(Editor);
end;

procedure TChildForm.FormDestroy(Sender: TObject);
begin
  with MainForm.dxBarListWindows.Items do
    Delete(IndexOfObject(Self));

  if MainForm.MDIChildCount = 1 then MainForm.ShowItems(False);
end;

procedure TChildForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  Res: Integer;
begin
  if Editor.Modified then
  begin
    Res := Application.MessageBox(
      PChar(Format('Do you want to save the changes you made to "%s"?', [Caption])),
      PChar(Application.Title), MB_ICONQUESTION or MB_YESNOCANCEL);
    case Res of
      ID_YES: CanClose := MainForm.SaveFile(False);
      ID_NO: CanClose := True;
      ID_CANCEL: CanClose := False;
    end;
  end;
end;

procedure TChildForm.EditorMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    MainForm.dxBarPopupMenu.PopupFromCursorPos;
end;

end.
