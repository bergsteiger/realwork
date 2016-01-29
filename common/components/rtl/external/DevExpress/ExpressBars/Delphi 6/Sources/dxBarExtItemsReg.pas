
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars extended items registring unit                  }
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

unit dxBarExtItemsReg;

{$I dxBarVer.inc}

interface

procedure Register;

implementation

uses
  {$IFDEF DELPHI6}DesignIntf, DesignEditors,{$ELSE} DsgnIntf,{$ENDIF}
  Classes, SysUtils, dxBarExtItems, dxBarImageComboEditor
  {$IFDEF DELPHI5}, ImgList, dxBarReg{$ENDIF};

type
  TDummydxBarImageCombo = class(TdxBarImageCombo);

{ TdxBarImageComboItemsProperty }

type
  TDummyStringList = class(TStringList);

  TdxBarImageComboItemsProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

procedure TdxBarImageComboItemsProperty.Edit;
begin
  if dxBarImageComboEdit(TdxBarImageCombo(GetComponent(0))) then
  begin
    Modified;
    TDummyStringList(TDummydxBarImageCombo(GetComponent(0)).Items).Changed;
  end;
end;

function TdxBarImageComboItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TdxBarImageComboItemsProperty.GetValue: string;
begin
  Result := Format('(%s)', [TStrings.ClassName]);
end;

{$IFDEF DELPHI5}
{ THotImageIndexProperty }

type
  THotImageIndexProperty = class(TImageIndexProperty)
  protected
    function GetImages: TCustomImageList; override;
  end;

function THotImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := BarManager.HotImages;
end;

{ TLargeImageIndexProperty }

type
  TLargeImageIndexProperty = class(TImageIndexProperty)
  protected
    function GetImages: TCustomImageList; override;
  end;

function TLargeImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := BarManager.LargeImages;
end;
{$ENDIF}

{ register }

procedure Register;
begin
  RegisterNoIcon([TdxBarStatic, TdxBarLargeButton, TdxBarColorCombo, TdxBarFontNameCombo,
    TdxBarDateCombo, TdxBarTreeViewCombo, TdxBarImageCombo,
    TdxBarToolbarsListItem, TdxBarSpinEdit,
    TdxBarControlContainerItem, TdxBarProgressItem, TdxBarMRUListItem, TdxBarInPlaceSubItem]);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxBarImageCombo, 'Items',
    TdxBarImageComboItemsProperty);
{$IFDEF DELPHI5}
  RegisterPropertyEditor(TypeInfo(Integer), TdxBarLargeButton, 'HotImageIndex',
    THotImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TdxBarLargeButton, 'LargeImageIndex',
    TLargeImageIndexProperty);
{$ENDIF}
end;

end.
