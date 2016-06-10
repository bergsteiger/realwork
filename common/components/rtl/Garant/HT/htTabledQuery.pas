unit htTabledQuery;

// Модуль: "w:\common\components\rtl\Garant\HT\htTabledQuery.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ThtTabledQuery" MUID: (5551AB1602F4)

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , daTabledQuery
 , htInterfaces
 , daInterfaces
;

type
 ThtTabledQuery = class(TdaTabledQuery)
  private
   f_Helper: IhtDataSchemeHelper;
  private
   function FindTable(const anAlias: AnsiString): IhtFromTable;
  protected
   procedure PrepareTable; override;
   procedure UnPrepareTable; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function MakeResultSet(Unidirectional: Boolean): IdaResultSet; override;
  public
   constructor Create(const aFactory: IdaTableQueryFactory;
    const aDataConverter: IhtDataConverter;
    const aHelper: IhtDataSchemeHelper;
    const aFromClause: IdaFromClause); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory;
    const aDataConverter: IhtDataConverter;
    const aHelper: IhtDataSchemeHelper;
    const aFromClause: IdaFromClause): IdaTabledQuery; reintroduce;
 end;//ThtTabledQuery

implementation

uses
 l3ImplUses
 , htFromTable
 , daTypes
 {$If NOT Defined(Nemesis)}
 , HT_Const
 {$IfEnd} // NOT Defined(Nemesis)
 , htResultSet
 , l3Base
 {$If NOT Defined(Nemesis)}
 , HT_DLL
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
;

constructor ThtTabledQuery.Create(const aFactory: IdaTableQueryFactory;
 const aDataConverter: IhtDataConverter;
 const aHelper: IhtDataSchemeHelper;
 const aFromClause: IdaFromClause);
//#UC START# *5551AB780328_5551AB1602F4_var*
//#UC END# *5551AB780328_5551AB1602F4_var*
begin
//#UC START# *5551AB780328_5551AB1602F4_impl*
 inherited Create(aFactory, aDataConverter, aFromClause);
 f_Helper := aHelper;
//#UC END# *5551AB780328_5551AB1602F4_impl*
end;//ThtTabledQuery.Create

class function ThtTabledQuery.Make(const aFactory: IdaTableQueryFactory;
 const aDataConverter: IhtDataConverter;
 const aHelper: IhtDataSchemeHelper;
 const aFromClause: IdaFromClause): IdaTabledQuery;
var
 l_Inst : ThtTabledQuery;
begin
 l_Inst := Create(aFactory, aDataConverter, aHelper, aFromClause);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtTabledQuery.Make

function ThtTabledQuery.FindTable(const anAlias: AnsiString): IhtFromTable;
//#UC START# *555CA4CC00D6_5551AB1602F4_var*
var
 l_FromTable: IdaFromTable;
//#UC END# *555CA4CC00D6_5551AB1602F4_var*
begin
//#UC START# *555CA4CC00D6_5551AB1602F4_impl*
 l_FromTable := FromClause.FindTable(anAlias);
 if Assigned(l_FromTable) then
  Result := l_FromTable as IhtFromTable
 else
  Result := nil;
//#UC END# *555CA4CC00D6_5551AB1602F4_impl*
end;//ThtTabledQuery.FindTable

procedure ThtTabledQuery.PrepareTable;
//#UC START# *566A892A0191_5551AB1602F4_var*
var
 l_Set: TdaTablesSet;

 function DoIt(const anItem: IdaFromTable): Boolean;
 var
  l_Table: IhtFromTable;
 begin
  Result := True;
  if Supports(anItem, IhtFromTable, l_Table) then
  begin
   l_Table.Prepare(f_Helper, l_Table.Table.Kind in l_Set);
   Include(l_Set, l_Table.Table.Kind);
  end;
 end;

//#UC END# *566A892A0191_5551AB1602F4_var*
begin
//#UC START# *566A892A0191_5551AB1602F4_impl*
 l_Set := [];
 FromClause.IterateTablesF(L2daFromClauseIteratorIterateTablesFAction(@DoIt));
//#UC END# *566A892A0191_5551AB1602F4_impl*
end;//ThtTabledQuery.PrepareTable

procedure ThtTabledQuery.UnPrepareTable;
//#UC START# *566A893B03C7_5551AB1602F4_var*

 function DoIt(const anItem: IdaFromTable): Boolean;
 var
  l_Table: IhtFromTable;
 begin
  Result := True;
  if Supports(anItem, IhtFromTable, l_Table) then
   l_Table.Unprepare(f_Helper);
 end;

//#UC END# *566A893B03C7_5551AB1602F4_var*
begin
//#UC START# *566A893B03C7_5551AB1602F4_impl*
 FromClause.IterateTablesF(L2daFromClauseIteratorIterateTablesFAction(@DoIt));
//#UC END# *566A893B03C7_5551AB1602F4_impl*
end;//ThtTabledQuery.UnPrepareTable

procedure ThtTabledQuery.Cleanup;
 {* Функция очистки полей объекта. }
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

//!! !!! Needs to be implemented !!! join tables support!
  Assert(Supports(FromClause, IhtFromTable));

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
  htSearch(nil, l_Sab, (FromClause as IhtFromTable).Handle, AbsNumFld, GREAT, @Zero, nil);
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
