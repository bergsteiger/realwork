unit K603416415;
 {* [Requestlink:603416415] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K603416415.pas"
// Стереотип: "TestCase"
// Элемент модели: "K603416415" MUID: (55C48CB403CC)
// Имя типа: "TK603416415"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK603416415 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:603416415] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK603416415
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK603416415.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK603416415.GetFolder

function TK603416415.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55C48CB403CC';
end;//TK603416415.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK603416415.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
