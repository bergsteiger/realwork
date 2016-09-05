unit tfwCS;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCS.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwCS" MUID: (57C3F3540027)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoObject
 , SyncObjs
;

type
 _seCriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TtfwCS = class(_seCriticalSectionHolder_)
  public
   class function Instance: TtfwCS;
    {* Метод получения экземпляра синглетона TtfwCS }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwCS
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57C3F3540027impl_uses*
 //#UC END# *57C3F3540027impl_uses*
;

var g_TtfwCS: TtfwCS = nil;
 {* Экземпляр синглетона TtfwCS }

procedure TtfwCSFree;
 {* Метод освобождения экземпляра синглетона TtfwCS }
begin
 l3Free(g_TtfwCS);
end;//TtfwCSFree

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

class function TtfwCS.Instance: TtfwCS;
 {* Метод получения экземпляра синглетона TtfwCS }
begin
 if (g_TtfwCS = nil) then
 begin
  l3System.AddExitProc(TtfwCSFree);
  g_TtfwCS := Create;
 end;
 Result := g_TtfwCS;
end;//TtfwCS.Instance

class function TtfwCS.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwCS <> nil;
end;//TtfwCS.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
