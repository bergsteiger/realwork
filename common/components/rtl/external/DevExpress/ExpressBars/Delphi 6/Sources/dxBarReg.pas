
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars registring unit                                 }
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

unit dxBarReg;

{$I dxBarVer.inc}

interface

uses
  Windows, Classes, Graphics, {$IFDEF DELPHI6}DesignIntf, DesignEditors, VCLEditors,{$ELSE} DsgnIntf,{$ENDIF}
  Controls, {$IFDEF DELPHI5}ImgList,{$ENDIF} dxBar;

{$IFDEF DELPHI5}
type
  TImageIndexProperty = class(TIntegerProperty{$IFDEF DELPHI6}, ICustomPropertyListDrawing{$ENDIF})
  private
    function GetBarManager: TdxBarManager;
  protected
    function GetImages: TCustomImageList; virtual;
    property BarManager: TdxBarManager read GetBarManager;
    property Images: TCustomImageList read GetImages;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer); {$IFNDEF DELPHI6}override;{$ENDIF}
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFNDEF DELPHI6}override;{$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFNDEF DELPHI6}override;{$ENDIF}
  end;
{$ENDIF}

procedure Register;

implementation

uses
  Messages, SysUtils, Forms, Dialogs,
  TypInfo, ExptIntf, EditIntf,
  {$IFDEF DELPHI6}ComponentDesigner,{$ENDIF}
  dxBarCustForm, dxBarPopupMenuEd, dxBarStrs, dxRegEd;

type
  FormDesigner =
    {$IFDEF DELPHI6}IDesigner{$ELSE}{$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}{$ENDIF};
{$IFDEF DELPHI6}
  TMyDesignerSelections = class(TDesignerSelections);
{$ENDIF}  
  TSelections =
    {$IFDEF DELPHI6}TMyDesignerSelections{$ELSE}{$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}{$ENDIF};

{ TdxBarRealDesigner }

type
  TdxBarRealDesigner = class(TdxBarDesigner)
  protected
    function GetDesigner(BarManager: TdxBarManager): FormDesigner;
  public
    procedure DeleteComponent(BarManager: TdxBarManager; Component: TPersistent); override;
    procedure SelectComponent(BarManager: TdxBarManager; Instance: TPersistent); override;
    function SelectedComponent(BarManager: TdxBarManager): TPersistent; override;
    procedure ShowDefaultEventHandler(AItem: TdxBarItem); override;
    function UniqueName(BarManager: TdxBarManager; const BaseName: string): string; override;
  end;

function TdxBarRealDesigner.GetDesigner(BarManager: TdxBarManager): FormDesigner;
begin
{$IFDEF DELPHI6}
  Result := ActiveRoot.GetDesigner;
{$ELSE}
  Result := FormDesigner(BarManager.MainForm.Designer);
{$ENDIF}
end;

procedure TdxBarRealDesigner.DeleteComponent(BarManager: TdxBarManager; Component: TPersistent);
begin
(*{$IFDEF DELPHI5}
  with FormDesigner(BarManager.MainForm.Designer) do
  begin
    SelectComponent(Component);
    DeleteSelection;
  end;
{$ELSE}*)
  Component.Free;
//{$ENDIF}
end;

procedure TdxBarRealDesigner.SelectComponent(BarManager: TdxBarManager; Instance: TPersistent);
begin
  GetDesigner(BarManager).SelectComponent(Instance);
end;

function TdxBarRealDesigner.SelectedComponent(BarManager: TdxBarManager): TPersistent;
var
  AList: TSelections;
begin
  AList := TSelections.Create;
  try
    GetDesigner(BarManager).GetSelections(AList);
  finally
    if AList.Count = 0 then Result := nil
    else Result := AList[0];
    AList.Free;
  end;
end;

procedure TdxBarRealDesigner.ShowDefaultEventHandler(AItem: TdxBarItem);
var
  APropInfo: PPropInfo;
  AFormDesigner: FormDesigner;
  AMethod: TMethod;
  AMethodName: string;
