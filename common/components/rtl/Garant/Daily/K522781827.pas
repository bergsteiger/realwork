unit K522781827;
 {* [Requestlink:522781827] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K522781827.pas"
// Стереотип: "TestCase"
// Элемент модели: "K522781827" MUID: (54CA36DF0147)
// Имя типа: "TK522781827"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK522781827 = class(THTMLtoEVDTest)
  {* [Requestlink:522781827] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK522781827
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *54CA36DF0147impl_uses*
 //#UC END# *54CA36DF0147impl_uses*
;

function TK522781827.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK522781827.GetFolder

function TK522781827.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54CA36DF0147';
end;//TK522781827.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK522781827.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
