unit K235062061;
 {* [RequestLink:235062061] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235062061.pas"
// Стереотип: "TestCase"
// Элемент модели: "K235062061" MUID: (4CA3197900C0)
// Имя типа: "TK235062061"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDwithFormulasToRTFWriterTest
;

type
 TK235062061 = class(TEVDwithFormulasToRTFWriterTest)
  {* [RequestLink:235062061] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235062061
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235062061.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235062061.GetFolder

function TK235062061.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA3197900C0';
end;//TK235062061.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235062061.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
