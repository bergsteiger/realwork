unit pgFamilyHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgFamilyHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgFamilyHelper
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
 TpgFamilyHelper = class(Tl3ProtoObject)
 private
 // private fields
   f_Query : IdaTabledQuery;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
   function FamilyPath(aFamily: TdaFamilyID): AnsiString;
 end;//TpgFamilyHelper
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  daScheme,
  SysUtils
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgFamilyHelper

constructor TpgFamilyHelper.Create(const aFactory: IdaTableQueryFactory);
//#UC START# *5645C3C5010C_5645BD2C03A2_var*
//#UC END# *5645C3C5010C_5645BD2C03A2_var*
begin
//#UC START# *5645C3C5010C_5645BD2C03A2_impl*
 inherited Create;
 f_Query := aFactory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtFamily));
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
//#UC START# *479731C50290_5645BD2C03A2_var*
//#UC END# *479731C50290_5645BD2C03A2_var*
begin
//#UC START# *479731C50290_5645BD2C03A2_impl*
 f_Query := nil;
 inherited;
//#UC END# *479731C50290_5645BD2C03A2_impl*
end;//TpgFamilyHelper.Cleanup

{$IfEnd} //UsePostgres

end.