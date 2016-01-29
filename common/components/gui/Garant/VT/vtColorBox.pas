unit vtColorBox;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/vtColorBox.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::Combos::TvtColorBox
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3Interfaces,
  Graphics,
  vtComboTree,
  Classes,
  ctTypes,
  l3VCLStrings,
  l3InternalInterfaces,
  nevTools
  ;

type
 TvtColorBoxStyles = (
   cbStandardColors // first sixteen RGBI colors
 , cbExtendedColors // four additional reserved colors
 , cbSystemColors // system managed/defined colors
 , cbIncludeNone // include clNone color, must be used with cbSystemColors
 , cbIncludeDefault // include clDefault color, must be used with cbSystemColors
 , cbCustomColor // first color is customizable
 , cbPrettyNames // instead of 'clColorNames' you get 'Color Names'
 , cbNoName // show only color rect
 );//TvtColorBoxStyles

 TvtColorBoxStyle = set of TvtColorBoxStyles;

 TvtCustomColorBox = class(TvtComboTree)
 private
 // private fields
   f_NeedToPopulate : Boolean;
   f_LockPickCustomColor : Boolean;
   f_ColorStyle : TvtColorBoxStyle;
    {* Поле для свойства ColorStyle}
   f_Selected : TColor;
    {* Поле для свойства Selected}
   f_DefaultColorColor : TColor;
    {* Поле для свойства DefaultColorColor}
   f_NoneColorColor : TColor;
    {* Поле для свойства NoneColorColor}
 private
 // private methods
   procedure ColorCallBack(const aName: AnsiString);
   function IndexOfColor(aColor: TColor): Integer;
 protected
 // property methods
   procedure pm_SetColorStyle(aValue: TvtColorBoxStyle);
   function pm_GetColors(anIndex: Integer): TColor;
   function pm_GetColorNames(anIndex: Integer): Il3CString;
   function pm_GetSelected: TColor;
   procedure pm_SetSelected(aValue: TColor);
   procedure pm_SetDefaultColorColor(aValue: TColor);
   procedure pm_SetNoneColorColor(aValue: TColor);
 protected
 // overridden protected methods
   procedure Change; override;
   procedure Loaded; override;
  {$If not defined(NoVCL)}
   procedure CreateWnd; override;
  {$IfEnd} //not NoVCL
   procedure RecreateTreeIfNeeded(aValue: TComboStyle); override;
   procedure ProcessTreeSelect(ChooseFromTree: Boolean;
     aTriggerSelect: Boolean); override;
   function DoCreateStrings: Tl3Strings; override;
   function DoDrawDocument(const aCanvas: Il3Canvas;
    out aMap: InevMap): Boolean; override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   function PickCustomColor: Boolean; virtual;
   procedure PopulateList;
     {* Сигнатура метода PopulateList }
 public
 // public methods
   function DrawNames: Boolean;
 public
 // public properties
   property ColorStyle: TvtColorBoxStyle
     read f_ColorStyle
     write pm_SetColorStyle;
   property Colors[anIndex: Integer]: TColor
     read pm_GetColors;
   property ColorNames[anIndex: Integer]: Il3CString
     read pm_GetColorNames;
   property Selected: TColor
     read pm_GetSelected
     write pm_SetSelected;
   property DefaultColorColor: TColor
     read f_DefaultColorColor
     write pm_SetDefaultColorColor;
   property NoneColorColor: TColor
     read f_NoneColorColor
     write pm_SetNoneColorColor;
 end;//TvtCustomColorBox

const
  { vtColorBox Consts }
 NoColorSelected = TColor($FF000000);

type
//#UC START# *5270BBC702C7ci*
//#UC END# *5270BBC702C7ci*
//#UC START# *5270BBC702C7cit*
//#UC END# *5270BBC702C7cit*
 TvtColorBox = class(TvtCustomColorBox)
//#UC START# *5270BBC702C7publ*
  published
   property ColorStyle default [cbStandardColors, cbExtendedColors, cbSystemColors];
   property DefaultColorColor default clBlack;
   property NoneColorColor default clBlack;
   property Selected default clBlack;
   property Color;
   property Font;
   property HelpContext;
   property HelpKeyword;
   property HelpType;
   property Hint;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property ShowHint;
   property TabOrder;
   property TabStop;
   property Visible;
