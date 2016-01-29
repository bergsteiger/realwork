unit adItemEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, adEngine, OvcBase, afwControlPrim, afwBaseControl, afwControl,
  afwInputControl, vtLister, Mask, ToolEdit, StdCtrls, Buttons, l3Interfaces,
  vtStringLister, l3StringList;

type
  TadItemEditDlg = class(TForm)
    edName: TEdit;
    lblName: TLabel;
    edAlias: TEdit;
    lblAlias: TLabel;
    deTarget: TDirectoryEdit;
    lblTarget: TLabel;
    lstFiles: TvtLister;
    lblFileList: TLabel;
    sbAddFile: TSpeedButton;
    sbDelFile: TSpeedButton;
    btnOK: TButton;
    btnCancel: TButton;
    odFiles: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure lstFilesGetItemColor(Sender: TObject; Index: Integer; var FG, BG: TColor);
    procedure lstFilesGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
    procedure sbAddFileClick(Sender: TObject);
    procedure sbDelFileClick(Sender: TObject);
  private
   f_Item: TadItem;
   f_FileValidity: array of Boolean;
   f_FileList: Tl3StringList;
   f_IsDataValid: Boolean;
   procedure CheckValidity;
   procedure pm_SetItem(const Value: TadItem);
   procedure PutData;
    procedure UpdateFileList;
    { Private declarations }
  public
   function Execute: Boolean;
   property Item: TadItem read f_Item write pm_SetItem;
    { Public declarations }
  end;

var
  adItemEditDlg: TadItemEditDlg;

implementation

{$R *.dfm}

uses
 l3Types,
 l3Base,
 l3DatLst,
 l3StringListPrim,
 l3Chars,
 l3String;

procedure TadItemEditDlg.FormCreate(Sender: TObject);
begin
 f_FileList := Tl3StringList.Make;
end;

procedure TadItemEditDlg.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_FileList);
 FreeAndNil(f_Item);
end;

procedure TadItemEditDlg.btnOKClick(Sender: TObject);
begin
 CheckValidity;
 if f_IsDataValid then
 begin
  PutData;
  ModalResult := mrOK;
 end
 else
  MessageDlg('Невалидные данные', mtError, [mbOK], 0);
end;

procedure TadItemEditDlg.CheckValidity;
var
 l_Alias: AnsiString;
begin
 f_IsDataValid := True;
 if edName.Text = '' then
 begin
  lblName.Font.Color := clRed;
  f_IsDataValid := False;
 end
 else
  lblName.Font.Color := clWindowText;

 l_Alias := edAlias.Text;
 if (l_Alias = '') or (l3CharSetPresentExR(PAnsiChar(@l_Alias[1]), Length(l_Alias)-1, cc_WordDelimANSISet) >= 0) then
 begin
  lblAlias.Font.Color := clRed;
  f_IsDataValid := False;
 end
 else
  lblAlias.Font.Color := clWindowText;

 if deTarget.Text = '' then
 begin
  lblTarget.Font.Color := clRed;
  f_IsDataValid := False;
 end
 else
  if not DirectoryExists(deTarget.Text) then
  begin
   lblTarget.Font.Color := clRed;
   f_IsDataValid := False;
  end
  else
   lblTarget.Font.Color := clWindowText;

 if lstFiles.Total = 0 then
 begin
  lblFileList.Font.Color := clRed;
  f_IsDataValid := False;
 end
 else
  lblFileList.Font.Color := clWindowText;
end;

function TadItemEditDlg.Execute: Boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TadItemEditDlg.lstFilesGetItemColor(Sender: TObject; Index: Integer; var FG, BG: TColor);
begin
 if f_FileValidity[Index] then
  FG := clWindowText
 else
  FG := clRed; 
end;

procedure TadItemEditDlg.lstFilesGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
begin
 ItemString := f_FileList.ItemC[Index];
end;

procedure TadItemEditDlg.pm_SetItem(const Value: TadItem);
var
 I: Integer;
begin
 Value.SetRefTo(f_Item);
 edName.Text := f_Item.Name;
 edAlias.Text := f_Item.Alias;
 deTarget.Text := f_Item.TargetFolder;
 for I := 0 to f_Item.FilesCount-1 do
  f_FileList.Add(f_Item.Files[I]);
 UpdateFileList; 
 CheckValidity;
end;

procedure TadItemEditDlg.PutData;
var
 I: Integer;
begin
 f_Item.Name := edName.Text;
 f_Item.Alias := edAlias.Text;
 f_Item.TargetFolder := deTarget.Text;
 f_Item.ClearFiles;
 for I := 0 to f_FileList.Count-1 do
  f_Item.AddFile(f_FileList.Items[I].AsString);
end;

procedure TadItemEditDlg.sbAddFileClick(Sender: TObject);
var
 I: Integer;
begin
 if odFiles.Execute then
 begin
  lstFiles.BeginUpdate;
  try
   for I := 0 to odFiles.Files.Count - 1 do
    f_FileList.Add(odFiles.Files[I]);
   UpdateFileList;
  finally
   lstFiles.EndUpdate
  end;
 end;
end;

procedure TadItemEditDlg.sbDelFileClick(Sender: TObject);
var
 I: Integer;
begin
 if MessageDlg('Действительно удалить выбранные элементы?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin
  lstFiles.BeginUpdate;
  try
   for I := f_FileList.Count-1 downto 0 do
    if lstFiles.Selected[I] then
     f_FileList.Delete(I);
   UpdateFileList;
  finally
   lstFiles.EndUpdate;
  end;
 end;
end;

procedure TadItemEditDlg.UpdateFileList;
 function CheckOne(Data: Pointer; Index: Long): Bool;
 begin
  Result := True;
  f_FileValidity[Index] := FileExists(Tl3PrimString(Data^).AsString);
 end;
var
 l_IA: Tl3IteratorAction;
begin
 SetLength(f_FileValidity, f_FileList.Count);
 l_IA := l3L2IA(@CheckOne);
 f_FileList.IterateAllF(l_IA);
 lstFiles.Total := f_FileList.Count;
 lstFiles.Invalidate;
end;

end.
