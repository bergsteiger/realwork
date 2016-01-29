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

unit adxWFrmClientStart;

{$I adxDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  adxWFrmClient, StdCtrls;

type
  TfrmClientStart = class(TfrmClient)
  private
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  frmClientStart: TfrmClientStart;

implementation

{$R *.DFM}

uses adxWForm;

{ TfrmClientStart }

constructor TfrmClientStart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if MainForm.FDestApp = daSmartTag then
    lblTitle.Caption := 'Welcome to the Smart Tag Wizard'
  else
    if MainForm.FDestApp = daRTD then
      lblTitle.Caption := 'Welcome to the RTD Server Wizard'
    else
      lblTitle.Caption := 'Welcome to the COM Add-in Wizard';
  if MainForm.FDestApp = daRTD then
    lblComment.Caption :=
      'This will create a MS Excel Real-Time Data Server project based on Add-in Express 2010 for VCL.' +
      '                                                       '#10#10
  else
    if MainForm.FDestApp = daSmartTag then
      lblComment.Caption :=
        'This will create a smart tag library project based on Add-in Express 2010 for VCL.' +
        '                                                       '#10#10
    else
      lblComment.Caption :=
        'This will create a COM add-in project based on Add-in Express 2010 for VCL.' +
        '                                                       '#10#10;
  lblComment.Caption := lblComment.Caption +
    'It is strongly recomended that you close all other projects ' +
    'you have opened before continuing. This will help prevent ' +
    'any conflicts during the creation process.'#10#10#10#10 +
    'Click Next to continue, or Cancel to exit Wizard.'
end;

end.
