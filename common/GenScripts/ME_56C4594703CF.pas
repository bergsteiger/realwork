unit caTableQueryFactory;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caTableQueryFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcaTableQueryFactory" MUID: (56C4594703CF)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , caInterfaces
 , daTypes
;

type
 TcaTableQueryFactory = class(Tl3ProtoObject, IdaTableQueryFactory)
  private
   f_HTFactory: IdaTableQueryFactory;
   f_PGFactory: IdaTableQueryFactory;
   f_DataConverter: IcaDataConverter;
  protected
   function MakeTabledQuery(const aFromClause: IdaFromClause): IdaTabledQuery;
   function MakeSelectField(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const anAlias: AnsiString = ''): IdaSelectField;
   function MakeParamsCondition(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    anOperation: TdaCompareOperation;
    const aParamName: AnsiString): IdaCondition;
   function Get_DataConverter: IdaDataConverter;
   function MakeLogicCondition(const aLeft: IdaCondition;
    anOperation: TdaLogicOperation;
    const aRight: IdaCondition): IdaCondition;
   function MakeSubQueryCondition(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const aQuery: IdaTabledQuery): IdaCondition;
   function MakeSortField(const aSelectField: IdaSelectField;
    aSortOrder: TdaSortOrder = daTypes.da_soAscending): IdaSortField;
   function MakeJoin(const aLeft: IdaFromClause;
    const aRight: IdaFromClause;
    aKind: TdaJoinKind): IdaJoin;
   function MakeJoinCondition(const aLeftTableAlias: AnsiString;
    const aLeftField: IdaFieldDescription;
    const aRightTableAlias: AnsiString;
    const aRightField: IdaFieldDescription): IdaCondition;
   function MakeSimpleFromClause(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''): IdaFromClause;
   function MakeAggregateField(anOperation: TdaAggregateOperation;
    const aField: IdaSelectField;
    const anAlias: AnsiString): IdaSelectField;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aDataConverter: IcaDataConverter;
    const aHTFactory: IdaTableQueryFactory;
    const aPGFactory: IdaTableQueryFactory); reintroduce;
   class function Make(const aDataConverter: IcaDataConverter;
    const aHTFactory: IdaTableQueryFactory;
    const aPGFactory: IdaTableQueryFactory): IdaTableQueryFactory; reintroduce;
 end;//TcaTableQueryFactory
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , caTabledQuery
 , daLogicCondition
 , daParamsCondition
 , daSortField
 , daSelectField
 , daSubQueryCondition
 , daJoin
 , daJoinCondition
 , caFromClause
 , daAggregateField
;

constructor TcaTableQueryFactory.Create(const aDataConverter: IcaDataConverter;
 const aHTFactory: IdaTableQueryFactory;
 const aPGFactory: IdaTableQueryFactory);
//#UC START# *56C45EE801FB_56C4594703CF_var*
//#UC END# *56C45EE801FB_56C4594703CF_var*
begin
//#UC START# *56C45EE801FB_56C4594703CF_impl*
 inherited Create;
 f_DataConverter := aDataConverter;
 f_HTFactory := aHTFactory;
 f_PGFactory := aPGFactory;
//#UC END# *56C45EE801FB_56C4594703CF_impl*
end;//TcaTableQueryFactory.Create

class function TcaTableQueryFactory.Make(const aDataConverter: IcaDataConverter;
 const aHTFactory: IdaTableQueryFactory;
 const aPGFactory: IdaTableQueryFactory): IdaTableQueryFactory;
var
 l_Inst : TcaTableQueryFactory;
begin
 l_Inst := Create(aDataConverter, aHTFactory, aPGFactory);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaTableQueryFactory.Make

function TcaTableQueryFactory.MakeTabledQuery(const aFromClause: IdaFromClause): IdaTabledQuery;
//#UC START# *5549C65D038D_56C4594703CF_var*
//#UC END# *5549C65D038D_56C4594703CF_var*
begin
//#UC START# *5549C65D038D_56C4594703CF_impl*
 Result := TcaTabledQuery.Make(Self, f_DataConverter, aFromClause, f_HTFactory.MakeTabledQuery((aFromClause as IdaComboAccessFromClauseHelper).HTClause),
  f_PGFactory.MakeTabledQuery((aFromClause as IdaComboAccessFromClauseHelper).PGClause));
//#UC END# *5549C65D038D_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeTabledQuery

function TcaTableQueryFactory.MakeSelectField(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 const anAlias: AnsiString = ''): IdaSelectField;
//#UC START# *559B80BD00A8_56C4594703CF_var*
//#UC END# *559B80BD00A8_56C4594703CF_var*
begin
//#UC START# *559B80BD00A8_56C4594703CF_impl*
 Result := TdaSelectField.Make(aTableAlias, aField, anAlias);
//#UC END# *559B80BD00A8_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeSelectField

function TcaTableQueryFactory.MakeParamsCondition(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 anOperation: TdaCompareOperation;
 const aParamName: AnsiString): IdaCondition;
//#UC START# *559B810003CF_56C4594703CF_var*
//#UC END# *559B810003CF_56C4594703CF_var*
begin
//#UC START# *559B810003CF_56C4594703CF_impl*
 Result := TdaParamsCondition.Make(aTableAlias, aField, anOperation, aParamName);
