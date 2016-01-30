unit K233015524;
 {* [$233015524] }

// ������: "w:\common\components\rtl\Garant\Daily\K233015524.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , SplitTableTest
;

type
 TK233015524 = class(TSplitTableTest)
  {* [$233015524] }
  protected
   function GetLineCount: Integer; override;
    {* ���������� ������� (������), �� ������� ����� ������� ������ ����� ����������� ������� �� ���. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK233015524
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK233015524.GetLineCount: Integer;
 {* ���������� ������� (������), �� ������� ����� ������� ������ ����� ����������� ������� �� ���. }
//#UC START# *4C6CFAE20264_4C6CF445008D_var*
//#UC END# *4C6CFAE20264_4C6CF445008D_var*
begin
//#UC START# *4C6CFAE20264_4C6CF445008D_impl*
 Result := 7;
//#UC END# *4C6CFAE20264_4C6CF445008D_impl*
end;//TK233015524.GetLineCount

function TK233015524.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK233015524.GetFolder

function TK233015524.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C6CF445008D';
end;//TK233015524.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK233015524.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
