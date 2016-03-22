unit K601462517;
 {* [Requestlink:601462517] }

// ������: "w:\common\components\rtl\Garant\Daily\K601462517.pas"
// ���������: "TestCase"
// ������� ������: "K601462517" MUID: (559CE7DB02CF)
// ��� ����: "TK601462517"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK601462517 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:601462517] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK601462517
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK601462517.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK601462517.GetFolder

function TK601462517.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '559CE7DB02CF';
end;//TK601462517.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK601462517.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
