unit LocaleMessages;

interface

type
 TLocaleMessages = (
  c_ApplicationTitle
  , c_Publisher
 // Common
  , c_CommonErrorMessage
  , c_CommonFileNotFound
  , c_CommonNotEmptyValueRequired
  , c_CommonUnableStartProcess
  , c_CommonUnexpectedException
  , c_CommonUnrecognisedParameterValue
 // Garant
  , c_GarantCannotCreateFolder
  , c_GarantCheckCopyResults
  , c_GarantCheckOperationFailed
  , c_GarantCheckUpdateInstallation
  , c_GarantCreateShortcutsOnDesktop
  , c_GarantCurrentUser
  , c_GarantEtalonSettingsFolderAbsent
  , c_GarantInstallUpdate
  , c_GarantOperationAborted
  , c_GarantOperationFailed
  , c_GarantRegistryOperationFailed
  , c_GarantSettingsCopyOperation
  , c_GarantSettingsExportOperation
  , c_GarantSettingsRestoreOperation
  , c_GarantSettingsRevertOperation
  , c_GarantSettingsSaveOperation
  , c_GarantUpdateLocalCache
  , c_GarantUnableGetDesktopPath
  , c_GarantVersionClient
  , c_GarantVersionDesktop
  , c_GarantVersionMobile
  , c_GarantVersionNetware
  , c_GarantVersionSuperMobile
  , c_GarantVersionUnknown
  , c_GarantVersionWorking
  , c_GarantWarningMessage
 // Garant: FolderNotExist
  , c_GarantFolderNotExistFormContinueButtonCaption
  , c_GarantFolderNotExistFormFolderNotExist
  , c_GarantFolderNotExistFormFolderNotExistButtonCaption
  , c_GarantFolderNotExistFormFolderNotExistFormLabelCaption
  , c_GarantFolderNotExistFormMainPanelLabelCaption
  , c_GarantFolderNotExistFormSkipButtonCaption
 // Garant: SelectInstallFolderForm
  , c_GarantSelectInstallFolderFormCancelButtonCaption
  , c_GarantSelectInstallFolderFormContinueButtonCaption
  , c_GarantSelectInstallFolderFormFirstRunClientProduct
  , c_GarantSelectInstallFolderFormFirstRunDesktopProduct
  , c_GarantSelectInstallFolderFormFirstRunMobileProduct
  , c_GarantSelectInstallFolderFormFirstRunNetwareProduct
  , c_GarantSelectInstallFolderFormFirstRunSuperMobileProduct
  , c_GarantSelectInstallFolderFormFirstRunUnknownProduct
  , c_GarantSelectInstallFolderFormFirstRunWorkingProduct
  , c_GarantSelectInstallFolderFormMainPanelSecondLabelCaption
  , c_GarantSelectInstallFolderFormNotEnoughFreeSpaceInFolder
  , c_GarantSelectInstallFolderFormResetDefaultFolderButtonCaption
  , c_GarantSelectInstallFolderFormSelectInstallFolderButtonCaption
  , c_GarantSelectInstallFolderFormSelectInstallFolderFormLabelCaption
  , c_GarantSelectInstallFolderFormUnableCreateFolder
  , c_GarantSelectInstallFolderFormUnableSelectFolder
  , c_GarantSelectInstallFolderFormUnwritableFolder
 // Garant: WaitMessageForm
  , c_GarantWaitMessageFormOperationInProgress
 // GarantCleaner
  , c_GarantCleanerDeleteAborted
  , c_GarantCleanerDeleteFailed
  , c_GarantCleanerErrorMessage
  , c_GarantCleanerProductUninstalled
  , c_GarantCleanerSubInfo
  , c_GarantCleanerUninstallProduct
 // Mini
  , c_MiniUseCreateStorageFile
  , c_MiniUseMultiFileEncoderCaption
  , c_MiniUseMultiFileEncoderSelectFolder
  , c_MiniUseMultiFileEncoderText
  , c_MiniUseMultiFileEncoding
  , c_MiniUseStatusSavedCaption
  , c_MiniUseStatusSavedText
  , c_MiniUseStatusSavedSuccessfullyCaption
  , c_MiniUseStatusSavedSuccessfullyText
  , c_MiniUseStorageCreatedCaption
  , c_MiniUseStorageCreatedText
  , c_MiniUseStorageFileFull
  , c_MiniUseStorageUnsupportedIntegerSize
 // Logo
  , c_LogoLoading
 // Protection
  , c_ProtectionFailure
 );

