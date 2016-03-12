unit NSRCtoNSRCTest;
 {* Тест преобразования NSRC в NSRC }

// Модуль: "w:\common\components\rtl\Garant\Daily\NSRCtoNSRCTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TNSRCtoNSRCTest = {abstract} class(TNSRCWriterTest)
  {* Тест преобразования NSRC в NSRC }
  protected
   function IsPlus: Boolean; virtual;
    {* NSRC+? }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TNSRCtoNSRCTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TNSRCtoNSRCTest.DoIt;
//#UC START# *4CE67DDC011B_4CE67D90013B_var*
//#UC END# *4CE67DDC011B_4CE67D90013B_var*
begin
//#UC START# *4CE67DDC011B_4CE67D90013B_impl*
 NSRCtoNSRC(KPage + '.nsr', IsPlus);
//#UC END# *4CE67DDC011B_4CE67D90013B_impl*
end;//TNSRCtoNSRCTest.DoIt

function TNSRCtoNSRCTest.IsPlus: Boolean;
 {* NSRC+? }
//#UC START# *4CE67DED0192_4CE67D90013B_var*
//#UC END# *4CE67DED0192_4CE67D90013B_var*
begin
//#UC START# *4CE67DED0192_4CE67D90013B_impl*
 Result := true;
//#UC END# *4CE67DED0192_4CE67D90013B_impl*
end;//TNSRCtoNSRCTest.IsPlus

function TNSRCtoNSRCTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TNSRCtoNSRCTest.GetFolder

function TNSRCtoNSRCTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CE67D90013B';
end;//TNSRCtoNSRCTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
