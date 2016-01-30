unit K247300520;
 {* [RequestLink:247300520] }

// ������: "w:\common\components\rtl\Garant\Daily\K247300520.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoBlockTest
;

type
 TK247300520 = class(TAutoBlockTest)
  {* [RequestLink:247300520] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK247300520
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK247300520.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK247300520.GetFolder

function TK247300520.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D08F3E3023E';
end;//TK247300520.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK247300520.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
