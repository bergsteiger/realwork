unit K604929290;
 {* [RequestLink:604929290] }

// ������: "w:\common\components\rtl\Garant\Daily\K604929290.pas"
// ���������: "TestCase"
// ������� ������: "K604929290" MUID: (55D1ED1E0071)
// ��� ����: "TK604929290"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK604929290 = class(TNSRCtoEVDTest)
  {* [RequestLink:604929290] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK604929290
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK604929290.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'DecorText';
end;//TK604929290.GetFolder

function TK604929290.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55D1ED1E0071';
end;//TK604929290.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK604929290.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
