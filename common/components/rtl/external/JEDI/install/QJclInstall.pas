{**************************************************************************************************}
{  WARNING:  JEDI preprocessor generated unit.  Do not edit.                                       }
{**************************************************************************************************}

{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL) extension                                                        }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclInstall.pas.                                                             }
{                                                                                                  }
{ The Initial Developer of the Original Code is Petr Vones. Portions created by Petr Vones are     }
{ Copyright (C) of Petr Vones. All Rights Reserved.                                                }
{                                                                                                  }
{ Contributor(s): Robert Rossmair (crossplatform & BCB support, refactoring)                       }
{                                                                                                  }
{**************************************************************************************************}

// $Id: QJclInstall.pas,v 1.1 2004/04/07 09:30:25 law Exp $

// TODO/Issues:
// - Uninstall functionality lacking 
// - Progress display doesn't take unchecked features into account

unit QJclInstall;

interface

{$I jcl.inc}

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  SysUtils, Classes, IniFiles,
  
  Types,
  QComCtrls, QDialogs, QJediInstallIntf,
  
  JclBorlandTools;

const
  Prefixes: array[TJclBorRadToolKind] of Char = ('D', 'C');

type
  TJclInstall = class (TInterfacedObject, IJediInstall)
  private
    FJclPath: string;
    FLibDirMask: string;
    FLibDebugDirMask: string;
    FLibObjDirMask: string;
    FJclSourceDir: string;
    FJclSourcePath: string;
    FJclLibObjDir: string;
    FClxDialogFileName: string;
    FClxDialogIconFileName: string;
    {$IFDEF MSWINDOWS}
    FVclDialogFileName: string;
    FVclDialogSendFileName: string;
    FVclDialogIconFileName: string;
    FVclDialogSendIconFileName: string;
    {$ENDIF MSWINDOWS}
    FJclChmHelpFileName: string;
    FJclHlpHelpFileName: string;
    FJclReadmeFileName: string;
    FTool: IJediInstallTool;
    FIniFile: TMemIniFile;
    FTotalLogSize: Integer;
    FVersionLogSize: Integer;
    FLogSize: Integer;
    FProgressPercent: Integer;
    FOnStarting: TInstallationEvent;
    FOnEnding: TInstallationEvent;
    FOnProgress: TInstallationProgressEvent;
    function AddLogSize(Installation: TJclBorRADToolInstallation): Boolean;
    procedure InitProgress;
    procedure WriteInstallLog(const Msg: string);
  protected
    constructor Create;
    {$IFDEF MSWINDOWS}
    procedure AddHelpToIdeTools(Installation: TJclBorRADToolInstallation);
    procedure AddHelpToOpenHelp(Installation: TJclBorRADToolInstallation);
    {$ENDIF MSWINDOWS}
    procedure CleanupRepository(Installation: TJclBorRADToolInstallation);
    function CompileLibraryUnits(Installation: TJclBorRADToolInstallation; const SubDir: string; Debug: Boolean): Boolean;
    function DocFileName(const BaseFileName: string): string;
    procedure InstallationStarted(Installation: TJclBorRADToolInstallation);
    procedure InstallationFinished(Installation: TJclBorRADToolInstallation);
    procedure InstallFailedOn(const InstallObj: string);
    function InstallPackage(Installation: TJclBorRADToolInstallation; const Name: string): Boolean;
    function InstallRunTimePackage(Installation: TJclBorRADToolInstallation; const BaseName: string): Boolean;
    function MakePath(Installation: TJclBorRADToolInstallation; const FormatStr: string): string;
    function MakeUnits(Installation: TJclBorRADToolInstallation; Debug: Boolean): Boolean;
    procedure ShowProgress;
    property LibObjDir: string read FJclLibObjDir write FJclLibObjDir;
  public
    destructor Destroy; override;
    function FeatureInfoFileName(FeatureID: Cardinal): string;
    function InitInformation(const ApplicationFileName: string): Boolean;
    function Install: Boolean;
    function InstallFor(Installation: TJclBorRADToolInstallation): Boolean;
    function PopulateTreeView(Installation: TJclBorRADToolInstallation; Nodes: TTreeNodes): Boolean;
    function ReadmeFileName: string;
    function SelectedNodeCollapsing(Node: TTreeNode): Boolean;
    procedure SelectedNodeChanged(Node: TTreeNode);
    procedure SetOnEnding(Value: TInstallationEvent);
    procedure SetOnProgress(Value: TInstallationProgressEvent);
    procedure SetOnStarting(Value: TInstallationEvent);
    procedure SetTool(const Value: IJediInstallTool);
    function Supports(Installation: TJclBorRADToolInstallation): Boolean;
    property Tool: IJediInstallTool read FTool;
  end;

function CreateJediInstall: IJediInstall;

implementation

uses
  JclBase, JclSysInfo, JclFileUtils, JclStrings;

