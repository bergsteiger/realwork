unit pgTableQueryFactory;

// Модуль: "w:\common\components\rtl\Garant\PG\pgTableQueryFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgTableQueryFactory" MUID: (55F81B3F024D)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , pgInterfaces
 , pgConnection
 , daTypes
;

type
 TpgTableQueryFactory = class(Tl3ProtoObject, IdaTableQueryFactory)
  private
   f_DataConverter: IpgDataConverter;
   f_Connection: TpgConnection;
   f_UserNameQuery: IdaTabledQuery;
  private
   function UserNameQuery: IdaTabledQuery;
  protected
   function MakeTabledQuery(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''): IdaTabledQuery;
   function MakeSelectField(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const anAlias: AnsiString = ''): IdaSelectField;
   function MakeParamsCondition(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    anOperation: TdaCompareOperation;
    const aParamName: AnsiString): IdaCondition;
   function GetUserNameStr(anUserID: LargeInt): AnsiString;
   function Get_DataConverter: IdaDataConverter;
   function MakeLogicCondition(const aLeft: IdaCondition;
    anOperation: TdaLogicOperation;
    const aRight: IdaCondition): IdaCondition;
   function MakeSubQueryCondition(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const aQuery: IdaTabledQuery): IdaCondition;
   function MakeSortField(const aSelectField: IdaSelectField;
    aSortOrder: TdaSortOrder = daTypes.da_soAscending): IdaSortField;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aDataConverter: IpgDataConverter;
    aConnection: TpgConnection); reintroduce;
   class function Make(const aDataConverter: IpgDataConverter;
    aConnection: TpgConnection): IdaTableQueryFactory; reintroduce;
 end;//TpgTableQueryFactory
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , daSelectField
 , daParamsCondition
 , pgTabledQuery
 , daScheme
 , SysUtils
 , daLogicCondition
 , daSubQueryCondition
 , daSortField
;

constructor TpgTableQueryFactory.Create(const aDataConverter: IpgDataConverter;
 aConnection: TpgConnection);
//#UC START# *55F81B5C029C_55F81B3F024D_var*
//#UC END# *55F81B5C029C_55F81B3F024D_var*
begin
//#UC START# *55F81B5C029C_55F81B3F024D_impl*
 inherited Create;
 f_DataConverter := aDataConverter;
 aConnection.SetRefTo(f_Connection);
//#UC END# *55F81B5C029C_55F81B3F024D_impl*
end;//TpgTableQueryFactory.Create

class function TpgTableQueryFactory.Make(const aDataConverter: IpgDataConverter;
 aConnection: TpgConnection): IdaTableQueryFactory;
var
 l_Inst : TpgTableQueryFactory;
begin
 l_Inst := Create(aDataConverter, aConnection);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TpgTableQueryFactory.Make

function TpgTableQueryFactory.UserNameQuery: IdaTabledQuery;
//#UC START# *56F11DEF037F_55F81B3F024D_var*
//#UC END# *56F11DEF037F_55F81B3F024D_var*
begin
//#UC START# *56F11DEF037F_55F81B3F024D_impl*
 if f_UserNameQuery = nil then
 begin
  f_UserNameQuery := MakeTabledQuery(TdaScheme.Instance.Table(da_mtUsers));
  f_UserNameQuery.AddSelectField(MakeSelectField('', TdaScheme.Instance.Table(da_mtUsers)['user_name']));
  f_UserNameQuery.WhereCondition := MakeParamsCondition('', TdaScheme.Instance.Table(da_mtUsers)['ID'], da_copEqual, 'p_UserID');
  f_UserNameQuery.Prepare;
 end;
 Result := f_UserNameQuery;
//#UC END# *56F11DEF037F_55F81B3F024D_impl*
end;//TpgTableQueryFactory.UserNameQuery

function TpgTableQueryFactory.MakeTabledQuery(const aTable: IdaTableDescription;
 const anAlias: AnsiString = ''): IdaTabledQuery;
//#UC START# *5549C65D038D_55F81B3F024D_var*
//#UC END# *5549C65D038D_55F81B3F024D_var*
begin
//#UC START# *5549C65D038D_55F81B3F024D_impl*
 Result := TpgTabledQuery.Make(f_DataConverter, aTable, f_Connection, anAlias);
//#UC END# *5549C65D038D_55F81B3F024D_impl*
end;//TpgTableQueryFactory.MakeTabledQuery

