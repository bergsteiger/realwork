unit K607532057;
 {* [RequestLink:607532057] }

// ������: "w:\common\components\rtl\Garant\Daily\K607532057.pas"
// ���������: "TestCase"
// ������� ������: "K607532057" MUID: (55FFDDFD0132)
// ��� ����: "TK607532057"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK607532057 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:607532057] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK607532057
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607532057.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK607532057.GetFolder

function TK607532057.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55FFDDFD0132';
end;//TK607532057.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607532057.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
