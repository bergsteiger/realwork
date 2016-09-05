unit K604929313;
 {* [RequestLink:604929313] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K604929313.pas"
// Стереотип: "TestCase"
// Элемент модели: "K604929313" MUID: (55CE18D901C2)
// Имя типа: "TK604929313"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK604929313 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:604929313] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK604929313
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *55CE18D901C2impl_uses*
 //#UC END# *55CE18D901C2impl_uses*
;

function TK604929313.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DecorText';
end;//TK604929313.GetFolder

function TK604929313.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55CE18D901C2';
end;//TK604929313.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK604929313.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
