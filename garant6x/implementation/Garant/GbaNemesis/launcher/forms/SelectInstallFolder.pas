unit SelectInstallFolder;

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
 TProductType = (ptUnknown, ptDesktop, ptMobile, ptNetware, ptWorking, ptClient, ptSuperMobile);

 TSelectInstallFolderForm = class(TForm)
  f_BackgroundFormImage: TImage;
  f_BottomBevel: TBevel;
  f_CancelButton: TButton;
  f_ContinueButton: TButton;
  f_ImagePanel: TPanel;
  f_PanelImage: TImage;
  f_MainPanel: TPanel;
  f_FolderEdit: TEdit;
  f_MainPanelFirstLabel: TLabel;
  f_MainPanelSecondLabel: TLabel;
  f_ResetDefaultFolderButton: TButton;
  f_SelectInstallFolderButton: TButton;
  f_SelectInstallFolderFormLabel: TLabel;
  //
  procedure FormCreate(a_Sender: TObject);
  procedure FormCloseQuery(a_Sender: TObject; var a_CanClose: Boolean);
  //
  procedure ResetDefaultFolderButtonClick(a_Sender: TObject);
  procedure SelectInstallFolderButtonClick(a_Sender: TObject);
 private
  f_DefaultPath: string;
  f_ExecuteRoot: string;
  f_ProductType: TProductType;
  f_RequiredSize: Int64;
  //
  procedure OnShowNotifyEvent(a_Sender: TObject);
  //
  procedure pm_SetDefaultPath(const a_Value: string);
  function  pm_GetInstallPath: string;
  procedure pm_SetProductType(const a_Value: TProductType);
 public
  property  DefaultPath: string read f_DefaultPath write pm_SetDefaultPath;
  property  ExecuteRoot: string read f_ExecuteRoot write f_ExecuteRoot;
  property  InstallPath: string read pm_GetInstallPath;
  property  ProductType: TProductType read f_ProductType write pm_SetProductType;
  property  RequiredSize: Int64 read f_RequiredSize write f_RequiredSize;
 end;

var
 SelectInstallFolderForm: TSelectInstallFolderForm;

implementation {$R *.DFM}

uses
 SysUtils
 , LocaleMessages
 ;

procedure TSelectInstallFolderForm.FormCreate(a_Sender: TObject);
begin
 f_MainPanelSecondLabel.Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormMainPanelSecondLabelCaption);
 f_SelectInstallFolderFormLabel.Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormSelectInstallFolderFormLabelCaption);
 //
 f_ResetDefaultFolderButton.Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormResetDefaultFolderButtonCaption);
 f_SelectInstallFolderButton.Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormSelectInstallFolderButtonCaption);
 //
 f_CancelButton.Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormCancelButtonCaption);
 f_ContinueButton.Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormContinueButtonCaption);
 //
 Caption := Application.Title;
 //
 ExecuteRoot := '';
 //
 ProductType := ptUnknown;
 RequiredSize := 0;
 //
 OnShow := OnShowNotifyEvent;
end;

