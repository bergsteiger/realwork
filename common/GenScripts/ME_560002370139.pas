unit K607532796;
 {* [RequestLink:607532796] }

// ������: "w:\common\components\rtl\Garant\Daily\K607532796.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK607532796 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:607532796] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK607532796
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607532796.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK607532796.GetFolder

function TK607532796.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '560002370139';
end;//TK607532796.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607532796.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
