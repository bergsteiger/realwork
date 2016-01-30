unit K610745778;
 {* [Requestlink:610745778] }

// ������: "w:\common\components\rtl\Garant\Daily\K610745778.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610745778 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610745778] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK610745778
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK610745778.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK610745778.GetFolder

function TK610745778.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '563C60760314';
end;//TK610745778.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610745778.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
