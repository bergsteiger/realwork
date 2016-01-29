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

unit adxWFrmClient1;

{$I adxDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
  adxWFrmClient, adxWDialogs, ExtCtrls;

type
  TfrmClient1 = class(TfrmClient)
    LabelProjectFolder: TLabel;
    edDst: TEdit;
    btnBrowse: TButton;
    LabelProjectName: TLabel;
    edProjectName: TEdit;
    LabelCoClassName: TLabel;
    edCoClass: TEdit;
    rgInstall: TRadioGroup;
    cbInnoSetup: TCheckBox;
    cbWiX: TCheckBox;
    procedure btnBrowseClick(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Check: boolean; override;
  end;

implementation

{$R *.DFM}

uses Registry, adxWForm;

{ TfrmClient1 }

constructor TfrmClient1.Create(AOwner: TComponent);
{$IFDEF DELPHI_10_UP}
  function GetRegistryValue(AHive: LongWord; AKey, AValueName: string): string;
  begin
    Result := '';
    with TRegistry.Create(KEY_READ) do
      try
        RootKey := AHive;
        if OpenKey(AKey, False) then begin
          if ValueExists(AValueName) then
            Result := ReadString(AValueName);
          CloseKey;
        end;
      finally
        Free;
      end;
  end;

var
  S: string;
{$ENDIF}
begin
  inherited Create(AOwner);
  // InnoSetup
  //with TRegistry.Create(KEY_READ) do
  //  try
  //    RootKey := HKEY_CURRENT_USER;
  //    if KeyExists('Software\Jordan Russell\Inno Setup') then begin
  //      cbInnoSetup.Enabled := True;
  //      cbInnoSetup.Checked := True;
  //    end;
  //  finally
  //    Free;
  //  end;
  cbInnoSetup.Enabled := True;
  // Windows Installer XML (WiX)
  //with TRegistry.Create(KEY_READ) do
  //  try
  //    RootKey := HKEY_CURRENT_USER;
  //    if KeyExists('Software\Windows Installer XML 3') then begin
  //      cbWiX.Enabled := True;
  //    end;
  //  finally
  //    Free;
  //  end;
  cbWiX.Enabled := True;

  edDst.Text :=
    StringReplace(MainForm.DestinationFolder, Self.MainForm.LongDelphiPath, Self.MainForm.ShortDelphiPath, [rfReplaceAll, rfIgnoreCase]);
  edProjectName.Text := MainForm.ProjectName;
  edCoClass.Text := MainForm.AddInCoClassName;
  rgInstall.ItemIndex := MainForm.RegisterUnder;
  cbInnoSetup.Checked := MainForm.IsInnoSetup;
  cbWix.Checked := MainForm.IsWiXSetup;

  if edDst.Text = '' then begin
    {$IFDEF DELPHI_9_UP}
    if Self.MainForm.ShortDelphiPath <> '' then
      edDst.Text := Self.MainForm.ShortDelphiPath + '\';
    {$IFDEF DELPHI_10_UP}
    S := GetRegistryValue(HKEY_CURRENT_USER, 'Software\Borland\BDS\4.0\Globals', 'DefaultProjectsDirectory');
    if (S <> '') and (S <> Self.MainForm.LongDelphiPath) then edDst.Text := S + '\';
    {$ENDIF ADX_VCL10}
    {$ELSE}
    if Self.MainForm.ShortDelphiPath <> '' then
      edDst.Text := Self.MainForm.ShortDelphiPath + '\Projects\';
    {$ENDIF}
  end;
  if MainForm.FDestApp = daRTD then begin
    lblTitle.Caption :=
      'Project name and destination directory';
    lblComment.Caption :=
      'You should name the RTD Server project. The "Project name" will be used to name '+
      'the project, the RTD Server implementation unit and the type library modules ' +
      '(for example MyRTDServer.dpr, MyRTDServer_IMPL.pas, MyRTDServer_TLB.pas and MyRTDServer.tlb).'#10#10 +
      'All project modules will be saved to the "Project folder" ' +
      'when the wizard is finished.';

    //edDst.Top := edProjectName.Top + edProjectName.Height + 25;
    //LabelProjectFolder.Top := edDst.Top + 2;
    //btnBrowse.Top := edDst.Top;
    //rgInstall.Height := 50;

    edCoClass.Top := edProjectName.Top + edProjectName.Height + 13;
    edCoClass.Visible := False;
    LabelCoClassName.Top := edCoClass.Top + 2;
    LabelCoClassName.Visible := False;

    cbInnoSetup.Top := rgInstall.Top + rgInstall.Height;
    cbInnoSetup.Visible := True;
    cbWix.Top := cbInnoSetup.Top + cbInnoSetup.Height;

    //edDst.Top := edCoClass.Top + edCoClass.Height + 17;
    edDst.Top := cbWix.Top + cbWix.Height;
    LabelProjectFolder.Top := edDst.Top + 2;
    btnBrowse.Top := edDst.Top;
  end
  else begin
    if MainForm.FDestApp = daSmartTag then begin
      lblTitle.Caption :=
        'Project name, coclass name and destination directory';
      lblComment.Caption :=
        'You should name the smart tag project. The "Project name" will be used to name '+
        'the project, the implementation unit and the type library modules ' +
        '(for example MySmartTag.dpr, MySmartTag_IMPL.pas, MySmartTag_TLB.pas and MySmartTag.tlb). ' +
        'The "CoClass name" will be used to name the interfaces and classes ' +
        'that implements your smart tag.' + #10#10 +
        'All project modules will be saved to the "Project folder" ' +
        'when the wizard is finished.';
    end
    else
    begin
      lblTitle.Caption :=
        'Project name, COM add-in coclass name and destination directory';
      lblComment.Caption :=
        'You should name the add-in project. The "Project name" will be used to name '+
        'the project, the add-in implementation unit and the type library modules ' +
        '(for example MyAddIn.dpr, MyAddIn_IMPL.pas, MyAddIn_TLB.pas and MyAddIn.tlb). ' +
        'The "CoClass name" will be used to name the add-in interfaces, and class ' +
        'that implements your add-in.' + #10#10 +
        'All add-in project modules will be saved to the "Project folder" ' +
        'when the wizard is finished.';
    end;
    edCoClass.Top := edProjectName.Top + edProjectName.Height + 13;
    edCoClass.Visible := True;
    LabelCoClassName.Top := edCoClass.Top + 2;
    LabelCoClassName.Visible := True;

    cbInnoSetup.Top := rgInstall.Top + rgInstall.Height;
    cbInnoSetup.Visible := True;
    cbWix.Top := cbInnoSetup.Top + cbInnoSetup.Height;

    edDst.Top := cbWix.Top + cbWix.Height;
    LabelProjectFolder.Top := edDst.Top + 2;
    btnBrowse.Top := edDst.Top;
  end;
end;

destructor TfrmClient1.Destroy;
begin
  MainForm.DestinationFolder :=
    StringReplace(edDst.Text, Self.MainForm.ShortDelphiPath, Self.MainForm.LongDelphiPath, [rfReplaceAll, rfIgnoreCase]);
  MainForm.ProjectName := StringReplace(edProjectName.Text, #32, '_', [rfReplaceAll]);
  MainForm.AddInCoClassName := StringReplace(edCoClass.Text, #32, '_', [rfReplaceAll]);
  MainForm.RegisterUnder := rgInstall.ItemIndex;
  MainForm.IsInnoSetup := cbInnoSetup.Enabled and cbInnoSetup.Checked;
  MainForm.IsWiXSetup := cbWiX.Enabled and cbWiX.Checked;
  inherited Destroy;
end;

procedure TfrmClient1.btnBrowseClick(Sender: TObject);
var
  FldDlg: TaxpwBrowseFolderDlg;
begin
  FldDlg := TaxpwBrowseFolderDlg.Create(Self);
  try
    if edDst.Text <> '' then
      FldDlg.Folder := StringReplace(edDst.Text, Self.MainForm.ShortDelphiPath, Self.MainForm.LongDelphiPath, [rfReplaceAll, rfIgnoreCase]);
    if FldDlg.Execute then
      edDst.Text := StringReplace(FldDlg.Folder, Self.MainForm.LongDelphiPath, Self.MainForm.ShortDelphiPath, [rfReplaceAll, rfIgnoreCase]);
  finally
    FldDlg.Free;
  end;
end;

function TfrmClient1.Check: boolean;
begin
  Result := True;
  if edProjectName.Text = '' then begin
    MessageDlg('You should define a name for the project.', mtError, [mbCancel], 0);
    Result := False;
  end;
  if Result and not IsValidIdent(edProjectName.Text) then begin
    MessageDlg('Project name is not valid. Use characters from the set ["A".."Z", "a".."z", "0".."9", "_"] only.', mtError, [mbCancel], 0);
    Result := False;
  end;
  if (MainForm.FDestApp in [daOffice, daOutlook, daOffice_XL, daOffice_WD]) and Result then
    if edCoClass.Text = '' then begin
      MessageDlg('You should define a coclass name.', mtError, [mbCancel], 0);
      Result := False;
    end
    else
      if UpperCase(edCoClass.Text) = UpperCase(edProjectName.Text) then begin
        MessageDlg('The coclass has the same name as the project. Please rename one of them.', mtError, [mbCancel], 0);
        Result := False;
      end
      else
        if UpperCase(edCoClass.Text) = 'ADDINMODULE' then begin
          MessageDlg('The AddInModule is a reserved word. Please rename coclass.', mtError, [mbCancel], 0);
          Result := False;
        end;
  if Result then
    if edDst.Text = '' then begin
      MessageDlg('You should define a folder to place the project.', mtError, [mbCancel], 0);
      Result := False;
    end
end;

end.
