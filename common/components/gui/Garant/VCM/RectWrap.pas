unit RectWrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCMTest"
// Модуль: "w:/common/components/gui/Garant/VCM/RectWrap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi TestComplete Wrappers::VCMTest::Wrap::TRectWrap
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
uses
  Types,
  Classes
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
type
//#UC START# *547869730335ci*
 //#UC END# *547869730335ci*
//#UC START# *547869730335cit*
 //#UC END# *547869730335cit*
 TRectWrap = class(TPersistent)
 private
 // private fields
   f_Rect : TRect;
 public
 // public methods
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
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}

// start class TRectWrap

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

{$IfEnd} //not NoTabs AND not NoVCM AND not XE

end.