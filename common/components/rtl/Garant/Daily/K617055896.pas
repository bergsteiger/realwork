unit K617055896;
 {* [Requestlink:617055896] - ��������� ������� �������� � ������ � ������� �������. }

// ������: "w:\common\components\rtl\Garant\Daily\K617055896.pas"
// ���������: "TestCase"
// ������� ������: "K617055896" MUID: (56B1AE9A00C6)
// ��� ����: "TK617055896"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK617055896 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:617055896] - ��������� ������� �������� � ������ � ������� �������. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK617055896
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56B1AE9A00C6impl_uses*
 //#UC END# *56B1AE9A00C6impl_uses*
;

function TK617055896.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK617055896.GetFolder

function TK617055896.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56B1AE9A00C6';
end;//TK617055896.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK617055896.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