//#UC END# *5270BBC702C7publ*
 end;//TvtColorBox

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  k2Tags,
  l3Base
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  Consts,
  vtColorBoxStrings
  ;

// start class TvtCustomColorBox

procedure TvtCustomColorBox.ColorCallBack(const aName: AnsiString);
//#UC START# *5538F3810270_5538E709017E_var*
resourcestring
  clNameBlack = 'Black';
  clNameMaroon = 'Maroon';
  clNameGreen = 'Green';
  clNameOlive = 'Olive';
  clNameNavy = 'Navy';
  clNamePurple = 'Purple';
  clNameTeal = 'Teal';
  clNameGray = 'Gray';
  clNameSilver = 'Silver';
  clNameRed = 'Red';
  clNameLime = 'Lime';
  clNameYellow = 'Yellow';
  clNameBlue = 'Blue';
  clNameFuchsia = 'Fuchsia';
  clNameAqua = 'Aqua';
  clNameWhite = 'White';
  clNameMoneyGreen = 'Money Green';
  clNameSkyBlue = 'Sky Blue';
  clNameCream = 'Cream';
  clNameMedGray = 'Medium Gray';
  clNameActiveBorder = 'Active Border';
  clNameActiveCaption = 'Active Caption';
  clNameAppWorkSpace = 'Application Workspace';
  clNameBackground = 'Background';
  clNameBtnFace = 'Button Face';
  clNameBtnHighlight = 'Button Highlight';
  clNameBtnShadow = 'Button Shadow';
  clNameBtnText = 'Button Text';
  clNameCaptionText = 'Caption Text';
  clNameDefault = 'Default';
  clNameGradientActiveCaption = 'Gradient Active Caption';
  clNameGradientInactiveCaption = 'Gradient Inactive Caption';
  clNameGrayText = 'Gray Text';
  clNameHighlight = 'Highlight Background';
  clNameHighlightText = 'Highlight Text';
  clNameInactiveBorder = 'Inactive Border';
  clNameInactiveCaption = 'Inactive Caption';
  clNameInactiveCaptionText = 'Inactive Caption Text';
  clNameInfoBk = 'Info Background';
  clNameInfoText = 'Info Text';
  clNameMenu = 'Menu Background';
  clNameMenuText = 'Menu Text';
  clNameNone = 'None';
  clNameScrollBar = 'Scroll Bar';
  clName3DDkShadow = '3D Dark Shadow';
  clName3DLight = '3D Light';
  clNameWindow = 'Window Background';
  clNameWindowFrame = 'Window Frame';
  clNameWindowText = 'Window Text';

const
  c_ColorToPrettyName: array[0..46] of TIdentMapEntry = (
    (Value: clBlack; Name: clNameBlack),
    (Value: clMaroon; Name: clNameMaroon),
    (Value: clGreen; Name: clNameGreen),
    (Value: clOlive; Name: clNameOlive),
    (Value: clNavy; Name: clNameNavy),
    (Value: clPurple; Name: clNamePurple),
    (Value: clTeal; Name: clNameTeal),
    (Value: clGray; Name: clNameGray),
    (Value: clSilver; Name: clNameSilver),
    (Value: clRed; Name: clNameRed),
    (Value: clLime; Name: clNameLime),
    (Value: clYellow; Name: clNameYellow),
    (Value: clBlue; Name: clNameBlue),
    (Value: clFuchsia; Name: clNameFuchsia),
    (Value: clAqua; Name: clNameAqua),
    (Value: clWhite; Name: clNameWhite),
    (Value: clMoneyGreen; Name: clNameMoneyGreen),
    (Value: clSkyBlue; Name: clNameSkyBlue),
    (Value: clCream; Name: clNameCream),
    (Value: clMedGray; Name: clNameMedGray),
    (Value: clActiveBorder; Name: clNameActiveBorder),
    (Value: clActiveCaption; Name: clNameActiveCaption),
    (Value: clAppWorkSpace; Name: clNameAppWorkSpace),
    (Value: clBackground; Name: clNameBackground),
    (Value: clBtnFace; Name: clNameBtnFace),
    (Value: clBtnHighlight; Name: clNameBtnHighlight),
    (Value: clBtnShadow; Name: clNameBtnShadow),
    (Value: clBtnText; Name: clNameBtnText),
    (Value: clCaptionText; Name: clNameCaptionText),
    (Value: clDefault; Name: clNameDefault),
    (Value: clGrayText; Name: clNameGrayText),
    (Value: clHighlight; Name: clNameHighlight),
    (Value: clHighlightText; Name: clNameHighlightText),
    (Value: clInactiveBorder; Name: clNameInactiveBorder),
    (Value: clInactiveCaption; Name: clNameInactiveCaption),
    (Value: clInactiveCaptionText; Name: clNameInactiveCaptionText),
    (Value: clInfoBk; Name: clNameInfoBk),
    (Value: clInfoText; Name: clNameInfoText),
    (Value: clMenu; Name: clNameMenu),
    (Value: clMenuText; Name: clNameMenuText),
    (Value: clNone; Name: clNameNone),
    (Value: clScrollBar; Name: clNameScrollBar),
    (Value: cl3DDkShadow; Name: clName3DDkShadow),
    (Value: cl3DLight; Name: clName3DLight),
    (Value: clWindow; Name: clNameWindow),
    (Value: clWindowFrame; Name: clNameWindowFrame),
    (Value: clWindowText; Name: clNameWindowText) );
