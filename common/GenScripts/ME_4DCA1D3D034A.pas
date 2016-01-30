unit HorzMergeCells;
 {* ����������� ����� �� �����������. }

// ������: "w:\common\components\rtl\Garant\Daily\HorzMergeCells.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 THorzMergeCells = {abstract} class(TTableToolsTest)
  {* ����������� ����� �� �����������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* ������� ���������� ��� ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//THorzMergeCells
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
procedure THorzMergeCells.ApplyTools(const aRange: IedRange);
 {* ������� ���������� ��� ������� }
//#UC START# *4C345B580083_4DCA1D3D034A_var*
//#UC END# *4C345B580083_4DCA1D3D034A_var*
begin
//#UC START# *4C345B580083_4DCA1D3D034A_impl*
 aRange.Table.Cells.Merge(ed_maHorz);
//#UC END# *4C345B580083_4DCA1D3D034A_impl*
end;//THorzMergeCells.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function THorzMergeCells.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//THorzMergeCells.GetFolder

function THorzMergeCells.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DCA1D3D034A';
end;//THorzMergeCells.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
