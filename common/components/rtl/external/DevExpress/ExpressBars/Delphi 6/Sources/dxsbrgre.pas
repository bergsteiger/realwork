
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{                                                                   }
{       Copyright (c) 1998-2000 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxsbrgre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmSideBarGroupRename = class(TForm)
    Bevel1: TBevel;
    LGroupName: TLabel;
    EGroupName: TEdit;
    BOk: TButton;
    BCancel: TButton;
    BHelp: TButton;
    procedure EGroupNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ESideBarGroupRename(var GroupName : String; Kind : Integer) : Boolean;

implementation


function ESideBarGroupRename(var GroupName : String; Kind : Integer) : Boolean;
Var
  AForm : TfrmSideBarGroupRename;
begin
  AForm := TfrmSideBarGroupRename.Create(Nil);
  Result := False;
  with AForm do begin
    case Kind of
      0: Caption := 'Add New Category';
      1: Caption := 'Insert New Category';
      2: Caption := 'Rename the Category';
    end;
    EGroupName.Text := GroupName;
    BOk.Enabled := EGroupName.Text  <> '';
    ShowModal;
    if(ModalResult = mrOk) then begin
      GroupName := EGroupName.Text;
      Result := True;
    end;
  end;
  AForm.Free;
end;

{$R *.DFM}

procedure TfrmSideBarGroupRename.EGroupNameKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  BOk.Enabled := EGroupName.Text  <> '';
end;

end.
