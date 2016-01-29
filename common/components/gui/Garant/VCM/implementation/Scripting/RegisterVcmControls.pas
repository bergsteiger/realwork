unit RegisterVcmControls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/RegisterVcmControls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Scripting::VCMWords::RegisterVcmControls
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmMenuManager
  {$If not defined(NoTB97)}
  ,
  TB97Tlbr
  {$IfEnd} //not NoTB97
  ,
  vcmToolbar,
  tfwClassRef,
  elCustomButtonEdit
  {$If not defined(NoVCL)}
  ,
  ComCtrls
  {$IfEnd} //not NoVCL
  ,
  vtNavigator
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLineForm
  {$IfEnd} //not NoVGScene
  
  ;

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
//#UC START# *52B16BBF00B4*
 TtfwClassRef.Register(TCustomUpDown);
//#UC END# *52B16BBF00B4*
{$IfEnd} //not NoScripts AND not NoVCM

end.