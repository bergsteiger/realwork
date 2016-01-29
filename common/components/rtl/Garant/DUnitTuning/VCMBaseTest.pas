unit VCMBaseTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnitTuning"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/DUnitTuning/VCMBaseTest.pas"
// Начат: 23.12.209 18:30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Testing Framework::DUnitTuning::VCM_TFW::VCMBaseTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM) AND not defined(NotTunedDUnit)}
uses
  BaseTest
  ;

type
 TVCMBaseTest = {abstract} class(TBaseTest)
  {* Базовый тест для тестирования объектов VCM }
 protected
 // overridden protected methods
   procedure InitFields; override;
 end;//TVCMBaseTest
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM AND not NotTunedDUnit

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM) AND not defined(NotTunedDUnit)}
uses
  l3Base,
  SysUtils,
  l3MenuManagerHelper
  ;

// unit methods

procedure FreeMM;
//#UC START# *4B323587024D_4B3235370235_var*
//#UC END# *4B323587024D_4B3235370235_var*
begin
//#UC START# *4B323587024D_4B3235370235_impl*
 if Tl3MenuManagerHelper.Exists then
  Tl3MenuManagerHelper.Instance.FreeManager;
//#UC END# *4B323587024D_4B3235370235_impl*
end;//FreeMM
// start class TVCMBaseTest

procedure TVCMBaseTest.InitFields;
//#UC START# *4B30EEA10210_4B30EEEB01EF_var*
//#UC END# *4B30EEA10210_4B30EEEB01EF_var*
begin
//#UC START# *4B30EEA10210_4B30EEEB01EF_impl*
 inherited;
 if Tl3MenuManagerHelper.Instance.CreateManager then
  l3System.AddExitProc(FreeMM);
//#UC END# *4B30EEA10210_4B30EEEB01EF_impl*
end;//TVCMBaseTest.InitFields
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM AND not NotTunedDUnit

end.