unit AutoTestSuiteWithDUnitSupport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnit Script Support"
// Модуль: "w:/common/components/rtl/Garant/DUnit_Script_Support/AutoTestSuiteWithDUnitSupport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnit Script Support::DUnitKeyWordsSupport::TAutoTestSuiteWithDUnitSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnit_Script_Support\dsDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  CustomAutoTestsSuite
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TAutoTestSuiteWithDUnitSupport = class(TCustomAutoTestSuite)
 end;//TAutoTestSuiteWithDUnitSupport
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwKeyWordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}


{$IfEnd} //nsTest AND not NoScripts
end.