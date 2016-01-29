{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express side bar controls registration                      }
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

unit dxsbreg;

{$I dxSBVer.inc}

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF DELPHI6}DesignIntf, DesignEditors{$ELSE}DsgnIntf{$ENDIF};

procedure Register;

implementation

uses dximctrl, dximcted, dxsppred, dxsbar, dxsbared, dxsbrsed, dxRegEd, ShellAPI;

const
  GetVerbSt1 = 'Express SideBarStore Editor ...';
  GetVerbSt2 = '-';
  GetVerbSt3 = 'ExpressSideBar Ver 4.2';
  GetVerbSt4 = 'http://www.devexpress.com';
  GetVerbSt5 = 'Developer Express Inc.';


{TSideBarStoreEditor}
type
  TSideBarStoreEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TSideBarStoreEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowSideBarStoreEditor(TdxSideBarStore(Component), Designer);
    3: ShellExecute(0, PChar('OPEN'), PChar('http://www.devexpress.com'), Nil, Nil, SW_SHOWMAXIMIZED);
  end;
end;

function TSideBarStoreEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := GetVerbSt1;
    1: Result := GetVerbSt2;
    2: Result := GetVerbSt3;
    3: Result := GetVerbSt4;
    4: Result := GetVerbSt5;
  end;
end;

function TSideBarStoreEditor.GetVerbCount: Integer;
begin
  Result := 5;
end;

{TSideBarEditor}
type
  TSideBarEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TSideBarEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if ShowSideBarEditor(TdxSideBar(Component)) then   Designer.Modified;
    3: ShellExecute(0, PChar('OPEN'), PChar('http://www.devexpress.com'), Nil, Nil, SW_SHOWMAXIMIZED);    
  end;
end;

function TSideBarEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := GetVerbSt1;
    1: Result := GetVerbSt2;
    2: Result := GetVerbSt3;
    3: Result := GetVerbSt4;
    4: Result := GetVerbSt5;        
  end;
end;

function TSideBarEditor.GetVerbCount: Integer;
begin
  Result := 5;
end;

{TSideBarStoreGroupsPropertyEditor}
type
TSideBarStoreGroupsPropertyEditor = class(TPropertyEditor)
public
  function GetValue: string; override;
  function GetAttributes: TPropertyAttributes; override;
  procedure Edit; override;
end;

function TSideBarStoreGroupsPropertyEditor.GetValue: string;
begin
  Result := Format('(%s)', [TStrings.ClassName]);
end;

function TSideBarStoreGroupsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog];
end;

procedure TSideBarStoreGroupsPropertyEditor.Edit;
begin
  ShowSideBarStoreEditor(GetComponent(0) as TdxSideBarStore, Designer);
end;

{TSideBarGroupsPropertyEditor}
type
TSideBarGroupsPropertyEditor = class(TPropertyEditor)
public
  function GetValue: string; override;
  function GetAttributes: TPropertyAttributes; override;
  procedure Edit; override;
end;

function TSideBarGroupsPropertyEditor.GetValue: string;
begin
  Result := Format('(%s)', [TdxSideGroups.ClassName]);
end;

function TSideBarGroupsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog];
end;

procedure TSideBarGroupsPropertyEditor.Edit;
begin
  if ShowSideBarEditor(GetComponent(0) as TdxSideBar) then
    Modified;
end;

type
TdxImageControlItemProperties = class(TPropertyEditor)
public
  function GetValue: string; override;
  function GetAttributes: TPropertyAttributes; override;
  procedure Edit; override;
end;

function TdxImageControlItemProperties.GetValue: string;
begin
  Result := Format('(%s)', [TStrings.ClassName]);
end;

function TdxImageControlItemProperties.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog];
end;

procedure TdxImageControlItemProperties.Edit;
begin
  if(ExpressImageItemsPropEditor(GetComponent(0) as TWinControl)) then
    Modified;
end;

type
TdxSpinImageItemsProperties = class(TClassProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure Edit; override;
end;

function TdxSpinImageItemsProperties.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TdxSpinImageItemsProperties.Edit;
begin
  if(ExpressSpinImageItemsPropEditor(GetComponent(0) as TdxCustomSpinImage)) then
    Modified;
end;

{ TdxRegistryPathProperty }

type
  TdxRegistryPathProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure TdxRegistryPathProperty.Edit;
var
  Bar: TdxSideBar;
  S: string;
begin
  Bar := TdxSideBar(GetComponent(0));
  S := Bar.RegistryPath;
  if dxGetRegistryPath(S) then
  begin
    Bar.RegistryPath := S;
    Designer.Modified;
  end;
end;

function TdxRegistryPathProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure Register;
begin
  RegisterComponents('ExpressBars', [TdxSideBarStore, TdxSideBar, TdxSideBarPopupMenu]);
  RegisterNoIcon([TdxStoredSideItem]);

  RegisterComponents('ExpressBars', [TdxImageListBox, TdxImageComboBox, TdxSpinImage]);

  RegisterPropertyEditor(TypeInfo(TStrings), TdxCustomImageListBox, 'Items', TdxImageControlItemProperties);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxImageComboBox, 'Items', TdxImageControlItemProperties);
  RegisterPropertyEditor(TypeInfo(TdxSpinImageItems), TdxCustomSpinImage, 'Items', TdxSpinImageItemsProperties);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxSideBarStore, 'Groups', TSideBarStoreGroupsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxSideGroups), TdxSideBar, 'Groups', TSideBarGroupsPropertyEditor);

  RegisterPropertyEditor(TypeInfo(string), TdxSideBar, 'RegistryPath', TdxRegistryPathProperty);

  RegisterComponentEditor(TdxSideBarStore, TSideBarStoreEditor);
  RegisterComponentEditor(TdxSideBar, TSideBarEditor);
end;


end.