var
 I, LStart: Integer;
 LColor: TColor;
 LName: String;
//#UC END# *5538F3810270_5538E709017E_var*
begin
//#UC START# *5538F3810270_5538E709017E_impl*
 LColor := StringToColor(AName);
 if cbPrettyNames in ColorStyle then
 begin
  if not IntToIdent(LColor, LName, c_ColorToPrettyName) then
  begin
   if System.Copy(AName, 1, 2) = 'cl' then
    LStart := 3
   else
    LStart := 1;
   LName := '';
   for I := LStart to Length(AName) do
   begin
    case AName[I] of
     'A'..'Z':
       if LName <> '' then
        LName := LName + ' ';
    end;
    LName := LName + AName[I];
   end;
  end;
 end
 else
  LName := AName;
 Items.AddObject(l3CStr(LName), TObject(LColor));
//#UC END# *5538F3810270_5538E709017E_impl*
end;//TvtCustomColorBox.ColorCallBack

function TvtCustomColorBox.IndexOfColor(aColor: TColor): Integer;
//#UC START# *5538F39B01D0_5538E709017E_var*
var
 Index: Integer;
//#UC END# *5538F39B01D0_5538E709017E_var*
begin
//#UC START# *5538F39B01D0_5538E709017E_impl*
 Result := -1;
 for Index := 0 to Items.Count - 1 do
 begin
  if Items[Index].LinkedObject = TObject(AColor) then
  begin
   Result := Index;
   Break;
  end;
 end;
//#UC END# *5538F39B01D0_5538E709017E_impl*
end;//TvtCustomColorBox.IndexOfColor

function TvtCustomColorBox.PickCustomColor: Boolean;
//#UC START# *5538F3B8006F_5538E709017E_var*
var
 LColor: TColor;
//#UC END# *5538F3B8006F_5538E709017E_var*
begin
//#UC START# *5538F3B8006F_5538E709017E_impl*
 with TColorDialog.Create(nil) do
 try
  LColor := ColorToRGB(TColor(Items[0].LinkedObject));
  Color := LColor;
  CustomColors.Text := Format('ColorA=%.8x', [LColor]);
  Result := Execute;
  if Result then
  begin
   Items[0].LinkedObject := TObject(Color);
   Self.Invalidate;
  end;
 finally
  Free;
 end;
//#UC END# *5538F3B8006F_5538E709017E_impl*
end;//TvtCustomColorBox.PickCustomColor

procedure TvtCustomColorBox.PopulateList;
//#UC START# *5538F3D60102_5538E709017E_var*
 procedure DeleteRange(const AMin, AMax: Integer);
 var
  I: Integer;
 begin
  for I := AMax downto AMin do
   Items.Delete(I);
 end;

 procedure DeleteColor(const AColor: TColor);
 var
  I: Integer;
 begin
  I := IndexOfColor(AColor);
  if I <> -1 then
   Items.Delete(I);
 end;

var
 l_SelectedColor: TColor;
 l_CustomColor: TColor;
