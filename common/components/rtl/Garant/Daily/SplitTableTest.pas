unit SplitTableTest;
 {* ����� ��������� ������ }

// ������: "w:\common\components\rtl\Garant\Daily\SplitTableTest.pas"
// ���������: "TestCase"
// ������� ������: "TSplitTableTest" MUID: (4C6CF18001AE)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _CursorMover_Parent_ = TTableToolsTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TSplitTableTest = {abstract} class(_CursorMover_)
  {* ����� ��������� ������ }
  protected
   function GetLineCount: Integer; virtual;
    {* ���������� ������� (������), �� ������� ����� ������� ������ ����� ����������� ������� �� ���. }
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* ������� ���������� ��� ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function NeedSelection: Boolean; override;
    {* ����� �� ����-������ ��������. }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TSplitTableTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evMsgCode
 , evOp
 , TestFrameWork
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4C6CF18001AEimpl_uses*
 //#UC END# *4C6CF18001AEimpl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

function TSplitTableTest.GetLineCount: Integer;
 {* ���������� ������� (������), �� ������� ����� ������� ������ ����� ����������� ������� �� ���. }
//#UC START# *4C6CFAE20264_4C6CF18001AE_var*
//#UC END# *4C6CFAE20264_4C6CF18001AE_var*
begin
//#UC START# *4C6CFAE20264_4C6CF18001AE_impl*
 Result := 0;
//#UC END# *4C6CFAE20264_4C6CF18001AE_impl*
end;//TSplitTableTest.GetLineCount

{$If NOT Defined(NoVCM)}
procedure TSplitTableTest.ApplyTools(const aRange: IedRange);
 {* ������� ���������� ��� ������� }
//#UC START# *4C345B580083_4C6CF18001AE_var*
//#UC END# *4C345B580083_4C6CF18001AE_var*
begin
//#UC START# *4C345B580083_4C6CF18001AE_impl*
 aRange.Table.Split(nil);
//#UC END# *4C345B580083_4C6CF18001AE_impl*
end;//TSplitTableTest.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TSplitTableTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4C6CF18001AE_var*
var
 i: Integer;
//#UC END# *4BE419AF0217_4C6CF18001AE_var*
begin
//#UC START# *4BE419AF0217_4C6CF18001AE_impl*
 aForm.Text.Repaint;
 for i := 0 to GetLineCount - 1 do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
 inherited DoVisit(aForm);
//#UC END# *4BE419AF0217_4C6CF18001AE_impl*
end;//TSplitTableTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TSplitTableTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TSplitTableTest.GetFolder

function TSplitTableTest.NeedSelection: Boolean;
 {* ����� �� ����-������ ��������. }
//#UC START# *4CC8189D02DF_4C6CF18001AE_var*
//#UC END# *4CC8189D02DF_4C6CF18001AE_var*
begin
//#UC START# *4CC8189D02DF_4C6CF18001AE_impl*
 Result := False;
//#UC END# *4CC8189D02DF_4C6CF18001AE_impl*
end;//TSplitTableTest.NeedSelection

function TSplitTableTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C6CF18001AE';
end;//TSplitTableTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
