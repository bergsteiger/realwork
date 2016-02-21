unit K610951982;
 {* [Requestlink:610951982] }

// ������: "w:\common\components\rtl\Garant\Daily\K610951982.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610951982 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610951982] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK610951982
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK610951982.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK610951982.GetFolder

function TK610951982.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '565D366A0111';
end;//TK610951982.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610951982.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
