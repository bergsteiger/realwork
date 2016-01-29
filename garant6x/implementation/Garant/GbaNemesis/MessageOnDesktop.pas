unit MessageOnDesktop;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1Test"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/MessageOnDesktop.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::F1Test::TestHelpers::TMessageOnDesktop
//
// Коллеги, это что?
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(XE)}
uses
  l3Core,
  l3SimpleObject,
  Windows
  ;
{$IfEnd} //not XE

{$If not defined(XE)}
type
 TMessageOnDesktop = class(Tl3SimpleObject)
  {* Коллеги, это что? }
 private
 // private fields
   hDC : hDC;
   hFont : HFONT;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create; reintroduce;
   procedure DrawMessage(const aMsg: AnsiString);
 end;//TMessageOnDesktop
{$IfEnd} //not XE

implementation

{$If not defined(XE)}
uses
  Graphics
  ;
{$IfEnd} //not XE

{$If not defined(XE)}

// start class TMessageOnDesktop

constructor TMessageOnDesktop.Create;
//#UC START# *499C387E0015_499C38220140_var*
//#UC END# *499C387E0015_499C38220140_var*
begin
//#UC START# *499C387E0015_499C38220140_impl*
 inherited Create;
 //
 hDC := GetDC(0);
 hFont := CreateFont(
   -MulDiv(36, GetDeviceCaps(hDC, LOGPIXELSY), 72), 0,
   0, 0,
   FW_NORMAL, 0, 0, 0,
   DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, FF_DONTCARE or DEFAULT_PITCH,
   'Arial'
 );
 SelectObject(hDC, hFont);
 SetTextColor(hDC, clRed);
//#UC END# *499C387E0015_499C38220140_impl*
end;//TMessageOnDesktop.Create

procedure TMessageOnDesktop.DrawMessage(const aMsg: AnsiString);
//#UC START# *499C388A00BB_499C38220140_var*
//#UC END# *499C388A00BB_499C38220140_var*
begin
//#UC START# *499C388A00BB_499C38220140_impl*
 TextOutA(hDC, 50, 50, PAnsiChar(aMsg), Length(aMsg));
//#UC END# *499C388A00BB_499C38220140_impl*
end;//TMessageOnDesktop.DrawMessage

procedure TMessageOnDesktop.Cleanup;
//#UC START# *479731C50290_499C38220140_var*
//#UC END# *479731C50290_499C38220140_var*
begin
//#UC START# *479731C50290_499C38220140_impl*
 ReleaseDC( WindowFromDC(hDC), hDC);
 DeleteObject(hFont);
 //
 inherited;
//#UC END# *479731C50290_499C38220140_impl*
end;//TMessageOnDesktop.Cleanup

{$IfEnd} //not XE

end.