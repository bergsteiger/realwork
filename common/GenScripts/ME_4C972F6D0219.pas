unit K235053014;
 {* [RequestLink:235053014]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235053014.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK235053014 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:235053014]. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235053014
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235053014.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235053014.GetFolder

function TK235053014.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C972F6D0219';
end;//TK235053014.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235053014.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
