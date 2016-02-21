unit K592251812;
 {* [RequestLink:592251812] }

// ������: "w:\common\components\rtl\Garant\Daily\K592251812.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK592251812 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:592251812] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK592251812
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK592251812.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK592251812.GetFolder

function TK592251812.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5512945A0184';
end;//TK592251812.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK592251812.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
