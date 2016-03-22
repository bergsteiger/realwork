unit K598136171_Restore;
 {* [RequestLink:598136171] }

// ������: "w:\common\components\rtl\Garant\Daily\K598136171_Restore.pas"
// ���������: "TestCase"
// ������� ������: "K598136171_Restore" MUID: (561E7FB00077)
// ��� ����: "TK598136171_Restore"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , UnicodeFormulasToUnicodeConverterTest
;

type
 TK598136171_Restore = class(TUnicodeFormulasToUnicodeConverterTest)
  {* [RequestLink:598136171] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK598136171_Restore
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK598136171_Restore.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK598136171_Restore.GetFolder

function TK598136171_Restore.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561E7FB00077';
end;//TK598136171_Restore.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK598136171_Restore.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
