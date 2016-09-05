unit K439429165;
 {* [Requestlink:439429165] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K439429165.pas"
// Стереотип: "TestCase"
// Элемент модели: "K439429165" MUID: (514850F50232)
// Имя типа: "TK439429165"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK439429165 = class(TEVDtoNSRCPlusWriterTest)
  {* [Requestlink:439429165] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK439429165
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *514850F50232impl_uses*
 //#UC END# *514850F50232impl_uses*
;

function TK439429165.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK439429165.GetFolder

function TK439429165.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '514850F50232';
end;//TK439429165.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK439429165.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
