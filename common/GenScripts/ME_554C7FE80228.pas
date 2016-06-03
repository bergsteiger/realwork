unit htTableQueryFactory;

// ������: "w:\common\components\rtl\Garant\HT\htTableQueryFactory.pas"
// ���������: "SimpleClass"
// ������� ������: "ThtTableQueryFactory" MUID: (554C7FE80228)

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , htInterfaces
 , daTypes
;

type
 ThtTableQueryFactory = class(Tl3ProtoObject, IdaTableQueryFactory)
  private
   f_DataConverter: IhtDataConverter;
   f_Helper: IhtDataSchemeHelper;
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
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(const aDataConverter: IhtDataConverter;
    const aHelper: IhtDataSchemeHelper); reintroduce;
   class function Make(const aDataConverter: IhtDataConverter;
    const aHelper: IhtDataSchemeHelper): IdaTableQueryFactory; reintroduce;
 end;//ThtTableQueryFactory

implementation

uses
 l3ImplUses
 , htTabledQuery
 , daParamsCondition
 , daSelectField
 {$If NOT Defined(Nemesis)}
 , dt_User
 {$IfEnd} // NOT Defined(Nemesis)
 , daLogicCondition
 , daSubQueryCondition
 , daSortField
 , daJoin
 , daJoinCondition
 , htFromTable
;

constructor ThtTableQueryFactory.Create(const aDataConverter: IhtDataConverter;
 const aHelper: IhtDataSchemeHelper);
//#UC START# *554C8017020C_554C7FE80228_var*
//#UC END# *554C8017020C_554C7FE80228_var*
begin
//#UC START# *554C8017020C_554C7FE80228_impl*
 inherited Create;
 f_DataConverter := aDataConverter;
 f_Helper := aHelper;
//#UC END# *554C8017020C_554C7FE80228_impl*
end;//ThtTableQueryFactory.Create

class function ThtTableQueryFactory.Make(const aDataConverter: IhtDataConverter;
 const aHelper: IhtDataSchemeHelper): IdaTableQueryFactory;
var
 l_Inst : ThtTableQueryFactory;
begin
 l_Inst := Create(aDataConverter, aHelper);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtTableQueryFactory.Make

function ThtTableQueryFactory.MakeTabledQuery(const aFromClause: IdaFromClause): IdaTabledQuery;
//#UC START# *5549C65D038D_554C7FE80228_var*
//#UC END# *5549C65D038D_554C7FE80228_var*
begin
//#UC START# *5549C65D038D_554C7FE80228_impl*
 Result := ThtTabledQuery.Make(f_DataConverter, f_Helper, aTable, anAlias);
//#UC END# *5549C65D038D_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeTabledQuery

function ThtTableQueryFactory.MakeSelectField(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 const anAlias: AnsiString = ''): IdaSelectField;
//#UC START# *559B80BD00A8_554C7FE80228_var*
//#UC END# *559B80BD00A8_554C7FE80228_var*
begin
//#UC START# *559B80BD00A8_554C7FE80228_impl*
 Result := TdaSelectField.Make(aTableAlias, aField, anAlias);
//#UC END# *559B80BD00A8_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeSelectField

function ThtTableQueryFactory.MakeParamsCondition(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 anOperation: TdaCompareOperation;
 const aParamName: AnsiString): IdaCondition;
//#UC START# *559B810003CF_554C7FE80228_var*
//#UC END# *559B810003CF_554C7FE80228_var*
begin
//#UC START# *559B810003CF_554C7FE80228_impl*
 Result := TdaParamsCondition.Make(aTableAlias, aField, anOperation, aParamName);
//#UC END# *559B810003CF_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeParamsCondition

function ThtTableQueryFactory.Get_DataConverter: IdaDataConverter;
//#UC START# *55C1BFA402E3_554C7FE80228get_var*
//#UC END# *55C1BFA402E3_554C7FE80228get_var*
begin
//#UC START# *55C1BFA402E3_554C7FE80228get_impl*
 Result := f_DataConverter;
