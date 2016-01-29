
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars extended DB items registring unit               }
{                                                                   }
{       Copyright (c) 1998-2001 Developer Express Inc.              }
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

unit dxBarExtDBItemsReg;

{$I dxBarVer.inc}

interface

procedure Register;

implementation

uses
  {$IFDEF DELPHI6}DesignIntf, DesignEditors,{$ELSE} DsgnIntf,{$ENDIF}
  Classes, dxBarExtDBItems;

{ TdxBarLookupComboFieldProperty }

type
  TdxBarLookupComboFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TdxBarLookupComboFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxBarLookupComboFieldProperty.GetValues(Proc: TGetStrProc);
var
  Values: TStringList;
  Component: TdxBarLookupCombo;
  I: Integer;
begin
  Values := TStringList.Create;
  try
    Component := TdxBarLookupCombo(GetComponent(0));
    if (Component.ListSource <> nil) and (Component.ListSource.DataSet <> nil) then
      with Component.ListSource.DataSet do
      begin
        GetFieldNames(Values);
        for I := 0 to Values.Count - 1 do Proc(Values[I]);
      end;
  finally
    Values.Free;
  end;
end;

procedure Register;
begin
  RegisterNoIcon([TdxBarLookupCombo]);
  RegisterPropertyEditor(TypeInfo(string), TdxBarLookupCombo,
    'KeyField', TdxBarLookupComboFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxBarLookupCombo,
    'ListField', TdxBarLookupComboFieldProperty);
end;

end.
