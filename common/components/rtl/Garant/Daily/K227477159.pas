unit K227477159;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K227477159.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K227477159
//
// [$227477159]
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
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ScrollBackByLineTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK227477159 = class(TScrollBackByLineTest)
  {* [$227477159] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function MaxHeight: Integer; override;
     {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK227477159
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

// start class TK227477159

{$If defined(nsTest) AND not defined(NoVCM)}
function TK227477159.MaxHeight: Integer;
//#UC START# *4C0E56F000A4_4C45569C0111_var*
//#UC END# *4C0E56F000A4_4C45569C0111_var*
begin
//#UC START# *4C0E56F000A4_4C45569C0111_impl*
 Result := 12;
//#UC END# *4C0E56F000A4_4C45569C0111_impl*
end;//TK227477159.MaxHeight
{$IfEnd} //nsTest AND not NoVCM

function TK227477159.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK227477159.GetFolder

function TK227477159.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C45569C0111';
end;//TK227477159.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK227477159.Suite);

end.