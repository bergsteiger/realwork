unit K538550943;
 {* [Requestlink:538550943] }

// ������: "w:\common\components\rtl\Garant\Daily\K538550943.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538550943 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538550943] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK538550943
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK538550943.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK538550943.GetFolder

function TK538550943.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '538DA59D02C2';
end;//TK538550943.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538550943.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
