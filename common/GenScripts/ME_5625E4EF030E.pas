unit K609886857;
 {* [Requestlink:609886857] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K609886857.pas"
// Стереотип: "TestCase"
// Элемент модели: "K609886857" MUID: (5625E4EF030E)
// Имя типа: "TK609886857"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK609886857 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:609886857] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK609886857
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK609886857.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK609886857.GetFolder

function TK609886857.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5625E4EF030E';
end;//TK609886857.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK609886857.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
