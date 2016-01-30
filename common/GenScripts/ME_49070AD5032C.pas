unit nsMedicDictionTree;
 {* Словарь медицинских терминов (синглетон) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicDictionTree.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsMedicDictionTreeBase
 , l3TreeInterfaces
;

type
 TnsMedicDictionTree = class(TnsMedicDictionTreeBase)
  {* Словарь медицинских терминов (синглетон) }
  public
   class function Make: Il3SimpleTree; reintroduce;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsMedicDictionTree;
    {* Метод получения экземпляра синглетона TnsMedicDictionTree }
 end;//TnsMedicDictionTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsMedicDictionTree: TnsMedicDictionTree = nil;
 {* Экземпляр синглетона TnsMedicDictionTree }

procedure TnsMedicDictionTreeFree;
 {* Метод освобождения экземпляра синглетона TnsMedicDictionTree }
begin
 l3Free(g_TnsMedicDictionTree);
end;//TnsMedicDictionTreeFree

class function TnsMedicDictionTree.Make: Il3SimpleTree;
var
 l_Inst : TnsMedicDictionTree;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsMedicDictionTree.Make

class function TnsMedicDictionTree.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsMedicDictionTree <> nil;
end;//TnsMedicDictionTree.Exists

class function TnsMedicDictionTree.Instance: TnsMedicDictionTree;
 {* Метод получения экземпляра синглетона TnsMedicDictionTree }
begin
 if (g_TnsMedicDictionTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicDictionTreeFree);
  g_TnsMedicDictionTree := Create;
 end;
 Result := g_TnsMedicDictionTree;
end;//TnsMedicDictionTree.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
