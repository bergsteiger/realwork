unit K616562811;
 {* Тест на чтение приватных полей из RTF (полей, которые не должны отображаться). }

// Модуль: "w:\common\components\rtl\Garant\Daily\K616562811.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK616562811 = class(TRTFtoEVDWriterTest)
  {* Тест на чтение приватных полей из RTF (полей, которые не должны отображаться). }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK616562811
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK616562811.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK616562811.GetFolder

function TK616562811.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56AB2BA20338';
end;//TK616562811.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK616562811.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
