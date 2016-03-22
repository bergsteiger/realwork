unit K602943932;
 {* [Requestlink:602943932] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K602943932.pas"
// Стереотип: "TestCase"
// Элемент модели: "K602943932" MUID: (55951C9902B1)
// Имя типа: "TK602943932"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK602943932 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:602943932] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK602943932
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK602943932.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK602943932.GetFolder

function TK602943932.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55951C9902B1';
end;//TK602943932.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK602943932.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
