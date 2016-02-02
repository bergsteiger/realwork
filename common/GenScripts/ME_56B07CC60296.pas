unit K615931453;
 {* [Requestlink:615931453] }

// ������: "w:\common\components\rtl\Garant\Daily\K615931453.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK615931453 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:615931453] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK615931453
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK615931453.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK615931453.GetFolder

function TK615931453.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56B07CC60296';
end;//TK615931453.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK615931453.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
