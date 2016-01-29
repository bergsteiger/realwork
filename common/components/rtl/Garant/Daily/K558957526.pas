unit K558957526;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K558957526.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.10::K558957526
//
// {Requestlink:558957526}
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
  EVDtoRTFRender
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK558957526 = class(TEVDtoRTFRender)
  {* [Requestlink:558957526] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function TreatExceptionAsSuccess: Boolean; override;
 end;//TK558957526
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK558957526

function TK558957526.GetFolder: AnsiString;
 {-}
begin
 Result := '7.10';
end;//TK558957526.GetFolder

function TK558957526.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53DA29FE019E';
end;//TK558957526.GetModelElementGUID

function TK558957526.TreatExceptionAsSuccess: Boolean;
//#UC START# *53DA3E0C019A_53DA29FE019E_var*
//#UC END# *53DA3E0C019A_53DA29FE019E_var*
begin
//#UC START# *53DA3E0C019A_53DA29FE019E_impl*
 Result := True;
//#UC END# *53DA3E0C019A_53DA29FE019E_impl*
end;//TK558957526.TreatExceptionAsSuccess

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK558957526.Suite);

end.