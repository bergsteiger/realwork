unit MessageOnDesktop;
 {* Коллеги, это что? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MessageOnDesktop.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TMessageOnDesktop" MUID: (499C38220140)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , l3SimpleObject
 , l3Core
 , Windows
;

type
 TMessageOnDesktop = class(Tl3SimpleObject)
  {* Коллеги, это что? }
  private
   hDC: hDC;
   hFont: HFONT;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   procedure DrawMessage(const aMsg: AnsiString);
 end;//TMessageOnDesktop
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
 , Graphics
;

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
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(XE)

end.
