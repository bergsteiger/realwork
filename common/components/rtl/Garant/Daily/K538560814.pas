unit K538560814;
 {* [Requestlink:538560814] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K538560814.pas"
// Стереотип: "TestCase"
// Элемент модели: "K538560814" MUID: (53881E4003E3)
// Имя типа: "TK538560814"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538560814 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538560814] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK538560814
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *53881E4003E3impl_uses*
 //#UC END# *53881E4003E3impl_uses*
;

function TK538560814.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK538560814.GetFolder

function TK538560814.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53881E4003E3';
end;//TK538560814.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538560814.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
