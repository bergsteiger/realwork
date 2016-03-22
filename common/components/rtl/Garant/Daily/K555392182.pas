unit K555392182;
 {* [RequestLink:555392182] }

// ������: "w:\common\components\rtl\Garant\Daily\K555392182.pas"
// ���������: "TestCase"
// ������� ������: "K555392182" MUID: (53C50DBD0242)
// ��� ����: "TK555392182"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK555392182 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:555392182] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK555392182
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK555392182.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK555392182.GetFolder

function TK555392182.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53C50DBD0242';
end;//TK555392182.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK555392182.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