//#UC END# *5538F3D60102_5538E709017E_var*
begin
//#UC START# *5538F3D60102_5538E709017E_impl*
 if HandleAllocated then
 begin
  Items.BeginUpdate;
  try
   l_CustomColor := clBlack;
   if (cbCustomColor in ColorStyle) and (Items.Count > 0) then
     l_CustomColor := TColor(Items[0].LinkedObject);
   l_SelectedColor := f_Selected;
   Items.Clear;
   GetColorValues(ColorCallBack);
   if not (cbIncludeNone in ColorStyle) then
     DeleteColor(clNone);
   if not (cbIncludeDefault in ColorStyle) then
     DeleteColor(clDefault);
   if not (cbSystemColors in ColorStyle) then
     DeleteRange(StandardColorsCount + ExtendedColorsCount, Items.Count - 1);
   if not (cbExtendedColors in ColorStyle) then
     DeleteRange(StandardColorsCount, StandardColorsCount + ExtendedColorsCount - 1);
   if not (cbStandardColors in ColorStyle) then
     DeleteRange(0, StandardColorsCount - 1);
   if cbCustomColor in ColorStyle then
   begin
    Items.Insert(0, l3CStr(SColorBoxCustomCaption));
    Items[0].LinkedObject := TObject(l_CustomColor);
   end;
   Selected := l_SelectedColor;
  finally
   Items.EndUpdate;
   f_NeedToPopulate := False;
  end;
 end
 else
  f_NeedToPopulate := True;
//#UC END# *5538F3D60102_5538E709017E_impl*
end;//TvtCustomColorBox.PopulateList

function TvtCustomColorBox.DrawNames: Boolean;
//#UC START# *5538F3E80193_5538E709017E_var*
//#UC END# *5538F3E80193_5538E709017E_var*
begin
//#UC START# *5538F3E80193_5538E709017E_impl*
 Result := not (cbNoName in ColorStyle);
//#UC END# *5538F3E80193_5538E709017E_impl*
end;//TvtCustomColorBox.DrawNames

procedure TvtCustomColorBox.pm_SetColorStyle(aValue: TvtColorBoxStyle);
//#UC START# *5538EF8B0385_5538E709017Eset_var*
//#UC END# *5538EF8B0385_5538E709017Eset_var*
begin
//#UC START# *5538EF8B0385_5538E709017Eset_impl*
 if (ColorStyle <> aValue) then
 begin
  f_ColorStyle := aValue;
  Enabled := ([cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor] * f_ColorStyle) <> [];
  PopulateList;
  if (Items.Count > 0) and (ItemIndex = -1) then
    ItemIndex := 0;
 end;
//#UC END# *5538EF8B0385_5538E709017Eset_impl*
end;//TvtCustomColorBox.pm_SetColorStyle

function TvtCustomColorBox.pm_GetColors(anIndex: Integer): TColor;
//#UC START# *5538F01F01D6_5538E709017Eget_var*
//#UC END# *5538F01F01D6_5538E709017Eget_var*
begin
//#UC START# *5538F01F01D6_5538E709017Eget_impl*
 Result := TColor(Items[anIndex].LinkedObject);
//#UC END# *5538F01F01D6_5538E709017Eget_impl*
end;//TvtCustomColorBox.pm_GetColors

function TvtCustomColorBox.pm_GetColorNames(anIndex: Integer): Il3CString;
//#UC START# *5538F0A00111_5538E709017Eget_var*
//#UC END# *5538F0A00111_5538E709017Eget_var*
begin
//#UC START# *5538F0A00111_5538E709017Eget_impl*
 Result := l3CStr(Items[anIndex].AsWStr);
//#UC END# *5538F0A00111_5538E709017Eget_impl*
end;//TvtCustomColorBox.pm_GetColorNames

function TvtCustomColorBox.pm_GetSelected: TColor;
//#UC START# *5538F0F4031D_5538E709017Eget_var*
//#UC END# *5538F0F4031D_5538E709017Eget_var*
begin
//#UC START# *5538F0F4031D_5538E709017Eget_impl*
 if HandleAllocated then
  if ItemIndex <> -1 then
    Result := Colors[ItemIndex]
  else
    Result := NoColorSelected
 else
   Result := f_Selected;
