unit K253662098;
 {* [$253662098] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K253662098.pas"
// Стереотип: "TestCase"
// Элемент модели: "K253662098" MUID: (4D70937501E4)
// Имя типа: "TK253662098"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK253662098 = class(TEVDtoNSRCPlusWriterTest)
  {* [$253662098] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK253662098
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4D70937501E4impl_uses*
 //#UC END# *4D70937501E4impl_uses*
;

function TK253662098.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRC 7.7';
end;//TK253662098.GetFolder

function TK253662098.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D70937501E4';
end;//TK253662098.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK253662098.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
