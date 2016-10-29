unit nsOpenOrSaveInternetFileDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, nsDownloaderInterfaces, eeButton, vtButton,
  vtRadioButton, vtLabel, vtCtrls, ImgList;

type
  TnsOpenOrSaveInternetFileDialog = class(TForm)
    btnOpen: TvtButton;
    btnSave: TvtButton;
    btnCancel: TvtButton;
    lblPrompt: TvtLabel;
    lblFileNameCaption: TvtLabel;
    lblFileTypeCaption: TvtLabel;
    lblURLCaption: TvtLabel;
    lblFileName: TvtLabel;
    lblFileType: TvtLabel;
    lblURL: TvtLabel;
    imgFileTypeIcon: TvtImage;
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    FParams: Pointer;
    FUpdatingParams: Boolean;
    procedure UpdateControls;
  protected
    procedure Loaded; override;
    function GetParams: InsDownloadParams;
    procedure SetParams(const AParams: InsDownloadParams);
    property Params: InsDownloadParams read GetParams write SetParams;
  public
    class function ChooseParams(const AParams: InsDownloadParams): Boolean;
  end;

implementation
uses
 nsDownloaderRes,
 StrUtils,
 ShellApi,

 l3Base,
 l3String,

 vtSaveDialog,
 vcmBaseTypes,
 vcmBase;

{$R *.dfm}

{ TOpenOrSaveInternetFileDialog }

class function TnsOpenOrSaveInternetFileDialog.ChooseParams(
  const AParams: InsDownloadParams): Boolean;
var
 l_Form: TnsOpenOrSaveInternetFileDialog;
begin
 l_Form := Create(Application);
 try
  l_Form.Params := AParams;
  Result := (l_Form.ShowModal = mrOk);
 finally
  FreeAndNil(l_Form);
 end;
end;

procedure TnsOpenOrSaveInternetFileDialog.UpdateControls;

 function lp_GetRoot(const APath: string): string;
 var
  i: Integer;
 begin
  i := Pos('//', APath);
  if i>0 then
   i := PosEx('/', APath, i + 2)
  else
   i := Pos('/', APath);
  if (i = 0) then
   i := Length(APath);
  Result := Copy(APath, 1, i);
 end;

var
 l_FileName: String;
begin
 l_FileName := ExtractFileName(Params.FileName);
 lblFileName.Caption := l_FileName;
 lblFileName.Hint := l_FileName;
 lblFileType.Caption := Params.FileTypeString;
 lblFileType.Hint := Params.FileTypeString;
 lblURL.Caption := lp_GetRoot(Params.URL);
 lblURL.Hint := lblURL.Caption;
 imgFileTypeIcon.Picture.Icon.Handle := Params.FileIcon;

 lblPrompt.Caption := l3Str(str_OpenOrDownloadQuestion.AsCStr);
 lblFileNameCaption.Caption := l3Str(str_FileName.AsCStr);
 lblFileTypeCaption.Caption := l3Str(str_Type.AsCStr);
 lblURLCaption.Caption := l3Str(str_From.AsCStr);
 btnOpen.Caption := l3Str(str_Open.AsCStr);
 btnSave.Caption := l3Str(str_Download.AsCStr);
 btnCancel.Caption := l3Str(str_Cancel.AsCStr);
end;

procedure TnsOpenOrSaveInternetFileDialog.Loaded;
begin
 inherited;
 Caption := l3Str(str_FileDownload.AsCStr);
end;

function TnsOpenOrSaveInternetFileDialog.GetParams: InsDownloadParams;
begin
 Result := InsDownloadParams(FParams);
end;

procedure TnsOpenOrSaveInternetFileDialog.SetParams(const AParams: InsDownloadParams);
begin
 FParams := Pointer(AParams);
 UpdateControls;
end;

procedure TnsOpenOrSaveInternetFileDialog.btnOpenClick(Sender: TObject);
begin
 Params.FileAction := dfaOpen;
 ModalResult := mrOK;
end;

procedure TnsOpenOrSaveInternetFileDialog.btnSaveClick(Sender: TObject);
var
 l_SaveDialog: TvtSaveDialog;
 l_FileExt: String;
begin
 Params.FileAction := dfaSave;
 l_SaveDialog := TvtSaveDialog.Create(Self);
 try
  l_FileExt := ExtractFileExt(Params.FileName);
  l_SaveDialog.DefaultExt := l_FileExt;
  l_SaveDialog.Options := l_SaveDialog.Options + [ofOverwritePrompt];
  Delete(l_FileExt, 1, 1);
  l_SaveDialog.FileName := ExtractFileName(Params.FileName);
  l_SaveDialog.Filter := Format('%s|*.%s', [l_FileExt, l_FileExt]);
  if l_SaveDialog.Execute then
  begin
   Params.FileName := l_SaveDialog.FileName;
   ModalResult := mrOk;
  end
  else
   ModalResult := mrCancel;
 finally
  FreeAndNil(l_SaveDialog);
 end;
end;

end.