procedure TSelectInstallFolderForm.FormCloseQuery(a_Sender: TObject; var a_CanClose: Boolean);
 //
 function CheckFreeSpace(const a_Directory: string; const a_RequiredSize: Int64): Boolean;
 //
  function GetFreeSize(const a_Directory: string): Int64;
  type
   TGetDiskFreeSpaceEx = function (
    a_Directory: PChar
    ; a_FreeBytesAvailableToCaller: PULargeInteger
    ; a_TotalNumberOfBytes: PULargeInteger
    ; a_TotalNumberOfFreeBytes: PULargeInteger
   ): BOOL; stdcall;
  var
   l_Directory: string;
   l_Length: Integer;
   //
   l_GetDiskFreeSpaceEx: TGetDiskFreeSpaceEx;
   l_Kernel32ModuleHandle: THandle;
   //
   l_FreeBytesAvailableToCaller: TULargeInteger;
   l_TotalNumberOfBytes: TULargeInteger;
   l_TotalNumberOfFreeBytes: TULargeInteger;
   //
   l_BytesPerSector: DWORD;
   l_NumberOfFreeClusters: DWORD;
   l_SectorsPerCluster: DWORD;
   l_TotalNumberOfClusters: DWORD;
  begin
   @l_GetDiskFreeSpaceEx := nil;
   //
   l_Kernel32ModuleHandle := GetModuleHandle('kernel32.dll');
   if (l_Kernel32ModuleHandle <> THandle(0)) then
    @l_GetDiskFreeSpaceEx := GetProcAddress(l_Kernel32ModuleHandle, 'GetDiskFreeSpaceExA');
   //
   l_Length := Length(a_Directory);
   if ((l_Length <> 0) and (a_Directory [l_Length] <> '\')) then
    l_Directory := Format('%s\', [a_Directory])
   else
    l_Directory := a_Directory;
   //
   if (@l_GetDiskFreeSpaceEx <> nil) then
   begin
    Win32Check(l_GetDiskFreeSpaceEx(PChar(l_Directory), @l_FreeBytesAvailableToCaller, @l_TotalNumberOfBytes, @l_TotalNumberOfFreeBytes));
    Result := Int64(l_FreeBytesAvailableToCaller.QuadPart);
   end
   else
   begin
    Win32Check(GetDiskFreeSpace(PChar(Format('%s\', [ExtractFileDrive(l_Directory)])), l_SectorsPerCluster, l_BytesPerSector, l_NumberOfFreeClusters, l_TotalNumberOfClusters));
    Result := Int64(l_SectorsPerCluster*l_BytesPerSector*l_NumberOfFreeClusters);
   end;
  end;
 //
 var
  l_FreeSize: Int64;
 begin
  l_FreeSize := GetFreeSize(a_Directory);
  //
  if (((l_FreeSize < 0) and (a_RequiredSize >= 0)) or ((l_FreeSize >= 0) and (a_RequiredSize < 0))) then
   Result := (l_FreeSize <= a_RequiredSize)
  else
   Result := (l_FreeSize >= a_RequiredSize);
 end;
 //
 function IsDirectoryReadOnly(const a_Directory: string): Boolean;
 var
  l_Directory: string;
  l_Length: Integer;
 begin
  l_Directory := a_Directory;
  l_Length := Length(l_Directory);
  if ((l_Length > 0) and (l_Directory[l_Length] = '\')) then
   SetLength(l_Directory, Pred(l_Length));
  //
  Result := False;
  try
   Win32Check(CloseHandle(CreateFile(PChar(Format('%s\{A3D11BA5-A77C-4352-9508-F485FE04F328}', [l_Directory])), GENERIC_WRITE, DWORD(0), PSecurityAttributes(nil), CREATE_ALWAYS, FILE_ATTRIBUTE_HIDDEN or FILE_FLAG_DELETE_ON_CLOSE, THandle(0))));
  except
   Result := True;
  end;
 end;
 //
var
 l_Directory: string;
begin
 if (ModalResult <> mrCancel) then
 begin
  l_Directory := f_FolderEdit.Text;
  //
  if ((ExecuteRoot <> '') and (Pos(Format('%s\', [AnsiUpperCase(ExecuteRoot)]), Format('%s\', [AnsiUpperCase(l_Directory)])) <> 0)) then
  begin
   a_CanClose := False;
   //
   MessageBox(Handle, PChar(GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormUnableSelectFolder)), PChar(Application.Title), MB_OK+MB_ICONERROR);
  end
  else
   if not(DirectoryExists(l_Directory)) and not(ForceDirectories(l_Directory)) then
   begin
    a_CanClose := False;
    //
    MessageBox(Handle, PChar(GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormUnableCreateFolder)), PChar(Application.Title), MB_OK+MB_ICONERROR);
   end
   else
    if IsDirectoryReadOnly(l_Directory) then
    begin
     a_CanClose := False;
     //
     MessageBox(Handle, PChar(GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormUnwritableFolder)), PChar(Application.Title), MB_OK+MB_ICONERROR);
    end
    else
     if ((RequiredSize <> 0) and not(CheckFreeSpace(l_Directory, RequiredSize))) then
     begin
      a_CanClose := False;
      //
      MessageBox(Handle, PChar(GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormNotEnoughFreeSpaceInFolder)), PChar(Application.Title), MB_OK+MB_ICONERROR);
     end;
 end;
end;

procedure TSelectInstallFolderForm.ResetDefaultFolderButtonClick(a_Sender: TObject);
begin
 f_FolderEdit.Text := DefaultPath;
end;

procedure TSelectInstallFolderForm.SelectInstallFolderButtonClick(a_Sender: TObject);
var
 l_Directory: string;
 //
 l_DefaultTail: string;
 l_CurrentTail: string;
begin
 if SelectDirectory(f_MainPanelSecondLabel.Caption, '', l_Directory) then
 begin
  l_DefaultTail := ExtractFileName(f_DefaultPath);
  l_CurrentTail := ExtractFileName(l_Directory);
  //
  if (AnsiUpperCase(l_DefaultTail) <> AnsiUpperCase(l_CurrentTail)) then
   l_Directory := Format('%s\%s', [l_Directory, l_DefaultTail]);
  //
  f_FolderEdit.Text := l_Directory;
 end;
end;

procedure TSelectInstallFolderForm.OnShowNotifyEvent(a_Sender: TObject);
begin
 SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW and not(WS_EX_TOOLWINDOW));
end;

procedure TSelectInstallFolderForm.pm_SetDefaultPath(const a_Value: string);
begin
 f_DefaultPath := a_Value;
 ResetDefaultFolderButtonClick(nil);
end;

function TSelectInstallFolderForm.pm_GetInstallPath: string;
begin
 Result := f_FolderEdit.Text;
end;

procedure TSelectInstallFolderForm.pm_SetProductType(const a_Value: TProductType);
begin
 f_ProductType := a_Value;
 //
 with f_MainPanelFirstLabel do
  case a_Value of
   ptClient:  Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormFirstRunClientProduct);
   ptDesktop: Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormFirstRunDesktopProduct);
   ptMobile:  Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormFirstRunMobileProduct);
   ptNetware: Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormFirstRunNetwareProduct);
   ptWorking: Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormFirstRunWorkingProduct);
   ptSuperMobile: Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormFirstRunSuperMobileProduct);
  else
   Caption := GetCurrentLocaleMessage(c_GarantSelectInstallFolderFormFirstRunUnknownProduct);
  end;
end;

end.
