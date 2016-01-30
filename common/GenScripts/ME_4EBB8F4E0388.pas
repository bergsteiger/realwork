unit K297705917;
 {* [RequestLink:297705917] }

// ������: "w:\common\components\rtl\Garant\Daily\K297705917.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AllChildreCountTest
;

type
 TK297705917 = class(TAllChildreCountTest)
  {* [RequestLink:297705917] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK297705917
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK297705917.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK297705917.GetFolder

function TK297705917.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EBB8F4E0388';
end;//TK297705917.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK297705917.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
