unit RectWrap;

// Модуль: "w:\common\components\gui\Garant\VCM\RectWrap.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TRectWrap" MUID: (547869730335)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , Classes
 , Types
 //#UC START# *547869730335intf_uses*
 //#UC END# *547869730335intf_uses*
;

type
 //#UC START# *547869730335ci*
 //#UC END# *547869730335ci*
 //#UC START# *547869730335cit*
 //#UC END# *547869730335cit*
 TRectWrap = class(TPersistent)
  private
   f_Rect: TRect;
  public
   constructor Create(const aRect: TRect); reintroduce;
 //#UC START# *547869730335publ*
 published
  property Left : Integer
    read f_Rect.Left;
  property Right : Integer
    read f_Rect.Right;
  property Top : Integer
    read f_Rect.Top;
  property Bottom : Integer
    read f_Rect.Bottom;
 //#UC END# *547869730335publ*
 end;//TRectWrap
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 //#UC START# *547869730335impl_uses*
 //#UC END# *547869730335impl_uses*
;

constructor TRectWrap.Create(const aRect: TRect);
//#UC START# *547869A4035F_547869730335_var*
//#UC END# *547869A4035F_547869730335_var*
begin
//#UC START# *547869A4035F_547869730335_impl*
 inherited Create;
 f_Rect := aRect;
//#UC END# *547869A4035F_547869730335_impl*
end;//TRectWrap.Create

//#UC START# *547869730335impl*
//#UC END# *547869730335impl*
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
