unit K208699964;
 {* [RequestLink:208699964] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K208699964.pas"
// Стереотип: "TestCase"
// Элемент модели: "K208699964" MUID: (4BDAC30B0188)
// Имя типа: "TK208699964"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK208699964 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:208699964] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK208699964
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BDAC30B0188impl_uses*
 //#UC END# *4BDAC30B0188impl_uses*
;

function TK208699964.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK208699964.GetFolder

function TK208699964.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BDAC30B0188';
end;//TK208699964.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK208699964.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
