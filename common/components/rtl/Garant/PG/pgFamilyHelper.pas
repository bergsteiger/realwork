unit pgFamilyHelper;

// Модуль: "w:\common\components\rtl\Garant\PG\pgFamilyHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgFamilyHelper" MUID: (5645BD2C03A2)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TpgFamilyHelper = class(Tl3ProtoObject)
  private
   f_Query: IdaTabledQuery;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
   function FamilyPath(aFamily: TdaFamilyID): AnsiString;
 end;//TpgFamilyHelper
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , daScheme
 , SysUtils
;

constructor TpgFamilyHelper.Create(const aFactory: IdaTableQueryFactory);
//#UC START# *5645C3C5010C_5645BD2C03A2_var*
//#UC END# *5645C3C5010C_5645BD2C03A2_var*
begin
//#UC START# *5645C3C5010C_5645BD2C03A2_impl*
 inherited Create;
 f_Query := aFactory.MakeTabledQuery(aFactory.MakeSimpleFromClause(TdaScheme.Instance.Table(da_mtFamily)));
 f_Query.AddSelectField(aFactory.MakeSelectField('', TdaScheme.Instance.Table(da_mtFamily).Field['PathToTbl']));
 f_Query.WhereCondition := aFactory.MakeParamsCondition('', TdaScheme.Instance.Table(da_mtFamily).Field['ID'], da_copEqual, 'p_ID');
 f_Query.Prepare;
//#UC END# *5645C3C5010C_5645BD2C03A2_impl*
end;//TpgFamilyHelper.Create

function TpgFamilyHelper.FamilyPath(aFamily: TdaFamilyID): AnsiString;
//#UC START# *5645BD440189_5645BD2C03A2_var*
var
 l_ResultSet: IdaResultSet;
//#UC END# *5645BD440189_5645BD2C03A2_var*
begin
//#UC START# *5645BD440189_5645BD2C03A2_impl*
 f_Query.Param['p_ID'].AsInteger := aFamily;
 l_ResultSet := f_Query.OpenResultSet;
 try
  if l_ResultSet.IsEmpty then
   raise Exception.Create(Format('Неверный номер семейства: %d.', [aFamily]));
  Result := l_ResultSet.Field['PathToTbl'].AsString;
 finally
  l_ResultSet := nil;
 end;
//#UC END# *5645BD440189_5645BD2C03A2_impl*
end;//TpgFamilyHelper.FamilyPath

procedure TpgFamilyHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5645BD2C03A2_var*
//#UC END# *479731C50290_5645BD2C03A2_var*
begin
//#UC START# *479731C50290_5645BD2C03A2_impl*
 f_Query := nil;
 inherited;
//#UC END# *479731C50290_5645BD2C03A2_impl*
end;//TpgFamilyHelper.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
