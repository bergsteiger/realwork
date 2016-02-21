unit K538561126;
 {* [Requestlink:538561126] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K538561126.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538561126 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538561126] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK538561126
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK538561126.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK538561126.GetFolder

function TK538561126.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5387094A0118';
end;//TK538561126.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538561126.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
