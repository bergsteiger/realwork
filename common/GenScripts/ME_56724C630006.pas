unit K613540313;
 {* [Requestlink:613540313] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K613540313.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK613540313 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:613540313] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK613540313
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK613540313.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK613540313.GetFolder

function TK613540313.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56724C630006';
end;//TK613540313.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK613540313.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
