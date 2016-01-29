
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

unit dxreginf;

interface
uses forms, Registry;

procedure StoreExpressFormsInformation(AForm : TForm);
procedure ReStoreExpressFormsInformation(AForm : TForm);

implementation

const
  REGISTRYRSDPATHTODXL = 'Software\Developer Express\Delphi\Design Forms\';


procedure StoreExpressFormsInformation(AForm : TForm);
Var
  reg : TRegIniFile;
begin
  reg := TRegIniFile.Create(REGISTRYRSDPATHTODXL);
  with reg, AForm do begin
    LazyWrite := True;
    WriteInteger(AForm.Name, 'Top', Top);
    WriteInteger(AForm.Name, 'Left', Left);
    WriteInteger(AForm.Name, 'Height', Height);
    WriteInteger(AForm.Name, 'Width', Width);
  end;
end;

procedure ReStoreExpressFormsInformation(AForm : TForm);
Var
  reg : TRegIniFile;
begin
  reg := TRegIniFile.Create(REGISTRYRSDPATHTODXL);
  with reg, AForm do begin
    Top := reg.ReadInteger(AForm.Name, 'Top', Top);
    Left := reg.ReadInteger(AForm.Name, 'Left', Left);
    Height := reg.ReadInteger(AForm.Name, 'Height', Height);
    Width :=  reg.ReadInteger(AForm.Name, 'Width', Width);
  end;
end;


end.