const
  {$IFDEF KYLIX}
  VersionDir = '/k%d';
  VersionDirExp = '/k%%d';
  {$ELSE}
  VersionDir = '\%s%d';
  VersionDirExp = '\%%s%%d';
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  {$IFNDEF COMPILER6_UP}
  PathSep = ';';
  {$ENDIF COMPILER6_UP}
  VclDialogFileName = 'ExceptDlg.pas';
  VclDlgSndFileName = 'ExceptDlgMail.pas';
  VclDialogName     = 'Exception Dialog';
  VclDialogNameSend = 'Exception Dialog with Send';

  JclIdeDebugDpk    = 'examples\vcl\debugextension\JclDebugIde%d0.dpk';
  JclIdeAnalyzerDpk = 'examples\vcl\projectanalyzer\ProjectAnalyzer%d0.dpk';
  JclIdeFavoriteDpk = 'examples\vcl\idefavopendialogs\IdeOpenDlgFavorite%d0.dpk';
  JclIdeThrNamesDpk = 'examples\vcl\debugextension\threadnames\ThreadNameExpert%d0.dpk';

  JclSourcePath     = '%0:s\common;%0:s\windows;%0:s\vcl;%0:s\visclx';
  BCBIncludePath    = '%s;%s;$(BCB)\include;$(BCB)\include\vcl';
  {$ENDIF MSWINDOWS}
  {$IFDEF UNIX}
  JclSourcePath     = '%0:s/common:%0:s/unix:%0:s/visclx';
  BCBIncludePath    = '%s:%s:$(BCB)/include:$(BCB)/include/vcl';
  {$ENDIF UNIX}

  DialogsPath       = 'examples' + PathSeparator + 'vcl' + PathSeparator + 'debugextension'
                      + PathSeparator + 'dialog' + PathSeparator;
  ClxDialogFileName = 'ClxExceptDlg.pas';
  ClxDialogName     = 'CLX Exception Dialog';
  DialogDescription = 'JCL Application exception dialog';
  DialogAuthor      = 'Project JEDI';
  DialogPage        = 'Dialogs';

  JclChmHelpFile    = 'help' + PathSeparator + 'JCLHelp.chm';
  JclHlpHelpFile    = 'help' + PathSeparator + 'JCLHelp.hlp';
  JclHelpTitle      = 'JCL %d.%d Help';
  JclHelpIndexName  = 'Jedi Code Library Reference';
  HHFileName        = 'HH.EXE';

  // Feature IDs
  FID_JCL                  = $02000000;

  FID_JCL_Env              = FID_JCL + $00010000;
  FID_JCL_EnvLibPath       = FID_JCL + $00010100;
  FID_JCL_EnvBrowsingPath  = FID_JCL + $00010200;
  FID_JCL_EnvDebugDCUPath  = FID_JCL + $00010300;
  FID_JCL_Make             = FID_JCL + $00020000;
  FID_JCL_MakeRelease      = FID_JCL + $00020100;
  FID_JCL_MakeDebug        = FID_JCL + $00020200;
  FID_JCL_Vcl              = $00000001;
  FID_JCL_VClx             = $00000002;
  FID_JCL_Help             = FID_JCL + $00030000;
  FID_JCL_HelpHlp          = FID_JCL + $00030100;
  FID_JCL_HelpChm          = FID_JCL + $00030200;
  FID_JCL_Packages         = FID_JCL + $00040000;
  FID_JCL_Experts          = FID_JCL + $00040100;
  FID_JCL_ExpertDebug      = FID_JCL + $00040101;
  FID_JCL_ExpertAnalyzer   = FID_JCL + $00040102;
  FID_JCL_ExpertFavorite   = FID_JCL + $00040103;
  FID_JCL_ExpertsThrNames  = FID_JCL + $00040104;
  FID_JCL_ExcDialog        = FID_JCL + $00060000;
  FID_JCL_ExcDialogVCL     = FID_JCL + $00060100;
  FID_JCL_ExcDialogVCLSnd  = FID_JCL + $00060200;
  FID_JCL_ExcDialogCLX     = FID_JCL + $00060300;

  // Products
  RsJCL             = 'JEDI Code Library';

  // Common features
  RsEnvironment     = 'Environment';
  RsEnvLibPath      = 'Add JCL to IDE Library Path';
  RsEnvBrowsingPath = 'Add JCL to IDE Browsing Path';
  RsEnvDebugDCUPath = 'Add JCL to Debug DCU Path';
  RsMake            = 'Make library units';
  RsMakeRelease     = 'Release';
  RsMakeDebug       = 'Debug';
  RsMakeWindows     = 'Windows';
  RsMakeVcl         = 'VCL';
  RsMakeVClx        = 'Visual CLX';

  RsHelpFiles       = 'Help files';
  RsIdeExperts      = 'IDE experts';
  RsJCLPackages     = 'Packages';
  RsIdeHelpHlp      = 'Add help file to IDE help system';
  RsIdeHelpChm      = 'Add HTML help to the Tools menu';

  // Product specific features
  RsJCLExceptDlg    = 'Sample Exception Dialogs in the Object Reporitory';
  RsJCLDialogVCL    = 'VCL Exception Dialog';
  RsJCLDialogVCLSnd = 'VCL Exception Dialog with Send button';
  RsJCLDialogCLX    = 'CLX Exception Dialog';
  RsJCLIdeDebug     = 'Debug Extension';
  RsJCLIdeAnalyzer  = 'Project Analyzer';
  RsJCLIdeFavorite  = 'Favorite combobox in Open/Save dialogs';
  RsJCLIdeThrNames  = 'Displaying thread names in Thread Status window';

