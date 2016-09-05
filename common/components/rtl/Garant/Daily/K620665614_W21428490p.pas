unit K620665614_W21428490p;
 {* [RequestLink:620665614] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620665614_W21428490p.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620665614_W21428490p" MUID: (56FA6D8F02DD)
// Имя типа: "TK620665614_W21428490p"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620665614_W21428490p = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620665614] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620665614_W21428490p
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56FA6D8F02DDimpl_uses*
 //#UC END# *56FA6D8F02DDimpl_uses*
;

function TK620665614_W21428490p.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620665614_W21428490p.GetFolder

function TK620665614_W21428490p.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56FA6D8F02DD';
end;//TK620665614_W21428490p.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620665614_W21428490p.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
