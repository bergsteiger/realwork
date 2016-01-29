unit NOT_FINISHED_GUITestRunner;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnit"
// Модуль: "w:/common/components/rtl/external/DUnit/src/NOT_FINISHED_GUITestRunner.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Testing Framework::DUnit::Source::GUITestRunner
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

{$If defined(nsTest)}
type
 TGUITestRunner = class
 end;//TGUITestRunner
procedure RunRegisteredTests;
   {* Сигнатура метода RunRegisteredTests }
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  vtComboBoxQS
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwKeyWordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCL
  
  ;

// unit methods

procedure RunRegisteredTests;
//#UC START# *4B2A0DAC0037_4B2A0D9401CC_var*
//#UC END# *4B2A0DAC0037_4B2A0D9401CC_var*
begin
//#UC START# *4B2A0DAC0037_4B2A0D9401CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2A0DAC0037_4B2A0D9401CC_impl*
end;//RunRegisteredTests
{$IfEnd} //nsTest
end.