function TpgTableQueryFactory.MakeSelectField(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 const anAlias: AnsiString = ''): IdaSelectField;
//#UC START# *559B80BD00A8_55F81B3F024D_var*
//#UC END# *559B80BD00A8_55F81B3F024D_var*
begin
//#UC START# *559B80BD00A8_55F81B3F024D_impl*
 Result := TdaSelectField.Make(aTableAlias, aField, anAlias);
//#UC END# *559B80BD00A8_55F81B3F024D_impl*
end;//TpgTableQueryFactory.MakeSelectField

function TpgTableQueryFactory.MakeParamsCondition(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 anOperation: TdaCompareOperation;
 const aParamName: AnsiString): IdaCondition;
//#UC START# *559B810003CF_55F81B3F024D_var*
//#UC END# *559B810003CF_55F81B3F024D_var*
begin
//#UC START# *559B810003CF_55F81B3F024D_impl*
 Result := TdaParamsCondition.Make(aTableAlias, aField, anOperation, aParamName);
//#UC END# *559B810003CF_55F81B3F024D_impl*
end;//TpgTableQueryFactory.MakeParamsCondition

function TpgTableQueryFactory.GetUserNameStr(anUserID: LargeInt): AnsiString;
//#UC START# *559BAF4401C8_55F81B3F024D_var*
var
 l_ResultSet: IdaResultSet;
//#UC END# *559BAF4401C8_55F81B3F024D_var*
begin
//#UC START# *559BAF4401C8_55F81B3F024D_impl*
 UserNameQuery.Param['p_UserID'].AsLargeInt := anUserID;
 l_ResultSet := UserNameQuery.OpenResultSet;
 try
  Result := l_ResultSet.Field['user_name'].AsString;
 finally
  l_ResultSet := nil;
 end;
//#UC END# *559BAF4401C8_55F81B3F024D_impl*
end;//TpgTableQueryFactory.GetUserNameStr

function TpgTableQueryFactory.Get_DataConverter: IdaDataConverter;
//#UC START# *55C1BFA402E3_55F81B3F024Dget_var*
//#UC END# *55C1BFA402E3_55F81B3F024Dget_var*
begin
//#UC START# *55C1BFA402E3_55F81B3F024Dget_impl*
 Result := f_DataConverter;
//#UC END# *55C1BFA402E3_55F81B3F024Dget_impl*
end;//TpgTableQueryFactory.Get_DataConverter

function TpgTableQueryFactory.MakeLogicCondition(const aLeft: IdaCondition;
 anOperation: TdaLogicOperation;
 const aRight: IdaCondition): IdaCondition;
//#UC START# *56405475021D_55F81B3F024D_var*
//#UC END# *56405475021D_55F81B3F024D_var*
begin
//#UC START# *56405475021D_55F81B3F024D_impl*
 Result := TdaLogicCondition.Make(aLeft, anOperation, aRight);
//#UC END# *56405475021D_55F81B3F024D_impl*
end;//TpgTableQueryFactory.MakeLogicCondition

function TpgTableQueryFactory.MakeSubQueryCondition(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 const aQuery: IdaTabledQuery): IdaCondition;
//#UC START# *5641E5DB02C3_55F81B3F024D_var*
//#UC END# *5641E5DB02C3_55F81B3F024D_var*
begin
//#UC START# *5641E5DB02C3_55F81B3F024D_impl*
 Result := TdaSubQueryCondition.Make(aTableALias, aField, aQuery);
//#UC END# *5641E5DB02C3_55F81B3F024D_impl*
end;//TpgTableQueryFactory.MakeSubQueryCondition

function TpgTableQueryFactory.MakeSortField(const aSelectField: IdaSelectField;
 aSortOrder: TdaSortOrder = daTypes.da_soAscending): IdaSortField;
//#UC START# *56811844032C_55F81B3F024D_var*
//#UC END# *56811844032C_55F81B3F024D_var*
begin
//#UC START# *56811844032C_55F81B3F024D_impl*
 Result := TdaSortField.Make(aSelectField, aSortOrder);
//#UC END# *56811844032C_55F81B3F024D_impl*
end;//TpgTableQueryFactory.MakeSortField

procedure TpgTableQueryFactory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55F81B3F024D_var*
//#UC END# *479731C50290_55F81B3F024D_var*
begin
//#UC START# *479731C50290_55F81B3F024D_impl*
 f_UserNameQuery := nil;
 f_DataConverter := nil;
 FreeAndNil(f_Connection);
 inherited;
//#UC END# *479731C50290_55F81B3F024D_impl*
end;//TpgTableQueryFactory.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