resourcestring
  RsLogSize = 'Log Size';
  RsSourceLibHint   = 'Adds "%s" to the Library Path';
  RsStatusMessage   = 'Installing %s...';
  RsStatusDetailMessage = 'Installing %s for %s...';
  RsInstallFailed   = 'Installation of %s failed, see %s for details.';
  RsLibDescriptor   = '%s library %sunits for %s';
  
  RsReadmeFileName  = 'Readme.html';
  
  RsIniFileName = '%sJCL-install.ini';

function CreateJediInstall: IJediInstall;
begin
  Result := TJclInstall.Create as IJediInstall;
end;

function FullPackageFileName(Installation: TJclBorRADToolInstallation; const BaseName: string): string;
const
  S = 'packages' + VersionDir + PathSeparator + '%s%s';
var
  Prefix: string;
begin
  with Installation do
  begin
    Prefix := Prefixes[RADToolKind];
    if DCC.SupportsLibSuffix then
      Result := Format(S + '%s', [{$IFNDEF KYLIX}AnsiLowerCase(Prefix), {$ENDIF}VersionNumber, Prefix, BaseName, PackageSourceFileExtension])
    else
      Result := Format(S + '%1:d0%4:s', [AnsiLowerCase(Prefix), VersionNumber, Prefix, BaseName, PackageSourceFileExtension]);
  end;
end;

{ TJclInstall }

constructor TJclInstall.Create;
begin
  inherited;
  FIniFile := TMemIniFile.Create(Format(RsIniFileName, [ExtractFilePath(ParamStr(0))]));
end;

destructor TJclInstall.Destroy;
begin
  if Assigned(FIniFile) then
  begin
    FIniFile.UpdateFile;
    FreeAndNil(FIniFile);
  end;
  inherited;
end;

{$IFDEF MSWINDOWS}
procedure TJclInstall.AddHelpToIdeTools(Installation: TJclBorRADToolInstallation);
var
  ToolsIndex: Integer;
  HelpTitle: string;
begin
  HelpTitle := Format(JclHelpTitle, [JclVersionMajor, JclVersionMinor]);
  if Installation.IdeTools.IndexOfTitle(HelpTitle) = -1 then
  begin
    ToolsIndex := Installation.IdeTools.Count;
    Installation.IdeTools.Count := ToolsIndex + 1;
    Installation.IdeTools.Title[ToolsIndex] := HelpTitle;
    Installation.IdeTools.Path[ToolsIndex] := HHFileName;
    Installation.IdeTools.Parameters[ToolsIndex] := StrDoubleQuote(FJclChmHelpFileName);
    Installation.IdeTools.WorkingDir[ToolsIndex] := FJclPath;
  end;
end;

procedure TJclInstall.AddHelpToOpenHelp(Installation: TJclBorRADToolInstallation);
begin
  Installation.OpenHelp.AddHelpFile(FJclHlpHelpFileName, JclHelpIndexName);
end;
{$ENDIF MSWINDOWS}

procedure TJclInstall.CleanupRepository(Installation: TJclBorRADToolInstallation);
begin
  if Tool.FeatureChecked(FID_JCL, Installation) then
  begin
    Installation.Repository.RemoveObjects(DialogsPath, ClxDialogFileName, BorRADToolRepositoryFormTemplate);
    {$IFDEF MSWINDOWS}
    Installation.Repository.RemoveObjects(DialogsPath, VclDialogFileName, BorRADToolRepositoryFormTemplate);
    Installation.Repository.RemoveObjects(DialogsPath, VclDlgSndFileName, BorRADToolRepositoryFormTemplate);
    {$ENDIF MSWINDOWS}
  end;
end;

