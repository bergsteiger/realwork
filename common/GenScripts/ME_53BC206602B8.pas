unit K553427493_notBad;
 {* [RequestLink:553427493] }

// ������: "w:\common\components\rtl\Garant\Daily\K553427493_notBad.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BadEVDTest
;

type
 TK553427493_notBad = class(TBadEVDTest)
  {* [RequestLink:553427493] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK553427493_notBad
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK553427493_notBad.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BadEVD';
end;//TK553427493_notBad.GetFolder

function TK553427493_notBad.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53BC206602B8';
end;//TK553427493_notBad.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK553427493_notBad.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
