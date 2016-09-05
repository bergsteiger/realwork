unit K620665614_Hk0900071;
 {* [RequestLink:620665614] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620665614_Hk0900071.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620665614_Hk0900071" MUID: (56FA6D77032E)
// Имя типа: "TK620665614_Hk0900071"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620665614_Hk0900071 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620665614] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620665614_Hk0900071
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56FA6D77032Eimpl_uses*
 //#UC END# *56FA6D77032Eimpl_uses*
;

function TK620665614_Hk0900071.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620665614_Hk0900071.GetFolder

function TK620665614_Hk0900071.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56FA6D77032E';
end;//TK620665614_Hk0900071.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620665614_Hk0900071.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
