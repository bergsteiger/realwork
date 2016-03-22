unit K603416415;
 {* [Requestlink:603416415] }

// ������: "w:\common\components\rtl\Garant\Daily\K603416415.pas"
// ���������: "TestCase"
// ������� ������: "K603416415" MUID: (55C48CB403CC)
// ��� ����: "TK603416415"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK603416415 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:603416415] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK603416415
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK603416415.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK603416415.GetFolder

function TK603416415.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55C48CB403CC';
end;//TK603416415.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK603416415.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
