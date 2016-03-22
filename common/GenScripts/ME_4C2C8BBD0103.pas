unit K217678457;
 {* [RequestLink:217678457] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217678457.pas"
// Стереотип: "TestCase"
// Элемент модели: "K217678457" MUID: (4C2C8BBD0103)
// Имя типа: "TK217678457"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK217678457 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:217678457] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK217678457
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK217678457.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK217678457.GetFolder

function TK217678457.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C2C8BBD0103';
end;//TK217678457.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217678457.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
