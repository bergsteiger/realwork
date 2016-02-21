unit K461701432;
 {* [Requestlink:461701432] }

// ������: "w:\common\components\rtl\Garant\Daily\K461701432.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK461701432 = class(TEVDtoEVDWriterTest)
  {* [Requestlink:461701432] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK461701432
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK461701432.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.9';
end;//TK461701432.GetFolder

function TK461701432.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51DA9D410127';
end;//TK461701432.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK461701432.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
