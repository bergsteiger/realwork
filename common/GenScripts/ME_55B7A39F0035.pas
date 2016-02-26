unit tfwAxiomaticsResNameGetters;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetters.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwAxiomaticsResNameGetterList
;

type
 TtfwAxiomaticsResNameGetters = class(TtfwAxiomaticsResNameGetterList)
  public
   class function Instance: TtfwAxiomaticsResNameGetters;
    {* Метод получения экземпляра синглетона TtfwAxiomaticsResNameGetters }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwAxiomaticsResNameGetters
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TtfwAxiomaticsResNameGetters: TtfwAxiomaticsResNameGetters = nil;
 {* Экземпляр синглетона TtfwAxiomaticsResNameGetters }

procedure TtfwAxiomaticsResNameGettersFree;
 {* Метод освобождения экземпляра синглетона TtfwAxiomaticsResNameGetters }
begin
 l3Free(g_TtfwAxiomaticsResNameGetters);
end;//TtfwAxiomaticsResNameGettersFree

class function TtfwAxiomaticsResNameGetters.Instance: TtfwAxiomaticsResNameGetters;
 {* Метод получения экземпляра синглетона TtfwAxiomaticsResNameGetters }
begin
 if (g_TtfwAxiomaticsResNameGetters = nil) then
 begin
  l3System.AddExitProc(TtfwAxiomaticsResNameGettersFree);
  g_TtfwAxiomaticsResNameGetters := Create;
 end;
 Result := g_TtfwAxiomaticsResNameGetters;
end;//TtfwAxiomaticsResNameGetters.Instance

class function TtfwAxiomaticsResNameGetters.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwAxiomaticsResNameGetters <> nil;
end;//TtfwAxiomaticsResNameGetters.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
