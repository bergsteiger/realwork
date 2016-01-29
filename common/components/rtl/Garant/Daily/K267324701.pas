unit K267324701;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K267324701.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRC 7.7::K267324701
//
// [$267324701]
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
  EVDtoNSRCWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK267324701 = class(TEVDtoNSRCWriterTest)
  {* [$267324701] }
 protected
 // realized methods
   function IsNSRCPlus: Boolean; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK267324701
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK267324701

function TK267324701.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4DDF8309020E_var*
//#UC END# *4B8545CC03D2_4DDF8309020E_var*
begin
//#UC START# *4B8545CC03D2_4DDF8309020E_impl*
 Result := False;
//#UC END# *4B8545CC03D2_4DDF8309020E_impl*
end;//TK267324701.IsNSRCPlus

function TK267324701.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRC 7.7';
end;//TK267324701.GetFolder

function TK267324701.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DDF8309020E';
end;//TK267324701.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK267324701.Suite);

end.