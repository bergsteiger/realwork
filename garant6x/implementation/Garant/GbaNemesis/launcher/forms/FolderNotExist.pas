unit FolderNotExist;

interface

uses
 Windows,
 Classes,
 Graphics,
 Controls,
 Forms,
 Dialogs,
 StdCtrls,
 ExtCtrls,
 FileCtrl;

type
 TFolderNotExistForm = class(TForm)
  f_BackgroundFormImage: TImage;
  f_BottomBevel: TBevel;
  f_ContinueButton: TButton;
  f_FolderNotExistFormLabel: TLabel;
  f_ImagePanel: TPanel;
  f_PanelImage: TImage;
  f_MainPanel: TPanel;
   f_FolderEdit: TEdit;
   f_FolderNotExistButton: TButton;
   f_MainPanelLabel: TLabel;
  f_SkipButton: TButton;
  //
  procedure FormCreate(a_Sender: TObject);
  procedure FormCloseQuery(a_Sender: TObject; var a_CanClose: Boolean);
  //
  procedure FolderNotExistButtonClick(a_Sender: TObject);
 private
  procedure OnShowNotifyEvent(a_Sender: TObject);
  //
  function  pm_GetReplacePath: string;
  procedure pm_SetReplacePath(const a_Value: string);
 public
  property  ReplacePath: string read pm_GetReplacePath write pm_SetReplacePath;
 end;

var
 FolderNotExistForm: TFolderNotExistForm;

implementation {$R *.DFM}

uses
 SysUtils
 , LocaleMessages
 ;

procedure TFolderNotExistForm.FormCreate(a_Sender: TObject);
begin
 f_MainPanelLabel.Caption := GetCurrentLocaleMessage(c_GarantFolderNotExistFormMainPanelLabelCaption);
 f_FolderNotExistFormLabel.Caption := GetCurrentLocaleMessage(c_GarantFolderNotExistFormFolderNotExistFormLabelCaption);
 //
 f_FolderNotExistButton.Caption := GetCurrentLocaleMessage(c_GarantFolderNotExistFormFolderNotExistButtonCaption);
 //
 f_SkipButton.Caption := GetCurrentLocaleMessage(c_GarantFolderNotExistFormSkipButtonCaption);
 f_ContinueButton.Caption := GetCurrentLocaleMessage(c_GarantFolderNotExistFormContinueButtonCaption);
 //
 Caption := Application.Title;
 //
 OnShow := OnShowNotifyEvent;
end;

procedure TFolderNotExistForm.FormCloseQuery(a_Sender: TObject; var a_CanClose: Boolean);
var
 l_Directory: string;
begin
 if (ModalResult <> mrCancel) then
 begin
  l_Directory := f_FolderEdit.Text;
  //
  if (not(DirectoryExists(l_Directory))) then
  begin
   a_CanClose := False;
   //
   MessageBox(Handle, PChar(GetCurrentLocaleMessage(c_GarantFolderNotExistFormFolderNotExist)), PChar(Application.Title), MB_OK+MB_ICONERROR);
  end;
 end;
end;

procedure TFolderNotExistForm.FolderNotExistButtonClick(a_Sender: TObject);
var
 l_Directory: string;
begin
 if SelectDirectory(f_MainPanelLabel.Caption, '', l_Directory) then
  f_FolderEdit.Text := l_Directory;
end;

procedure TFolderNotExistForm.OnShowNotifyEvent(a_Sender: TObject);
begin
 SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW and not(WS_EX_TOOLWINDOW));
end;

function TFolderNotExistForm.pm_GetReplacePath: string;
begin
 Result := f_FolderEdit.Text;
end;

procedure TFolderNotExistForm.pm_SetReplacePath(const a_Value: string);
begin
 f_FolderEdit.Text := a_Value;
end;

end.
