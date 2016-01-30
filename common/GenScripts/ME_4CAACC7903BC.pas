unit K234360960;
 {* [$234360960] }

// ������: "w:\common\components\rtl\Garant\Daily\K234360960.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , InsertRowTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK234360960 = class(TInsertRowTest)
  {* [$234360960] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK234360960
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK234360960.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK234360960.GetFolder

function TK234360960.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CAACC7903BC';
end;//TK234360960.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK234360960.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
