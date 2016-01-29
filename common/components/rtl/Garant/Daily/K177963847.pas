unit K177963847;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K177963847.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K177963847
//
// [$177963847]
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
  EVDtoRTFWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK177963847 = class(TEVDtoRTFWriterTest)
  {* [$177963847] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonCanHaveDiff: Boolean; override;
     {* Эталон может иметь эталонную разницу для конкретного компьютера. Например как в [RequestLink:234362304] }
    {$IfEnd} //nsTest AND not NotTunedDUnit
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK177963847
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK177963847

function TK177963847.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK177963847.GetFolder

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TK177963847.EtalonCanHaveDiff: Boolean;
//#UC START# *4CAEE13D00E1_4D54F92D03CD_var*
//#UC END# *4CAEE13D00E1_4D54F92D03CD_var*
begin
//#UC START# *4CAEE13D00E1_4D54F92D03CD_impl*
 Result := True;
//#UC END# *4CAEE13D00E1_4D54F92D03CD_impl*
end;//TK177963847.EtalonCanHaveDiff
{$IfEnd} //nsTest AND not NotTunedDUnit

function TK177963847.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D54F92D03CD';
end;//TK177963847.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK177963847.Suite);

end.