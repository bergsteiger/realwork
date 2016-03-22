unit K607750753;
 {* [Requestlink:607750753] }

// ������: "w:\common\components\rtl\Garant\Daily\K607750753.pas"
// ���������: "TestCase"
// ������� ������: "K607750753" MUID: (56038F3C001E)
// ��� ����: "TK607750753"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK607750753 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:607750753] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK607750753
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607750753.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK607750753.GetFolder

function TK607750753.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56038F3C001E';
end;//TK607750753.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607750753.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
