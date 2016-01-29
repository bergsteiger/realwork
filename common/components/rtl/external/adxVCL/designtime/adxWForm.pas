{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit adxWForm;

{$I adxDefs.inc}

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComObj, ActiveX, {$IFNDEF ADX_VCL14} FileCtrl, {$ENDIF}
  Contnrs, Registry, jpeg;

type
  TPropPage = class(TObject)
  private
    FFolderName: string;
    FCoClassName: string;
    FTabTitle: string;
    FIID,
    FDIID,
    FCLSID: TGUID;
    FIsEqualOptionsPage: boolean;
    function GetIsAllFolders: boolean;
    function GetIsOptionPage: boolean;
  protected
  public
    property FolderName: string read FFolderName write FFolderName;
    property CoClassName: string read FCoClassName write FCoClassName;
    property TabTitle: string read FTabTitle write FTabTitle;
    property IID: TGUID read FIID;
    property DIID: TGUID read FDIID;
    property CLSID: TGUID read FCLSID;
    property IsOptionPage: boolean read GetIsOptionPage;
    property IsAllFolders: boolean read GetIsAllFolders;
    property IsEqualOptionsPage: boolean read FIsEqualOptionsPage;
    constructor Create; overload;
    constructor Create(APropPage: TPropPage); overload;
  end;

  TPropPages = class(TObjectList)
  private
    function GetItem(Index: Integer): TPropPage;
    procedure SetItem(Index: Integer; const AObject: TPropPage);
  public
    function FindCoClassName(const Name: string): boolean;
    function OptionPageExist: boolean;
    function FolderPageExist: boolean;
    property Items[Index: Integer]: TPropPage read GetItem write SetItem; default;
  end;

  TTaskPane = class(TObject)
  private
    FCoClassName: string;
    FTitle: string;
    FIID,
    FDIID,
    FCLSID: TGUID;
  protected
  public
    property CoClassName: string read FCoClassName write FCoClassName;
    property Title: string read FTitle write FTitle;
    property IID: TGUID read FIID;
    property DIID: TGUID read FDIID;
    property CLSID: TGUID read FCLSID;
    constructor Create; overload;
    constructor Create(ATaskPane: TTaskPane); overload;
  end;

  TTaskPanes = class(TObjectList)
  private
    function GetItem(Index: Integer): TTaskPane;
    procedure SetItem(Index: Integer; const AObject: TTaskPane);
  public
    function FindCoClassName(const Name: string): boolean;
    property Items[Index: Integer]: TTaskPane read GetItem write SetItem; default;
  end;

  TDestApplication = (daOutlook, daOffice, daRTD, daIE, daSmartTag, daOffice_XL, daOffice_WD);
  TOutlookPropPage = (oppTools, oppFolders);
  TOutlookPropPageSet = set of TOutlookPropPage;
  TAppFormat = (afDLL, afStandalone);

  TadxWMainForm = class(TForm)
    panDsk: TPanel;
    Panel1: TPanel;
    panWorkspace: TPanel;
    panButtons: TPanel;
    btnCancel: TButton;
    btnNext: TButton;
    btnBack: TButton;
    Image1: TImage;
    panToForm: TPanel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FClientForm: TForm;
    FCurrStep: Integer;
    //
    FProjectName: string;
    FDestinationFolder: string;
    FAddInCoClassName: string;
    FRegisterUnder: Integer;
    //
    FLIBID: TGUID;
    FIID: TGUID;
    FCLSID: TGUID;
    FIID2: TGUID;
    FCLSID2: TGUID;
    FPropPages: TPropPages;
    FRTDFormat: TAppFormat;
    FInnoSetup: boolean;
    FWiXSetup: boolean;
    //
    FShortDelphiPath: string;
    FLongDelphiPath: string;
    //
    FTaskPanes: TTaskPanes;
    {$IFNDEF DELPHI_12_UP}
    procedure CreateTypeLibrary;
    {$ENDIF}
  public
    FDestApp: TDestApplication;
    { Public declarations }
    constructor Create(const DestApp: TDestApplication); reintroduce;
    destructor Destroy; override;
    //
    procedure DoStep;
    function CreateProject: boolean;
    //
    property ProjectName: string read FProjectName write FProjectName;
    property DestinationFolder: string read FDestinationFolder write FDestinationFolder;
    property AddInCoClassName: string read FAddInCoClassName write FAddInCoClassName;
    property RegisterUnder: Integer read FRegisterUnder write FRegisterUnder default 0;
    property IsInnoSetup: boolean read FInnoSetup write FInnoSetup default False;
    property IsWiXSetup: boolean read FWiXSetup write FWiXSetup default False;
    //
    property PropPages: TPropPages read FPropPages;
    property RTDFormat: TAppFormat read FRTDFormat write FRTDFormat;
    //
    property ShortDelphiPath: string read FShortDelphiPath;
    property LongDelphiPath: string read FLongDelphiPath;
    //
    property TaskPanes: TTaskPanes read FTaskPanes;
  end;

  function GetRegistryValue(AHive: LongWord; AKey, AValueName: string): string;

var
  adxWMainForm: TadxWMainForm;
  MaxStep: Integer = 0;

implementation

{$R *.DFM}

uses {ExptIntf, }adxWFrmClient, adxWFrmClientStart, adxWFrmClient1,
  adxWFrmClient3, adxWFrmClient4, adxWFrmClient5, adxWFrmClient6;

{$I adxWCode.inc}
{$I adxWCodeST.inc}

type
  EadxWError = class(Exception);

function GUIDToString2(GUID: TGUID): string;
begin
  result:= format('%.8x-%.4x-%.4x-%.2x%.2x-%.2x%.2x%.2x%.2x%.2x%.2x',
    [GUID.D1, GUID.D2, GUID.D3, GUID.D4[0], GUID.D4[1], GUID.D4[2], GUID.D4[3], GUID.D4[4], GUID.D4[5], GUID.D4[6], GUID.D4[7]]);
end;

{ TPropPage }

constructor TPropPage.Create;
begin
  inherited Create;
  CoCreateGUID(FIID);
  CoCreateGUID(FDIID);
  CoCreateGUID(FCLSID);
end;

constructor TPropPage.Create(APropPage: TPropPage);
begin
  inherited Create;
  FFolderName := APropPage.FolderName;
  FCoClassName := APropPage.CoClassName;
  FTabTitle := APropPage.TabTitle;
  FIID := APropPage.IID;
  FDIID := APropPage.DIID;
  FCLSID := APropPage.CLSID;
end;

function TPropPage.GetIsAllFolders: boolean;
begin
  Result := FolderName = 'All Folders';
end;

function TPropPage.GetIsOptionPage: boolean;
begin
  Result := FolderName = '';
end;

{ TPropPages }

function TPropPages.FindCoClassName(const Name: string): boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
    if Items[i].CoClassName = Name then
    begin
      Result := True;
      Break;
    end;
end;

function TPropPages.OptionPageExist: boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
    if Items[i].IsOptionPage then begin
      Result := True;
      Break;
    end;
end;

function TPropPages.FolderPageExist: boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
    if not Items[i].IsOptionPage then begin
      Result := True;
      Break;
    end;
end;

function TPropPages.GetItem(Index: Integer): TPropPage;
begin
  Result := TPropPage(inherited Items[Index]);
end;

procedure TPropPages.SetItem(Index: Integer; const AObject: TPropPage);
begin
  inherited Items[Index] := AObject;
end;

{ TTaskPane }

constructor TTaskPane.Create;
begin
  inherited Create;
  CoCreateGUID(FIID);
  CoCreateGUID(FDIID);
  CoCreateGUID(FCLSID);
end;

constructor TTaskPane.Create(ATaskPane: TTaskPane);
begin
  inherited Create;
  FCoClassName := ATaskPane.CoClassName;
  FTitle := ATaskPane.Title;
  FIID := ATaskPane.IID;
  FDIID := ATaskPane.DIID;
  FCLSID := ATaskPane.CLSID;
end;

{ TTaskPanes }

function TTaskPanes.FindCoClassName(const Name: string): boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
    if Items[i].CoClassName = Name then
    begin
      Result := True;
      Break;
    end;
end;

function TTaskPanes.GetItem(Index: Integer): TTaskPane;
begin
  Result := TTaskPane(inherited Items[Index]);
end;

procedure TTaskPanes.SetItem(Index: Integer; const AObject: TTaskPane);
begin
  inherited Items[Index] := AObject;
end;

{ TadxWMainForm }

constructor TadxWMainForm.Create(const DestApp: TDestApplication);
//{$IFNDEF DELPHI_9_UP}
var
  S: string;
//{$ENDIF}
begin
  inherited Create(nil);
  {$IFDEF DELPHI_9_UP}
  FShortDelphiPath := '$(BDSPROJECTSDIR)';
  S := '';
  try
  {$IFDEF ADX_VCL9}
    S := GetRegistryValue(HKEY_CURRENT_USER, 'Software\Borland\BDS\3.0\Environment Variables', 'BDSPROJECTSDIR');
  {$ENDIF ADX_VCL9}
  {$IFDEF ADX_VCL10}
    S := GetRegistryValue(HKEY_CURRENT_USER, 'Software\Borland\BDS\4.0\Environment Variables', 'BDSPROJECTSDIR');
  {$ENDIF ADX_VCL10}
  {$IFDEF ADX_VCL11}
    S := GetRegistryValue(HKEY_CURRENT_USER, 'Software\Borland\BDS\5.0\Environment Variables', 'BDSPROJECTSDIR');
  {$ENDIF ADX_VCL11}
  except
  end;
  if S <> '' then
    FLongDelphiPath := ExcludeTrailingPathDelimiter(S)
  else
    FLongDelphiPath := GetEnvironmentVariable('BDSPROJECTSDIR');
  {$ENDIF DELPHI_9_UP}

  {$IFDEF ADX_VCL5}
  FShortDelphiPath := '$(DELPHI)';
  S := GetRegistryValue(HKEY_LOCAL_MACHINE, 'Software\Borland\Delphi\5.0', 'RootDir');
  if S <> '' then
    FLongDelphiPath := ExcludeTrailingBackslash(S);
  {$ENDIF ADX_VCL5}
  {$IFDEF ADX_VCL6}
  FShortDelphiPath := '$(DELPHI)';
  S := GetRegistryValue(HKEY_LOCAL_MACHINE, 'Software\Borland\Delphi\6.0', 'RootDir');
  if S <> '' then
    FLongDelphiPath := ExcludeTrailingPathDelimiter(S);
  {$ENDIF ADX_VCL6}
  {$IFDEF ADX_VCL7}
  FShortDelphiPath := '$(DELPHI)';
  S := GetRegistryValue(HKEY_LOCAL_MACHINE, 'Software\Borland\Delphi\7.0', 'RootDir');
  if S <> '' then
    FLongDelphiPath := ExcludeTrailingPathDelimiter(S);
  {$ENDIF ADX_VCL7}

  FDestApp := DestApp;
  case FDestApp of
    daRTD:
      begin
        MaxStep := 3;
        Caption := Format(Caption, ['Real-Time Data Server Wizard']);
      end;
    daOffice:
      begin
        MaxStep := 3; // 2
        Caption := Format(Caption, ['MS Office COM Add-in Wizard']);
      end;
    daOffice_XL:
      begin
        MaxStep := 2;
        Caption := Format(Caption, ['MS Excel COM Add-in Wizard (MS Forms Controls)']);
      end;
    daOffice_WD:
      begin
        MaxStep := 2;
        Caption := Format(Caption, ['MS Word COM Add-in Wizard (MS Forms Controls)']);
      end;
    daOutlook:
      begin
        MaxStep := 4; // 3
        Caption := Format(Caption, ['MS Outlook COM Add-in Wizard']);
      end;
    daIE: MaxStep := 0;
    daSmartTag:
      begin
        MaxStep := 2;
        Caption := Format(Caption, ['Smart Tag Wizard']);
      end;
    else
      ShowMessage('Error');
  end;
  FPropPages := TPropPages.Create(True);
  FTaskPanes := TTaskPanes.Create(True);
  FCurrStep := 0;
  FInnoSetup := False;
  FWiXSetup := False;
  DoStep;
end;

destructor TadxWMainForm.Destroy;
begin
  FTaskPanes.Free; 
  FPropPages.Free;
  inherited Destroy;
end;

procedure TadxWMainForm.btnCancelClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to exit the wizard?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    ModalResult := mrAbort;
end;

procedure TadxWMainForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrCancel then
    if MessageDlg('Are you sure you want to exit the wizard?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then ModalResult := mrAbort
    else CanClose := False;
end;

procedure TadxWMainForm.btnBackClick(Sender: TObject);
begin
  FCurrStep := Pred(FCurrStep);
//  {$IFDEF ADX_VCL9}
//   skip options page
//  if (FDestApp = daOutlook) and (FCurrStep = 2) then
//    FCurrStep := Pred(FCurrStep);
//  {$ENDIF}
  DoStep;
end;

procedure TadxWMainForm.btnNextClick(Sender: TObject);
begin
  try
    if FCurrStep <> MaxStep then begin
      if (FClientForm as TfrmClient).Check then begin
        FCurrStep := Succ(FCurrStep);
//        {$IFDEF ADX_VCL9}
//        // skip options page
//        if (FDestApp = daOutlook) and (FCurrStep = 2) then
//          FCurrStep := Succ(FCurrStep);
//        {$ENDIF}
        DoStep;
      end;
    end
    else
      if CreateProject then ModalResult := mrOk;
  except
    on E: Exception do
      if not (E is EadxWError) then raise E;
  end;
end;

procedure TadxWMainForm.DoStep;
begin
  btnBack.Enabled := FCurrStep <> 0;
  btnNext.Enabled := True;
  if FCurrStep = MaxStep then
    btnNext.Caption := 'Finish'
  else
    btnNext.Caption := '&Next >';
  if Assigned(FClientForm) then FreeAndNil(FClientForm);
  if FDestApp in [daRTD, daOutlook] then begin
    case FCurrStep of
      0: FClientForm := TfrmClientStart.Create(Self);
      1: FClientForm := TfrmClient1.Create(Self);
      2: if FDestApp = daRTD then FClientForm := TfrmClient3.Create(Self)
         else FClientForm := TfrmClient5.Create(Self);
      3: if FDestApp = daOutlook then FClientForm := TfrmClient6.Create(Self)
         else FClientForm := TfrmClient4.Create(Self);
      4: if FDestApp = daOutlook then FClientForm := TfrmClient4.Create(Self);
    end;
  end
  else
    if FDestApp in [daOffice, daSmartTag, daOffice_XL, daOffice_WD] then begin
      case FCurrStep of
        0: FClientForm := TfrmClientStart.Create(Self);
        1: FClientForm := TfrmClient1.Create(Self);
        2: if FDestApp = daOffice then FClientForm := TfrmClient6.Create(Self)
           else FClientForm := TfrmClient4.Create(Self);
        3: if FDestApp = daOffice then FClientForm := TfrmClient4.Create(Self);
      end;
    end
    else
      if FDestApp = daIE then begin
      end;
  if Assigned(FClientForm) then begin
    FClientForm.Parent := panToForm;
    FClientForm.Show;
    FClientForm.SetFocus;
  end;
end;

function TadxWMainForm.CreateProject: boolean;

  procedure CheckExistingFile(const FileName: string);
  begin
    if FileExists(FileName) then
      if MessageDlg( Format('The file "%s" already exists! Do you want replace the existing file?',
        [FileName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        DeleteFile(FileName)
      else
        raise EadxWError.Create(Format('The file "%s" already exists!', [FileName]));
  end;

const
  EmptyResFile: array [0..15] of Word = (
    $0000, $0000, $0020, $0000, $FFFF, $0000, $FFFF, $0000,
    $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000);
var
  i: Integer;
  Module: TStrings;
  s, FldAdding, OptAdding, IndentStr: string;
  Stream: TMemoryStream;
  UniquePages: TPropPages;
  {$IFDEF DELPHI_9_UP}
  BdsProjIID: TGUID;
  ProjectExt: string;
  {$ENDIF}
  {$IFDEF DELPHI_12_UP}
  EnumIID: TGUID;
  {$ENDIF}
  TempGuid: TGUID;

  {$IFDEF DELPHI_12_UP}
  function DelChar(source: string; chars: TSysCharSet): string;
  begin
    result:= '';
  end;
  {$ENDIF}

begin
  Result := True;
  // Create all GUIDs
  CoCreateGUID(FLIBID);
  CoCreateGUID(FIID);
  CoCreateGUID(FCLSID);
  // Smart Tag
  CoCreateGUID(FIID2);
  CoCreateGUID(FCLSID2);
  // Create destination directory
  if not DirectoryExists(DestinationFolder) then
    if MessageDlg(Format('The folder "%s" doesn'#39't exists. Do you want to create it?',
      [DestinationFolder]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      if ExtractFileDrive(DestinationFolder) = '' then begin
        MessageDlg(Format('Incorrect path to the destination folder! Can'#39't create the "%s" folder.',
          [DestinationFolder]), mtError, [mbCancel], 0);
        Result := false;
      end
      else
      if not CreateDir(DestinationFolder) then begin
        MessageDlg(Format('Can'#39't create the "%s" folder.',
          [DestinationFolder]), mtError, [mbCancel], 0);
        Result := false;
      end;
    end
    else
      Result := false;
  //
  if Result then begin
    Module := TStringList.Create;
    Stream := TMemoryStream.Create;
    Stream.Write(EmptyResFile, SizeOf(EmptyResFile));
    if DestinationFolder[Length(DestinationFolder)] <> '\' then
      DestinationFolder := DestinationFolder + '\';
    UniquePages := TPropPages.Create(False);
    try
      // Create project module
      Module.Clear;
      if (FDestApp = daRTD) and (RTDFormat = afStandalone) then
        Module.Text := StringReplace(ProjectAppModule, lexProjectName,
          ProjectName, [rfReplaceAll, rfIgnoreCase])
      else begin
        if FDestApp = daSmartTag then
          Module.Text := StringReplace(ProjectModuleST, lexProjectName,
            ProjectName, [rfReplaceAll, rfIgnoreCase])
        else
          Module.Text := StringReplace(ProjectModule, lexProjectName,
            ProjectName, [rfReplaceAll, rfIgnoreCase]);

        if Self.FRegisterUnder = 1 then begin
          Module.Text := StringReplace(Module.Text, lexRegisterStuff, chCR + RegisterStuff + chCR, [rfReplaceAll, rfIgnoreCase]);
          Module.Strings[3] := '  ComServ, ComObj, Windows, adxAddIn,';
        end
        else
          Module.Text := StringReplace(Module.Text, lexRegisterStuff, '', [rfReplaceAll, rfIgnoreCase]);
      end;
      if FDestApp = daRTD then
        Module.Text := StringReplace(Module.Text, lexModuleType,
          'RTDServerModule', [rfReplaceAll, rfIgnoreCase])
      else
        if FDestApp = daSmartTag then
          Module.Text := StringReplace(Module.Text, lexModuleType,
            'SmartTagModule', [rfReplaceAll, rfIgnoreCase])
        else
          Module.Text := StringReplace(Module.Text, lexModuleType,
            'AddInModule', [rfReplaceAll, rfIgnoreCase]);
      // {zzz: CoClass}
      Module.Text := StringReplace(Module.Text, lexAddInCoClassName,
        AddInCoClassName, [rfReplaceAll, rfIgnoreCase]);

      if (FDestApp = daOutlook) and (PropPages.Count > 0) then begin
        for i := 0 to PropPages.Count - 1 do
          if not UniquePages.FindCoClassName(PropPages[i].CoClassName) then
            UniquePages.Add(PropPages[i]);
        s := '';
        for i := 0 to UniquePages.Count - 1 do
          s := s + StringReplace(OutlookProjectModule, lexToolsPropPage,
            UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
        s := TrimRight(s);
        s[Length(s)] := ';';
        Module.Insert(6, s);
        s := Module[5];
        s[Length(s)] := ',';
        Module[5] := s;
      end;
      if (TaskPanes.Count > 0) then begin
        s := '';
        for i := 0 to TaskPanes.Count - 1 do
          s := s + StringReplace(OutlookProjectModule, lexToolsPropPage,
            TaskPanes[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
        s := TrimRight(s);
        if PropPages.Count = 0 then
          s[Length(s)] := ';';
        Module.Insert(6, s);
        s := Module[5];
        s[Length(s)] := ',';
        Module[5] := s;
      end;

      CheckExistingFile(DestinationFolder + ProjectName + '.dpr');
      Module.SaveToFile(DestinationFolder + ProjectName + '.dpr');
      // Create ini file
      if Self.FRegisterUnder = 1 then begin
        Module.Clear;
        Module.Text := RegisterINIFile;
        CheckExistingFile(DestinationFolder + ProjectName + '.ini');
        Module.SaveToFile(DestinationFolder + ProjectName + '.ini');
      end;
      // Create implementation module
      Module.Clear;
      if (FDestApp = daOutlook) and (PropPages.Count > 0) then begin
        s := IMPLModuleOutlook;
        if PropPages.OptionPageExist and PropPages.FolderPageExist then begin
          s := StringReplace(s, '%PROTECTED_DECL%', ProtectedDeclOptions + ProtectedDeclFolders, [rfReplaceAll, rfIgnoreCase]);
          OptAdding := '';
          FldAdding := '';
          for i := 0 to PropPages.Count - 1 do begin
            if PropPages[i].IsOptionPage then begin
              OptAdding := OptAdding + StringReplace(OptionsAddingCode,
                lexToolsPropPage, PropPages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              OptAdding := StringReplace(OptAdding, lexToolsPropPageTitle,
                PropPages[i].TabTitle, [rfReplaceAll, rfIgnoreCase]);
            end
            else begin
              if PropPages[i].FolderName <> '*' then begin
                FldAdding := FldAdding + StringReplace(FolderConditionalCode,
                  '%FOLDER_NAME%', PropPages[i].FolderName, [rfReplaceAll, rfIgnoreCase]);
                IndentStr := '  ';
              end
              else
                IndentStr := '';
              FldAdding := FldAdding + IndentStr + StringReplace(FolderAddingCode,
                lexFoldersPropPage, PropPages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              FldAdding := StringReplace(FldAdding, lexFoldersPropPageTitle,
                PropPages[i].TabTitle, [rfReplaceAll, rfIgnoreCase]);
            end;
          end;
          OptAdding := StringReplace(OptionsCode, '%OPTION_ADDING%', OptAdding,
            [rfReplaceAll, rfIgnoreCase]);
          FldAdding := StringReplace(FoldersCode, '%FOLDER_ADDING%', FldAdding,
            [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, '%CODE%', OptAdding + #13#10 + FldAdding,
            [rfReplaceAll, rfIgnoreCase]);
        end
        else begin
          if PropPages.OptionPageExist then begin
            s := StringReplace(s, '%PROTECTED_DECL%', ProtectedDeclOptions, [rfReplaceAll, rfIgnoreCase]);
            OptAdding := '';
            for i := 0 to PropPages.Count - 1 do
              if PropPages[i].IsOptionPage then begin
                OptAdding := OptAdding + StringReplace(OptionsAddingCode,
                  lexToolsPropPage, PropPages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
                OptAdding := StringReplace(OptAdding, lexToolsPropPageTitle,
                  PropPages[i].TabTitle, [rfReplaceAll, rfIgnoreCase]);
              end;
            OptAdding := StringReplace(OptionsCode, '%OPTION_ADDING%', OptAdding,
              [rfReplaceAll, rfIgnoreCase]);
            s := StringReplace(s, '%CODE%', OptAdding, [rfReplaceAll, rfIgnoreCase]);
          end;
          if PropPages.FolderPageExist then begin
            s := StringReplace(s, '%PROTECTED_DECL%', ProtectedDeclFolders, [rfReplaceAll, rfIgnoreCase]);
            FldAdding := '';
            for i := 0 to PropPages.Count - 1 do
              if not PropPages[i].IsOptionPage then begin
                if PropPages[i].FolderName <> '*' then begin
                  FldAdding := FldAdding + StringReplace(FolderConditionalCode,
                    '%FOLDER_NAME%', PropPages[i].FolderName, [rfReplaceAll, rfIgnoreCase]);
                  IndentStr := '  ';
                end else
                  IndentStr := '';
                FldAdding := FldAdding + IndentStr + StringReplace(FolderAddingCode,
                  lexFoldersPropPage, PropPages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
                FldAdding := StringReplace(FldAdding, lexFoldersPropPageTitle,
                  PropPages[i].TabTitle, [rfReplaceAll, rfIgnoreCase]);
              end;
            FldAdding := StringReplace(FoldersCode, '%FOLDER_ADDING%', FldAdding,
              [rfReplaceAll, rfIgnoreCase]);
            s := StringReplace(s, '%CODE%', FldAdding, [rfReplaceAll, rfIgnoreCase]);
          end;
        end;
        s := StringReplace(s, lexAddInCoClassName,
          AddInCoClassName, [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, lexUnitList,
          UnitList, [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, lexProjectName,
          ProjectName, [rfReplaceAll, rfIgnoreCase]);
        Module.Text := s;
      end
      else begin
        if FDestApp = daRTD then
          s := StringReplace(IMPLModuleRTD, lexAddInCoClassName,
            AddInCoClassName, [rfReplaceAll, rfIgnoreCase])
        else
          if FDestApp = daSmartTag then
            s := StringReplace(IMPLModuleST, lexAddInCoClassName,
              AddInCoClassName, [rfReplaceAll, rfIgnoreCase])
          else
            if FDestApp in [daOffice, daOutlook] then begin
              if TaskPanes.Count > 0 then begin
                s := StringReplace(IMPLModuleTaskPane, lexAddInCoClassName,
                  AddInCoClassName, [rfReplaceAll, rfIgnoreCase]);
              end
              else
                s := StringReplace(IMPLModule, lexAddInCoClassName,
                  AddInCoClassName, [rfReplaceAll, rfIgnoreCase])
            end
            else
              if FDestApp = daOffice_XL then
                s := StringReplace(IMPLModule_XL, lexAddInCoClassName,
                  AddInCoClassName, [rfReplaceAll, rfIgnoreCase])
              else
                if FDestApp = daOffice_WD then
                  s := StringReplace(IMPLModule_WD, lexAddInCoClassName,
                    AddInCoClassName, [rfReplaceAll, rfIgnoreCase]);
        if FDestApp = daOutlook then
          s := StringReplace(s, lexUnitList, UnitList + ', Outlook2000', [rfReplaceAll, rfIgnoreCase])
        else
          s := StringReplace(s, lexUnitList, UnitList, [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, lexProjectName, ProjectName, [rfReplaceAll, rfIgnoreCase]);
        Module.Text := s;
      end;
      CheckExistingFile(DestinationFolder + ProjectName + '_IMPL.pas');
      Module.SaveToFile(DestinationFolder + ProjectName + '_IMPL.pas');
      // DFM file
      Module.Clear;
      if FDestApp = daRTD then Module.Text := IMPLModuleRTD_DFM
      else
        if FDestApp = daOutlook then begin
          Module.Text := StringReplace(IMPLModuleOutlookDFM, lexAddInCoClassName, AddInCoClassName, [rfReplaceAll, rfIgnoreCase]);
          if (PropPages.Count = 0) and (TaskPanes.Count = 0) then begin
            if Module.IndexOf('  OnAddInInitialize = adxCOMAddInModuleAddInInitialize') > 0 then
              Module.Delete(Module.IndexOf('  OnAddInInitialize = adxCOMAddInModuleAddInInitialize'));
            if Module.IndexOf('  OnAddInFinalize = adxCOMAddInModuleAddInFinalize') > 0 then
              Module.Delete(Module.IndexOf('  OnAddInFinalize = adxCOMAddInModuleAddInFinalize'));
          end;
          if TaskPanes.Count > 0 then begin
            s := '';
            for i := 0 to TaskPanes.Count - 1 do
              s := s + #13#10 +
                 '    item' + #13#10 +
                 '      ControlProgID = ''' + Self.ProjectName + '.' + TaskPanes[i].CoClassName + '''' + #13#10 +
                 '      Title = ''' + TaskPanes[i].Title + '''' + #13#10 +
                 '    end';
            Module.Text := StringReplace(Module.Text, '%TASK_PANES%', s, [rfReplaceAll, rfIgnoreCase]);
          end
          else
            Module.Text := StringReplace(Module.Text, '%TASK_PANES%', '', [rfReplaceAll, rfIgnoreCase]);
        end
        else
          if FDestApp = daSmartTag then
            Module.Text := StringReplace(IMPLModuleDFMST, lexAddInCoClassName, AddInCoClassName, [rfReplaceAll, rfIgnoreCase])
          else
            if FDestApp = daOffice then begin
              if TaskPanes.Count > 0 then begin
                Module.Text := StringReplace(IMPLModuleTaskPaneDFM, lexAddInCoClassName, AddInCoClassName, [rfReplaceAll, rfIgnoreCase]);
                s := '';
                for i := 0 to TaskPanes.Count - 1 do
                  s := s + #13#10 +
                     '    item' + #13#10 +
                     '      ControlProgID = ''' + Self.ProjectName + '.' + TaskPanes[i].CoClassName + '''' + #13#10 +
                     '      Title = ''' + TaskPanes[i].Title + '''' + #13#10 +
                     '    end';
                Module.Text := StringReplace(Module.Text, '%TASK_PANES%', s, [rfReplaceAll, rfIgnoreCase]);
              end
              else
                Module.Text := StringReplace(IMPLModuleDFM, lexAddInCoClassName, AddInCoClassName, [rfReplaceAll, rfIgnoreCase])
            end
            else
              if FDestApp = daOffice_XL then
                Module.Text := StringReplace(IMPLModuleDFM_XL, lexAddInCoClassName, AddInCoClassName, [rfReplaceAll, rfIgnoreCase])
              else
                if FDestApp = daOffice_WD then
                  Module.Text := StringReplace(IMPLModuleDFM_WD, lexAddInCoClassName, AddInCoClassName, [rfReplaceAll, rfIgnoreCase]);
      CheckExistingFile(DestinationFolder + ProjectName + '_IMPL.dfm');
      Module.SaveToFile(DestinationFolder + ProjectName + '_IMPL.dfm');

      // Create Property Pages
      Module.Clear;
      if (FDestApp = daOutlook) and (PropPages.Count > 0) then begin
        if UniquePages.OptionPageExist then
          for i := 0 to UniquePages.Count - 1 do
            if UniquePages[i].IsOptionPage then begin
              s := StringReplace(PASModule, lexToolsPropPage,
                UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              Module.Text := StringReplace(s, lexProjectName,
                ProjectName, [rfReplaceAll, rfIgnoreCase]);
              CheckExistingFile(DestinationFolder + UniquePages[i].CoClassName + '.pas');
              Module.SaveToFile(DestinationFolder + UniquePages[i].CoClassName + '.pas');
              Module.Clear;
              Module.Text := StringReplace(DFMModuleOptions, lexToolsPropPage,
                UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              CheckExistingFile(DestinationFolder + UniquePages[i].CoClassName + '.dfm');
              Module.SaveToFile(DestinationFolder + UniquePages[i].CoClassName + '.dfm');
            end;
        if UniquePages.FolderPageExist then
          for i := 0 to UniquePages.Count - 1 do
            if not UniquePages[i].IsOptionPage then begin
              s := StringReplace(PASModule, lexToolsPropPage,
                UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              Module.Text := StringReplace(s, lexProjectName,
                ProjectName, [rfReplaceAll, rfIgnoreCase]);
              CheckExistingFile(DestinationFolder + UniquePages[i].CoClassName + '.pas');
              Module.SaveToFile(DestinationFolder + UniquePages[i].CoClassName + '.pas');
              Module.Clear;
              Module.Text := StringReplace(DFMModuleFolders, lexToolsPropPage,
                UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              CheckExistingFile(DestinationFolder + UniquePages[i].CoClassName + '.dfm');
              Module.SaveToFile(DestinationFolder + UniquePages[i].CoClassName + '.dfm');
            end;
      end;
      // Create Task Panes
      Module.Clear;
      if (TaskPanes.Count > 0) then begin
        for i := 0 to TaskPanes.Count - 1 do begin
          s := StringReplace(TaskPanePASModule, lexToolsPropPage,
            TaskPanes[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
          Module.Text := StringReplace(s, lexProjectName,
            ProjectName, [rfReplaceAll, rfIgnoreCase]);
          CheckExistingFile(DestinationFolder + TaskPanes[i].CoClassName + '.pas');
          Module.SaveToFile(DestinationFolder + TaskPanes[i].CoClassName + '.pas');
          Module.Clear;
          Module.Text := StringReplace(TaskPaneDFMModuleOptions, lexToolsPropPage,
            TaskPanes[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
          CheckExistingFile(DestinationFolder + TaskPanes[i].CoClassName + '.dfm');
          Module.SaveToFile(DestinationFolder + TaskPanes[i].CoClassName + '.dfm');
        end;
      end;
      // Create TLB module
      Module.Clear;
      if FDestApp = daSmartTag then begin
        s := StringReplace(TLBModuleST, lexAddinCoClassName, AddinCoClassName, [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, lexIID2, GUIDToString(FIID2), [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, lexCLSID2, GUIDToString(FCLSID2), [rfReplaceAll, rfIgnoreCase]);
      end
      else
        s := StringReplace(TLBModule, lexAddinCoClassName, AddinCoClassName, [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, lexProjectName, ProjectName, [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, lexUnitList, UnitList, [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, lexLIBID, GUIDToString(FLIBID), [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, lexIID, GUIDToString(FIID), [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, lexCLSID, GUIDToString(FCLSID), [rfReplaceAll, rfIgnoreCase]);
      Module.Text := s;
      if (PropPages.Count > 0) or (TaskPanes.Count > 0) then begin
        s := '';
        if UniquePages.OptionPageExist then
          for i := 0 to UniquePages.Count - 1 do
            if UniquePages[i].IsOptionPage then begin
              s := s + StringReplace(TToolsLBModule, lexToolsPropPage,
                UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexToolsIID, GUIDToString(UniquePages[i].IID),
                [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexToolsDIID, GUIDToString(UniquePages[i].DIID),
                [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexToolsCLSID, GUIDToString(UniquePages[i].CLSID),
                [rfReplaceAll, rfIgnoreCase]);
            end;
        if UniquePages.FolderPageExist then
          for i := 0 to UniquePages.Count - 1 do
            if not UniquePages[i].IsOptionPage then begin
              s := s + StringReplace(TFoldersLBModule, lexFoldersPropPage,
                UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexFoldersIID, GUIDToString(UniquePages[i].IID),
                [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexFoldersDIID, GUIDToString(UniquePages[i].DIID),
                [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexFoldersCLSID, GUIDToString(UniquePages[i].CLSID),
                [rfReplaceAll, rfIgnoreCase]);
            end;
        // Task Panes
        for i := 0 to TaskPanes.Count - 1 do begin
          s := s + StringReplace(TFoldersLBModule, lexFoldersPropPage,
            TaskPanes[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexFoldersIID, GUIDToString(TaskPanes[i].IID),
            [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexFoldersDIID, GUIDToString(TaskPanes[i].DIID),
            [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexFoldersCLSID, GUIDToString(TaskPanes[i].CLSID),
            [rfReplaceAll, rfIgnoreCase]);
        end;
        s := s + TPropPageProperties;
        Module.Insert(16, s);
        s := '';
        if UniquePages.OptionPageExist then
          for i := 0 to UniquePages.Count - 1 do
            if UniquePages[i].IsOptionPage then begin
              s := s + StringReplace(TLBModule2, lexToolsPropPage,
                UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexToolsIID, GUIDToString(UniquePages[i].IID),
                [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexToolsDIID, GUIDToString(UniquePages[i].DIID),
                [rfReplaceAll, rfIgnoreCase]);
            end;
        if UniquePages.FolderPageExist then
          for i := 0 to UniquePages.Count - 1 do
            if not UniquePages[i].IsOptionPage then begin
              s := s + StringReplace(TLBModule2, lexToolsPropPage,
                UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexToolsIID, GUIDToString(UniquePages[i].IID),
                [rfReplaceAll, rfIgnoreCase]);
              s := StringReplace(s, lexToolsDIID, GUIDToString(UniquePages[i].DIID),
                [rfReplaceAll, rfIgnoreCase]);
            end;
        // Task Panes
        for i := 0 to TaskPanes.Count - 1 do begin
          s := s + StringReplace(TLBModule2, lexToolsPropPage,
            TaskPanes[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsIID, GUIDToString(TaskPanes[i].IID),
            [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsDIID, GUIDToString(TaskPanes[i].DIID),
            [rfReplaceAll, rfIgnoreCase]);
        end;
        Module.Insert(Module.IndexOf('implementation'), s);
      end;
      CheckExistingFile(DestinationFolder + ProjectName + '_TLB.pas');
      Module.SaveToFile(DestinationFolder + ProjectName + '_TLB.pas');
      {$IFDEF DELPHI_12_UP}
      // Create RIDL
      Module.Clear;
      if FDestApp = daSmartTag then begin
        s := StringReplace(RIDLModuleST, lexAddinCoClassName, AddinCoClassName, [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, lexIID2, GUIDToString(FIID2), [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, lexCLSID2, GUIDToString(FCLSID2), [rfReplaceAll, rfIgnoreCase]);
      end
      else
        s := StringReplace(RIDLModule, lexAddinCoClassName, AddinCoClassName, [rfReplaceAll, rfIgnoreCase]);

      s := StringReplace(s, lexProjectName, ProjectName, [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, lexLIBID, GUIDToString2(FLIBID), [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, lexIID, GUIDToString2(FIID), [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, lexCLSID, GUIDToString2(FCLSID), [rfReplaceAll, rfIgnoreCase]);
      Module.Text := s;

      if (PropPages.Count > 0) or (TaskPanes.Count > 0) then begin
        s:= '';
        for i := 0 to UniquePages.Count - 1 do begin
          s := s + StringReplace(RIDLLBModule, lexToolsPropPage, UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsIID, GUIDToString2(UniquePages[i].IID), [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsDIID, GUIDToString2(UniquePages[i].DIID), [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsCLSID, GUIDToString2(UniquePages[i].CLSID), [rfReplaceAll, rfIgnoreCase]);
        end;
        for i := 0 to TaskPanes.Count - 1 do begin
          s := s + StringReplace(RIDLLBModule, lexToolsPropPage, TaskPanes[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsIID, GUIDToString2(TaskPanes[i].IID), [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsDIID, GUIDToString2(TaskPanes[i].DIID), [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsCLSID, GUIDToString2(TaskPanes[i].CLSID), [rfReplaceAll, rfIgnoreCase]);
        end;
        Module.Text := StringReplace(Module.Text, '%RIDLLBModule%', s, [rfReplaceAll, rfIgnoreCase]);

        s:= RIDLModuleEnum;
        for i := 1 to 3 do begin
          CoCreateGUID(EnumIID);
          s := StringReplace(s, '%ENUM_IID'+IntToStr(i)+'%', GUIDToString2(EnumIID), [rfReplaceAll, rfIgnoreCase]);
        end;
        Module.Text := StringReplace(Module.Text, '%RIDLModuleEnum%', s, [rfReplaceAll, rfIgnoreCase]);

        s:= '';
        for i := 0 to UniquePages.Count - 1 do begin
          s := s + StringReplace(RIDLModuleTools, lexToolsPropPage, UniquePages[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsIID, GUIDToString2(UniquePages[i].IID), [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsDIID, GUIDToString2(UniquePages[i].DIID), [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsCLSID, GUIDToString2(UniquePages[i].CLSID), [rfReplaceAll, rfIgnoreCase]);
        end;
        for i := 0 to TaskPanes.Count - 1 do begin
          s := s + StringReplace(RIDLModuleTools, lexToolsPropPage, TaskPanes[i].CoClassName, [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsIID, GUIDToString2(TaskPanes[i].IID), [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsDIID, GUIDToString2(TaskPanes[i].DIID), [rfReplaceAll, rfIgnoreCase]);
          s := StringReplace(s, lexToolsCLSID, GUIDToString2(TaskPanes[i].CLSID), [rfReplaceAll, rfIgnoreCase]);
        end;
        Module.Text := StringReplace(Module.Text, '%RIDLModuleTools%', s, [rfReplaceAll, rfIgnoreCase]);
      end
      else begin
        Module.Text := StringReplace(Module.Text, '%RIDLLBModule%', '', [rfReplaceAll, rfIgnoreCase]);
        Module.Text := StringReplace(Module.Text, '%RIDLModuleEnum%', '', [rfReplaceAll, rfIgnoreCase]);
        Module.Text := StringReplace(Module.Text, '%RIDLModuleTools%', '', [rfReplaceAll, rfIgnoreCase]);
      end;

      CheckExistingFile(DestinationFolder + ProjectName + '.ridl');
      Module.SaveToFile(DestinationFolder + ProjectName + '.ridl');
      {$ENDIF}
      // Create resource file
      CheckExistingFile(DestinationFolder + ProjectName + '.res');
      Stream.SaveToFile(DestinationFolder + ProjectName + '.res');
      // Create TLB
      {$IFNDEF DELPHI_12_UP}
      CheckExistingFile(DestinationFolder + ProjectName + '.tlb');
      CreateTypeLibrary;
      {$ENDIF}
      {$IFDEF DELPHI_9_UP}
        // Create bdsproj
        ProjectExt:= '.bdsproj';
        Module.Clear;
        CoCreateGUID(BdsProjIID);
        {$IFDEF DELPHI_11_UP}
          ProjectExt:= '.dproj';
          {$IFDEF DELPHI_12_UP}
          s := StringReplace(D12ProjModule, lexProjectName, ProjectName, [rfReplaceAll, rfIgnoreCase]);
          {$ELSE}
          s := StringReplace(D11ProjModule, lexProjectName, ProjectName, [rfReplaceAll, rfIgnoreCase]);
          {$ENDIF}
        {$ELSE}
        s := StringReplace(BdsProjModule, lexProjectName, ProjectName, [rfReplaceAll, rfIgnoreCase]);
        {$ENDIF}
        s := StringReplace(s, lexAddInCoClassName, AddInCoClassName, [rfReplaceAll, rfIgnoreCase]);
        Module.Text := StringReplace(s, lexProjectGUID, GuidToString(BdsProjIID), [rfReplaceAll, rfIgnoreCase]);
        CheckExistingFile(DestinationFolder + ProjectName + ProjectExt);
        Module.SaveToFile(DestinationFolder + ProjectName + ProjectExt);
      {$ENDIF}

      // Create InnoSetup
      if FInnoSetup then begin
        Module.Clear;
        if Self.FRegisterUnder = 1 then
          Module.Text := StringReplace(ISSScript, '%INI_FILE%', 'Source: "%PROJECT_NAME%.ini";                                     DestDir: "{app}";', [rfReplaceAll, rfIgnoreCase])
        else
          Module.Text := StringReplace(ISSScript, '%INI_FILE%', '', [rfReplaceAll, rfIgnoreCase]);
        Module.Text := StringReplace(Module.Text, lexProjectName, ProjectName, [rfReplaceAll, rfIgnoreCase]);
        if FDestApp in [daOutlook, daOffice, daOffice_XL, daOffice_WD] then
          Module.Text := StringReplace(Module.Text, '%GDIPLUS%', 'Source: "gdiplus.dll";                                            DestDir: "{app}"; Flags: ignoreversion', [rfReplaceAll, rfIgnoreCase])
        else
          Module.Text := StringReplace(Module.Text, '%GDIPLUS%', '', [rfReplaceAll, rfIgnoreCase]);
        CheckExistingFile(DestinationFolder + ProjectName + '.iss');
        Module.SaveToFile(DestinationFolder + ProjectName + '.iss');
      end;
      // Create WiX setup
      if FWiXSetup then begin
        Module.Clear;
        if Self.FRegisterUnder = 1 then
          Module.Text := StringReplace(WIXScript, '%INI_FILE%', '                <File Id="%PROJECT_NAME%.ini" Source="%PROJECT_NAME%.ini"/>', [rfReplaceAll, rfIgnoreCase])
        else
          Module.Text := StringReplace(WIXScript, '%INI_FILE%', '', [rfReplaceAll, rfIgnoreCase]);
        Module.Text := StringReplace(Module.Text, lexProjectName, ProjectName, [rfReplaceAll, rfIgnoreCase]);
        if FDestApp in [daOutlook, daOffice, daOffice_XL, daOffice_WD] then
          Module.Text := StringReplace(Module.Text, '%GDIPLUS%', '                <File Id="gdiplus.dll" Source="gdiplus.dll"/>', [rfReplaceAll, rfIgnoreCase])
        else
          Module.Text := StringReplace(Module.Text, '%GDIPLUS%', '', [rfReplaceAll, rfIgnoreCase]);
        CoCreateGUID(TempGuid);
        Module.Text := StringReplace(Module.Text, '%GUID1%', GUIDToString(TempGuid), [rfReplaceAll, rfIgnoreCase]);
        CoCreateGUID(TempGuid);
        Module.Text := StringReplace(Module.Text, '%GUID2%', GUIDToString(TempGuid), [rfReplaceAll, rfIgnoreCase]);
        CoCreateGUID(TempGuid);
        Module.Text := StringReplace(Module.Text, '%GUID3%', GUIDToString(TempGuid), [rfReplaceAll, rfIgnoreCase]);

        CheckExistingFile(DestinationFolder + ProjectName + '.wxs');
        Module.SaveToFile(DestinationFolder + ProjectName + '.wxs');
        // bat file
        Module.Clear;
        Module.Text := StringReplace(WIXBat, lexProjectName, ProjectName, [rfReplaceAll, rfIgnoreCase]);
        CheckExistingFile(DestinationFolder + ProjectName + '.bat');
        Module.SaveToFile(DestinationFolder + ProjectName + '.bat');
      end;
    finally
      UniquePages.Free;
      Stream.Free;
      Module.Free;
    end;
  end; // if Result
end;

type
  TFuncType = (ftInvoke, ftGet, ftPut, ftGetPutByRef);
  TCallType = (ctVirual, ctPureVirtual, ctNonVirtual, ctStatic, ctDispatch);
  TParamType = record
    ParamName: string;
    ParamType: Integer;
    ParamDeclaration: Integer;
    Modifier: Integer;
    HReftype: Cardinal;
  end;
  TParamTypes = array of TParamType;

function GetRegistryValue(AHive: LongWord; AKey, AValueName: string): string;
begin
  Result := '';
  with TRegistry.Create(KEY_READ) do
    try
      RootKey := AHive;
      if OpenKey(AKey, False) then begin
        if ValueExists(AValueName) then Result := ReadString(AValueName);
        CloseKey;
      end;
    finally
      Free;
    end;
end;

procedure AddTypeLibFunction(const TypeInfo: ICreateTypeInfo; AName: string;
  ADispID, AIndex: Integer; const AParams: TParamTypes;
  AFuncType: TFuncType = ftInvoke; AResultType: Integer = VT_VOID;
  ACallType: TCallType = ctDispatch);
const
  FuncKind: array [TCallType] of Integer = (FUNC_VIRTUAL, FUNC_PUREVIRTUAL, FUNC_NONVIRTUAL, FUNC_STATIC, FUNC_DISPATCH);
  InvokeKind: array [TFuncType] of Integer = (INVOKE_FUNC, INVOKE_PROPERTYGET, INVOKE_PROPERTYPUT, INVOKE_PROPERTYPUTREF);
var
  i: Integer;
  FuncDesc: TFuncDesc;
  OleStrList: POleStrList;
  DescList: PElemDescList;
begin
  GetMem(OleStrList, SizeOf(TOleStrList));
  GetMem(DescList, SizeOf(TElemDescList));
  try
    FillChar(FuncDesc, SizeOf(FuncDesc), #0);
    FuncDesc.memid := ADispID;
    FuncDesc.lprgscode := nil;
    if Length(AParams) > 0 then
    begin
      for i := Low(AParams) to High(AParams) do
      begin
        DescList^[i].tdesc.vt := AParams[i].ParamDeclaration;
        GetMem(DescList^[i].tdesc.ptdesc, SizeOf(TTypeDesc));
        DescList^[i].tdesc.ptdesc^.vt := AParams[i].ParamType;
        DescList^[i].idldesc.wIDLFlags := AParams[i].Modifier;
      end;
      FuncDesc.lprgelemdescParam := DescList;
    end
    else
      FuncDesc.lprgelemdescParam := nil;

    FuncDesc.funckind := FuncKind[ACallType];
    FuncDesc.invkind := InvokeKind[AFuncType];
    FuncDesc.callconv := CC_STDCALL;
    FuncDesc.cParams := Length(AParams);
    FuncDesc.cParamsOpt := 0;
    FuncDesc.oVft := 0;
    FuncDesc.cScodes := 0;
    FuncDesc.elemdescFunc.tdesc.vt := AResultType;
    FuncDesc.wFuncFlags := 0;
    TypeInfo.AddFuncDesc(AIndex, FuncDesc);
    OleStrList^[0] := StringToOLEStr(AName);
    if Length(AParams) > 0 then
      for i := Low(AParams) to High(AParams) do
        OleStrList^[i + 1] := StringToOLEStr(AParams[i].ParamName);
    TypeInfo.SetFuncAndParamNames(AIndex, OleStrList, 1 + FuncDesc.cParams);
  finally
    for i := Low(AParams) to High(AParams) do
      FreeMem(DescList^[i].tdesc.ptdesc);
    FreeMem(DescList);
    FreeMem(OleStrList);
  end;
end;

procedure AddTypeLibProperty(const TypeInfo: ICreateTypeInfo; AName: string;
  ADispID: Integer; var AIndex: Integer; const AParams: TParamTypes;
  InvokeKind: Integer; FuncFlag: Integer);
var
  FuncDesc: TFuncDesc;
  OleStrList: POleStrList;
  DescList: PElemDescList;
begin
  GetMem(OleStrList, SizeOf(TOleStrList));
  GetMem(DescList, SizeOf(TElemDescList));
  try
    FillChar(DescList^, SizeOf(TElemDescList), #0);
    FillChar(FuncDesc, SizeOf(FuncDesc), #0);
    FuncDesc.memid := ADispID;
    FuncDesc.lprgscode := nil;
    if InvokeKind = INVOKE_PROPERTYGET then
    begin
      DescList^[0].tdesc.vt := AParams[0].ParamDeclaration;
      GetMem(DescList^[0].tdesc.ptdesc, SizeOf(TTypeDesc));
      DescList^[0].tdesc.ptdesc^.vt := AParams[0].ParamType;
      if AParams[0].ParamType = VT_USERDEFINED then
        DescList^[0].tdesc.ptdesc^.hreftype := AParams[0].HRefType;
    end
    else
    begin
      DescList^[0].tdesc.vt := AParams[0].ParamType;
      if AParams[0].ParamType = VT_USERDEFINED then
        DescList^[0].tdesc.hreftype := AParams[0].HRefType;
    end;
    DescList^[0].idldesc.wIDLFlags := AParams[0].Modifier;
    FuncDesc.lprgelemdescParam := DescList;
    FuncDesc.funckind := FUNC_PUREVIRTUAL;
    FuncDesc.invkind := InvokeKind;
    FuncDesc.callconv := CC_STDCALL;
    FuncDesc.cParams := 1;
    FuncDesc.elemdescFunc.tdesc.vt := VT_HRESULT;
    FuncDesc.wFuncFlags := FuncFlag;
    TypeInfo.AddFuncDesc(AIndex, FuncDesc);
    OleStrList^[0] := StringToOleStr(AName);
    if FuncDesc.invkind = INVOKE_PROPERTYGET then
    begin
      OleStrList[1] := StringToOleStr(AParams[0].ParamName);
      TypeInfo.SetFuncAndParamNames(AIndex, OleStrList, 1 + FuncDesc.cParams)
    end
    else
      TypeInfo.SetFuncAndParamNames(AIndex, OleStrList, 1);
    Inc(AIndex);
  finally
    FreeMem(OleStrList);
    FreeMem(DescList);
  end;
end;

procedure AddEnum(const TypeInfo: ICreateTypeInfo; ANames: array of string);
var
  i: Integer;
  VarDesc: TVarDesc;
  Index: array of OleVariant;
begin
  FillChar(VarDesc, SizeOf(VarDesc), #0);
  VarDesc.varkind := VAR_CONST;
  VarDesc.elemdescVar.tdesc.vt := VT_UI4;
  SetLength(Index, Length(ANames));
  for i := 0 to Length(ANames) - 1 do
  begin
    Index[i] := i;
    VarDesc.memid := i;
    VarDesc.lpvarValue := @Index[i];
    TypeInfo.AddVarDesc(i, VarDesc);
    TypeInfo.SetVarName(i, StringToOLEStr(ANames[i]));
    TypeInfo.SetVarDocString(i, StringToOLEStr(ANames[i]));
  end;
  SetLength(Index, 0);
end;

procedure AddOptionsPage(INewTLB: ICreateTypeLib; PropPageName: string;
  FIID, FDIID, FCLSID: TGUID; ITypeInfoIDispatch, ITypeInfoEnum1,
  ITypeInfoEnum2: ITypeInfo);
var
  ITypeInfoINewIntf, ITypeInfoINewEventIntf: ITypeInfo;
  INewTypeInfo: ICreateTypeInfo;
  RefType, RefTypeEvent, rtiEnum2: Cardinal;
  {$IFNDEF ADX_VCL9}
  rtiEnum1: Cardinal;
  {$ENDIF}
  Params: TParamTypes;
  LocalIndex: Integer;
begin
  LocalIndex := 0;
  // Create interfaces
  INewTLB.CreateTypeInfo(StringToOLEStr('I' + PropPageName), TKIND_INTERFACE, INewTypeInfo);
  INewTypeInfo.SetDocString(StringToOLEStr('Dispatch interface for ' + PropPageName + ' Control'));
  INewTypeInfo.SetGuid(FIID);
  INewTypeInfo.SetVersion(1, 0);
  INewTypeInfo.SetTypeFlags(TYPEFLAG_FDUAL or TYPEFLAG_FOLEAUTOMATION);
  INewTypeInfo.QueryInterface(ITypeInfo, ITypeInfoINewIntf);
  INewTypeInfo.AddRefTypeInfo(ITypeInfoIDispatch, RefType);
  INewTypeInfo.AddImplType(0, RefType);

  // property Visible: WordBool dispid 1; Hidden
  SetLength(Params, 1);
  with Params[0] do
  begin
    ParamName := 'Value';
    ParamType := VT_BOOL;
    ParamDeclaration := VT_PTR;
    Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
    HRefType := 0;
  end;
  AddTypeLibProperty(INewTypeInfo, 'Visible', 1, LocalIndex, Params,
    INVOKE_PROPERTYGET, FUNCFLAG_FHIDDEN);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'Visible', 1, LocalIndex, Params,
    INVOKE_PROPERTYPUT, FUNCFLAG_FHIDDEN);

  // property AutoScroll: WordBool dispid 2;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'AutoScroll', 2, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'AutoScroll', 2, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);

  // property AutoSize: WordBool dispid 3;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'AutoSize', 3, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'AutoSize', 3, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);

  {$IFNDEF ADX_VCL9}
  // property AxBorderStyle: TxActiveFormBorderStyle dispid 4;
  INewTypeInfo.AddRefTypeInfo(ITypeInfoEnum1, rtiEnum1);
  ITypeInfoEnum1 := nil;
  with Params[0] do
  begin
    ParamName := 'Value';
    ParamType := VT_USERDEFINED;
    ParamDeclaration := VT_PTR;
    Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
    HRefType := rtiEnum1;
  end;
  AddTypeLibProperty(INewTypeInfo, 'AxBorderStyle', 4, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'AxBorderStyle', 4, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);
  {$ENDIF}

  // property Caption: WideString dispid -518;
  with Params[0] do
  begin
    ParamName := 'Value';
    ParamType := VT_BSTR;
    ParamDeclaration := VT_PTR;
    Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
    HRefType := 0;
  end;
  AddTypeLibProperty(INewTypeInfo, 'Caption', -518, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'Caption', -518, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);

  // property Color: Integer dispid 5;
  Params[0].ParamType := VT_I4;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'Color', 5, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'Color', 5, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);

  // property KeyPreview: WordBool dispid 6;
  Params[0].ParamType := VT_BOOL;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'KeyPreview', 6, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'KeyPreview', 6, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);

  // property PixelsPerInch: Integer dispid 7;
  Params[0].ParamType := VT_I4;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'PixelsPerInch', 7, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'PixelsPerInch', 7, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);

  // property PrintScale: TxPrintScale dispid 8;
  INewTypeInfo.AddRefTypeInfo(ITypeInfoEnum2, rtiEnum2);
  ITypeInfoEnum2 := nil;
  Params[0].ParamType := VT_USERDEFINED;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  Params[0].HReftype := rtiEnum2;
  AddTypeLibProperty(INewTypeInfo, 'PrintScale', 8, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'PrintScale', 8, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);

  // property Scaled: WordBool dispid 9;
  Params[0].ParamType := VT_BOOL;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  Params[0].HReftype := 0;
  AddTypeLibProperty(INewTypeInfo, 'Scaled', 9, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'Scaled', 9, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);

  // property Active: WordBool readonly dispid 10; Hidden;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'Active', 10, LocalIndex, Params,
    INVOKE_PROPERTYGET, FUNCFLAG_FHIDDEN);

  // property DropTarget: WordBool dispid 11; Hidden;
  AddTypeLibProperty(INewTypeInfo, 'DropTarget', 11, LocalIndex, Params,
    INVOKE_PROPERTYGET, FUNCFLAG_FHIDDEN);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'DropTarget', 11, LocalIndex, Params,
    INVOKE_PROPERTYPUT, FUNCFLAG_FHIDDEN);

  // property HelpFile: WideString dispid 12; Hidden;
  Params[0].ParamType := VT_BSTR;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'HelpFile', 12, LocalIndex, Params,
    INVOKE_PROPERTYGET, FUNCFLAG_FHIDDEN);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'HelpFile', 12, LocalIndex, Params,
    INVOKE_PROPERTYPUT, FUNCFLAG_FHIDDEN);

  // property DoubleBuffered: WordBool dispid 13; Hidden;
  Params[0].ParamType := VT_BOOL;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'DoubleBuffered', 13, LocalIndex, Params,
    INVOKE_PROPERTYGET, FUNCFLAG_FHIDDEN);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'DoubleBuffered', 13, LocalIndex, Params,
    INVOKE_PROPERTYPUT, FUNCFLAG_FHIDDEN);

  // property VisibleDockClientCount: Integer readonly dispid 14; Hidden;
  Params[0].ParamType := VT_I4;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'VisibleDockClientCount', 14, LocalIndex, Params,
    INVOKE_PROPERTYGET, FUNCFLAG_FHIDDEN);

  // property Enabled: WordBool dispid -514; Hidden;
  Params[0].ParamType := VT_BOOL;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'Enabled', -514, LocalIndex, Params,
    INVOKE_PROPERTYGET, FUNCFLAG_FHIDDEN);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'Enabled', -514, LocalIndex, Params,
    INVOKE_PROPERTYPUT, FUNCFLAG_FHIDDEN);

  // property Cursor: Smallint dispid 15;
  Params[0].ParamType := VT_I2;
  Params[0].Modifier := IDLFLAG_FOUT or IDLFLAG_FRETVAL;
  AddTypeLibProperty(INewTypeInfo, 'Cursor', 15, LocalIndex, Params,
    INVOKE_PROPERTYGET, 0);
  Params[0].Modifier := IDLFLAG_FIN;
  AddTypeLibProperty(INewTypeInfo, 'Cursor', 15, LocalIndex, Params,
    INVOKE_PROPERTYPUT, 0);
  SetLength(Params, 0);
  INewTypeInfo.LayOut;
  INewTypeInfo := nil;
  // Events
  INewTLB.CreateTypeInfo(StringToOLEStr('I' + PropPageName + 'Events'), TKIND_DISPATCH, INewTypeInfo);
  INewTypeInfo.SetDocString(StringToOLEStr('Events interface for ' + PropPageName + ' Control'));
  INewTypeInfo.SetGuid(FDIID);
  INewTypeInfo.SetVersion(1, 0);
  INewTypeInfo.QueryInterface(ITypeInfo, ITypeInfoINewEventIntf);
  INewTypeInfo.AddRefTypeInfo(ITypeInfoIDispatch, RefTypeEvent);
  INewTypeInfo.AddImplType(0, RefTypeEvent);

  AddTypeLibFunction(INewTypeInfo, 'OnActivate', 1, 0, Params);
  AddTypeLibFunction(INewTypeInfo, 'OnClick', 2, 1, Params);
  AddTypeLibFunction(INewTypeInfo, 'OnCreate', 3, 2, Params);
  AddTypeLibFunction(INewTypeInfo, 'OnDblClick', 5, 3, Params);
  AddTypeLibFunction(INewTypeInfo, 'OnDestroy', 6, 4, Params);
  AddTypeLibFunction(INewTypeInfo, 'OnDeactivate', 7, 5, Params);
  SetLength(Params, 1);
  with Params[0] do begin
    ParamName := 'Key';
    ParamType := VT_I2;
    ParamDeclaration := VT_PTR;
    Modifier := IDLFLAG_FIN or IDLFLAG_FOUT;
  end;
  AddTypeLibFunction(INewTypeInfo, 'OnKeyPress', 11, 6, Params);
  SetLength(Params, 0);
  AddTypeLibFunction(INewTypeInfo, 'OnPaint', 16, 7, Params);
  INewTypeInfo.LayOut;
  INewTypeInfo := nil;
  // CoClass
  INewTLB.CreateTypeInfo(StringToOLEStr(PropPageName), TKIND_COCLASS, INewTypeInfo);
  INewTypeInfo.SetDocString(StringToOLEStr(PropPageName + ' Control'));
  INewTypeInfo.SetGuid(FCLSID);
  INewTypeInfo.SetVersion(1, 0);
  INewTypeInfo.SetTypeFlags(TYPEFLAG_FCANCREATE or TYPEFLAG_FCONTROL);
  INewTypeInfo.AddRefTypeInfo(ITypeInfoINewIntf, RefType);
  INewTypeInfo.AddImplType(0, RefType);
  INewTypeInfo.SetImplTypeFlags(0, IMPLTYPEFLAG_FDEFAULT);

  INewTypeInfo.AddRefTypeInfo(ITypeInfoINewEventIntf, RefTypeEvent);
  INewTypeInfo.AddImplType(1, RefTypeEvent);
  INewTypeInfo.SetImplTypeFlags(1, IMPLTYPEFLAG_FDEFAULT or IMPLTYPEFLAG_FSOURCE);
  INewTypeInfo.LayOut;
end;

{$IFNDEF DELPHI_12_UP}
procedure TadxWMainForm.CreateTypeLibrary;

  function StrToOLE(const S: string): PWideChar;
  begin
    Result := StringToOLEStr(S);
  end;

const
  StdOLELIBID: TGUID = '{00020430-0000-0000-C000-000000000046}';

var
  i: Integer;
  IStdOLETLB: ITypeLib;
  ITypeInfoIDispatch: ITypeInfo;
  ITypeInfoINewIntf: ITypeInfo;
  ITypeInfoEnum1, ITypeInfoEnum2: ITypeInfo;
  INewTLB: ICreateTypeLib2;
  INewTypeInfo: ICreateTypeInfo;
  RefType: Cardinal;
  TempGUID: TGUID;
  UniquePages: TPropPages;
begin
  // Get IDispatch type info
  LoadRegTypeLib(StdOLELIBID, 2, 0, 0, IStdOLETLB);
  IStdOLETLB.GetTypeInfoOfGuid(IDispatch, ITypeInfoIDispatch);
  IStdOLETLB := nil;
  // Create TLB
  // "SLTG" -> "MSFT"
  CreateTypeLib2(SYS_WIN32, StrToOLE(DestinationFolder + ProjectName + '.tlb'), INewTLB);
  INewTLB.SetGUID(FLIBID);
  INewTLB.SetDocString(StrToOLE(ProjectName + ' Library'));
  INewTLB.SetLCID(0);
  INewTLB.SetName(StrToOLE(ProjectName));
  INewTLB.SetVersion(1, 0);
  if FDestApp = daSmartTag then begin
    // Create interface Recognizer
    INewTLB.CreateTypeInfo(StrToOLE('I' + AddInCoClassName + 'Recognizer'), TKIND_INTERFACE, INewTypeInfo);
    INewTypeInfo.SetDocString(StrToOLE('Dispatch interface for ' + AddInCoClassName + 'Recognizer Object'));
    INewTypeInfo.SetGuid(FIID);
    INewTypeInfo.SetVersion(1, 0);
    INewTypeInfo.SetTypeFlags(TYPEFLAG_FDUAL or TYPEFLAG_FOLEAUTOMATION);
    INewTypeInfo.QueryInterface(ITypeInfo, ITypeInfoINewIntf);
    INewTypeInfo.AddRefTypeInfo(ITypeInfoIDispatch, RefType);
    INewTypeInfo.AddImplType(0, RefType);
    INewTypeInfo.LayOut;
    INewTypeInfo := nil;
    // Create CoClass
    INewTLB.CreateTypeInfo(StrToOLE(AddInCoClassName + 'Recognizer'), TKIND_COCLASS, INewTypeInfo);
    INewTypeInfo.SetDocString(StringToOLEStr(AddInCoClassName + 'Recognizer Object'));
    INewTypeInfo.SetGuid(FCLSID);
    INewTypeInfo.SetVersion(1, 0);
    INewTypeInfo.SetTypeFlags(TYPEFLAG_FCANCREATE);
    INewTypeInfo.AddRefTypeInfo(ITypeInfoINewIntf, RefType);
    INewTypeInfo.AddImplType(0, RefType);
    INewTypeInfo.SetImplTypeFlags(0, IMPLTYPEFLAG_FDEFAULT);
    INewTypeInfo.LayOut;

    // Create interface Action
    INewTLB.CreateTypeInfo(StrToOLE('I' + AddInCoClassName + 'Action'), TKIND_INTERFACE, INewTypeInfo);
    INewTypeInfo.SetDocString(StrToOLE('Dispatch interface for ' + AddInCoClassName + 'Action Object'));
    INewTypeInfo.SetGuid(FIID2);
    INewTypeInfo.SetVersion(1, 0);
    INewTypeInfo.SetTypeFlags(TYPEFLAG_FDUAL or TYPEFLAG_FOLEAUTOMATION);
    INewTypeInfo.QueryInterface(ITypeInfo, ITypeInfoINewIntf);
    INewTypeInfo.AddRefTypeInfo(ITypeInfoIDispatch, RefType);
    INewTypeInfo.AddImplType(0, RefType);
    INewTypeInfo.LayOut;
    INewTypeInfo := nil;
    // Create CoClass
    INewTLB.CreateTypeInfo(StrToOLE(AddInCoClassName + 'Action'), TKIND_COCLASS, INewTypeInfo);
    INewTypeInfo.SetDocString(StringToOLEStr(AddInCoClassName + 'Action Object'));
    INewTypeInfo.SetGuid(FCLSID2);
    INewTypeInfo.SetVersion(1, 0);
    INewTypeInfo.SetTypeFlags(TYPEFLAG_FCANCREATE);
    INewTypeInfo.AddRefTypeInfo(ITypeInfoINewIntf, RefType);
    INewTypeInfo.AddImplType(0, RefType);
    INewTypeInfo.SetImplTypeFlags(0, IMPLTYPEFLAG_FDEFAULT);
    INewTypeInfo.LayOut;
  end else begin
    // Create interfaces
    INewTLB.CreateTypeInfo(StrToOLE('I' + AddInCoClassName), TKIND_INTERFACE, INewTypeInfo);
    INewTypeInfo.SetDocString(StrToOLE('Dispatch interface for ' + AddInCoClassName + ' Object'));
    INewTypeInfo.SetGuid(FIID);
    INewTypeInfo.SetVersion(1, 0);
    INewTypeInfo.SetTypeFlags(TYPEFLAG_FDUAL or TYPEFLAG_FOLEAUTOMATION);
    INewTypeInfo.QueryInterface(ITypeInfo, ITypeInfoINewIntf);
    INewTypeInfo.AddRefTypeInfo(ITypeInfoIDispatch, RefType);
    INewTypeInfo.AddImplType(0, RefType);
    INewTypeInfo.LayOut;
    INewTypeInfo := nil;
    // Create CoClass
    INewTLB.CreateTypeInfo(StrToOLE(AddInCoClassName), TKIND_COCLASS, INewTypeInfo);
    INewTypeInfo.SetDocString(StringToOLEStr(AddInCoClassName + ' Object'));
    INewTypeInfo.SetGuid(FCLSID);
    INewTypeInfo.SetVersion(1, 0);
    INewTypeInfo.SetTypeFlags(TYPEFLAG_FCANCREATE);
    INewTypeInfo.AddRefTypeInfo(ITypeInfoINewIntf, RefType);
    INewTypeInfo.AddImplType(0, RefType);
    INewTypeInfo.SetImplTypeFlags(0, IMPLTYPEFLAG_FDEFAULT);
    INewTypeInfo.LayOut;
  end;
  if (FDestApp = daOutlook) and (PropPages.Count > 0) then begin
    UniquePages := TPropPages.Create(False);
    for i := 0 to PropPages.Count - 1 do
      if not UniquePages.FindCoClassName(PropPages[i].CoClassName) then
        UniquePages.Add(PropPages[i]);
    // Add Control Flag
    INewTLB.SetLibFlags(LIBFLAG_FCONTROL);

    // Create TxActiveFormBorderStyle
    INewTLB.CreateTypeInfo(StrToOLE('TxActiveFormBorderStyle'), TKIND_ENUM, INewTypeInfo);
    CoCreateGUID(TempGUID);
    INewTypeInfo.SetGuid(TempGUID);
    INewTypeInfo.SetVersion(1, 0);
    AddEnum(INewTypeInfo, ['afbNone', 'afbSingle', 'afbSunken', 'afbRaised']);
    INewTypeInfo.QueryInterface(ITypeInfo, ITypeInfoEnum1);
    INewTypeInfo.LayOut;

    // Create TxPrintScale
    INewTLB.CreateTypeInfo(StrToOLE('TxPrintScale'), TKIND_ENUM, INewTypeInfo);
    CoCreateGUID(TempGUID);
    INewTypeInfo.SetGuid(TempGUID);
    INewTypeInfo.SetVersion(1, 0);
    AddEnum(INewTypeInfo, ['poNone', 'poProportional', 'poPrintToFit']);
    INewTypeInfo.QueryInterface(ITypeInfo, ITypeInfoEnum2);
    INewTypeInfo.LayOut;

    // Create TxMouseButton
    INewTLB.CreateTypeInfo(StrToOLE('TxMouseButton'), TKIND_ENUM, INewTypeInfo);
    CoCreateGUID(TempGUID);
    INewTypeInfo.SetGuid(TempGUID);
    INewTypeInfo.SetVersion(1, 0);
    AddEnum(INewTypeInfo, ['mbLeft', 'mbRight', 'mbMiddle']);
    INewTypeInfo.LayOut;

    if UniquePages.OptionPageExist then
      for i := 0 to UniquePages.Count - 1 do
        if UniquePages[i].IsOptionPage then
          AddOptionsPage(INewTLB, UniquePages[i].CoClassName,
            UniquePages[i].IID, UniquePages[i].DIID, UniquePages[i].CLSID,
            ITypeInfoIDispatch, ITypeInfoEnum1, ITypeInfoEnum2);
    if UniquePages.FolderPageExist then
      for i := 0 to UniquePages.Count - 1 do
        if not UniquePages[i].IsOptionPage then
          AddOptionsPage(INewTLB, UniquePages[i].CoClassName,
            UniquePages[i].IID, UniquePages[i].DIID, UniquePages[i].CLSID,
            ITypeInfoIDispatch, ITypeInfoEnum1, ITypeInfoEnum2);
    UniquePages.Free;
  end;
  // TaskPanes
  if (TaskPanes.Count > 0) then begin
    if PropPages.Count = 0 then begin
      // Add Control Flag
      INewTLB.SetLibFlags(LIBFLAG_FCONTROL);
      // Create TxActiveFormBorderStyle
      INewTLB.CreateTypeInfo(StrToOLE('TxActiveFormBorderStyle'), TKIND_ENUM, INewTypeInfo);
      CoCreateGUID(TempGUID);
      INewTypeInfo.SetGuid(TempGUID);
      INewTypeInfo.SetVersion(1, 0);
      AddEnum(INewTypeInfo, ['afbNone', 'afbSingle', 'afbSunken', 'afbRaised']);
      INewTypeInfo.QueryInterface(ITypeInfo, ITypeInfoEnum1);
      INewTypeInfo.LayOut;
      // Create TxPrintScale
      INewTLB.CreateTypeInfo(StrToOLE('TxPrintScale'), TKIND_ENUM, INewTypeInfo);
      CoCreateGUID(TempGUID);
      INewTypeInfo.SetGuid(TempGUID);
      INewTypeInfo.SetVersion(1, 0);
      AddEnum(INewTypeInfo, ['poNone', 'poProportional', 'poPrintToFit']);
      INewTypeInfo.QueryInterface(ITypeInfo, ITypeInfoEnum2);
      INewTypeInfo.LayOut;
      // Create TxMouseButton
      INewTLB.CreateTypeInfo(StrToOLE('TxMouseButton'), TKIND_ENUM, INewTypeInfo);
      CoCreateGUID(TempGUID);
      INewTypeInfo.SetGuid(TempGUID);
      INewTypeInfo.SetVersion(1, 0);
      AddEnum(INewTypeInfo, ['mbLeft', 'mbRight', 'mbMiddle']);
      INewTypeInfo.LayOut;
    end;
    for i := 0 to TaskPanes.Count - 1 do
      AddOptionsPage(INewTLB, TaskPanes[i].CoClassName,
        TaskPanes[i].IID, TaskPanes[i].DIID, TaskPanes[i].CLSID,
        ITypeInfoIDispatch, ITypeInfoEnum1, ITypeInfoEnum2);
  end;
  // Save tlb
  INewTLB.SaveAllChanges;
end;
{$ENDIF}

end.

