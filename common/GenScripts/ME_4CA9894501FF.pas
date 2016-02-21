unit K235866053;
 {* [RequestLink:235866053] }

// ������: "w:\common\components\rtl\Garant\Daily\K235866053.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK235866053 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:235866053] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235866053
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235866053.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235866053.GetFolder

function TK235866053.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA9894501FF';
end;//TK235866053.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235866053.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
