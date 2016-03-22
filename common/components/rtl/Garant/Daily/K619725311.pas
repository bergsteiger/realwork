unit K619725311;
 {* [Requestlink:619725311] }

// ������: "w:\common\components\rtl\Garant\Daily\K619725311.pas"
// ���������: "TestCase"
// ������� ������: "K619725311" MUID: (56E809B1018D)
// ��� ����: "TK619725311"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK619725311 = class(THTMLtoEVDFull)
  {* [Requestlink:619725311] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619725311
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619725311.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619725311.GetFolder

function TK619725311.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E809B1018D';
end;//TK619725311.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619725311.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
