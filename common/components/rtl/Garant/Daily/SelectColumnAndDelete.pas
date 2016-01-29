unit SelectColumnAndDelete;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/SelectColumnAndDelete.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TSelectColumnAndDelete
//
// ���� ��������� � �������� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TableToolsTest
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  ,
  evEditorInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TSelectColumnAndDelete = {abstract} class(TTableToolsTest)
  {* ���� ��������� � �������� �������. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
     {* ������� ���������� ��� ������� }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure CheckOperation(aForm: TPrimTextLoadForm); override;
     {* �������� ����� ���������� �����������. }
   {$IfEnd} //nsTest AND not NoVCM
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TSelectColumnAndDelete
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevTools,
  TestFrameWork,
  evMsgCode,
  evOp
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TSelectColumnAndDelete

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSelectColumnAndDelete.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4C99945800BC_var*
//#UC END# *4C345B580083_4C99945800BC_var*
begin
//#UC START# *4C345B580083_4C99945800BC_impl*
 aRange.Delete;
//#UC END# *4C345B580083_4C99945800BC_impl*
end;//TSelectColumnAndDelete.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

function TSelectColumnAndDelete.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TSelectColumnAndDelete.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSelectColumnAndDelete.CheckOperation(aForm: TPrimTextLoadForm);
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
{$IfEnd} //nsTest AND not NoVCM

function TSelectColumnAndDelete.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C99945800BC';
end;//TSelectColumnAndDelete.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.