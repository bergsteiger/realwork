unit K553427493;
 {* [RequestLink:553427493] }

// ������: "w:\common\components\rtl\Garant\Daily\K553427493.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BadEVDTest
;

type
 TK553427493 = class(TBadEVDTest)
  {* [RequestLink:553427493] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK553427493
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK553427493.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BadEVD';
end;//TK553427493.GetFolder

function TK553427493.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53BC205D036D';
end;//TK553427493.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK553427493.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
