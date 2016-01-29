unit K263750307;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K263750307.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K263750307
//
// [$263750307]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  InsertFormulaTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK263750307 = class(TInsertFormulaTest)
  {* [$263750307] }
 protected
 // realized methods
   function GetFormulaText: AnsiString; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK263750307
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK263750307

function TK263750307.GetFormulaText: AnsiString;
//#UC START# *4DAFEAFC033F_4DAFEB7300EE_var*
//#UC END# *4DAFEAFC033F_4DAFEB7300EE_var*
begin
//#UC START# *4DAFEAFC033F_4DAFEB7300EE_impl*
 Result := '';
//#UC END# *4DAFEAFC033F_4DAFEB7300EE_impl*
end;//TK263750307.GetFormulaText

function TK263750307.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK263750307.GetFolder

function TK263750307.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DAFEB7300EE';
end;//TK263750307.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK263750307.Suite);

end.