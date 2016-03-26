unit K245206060;
 {* [RequestLink:245206060] }

// ������: "w:\common\components\rtl\Garant\Daily\K245206060.pas"
// ���������: "TestCase"
// ������� ������: "K245206060" MUID: (4CFCACFE0085)
// ��� ����: "TK245206060"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoNSRCTest
;

type
 TK245206060 = class(TNSRCtoNSRCTest)
  {* [RequestLink:245206060] }
  protected
   function IsPlus: Boolean; override;
    {* NSRC+? }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK245206060
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK245206060.IsPlus: Boolean;
 {* NSRC+? }
//#UC START# *4CE67DED0192_4CFCACFE0085_var*
//#UC END# *4CE67DED0192_4CFCACFE0085_var*
begin
//#UC START# *4CE67DED0192_4CFCACFE0085_impl*
 Result := false;
//#UC END# *4CE67DED0192_4CFCACFE0085_impl*
end;//TK245206060.IsPlus

function TK245206060.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRC 7.6';
end;//TK245206060.GetFolder

function TK245206060.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CFCACFE0085';
end;//TK245206060.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK245206060.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
