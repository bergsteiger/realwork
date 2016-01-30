unit K216072357;
 {* [RequestLink:216072357] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K216072357.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK216072357 = class(TScrollBackTest)
  {* [RequestLink:216072357] }
  protected
   {$If NOT Defined(NoVCM)}
   function TreatExceptionAsSuccess: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK216072357
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK216072357.TreatExceptionAsSuccess: Boolean;
//#UC START# *4BFD1B5A0200_4BFBDF0E01A4_var*
//#UC END# *4BFD1B5A0200_4BFBDF0E01A4_var*
begin
//#UC START# *4BFD1B5A0200_4BFBDF0E01A4_impl*
 Result := false{true};
//#UC END# *4BFD1B5A0200_4BFBDF0E01A4_impl*
end;//TK216072357.TreatExceptionAsSuccess
{$IfEnd} // NOT Defined(NoVCM)

function TK216072357.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK216072357.GetFolder

function TK216072357.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BFBDF0E01A4';
end;//TK216072357.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK216072357.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
