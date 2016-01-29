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

unit adxWFrmClient3;

{$I adxDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  adxWFrmClient, StdCtrls, ExtCtrls;

type
  TfrmClient3 = class(TfrmClient)
    panRTD: TPanel;
    Label4: TLabel;
    edRTDCoClass: TEdit;
    Label5: TLabel;
    rbDLL: TRadioButton;
    rbStandalone: TRadioButton;
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Check: boolean; override;
  end;

implementation

uses adxWForm;

{$R *.DFM}

{ TfrmNames }

constructor TfrmClient3.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  edRTDCoClass.Text := MainForm.AddInCoClassName;
  ActiveControl := edRTDCoClass;
  if MainForm.RTDFormat = afStandalone then rbStandalone.Checked := True;
  lblTitle.Caption := 'CoClass Name and COM Server type';
  lblComment.Caption :=
    'You should specify a coclass name and COM Server type. ' +
    '' +
    'The "CoClass name" will be used to name the RTD Server interfaces, and class ' +
    'that implements your application.';
end;

destructor TfrmClient3.Destroy;
begin
  MainForm.AddInCoClassName := StringReplace(edRTDCoClass.Text, #32, '_', [rfReplaceAll]);
  if rbDLL.Checked then
    MainForm.RTDFormat := afDLL
  else begin
    MainForm.RTDFormat := afStandalone;
    MainForm.RegisterUnder := 0;
  end;
  inherited Destroy;
end;

function TfrmClient3.Check: boolean;
begin
  Result := True;
  if edRTDCoClass.Text = '' then begin
    MessageDlg('You should define a coclass name.', mtError, [mbCancel], 0);
    Result := False;
  end;
  if Result then
    if UpperCase(edRTDCoClass.Text) = UpperCase(MainForm.ProjectName) then begin
      MessageDlg('The coclass has the same name as the project. Please rename one of them.', mtError, [mbCancel], 0);
      Result := False;
    end;
  if Result then
    if UpperCase(edRTDCoClass.Text) = 'RTDSERVERMODULE' then begin
      MessageDlg('The RTDServerModule is a reserved word. Please rename coclass.', mtError, [mbCancel], 0);
      Result := False;
    end;
end;

end.
