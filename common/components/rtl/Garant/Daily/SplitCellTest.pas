unit SplitCellTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/SplitCellTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TSplitCellTest
//
// ���� ���������� �����
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
 _CursorMover_Parent_ = TTableToolsTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TSplitCellTest = {abstract} class(_CursorMover_)
  {* ���� ���������� ����� }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
     {* ������� ���������� ��� ������� }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* ���������� ����� }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function NeedSelection: Boolean; override;
     {* ����� �� ����-������ ��������. }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 protected
 // protected methods
   function GetLineCount: Integer; virtual;
   function GetTabCount: Integer; virtual;
 end;//TSplitCellTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
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

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

// start class TSplitCellTest

function TSplitCellTest.GetLineCount: Integer;
//#UC START# *4D5A6EE600D3_4D5A63ED011A_var*
//#UC END# *4D5A6EE600D3_4D5A63ED011A_var*
begin
//#UC START# *4D5A6EE600D3_4D5A63ED011A_impl*
 Result := 0;
//#UC END# *4D5A6EE600D3_4D5A63ED011A_impl*
end;//TSplitCellTest.GetLineCount

function TSplitCellTest.GetTabCount: Integer;
//#UC START# *4D5A6F4802CB_4D5A63ED011A_var*
//#UC END# *4D5A6F4802CB_4D5A63ED011A_var*
begin
//#UC START# *4D5A6F4802CB_4D5A63ED011A_impl*
 Result := 0;
//#UC END# *4D5A6F4802CB_4D5A63ED011A_impl*
end;//TSplitCellTest.GetTabCount

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSplitCellTest.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4D5A63ED011A_var*
//#UC END# *4C345B580083_4D5A63ED011A_var*
begin
//#UC START# *4C345B580083_4D5A63ED011A_impl*
 aRange.Table.Cell.Split(1, 2);
//#UC END# *4C345B580083_4D5A63ED011A_impl*
end;//TSplitCellTest.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSplitCellTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4D5A63ED011A_var*
var
 i : Integer;
//#UC END# *4BE419AF0217_4D5A63ED011A_var*
begin
//#UC START# *4BE419AF0217_4D5A63ED011A_impl*
 for i := 0 to GetLineCount do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
 for i := 0 to GetTabCount do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocColumnRight);
 inherited DoVisit(aForm);
//#UC END# *4BE419AF0217_4D5A63ED011A_impl*
end;//TSplitCellTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TSplitCellTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TSplitCellTest.GetFolder

function TSplitCellTest.NeedSelection: Boolean;
//#UC START# *4CC8189D02DF_4D5A63ED011A_var*
//#UC END# *4CC8189D02DF_4D5A63ED011A_var*
begin
//#UC START# *4CC8189D02DF_4D5A63ED011A_impl*
 Result := False;
//#UC END# *4CC8189D02DF_4D5A63ED011A_impl*
end;//TSplitCellTest.NeedSelection

function TSplitCellTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D5A63ED011A';
end;//TSplitCellTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.