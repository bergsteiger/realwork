unit evCustomEdit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomEdit.pas"
// Начат: 13.05.2008 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Editors::TevCustomEdit
//
// Строка ввода.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evDef,
  evCustomMemo,
  Messages,
  l3Region,
  Controls {a},
  Classes,
  l3InternalInterfaces
  ;

const
  { Defaults }
 def_EditScrollStyle = evDef.def_EditScrollStyle;

type
 _RegionableControl_Parent_ = TevCustomMemo;
 {$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
 TevCustomEdit = class(_RegionableControl_)
  {* Строка ввода. }
 private
 // private fields
   f_UpperCase : Boolean;
    {* Поле для свойства UpperCase}
   f_Regionable : Boolean;
    {* Поле для свойства Regionable}
 private
 // private methods
   function CnvLo2Up(Sender: TObject;
    aStr: PAnsiChar;
    aLen: Integer;
    aCodePage: Integer): Boolean;
 protected
 // property methods
   procedure pm_SetRegionable(aValue: Boolean);
 protected
 // overridden protected methods
   function TextSourceClass: RevCustomMemoTextSource; override;
   function GetTopMargin: Integer; override;
     {* Возвращает отступ до текста сверху. }
   procedure Validate; override;
   procedure Paint(const CN: Il3Canvas); override;
     {* процедура рисования внешнего вида управляющего элемента }
   function WantSoftEnter: Boolean; override;
   procedure TuneRegion(aRegion: Tl3Region); override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 public
 // public properties
   property UpperCase: Boolean
     read f_UpperCase
     write f_UpperCase
     default false;
   property Regionable: Boolean
     read f_Regionable
     write pm_SetRegionable;
 end;//TevCustomEdit

implementation

uses
  evCustomEditTextSource,
  SysUtils,
  evSearch,
  l3String,
  evTypes,
  evConvertTextTools,
  l3Units,
  Windows
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCL)}
  ,
  Themes
  {$IfEnd} //not NoVCL
  
  ;

{$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}

// start class TevCustomEdit

procedure TevCustomEdit.pm_SetRegionable(aValue: Boolean);
//#UC START# *4CFFC1BA00EB_4829D7E80085set_var*
//#UC END# *4CFFC1BA00EB_4829D7E80085set_var*
begin
//#UC START# *4CFFC1BA00EB_4829D7E80085set_impl*
 if (f_Regionable <> aValue) then
 begin
  f_Regionable := aValue;
  RecreateWnd;
 end;//f_Regionable <> aValue
//#UC END# *4CFFC1BA00EB_4829D7E80085set_impl*
end;//TevCustomEdit.pm_SetRegionable

function TevCustomEdit.CnvLo2Up(Sender: TObject;
  aStr: PAnsiChar;
  aLen: Integer;
  aCodePage: Integer): Boolean;
//#UC START# *4860F67C0000_4829D7E80085_var*
//#UC END# *4860F67C0000_4829D7E80085_var*
begin
//#UC START# *4860F67C0000_4829D7E80085_impl*
 Result := l3MakeUpperCase(aStr, aLen, aCodePage);
//#UC END# *4860F67C0000_4829D7E80085_impl*
end;//TevCustomEdit.CnvLo2Up

constructor TevCustomEdit.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4829D7E80085_var*
//#UC END# *47D1602000C6_4829D7E80085_var*
begin
//#UC START# *47D1602000C6_4829D7E80085_impl*
 inherited;
 ScrollStyle := def_EditScrollStyle;
 Width := 121;
 Height := 25;
 Wrap := false;
 LMargin := 1;
 NeedReplaceQuotes := false; 
//#UC END# *47D1602000C6_4829D7E80085_impl*
end;//TevCustomEdit.Create

function TevCustomEdit.TextSourceClass: RevCustomMemoTextSource;
//#UC START# *482D9D1701E0_4829D7E80085_var*
//#UC END# *482D9D1701E0_4829D7E80085_var*
begin
//#UC START# *482D9D1701E0_4829D7E80085_impl*
 Result := TevCustomEditTextSource;
//#UC END# *482D9D1701E0_4829D7E80085_impl*
end;//TevCustomEdit.TextSourceClass

function TevCustomEdit.GetTopMargin: Integer;
//#UC START# *483D718E0143_4829D7E80085_var*
var
 l_DocHeight : Integer;
//#UC END# *483D718E0143_4829D7E80085_var*
begin
//#UC START# *483D718E0143_4829D7E80085_impl*
 l_DocHeight := DocumentFullHeight;
 Result := ((ClientHeight - l_DocHeight) div 2) - 1;
 if (Result < 0) then
  Result := 0;
//#UC END# *483D718E0143_4829D7E80085_impl*
end;//TevCustomEdit.GetTopMargin

procedure TevCustomEdit.Validate;
//#UC START# *4860F5DF026F_4829D7E80085_var*
var
 l_Op : TevSearchOptionSet;
//#UC END# *4860F5DF026F_4829D7E80085_var*
begin
//#UC START# *4860F5DF026F_4829D7E80085_impl*
 if f_UpperCase then
 begin
  l_Op := [ev_soGlobal, ev_soReplaceAll, ev_soUseInternalCursor];
  Find(TevAnyParagraphSearcher.Make,
       TevInPlaceTextConverter.Make(cnvLo2Up, l_Op), l_Op);
 end;
//#UC END# *4860F5DF026F_4829D7E80085_impl*
end;//TevCustomEdit.Validate

procedure TevCustomEdit.Paint(const CN: Il3Canvas);
//#UC START# *48C6C044025E_4829D7E80085_var*
var
 l_Delta : Integer;
//#UC END# *48C6C044025E_4829D7E80085_var*
begin
//#UC START# *48C6C044025E_4829D7E80085_impl*
 l_Delta := GetTopMargin;
 if (l_Delta > 0) then
  CN.MoveWindowOrg(l3SPoint(0, -l_Delta));
 inherited;
//#UC END# *48C6C044025E_4829D7E80085_impl*
end;//TevCustomEdit.Paint

function TevCustomEdit.WantSoftEnter: Boolean;
//#UC START# *4B28D6780001_4829D7E80085_var*
//#UC END# *4B28D6780001_4829D7E80085_var*
begin
//#UC START# *4B28D6780001_4829D7E80085_impl*
 {$IFDEF Archi}
 Result := False; 
 {$ELSE}
 Result := inherited WantSoftEnter;
 {$ENDIF Archi}
//#UC END# *4B28D6780001_4829D7E80085_impl*
end;//TevCustomEdit.WantSoftEnter

procedure TevCustomEdit.TuneRegion(aRegion: Tl3Region);
//#UC START# *4CC847800383_4829D7E80085_var*
const
 cRad = 6;
var
 l_R : Tl3Region;
//#UC END# *4CC847800383_4829D7E80085_var*
begin
//#UC START# *4CC847800383_4829D7E80085_impl*
 if Regionable then
 begin
  l_R := Tl3Region.Create;
  try
   l_R.Rgn := CreateRoundRectRgn(1, 0, Width + 1, Height, cRad, cRad);
   aRegion.Combine(l_R, RGN_OR);
   aRegion.CombineRect(l3SRect(Width - cRad, 0, Width, Height), RGN_OR);
  finally
   FreeAndNil(l_R);
  end;//try..fianlly
 end;//Regionable
//#UC END# *4CC847800383_4829D7E80085_impl*
end;//TevCustomEdit.TuneRegion

initialization
{$If not defined(NoScripts)}
// Регистрация TevCustomEdit
 TtfwClassRef.Register(TevCustomEdit);
{$IfEnd} //not NoScripts

end.