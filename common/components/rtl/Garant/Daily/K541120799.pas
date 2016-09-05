unit K541120799;
 {* [Requestlink:541120799] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K541120799.pas"
// Стереотип: "TestCase"
// Элемент модели: "K541120799" MUID: (5398289A01EB)
// Имя типа: "TK541120799"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK541120799 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:541120799] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK541120799
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5398289A01EBimpl_uses*
 //#UC END# *5398289A01EBimpl_uses*
;

function TK541120799.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK541120799.GetFolder

function TK541120799.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5398289A01EB';
end;//TK541120799.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK541120799.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