function TJclInstall.CompileLibraryUnits(Installation: TJclBorRADToolInstallation; const SubDir: string; Debug: Boolean): Boolean;
var
  Units: TStringList;
  UnitType: string;
  LibDescriptor: string;
  SaveDir, UnitOutputDir: string;
  Path: string;

  procedure GetUnits(const Path: string; Units: TStrings);
  var
    I, J: Integer;
    ExcludeList: TStringList;
    ExcludeListFileName: string;
    Editions, UnitName: string;
  begin
    BuildFileList(Path + (PathSeparator + '*.pas'), faAnyFile, Units);
    // check for units not to compile
    ExcludeListFileName := MakePath(Installation, Format('%s' + PathSeparator + '%s.exc', [FLibDirMask, SubDir]));
    if FileExists(ExcludeListFileName) then
    begin
      ExcludeList := TStringList.Create;
      try
        ExcludeList.LoadFromFile(ExcludeListFileName);
        for I := 0 to ExcludeList.Count - 1 do
        begin
          UnitName := ExcludeList[I];
          J := Pos('=', UnitName);
          if J > 0 then
            SetLength(UnitName, J - 1);
          J := Units.IndexOf(UnitName);
          if J <> -1 then
          begin
            Editions := ExcludeList.Values[UnitName];
            if (Editions = '') or (StrIPos(BorRADToolEditionIDs[Installation.Edition], Editions) > 0) then
              Units.Delete(J);
          end;
        end;
      finally
        ExcludeList.Free;
      end;
    end;
    // remove extension '.pas'
    for I := 0 to Units.Count -1 do
      Units[I] := Copy(Units[I], 1, Length(Units[I]) - 4);
  end;

begin
  if Debug then
    UnitType := 'debug ';
  LibDescriptor := Format(RsLibDescriptor, [SubDir, UnitType, Installation.Name]);
  WriteInstallLog(Format('Making %s', [LibDescriptor]));
  Units := TStringList.Create;
  try
    Tool.UpdateStatus(Format('Compiling %s...', [LibDescriptor]));
    Path := Format('%ssource' + PathSeparator + '%s', [FJclPath, SubDir]);
    GetUnits(Path, Units);
    with Installation.DCC do
    begin
      Options.Clear;
      Options.Add('-M');
      if Installation.RADToolKind = brCppBuilder then
      begin
        Options.Add('-D_RTLDLL;NO_STRICT;USEPACKAGES'); // $(SYSDEFINES)
        if Debug then
        begin
          Options.Add('-$Y+');
          Options.Add('-$W');
          Options.Add('-$O-');
          Options.Add('-v');
          UnitOutputDir := MakePath(Installation, FLibDebugDirMask);
          AddPathOption('N2', MakePath(Installation, FLibDirMask + PathSeparator + 'obj')); // .obj files
        end
        else
        begin
          Options.Add('-$YD');
          Options.Add('-$W+');
          Options.Add('-$O+');
          UnitOutputDir := MakePath(Installation, FLibDirMask);
          AddPathOption('N2', UnitOutputDir + PathSeparator + 'obj'); // .obj files
        end;
        Options.Add('-v');
        Options.Add('-JPHNE');
        Options.Add('--BCB');
        LibObjDir := MakePath(Installation, FLibObjDirMask);
        AddPathOption('N0', UnitOutputDir); // .dcu files
        AddPathOption('O', Format(BCBIncludePath, [FJclSourceDir, FJclSourcePath]));
        AddPathOption('U', Format(BCBIncludePath, [FJclSourceDir, FJclSourcePath]));
      end
      else // Delphi
      begin
        if Debug then
        begin
          Options.Add('-$O-');
          Options.Add('-$W+');
          Options.Add('-$R+');
          Options.Add('-$Q+');
          Options.Add('-$D+');
          Options.Add('-$L+');
          Options.Add('-$Y+');
          UnitOutputDir := MakePath(Installation, FLibDebugDirMask);
        end
        else
        begin
          Options.Add('-$O+');
          Options.Add('-$R-');
          Options.Add('-$Q-');
          Options.Add('-$C-');
          Options.Add('-$D-');
          UnitOutputDir := MakePath(Installation, FLibDirMask);
        end;
        AddPathOption('N', UnitOutputDir);
        AddPathOption('U', FJclSourcePath);
        AddPathOption('R', FJclSourcePath);
      end;
      AddPathOption('I', FJclSourceDir);
      SaveDir := GetCurrentDir;
      Result := SetCurrentDir(Path);
      {$IFDEF WIN32}
      Win32Check(Result);
      {$ELSE}
      if Result then
      {$ENDIF}
      try
        Result := Execute(StringsToStr(Units, ' ', False));
        WriteInstallLog('');
        WriteInstallLog('Compiling .dcu files...');
        WriteInstallLog(Installation.DCC.Output);
        {$IFDEF KYLIX}
        Options.Add('-P');   // generate position independent code (PIC)
        Result := Execute(StringsToStr(Units, ' ', False));
        WriteInstallLog('');
        WriteInstallLog('Compiling dpu files...');
        WriteInstallLog(Installation.DCC.Output);
        {$ENDIF KYLIX}
      finally
        SetCurrentDir(SaveDir);
      end;
    end;
  finally
    Units.Free;
  end;
  if not Result then
    InstallFailedOn(LibDescriptor);
end;

function TJclInstall.DocFileName(const BaseFileName: string): string;
const
  SDocFileMask = '%sdocs' + PathSeparator + '%s';
begin
  Result := Format(SDocFileMask, [FJclPath, BaseFileName]);
