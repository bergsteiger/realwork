unit K568147841;
 {* [Requestlink:568147841] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K568147841.pas"
// Стереотип: "TestCase"
// Элемент модели: "K568147841" MUID: (544E3A1503CB)
// Имя типа: "TK568147841"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK568147841 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:568147841] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK568147841
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *544E3A1503CBimpl_uses*
 //#UC END# *544E3A1503CBimpl_uses*
;

function TK568147841.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK568147841.GetFolder

function TK568147841.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '544E3A1503CB';
end;//TK568147841.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK568147841.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
