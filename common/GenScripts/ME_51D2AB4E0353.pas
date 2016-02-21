unit K466751465;
 {* [Requestlink:466751465] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K466751465.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK466751465 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:466751465] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK466751465
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK466751465.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.9';
end;//TK466751465.GetFolder

function TK466751465.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51D2AB4E0353';
end;//TK466751465.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK466751465.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
