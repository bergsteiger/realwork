unit pgRenumerator;

// Модуль: "w:\common\components\rtl\Garant\PG\pgRenumerator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgRenumerator" MUID: (5652B5360294)

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
 TpgRenumerator = class(Tl3ProtoObject)
  private
   f_ToRealQuery: IdaTabledQuery;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
   function ConvertToRealNumber(aImpID: TdaDocID): TdaDocID;
 end;//TpgRenumerator
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , daScheme
 //#UC START# *5652B5360294impl_uses*
 //#UC END# *5652B5360294impl_uses*
;

constructor TpgRenumerator.Create(const aFactory: IdaTableQueryFactory);
//#UC START# *5652CB64000B_5652B5360294_var*
//#UC END# *5652CB64000B_5652B5360294_var*
begin
//#UC START# *5652CB64000B_5652B5360294_impl*
 inherited Create;
 f_ToRealQuery := aFactory.MakeTabledQuery(aFactory.MakeSimpleFromClause(TdaScheme.Instance.Table(da_ftRenum)));
 f_ToRealQuery.AddSelectField(aFactory.MakeSelectField('', TdaScheme.Instance.Table(da_ftRenum)['RealID']));
 f_ToRealQuery.WhereCondition := aFactory.MakeParamsCondition('', TdaScheme.Instance.Table(da_ftRenum)['ImportID'], da_copEqual, 'p_ID');
 f_ToRealQuery.Prepare;
//#UC END# *5652CB64000B_5652B5360294_impl*
end;//TpgRenumerator.Create

function TpgRenumerator.ConvertToRealNumber(aImpID: TdaDocID): TdaDocID;
//#UC START# *5652B58D01EF_5652B5360294_var*
var
 l_ResultSet: IdaResultSet;
//#UC END# *5652B58D01EF_5652B5360294_var*
begin
//#UC START# *5652B58D01EF_5652B5360294_impl*
 Result := 0;
 if aImpID = 0 then
  exit;
 f_ToRealQuery.Param['p_ID'].AsLargeInt := aImpID;
 l_ResultSet := f_ToRealQuery.OpenResultSet;
 try
  if l_ResultSet.IsEmpty then
   Result := cUndefDocID
  else
   Result := l_ResultSet.Field['RealID'].AsInteger;
 finally
  l_ResultSet := nil;
 end;
//#UC END# *5652B58D01EF_5652B5360294_impl*
end;//TpgRenumerator.ConvertToRealNumber

procedure TpgRenumerator.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5652B5360294_var*
//#UC END# *479731C50290_5652B5360294_var*
begin
//#UC START# *479731C50290_5652B5360294_impl*
 f_ToRealQuery := nil;
 inherited;
//#UC END# *479731C50290_5652B5360294_impl*
end;//TpgRenumerator.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
