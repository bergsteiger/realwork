unit NSRCtoEVDTest;
 {* Тест преобразования NSRC в EVD }

// Модуль: "w:\common\components\rtl\Garant\Daily\NSRCtoEVDTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TNSRCtoEVDTest = {abstract} class(TNSRCWriterTest)
  {* Тест преобразования NSRC в EVD }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TNSRCtoEVDTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TNSRCtoEVDTest.DoIt;
//#UC START# *4BED4080012C_4BED405E0256_var*
//#UC END# *4BED4080012C_4BED405E0256_var*
begin
//#UC START# *4BED4080012C_4BED405E0256_impl*
 NSRCtoEVD(KPage + '.nsr');
//#UC END# *4BED4080012C_4BED405E0256_impl*
end;//TNSRCtoEVDTest.DoIt

function TNSRCtoEVDTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TNSRCtoEVDTest.GetFolder

function TNSRCtoEVDTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BED405E0256';
end;//TNSRCtoEVDTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
