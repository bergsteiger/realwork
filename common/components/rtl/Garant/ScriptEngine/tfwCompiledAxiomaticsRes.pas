unit tfwCompiledAxiomaticsRes;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCompiledAxiomaticsRes.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwCompiledAxiomaticsRes" MUID: (55BA0CA0035A)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3StringList
;

type
 TtfwCompiledAxiomaticsRes = class(Tl3StringList)
  public
   class function Instance: TtfwCompiledAxiomaticsRes;
    {* Метод получения экземпляра синглетона TtfwCompiledAxiomaticsRes }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwCompiledAxiomaticsRes
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *55BA0CA0035Aimpl_uses*
 //#UC END# *55BA0CA0035Aimpl_uses*
;

var g_TtfwCompiledAxiomaticsRes: TtfwCompiledAxiomaticsRes = nil;
 {* Экземпляр синглетона TtfwCompiledAxiomaticsRes }

procedure TtfwCompiledAxiomaticsResFree;
 {* Метод освобождения экземпляра синглетона TtfwCompiledAxiomaticsRes }
begin
 l3Free(g_TtfwCompiledAxiomaticsRes);
end;//TtfwCompiledAxiomaticsResFree

class function TtfwCompiledAxiomaticsRes.Instance: TtfwCompiledAxiomaticsRes;
 {* Метод получения экземпляра синглетона TtfwCompiledAxiomaticsRes }
begin
 if (g_TtfwCompiledAxiomaticsRes = nil) then
 begin
  l3System.AddExitProc(TtfwCompiledAxiomaticsResFree);
  g_TtfwCompiledAxiomaticsRes := Create;
 end;
 Result := g_TtfwCompiledAxiomaticsRes;
end;//TtfwCompiledAxiomaticsRes.Instance

class function TtfwCompiledAxiomaticsRes.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwCompiledAxiomaticsRes <> nil;
end;//TtfwCompiledAxiomaticsRes.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
