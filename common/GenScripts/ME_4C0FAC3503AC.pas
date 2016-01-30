unit K217686256;
 {* [RequestLink:217686256] }

// ������: "w:\common\components\rtl\Garant\Daily\K217686256.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK217686256 = class(TPreviewTestBefore235875079)
  {* [RequestLink:217686256] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217686256
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK217686256.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK217686256.GetFolder

function TK217686256.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C0FAC3503AC';
end;//TK217686256.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217686256.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
