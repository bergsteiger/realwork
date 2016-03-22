unit K255966779;
 {* [RequestLink:255966779] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K255966779.pas"
// Стереотип: "TestCase"
// Элемент модели: "K255966779" MUID: (4D909FCA01A2)
// Имя типа: "TK255966779"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDBlockNameAdderTest
;

type
 TK255966779 = class(TEVDtoEVDBlockNameAdderTest)
  {* [RequestLink:255966779] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK255966779
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK255966779.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK255966779.GetFolder

function TK255966779.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D909FCA01A2';
end;//TK255966779.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK255966779.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
