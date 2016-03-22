unit tfwWordInfoCache;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoCache.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwWordInfoCache" MUID: (559F828102D8)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwWordInfoList
 , tfwScriptingInterfaces
 , tfwScriptingTypes
;

type
 TtfwWordInfoCache = class(TtfwWordInfoList)
  protected
   procedure InitFields; override;
  public
   function GetTypeInfo(const aModifiers: TtfwWordInfoRec): TtfwWordInfo;
   class function Instance: TtfwWordInfoCache;
    {* Метод получения экземпляра синглетона TtfwWordInfoCache }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwWordInfoCache
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TtfwWordInfoCache: TtfwWordInfoCache = nil;
 {* Экземпляр синглетона TtfwWordInfoCache }

procedure TtfwWordInfoCacheFree;
 {* Метод освобождения экземпляра синглетона TtfwWordInfoCache }
begin
 l3Free(g_TtfwWordInfoCache);
end;//TtfwWordInfoCacheFree

function TtfwWordInfoCache.GetTypeInfo(const aModifiers: TtfwWordInfoRec): TtfwWordInfo;
//#UC START# *559F82A60110_559F828102D8_var*
var
 l_Index : Integer;
 l_TI : TtfwWordInfoF;
//#UC END# *559F82A60110_559F828102D8_var*
begin
//#UC START# *559F82A60110_559F828102D8_impl*
 if aModifiers.Empty then
  Result := TtfwWordInfoE.Instance
 else
 if FindData(aModifiers, l_Index) then
  Result := Items[l_Index]
 else
 begin
  l_TI := TtfwWordInfoF.Create(aModifiers);
  try
   Add(l_TI);
   Result := l_TI;
  finally
   FreeAndNil(l_TI);
  end;//try..finally
 end;//FindData(aModifiers, l_Index)
//#UC END# *559F82A60110_559F828102D8_impl*
end;//TtfwWordInfoCache.GetTypeInfo

class function TtfwWordInfoCache.Instance: TtfwWordInfoCache;
 {* Метод получения экземпляра синглетона TtfwWordInfoCache }
begin
 if (g_TtfwWordInfoCache = nil) then
 begin
  l3System.AddExitProc(TtfwWordInfoCacheFree);
  g_TtfwWordInfoCache := Create;
 end;
 Result := g_TtfwWordInfoCache;
end;//TtfwWordInfoCache.Instance

class function TtfwWordInfoCache.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwWordInfoCache <> nil;
end;//TtfwWordInfoCache.Exists

procedure TtfwWordInfoCache.InitFields;
//#UC START# *47A042E100E2_559F828102D8_var*
//#UC END# *47A042E100E2_559F828102D8_var*
begin
//#UC START# *47A042E100E2_559F828102D8_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_559F828102D8_impl*
end;//TtfwWordInfoCache.InitFields
{$IfEnd} // NOT Defined(NoScripts)

end.