end;

function TJclInstall.FeatureInfoFileName(FeatureID: Cardinal): string;
begin
  Result := DocFileName(Format('%.7x.info', [FeatureID]));
end;

function TJclInstall.InitInformation(const ApplicationFileName: string): Boolean;
var
  I: Integer;
  ReadmeText: string;
begin
  FJclPath := PathAddSeparator(PathCanonicalize(PathExtractFileDirFixed(ApplicationFileName) + '..'));
  FLibDirMask := Format('%slib' + VersionDirExp, [FJclPath]);
  FLibDebugDirMask := FLibDirMask + PathSeparator + 'debug';
  FLibObjDirMask := FLibDirMask + PathSeparator + 'obj';
  FJclSourceDir := FJclPath + 'source';
  FJclSourcePath := Format(JclSourcePath, [FJclSourceDir]);
  {$IFDEF MSWINDOWS}
  FClxDialogFileName := AnsiUpperCase(FJclPath + DialogsPath + ClxDialogFileName);
  {$ENDIF MSWINDOWS}
  {$IFDEF UNIX}
  FClxDialogFileName := FJclPath + DialogsPath + ClxDialogFileName;
  {$ENDIF UNIX}
  FClxDialogIconFileName := ChangeFileExt(FClxDialogFileName, '.ico');
  {$IFDEF MSWINDOWS}
  FVclDialogFileName := AnsiUpperCase(FJclPath + DialogsPath + VclDialogFileName);
  FVclDialogSendFileName := AnsiUpperCase(FJclPath + DialogsPath + VclDlgSndFileName);
  FVclDialogIconFileName := ChangeFileExt(FVclDialogFileName, '.ico');
  FVclDialogSendIconFileName := ChangeFileExt(FVclDialogSendFileName, '.ico');
  {$ENDIF MSWINDOWS}
  FJclChmHelpFileName := FJclPath + JclChmHelpFile;
  FJclHlpHelpFileName := FJclPath + JclHlpHelpFile;
  if not FileExists(FJclChmHelpFileName) then
    FJclChmHelpFileName := '';
  if not FileExists(FJclHlpHelpFileName) then
    FJclHlpHelpFileName := '';
  {$IFDEF MSWINDOWS}
  // Reset ReadOnly flag for dialog forms
  FileSetAttr(FClxDialogFileName, faArchive);
  FileSetAttr(ChangeFileExt(FClxDialogFileName, '.xfm'), faArchive);
  FileSetAttr(FVclDialogFileName, faArchive);
  FileSetAttr(ChangeFileExt(FVclDialogFileName, '.dfm'), faArchive);
  FileSetAttr(FVclDialogSendFileName, faArchive);
  FileSetAttr(ChangeFileExt(FVclDialogSendFileName, '.dfm'), faArchive);
  {$ENDIF MSWINDOWS}
  Result := FileExists(FClxDialogFileName) and FileExists(FClxDialogIconFileName)
  {$IFDEF MSWINDOWS}
    and FileExists(FVclDialogFileName)  and FileExists(FVclDialogIconFileName)
  {$ENDIF MSWINDOWS};
  FJclReadmeFileName := DocFileName(RsReadmeFileName);
  if FileExists(FJclReadmeFileName) then
  begin
    ReadmeText := FileToString(FJclReadmeFileName);
    for I := 0 to Tool.BorRADToolInstallations.Count - 1 do
       Tool.UpdateInfo(Tool.BorRADToolInstallations[I], ReadmeText);
  end;
end;

function TJclInstall.AddLogSize(Installation: TJclBorRADToolInstallation): Boolean;
var
  LogSize: Integer;
begin
  Result := True;
  if Tool.FeatureChecked(FID_JCL, Installation) then
  begin
    LogSize := FIniFile.ReadInteger(RsLogSize, Installation.Name, 0);
    Inc(FTotalLogSize, LogSize);
    Result := LogSize > 0;
  end;
end;

procedure TJclInstall.InitProgress;
begin
  FTotalLogSize := 0;
  FLogSize := 0;
  Tool.BorRADToolInstallations.Iterate(AddLogSize);
end;

function TJclInstall.Install: Boolean;
begin
  WriteInstallLog(Format('Installation started %s', [DateTimeToStr(Now)]));
  try
    InitProgress;
    Result := Tool.BorRADToolInstallations.Iterate(InstallFor);
  finally
    Tool.UpdateStatus('');
  end;
end;

procedure TJclInstall.InstallFailedOn(const InstallObj: string);
begin
  Tool.MessageBox(Format(RsInstallFailed, [InstallObj, ChangeFileExt(ExtractFileName(ParamStr(0)), '.log')]), mtError);
end;

function TJclInstall.InstallFor(Installation: TJclBorRADToolInstallation): Boolean;

  procedure WriteBorRADToolVersionToLog;
  begin
    WriteInstallLog(StrPadRight(Format('%s Build %s ', [Installation.Name, Installation.IdeExeBuildNumber]), 120, '='));
  end;

