unit K255975907;
 {* [$255975907] }

// ������: "w:\common\components\rtl\Garant\Daily\K255975907.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore278833302
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK255975907 = class(TPreviewTestBefore278833302)
  {* [$255975907] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK255975907
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK255975907.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK255975907.GetFolder

function TK255975907.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D7A25F90063';
end;//TK255975907.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK255975907.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
