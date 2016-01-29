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

unit adxWClasses;

{$I adxDefs.inc}

interface

procedure Register;
procedure CopyRedistributables(PathTo: string);

implementation

{$R adxWizard.res}


uses Windows, SysUtils, Controls, Dialogs, Classes,
  ToolsAPI, {$IFNDEF ADX_VCL14} ExptIntf, ToolIntf, {$ENDIF} EditIntf, TypInfo,
  {$IFDEF ADX_TRIAL}
  Forms, uProtection,
  {$ENDIF}
  adxWForm;

type
  TadxCustomExpert = class(TNotifierObject, IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard)
  public
    { IOTAWizard }
    function GetIDString: string; virtual;
    function GetName: string; virtual;
    function GetState: TWizardState;
    procedure Execute; virtual;
    { IOTARepositoryWizard }
    function GetAuthor: string;
    function GetComment: string; virtual;
    function GetPage: string;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; virtual;
    {$ELSE}
    function GetGlyph: Cardinal; virtual;
    {$ENDIF}
  end;

  { TadxRTDExpert }
  TadxRTDExpert = class(TadxCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;

  { TadxOfficeExpert }
  TadxOfficeExpert = class(TadxCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;

  { TadxOutlookExpert }
  TadxOutlookExpert = class(TadxCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;

  { TadxSmartTagExpert }
  TadxSmartTagExpert = class(TadxCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;

  { TadxExcelSheetExpert }
  TadxExcelSheetExpert = class(TadxCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;

  { TadxWordDocumentExpert }
  TadxWordDocumentExpert = class(TadxCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;

{$IFDEF ADX_TRIAL}
{$I Trial2.inc}
{$ENDIF}

{ TadxCustomExpert }

function TadxCustomExpert.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

function TadxCustomExpert.GetAuthor: string;
begin
  Result := 'Add-in Express Ltd. (www.add-in-express.com)';
end;

function TadxCustomExpert.GetPage: string;
begin
  Result := 'Add-in Express VCL';
end;

function TadxCustomExpert.GetIDString: string;
begin
  Result := '';
end;

function TadxCustomExpert.GetName: string;
begin
  Result := '';
end;

procedure TadxCustomExpert.Execute;
begin
end;

function TadxCustomExpert.GetComment: string;
begin
  Result := '';
end;

{$IFDEF ADX_VCL5}
function TadxCustomExpert.GetGlyph: HICON;
{$ELSE}
function TadxCustomExpert.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := 0;
end;

{ TadxRTDExpert }

function TadxRTDExpert.GetName: string;
begin
  Result := 'ADX Excel RTD Server';
end;

function TadxRTDExpert.GetComment: string;
begin
  Result := 'Creates a RealTimeData Server for MS Excel 2002 and higher';
end;

{$IFDEF ADX_VCL5}
function TadxRTDExpert.GetGlyph: HICON;
{$ELSE}
function TadxRTDExpert.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADXRTDICON');
end;

function TadxRTDExpert.GetIDString: string;
begin
  Result := 'AddinExpress.ADX.20.1';
end;

procedure TadxRTDExpert.Execute;
begin
  {$IFDEF ADX_TRIAL}
  {$I Trial3.inc}
  {$ENDIF}
  adxWMainForm := TadxWMainForm.Create(daRTD);
  try
    if adxWMainForm.ShowModal = mrOk then begin
      {$IFDEF DELPHI_9_UP}
        {$IFDEF DELPHI_11_UP}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dproj', True);
        {$ELSE}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.bdsproj', True);
        {$ENDIF}
      (BorlandIDEServices as IOTAActionServices).OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      {$ELSE}
      ToolServices.OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dpr');
      ToolServices.OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      ToolServices.SaveProject;
      {$ENDIF}
    end;
  finally
    adxWMainForm.Free;
  end;
end;

{ TadxOfficeExpert }

function TadxOfficeExpert.GetName: string;
begin
  Result := 'ADX COM Add-in';
end;

function TadxOfficeExpert.GetComment: string;
begin
  Result := 'Creates a COM add-in for MS Office';
end;

{$IFDEF ADX_VCL5}
function TadxOfficeExpert.GetGlyph: HICON;
{$ELSE}
function TadxOfficeExpert.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADXOFFICEICON');
end;

function TadxOfficeExpert.GetIDString: string;
begin
  Result := 'AddinExpress.ADX.20.2';
end;

procedure TadxOfficeExpert.Execute;
begin
  {$IFDEF ADX_TRIAL}
  {$I Trial3.inc}
  {$ENDIF}

  adxWMainForm := TadxWMainForm.Create(daOffice);
  try
    if adxWMainForm.ShowModal = mrOk then begin
      {$IFDEF DELPHI_9_UP}
        {$IFDEF DELPHI_11_UP}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dproj', True);
        {$ELSE}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.bdsproj', True);
        {$ENDIF}
        (BorlandIDEServices as IOTAActionServices).OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      {$ELSE}
      ToolServices.OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dpr');
      ToolServices.OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      ToolServices.SaveProject;
      {$ENDIF}
      CopyRedistributables(adxWMainForm.DestinationFolder);
    end;
  finally
    adxWMainForm.Free;
  end;
end;

{ TadxOutlookExpert }

function TadxOutlookExpert.GetName: string;
begin
  Result := 'ADX Outlook Add-in';
end;

function TadxOutlookExpert.GetComment: string;
begin
  Result := 'Creates a COM add-in for MS Outlook';
end;

{$IFDEF ADX_VCL5}
function TadxOutlookExpert.GetGlyph: HICON;
{$ELSE}
function TadxOutlookExpert.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADXOUTLOOKICON');
end;

function TadxOutlookExpert.GetIDString: string;
begin
  Result := 'AddinExpress.ADX.20.3';
end;

procedure TadxOutlookExpert.Execute;
var
  i: Integer;
  AllPages, UniquePages: TPropPages;
begin
  {$IFDEF ADX_TRIAL}
  {$I Trial3.inc}
  {$ENDIF}
  adxWMainForm := TadxWMainForm.Create(daOutlook);
  try
    if adxWMainForm.ShowModal = mrOk then begin
      {$IFDEF DELPHI_9_UP}
        {$IFDEF DELPHI_11_UP}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dproj', True);
        {$ELSE}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.bdsproj', True);
        {$ENDIF}
        (BorlandIDEServices as IOTAActionServices).OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      {$ELSE}
        ToolServices.OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dpr');
        ToolServices.OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
        ToolServices.SaveProject;
      {$ENDIF}
      AllPages := TPropPages(adxWMainForm.PropPages);
      if AllPages.Count > 0 then begin
        UniquePages := TPropPages.Create(False);
        for i := 0 to AllPages.Count - 1 do
          if not UniquePages.FindCoClassName(AllPages[i].CoClassName) then
            UniquePages.Add(AllPages[i]);
        for i := 0 to UniquePages.Count - 1 do
          {$IFDEF DELPHI_9_UP}
          (BorlandIDEServices as IOTAActionServices).OpenFile(adxWMainForm.DestinationFolder + UniquePages[i].CoClassName + '.pas');          {$ELSE}
          ToolServices.OpenFile(adxWMainForm.DestinationFolder + UniquePages[i].CoClassName + '.pas');
          {$ENDIF}
        UniquePages.Free;
      end;
      CopyRedistributables(adxWMainForm.DestinationFolder);
    end;
  finally
    adxWMainForm.Free;
  end;
end;

{ TadxSmartTagExpert }

function TadxSmartTagExpert.GetName: string;
begin
  Result := 'ADX Smart Tag';
end;

function TadxSmartTagExpert.GetComment: string;
begin
  Result := 'Creates a Smart Tag Library for MS Office';
end;

{$IFDEF ADX_VCL5}
function TadxSmartTagExpert.GetGlyph: HICON;
{$ELSE}
function TadxSmartTagExpert.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADXSTICON');
end;

function TadxSmartTagExpert.GetIDString: string;
begin
  Result := 'AddinExpress.ADX.20.5';
end;

procedure TadxSmartTagExpert.Execute;
begin
  {$IFDEF ADX_TRIAL}
  {$I Trial3.inc}
  {$ENDIF}
  adxWMainForm := TadxWMainForm.Create(daSmartTag);
  try
    if adxWMainForm.ShowModal = mrOk then begin
      {$IFDEF DELPHI_9_UP}
        {$IFDEF DELPHI_11_UP}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dproj', True);
        {$ELSE}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.bdsproj', True);
        {$ENDIF}
        (BorlandIDEServices as IOTAActionServices).OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      {$ELSE}
      ToolServices.OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dpr');
      ToolServices.OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      ToolServices.SaveProject;
      {$ENDIF}
    end;
  finally
    adxWMainForm.Free;
  end;
end;

{ TadxExcelSheetExpert }

function TadxExcelSheetExpert.GetName: string;
begin
  Result := 'ADX Excel Worksheet';
end;

function TadxExcelSheetExpert.GetComment: string;
begin
  Result := 'Creates a COM add-in for MS Excel with the support of MS Forms Controls';
end;

{$IFDEF ADX_VCL5}
function TadxExcelSheetExpert.GetGlyph: HICON;
{$ELSE}
function TadxExcelSheetExpert.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_XL_SHEET_ICON');
end;

function TadxExcelSheetExpert.GetIDString: string;
begin
  Result := 'AddinExpress.ADX.20.6';
end;

procedure TadxExcelSheetExpert.Execute;
begin
  {$IFDEF ADX_TRIAL}
  {$I Trial3.inc}
  {$ENDIF}
  adxWMainForm := TadxWMainForm.Create(daOffice_XL);
  try
    if adxWMainForm.ShowModal = mrOk then begin
      {$IFDEF DELPHI_9_UP}
        {$IFDEF DELPHI_11_UP}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dproj', True);
        {$ELSE}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.bdsproj', True);
        {$ENDIF}
        (BorlandIDEServices as IOTAActionServices).OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      {$ELSE}
      ToolServices.OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dpr');
      ToolServices.OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      ToolServices.SaveProject;
      {$ENDIF}
      CopyRedistributables(adxWMainForm.DestinationFolder);
    end;
  finally
    adxWMainForm.Free;
  end;
end;

{ WordDocumentExpert }

function TadxWordDocumentExpert.GetName: string;
begin
  Result := 'ADX Word Document';
end;

function TadxWordDocumentExpert.GetComment: string;
begin
  Result := 'Creates a COM add-in for MS Word with the support of MS Forms Controls';
end;

{$IFDEF ADX_VCL5}
function TadxWordDocumentExpert.GetGlyph: HICON;
{$ELSE}
function TadxWordDocumentExpert.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_WD_DOC_ICON');
end;

function TadxWordDocumentExpert.GetIDString: string;
begin
  Result := 'AddinExpress.ADX.20.7';
end;

procedure TadxWordDocumentExpert.Execute;
begin
  {$IFDEF ADX_TRIAL}
  {$I Trial3.inc}
  {$ENDIF}
  adxWMainForm := TadxWMainForm.Create(daOffice_WD);
  try
    if adxWMainForm.ShowModal = mrOk then begin
      {$IFDEF DELPHI_9_UP}
        {$IFDEF DELPHI_11_UP}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dproj', True);
        {$ELSE}
        (BorlandIDEServices as IOTAActionServices).OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.bdsproj', True);
        {$ENDIF}
        (BorlandIDEServices as IOTAActionServices).OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      {$ELSE}
      ToolServices.OpenProject(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '.dpr');
      ToolServices.OpenFile(adxWMainForm.DestinationFolder + adxWMainForm.ProjectName + '_IMPL.pas');
      ToolServices.SaveProject;
      {$ENDIF}
      CopyRedistributables(adxWMainForm.DestinationFolder);
    end;
  finally
    adxWMainForm.Free;
  end;
end;

procedure CopyRedistributables(PathTo: string);
var
  adxPath: string;
begin
  adxPath := GetRegistryValue(HKEY_LOCAL_MACHINE, 'Software\Add-in Express\InstalledProducts\Add-in Express 2010 for VCL', 'InstallDir');
  if adxPath <> '' then
  try
    CopyFile(PChar(adxPath + '\Redistributables\gdiplus.dll'), PChar(PathTo + 'gdiplus.dll'), true);
  except
  end;
end;

{ Register }

procedure Register;
begin
  RegisterPackageWizard(TadxRTDExpert.Create);
  RegisterPackageWizard(TadxOfficeExpert.Create);
  RegisterPackageWizard(TadxOutlookExpert.Create);
  RegisterPackageWizard(TadxSmartTagExpert.Create);
  RegisterPackageWizard(TadxExcelSheetExpert.Create);
  RegisterPackageWizard(TadxWordDocumentExpert.Create);
end;

{$IFDEF ADX_TRIAL}
{$I Trial1.inc}
{$ENDIF}

end.