begin
  Result := True;
  if not Supports(Installation) then
    Exit;
  InstallationStarted(Installation);
  Tool.UpdateStatus(Format(RsStatusMessage, [Installation.Name]));
  WriteBorRADToolVersionToLog;
  CleanupRepository(Installation);
  if Tool.FeatureChecked(FID_JCL_EnvLibPath, Installation) then
  begin
    Installation.AddToLibrarySearchPath(MakePath(Installation, FLibDirMask));
    Installation.AddToLibrarySearchPath(FJclSourceDir);
  end;
  if Tool.FeatureChecked(FID_JCL_EnvDebugDCUPath, Installation) then
    Installation.AddToDebugDCUPath(MakePath(Installation, FLibDebugDirMask));
  if Tool.FeatureChecked(FID_JCL_EnvBrowsingPath, Installation) then
    Installation.AddToLibraryBrowsingPath(FJclSourcePath);
  if Tool.FeatureChecked(FID_JCL_Make, Installation) then
  begin
    if Tool.FeatureChecked(FID_JCL_MakeDebug, Installation) then
      Result := Result and MakeUnits(Installation, True);
    if Tool.FeatureChecked(FID_JCL_MakeRelease, Installation) then
      Result := Result and MakeUnits(Installation, False);
  end;
  {$IFDEF MSWINDOWS}
  if Tool.FeatureChecked(FID_JCL_HelpHlp, Installation) then
    AddHelpToOpenHelp(Installation);
  if Tool.FeatureChecked(FID_JCL_HelpChm, Installation) then
    AddHelpToIdeTools(Installation);
  if Tool.FeatureChecked(FID_JCL_ExcDialogVCL, Installation) then
    Installation.Repository.AddObject(FVclDialogFileName, BorRADToolRepositoryFormTemplate,
      Installation.Repository.FindPage(DialogPage, 1), VclDialogName, FVclDialogIconFileName,
      DialogDescription, DialogAuthor, BorRADToolRepositoryDesignerDfm);
  if Tool.FeatureChecked(FID_JCL_ExcDialogVCLSnd, Installation) then
    Installation.Repository.AddObject(FVclDialogSendFileName, BorRADToolRepositoryFormTemplate,
      Installation.Repository.FindPage(DialogPage, 1), VclDialogNameSend, FVclDialogSendIconFileName,
      DialogDescription, DialogAuthor, BorRADToolRepositoryDesignerDfm, FVclDialogFileName);
  {$ENDIF MSWINDOWS}
  if Tool.FeatureChecked(FID_JCL_ExcDialogCLX, Installation) then
    Installation.Repository.AddObject(FClxDialogFileName, BorRADToolRepositoryFormTemplate,
      Installation.Repository.FindPage(DialogPage, 1), ClxDialogName, FClxDialogIconFileName,
      DialogDescription, DialogAuthor, BorRADToolRepositoryDesignerXfm);
  if Tool.FeatureChecked(FID_JCL_Packages, Installation) then
  begin
    Result := Result and InstallRunTimePackage(Installation, 'Jcl');
    if Installation.SupportsVisualCLX then
      Result := Result and InstallRunTimePackage(Installation, 'JclVClx');
    {$IFDEF MSWINDOWS}
    if Installation.VersionNumber >= 6 then
      Result := Result and InstallRunTimePackage(Installation, 'JclVcl');
    if Tool.FeatureChecked(FID_JCL_ExpertDebug, Installation) then
      Result := Result and InstallPackage(Installation, JclIdeDebugDpk);
    if Tool.FeatureChecked(FID_JCL_ExpertAnalyzer, Installation) then
      Result := Result and InstallPackage(Installation, JclIdeAnalyzerDpk);
    if Tool.FeatureChecked(FID_JCL_ExpertFavorite, Installation) then
      Result := Result and InstallPackage(Installation, JclIdeFavoriteDpk);
    if Tool.FeatureChecked(FID_JCL_ExpertsThrNames, Installation) then
      Result := Result and InstallPackage(Installation, JclIdeThrNamesDpk);
    {$ENDIF MSWINDOWS}
  end;
  if Result then
    InstallationFinished(Installation);
end;

function TJclInstall.InstallPackage(Installation: TJclBorRADToolInstallation; const Name: string): Boolean;
const
  {$IFDEF MSWINDOWS}
  Bcb2MakTemplate = '\BCB.bmk';
  {$ENDIF MSWINDOWS}
  {$IFDEF KYLIX}
  Bcb2MakTemplate = '/bcb.gmk';
  {$ENDIF KYLIX}
var
  PackageFileName: string;
