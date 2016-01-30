unit K237503768;
 {* [$237503768] }

// ������: "w:\common\components\rtl\Garant\Daily\K237503768.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeAndCheck
;

type
 TK237503768 = class(TMergeAndCheck)
  {* [$237503768] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK237503768
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK237503768.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK237503768.GetFolder

function TK237503768.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CC81E5E03C9';
end;//TK237503768.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK237503768.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