begin
  APropInfo := GetPropInfo(AItem.ClassInfo, 'OnChange');
  if APropInfo = nil then
  begin
    APropInfo := GetPropInfo(AItem.ClassInfo, 'OnClick');
    if APropInfo = nil then
      Exit
    else
      AMethodName := 'Click';
  end
  else
    AMethodName := 'Change';
  AFormDesigner := GetDesigner(AItem.BarManager);
  AMethod := GetMethodProp(AItem, APropInfo);
  if AMethod.Code <> nil then
    AMethodName := AFormDesigner.GetMethodName(AMethod)
  else
  begin
    AMethodName := AItem.Name + AMethodName;
    AMethod :=
      AFormDesigner.CreateMethod(AMethodName, GetTypeData(APropInfo^.PropType^));
    SetMethodProp(AItem, APropInfo, AMethod);
    AFormDesigner.Modified;
  end;
  AFormDesigner.ShowMethod(AMethodName);
end;

function TdxBarRealDesigner.UniqueName(BarManager: TdxBarManager; const BaseName: string): string;
begin
  Result := GetDesigner(BarManager).UniqueName(BaseName);
end;

{ TdxBarManagerEditor }

type
  TdxBarManagerEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TdxBarManagerEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: TdxBarManager(Component).Customizing(True);
  end;
end;

function TdxBarManagerEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := LoadStr(DXBAR_CUSTOMIZINGFORM);
    1: Result := '-';
    2: Result := 'ExpressBars 4.2';
    3: Result := 'Developer Express Inc.';
  end;
end;

function TdxBarManagerEditor.GetVerbCount: Integer;
begin
  Result := 1 + 3;
end;

{ TdxBarPopupMenuEditor }

type
  TdxBarPopupMenuEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TdxBarPopupMenuEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowdxBarSubMenuEditor(TdxBarPopupMenu(Component).ItemLinks);
  end;
end;

function TdxBarPopupMenuEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := LoadStr(DXBAR_POPUPMENUEDITOR);
  end;
end;

function TdxBarPopupMenuEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TdxBarsPropertyEditor }

type
  TdxBarsPropertyEditor = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

procedure TdxBarsPropertyEditor.Edit;
var
  BarManager: TdxBarManager;
begin
  BarManager := TdxBarManager(GetComponent(0));
  BarManager.Customizing(True);
  if BarManager.IsCustomizing then
    dxBarCustomizingForm.SelectPage(0);
end;

function TdxBarsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TdxBarsPropertyEditor.GetValue: string;
begin
  Result := Format('(%s)', [TdxBars.ClassName]);
end;

{ TdxCategoriesPropertyEditor }

type
  TdxCategoriesPropertyEditor = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

procedure TdxCategoriesPropertyEditor.Edit;
var
  BarManager: TdxBarManager;
begin
  BarManager := TdxBarManager(GetComponent(0));
  BarManager.Customizing(True);
  if BarManager.IsCustomizing then
    dxBarCustomizingForm.SelectPage(1);
end;

function TdxCategoriesPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TdxCategoriesPropertyEditor.GetValue: string;
begin
  Result := Format('(%s)', [TStrings.ClassName]);
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
  BarManager: TdxBarManager;
  S: string;
begin
  BarManager := TdxBarManager(GetComponent(0));
  S := BarManager.RegistryPath;
  if dxGetRegistryPath(S) then
  begin
    BarManager.RegistryPath := S;
    Designer.Modified;
  end;
end;

function TdxRegistryPathProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TdxBarItemLinksPropertyEditor }

type
  TdxBarItemLinksPropertyEditor = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

procedure TdxBarItemLinksPropertyEditor.Edit;
begin
  if not (GetComponent(0) is TdxBar) then
    ShowdxBarSubMenuEditor(TdxBarItemLinks(GetOrdValue));
end;

function TdxBarItemLinksPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paReadOnly];
  if not (GetComponent(0) is TdxBar) then Include(Result, paDialog);
end;

function TdxBarItemLinksPropertyEditor.GetValue: string;
begin
  Result := Format('(%s)', [TdxBarItemLinks.ClassName]);
end;

{ TDetachingBarPropertyEditor }

const
  NoneBarCaption = '<none>';

type
  TDetachingBarPropertyEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TDetachingBarPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList{$IFNDEF DELPHI6}, paReadOnly{$ENDIF}];
end;

procedure TDetachingBarPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  Proc(NoneBarCaption);
  with TdxBarItem(GetComponent(0)).BarManager do
    for I := 0 to Bars.Count - 1 do
      Proc(Bars[I].Caption);
end;

function TDetachingBarPropertyEditor.GetValue: string;
begin
  with TCustomdxBarSubItem(GetComponent(0)) do
    if GetDetachingBar = nil then
      Result := NoneBarCaption
    else
      Result := GetDetachingBar.Caption;
