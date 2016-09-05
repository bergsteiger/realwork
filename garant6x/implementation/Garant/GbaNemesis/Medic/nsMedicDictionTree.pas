unit nsMedicDictionTree;
 {* Словарь медицинских терминов (синглетон) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicDictionTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsMedicDictionTree" MUID: (49070AD5032C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 end;//TnsMedicDictionTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *49070AD5032Cimpl_uses*
 //#UC END# *49070AD5032Cimpl_uses*
;

var g_TnsMedicDictionTree: Pointer = nil;
 {* Экземпляр синглетона TnsMedicDictionTree }

procedure TnsMedicDictionTreeFree;
 {* Метод освобождения экземпляра синглетона TnsMedicDictionTree }
begin
 IUnknown(g_TnsMedicDictionTree) := nil;
end;//TnsMedicDictionTreeFree

class function TnsMedicDictionTree.Make: Il3SimpleTree;
begin
 if (g_TnsMedicDictionTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicDictionTreeFree);
  Il3SimpleTree(g_TnsMedicDictionTree) := inherited Make;
 end;
 Result := Il3SimpleTree(g_TnsMedicDictionTree);
end;//TnsMedicDictionTree.Make

class function TnsMedicDictionTree.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsMedicDictionTree <> nil;
end;//TnsMedicDictionTree.Exists
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
