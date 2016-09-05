unit DrawSelectionInTableTest;
 {* ���� ��� �������� ������������ ��������� ��������� � ������� }

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\DrawSelectionInTableTest.pas"
// ���������: "TestCase"
// ������� ������: "TDrawSelectionInTableTest" MUID: (4D6F501303E4)

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(evNeedPainters)}
 , evDelayedPaintersSpy
 {$IfEnd} // Defined(evNeedPainters)
 , Types
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , evCustomEditorWindow
;

type
 _SelectTablePart_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TDrawSelectionInTableTest = {abstract} class(_SelectTablePart_{$If Defined(evNeedPainters)}
 , IevDelayedPainterLogger
 {$IfEnd} // Defined(evNeedPainters)
 )
  {* ���� ��� �������� ������������ ��������� ��������� � ������� }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If Defined(evNeedPainters)}
   function OpenSelectionLog: AnsiString;
   {$IfEnd} // Defined(evNeedPainters)
   {$If Defined(evNeedPainters)}
   procedure CloseSelectionLog(const aLogName: AnsiString);
   {$IfEnd} // Defined(evNeedPainters)
   {$If NOT Defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
    {* ����������� ���� ��� ������, ��� ������� ����� }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function NeedSelection: Boolean; override;
    {* ����� �� ����-������ ��������. }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TDrawSelectionInTableTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4D6F501303E4impl_uses*
 //#UC END# *4D6F501303E4impl_uses*
;

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}

procedure TDrawSelectionInTableTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4D6F501303E4_var*
//#UC END# *4BE419AF0217_4D6F501303E4_var*
begin
//#UC START# *4BE419AF0217_4D6F501303E4_impl*
 MakeSelection(aForm.Text);
 ScrollByWeel(aForm, 10, False);
 TevDelayedPaintersSpy.Instance.SetLogger(Self);
 try
  aForm.Text.Repaint;
 finally
  TevDelayedPaintersSpy.Instance.RemoveLogger(Self);
 end;
//#UC END# *4BE419AF0217_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.DoVisit

{$If Defined(evNeedPainters)}
function TDrawSelectionInTableTest.OpenSelectionLog: AnsiString;
//#UC START# *4D6F66820158_4D6F501303E4_var*
//#UC END# *4D6F66820158_4D6F501303E4_var*
begin
//#UC START# *4D6F66820158_4D6F501303E4_impl*
 Result := FileForOutput;
//#UC END# *4D6F66820158_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.OpenSelectionLog
{$IfEnd} // Defined(evNeedPainters)

{$If Defined(evNeedPainters)}
procedure TDrawSelectionInTableTest.CloseSelectionLog(const aLogName: AnsiString);
//#UC START# *4D6F669C0185_4D6F501303E4_var*
//#UC END# *4D6F669C0185_4D6F501303E4_var*
begin
//#UC START# *4D6F669C0185_4D6F501303E4_impl*
 CheckOutputWithInput(ChangeFileExt(ExtractFileName(aLogName), EtalonSuffix + '.selection'));
//#UC END# *4D6F669C0185_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.CloseSelectionLog
{$IfEnd} // Defined(evNeedPainters)

{$If NOT Defined(NotTunedDUnit)}
function TDrawSelectionInTableTest.FileForOutput: AnsiString;
 {* ����������� ���� ��� ������, ��� ������� ����� }
//#UC START# *4B4F588B0241_4D6F501303E4_var*
//#UC END# *4B4F588B0241_4D6F501303E4_var*
begin
//#UC START# *4B4F588B0241_4D6F501303E4_impl*
 Result := OutputPath + KPage + '.selection'
//#UC END# *4B4F588B0241_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.FileForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TDrawSelectionInTableTest.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4D6F501303E4_var*
//#UC END# *4C07AC6F036D_4D6F501303E4_var*
begin
//#UC START# *4C07AC6F036D_4D6F501303E4_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.GetNormalFontSize

function TDrawSelectionInTableTest.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4D6F501303E4_var*
//#UC END# *4C08CF700318_4D6F501303E4_var*
begin
//#UC START# *4C08CF700318_4D6F501303E4_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.FormExtent

function TDrawSelectionInTableTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TDrawSelectionInTableTest.GetFolder

function TDrawSelectionInTableTest.NeedSelection: Boolean;
 {* ����� �� ����-������ ��������. }
//#UC START# *4CC8189D02DF_4D6F501303E4_var*
//#UC END# *4CC8189D02DF_4D6F501303E4_var*
begin
//#UC START# *4CC8189D02DF_4D6F501303E4_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.NeedSelection

function TDrawSelectionInTableTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D6F501303E4';
end;//TDrawSelectionInTableTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
