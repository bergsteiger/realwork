unit K208700993;
 {* [RequestLink:208700993] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K208700993.pas"
// Стереотип: "TestCase"
// Элемент модели: "K208700993" MUID: (4BDFE7D90383)
// Имя типа: "TK208700993"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK208700993 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:208700993] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK208700993
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK208700993.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK208700993.GetFolder

function TK208700993.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BDFE7D90383';
end;//TK208700993.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK208700993.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
