unit daAggregateField;

// Модуль: "w:\common\components\rtl\Garant\DA\daAggregateField.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaAggregateField" MUID: (5755430A006F)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TdaAggregateField = class(Tl3ProtoObject, IdaSelectField)
  private
   f_Alias: AnsiString;
   f_Field: IdaSelectField;
   f_Operation: TdaAggregateOperation;
  protected
   function Get_Alias: AnsiString;
   function BuildSQLValue(AddAlias: Boolean = True): AnsiString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(anOperation: TdaAggregateOperation;
    const aField: IdaSelectField;
    const anAlias: AnsiString); reintroduce;
   class function Make(anOperation: TdaAggregateOperation;
    const aField: IdaSelectField;
    const anAlias: AnsiString): IdaSelectField; reintroduce;
   procedure IterateTables(anAction: daSelectFieldIterator_IterateTables_Action); virtual;
   procedure IterateTablesF(anAction: daSelectFieldIterator_IterateTables_Action);
 end;//TdaAggregateField

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

constructor TdaAggregateField.Create(anOperation: TdaAggregateOperation;
 const aField: IdaSelectField;
 const anAlias: AnsiString);
//#UC START# *5755433A00FF_5755430A006F_var*
//#UC END# *5755433A00FF_5755430A006F_var*
begin
//#UC START# *5755433A00FF_5755430A006F_impl*
 inherited Create;
 Assert(anAlias <> '');
 f_Operation := anOperation;
 f_Field := aField;
 F_Alias := anAlias;
//#UC END# *5755433A00FF_5755430A006F_impl*
end;//TdaAggregateField.Create

class function TdaAggregateField.Make(anOperation: TdaAggregateOperation;
 const aField: IdaSelectField;
 const anAlias: AnsiString): IdaSelectField;
var
 l_Inst : TdaAggregateField;
begin
 l_Inst := Create(anOperation, aField, anAlias);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaAggregateField.Make

function TdaAggregateField.Get_Alias: AnsiString;
//#UC START# *555352070022_5755430A006Fget_var*
//#UC END# *555352070022_5755430A006Fget_var*
begin
//#UC START# *555352070022_5755430A006Fget_impl*
 Result := f_Alias;
//#UC END# *555352070022_5755430A006Fget_impl*
end;//TdaAggregateField.Get_Alias

function TdaAggregateField.BuildSQLValue(AddAlias: Boolean = True): AnsiString;
//#UC START# *5608E5A4025F_5755430A006F_var*
const
 cMap: array[TdaAggregateOperation] of String = (
  'COUNT', //da_aopCount
  'MIN', //da_aopMin
  'MAX', //da_aopMax
  'AVG', //da_aopAverage
  'SUM' //da_aopSum
 );
//#UC END# *5608E5A4025F_5755430A006F_var*
begin
//#UC START# *5608E5A4025F_5755430A006F_impl*
 Result := Format('%s(%s) as %s', [cMap[f_Operation], f_Field.BuildSQLValue(False), f_Alias]);
//#UC END# *5608E5A4025F_5755430A006F_impl*
end;//TdaAggregateField.BuildSQLValue

procedure TdaAggregateField.IterateTables(anAction: daSelectFieldIterator_IterateTables_Action);
//#UC START# *5756AC9B0213_5755430A006F_var*
//#UC END# *5756AC9B0213_5755430A006F_var*
begin
//#UC START# *5756AC9B0213_5755430A006F_impl*
 f_Field.IterateTables(anAction);
//#UC END# *5756AC9B0213_5755430A006F_impl*
end;//TdaAggregateField.IterateTables

procedure TdaAggregateField.IterateTablesF(anAction: daSelectFieldIterator_IterateTables_Action);
var
 Hack : Pointer absolute anAction;
begin
 try
  IterateTables(anAction);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;//TdaAggregateField.IterateTablesF

procedure TdaAggregateField.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5755430A006F_var*
//#UC END# *479731C50290_5755430A006F_var*
begin
//#UC START# *479731C50290_5755430A006F_impl*
 f_Field := nil;
 inherited;
//#UC END# *479731C50290_5755430A006F_impl*
end;//TdaAggregateField.Cleanup

end.
