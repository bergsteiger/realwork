unit K619338871;
 {* [Requestlink:619338871] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619338871.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK619338871 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:619338871] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619338871
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619338871.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK619338871.GetFolder

function TK619338871.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E010DE0110';
end;//TK619338871.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619338871.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