//#UC END# *5538F0F4031D_5538E709017Eget_impl*
end;//TvtCustomColorBox.pm_GetSelected

procedure TvtCustomColorBox.pm_SetSelected(aValue: TColor);
//#UC START# *5538F0F4031D_5538E709017Eset_var*
var
 I, Index: Integer;
//#UC END# *5538F0F4031D_5538E709017Eset_var*
begin
//#UC START# *5538F0F4031D_5538E709017Eset_impl*
 if HandleAllocated then
 begin
  I := IndexOfColor(aValue);
  if (I = -1) and (cbCustomColor in ColorStyle) and (aValue <> NoColorSelected) then
  begin
   Items[0].LinkedObject := TObject(aValue);
   I := 0;
  end
  else
  if (cbCustomColor in ColorStyle) and (I = 0) then
  begin
   { Look for the color anywhere else but the first color before
     defaulting to selecting the "custom color". }
   for Index := 1 to Items.Count - 1 do
   begin
    if Items[Index].LinkedObject = TObject(aValue) then
    begin
     I := Index;
     Break;
    end;
   end;
  end;
  f_LockPickCustomColor := True;
  try
   ItemIndex := I;
  finally
   f_LockPickCustomColor := False;
  end;
 end;
 f_Selected := aValue;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=517767425
 if HandleAllocated then
  Invalidate;
//#UC END# *5538F0F4031D_5538E709017Eset_impl*
end;//TvtCustomColorBox.pm_SetSelected

procedure TvtCustomColorBox.pm_SetDefaultColorColor(aValue: TColor);
//#UC START# *5538F2C90308_5538E709017Eset_var*
//#UC END# *5538F2C90308_5538E709017Eset_var*
begin
//#UC START# *5538F2C90308_5538E709017Eset_impl*
 if (aValue <> f_DefaultColorColor) then
 begin
  f_DefaultColorColor := aValue;
  Invalidate;
 end;
//#UC END# *5538F2C90308_5538E709017Eset_impl*
end;//TvtCustomColorBox.pm_SetDefaultColorColor

procedure TvtCustomColorBox.pm_SetNoneColorColor(aValue: TColor);
//#UC START# *5538F2DD02EF_5538E709017Eset_var*
//#UC END# *5538F2DD02EF_5538E709017Eset_var*
begin
//#UC START# *5538F2DD02EF_5538E709017Eset_impl*
 if (aValue <> f_NoneColorColor) then
 begin
  f_NoneColorColor := aValue;
  Invalidate;
 end;
//#UC END# *5538F2DD02EF_5538E709017Eset_impl*
end;//TvtCustomColorBox.pm_SetNoneColorColor

constructor TvtCustomColorBox.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_5538E709017E_var*
//#UC END# *47D1602000C6_5538E709017E_var*
begin
//#UC START# *47D1602000C6_5538E709017E_impl*
 inherited Create(aOwner);
 Assert(Items is TvtColorBoxStrings);
 ComboStyle := ct_cbDropDownList;
 f_ColorStyle := [cbStandardColors, cbExtendedColors, cbSystemColors];
 f_Selected := clBlack;
 f_DefaultColorColor := clBlack;
 f_NoneColorColor := clBlack;
 PopulateList;
//#UC END# *47D1602000C6_5538E709017E_impl*
end;//TvtCustomColorBox.Create

procedure TvtCustomColorBox.Change;
//#UC START# *482AE42802AE_5538E709017E_var*
//#UC END# *482AE42802AE_5538E709017E_var*
begin
//#UC START# *482AE42802AE_5538E709017E_impl*
 if not f_LockPickCustomColor then
  inherited;
//#UC END# *482AE42802AE_5538E709017E_impl*
end;//TvtCustomColorBox.Change

procedure TvtCustomColorBox.Loaded;
//#UC START# *484516C00214_5538E709017E_var*
//#UC END# *484516C00214_5538E709017E_var*
begin
//#UC START# *484516C00214_5538E709017E_impl*
 inherited;
 Selected := f_Selected;
//#UC END# *484516C00214_5538E709017E_impl*
end;//TvtCustomColorBox.Loaded

{$If not defined(NoVCL)}
procedure TvtCustomColorBox.CreateWnd;
//#UC START# *4CC8414403B8_5538E709017E_var*
//#UC END# *4CC8414403B8_5538E709017E_var*
begin
//#UC START# *4CC8414403B8_5538E709017E_impl*
 inherited;
 if f_NeedToPopulate then
  PopulateList;
