unit htTabledQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "HT"
// ������: "w:/common/components/rtl/Garant/HT/htTabledQuery.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::HT::Provider::ThtTabledQuery
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\HT\htDefineDA.inc}

interface

uses
  daInterfaces,
  htInterfaces,
  daTabledQuery
  ;

type
 ThtTabledQuery = class(TdaTabledQuery)
 private
 // private fields
   f_Helper : IhtDataSchemeHelper;
 private
 // private methods
   function FindTable(const anAlias: AnsiString): IhtFromTable;
 protected
 // realized methods
   function MakeFromTable(const aTable: IdaTableDescription;
     const anAlias: AnsiString = ''): IdaFromTable; override;
   procedure PrepareTable; override;
     {* ��������� ������ PrepareTable }
   procedure UnPrepareTable; override;
     {* ��������� ������ UnPrepareTable }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   function MakeResultSet(Unidirectional: Boolean): IdaResultSet; override;
 public
 // public methods
   constructor Create(const aDataConverter: IhtDataConverter;
     const aHelper: IhtDataSchemeHelper;
     const aTable: IdaTableDescription;
     const anAlias: AnsiString = ''); reintroduce;
   class function Make(const aDataConverter: IhtDataConverter;
     const aHelper: IhtDataSchemeHelper;
     const aTable: IdaTableDescription;
     const anAlias: AnsiString = ''): IdaTabledQuery; reintroduce;
     {* ��������� ������� ThtTabledQuery.Make }
 end;//ThtTabledQuery

implementation

uses
  htFromTable,
  daTypes
  {$If not defined(Nemesis)}
  ,
  HT_Const
  {$IfEnd} //not Nemesis
  ,
  htResultSet,
  l3Base
  {$If not defined(Nemesis)}
  ,
  HT_DLL
  {$IfEnd} //not Nemesis
  ,
  SysUtils
  ;

// start class ThtTabledQuery

function ThtTabledQuery.FindTable(const anAlias: AnsiString): IhtFromTable;
//#UC START# *555CA4CC00D6_5551AB1602F4_var*
var
 l_IDX: Integer;
//#UC END# *555CA4CC00D6_5551AB1602F4_var*
begin
//#UC START# *555CA4CC00D6_5551AB1602F4_impl*
 if AnsiSameText(anAlias, Table.TableAlias) then
  Result := Table as IhtFromTable
 else
  Result := nil;
//#UC END# *555CA4CC00D6_5551AB1602F4_impl*
end;//ThtTabledQuery.FindTable

constructor ThtTabledQuery.Create(const aDataConverter: IhtDataConverter;
  const aHelper: IhtDataSchemeHelper;
  const aTable: IdaTableDescription;
  const anAlias: AnsiString = '');
//#UC START# *5551AB780328_5551AB1602F4_var*
//#UC END# *5551AB780328_5551AB1602F4_var*
begin
//#UC START# *5551AB780328_5551AB1602F4_impl*
 inherited Create(aDataConverter, aTable, anAlias);
 f_Helper := aHelper;
//#UC END# *5551AB780328_5551AB1602F4_impl*
end;//ThtTabledQuery.Create

class function ThtTabledQuery.Make(const aDataConverter: IhtDataConverter;
  const aHelper: IhtDataSchemeHelper;
  const aTable: IdaTableDescription;
  const anAlias: AnsiString = ''): IdaTabledQuery;
var
 l_Inst : ThtTabledQuery;
begin
 l_Inst := Create(aDataConverter, aHelper, aTable, anAlias);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function ThtTabledQuery.MakeFromTable(const aTable: IdaTableDescription;
  const anAlias: AnsiString = ''): IdaFromTable;
//#UC START# *5600FFF80332_5551AB1602F4_var*
//#UC END# *5600FFF80332_5551AB1602F4_var*
begin
//#UC START# *5600FFF80332_5551AB1602F4_impl*
 Result := ThtFromTable.Make(aTable, anAlias);
//#UC END# *5600FFF80332_5551AB1602F4_impl*
end;//ThtTabledQuery.MakeFromTable

procedure ThtTabledQuery.PrepareTable;
//#UC START# *566A892A0191_5551AB1602F4_var*
var
 l_Table: IhtFromTable;
 l_Set: TdaTablesSet;
