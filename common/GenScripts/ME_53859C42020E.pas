unit K537973036;
 {* [Requestlink:537973036] }

// ������: "w:\common\components\rtl\Garant\Daily\K537973036.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537973036 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537973036] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK537973036
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK537973036.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK537973036.GetFolder

function TK537973036.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53859C42020E';
end;//TK537973036.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537973036.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
