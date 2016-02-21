unit K385025566;
 {* [RequestLink:385025566] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K385025566.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoXMLWiterTest
;

type
 TK385025566 = class(TEVDtoXMLWiterTest)
  {* [RequestLink:385025566] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK385025566
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK385025566.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK385025566.GetFolder

function TK385025566.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5036354101E5';
end;//TK385025566.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK385025566.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
