unit NSRCtoNSRCTest;
 {* ���� �������������� NSRC � NSRC }

// ������: "w:\common\components\rtl\Garant\Daily\NSRCtoNSRCTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TNSRCtoNSRCTest = {abstract} class(TNSRCWriterTest)
  {* ���� �������������� NSRC � NSRC }
  protected
   function IsPlus: Boolean; virtual;
    {* NSRC+? }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
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
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TNSRCtoNSRCTest.GetFolder

function TNSRCtoNSRCTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CE67D90013B';
end;//TNSRCtoNSRCTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
