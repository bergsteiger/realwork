unit K253659671;
 {* [$253659671] }

// ������: "w:\common\components\rtl\Garant\Daily\K253659671.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ShowBaseSearchTest
;

type
 TK253659671 = class(TShowBaseSearchTest)
  {* [$253659671] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK253659671
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK253659671.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK253659671.GetFolder

function TK253659671.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D6CBB42030B';
end;//TK253659671.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK253659671.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
