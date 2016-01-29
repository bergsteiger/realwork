unit K265409725;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K265409725.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K265409725
//
// [$265409725]
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
 TK265409725 = class(TDrawTest)
  {* [$265409725] }
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
 end;//TK265409725
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

// start class TK265409725

{$If defined(nsTest) AND not defined(NoVCM)}
function TK265409725.FormExtent: TPoint;
//#UC START# *4C08CF700318_4DEDC61B02A0_var*
//#UC END# *4C08CF700318_4DEDC61B02A0_var*
begin
//#UC START# *4C08CF700318_4DEDC61B02A0_impl*
 Result.X := 1024;
 Result.Y := 710; 
//#UC END# *4C08CF700318_4DEDC61B02A0_impl*
end;//TK265409725.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK265409725.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK265409725.GetFolder

function TK265409725.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DEDC61B02A0';
end;//TK265409725.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK265409725.Suite);

end.