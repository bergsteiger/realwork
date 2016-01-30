unit K204931408;
 {* [RequestLink:204931408] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K204931408.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDEmptyRowTest
;

type
 TK204931408 = class(TEVDtoEVDEmptyRowTest)
  {* [RequestLink:204931408] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK204931408
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK204931408.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK204931408.GetFolder

function TK204931408.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C07BA35009C';
end;//TK204931408.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK204931408.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
