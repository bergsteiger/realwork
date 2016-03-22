unit tfwValueTypesCache;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesCache.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwValueTypesCache" MUID: (55BF37AB038D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwValueTypesList
 , tfwValueTypes
;

type
 TtfwValueTypesCache = class(TtfwValueTypesList)
  protected
   procedure InitFields; override;
  public
   function CheckList(aValue: TtfwValueTypes): TtfwValueTypes;
   class function Instance: TtfwValueTypesCache;
    {* Метод получения экземпляра синглетона TtfwValueTypesCache }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwValueTypesCache
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TtfwValueTypesCache: TtfwValueTypesCache = nil;
 {* Экземпляр синглетона TtfwValueTypesCache }

procedure TtfwValueTypesCacheFree;
 {* Метод освобождения экземпляра синглетона TtfwValueTypesCache }
begin
 l3Free(g_TtfwValueTypesCache);
end;//TtfwValueTypesCacheFree

function TtfwValueTypesCache.CheckList(aValue: TtfwValueTypes): TtfwValueTypes;
//#UC START# *55C0A4040157_55BF37AB038D_var*
var
 l_Index : Integer;
//#UC END# *55C0A4040157_55BF37AB038D_var*
begin
//#UC START# *55C0A4040157_55BF37AB038D_impl*
 if Self.FindData(aValue, l_Index) then
  Result := Self.Items[l_Index]
 else
 begin
  Self.Add(aValue);
  Result := aValue;
 end;//TtfwValueTypesCache.Instance.FindData(l_L, l_Index)
//#UC END# *55C0A4040157_55BF37AB038D_impl*
end;//TtfwValueTypesCache.CheckList

class function TtfwValueTypesCache.Instance: TtfwValueTypesCache;
 {* Метод получения экземпляра синглетона TtfwValueTypesCache }
begin
 if (g_TtfwValueTypesCache = nil) then
 begin
  l3System.AddExitProc(TtfwValueTypesCacheFree);
  g_TtfwValueTypesCache := Create;
 end;
 Result := g_TtfwValueTypesCache;
end;//TtfwValueTypesCache.Instance

class function TtfwValueTypesCache.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwValueTypesCache <> nil;
end;//TtfwValueTypesCache.Exists

procedure TtfwValueTypesCache.InitFields;
//#UC START# *47A042E100E2_55BF37AB038D_var*
//#UC END# *47A042E100E2_55BF37AB038D_var*
begin
//#UC START# *47A042E100E2_55BF37AB038D_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_55BF37AB038D_impl*
end;//TtfwValueTypesCache.InitFields
{$IfEnd} // NOT Defined(NoScripts)

end.
