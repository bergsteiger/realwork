unit K619732685;
 {* [Requestlink:619732685] }

// ������: "w:\common\components\rtl\Garant\Daily\K619732685.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWithURL
;

type
 TK619732685 = class(TRTFtoEVDWithURL)
  {* [Requestlink:619732685] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619732685
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619732685.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619732685.GetFolder

function TK619732685.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E809720352';
end;//TK619732685.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619732685.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
