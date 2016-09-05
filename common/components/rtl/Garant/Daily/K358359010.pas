unit K358359010;
 {* [Requestlink:358359010] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K358359010.pas"
// Стереотип: "TestCase"
// Элемент модели: "K358359010" MUID: (51A852A001EA)
// Имя типа: "TK358359010"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK358359010 = class(THTMLtoEVDTest)
  {* [Requestlink:358359010] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358359010
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *51A852A001EAimpl_uses*
 //#UC END# *51A852A001EAimpl_uses*
;

function TK358359010.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK358359010.GetFolder

function TK358359010.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51A852A001EA';
end;//TK358359010.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358359010.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
