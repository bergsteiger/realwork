unit PrimScrollTest;

// ������: "w:\common\components\gui\Garant\Daily\PrimScrollTest.pas"
// ���������: "TestCase"
// ������� ������: "TPrimScrollTest" MUID: (4C9899150030)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitor
;

type
 TPrimScrollTest = {abstract} class(TTextEditorVisitor)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   function NotForTerminalSession: Boolean; override;
    {* �� ��������� ���� � ������������ ������ }
 end;//TPrimScrollTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TPrimScrollTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TPrimScrollTest.GetFolder

function TPrimScrollTest.NotForTerminalSession: Boolean;
 {* �� ��������� ���� � ������������ ������ }
//#UC START# *4C988C1B0246_4C9899150030_var*
//#UC END# *4C988C1B0246_4C9899150030_var*
begin
//#UC START# *4C988C1B0246_4C9899150030_impl*
 Result := true;
//#UC END# *4C988C1B0246_4C9899150030_impl*
end;//TPrimScrollTest.NotForTerminalSession

function TPrimScrollTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C9899150030';
end;//TPrimScrollTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
