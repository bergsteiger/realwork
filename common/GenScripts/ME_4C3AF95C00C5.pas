unit K224791621;
 {* [$224791621] }

// ������: "w:\common\components\rtl\Garant\Daily\K224791621.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeTablesTest
 , evEditorInterfaces
;

type
 TK224791621 = class(TMergeTablesTest)
  {* [$224791621] }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* ������� ���������� ��� ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK224791621
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
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
;

{$If NOT Defined(NoVCM)}
procedure TK224791621.ApplyTools(const aRange: IedRange);
 {* ������� ���������� ��� ������� }
//#UC START# *4C345B580083_4C3AF95C00C5_var*
var
 i             : Integer;
 l_Table       : IedTable;
 l_Row         : IedRow;
 l_RowIterator : IedRowsIterator;
 l_OldRowCount : Integer;
//#UC END# *4C345B580083_4C3AF95C00C5_var*
begin
//#UC START# *4C345B580083_4C3AF95C00C5_impl*
 l_Table := aRange.Table;
 l_OldRowCount := l_Table.RowCount;
 inherited ApplyTools(aRange);
 l_RowIterator := l_Table.RowsIterator;
 l_RowIterator.First;
 for i := 0 to l_OldRowCount + 1 do
  l_Row := l_RowIterator.Next;
 CheckTrue(l_Row.CellsIterator.CellsCount = 3, '� ������� ������� ������ ���� �� ��� ������!');
//#UC END# *4C345B580083_4C3AF95C00C5_impl*
end;//TK224791621.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function TK224791621.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK224791621.GetFolder

function TK224791621.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C3AF95C00C5';
end;//TK224791621.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK224791621.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
