unit K509706011;
 {* [RequestLink:509706011] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K509706011.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFRender
;

type
 TK509706011 = class(TEVDtoRTFRender)
  {* [RequestLink:509706011] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK509706011
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK509706011.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK509706011.GetFolder

function TK509706011.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '52BABA7D0004';
end;//TK509706011.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK509706011.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
