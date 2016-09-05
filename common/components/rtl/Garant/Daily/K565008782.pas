unit K565008782;
 {* [Requestlink:565008782] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K565008782.pas"
// Стереотип: "TestCase"
// Элемент модели: "K565008782" MUID: (54182CF10045)
// Имя типа: "TK565008782"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK565008782 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:565008782] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK565008782
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *54182CF10045impl_uses*
 //#UC END# *54182CF10045impl_uses*
;

function TK565008782.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK565008782.GetFolder

function TK565008782.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54182CF10045';
end;//TK565008782.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK565008782.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