procedure SetCurrentLocale(const a_LocaleValue: string);
function  GetCurrentLocaleMessage(const a_LocaleMessages: TLocaleMessages): string;
procedure SetLocaleApplicationTitle;

implementation

uses
 SysUtils, Forms;

var
 g_LocaleMessagesArray: array [TLocaleMessages] of record
  r_Current: PChar;
  //
  r_English: PChar;
  r_Russian: PChar;
 end = (
  (
   r_Current: nil  // c_ApplicationTitle
   ; r_English: 'GARANT aero'
   ; r_Russian: '������ ����'
  )
  , (
   r_Current: nil // c_Publisher
   ; r_English: 'SIE "GARANT-SERVICE-UNIVERSITY" LLC'
   ; r_Russian: '��� ��� "������-������-�����������"'
  )
 // Common
  , (
   r_Current: nil // c_CommonErrorMessage
   ; r_English: '%s'#13#13'Cannot continue working with system.'#13#13'Install product again from installation disk or'#13'apply to your servicing organization.'
   ; r_Russian: '%s'#13#13'���������� ������ ����������.'#13#13'���������� ������ ���������� ������� � ������������ ���'#13'���������� � ������������� ��� �����������.'
  )
  , (
   r_Current: nil // c_CommonFileNotFound
   ; r_English: 'Cannot find file "%s" (it was possibly deleted or corrupted).'
   ; r_Russian: '�� ���� ����� ���� "%s" (�������� �� ��� ������ ��� ���������).'
  )
  , (
   r_Current: nil // c_CommonNotEmptyValueRequired
   ; r_English: 'Parameter value "\[%s]\%s" in file "%s" cannot be empty.'
   ; r_Russian: '�������� ��������� "\[%s]\%s" � ����� "%s" �� ����� ���� ������.'
  )
  , (
   r_Current: nil // c_CommonUnableStartProcess
   ; r_English: 'Cannot start process: "%s".'
   ; r_Russian: '�� ���� ���������� �������: "%s".'
  )
  , (
   r_Current: nil // c_CommonUnexpectedException
   ; r_English: 'Unexpected program error, exception:'#13'%s.'
   ; r_Russian: '�������������� ������ ���������, ����������:'#13'%s.'
  )
  , (
   r_Current: nil // c_CommonUnrecognisedParameterValue
   ; r_English: 'Unknown parameter value "%s=%s".'
   ; r_Russian: '����������� �������� ��������� "%s=%s".'
  )
 // Garant
  , (
   r_Current: nil // c_GarantCannotCreateFolder
   ; r_English: 'Cannot create folder "%s".'
   ; r_Russian: '�� ���� ������� ����� "%s".'
  )
  , (
   r_Current: nil // c_GarantCheckCopyResults
   ; r_English: 'Checking copy results'
   ; r_Russian: '�������� ����������� �����������'
  )
  , (
   r_Current: nil // c_GarantCheckOperationFailed
   ; r_English: 'Checking operation "%s" failed.'#13#13'File "%s" content not equal'#13'to file "%s" content.'
   ; r_Russian: '�������� �������� "%s" ����������� ��������.'#13#13'���������� ����� "%s" �� ���������'#13'� ���������� ����� "%s".'
  )
  , (
   r_Current: nil // c_GarantCheckUpdateInstallation
   ; r_English: 'Checking update results <%s>'
   ; r_Russian: '�������� ��������� ���������� <%s>'
  )
  , (
   r_Current: nil // c_GarantCreateShortcutsOnDesktop
   ; r_English: 'Do you want to create shortcuts on your desktop?'
   ; r_Russian: '���������� �������� ����������� ������� �� ����� ������� �����?'
  )
  , (
   r_Current: nil // c_GarantCurrentUser
   ; r_English: 'Current User'
   ; r_Russian: '������� ������������'
  )
  , (
   r_Current: nil // c_GarantEtalonSettingsFolderAbsent
   ; r_English: 'Default settings folder for user "%s" is absent.'
   ; r_Russian: '������� ��������� �������� ������������ "%s" �����������.'
  )
  , (
   r_Current: nil // c_GarantInstallUpdate
   ; r_English: 'Updating <%s>'
   ; r_Russian: '��������� ���������� <%s>'
  )
  , (
   r_Current: nil // c_GarantOperationAborted
   ; r_English: 'Operation "%s" was interrupted.'
   ; r_Russian: '�������� "%s" ���� ��������.'
  )
  , (
   r_Current: nil // c_GarantOperationFailed
   ; r_English: 'Operation "%s" was failed.'
   ; r_Russian: '�������� "%s" ����������� ��������.'
  )
  , (
   r_Current: nil // c_GarantRegistryOperationFailed
   ; r_English: 'Unable to do necessary operation with registry.'
   ; r_Russian: '���������� ���������� ����������� �������� � ��������.'
  )
  , (
   r_Current: nil // c_GarantSettingsCopyOperation
   ; r_English: 'Installation default user settings'
   ; r_Russian: '��������� ��������� �������� ������������'
  )
  , (
   r_Current: nil // c_GarantSettingsExportOperation
   ; r_English: 'Export user settings'
   ; r_Russian: '������� �������� ������������'
  )
  , (
   r_Current: nil // c_GarantSettingsRestoreOperation
   ; r_English: 'Restoration saved user settings'
   ; r_Russian: '�������������� ����������� �������� ������������'
  )
  , (
   r_Current: nil // c_GarantSettingsRevertOperation
   ; r_English: 'Undo installation default user settings'
   ; r_Russian: '����� ��������� ��������� �������� ������������'
  )
  , (
   r_Current: nil // c_GarantSettingsSaveOperation
   ; r_English: 'Saving current user settings'
   ; r_Russian: '���������� ������� �������� ������������'
  )
  , (
   r_Current: nil // c_GarantUpdateLocalCache
   ; r_English: 'Update data cache'
   ; r_Russian: '���������� ������������ ������'
  )
  , (
   r_Current: nil // c_GarantUnableGetDesktopPath
   ; r_English: 'Unable get path to desktop folder.'
   ; r_Russian: '�� ���� �������� ���� � �������� �������� �����.'
  )
  , (
   r_Current: nil // c_GarantVersionClient
   ; r_English: 'Client'
   ; r_Russian: '������'
  )
  , (
   r_Current: nil // c_GarantVersionDesktop
   ; r_English: 'Local'
   ; r_Russian: '���������'
  )
  , (
   r_Current: nil // c_GarantVersionMobile
   ; r_English: 'Mobile'
   ; r_Russian: '���������'
  )
  , (
   r_Current: nil // c_GarantVersionNetware
   ; r_English: 'FileServer'
   ; r_Russian: '����������'
  )
  , (
   r_Current: nil // c_GarantVersionSuperMobile
   ; r_English: 'Mobile Online'
   ; r_Russian: '��������� ������'
  )
  , (
   r_Current: nil // c_GarantVersionUnknown
   ; r_English: 'Unknown'
   ; r_Russian: '�����������'
  )
  , (
   r_Current: nil // c_GarantVersionWorking
   ; r_English: 'Working'
   ; r_Russian: '�������'
  )
  , (
   r_Current: nil // c_GarantWarningMessage
   ; r_English: '%s'#13#13'After OK pressed prorgram will launch with default settings.'#13#13'Previous settings was saved.'#13'If you want to repair it -'#13'please apply to your servicing organization:'
   ; r_Russian: '%s'#13#13'����� ������� �� ��������� ���������� � ����������� �� ���������.'#13#13'��������� ���������� ������ ���������.'#13'� ������, ���� ��� ������������ ��� ��� �������� -'#13'����������, ���������� � ������������� ��� �����������:'
  )
 // Garant: FolderNotExist
  , (
   r_Current: nil // c_GarantFolderNotExistFormContinueButtonCaption
   ; r_English: 'Continue'
   ; r_Russian: '����������'
  )
  , (
   r_Current: nil // c_GarantFolderNotExistFormFolderNotExist
   ; r_English: 'Folder not exist!'#13'You have to select exist folder.'
   ; r_Russian: '��������� ������� �� ����������!'#13'�� ������ ������� ������������ �������.'
  )
  , (
   r_Current: nil // c_GarantFolderNotExistFormFolderNotExistButtonCaption
   ; r_English: 'Select...'
   ; r_Russian: '��������...'
  )
  , (
   r_Current: nil // c_GarantFolderNotExistFormFolderNotExistFormLabelCaption
   ; r_English: 'Folder not exist'
   ; r_Russian: '����� �� ����������'
  )
  , (
   r_Current: nil // c_GarantFolderNotExistFormMainPanelLabelCaption
   ; r_English: 'Select replace folder:'
   ; r_Russian: '������� ����� ��� ������:'
  )
  , (
   r_Current: nil // c_GarantFolderNotExistFormSkipButtonCaption
   ; r_English: 'Skip'
   ; r_Russian: '����������'
  )
 // Garant: SelectInstallFolderForm
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormCancelButtonCaption
   ; r_English: 'Cancel'
   ; r_Russian: '������'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormContinueButtonCaption
   ; r_English: 'Continue'
   ; r_Russian: '������ ������'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormFirstRunClientProduct
   ; r_English: 'This is the first launch of client version.'
   ; r_Russian: '�� ������� ��������� ���������� ������ ��������.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormFirstRunDesktopProduct
   ; r_English: 'This is the first launch of local version.'
   ; r_Russian: '�� ������� ��������� ��������� ������ ��������.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormFirstRunMobileProduct
   ; r_English: 'This is the first launch of mobile version.'
   ; r_Russian: '�� ������� ��������� ��������� ������ ��������.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormFirstRunNetwareProduct
   ; r_English: 'This is the first launch of file-server version.'
   ; r_Russian: '�� ������� ��������� ����-��������� ������ ��������.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormFirstRunSuperMobileProduct
   ; r_English: 'This is the first launch of mobile-online version.'
   ; r_Russian: '�� ������� ��������� ��������� ������ ������ ��������.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormFirstRunUnknownProduct
   ; r_English: 'This is the first launch of program.'
   ; r_Russian: '�� ������� ��������� �������.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormFirstRunWorkingProduct
   ; r_English: 'This is the first launch of CD or DVD version.'
   ; r_Russian: '�� ������� ��������� ������� ������ ��������.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormMainPanelSecondLabelCaption
   ; r_English: 'Select personal settings folder:'
   ; r_Russian: '������� ����� ��� ����� ������ ��������:'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormNotEnoughFreeSpaceInFolder
   ; r_English: 'Not enough free space in selected folder.'
   ; r_Russian: '� ��������� ����� ������������ ���������� �����.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormResetDefaultFolderButtonCaption
   ; r_English: 'Return to default folder'
   ; r_Russian: '��������� � ����� �� ���������'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormSelectInstallFolderButtonCaption
   ; r_English: 'Select...'
   ; r_Russian: '��������...'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormSelectInstallFolderFormLabelCaption
   ; r_English: 'Select installation folder'
   ; r_Russian: '�������� ����� ��� ���������'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormUnableCreateFolder
   ; r_English: 'Cannot create folder. Select other folder to store settings.'
   ; r_Russian: '������ �������� �����, ��������, �� ������� ���� ��� ������ �������� ����. �������� ������ ����� ��� ���������� ��������.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormUnableSelectFolder
   ; r_English: 'This folder cannot be used, because it is installation folder or one of its subfolders.'
   ; r_Russian: '��������� ����� �� ����� ���� �������, �.�. ��� ��������� �� ������� ��� ���������� ������������.'
  )
  , (
   r_Current: nil // c_GarantSelectInstallFolderFormUnwritableFolder
   ; r_English: 'This folder is write-protected.'
   ; r_Russian: '� ��������� ����� ����������� ����� �� ������.'
  )
 // Garant: WaitMessageForm
  , (
   r_Current: nil // c_GarantWaitMessageFormOperationInProgress
   ; r_English: #13#10'Processing operation "%s".'#13#10#13#10'Wait, please...'
   ; r_Russian: #13#10'���� �������� "%s".'#13#10#13#10'����������, ���������...'
  )
 // GarantCleaner
  , (
   r_Current: nil // c_GarantCleanerDeleteAborted
   ; r_English: 'Deleting folder "%s" was interrupted.'
   ; r_Russian: '�������� �������� �������� "%s" ���� ��������.'
  )
  , (
   r_Current: nil // c_GarantCleanerDeleteFailed
   ; r_English: 'Deleting folder "%s" was failed.'
   ; r_Russian: '�������� �������� �������� "%s" ����������� ��������.'
  )
  , (
   r_Current: nil // c_GarantCleanerErrorMessage
   ; r_English: '%s'#13#13'Deleting program will not further proceed.'
   ; r_Russian: '%s'#13#13'���������� ������ ��������� �������� ����������.'
  )
  , (
   r_Current: nil // c_GarantCleanerProductUninstalled
   ; r_English: '"%s" uninstalled successfully.'
   ; r_Russian: '"%s" ������� ������.'
  )
  , (
   r_Current: nil // c_GarantCleanerSubInfo
   ; r_English: 'current settings remove'
   ; r_Russian: '�������� ������� ��������'
  )
  , (
   r_Current: nil // c_GarantCleanerUninstallProduct
   ; r_English: 'Do you want to uninstall "%s"?'
   ; r_Russian: '�� ������������� ������ ������� "%s"?'
  )
 // Mini
  , (
   r_Current: nil // c_MiniUseCreateStorageFile
   ; r_English: 'Create STORAGE file'
   ; r_Russian: '�������� ����� ���������'
  )
  , (
   r_Current: nil // c_MiniUseMultiFileEncoderCaption
   ; r_English: 'GARANT system update'
   ; r_Russian: '���������� ������� ������'
  )
  , (
   r_Current: nil // c_MiniUseMultiFileEncoderSelectFolder
   ; r_English: 'Select folder for the status of installation saving:'
   ; r_Russian: '�������� ����� ��� ���������� ������� ���������:'
  )
  , (
   r_Current: nil // c_MiniUseMultiFileEncoderText
   ; r_English: 'Save the status of installation?'#13#13'(this functionality is for GARANT support engineers only)'
   ; r_Russian: '��������� ������ ���������?'#13#13'(������ ���������������� ������������� ������ ��� ������������ �� ���������� ������������ ������� ������)'
  )
  , (
   r_Current: nil // c_MiniUseMultiFileEncoding
   ; r_English: 'Saving the status of installation'
   ; r_Russian: '���������� ������� ���������'
  )
  , (
   r_Current: nil // c_MiniUseStatusSavedCaption
   ; r_English: 'GARANT system update'
   ; r_Russian: '���������� ������� ������'
  )
  , (
   r_Current: nil // c_MiniUseStatusSavedText
   ; r_English: 'The status of installation is saved.'
   ; r_Russian: '������ ��������� ��������.'
  )
  , (
   r_Current: nil // c_MiniUseStatusSavedSuccessfullyCaption
   ; r_English: 'GARANT system update'
   ; r_Russian: '���������� ������� ������'
  )
  , (
   r_Current: nil // c_MiniUseStatusSavedSuccessfullyText
   ; r_English: 'The status of installation is successfully saved.'
   ; r_Russian: '������ ��������� ������� ��������.'
  )
  , (
   r_Current: nil // c_MiniUseStorageCreatedCaption
   ; r_English: 'GARANT system update'
   ; r_Russian: '���������� ������� ������'
  )
  , (
   r_Current: nil // c_MiniUseStorageCreatedText
   ; r_English: 'The STORAGE creation is successfully finished.'
   ; r_Russian: '�������� ��������� ������� ���������.'
  )
  , (
   r_Current: nil // c_MiniUseStorageFileFull
   ; r_English: 'The STORAGE file full!'
   ; r_Russian: '� ����� ��������� ������������ ���������� �����!'
  )
  , (
   r_Current: nil // c_MiniUseStorageUnsupportedIntegerSize
   ; r_English: 'Unsupported size of "integer" type!'
   ; r_Russian: '�� �������������� ������ ���� "integer"!'
  )
 // Logo
  , (
   r_Current: nil // c_LogoLoading
   ; r_English: 'Loading...'
   ; r_Russian: '���� ��������...'
  )
 // Protection
 , (
   r_Current: nil // c_ProtectionFailure
   ; r_English: 'Protection failure: %d'
   ; r_Russian: '������ ������: %d'
 )
 );

