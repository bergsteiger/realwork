unit K199591594;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K199591594.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K199591594
//
// [$199591594]
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
  RTFWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK199591594 = class(TRTFWriterTest)
  {* [$199591594] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsComputerName: Boolean; override;
    {$IfEnd} //nsTest AND not NotTunedDUnit
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TK199591594
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK199591594

procedure TK199591594.DoIt;
//#UC START# *4BACE4A50338_4BACE34001A1_var*
//#UC END# *4BACE4A50338_4BACE34001A1_var*
begin
//#UC START# *4BACE4A50338_4BACE34001A1_impl*
 EVDtoRTF('199591594.evd', true{false});
//#UC END# *4BACE4A50338_4BACE34001A1_impl*
end;//TK199591594.DoIt

function TK199591594.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK199591594.GetFolder

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TK199591594.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_4BACE34001A1_var*
//#UC END# *4CA45DAA01BA_4BACE34001A1_var*
begin
//#UC START# *4CA45DAA01BA_4BACE34001A1_impl*
 Result := true;
//#UC END# *4CA45DAA01BA_4BACE34001A1_impl*
end;//TK199591594.EtalonNeedsComputerName
{$IfEnd} //nsTest AND not NotTunedDUnit

function TK199591594.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BACE34001A1';
end;//TK199591594.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK199591594.Suite);

end.