//#UC END# *559B810003CF_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeParamsCondition

function TcaTableQueryFactory.Get_DataConverter: IdaDataConverter;
//#UC START# *55C1BFA402E3_56C4594703CFget_var*
//#UC END# *55C1BFA402E3_56C4594703CFget_var*
begin
//#UC START# *55C1BFA402E3_56C4594703CFget_impl*
 Result := f_DataConverter;
//#UC END# *55C1BFA402E3_56C4594703CFget_impl*
end;//TcaTableQueryFactory.Get_DataConverter

function TcaTableQueryFactory.MakeLogicCondition(const aLeft: IdaCondition;
 anOperation: TdaLogicOperation;
 const aRight: IdaCondition): IdaCondition;
//#UC START# *56405475021D_56C4594703CF_var*
//#UC END# *56405475021D_56C4594703CF_var*
begin
//#UC START# *56405475021D_56C4594703CF_impl*
 Result := TdaLogicCondition.Make(aLeft, anOperation, aRight);
//#UC END# *56405475021D_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeLogicCondition

function TcaTableQueryFactory.MakeSubQueryCondition(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 const aQuery: IdaTabledQuery): IdaCondition;
//#UC START# *5641E5DB02C3_56C4594703CF_var*
//#UC END# *5641E5DB02C3_56C4594703CF_var*
begin
//#UC START# *5641E5DB02C3_56C4594703CF_impl*
 Result := TdaSubQueryCondition.Make(aTableALias, aField, aQuery);
//#UC END# *5641E5DB02C3_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeSubQueryCondition

function TcaTableQueryFactory.MakeSortField(const aSelectField: IdaSelectField;
 aSortOrder: TdaSortOrder = daTypes.da_soAscending): IdaSortField;
//#UC START# *56811844032C_56C4594703CF_var*
//#UC END# *56811844032C_56C4594703CF_var*
begin
//#UC START# *56811844032C_56C4594703CF_impl*
 Result := TdaSortField.Make(aSelectField, aSortOrder);
//#UC END# *56811844032C_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeSortField

function TcaTableQueryFactory.MakeJoin(const aLeft: IdaFromClause;
 const aRight: IdaFromClause;
 aKind: TdaJoinKind): IdaJoin;
//#UC START# *574584D802F6_56C4594703CF_var*
//#UC END# *574584D802F6_56C4594703CF_var*
begin
//#UC START# *574584D802F6_56C4594703CF_impl*
 Result := TcaFromClause.Make(Self, f_HTFactory.MakeJoin((aLeft as IdaComboAccessFromClauseHelper).HTClause, (aRight as IdaComboAccessFromClauseHelper).HTClause, aKind) as IdaFromClause,
  f_PGFactory.MakeJoin((aLeft as IdaComboAccessFromClauseHelper).PGClause, (aRight as IdaComboAccessFromClauseHelper).PGClause, aKind) as IdaFromClause);
//#UC END# *574584D802F6_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeJoin

function TcaTableQueryFactory.MakeJoinCondition(const aLeftTableAlias: AnsiString;
 const aLeftField: IdaFieldDescription;
 const aRightTableAlias: AnsiString;
 const aRightField: IdaFieldDescription): IdaCondition;
//#UC START# *574BF2B20123_56C4594703CF_var*
//#UC END# *574BF2B20123_56C4594703CF_var*
begin
//#UC START# *574BF2B20123_56C4594703CF_impl*
 Result := TdaJoinCondition.Make(aLeftTableAlias, aLeftField, aRightTableAlias, aRightField);
//#UC END# *574BF2B20123_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeJoinCondition

function TcaTableQueryFactory.MakeSimpleFromClause(const aTable: IdaTableDescription;
 const anAlias: AnsiString = ''): IdaFromClause;
//#UC START# *574C32760314_56C4594703CF_var*
//#UC END# *574C32760314_56C4594703CF_var*
begin
//#UC START# *574C32760314_56C4594703CF_impl*
 Result := TcaFromClause.Make(Self, f_HTFactory.MakeSimpleFromClause(aTable, anAlias), f_PGFactory.MakeSimpleFromClause(aTable, anAlias)) as IdaFromClause;
//#UC END# *574C32760314_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeSimpleFromClause

function TcaTableQueryFactory.MakeAggregateField(anOperation: TdaAggregateOperation;
 const aField: IdaSelectField;
 const anAlias: AnsiString): IdaSelectField;
//#UC START# *5755313E0083_56C4594703CF_var*
//#UC END# *5755313E0083_56C4594703CF_var*
begin
//#UC START# *5755313E0083_56C4594703CF_impl*
 Result := TdaAggregateField.Make(anOperation, aField, anAlias);
//#UC END# *5755313E0083_56C4594703CF_impl*
end;//TcaTableQueryFactory.MakeAggregateField

procedure TcaTableQueryFactory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56C4594703CF_var*
//#UC END# *479731C50290_56C4594703CF_var*
begin
//#UC START# *479731C50290_56C4594703CF_impl*
 f_DataConverter := nil;
 f_HTFactory := nil;
 f_PGFactory := nil;
 inherited;
//#UC END# *479731C50290_56C4594703CF_impl*
end;//TcaTableQueryFactory.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
