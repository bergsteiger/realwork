unit vcmGlassForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmGlassForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::TvcmGlassForm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  vcmEntityForm,
  Types,
  vcmGlassFrame,
  Classes,
  Messages,
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 _vcmGlassForm_Parent_ = TvcmEntityForm;
 {$Include ..\ChromeLike\vcmGlassForm.imp.pas}
 TvcmGlassForm = class(_vcmGlassForm_)
 end;//TvcmGlassForm
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3DwmApi,
  l3Base
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

type _Instance_R_ = TvcmGlassForm;

{$Include ..\ChromeLike\vcmGlassForm.imp.pas}


{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TvcmGlassForm
 TtfwClassRef.Register(TvcmGlassForm);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene

end.