unit K609602166;
 {* [Requestlink:609602166] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K609602166.pas"
// Стереотип: "TestCase"
// Элемент модели: "K609602166" MUID: (5625E50C0063)
// Имя типа: "TK609602166"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK609602166 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:609602166] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK609602166
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK609602166.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK609602166.GetFolder

function TK609602166.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5625E50C0063';
end;//TK609602166.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK609602166.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
