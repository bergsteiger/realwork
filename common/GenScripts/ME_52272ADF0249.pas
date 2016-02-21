unit K481450949;
 {* [Requestlink:481450949] }

// ������: "w:\common\components\rtl\Garant\Daily\K481450949.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK481450949 = class(TNSRCtoEVDTest)
  {* [Requestlink:481450949] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK481450949
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK481450949.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.9';
end;//TK481450949.GetFolder

function TK481450949.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '52272ADF0249';
end;//TK481450949.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK481450949.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
