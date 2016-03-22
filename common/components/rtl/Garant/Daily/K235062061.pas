unit K235062061;
 {* [RequestLink:235062061] }

// ������: "w:\common\components\rtl\Garant\Daily\K235062061.pas"
// ���������: "TestCase"
// ������� ������: "K235062061" MUID: (4CA3197900C0)
// ��� ����: "TK235062061"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDwithFormulasToRTFWriterTest
;

type
 TK235062061 = class(TEVDwithFormulasToRTFWriterTest)
  {* [RequestLink:235062061] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235062061
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235062061.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235062061.GetFolder

function TK235062061.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA3197900C0';
end;//TK235062061.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235062061.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
