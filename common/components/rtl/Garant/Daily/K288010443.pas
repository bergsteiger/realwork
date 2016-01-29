unit K288010443;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K288010443.pas"
// Начат: 28.09.2011 15:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7 Lulin::K288010443
//
// {RequestLink:288010443}
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
  EVDtoNSRCPlusWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK288010443 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLink:288010443] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function AcceptBadPictureFormat: Boolean; override;
 end;//TK288010443
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK288010443

function TK288010443.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7 Lulin';
end;//TK288010443.GetFolder

function TK288010443.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E8304550222';
end;//TK288010443.GetModelElementGUID

function TK288010443.AcceptBadPictureFormat: Boolean;
//#UC START# *4E8317EF02C7_4E8304550222_var*
//#UC END# *4E8317EF02C7_4E8304550222_var*
begin
//#UC START# *4E8317EF02C7_4E8304550222_impl*
 Result := true;
//#UC END# *4E8317EF02C7_4E8304550222_impl*
end;//TK288010443.AcceptBadPictureFormat

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK288010443.Suite);

end.