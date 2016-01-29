unit K252520444;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K252520444.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K252520444
//
// [$252520444]
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
  DrawTest,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK252520444 = class(TDrawTest)
  {* [$252520444] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK252520444
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  nevTools
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

// start class TK252520444

{$If defined(nsTest) AND not defined(NoVCM)}
function TK252520444.FormExtent: TPoint;
//#UC START# *4C08CF700318_4D676F85029E_var*
//#UC END# *4C08CF700318_4D676F85029E_var*
begin
//#UC START# *4C08CF700318_4D676F85029E_impl*
 Result.X := 850;
 Result.Y := 600;
//#UC END# *4C08CF700318_4D676F85029E_impl*
end;//TK252520444.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK252520444.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK252520444.GetFolder

function TK252520444.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D676F85029E';
end;//TK252520444.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK252520444.Suite);

end.