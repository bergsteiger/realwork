unit K607284377;
 {* [Requestlink:607284377] }

// ������: "w:\common\components\rtl\Garant\Daily\K607284377.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK607284377 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:607284377] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK607284377
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607284377.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK607284377.GetFolder

function TK607284377.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '560517DB008C';
end;//TK607284377.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607284377.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
