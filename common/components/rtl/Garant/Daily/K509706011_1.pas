unit K509706011_1;
 {* [RequestLink:509706011] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K509706011_1.pas"
// Стереотип: "TestCase"
// Элемент модели: "K509706011_1" MUID: (52BAF700009D)
// Имя типа: "TK509706011_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK509706011_1 = class(TEVDtoRTFWriterTest)
  {* [RequestLink:509706011] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK509706011_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *52BAF700009Dimpl_uses*
 //#UC END# *52BAF700009Dimpl_uses*
;

function TK509706011_1.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK509706011_1.GetFolder

function TK509706011_1.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '52BAF700009D';
end;//TK509706011_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK509706011_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
