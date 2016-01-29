; Скрипт работает с диском O:, сделанным с помошью команды Subst, например:
; "subst o: "c:\Program Files\Borland\Delphi7\Projects""
; На диске должны быть подкаталог "exe\1.2", где бы находился скомпилированный редактор.
; А в нем подкаталог "Output", куда компилируется дистрибутив.
; Если будет использоваться директива CheckInSetup, то в каталоге o:\exe\1.2 должна
; находится CheckSSE.dll и должно быть еще четыре подкаталога:
; * "NSRC"  - версия с поддержкой обычного NSRC
; * "NSRC+" - версия с поддержкой NSRC+
; * "NoSSE+" - версия с поддержкой NSRC+ без поддержки инструкций SSE процессора
; * "NoSSE" - версия с поддержкой обычного NSRC без поддержки инструкций SSE процессора
;
; Компилировался с Inno Setup 5.5.4 

#define EverestAppName "Everest (Lite)"
#define EverestAppVerName "Everest (Lite) 1.2 (Build 10649)"
#define EverestAppVersion "Everest (Lite) 1.2 (Build 10649)"
#define EverestAppID "Everest (Lite) 1.2"
#define EverestAppExeName "Everest.exe"
#define EverestIniName "Everest.ini"

#define FormulaGuide "ExprGuide"
#define EverestAppPublisher "Гарант-Сервис-Университет"
#define EverestAppURL "http://www.garant.ru/"

; #define CheckInSetup

#ifdef CheckInSetup
 #define NSRC 1
 #define NoSSE 2
 #define NSRCPlus 2
 #define NSRCPlusWNoSSE 2
#endif