begin
  Result := True;
  PackageFileName := FJclPath + Format(Name, [Installation.VersionNumber]);
  WriteInstallLog(Format('Installing package %s', [PackageFileName]));
  Tool.UpdateStatus(Format(RsStatusDetailMessage, [ExtractFileName(PackageFileName), Installation.Name]));
  if IsDelphiPackage(Name) then
  begin
    Result := Installation.InstallPackage(PackageFileName, Tool.BPLPath(Installation),
      Tool.DCPPath(Installation));
    WriteInstallLog(Installation.DCC.Output);
  end
  else
    if Installation is TJclBCBInstallation then
    with TJclBCBInstallation(Installation) do
    begin
      Bpr2Mak.Options.Clear;
      Bpr2Mak.Options.Add('-t..' + Bcb2MakTemplate);
      {$IFDEF KYLIX}
      SetEnvironmentVar('OBJDIR', LibObjDir);
      SetEnvironmentVar('BPILIBDIR', Tool.DcpPath(Installation));
      SetEnvironmentVar('BPLDIR', Tool.BplPath(Installation));
      {$ELSE}
      Make.Options.Clear;
      Make.AddPathOption('DBPILIBDIR=', Tool.DcpPath(Installation));
      Make.AddPathOption('DBPLDIR=', Tool.BplPath(Installation));
      {$ENDIF}
      Result := Installation.InstallPackage(PackageFileName, Tool.BPLPath(Installation),
        Tool.DCPPath(Installation));
      WriteInstallLog(Installation.DCC.Output);
      WriteInstallLog(Bpr2Mak.Output);
      WriteInstallLog(Make.Output);
    end;
  WriteInstallLog('');
  if not Result then
    InstallFailedOn(PackageFileName);
end;

function TJclInstall.InstallRunTimePackage(Installation: TJclBorRADToolInstallation; const BaseName: string): Boolean;
begin
  Result := InstallPackage(Installation, FullPackageFileName(Installation, BaseName));
end;

function TJclInstall.MakePath(Installation: TJclBorRADToolInstallation; const FormatStr: string): string;
begin
  {$IFDEF KYLIX}
  Result := Format(FormatStr, [Installation.VersionNumber]);
  {$ELSE}
  Result := Format(FormatStr, [Prefixes[Installation.RADToolKind], Installation.VersionNumber]);
  {$ENDIF}
end;

function TJclInstall.MakeUnits(Installation: TJclBorRADToolInstallation; Debug: Boolean): Boolean;
begin
  Result := CompileLibraryUnits(Installation, 'common', Debug);
  {$IFDEF MSWINDOWS}
  Result := Result and CompileLibraryUnits(Installation, 'windows', Debug);
  Result := Result and CompileLibraryUnits(Installation, 'vcl', Debug);
  {$ENDIF MSWINDOWS}
  if Tool.FeatureChecked(FID_JCL_MakeRelease + FID_JCL_VClx, Installation) then
    Result := Result and CompileLibraryUnits(Installation, 'visclx', Debug);
end;

function TJclInstall.PopulateTreeView(Installation: TJclBorRADToolInstallation; Nodes: TTreeNodes): Boolean;
var
  InstallationNode, ProductNode, TempNode, MakeNode: TTreeNode;

  function AddNode(Parent: TTreeNode; const Caption: string; FeatureID: Cardinal): TTreeNode;
  begin
    FeatureID := FeatureID or FID_Checked;
    Result := Nodes.AddChildObject(Parent, Caption, Pointer(FeatureID));
    Result.ImageIndex := IcoChecked;
    Result.SelectedIndex := IcoChecked;
  end;

  procedure AddMakeNodes(Parent: TTreeNode; DebugSettings: Boolean);
  const
    Caption: array[Boolean] of string = (RsMakeRelease, RsMakeDebug);
    Feature: array[Boolean] of Cardinal = (
      FID_JCL_MakeRelease + FID_StandaloneParent,
      FID_JCL_MakeDebug + FID_StandaloneParent);
  var
    Node: TTreeNode;
  begin
    Node := AddNode(Parent, Caption[DebugSettings], Feature[DebugSettings]);
    {$IFDEF KYLIX}
    AddNode(Node, RsMakeVClx, Feature[DebugSettings] or FID_JCL_VClx);
    {$ELSE}
    AddNode(Node, RsMakeVcl, Feature[DebugSettings] or FID_JCL_Vcl);
    if Installation.VersionNumber >= 6 then
    begin
      if Installation.SupportsVisualCLX then
        AddNode(Node, RsMakeVClx, Feature[DebugSettings] or FID_JCL_VClx);
    end;
    {$ENDIF}
  end;

