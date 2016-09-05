unit K619944727_H11000224;
 {* [RequestLink:619944727] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619944727_H11000224.pas"
// Стереотип: "TestCase"
// Элемент модели: "K619944727_H11000224" MUID: (56E951F40329)
// Имя типа: "TK619944727_H11000224"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619944727_H11000224 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619944727] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619944727_H11000224
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56E951F40329impl_uses*
 //#UC END# *56E951F40329impl_uses*
;

function TK619944727_H11000224.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK619944727_H11000224.GetFolder

function TK619944727_H11000224.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E951F40329';
end;//TK619944727_H11000224.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619944727_H11000224.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
