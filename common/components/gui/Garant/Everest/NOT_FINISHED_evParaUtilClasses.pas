unit NOT_FINISHED_evParaUtilClasses;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evParaUtilClasses.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
uses
 l3IntfUses
 , evCustomParaListUtils
 , evEditorInterfaces
 , nevTools
 , evdTypes
 , nevBase
 , k2Interfaces
;

type
 TevTable = class(TevLocationProcessorTagTool, IedTable, IedCells)
  {* ���������� ����������� IedCell � IedCells ��� �������. }
  protected
   function Get_Frame: IedFrame;
   function Merge(aMergeAlg: TedMergeAlgorythm = All): Boolean; overload;
    {* ���������� ������ � ��������� }
   function pm_GetTableRange: IevTableRange;
   function pm_GetTable: IedTable;
   function pm_GetVerticalAligment: TevVerticalAligment;
   procedure pm_SetVerticalAligment(aValue: TevVerticalAligment);
   function InsertRows(NumRows: Integer): Boolean;
    {* �������� NumRows ����� � ������� ����� ������� }
   function Split(const anIndicator: InevProgress): Boolean;
    {* ��������� ������� �� ���, � ������� ����� }
   function Merge(const anIndicator: InevProgress): Boolean; overload;
    {* ���������� ������� �� ��������� }
   function FirstRowID: Integer;
    {* ���������� ����� ������ ���������� ������ }
   function Delete: Boolean;
    {* ������� ������� }
   function RowCount: Integer;
    {* ���������� ���������� ����� � ������� }
   function Get_Cell: IedCell;
   function Get_Cells: IedCells;
   function Get_Column: IedColumn;
   function Get_ColumnsIterator: IedColumnsIterator;
   function pm_GetRowsIterator: IedRowsIterator;
   function pm_GetOldNSRC: Boolean;
   procedure pm_SetOldNSRC(aValue: Boolean);
   procedure Translate2Text;
    {* ����������� �������� ����� � �����. }
   function GetTagCell(aRow: Tl3Variant;
    const aCell: InevPara;
    aTagIndex: LongInt;
    const aLocation: InevLocation;
    anInitNeighbours: Boolean): IedCell;
    {* �������� �� �������� �� ������ evParaUtilClasses �� ������. }
   function GetTag: Tl3Variant;
 end;//TevTable
{$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)

implementation

