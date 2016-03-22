unit K604929290;
 {* [RequestLink:604929290] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K604929290.pas"
// Стереотип: "TestCase"
// Элемент модели: "K604929290" MUID: (55D1ED1E0071)
// Имя типа: "TK604929290"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK604929290 = class(TNSRCtoEVDTest)
  {* [RequestLink:604929290] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK604929290
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK604929290.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DecorText';
end;//TK604929290.GetFolder

function TK604929290.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55D1ED1E0071';
end;//TK604929290.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK604929290.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