//#UC END# *55C1BFA402E3_554C7FE80228get_impl*
end;//ThtTableQueryFactory.Get_DataConverter

function ThtTableQueryFactory.MakeLogicCondition(const aLeft: IdaCondition;
 anOperation: TdaLogicOperation;
 const aRight: IdaCondition): IdaCondition;
//#UC START# *56405475021D_554C7FE80228_var*
//#UC END# *56405475021D_554C7FE80228_var*
begin
//#UC START# *56405475021D_554C7FE80228_impl*
 Result := TdaLogicCondition.Make(aLeft, anOperation, aRight);
//#UC END# *56405475021D_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeLogicCondition

function ThtTableQueryFactory.MakeSubQueryCondition(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 const aQuery: IdaTabledQuery): IdaCondition;
//#UC START# *5641E5DB02C3_554C7FE80228_var*
//#UC END# *5641E5DB02C3_554C7FE80228_var*
begin
//#UC START# *5641E5DB02C3_554C7FE80228_impl*
 Result := TdaSubQueryCondition.Make(aTableALias, aField, aQuery);
//#UC END# *5641E5DB02C3_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeSubQueryCondition

function ThtTableQueryFactory.MakeSortField(const aSelectField: IdaSelectField;
 aSortOrder: TdaSortOrder = daTypes.da_soAscending): IdaSortField;
//#UC START# *56811844032C_554C7FE80228_var*
//#UC END# *56811844032C_554C7FE80228_var*
begin
//#UC START# *56811844032C_554C7FE80228_impl*
 Result := TdaSortField.Make(aSelectField, aSortOrder);
//#UC END# *56811844032C_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeSortField

function ThtTableQueryFactory.MakeJoin(const aLeft: IdaFromClause;
 const aRight: IdaFromClause;
 aKind: TdaJoinKind): IdaJoin;
//#UC START# *574584D802F6_554C7FE80228_var*
//#UC END# *574584D802F6_554C7FE80228_var*
begin
//#UC START# *574584D802F6_554C7FE80228_impl*
 Result := TdaJoin.Make(Self, aLeft, aRight, aKind);
//#UC END# *574584D802F6_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeJoin

function ThtTableQueryFactory.MakeJoinCondition(const aLeftTableAlias: AnsiString;
 const aLeftField: IdaFieldDescription;
 const aRightTableAlias: AnsiString;
 const aRightField: IdaFieldDescription): IdaCondition;
//#UC START# *574BF2B20123_554C7FE80228_var*
//#UC END# *574BF2B20123_554C7FE80228_var*
begin
//#UC START# *574BF2B20123_554C7FE80228_impl*
 Result := TdaJoinCondition.Make(aLeftTableAlias, aLeftField, aRightTableAlias, aRightField);
//#UC END# *574BF2B20123_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeJoinCondition

function ThtTableQueryFactory.MakeSimpleFromClause(const aTable: IdaTableDescription;
 const anAlias: AnsiString = ''): IdaFromClause;
//#UC START# *574C32760314_554C7FE80228_var*
//#UC END# *574C32760314_554C7FE80228_var*
begin
//#UC START# *574C32760314_554C7FE80228_impl*
 Assert(anAlias <> '');
 Result := TdaFromTable.Make(Self, aTable, anAlias);
//#UC END# *574C32760314_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeSimpleFromClause

procedure ThtTableQueryFactory.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_554C7FE80228_var*
//#UC END# *479731C50290_554C7FE80228_var*
begin
//#UC START# *479731C50290_554C7FE80228_impl*
 f_DataConverter := nil;
 f_Helper := nil;
 inherited;
//#UC END# *479731C50290_554C7FE80228_impl*
end;//ThtTableQueryFactory.Cleanup

end.
