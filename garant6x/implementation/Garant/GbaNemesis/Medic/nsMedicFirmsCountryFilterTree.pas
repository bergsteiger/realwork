unit nsMedicFirmsCountryFilterTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsCountryFilterTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsMedicFirmsCountryFilterTree" MUID: (49071DD902DC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsMedicFirmsCountryFilterTreeBase
 , l3TreeInterfaces
;

type
 TnsMedicFirmsCountryFilterTree = class(TnsMedicFirmsCountryFilterTreeBase)
  public
   class function Make: Il3SimpleTree; reintroduce;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsMedicFirmsCountryFilterTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *49071DD902DCimpl_uses*
 //#UC END# *49071DD902DCimpl_uses*
;

var g_TnsMedicFirmsCountryFilterTree: Pointer = nil;
 {* Экземпляр синглетона TnsMedicFirmsCountryFilterTree }

procedure TnsMedicFirmsCountryFilterTreeFree;
 {* Метод освобождения экземпляра синглетона TnsMedicFirmsCountryFilterTree }
begin
 IUnknown(g_TnsMedicFirmsCountryFilterTree) := nil;
end;//TnsMedicFirmsCountryFilterTreeFree

class function TnsMedicFirmsCountryFilterTree.Make: Il3SimpleTree;
begin
 if (g_TnsMedicFirmsCountryFilterTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicFirmsCountryFilterTreeFree);
  Il3SimpleTree(g_TnsMedicFirmsCountryFilterTree) := inherited Make;
 end;
 Result := Il3SimpleTree(g_TnsMedicFirmsCountryFilterTree);
end;//TnsMedicFirmsCountryFilterTree.Make

class function TnsMedicFirmsCountryFilterTree.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsMedicFirmsCountryFilterTree <> nil;
end;//TnsMedicFirmsCountryFilterTree.Exists
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
