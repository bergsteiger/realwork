unit htTabledQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "HT"
// Модуль: "w:/common/components/rtl/Garant/HT/htTabledQuery.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::HT::Provider::ThtTabledQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
   function MakeResultSet(Unidirectional: Boolean): IdaResultSet; override;
   procedure PrepareTables; override;
     {* Сигнатура метода PrepareTables }
   procedure UnprepareTables; override;
     {* Сигнатура метода UnprepareTables }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aDataConverter: IhtDataConverter;
     const aHelper: IhtDataSchemeHelper;
     const aTable: IdaTableDescription;
     const anAlias: AnsiString = ''); reintroduce;
   class function Make(const aDataConverter: IhtDataConverter;
     const aHelper: IhtDataSchemeHelper;
     const aTable: IdaTableDescription;
     const anAlias: AnsiString = ''): IdaQuery; reintroduce;
     {* Сигнатура фабрики ThtTabledQuery.Make }
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
 if Tables.FindData(anAlias, l_IDX) then
  Result := Tables[l_IDX] as IhtFromTable
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
  const anAlias: AnsiString = ''): IdaQuery;
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

function ThtTabledQuery.MakeResultSet(Unidirectional: Boolean): IdaResultSet;
//#UC START# *56010A7801F2_5551AB1602F4_var*
var
 l_Field: IdaFieldFromTable;
 l_ParamDescription: IdaParamDescription;
 l_Sab: SAB;
 l_Condition: IdaAtomicCondition;
const
 Zero : LongInt =  0;
 AbsNumFld = 0;
 cOperationMap: array [TdaCompareOperation] of ThtCondition = (
  EQUAL // da_copEqual
 );
//#UC END# *56010A7801F2_5551AB1602F4_var*
begin
//#UC START# *56010A7801F2_5551AB1602F4_impl*

 l3ZeroMemory(@l_SAB, SizeOf(l_SAB));

 if WhereCondition <> nil then
 begin
  Assert(Supports(WhereCondition, IdaAtomicCondition));
  if Supports(WhereCondition, IdaFieldFromTable, l_Field) and
     Supports(WhereCondition, IdaParamDescription, l_ParamDescription) and
     Supports(WhereCondition, IdaAtomicCondition, l_Condition) then
   htSearch(nil, l_Sab, FindTable(l_Field.TableAlias).Handle, l_Field.Field.Index, cOperationMap[l_Condition.Operation], Get_Param(l_ParamDescription.Name).DataBuffer, nil)
  else
   Assert(False);
 end
 else
  htSearch(nil, l_Sab, FindTable(l_Field.TableAlias).Handle, AbsNumFld, GREAT, @Zero, nil);
 Result := ThtResultSet.Make(DataConverter as IhtDataConverter, l_Sab, SelectFields, Unidirectional);
//#UC END# *56010A7801F2_5551AB1602F4_impl*
end;//ThtTabledQuery.MakeResultSet

procedure ThtTabledQuery.PrepareTables;
//#UC START# *56010AB70258_5551AB1602F4_var*
var
 l_IDX: Integer;
 l_Table: IhtFromTable;
 l_Set: TdaTablesSet;
//#UC END# *56010AB70258_5551AB1602F4_var*
begin
//#UC START# *56010AB70258_5551AB1602F4_impl*
 l_Set := [];
 for l_IDX := 0 to Tables.Count - 1 do
  if Supports(Tables[l_IDX], IhtFromTable, l_Table) then
  begin
   l_Table.Prepare(f_Helper, l_Table.Table.Kind in l_Set);
   Include(l_Set, l_Table.Table.Kind);
  end;
//#UC END# *56010AB70258_5551AB1602F4_impl*
end;//ThtTabledQuery.PrepareTables

procedure ThtTabledQuery.UnprepareTables;
//#UC START# *56010ACB00F0_5551AB1602F4_var*
var
 l_IDX: Integer;
 l_Table: IhtFromTable;
//#UC END# *56010ACB00F0_5551AB1602F4_var*
begin
//#UC START# *56010ACB00F0_5551AB1602F4_impl*
 for l_IDX := 0 to Tables.Count - 1 do
  if Supports(Tables[l_IDX], IhtFromTable, l_Table) then
   l_Table.Unprepare(f_Helper);
//#UC END# *56010ACB00F0_5551AB1602F4_impl*
end;//ThtTabledQuery.UnprepareTables

procedure ThtTabledQuery.Cleanup;
//#UC START# *479731C50290_5551AB1602F4_var*
//#UC END# *479731C50290_5551AB1602F4_var*
begin
//#UC START# *479731C50290_5551AB1602F4_impl*
 f_Helper := nil;
 inherited;
//#UC END# *479731C50290_5551AB1602F4_impl*
end;//ThtTabledQuery.Cleanup

end.