{$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , IedTableWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

function TevTable.Get_Frame: IedFrame;
//#UC START# *4BBC89F8009C_48E4EBC401E7get_var*
//#UC END# *4BBC89F8009C_48E4EBC401E7get_var*
begin
//#UC START# *4BBC89F8009C_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBC89F8009C_48E4EBC401E7get_impl*
end;//TevTable.Get_Frame

function TevTable.Merge(aMergeAlg: TedMergeAlgorythm = All): Boolean;
 {* ���������� ������ � ��������� }
//#UC START# *4BBC978B0203_48E4EBC401E7_var*
//#UC END# *4BBC978B0203_48E4EBC401E7_var*
begin
//#UC START# *4BBC978B0203_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBC978B0203_48E4EBC401E7_impl*
end;//TevTable.Merge

function TevTable.pm_GetTableRange: IevTableRange;
//#UC START# *4BBC9D99015E_48E4EBC401E7get_var*
//#UC END# *4BBC9D99015E_48E4EBC401E7get_var*
begin
//#UC START# *4BBC9D99015E_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBC9D99015E_48E4EBC401E7get_impl*
end;//TevTable.pm_GetTableRange

function TevTable.pm_GetTable: IedTable;
//#UC START# *4BBC9DB602BA_48E4EBC401E7get_var*
//#UC END# *4BBC9DB602BA_48E4EBC401E7get_var*
begin
//#UC START# *4BBC9DB602BA_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBC9DB602BA_48E4EBC401E7get_impl*
end;//TevTable.pm_GetTable

function TevTable.pm_GetVerticalAligment: TevVerticalAligment;
//#UC START# *4BBC9DEE0322_48E4EBC401E7get_var*
//#UC END# *4BBC9DEE0322_48E4EBC401E7get_var*
begin
//#UC START# *4BBC9DEE0322_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBC9DEE0322_48E4EBC401E7get_impl*
end;//TevTable.pm_GetVerticalAligment

procedure TevTable.pm_SetVerticalAligment(aValue: TevVerticalAligment);
//#UC START# *4BBC9DEE0322_48E4EBC401E7set_var*
//#UC END# *4BBC9DEE0322_48E4EBC401E7set_var*
begin
//#UC START# *4BBC9DEE0322_48E4EBC401E7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBC9DEE0322_48E4EBC401E7set_impl*
end;//TevTable.pm_SetVerticalAligment

function TevTable.InsertRows(NumRows: Integer): Boolean;
 {* �������� NumRows ����� � ������� ����� ������� }
//#UC START# *4BBCAF7B0203_48E4EBC401E7_var*
//#UC END# *4BBCAF7B0203_48E4EBC401E7_var*
begin
//#UC START# *4BBCAF7B0203_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCAF7B0203_48E4EBC401E7_impl*
end;//TevTable.InsertRows

function TevTable.Split(const anIndicator: InevProgress): Boolean;
 {* ��������� ������� �� ���, � ������� ����� }
//#UC START# *4BBCAF9600F1_48E4EBC401E7_var*
//#UC END# *4BBCAF9600F1_48E4EBC401E7_var*
begin
//#UC START# *4BBCAF9600F1_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCAF9600F1_48E4EBC401E7_impl*
end;//TevTable.Split

function TevTable.Merge(const anIndicator: InevProgress): Boolean;
 {* ���������� ������� �� ��������� }
//#UC START# *4BBCAFA802FB_48E4EBC401E7_var*
//#UC END# *4BBCAFA802FB_48E4EBC401E7_var*
begin
//#UC START# *4BBCAFA802FB_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCAFA802FB_48E4EBC401E7_impl*
end;//TevTable.Merge

function TevTable.FirstRowID: Integer;
 {* ���������� ����� ������ ���������� ������ }
//#UC START# *4BBCAFBC0333_48E4EBC401E7_var*
//#UC END# *4BBCAFBC0333_48E4EBC401E7_var*
begin
//#UC START# *4BBCAFBC0333_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCAFBC0333_48E4EBC401E7_impl*
end;//TevTable.FirstRowID

function TevTable.Delete: Boolean;
 {* ������� ������� }
//#UC START# *4BBCAFD10171_48E4EBC401E7_var*
//#UC END# *4BBCAFD10171_48E4EBC401E7_var*
begin
//#UC START# *4BBCAFD10171_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCAFD10171_48E4EBC401E7_impl*
end;//TevTable.Delete

function TevTable.RowCount: Integer;
 {* ���������� ���������� ����� � ������� }
//#UC START# *4BBCAFFE0032_48E4EBC401E7_var*
//#UC END# *4BBCAFFE0032_48E4EBC401E7_var*
begin
//#UC START# *4BBCAFFE0032_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCAFFE0032_48E4EBC401E7_impl*
end;//TevTable.RowCount

function TevTable.Get_Cell: IedCell;
//#UC START# *4BBCB0470309_48E4EBC401E7get_var*
//#UC END# *4BBCB0470309_48E4EBC401E7get_var*
begin
//#UC START# *4BBCB0470309_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCB0470309_48E4EBC401E7get_impl*
end;//TevTable.Get_Cell

function TevTable.Get_Cells: IedCells;
//#UC START# *4BBCB05B0293_48E4EBC401E7get_var*
//#UC END# *4BBCB05B0293_48E4EBC401E7get_var*
begin
//#UC START# *4BBCB05B0293_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCB05B0293_48E4EBC401E7get_impl*
end;//TevTable.Get_Cells

function TevTable.Get_Column: IedColumn;
//#UC START# *4BBCB07702A8_48E4EBC401E7get_var*
//#UC END# *4BBCB07702A8_48E4EBC401E7get_var*
begin
//#UC START# *4BBCB07702A8_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCB07702A8_48E4EBC401E7get_impl*
end;//TevTable.Get_Column

function TevTable.Get_ColumnsIterator: IedColumnsIterator;
//#UC START# *4BBCB0890007_48E4EBC401E7get_var*
//#UC END# *4BBCB0890007_48E4EBC401E7get_var*
begin
//#UC START# *4BBCB0890007_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCB0890007_48E4EBC401E7get_impl*
end;//TevTable.Get_ColumnsIterator

function TevTable.pm_GetRowsIterator: IedRowsIterator;
//#UC START# *4BBCB0A0014A_48E4EBC401E7get_var*
//#UC END# *4BBCB0A0014A_48E4EBC401E7get_var*
begin
//#UC START# *4BBCB0A0014A_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCB0A0014A_48E4EBC401E7get_impl*
end;//TevTable.pm_GetRowsIterator

function TevTable.pm_GetOldNSRC: Boolean;
//#UC START# *4BBCB0BE004E_48E4EBC401E7get_var*
//#UC END# *4BBCB0BE004E_48E4EBC401E7get_var*
begin
//#UC START# *4BBCB0BE004E_48E4EBC401E7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCB0BE004E_48E4EBC401E7get_impl*
end;//TevTable.pm_GetOldNSRC

procedure TevTable.pm_SetOldNSRC(aValue: Boolean);
//#UC START# *4BBCB0BE004E_48E4EBC401E7set_var*
//#UC END# *4BBCB0BE004E_48E4EBC401E7set_var*
begin
//#UC START# *4BBCB0BE004E_48E4EBC401E7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBCB0BE004E_48E4EBC401E7set_impl*
end;//TevTable.pm_SetOldNSRC

procedure TevTable.Translate2Text;
 {* ����������� �������� ����� � �����. }
//#UC START# *4BFCC6860038_48E4EBC401E7_var*
//#UC END# *4BFCC6860038_48E4EBC401E7_var*
begin
//#UC START# *4BFCC6860038_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BFCC6860038_48E4EBC401E7_impl*
end;//TevTable.Translate2Text

function TevTable.GetTagCell(aRow: Tl3Variant;
 const aCell: InevPara;
 aTagIndex: LongInt;
 const aLocation: InevLocation;
 anInitNeighbours: Boolean): IedCell;
 {* �������� �� �������� �� ������ evParaUtilClasses �� ������. }
//#UC START# *4FC49AA30122_48E4EBC401E7_var*
//#UC END# *4FC49AA30122_48E4EBC401E7_var*
begin
//#UC START# *4FC49AA30122_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FC49AA30122_48E4EBC401E7_impl*
end;//TevTable.GetTagCell

function TevTable.GetTag: Tl3Variant;
//#UC START# *50DD7CA901AD_48E4EBC401E7_var*
//#UC END# *50DD7CA901AD_48E4EBC401E7_var*
begin
//#UC START# *50DD7CA901AD_48E4EBC401E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *50DD7CA901AD_48E4EBC401E7_impl*
end;//TevTable.GetTag
{$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)

end.
