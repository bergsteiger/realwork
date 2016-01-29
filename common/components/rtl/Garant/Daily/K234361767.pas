unit K234361767;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K234361767.pas"
// Начат: 06.09.2010 14:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K234361767
//
// {RequestLink:234361767}
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
 TK234361767 = class(TEVDtoRTFWriterTest)
  {* [RequestLink:234361767] }
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
 end;//TK234361767
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK234361767

function TK234361767.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK234361767.GetFolder

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TK234361767.EtalonCanHaveDiff: Boolean;
//#UC START# *4CAEE13D00E1_4C84C7D1022A_var*
//#UC END# *4CAEE13D00E1_4C84C7D1022A_var*
begin
//#UC START# *4CAEE13D00E1_4C84C7D1022A_impl*
 Result := true;
//#UC END# *4CAEE13D00E1_4C84C7D1022A_impl*
end;//TK234361767.EtalonCanHaveDiff
{$IfEnd} //nsTest AND not NotTunedDUnit

function TK234361767.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C84C7D1022A';
end;//TK234361767.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK234361767.Suite);

end.