unit K612968853;
 {* [Requestlink:612968853] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K612968853.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK612968853 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:612968853] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK612968853
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK612968853.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK612968853.GetFolder

function TK612968853.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56614EAD032D';
end;//TK612968853.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK612968853.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
