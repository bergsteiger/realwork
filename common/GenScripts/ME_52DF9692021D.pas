unit K512248597;
 {* [Requestlink:512248597] }

// ������: "w:\common\components\rtl\Garant\Daily\K512248597.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK512248597 = class(TEVDtoRTFWriterTest)
  {* [Requestlink:512248597] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK512248597
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK512248597.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK512248597.GetFolder

function TK512248597.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '52DF9692021D';
end;//TK512248597.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK512248597.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
