unit nsMedicDictionTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/nsMedicDictionTree.pas"
// Начат: 2008/03/06 10:02:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic$Unit::TnsMedicDictionTree
//
// Словарь медицинских терминов (синглетон)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  nsMedicDictionTreeBase
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMedicDictionTree = class(TnsMedicDictionTreeBase)
  {* Словарь медицинских терминов (синглетон) }
 public
 // public methods
   class function Make: Il3SimpleTree; reintroduce;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsMedicDictionTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsMedicDictionTree

var g_TnsMedicDictionTree : Pointer = nil;

procedure TnsMedicDictionTreeFree;
begin
 IUnknown(g_TnsMedicDictionTree) := nil;
end;


class function TnsMedicDictionTree.Make: Il3SimpleTree;
begin
 if (g_TnsMedicDictionTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicDictionTreeFree);
  Il3SimpleTree(g_TnsMedicDictionTree) := inherited Make;
 end;
 Result := Il3SimpleTree(g_TnsMedicDictionTree);
end;

class function TnsMedicDictionTree.Exists: Boolean;
 {-}
begin
 Result := g_TnsMedicDictionTree <> nil;
end;//TnsMedicDictionTree.Exists

{$IfEnd} //not Admin AND not Monitorings

end.