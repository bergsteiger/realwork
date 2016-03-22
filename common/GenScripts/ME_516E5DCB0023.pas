unit K288786476;
 {* [Requestlink:288786476] }

// ������: "w:\common\components\rtl\Garant\Daily\K288786476.pas"
// ���������: "TestCase"
// ������� ������: "K288786476" MUID: (516E5DCB0023)
// ��� ����: "TK288786476"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK288786476 = class(THTMLtoEVDTest)
  {* [Requestlink:288786476] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK288786476
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK288786476.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK288786476.GetFolder

function TK288786476.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '516E5DCB0023';
end;//TK288786476.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK288786476.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
