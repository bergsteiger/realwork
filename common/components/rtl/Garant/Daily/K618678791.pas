unit K618678791;
 {* [Requestlink:618678791] }

// ������: "w:\common\components\rtl\Garant\Daily\K618678791.pas"
// ���������: "TestCase"
// ������� ������: "K618678791" MUID: (56D6CE2102FA)
// ��� ����: "TK618678791"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK618678791 = class(THTMLtoEVDFull)
  {* [Requestlink:618678791] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK618678791
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56D6CE2102FAimpl_uses*
 //#UC END# *56D6CE2102FAimpl_uses*
;

function TK618678791.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK618678791.GetFolder

function TK618678791.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56D6CE2102FA';
end;//TK618678791.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK618678791.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
