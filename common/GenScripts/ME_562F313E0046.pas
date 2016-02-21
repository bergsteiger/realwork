unit K607284891;
 {* [Requestlink:607284891] }

// ������: "w:\common\components\rtl\Garant\Daily\K607284891.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK607284891 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:607284891] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK607284891
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607284891.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK607284891.GetFolder

function TK607284891.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '562F313E0046';
end;//TK607284891.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607284891.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