[Setup]
AppName={#EverestAppName}
AppVerName={#EverestAppVerName}
AppPublisher={#EverestAppPublisher}
AppVersion={#EverestAppVersion}
AppPublisherURL={#EverestAppURL}
AppSupportURL={#EverestAppURL}
AppUpdatesURL={#EverestAppURL}
AppId={#EverestAppID}
DefaultDirName={pf}\Everest
DefaultGroupName={#EverestAppName}
AllowNoIcons=yes
OutputDir=o:\exe\1.2\Output
OutputBaseFilename=setup_everest
Compression=lzma
SolidCompression=yes
ShowTasksTreeLines=yes
AppReadmeFile=o:\exe\EverestInfo.txt
;DiskSpanning=yes ;Для разбивки на дискеты раскомментировать

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce

[Files]
#ifdef CheckInSetup
Source: "o:\exe\1.2\NSRC\EverestLite.exe"; DestDir: "{app}"; DestName: {#EverestAppExeName}; Flags: ignoreversion; Check: EverestCheck({#NSRC})
#else
Source: "o:\exe\1.2\NSRC+\EverestLite.exe"; DestDir: "{app}"; DestName: {#EverestAppExeName}; Flags: ignoreversion
#endif
#ifdef CheckInSetup
Source: "o:\exe\1.2\NoSSE\EverestLite.exe"; DestDir: "{app}"; DestName: {#EverestAppExeName}; Flags: ignoreversion; Check: EverestCheck({#NoSSE})
Source: "o:\exe\1.2\NSRC+\EverestLite.exe"; DestDir: "{app}"; DestName: {#EverestAppExeName}; Flags: ignoreversion; Check: EverestCheck({#NSRCPlus})
Source: "o:\exe\1.2\NoSSE+\EverestLite.exe"; DestDir: "{app}"; DestName: {#EverestAppExeName}; Flags: ignoreversion; Check: EverestCheck({#NSRCPlusWNoSSE})
#endif
Source: "W:\common\components\rtl\External\Expr\ExprGuide\ExprGuide.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "o:\exe\1.2\NSRC+\EverestLite.evs"; DestDir: "{app}"; Flags: ignoreversion
Source: "ev16gr.ico"; DestDir: "{app}"; DestName: "EverestLite.ico"; Flags: ignoreversion
Source: "o:\exe\1.2\mlma32ru.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "W:\common\components\rtl\external\Docx2Rtf\DRS32.DLL"; DestDir: "{app}"; Flags: ignoreversion
Source: "W:\common\components\rtl\external\Docx2Rtf\txml2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "W:\common\components\rtl\external\Docx2Rtf\ter22.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "W:\common\components\rtl\external\Doc2Rtf\wrs6.dll"; DestDir: "{app}"; Flags: ignoreversion
#ifdef CheckInSetup
Source: "o:\exe\1.2\CheckSSE.dll"; DestDir: "{app}"; Flags: ignoreversion
#endif
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#EverestAppName}"; Filename: "{app}\{#EverestAppExeName}"
Name: "{group}\ExprGuide.exe"; Filename: "{app}\{#FormulaGuide}"
Name: "{group}\{cm:UninstallProgram,{#EverestAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#EverestAppName}"; Filename: "{app}\{#EverestAppExeName}"; IconFilename: "{app}\EverestLite.ico"; Tasks: desktopicon

[Run]
Filename: "{app}\{#EverestAppExeName}"; Description: "{cm:LaunchProgram,{#EverestAppName}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: files; Name: "{app}\{#EverestAppName}.log"
Type: files; Name: "{app}\acomplete.ini"
Type: files; Name: "{app}\{#EverestAppName}.evs"

#ifdef CheckInSetup
[Code]
function SSE_Supported: Boolean; external 'SSE_Supported@CheckSSE.dll stdcall setuponly delayload';

const
 cNotInit = -1;
 cNSRC = 1;
 cNoSSE = 2;
 cNSRCPlus = 3;
 cNSRCPlusWNoSSE = 4;

var
 SelectedEXE: Integer;
 NSRCPage: TInputOptionWizardPage;

function EverestCheck(aValue: Integer): Boolean;
begin
 if SelectedEXE = cNotInit then
//  if SSE_Supported then
   SelectedEXE := cNSRC
//  else
//   SelectedEXE := cNoSSE;
 Result := aValue = SelectedEXE;
end;

function InitializeSetup(): Boolean;
begin
 SelectedEXE := cNotInit;
 Result := True;
end;

procedure InitializeWizard;
begin
  NSRCPage := CreateInputOptionPage(wpSelectTasks,
    'Выливка NSRC', 'В каком формате NSRC нужно выливать документы?',
    'Выберите нужный формат NSRC, затем нажмите "Далее".',
    True, False);
  NSRCPage.Add('NSRC (таблицы в псевдографике)');
  NSRCPage.Add('NSRC+ (обычные таблицы и таблицы в псевдографике)');

  case GetPreviousData('NSRCMode', '') of
    'NSRC': NSRCPage.SelectedValueIndex := 0;
    'NSCR+': NSRCPage.SelectedValueIndex := 1;
  else
    NSRCPage.SelectedValueIndex := 0;
  end;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = NSRCPage.ID then
   if (NSRCPage.SelectedValueIndex = 1) then
    if (SelectedEXE = cNSRC) then
     SelectedEXE := cNSRCPlus
    else
     SelectedEXE := cNSRCPlusWNoSSE;
end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
var
  NSRCMode: String;
begin
  case NSRCPage.SelectedValueIndex of
    0: NSRCMode := 'NSRC';
    1: NSRCMode := 'NSRC+';
  end;
  SetPreviousData(PreviousDataKey, 'NSRCMode', NSRCMode);
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo,
  MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  S: String;
begin
  { Fill the 'Ready Memo' with the normal settings and the custom settings }
  S := '';
  if MemoUserInfoInfo <> '' then
   S := S + MemoUserInfoInfo + NewLine + NewLine;
  if MemoDirInfo <> '' then
   S := S + MemoDirInfo + NewLine + NewLine;
  if MemoTypeInfo <> '' then
   S := S + MemoTypeInfo + NewLine + NewLine;
  if MemoGroupInfo <> '' then
   S := S + MemoGroupInfo + NewLine + NewLine;
  if MemoTasksInfo <> '' then
   S := S + MemoTasksInfo + NewLine + NewLine;
  if MemoComponentsInfo <> '' then
   S := S + MemoComponentsInfo + NewLine + NewLine;
  S := S + 'Поддержка выливки в NSRC:' + NewLine + Space;
  S := S + 'Тип NSRC:' + NewLine + Space + Space;
  case NSRCPage.SelectedValueIndex of
    0: S := S + 'NSRC (псевдографические таблицы)';
    1: S := S + 'NSRC+ (обычные и псевдографические таблицы)';
  end;
  Result := S;
end;

#endif


