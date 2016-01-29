unit pgTableQueryFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgTableQueryFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgTableQueryFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  l3ProtoObject,
  daInterfaces,
  pgInterfaces,
  pgConnection,
  daTypes
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgTableQueryFactory = class(Tl3ProtoObject, IdaTableQueryFactory)
 private
 // private fields
   f_DataConverter : IpgDataConverter;
   f_Connection : TpgConnection;
 protected
 // realized methods
   function MakeTabledQuery(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''): IdaQuery;
   function MakeSelectField(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const anAlias: AnsiString = ''): IdaSelectField;
   function MakeParamsCondition(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    anOperation: TdaCompareOperation;
    const aParamName: AnsiString): IdaCondition;
   function GetUserNameStr(anUserID: LargeInt): AnsiString;
   function Get_DataConverter: IdaDataConverter;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aDataConverter: IpgDataConverter;
     aConnection: TpgConnection); reintroduce;
   class function Make(const aDataConverter: IpgDataConverter;
     aConnection: TpgConnection): IdaTableQueryFactory; reintroduce;
     {* Сигнатура фабрики TpgTableQueryFactory.Make }
 end;//TpgTableQueryFactory
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  daSelectField,
  daParamsCondition,
  pgTabledQuery,
  daScheme,
  SysUtils
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgTableQueryFactory

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
end;

function TpgTableQueryFactory.MakeTabledQuery(const aTable: IdaTableDescription;
  const anAlias: AnsiString = ''): IdaQuery;
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
 l_Query: IdaQuery;
 l_ResultSet: IdaResultSet;
//#UC END# *559BAF4401C8_55F81B3F024D_var*
begin
//#UC START# *559BAF4401C8_55F81B3F024D_impl*
 l_Query := MakeTabledQuery(TdaScheme.Instance.Table(da_mtUsers));
 try
  l_Query.AddSelectField(MakeSelectField('', TdaScheme.Instance.Table(da_mtUsers)['UserName']));
  l_Query.WhereCondition := MakeParamsCondition('', TdaScheme.Instance.Table(da_mtUsers)['ID'], da_copEqual, 'p_UserID');
  l_Query.Prepare;
  l_Query.Param['p_UserID'].AsLargeInt := anUserID;
  l_ResultSet := l_Query.OpenResultSet;
  try
   Result := l_ResultSet.Field['UserName'].AsString;
  finally
   l_ResultSet := nil;
  end;
 finally
  l_Query := nil;
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

procedure TpgTableQueryFactory.Cleanup;
//#UC START# *479731C50290_55F81B3F024D_var*
//#UC END# *479731C50290_55F81B3F024D_var*
begin
//#UC START# *479731C50290_55F81B3F024D_impl*
 f_DataConverter := nil;
 FreeAndNil(f_Connection);
 inherited;
//#UC END# *479731C50290_55F81B3F024D_impl*
end;//TpgTableQueryFactory.Cleanup

{$IfEnd} //UsePostgres

end.