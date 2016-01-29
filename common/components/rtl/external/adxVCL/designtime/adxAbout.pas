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

unit adxAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TfrmAbout = class(TForm)
    Image1: TImage;
    btnOK: TButton;
    Label7: TLabel;
    Label3: TLabel;
    lblVersion: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LabelPlugins: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    procedure CheckAddIns();
  public
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

uses adxAddIn, ShellAPI, Registry;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  with TRegistry.Create(KEY_READ) do begin
    try
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKeyReadOnly('Software\Add-in Express\InstalledProducts\Add-in Express 2010 for VCL') then begin
        if ValueExists('Version') then
          lblVersion.Caption := Format(lblVersion.Caption, [ReadString('Version')])
        else
          lblVersion.Caption := Format(lblVersion.Caption, [adxVersion]);
      end;
    finally
      Free;
    end;
  end;
  CheckAddIns();
end;

procedure TfrmAbout.CheckAddIns();
var
  i: Integer;
  AddIns: TStringList;
begin
  AddIns := TStringList.Create;
  with TRegistry.Create(KEY_READ) do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyReadOnly('Software\Add-in Express\InstalledProducts\Add-in Express 2010 for VCL\Plugins') then begin
      if HasSubKeys() then GetKeyNames(AddIns);
      CloseKey();
    end;
    if AddIns.Count > 0 then
      for i := 0 to AddIns.Count - 1 do
        if OpenKeyReadOnly('Software\Add-in Express\InstalledProducts\Add-in Express 2010 for VCL\Plugins\' + AddIns[i]) then begin
          if ValueExists('Version') then begin
            if LabelPlugins.Caption = '' then
              LabelPlugins.Caption := AddIns[i] + ' ' + ReadString('Version')
            else
              LabelPlugins.Caption := LabelPlugins.Caption + ', ' + AddIns[i] + ' ' + ReadString('Version');
          end;
          CloseKey();
        end;
    if LabelPlugins.Caption = '' then LabelPlugins.Caption := 'None';
  finally
    AddIns.Free;
    Free;
  end;
end;

end.
