unit pgRenumerator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgRenumerator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgRenumerator
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
  daTypes,
  daInterfaces
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgRenumerator = class(Tl3ProtoObject)
 private
 // private fields
   f_ToRealQuery : IdaTabledQuery;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
   function ConvertToRealNumber(aImpID: TdaDocID): TdaDocID;
 end;//TpgRenumerator
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  daScheme
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgRenumerator

constructor TpgRenumerator.Create(const aFactory: IdaTableQueryFactory);
//#UC START# *5652CB64000B_5652B5360294_var*
//#UC END# *5652CB64000B_5652B5360294_var*
begin
//#UC START# *5652CB64000B_5652B5360294_impl*
 inherited Create;
 f_ToRealQuery := aFactory.MakeTabledQuery(TdaScheme.Instance.Table(da_ftRenum));
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
//#UC START# *479731C50290_5652B5360294_var*
//#UC END# *479731C50290_5652B5360294_var*
begin
//#UC START# *479731C50290_5652B5360294_impl*
 f_ToRealQuery := nil;
 inherited;
//#UC END# *479731C50290_5652B5360294_impl*
end;//TpgRenumerator.Cleanup

{$IfEnd} //UsePostgres

end.