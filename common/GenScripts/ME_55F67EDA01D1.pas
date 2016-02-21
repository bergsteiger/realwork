unit K606808786;
 {* [Requestlink:606808786] }

// ������: "w:\common\components\rtl\Garant\Daily\K606808786.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606808786 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606808786] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK606808786
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606808786.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK606808786.GetFolder

function TK606808786.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55F67EDA01D1';
end;//TK606808786.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606808786.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
