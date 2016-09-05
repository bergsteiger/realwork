unit pgFreeIDHelperHolder;

// Модуль: "w:\common\components\rtl\Garant\PG\pgFreeIDHelperHolder.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgFreeIDHelperHolder" MUID: (5770F2450027)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , pgFreeIDHelper
 , pgConnection
 , daInterfaces
 , pgFunctionFactory
 , daTypes
;

type
 TpgFreeIDHelperHolder = class(Tl3ProtoObject)
  private
   f_MainHelper: TpgFreeIDHelper;
   f_CurrentHelper: TpgFreeIDHelper;
   f_Connection: TpgConnection;
   f_QueryFactory: IdaTableQueryFactory;
   f_FunctionFactory: TpgFunctionFactory;
  protected
   function pm_GetFreeIDHelper(aFamilyID: TdaFamilyID): TpgFreeIDHelper; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aConnection: TpgConnection;
    const aQueryFactory: IdaTableQueryFactory;
    aFunctionFactory: TpgFunctionFactory); reintroduce;
   procedure ExcludeFree(aTable: TdaTables;
    anID: TdaDocID);
   function GetFree(aTable: TdaTables): TdaDocID;
   procedure PutFree(aTable: TdaTables;
    anID: TdaDocID);
  public
   property FreeIDHelper[aFamilyID: TdaFamilyID]: TpgFreeIDHelper
    read pm_GetFreeIDHelper;
 end;//TpgFreeIDHelperHolder
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , SysUtils
 , daSchemeConsts
 , daScheme
 //#UC START# *5770F2450027impl_uses*
 //#UC END# *5770F2450027impl_uses*
;

function TpgFreeIDHelperHolder.pm_GetFreeIDHelper(aFamilyID: TdaFamilyID): TpgFreeIDHelper;
//#UC START# *5770F26F036D_5770F2450027get_var*
//#UC END# *5770F26F036D_5770F2450027get_var*
begin
//#UC START# *5770F26F036D_5770F2450027get_impl*
 case aFamilyID of
  MainTblsFamily:
   begin
    if f_MainHelper = nil then
     f_MainHelper := TpgFreeIDHelper.Create(f_Connection, f_QueryFactory, f_FunctionFactory, aFamilyID);
    Result := f_MainHelper;
   end;
  CurrentFamily:
   begin
    if f_CurrentHelper = nil then
     f_CurrentHelper := TpgFreeIDHelper.Create(f_Connection, f_QueryFactory, f_FunctionFactory, aFamilyID);
    Result := f_CurrentHelper;
   end;
  else
  begin
   Result := nil;
   Assert(False);
  end;
 end;
//#UC END# *5770F26F036D_5770F2450027get_impl*
end;//TpgFreeIDHelperHolder.pm_GetFreeIDHelper

constructor TpgFreeIDHelperHolder.Create(aConnection: TpgConnection;
 const aQueryFactory: IdaTableQueryFactory;
 aFunctionFactory: TpgFunctionFactory);
//#UC START# *5770FDA901D4_5770F2450027_var*
//#UC END# *5770FDA901D4_5770F2450027_var*
begin
//#UC START# *5770FDA901D4_5770F2450027_impl*
 inherited Create;
 aConnection.SetRefTo(f_Connection);
 f_QueryFactory := aQueryFactory;
 aFunctionFactory.SetRefTo(f_FunctionFactory);
//#UC END# *5770FDA901D4_5770F2450027_impl*
end;//TpgFreeIDHelperHolder.Create

procedure TpgFreeIDHelperHolder.ExcludeFree(aTable: TdaTables;
 anID: TdaDocID);
//#UC START# *577123B6029A_5770F2450027_var*
//#UC END# *577123B6029A_5770F2450027_var*
begin
//#UC START# *577123B6029A_5770F2450027_impl*
 FreeIDHelper[TdaScheme.Instance.Table(aTable).FamilyID].ExcludeFree(TdaScheme.Instance.Table(aTable).Code, anID);
//#UC END# *577123B6029A_5770F2450027_impl*
end;//TpgFreeIDHelperHolder.ExcludeFree

function TpgFreeIDHelperHolder.GetFree(aTable: TdaTables): TdaDocID;
//#UC START# *5771241A0324_5770F2450027_var*
//#UC END# *5771241A0324_5770F2450027_var*
begin
//#UC START# *5771241A0324_5770F2450027_impl*
 Result := FreeIDHelper[TdaScheme.Instance.Table(aTable).FamilyID].GetFree(TdaScheme.Instance.Table(aTable).Code);
//#UC END# *5771241A0324_5770F2450027_impl*
end;//TpgFreeIDHelperHolder.GetFree

procedure TpgFreeIDHelperHolder.PutFree(aTable: TdaTables;
 anID: TdaDocID);
//#UC START# *577CC0BF0321_5770F2450027_var*
//#UC END# *577CC0BF0321_5770F2450027_var*
begin
//#UC START# *577CC0BF0321_5770F2450027_impl*
 FreeIDHelper[TdaScheme.Instance.Table(aTable).FamilyID].PutFree(TdaScheme.Instance.Table(aTable).Code, anID);
//#UC END# *577CC0BF0321_5770F2450027_impl*
end;//TpgFreeIDHelperHolder.PutFree

procedure TpgFreeIDHelperHolder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5770F2450027_var*
//#UC END# *479731C50290_5770F2450027_var*
begin
//#UC START# *479731C50290_5770F2450027_impl*
 FreeAndNil(f_FunctionFactory);
 FreeAndNil(f_Connection);
 f_QueryFactory := nil;
 FreeAndNil(f_MainHelper);
 FreeAndNil(f_CurrentHelper);
 inherited;
//#UC END# *479731C50290_5770F2450027_impl*
end;//TpgFreeIDHelperHolder.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
