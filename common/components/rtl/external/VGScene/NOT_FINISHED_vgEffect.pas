unit NOT_FINISHED_vgEffect;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgEffect.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgEffect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  vgObject
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgEffect = class(TvgObject)
 end;//TvgEffect
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}


{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgEffect
 TtfwClassRef.Register(TvgEffect);
{$IfEnd} //not NoScripts AND not NoVGScene

end.