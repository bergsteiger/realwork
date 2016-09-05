unit K624074743;
 {* [Requestlink:624074743] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K624074743.pas"
// Стереотип: "TestCase"
// Элемент модели: "K624074743" MUID: (575FF5110334)
// Имя типа: "TK624074743"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK624074743 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:624074743] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK624074743
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *575FF5110334impl_uses*
 //#UC END# *575FF5110334impl_uses*
;

function TK624074743.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK624074743.GetFolder

function TK624074743.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '575FF5110334';
end;//TK624074743.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624074743.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
