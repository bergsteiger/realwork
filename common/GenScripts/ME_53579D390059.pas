unit K531957202;
 {* [Requestlink:531957202] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K531957202.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK531957202 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:531957202] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK531957202
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK531957202.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK531957202.GetFolder

function TK531957202.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53579D390059';
end;//TK531957202.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK531957202.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
