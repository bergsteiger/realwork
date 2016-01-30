unit K235052965;
 {* [$235052965] }

// ������: "w:\common\components\rtl\Garant\Daily\K235052965.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , SelectColumnAndDelete
;

type
 TK235052965 = class(TSelectColumnAndDelete)
  {* [$235052965] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function SelectColumn(var aColID: Integer): Boolean; override;
    {* �������� ������� aColID }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235052965
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235052965.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235052965.GetFolder

function TK235052965.SelectColumn(var aColID: Integer): Boolean;
 {* �������� ������� aColID }
//#UC START# *4C9874060367_4C99A80900C4_var*
//#UC END# *4C9874060367_4C99A80900C4_var*
begin
//#UC START# *4C9874060367_4C99A80900C4_impl*
 Result := True;
 aColID := 2;
//#UC END# *4C9874060367_4C99A80900C4_impl*
end;//TK235052965.SelectColumn

function TK235052965.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C99A80900C4';
end;//TK235052965.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235052965.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
