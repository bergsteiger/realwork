unit K604908954;
 {* [Requestlink:604908954] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K604908954.pas"
// Стереотип: "TestCase"
// Элемент модели: "K604908954" MUID: (55D6EC680274)
// Имя типа: "TK604908954"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK604908954 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:604908954] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK604908954
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *55D6EC680274impl_uses*
 //#UC END# *55D6EC680274impl_uses*
;

function TK604908954.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK604908954.GetFolder

function TK604908954.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55D6EC680274';
end;//TK604908954.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK604908954.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
