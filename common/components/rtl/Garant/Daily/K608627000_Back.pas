unit K608627000_Back;
 {* [RequestLink:608627000] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K608627000_Back.pas"
// Стереотип: "TestCase"
// Элемент модели: "K608627000_Back" MUID: (561E75BA011D)
// Имя типа: "TK608627000_Back"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK608627000_Back = class(TNSRCtoEVDTest)
  {* [RequestLink:608627000] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK608627000_Back
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561E75BA011Dimpl_uses*
 //#UC END# *561E75BA011Dimpl_uses*
;

function TK608627000_Back.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK608627000_Back.GetFolder

function TK608627000_Back.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561E75BA011D';
end;//TK608627000_Back.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK608627000_Back.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
