unit K213713115;
 {* [$213713115] }

// ������: "w:\common\components\rtl\Garant\Daily\K213713115.pas"
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
 TK213713115 = class(TPreviewTestBefore235875079)
  {* [$213713115] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK213713115
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK213713115.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK213713115.GetFolder

function TK213713115.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BF25356037B';
end;//TK213713115.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK213713115.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