procedure SetCurrentLocale(const a_LocaleValue: string);
const
 c_English = 1;
 c_Russian = 2;

 c_Default = c_English;
 //
 function GetLanguage(const a_LocaleValue: string): Word;
 begin
  Result := c_Default;
  //
  if (StrLIComp(PChar(a_LocaleValue), PChar('en'), 2) = 0) then
   Result := c_English
  else
   if (StrLIComp(PChar(a_LocaleValue), PChar('ru'), 2) = 0) then
    Result := c_Russian;
 end;
 //
var
 l_Index: TLocaleMessages;
 l_Language: Word;
begin
 l_Language := GetLanguage(a_LocaleValue);
 //
 for l_Index := Low(g_LocaleMessagesArray) to High(g_LocaleMessagesArray) do
  case l_Language of
   c_English: g_LocaleMessagesArray[l_Index].r_Current := g_LocaleMessagesArray[l_Index].r_English;
   c_Russian: g_LocaleMessagesArray[l_Index].r_Current := g_LocaleMessagesArray[l_Index].r_Russian;
  else
   g_LocaleMessagesArray[l_Index].r_Current := g_LocaleMessagesArray[l_Index].r_English;
  end;
end;

function GetCurrentLocaleMessage(const a_LocaleMessages: TLocaleMessages): string;
begin
 Result := g_LocaleMessagesArray[a_LocaleMessages].r_Current;
end;

procedure SetLocaleApplicationTitle;
begin
 Application.Title := GetCurrentLocaleMessage(c_ApplicationTitle);
end;

initialization SetCurrentLocale('$(UserDefaultLocale)'); // First initialization as User Default Locale (== English now)

end.