//#UC END# *4CC8414403B8_5538E709017E_impl*
end;//TvtCustomColorBox.CreateWnd
{$IfEnd} //not NoVCL

procedure TvtCustomColorBox.RecreateTreeIfNeeded(aValue: TComboStyle);
//#UC START# *53EE012C0211_5538E709017E_var*
//#UC END# *53EE012C0211_5538E709017E_var*
begin
//#UC START# *53EE012C0211_5538E709017E_impl*
 inherited RecreateTreeIfNeeded(aValue);
{$IfNDef DesignTimeLibrary}
 Tree.SelfDrawNodes := True;
{$EndIf DesignTimeLibrary}
//#UC END# *53EE012C0211_5538E709017E_impl*
end;//TvtCustomColorBox.RecreateTreeIfNeeded

procedure TvtCustomColorBox.ProcessTreeSelect(ChooseFromTree: Boolean;
  aTriggerSelect: Boolean);
//#UC START# *53EE0A730393_5538E709017E_var*
//#UC END# *53EE0A730393_5538E709017E_var*
begin
//#UC START# *53EE0A730393_5538E709017E_impl*
 {$IfNDef DesignTimeLibrary}
 if not f_LockPickCustomColor then
  if (cbCustomColor in ColorStyle) and (FindIndexOf(Tree.GetCurrentNode) = 0) and not PickCustomColor then
  begin
   Tree.GotoOnNode(ChoosenValue);
   Exit;
  end;
 {$EndIf DesignTimeLibrary}
 inherited;
//#UC END# *53EE0A730393_5538E709017E_impl*
end;//TvtCustomColorBox.ProcessTreeSelect

function TvtCustomColorBox.DoCreateStrings: Tl3Strings;
//#UC START# *53F45F9F030D_5538E709017E_var*
//#UC END# *53F45F9F030D_5538E709017E_var*
begin
//#UC START# *53F45F9F030D_5538E709017E_impl*
 Result := TvtColorBoxStrings.Create(Self);
//#UC END# *53F45F9F030D_5538E709017E_impl*
end;//TvtCustomColorBox.DoCreateStrings

function TvtCustomColorBox.DoDrawDocument(const aCanvas: Il3Canvas;
  out aMap: InevMap): Boolean;
//#UC START# *5538F4D60240_5538E709017E_var*
var
 l_NodePainter: Il3NodePainter;
 l_ClipRect: Tl3Rect;
 l_TopMargin: Integer;
 l_MarginRect: Tl3Rect;
//#UC END# *5538F4D60240_5538E709017E_var*
begin
//#UC START# *5538F4D60240_5538E709017E_impl*
 Result := True;
 if (ItemIndex <> -1) and Supports(Tree.GetNode(ItemIndex), Il3NodePainter, l_NodePainter) then
 begin
  l_ClipRect := aCanvas.ClipRect;
  l_TopMargin := Document.AsObject.IntA[k2_tiSpaceBefore];
  l_MarginRect := l_ClipRect;
  l_MarginRect.Bottom := l_TopMargin;
  aCanvas.FillRect(l_MarginRect);
  l_MarginRect := l_ClipRect;
  l_MarginRect.Top := l_MarginRect.Bottom - l_TopMargin;
  aCanvas.FillRect(l_MarginRect);
  l_ClipRect.Inflate(0, -l_TopMargin);
  aCanvas.ClipRect := l_ClipRect;
  l_NodePainter.PaintNode(aCanvas, aCanvas.ClipRect, 0, 0, Focused);
 end
 else
  aCanvas.FillEmptyRect(aCanvas.ClipRect);
//#UC END# *5538F4D60240_5538E709017E_impl*
end;//TvtCustomColorBox.DoDrawDocument

//#UC START# *5270BBC702C7impl*
//#UC END# *5270BBC702C7impl*

initialization
{$If not defined(NoScripts)}
// Регистрация TvtCustomColorBox
 TtfwClassRef.Register(TvtCustomColorBox);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TvtColorBox
 TtfwClassRef.Register(TvtColorBox);
{$IfEnd} //not NoScripts

end.