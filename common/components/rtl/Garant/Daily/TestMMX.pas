unit TestMMX;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/TestMMX.pas"
// Начат: 17.12.2009 15:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::Core::TTestMMX
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
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TTestMMX = class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoMMX;
 end;//TTestMMX
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Base,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TTestMMX

procedure TTestMMX.DoMMX;
//#UC START# *4B2A1D6D001D_4B2A1D3E0376_var*
//#UC END# *4B2A1D6D001D_4B2A1D3E0376_var*
begin
//#UC START# *4B2A1D6D001D_4B2A1D3E0376_impl*
 {$IfDef l3UseMMX}
 ToLog('l3UseMMX enabled');
 Check(MMX_Supported);
 {$Else  l3UseMMX}
 ToLog('l3UseMMX disabled');
 {$EndIf l3UseMMX}
//#UC END# *4B2A1D6D001D_4B2A1D3E0376_impl*
end;//TTestMMX.DoMMX

function TTestMMX.GetFolder: AnsiString;
 {-}
begin
 Result := 'Core';
end;//TTestMMX.GetFolder

function TTestMMX.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B2A1D3E0376';
end;//TTestMMX.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TTestMMX.Suite);

end.