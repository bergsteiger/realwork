unit K620665614_H11400224;
 {* [RequestLink:620665614] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620665614_H11400224.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620665614_H11400224" MUID: (56FA6D4303C3)
// Имя типа: "TK620665614_H11400224"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620665614_H11400224 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620665614] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620665614_H11400224
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56FA6D4303C3impl_uses*
 //#UC END# *56FA6D4303C3impl_uses*
;

function TK620665614_H11400224.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620665614_H11400224.GetFolder

function TK620665614_H11400224.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56FA6D4303C3';
end;//TK620665614_H11400224.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620665614_H11400224.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
