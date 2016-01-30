unit K607532072;
 {* [Requestlink:607532072] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K607532072.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK607532072 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:607532072] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK607532072
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607532072.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK607532072.GetFolder

function TK607532072.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '560159FF0323';
end;//TK607532072.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607532072.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
