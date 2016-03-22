unit K538546220;
 {* [Requestlink:538546220] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K538546220.pas"
// Стереотип: "TestCase"
// Элемент модели: "K538546220" MUID: (5386E06A0209)
// Имя типа: "TK538546220"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538546220 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538546220] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK538546220
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK538546220.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK538546220.GetFolder

function TK538546220.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5386E06A0209';
end;//TK538546220.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538546220.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