begin
  Result := Assigned(Installation) and Installation.Valid;
  Nodes.BeginUpdate;
  try
    if Result then
    begin
      InstallationNode := AddNode(nil, Installation.Description, 0);
      //InstallationNode.StateIndex := 0;
      // JCL
      ProductNode := AddNode(InstallationNode, RsJCL, FID_JCL);
      TempNode := AddNode(ProductNode, RsEnvironment, FID_JCL_Env);
      AddNode(TempNode, RsEnvLibPath, FID_JCL_EnvLibPath);
      AddNode(TempNode, RsEnvBrowsingPath, FID_JCL_EnvBrowsingPath);
      AddNode(TempNode, RsEnvDebugDCUPath, FID_JCL_EnvDebugDCUPath);

      MakeNode := AddNode(ProductNode, RsMake, FID_JCL_Make);
      AddMakeNodes(MakeNode, False);
      AddMakeNodes(MakeNode, True);

      {$IFDEF KYLIX}
      AddNode(ProductNode, RsJCLPackages, FID_JCL_Packages + FID_StandaloneParent);
      {$ELSE MSWINDOWS}
      if (FJclHlpHelpFileName <> '') or (FJclChmHelpFileName <> '') then
      begin
        TempNode := AddNode(ProductNode, RsHelpFiles, FID_JCL_Help);
        if FJclHlpHelpFileName <> '' then
          AddNode(TempNode, RsIdeHelpHlp, FID_JCL_HelpHlp);
        if FJclChmHelpFileName <> '' then
          AddNode(TempNode, RsIdeHelpChm, FID_JCL_HelpChm);
      end;
      TempNode := AddNode(ProductNode, RsJCLExceptDlg, FID_JCL_ExcDialog);

      AddNode(TempNode, RsJCLDialogVCL, FID_JCL_ExcDialogVCL);
      AddNode(TempNode, RsJCLDialogVCLSnd, FID_JCL_ExcDialogVCLSnd);
      if Installation.SupportsVisualCLX then
        AddNode(TempNode, RsJCLDialogCLX, FID_JCL_ExcDialogCLX);
      TempNode := AddNode(ProductNode, RsJCLPackages, FID_JCL_Packages + FID_StandaloneParent);
      if not (Installation is TJclBCBInstallation) then
      begin
        TempNode := AddNode(TempNode, RsIdeExperts, FID_JCL_Experts);
        AddNode(TempNode, RsJCLIdeDebug, FID_JCL_ExpertDebug);
        AddNode(TempNode, RsJCLIdeAnalyzer, FID_JCL_ExpertAnalyzer);
        AddNode(TempNode, RsJCLIdeFavorite, FID_JCL_ExpertFavorite);
        if Installation.VersionNumber <= 6 then
          AddNode(TempNode, RsJCLIdeThrNames, FID_JCL_ExpertsThrNames);
      end;
      {$ENDIF MSWINDOWS}
      InstallationNode.Expand(True);
      
    end;
  finally
    Nodes.EndUpdate;
  end;
end;

function TJclInstall.ReadmeFileName: string;
begin
  Result := FJclReadmeFileName;
end;

procedure TJclInstall.SelectedNodeChanged(Node: TTreeNode);
begin
end;

function TJclInstall.SelectedNodeCollapsing(Node: TTreeNode): Boolean;
begin
  Result := False;
end;

procedure TJclInstall.SetOnEnding(Value: TInstallationEvent);
begin
  FOnEnding := Value;
end;

procedure TJclInstall.SetOnProgress(Value: TInstallationProgressEvent);
begin
  FOnProgress := Value;
end;

procedure TJclInstall.SetOnStarting(Value: TInstallationEvent);
begin
  FOnStarting := Value;
end;

procedure TJclInstall.SetTool(const Value: IJediInstallTool);
begin
  FTool := Value;
end;

procedure TJclInstall.InstallationStarted(Installation: TJclBorRADToolInstallation);
begin
  FVersionLogSize := 0;
  if Assigned(FOnStarting) then
    FOnStarting(Installation);
end;

procedure TJclInstall.InstallationFinished(Installation: TJclBorRADToolInstallation);
begin
  if FVersionLogSize > FIniFile.ReadInteger(RsLogSize, Installation.Name, 0) then
    FIniFile.WriteInteger(RsLogSize, Installation.Name, FVersionLogSize);
  if Assigned(FOnEnding) then
    FOnEnding(Installation);
end;

procedure TJclInstall.ShowProgress;
var
  Percent: Integer;
begin
  if (FTotalLogSize > 0) and Assigned(FOnProgress) then
  begin
    Percent := (FLogSize * 100) div FTotalLogSize;
    if Percent <> FProgressPercent then
    begin
      FProgressPercent := Percent;
      FOnProgress(Percent);
    end;
  end;
end;

function TJclInstall.Supports(Installation: TJclBorRADToolInstallation): Boolean;
begin
  {$IFDEF KYLIX}
  Result := Installation.VersionNumber = 3;
  {$ELSE}
  if Installation.RADToolKind = brCppBuilder then
    Result := Installation.VersionNumber in [5..6]
  else
    Result := Installation.VersionNumber in [5..7];
  {$ENDIF}
end;

procedure TJclInstall.WriteInstallLog(const Msg: string);
var
  N: Integer;
begin
  N := StrCharCount(Msg, AnsiLineFeed);
  Inc(FVersionLogSize, N);
  Inc(FLogSize, N);
  ShowProgress;
  Tool.WriteInstallLog(Msg);
end;

end.
