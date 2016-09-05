unit K607531290_Back;
 {* [RequestLink:607531290] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K607531290_Back.pas"
// Стереотип: "TestCase"
// Элемент модели: "K607531290_Back" MUID: (561E75CD03A7)
// Имя типа: "TK607531290_Back"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK607531290_Back = class(TNSRCtoEVDTest)
  {* [RequestLink:607531290] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK607531290_Back
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561E75CD03A7impl_uses*
 //#UC END# *561E75CD03A7impl_uses*
;

function TK607531290_Back.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK607531290_Back.GetFolder

function TK607531290_Back.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561E75CD03A7';
end;//TK607531290_Back.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607531290_Back.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
