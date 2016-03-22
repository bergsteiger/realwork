unit K219119831;
 {* [RequestLink:219119831] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K219119831.pas"
// Стереотип: "TestCase"
// Элемент модели: "K219119831" MUID: (4C1B2A4701FC)
// Имя типа: "TK219119831"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK219119831 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:219119831] }
  protected
   function UseFullEVDReader: Boolean; override;
    {* Использовать ли ПОЛНЫЙ evdReader (с чтением текста тоже) }
   function DisableParserLog: Boolean; override;
    {* Запретить парсеру выводить в лог }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK219119831
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK219119831.UseFullEVDReader: Boolean;
 {* Использовать ли ПОЛНЫЙ evdReader (с чтением текста тоже) }
//#UC START# *4C1B2B0203A2_4C1B2A4701FC_var*
//#UC END# *4C1B2B0203A2_4C1B2A4701FC_var*
begin
//#UC START# *4C1B2B0203A2_4C1B2A4701FC_impl*
 Result := true;
//#UC END# *4C1B2B0203A2_4C1B2A4701FC_impl*
end;//TK219119831.UseFullEVDReader

function TK219119831.DisableParserLog: Boolean;
 {* Запретить парсеру выводить в лог }
//#UC START# *4C1B47BA03AC_4C1B2A4701FC_var*
//#UC END# *4C1B47BA03AC_4C1B2A4701FC_var*
begin
//#UC START# *4C1B47BA03AC_4C1B2A4701FC_impl*
 Result := true;
//#UC END# *4C1B47BA03AC_4C1B2A4701FC_impl*
end;//TK219119831.DisableParserLog

function TK219119831.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK219119831.GetFolder

function TK219119831.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C1B2A4701FC';
end;//TK219119831.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK219119831.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
