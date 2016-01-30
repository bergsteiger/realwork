unit SelectColumnAndDelete;
 {* ���� ��������� � �������� �������. }

// ������: "w:\common\components\rtl\Garant\Daily\SelectColumnAndDelete.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

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
 TSelectColumnAndDelete = {abstract} class(TTableToolsTest)
  {* ���� ��������� � �������� �������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* ������� ���������� ��� ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NoVCM)}
   procedure CheckOperation(aForm: TPrimTextLoadForm); override;
    {* �������� ����� ���������� �����������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TSelectColumnAndDelete
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevTools
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
procedure TSelectColumnAndDelete.ApplyTools(const aRange: IedRange);
 {* ������� ���������� ��� ������� }
//#UC START# *4C345B580083_4C99945800BC_var*
//#UC END# *4C345B580083_4C99945800BC_var*
begin
//#UC START# *4C345B580083_4C99945800BC_impl*
 aRange.Delete;
//#UC END# *4C345B580083_4C99945800BC_impl*
end;//TSelectColumnAndDelete.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function TSelectColumnAndDelete.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TSelectColumnAndDelete.GetFolder

{$If NOT Defined(NoVCM)}
procedure TSelectColumnAndDelete.CheckOperation(aForm: TPrimTextLoadForm);
 {* �������� ����� ���������� �����������. }
//#UC START# *4C9999C50326_4C99945800BC_var*
var
 l_Leaf: InevLeafPoint;
//#UC END# *4C9999C50326_4C99945800BC_var*
begin
//#UC START# *4C9999C50326_4C99945800BC_impl*
 l_Leaf := aForm.Text.Selection.Cursor.MostInner.AsLeaf;
 Assert(l_Leaf <> nil);
//#UC END# *4C9999C50326_4C99945800BC_impl*
end;//TSelectColumnAndDelete.CheckOperation
{$IfEnd} // NOT Defined(NoVCM)

function TSelectColumnAndDelete.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C99945800BC';
end;//TSelectColumnAndDelete.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