end;

procedure TDetachingBarPropertyEditor.SetValue(const Value: string); 
begin
  with TCustomdxBarSubItem(GetComponent(0)) do
    if (Value = NoneBarCaption) or (BarManager.BarByCaption(Value) = nil) then
      DetachingBar := -1
    else
      DetachingBar := BarManager.BarByCaption(Value).Index;
  Modified;    
end;

{$IFDEF DELPHI5}
{ TImageIndexProperty  }

function TImageIndexProperty.GetBarManager: TdxBarManager;
begin
  Result := TdxBarItem(GetComponent(0)).BarManager;
end;

function TImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := BarManager.Images;
end;

function TImageIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList];
end;

procedure TImageIndexProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  Proc('-1');
  if Images = nil then Exit;
  for I := 0 to Images.Count - 1 do
    Proc(IntToStr(I));
end;

procedure TImageIndexProperty.ListMeasureWidth(const Value: string; ACanvas: TCanvas;
  var AWidth: Integer);
begin
  inherited;
  if Images <> nil then Inc(AWidth, 1 + Images.Width + 1);
end;

procedure TImageIndexProperty.ListMeasureHeight(const Value: string; ACanvas: TCanvas;
  var AHeight: Integer);
begin
  inherited;
  if (Images <> nil) and (AHeight < 1 + Images.Height + 1) then
    AHeight := 1 + Images.Height + 1;
end;

procedure TImageIndexProperty.ListDrawValue(const Value: string; ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
var
  ATextRect: TRect;
  PrevBrushColor: TColor;
begin
  ATextRect := ARect;
  if Images <> nil then
  begin
    Inc(ATextRect.Left, 1 + Images.Width + 1);
    with ARect do
    begin
      PrevBrushColor := ACanvas.Brush.Color;
      ACanvas.Brush.Color := clWindow;
      ACanvas.FillRect(Rect(Left, Top, ATextRect.Left, Bottom));
      ACanvas.Brush.Color := PrevBrushColor;
    end;
    Images.Draw(ACanvas, ARect.Left + 1, ARect.Top + 1, StrToInt(Value));
  end;
  with ATextRect, ACanvas do
    ACanvas.TextRect(ATextRect, Left + 1, (Top + Bottom - TextHeight(Value)) div 2, Value);
end;
{$ENDIF}

{ register }

procedure Register;
begin
  RegisterComponents('ExpressBars', [TdxBarManager, TdxBarPopupMenu, TdxBarDockControl]);
  RegisterNoIcon([
    TdxBarGroup, TdxBarButton,
    TdxBarEdit, TCustomdxBarCombo, TdxBarCombo,
    TdxBarSubItem, TdxBarListItem, TdxBarContainerItem]);

  RegisterComponentEditor(TdxBarManager, TdxBarManagerEditor);
  RegisterComponentEditor(TdxBarPopupMenu, TdxBarPopupMenuEditor);

{$IFDEF DELPHI6}
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxBarButton, 'ShortCut', TShortCutProperty);
{$ENDIF}

  RegisterPropertyEditor(TypeInfo(TdxBars), TdxBarManager, 'Bars',
    TdxBarsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxBarManager, 'Categories',
    TdxCategoriesPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TdxBarManager, 'RegistryPath',
    TdxRegistryPathProperty);
  RegisterPropertyEditor(TypeInfo(TdxBarItemLinks), TdxBar, 'ItemLinks',
    TdxBarItemLinksPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxBarItemLinks), TdxBarPopupMenu, 'ItemLinks',
    TdxBarItemLinksPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxBarItemLinks), TdxBarSubItem, 'ItemLinks',
    TdxBarItemLinksPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxBarItemLinks), TdxBarContainerItem, 'ItemLinks',
    TdxBarItemLinksPropertyEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TCustomdxBarSubItem, 'DetachingBar',
    TDetachingBarPropertyEditor);
{$IFDEF DELPHI5}
  RegisterPropertyEditor(TypeInfo(Integer), TdxBarItem, 'ImageIndex',
    TImageIndexProperty);
{$ENDIF}
end;

initialization
  dxBarDesigner := TdxBarRealDesigner.Create;

finalization
  dxBarDesigner.Free;
  dxBarDesigner := nil;

end.
