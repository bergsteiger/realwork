unit K435460794;
 {* [Requestlink:435460794] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K435460794.pas"
// Стереотип: "TestCase"
// Элемент модели: "K435460794" MUID: (5141662201E0)
// Имя типа: "TK435460794"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK435460794 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:435460794] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK435460794
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5141662201E0impl_uses*
 //#UC END# *5141662201E0impl_uses*
;

function TK435460794.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK435460794.GetFolder

function TK435460794.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5141662201E0';
end;//TK435460794.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK435460794.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
