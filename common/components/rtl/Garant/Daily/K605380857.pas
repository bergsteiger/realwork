unit K605380857;
 {* [Reqeuestlink:605380857] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K605380857.pas"
// Стереотип: "TestCase"
// Элемент модели: "K605380857" MUID: (55D19080015C)
// Имя типа: "TK605380857"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK605380857 = class(TRTFtoEVDWriterTest)
  {* [Reqeuestlink:605380857] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK605380857
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK605380857.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK605380857.GetFolder

function TK605380857.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55D19080015C';
end;//TK605380857.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK605380857.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