//#UC END# *566A892A0191_5551AB1602F4_var*
begin
//#UC START# *566A892A0191_5551AB1602F4_impl*
 l_Set := [];
 if Supports(Table, IhtFromTable, l_Table) then
 begin
  l_Table.Prepare(f_Helper, l_Table.Table.Kind in l_Set);
  Include(l_Set, l_Table.Table.Kind);
 end;
//#UC END# *566A892A0191_5551AB1602F4_impl*
end;//ThtTabledQuery.PrepareTable

procedure ThtTabledQuery.UnPrepareTable;
//#UC START# *566A893B03C7_5551AB1602F4_var*
var
 l_Table: IhtFromTable;
//#UC END# *566A893B03C7_5551AB1602F4_var*
begin
//#UC START# *566A893B03C7_5551AB1602F4_impl*
 if Supports(Table, IhtFromTable, l_Table) then
  l_Table.Unprepare(f_Helper);
//#UC END# *566A893B03C7_5551AB1602F4_impl*
end;//ThtTabledQuery.UnPrepareTable

procedure ThtTabledQuery.Cleanup;
//#UC START# *479731C50290_5551AB1602F4_var*
//#UC END# *479731C50290_5551AB1602F4_var*
begin
//#UC START# *479731C50290_5551AB1602F4_impl*
 f_Helper := nil;
 inherited;
//#UC END# *479731C50290_5551AB1602F4_impl*
end;//ThtTabledQuery.Cleanup

function ThtTabledQuery.MakeResultSet(Unidirectional: Boolean): IdaResultSet;
//#UC START# *56010A7801F2_5551AB1602F4_var*
var
 l_Field: IdaFieldFromTable;
 l_ParamDescription: IdaParamDescription;
 l_Sab: SAB;
 l_Condition: IdaAtomicCondition;
 l_Sort: array of SmallInt;
 l_IDX: Integer;
 l_FieldIndex: Integer;
 l_SortedRecs: SAB;
const
 Zero : LongInt =  0;
 AbsNumFld = 0;
 cOperationMap: array [TdaCompareOperation] of ThtCondition = (
  EQUAL, // da_copEqual
  GREAT_EQUAL, // da_copGreaterOrEqual
  LESS_EQUAL, // da_copLessOrEqual
  NOT_EQUAL // da_copNotEqual
 );
 cOrderMap: array [TdaSortOrder] of SmallInt = (
  1, // da_soAscending
  -1 // da_soDescending
 );
//#UC END# *56010A7801F2_5551AB1602F4_var*
begin
//#UC START# *56010A7801F2_5551AB1602F4_impl*

 l3ZeroMemory(@l_SAB, SizeOf(l_SAB));

 if WhereCondition <> nil then
 begin
//!! !!! Needs to be implemented !!! complex conditions support
  Assert(Supports(WhereCondition, IdaAtomicCondition));
  if Supports(WhereCondition, IdaFieldFromTable, l_Field) and
     Supports(WhereCondition, IdaParamDescription, l_ParamDescription) and
     Supports(WhereCondition, IdaAtomicCondition, l_Condition) then
   htSearch(nil, l_Sab, FindTable(l_Field.TableAlias).Handle, l_Field.Field.Index, cOperationMap[l_Condition.Operation], Get_Param(l_ParamDescription.Name).DataBuffer, nil)
  else
//!! !!! Needs to be implemented !!!
   Assert(False, 'Complex condition unimplemented');
 end
 else
  htSearch(nil, l_Sab, (Table as IhtFromTable).Handle, AbsNumFld, GREAT, @Zero, nil);
 if OrderBy.Count > 0 then
 begin
  SetLength(l_Sort, OrderBy.Count);
  for l_IDX := 0 to OrderBy.Count - 1 do
  begin
   if Supports(OrderBy[l_IDX].SelectField, IdaFieldFromTable, l_Field) then
    l_Sort[l_IDX] := cOrderMap[OrderBy[l_IDX].SortOrder] * l_Field.Field.Index
   else
   begin
    Assert(False);
    l_Sort[l_IDX] := 0;
   end;
   htSortResults(l_SortedRecs, l_Sab, @l_Sort[0], OrderBy.Count);
   htClearResults(l_Sab);
   l_Sab := l_SortedRecs;
  end;
 end;
 Result := ThtResultSet.Make(DataConverter as IhtDataConverter, l_Sab, SelectFields, Unidirectional);
//#UC END# *56010A7801F2_5551AB1602F4_impl*
end;//ThtTabledQuery.MakeResultSet

end.