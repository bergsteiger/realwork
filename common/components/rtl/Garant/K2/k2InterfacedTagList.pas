unit k2InterfacedTagList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2InterfacedTagList.pas"
// Начат: 21.03.2008 12:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2Containers::Tk2InterfacedTagList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2InterfacesEx,
  k2SimpleTagList,
  l3PureMixIns,
  l3Variant
  ;

type
 _ListType_ = Ik2TagListPrim;
 _l3InterfacedList_Parent_ = Tk2SimpleTagList;
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}
 Tk2InterfacedTagList = class(_l3InterfacedList_, Ik2TagList)
 protected
 // realized methods
   {iterator} function ForEach(anAction: Ik2TagList_ForEach_Action): Integer;
     {* Перебирает элементы списка.

<!> Временно. Надо будет перенести на Ml3List. }
   {iterator} function ForEachF(anAction: Ik2TagList_ForEach_Action): Integer;
     {* Перебирает элементы списка.

<!> Временно. Надо будет перенести на Ml3List. }
 public
 // public methods
   class function MakeI: Ik2TagList; reintroduce;
 end;//Tk2InterfacedTagList

implementation

uses
  l3Base
  ;

type _Instance_R_ = Tk2InterfacedTagList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}

// start class Tk2InterfacedTagList

class function Tk2InterfacedTagList.MakeI: Ik2TagList;
var
 l_Inst : Tk2InterfacedTagList;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{iterator} function Tk2InterfacedTagList.ForEach(anAction: Ik2TagList_ForEach_Action): Integer;
//#UC START# *4BB0841A0071_47E37EF20114_var*

 function DoIt(anItem: Pl3Variant; anIndex: Integer): Boolean;
 begin
  Result := anAction(anItem^, anIndex);
 end;

//#UC END# *4BB0841A0071_47E37EF20114_var*
begin
//#UC START# *4BB0841A0071_47E37EF20114_impl*
 Result := IterateAllF(l3L2IA(@DoIt));
//#UC END# *4BB0841A0071_47E37EF20114_impl*
end;//Tk2InterfacedTagList.ForEach

{iterator} function Tk2InterfacedTagList.ForEachF(anAction: Ik2TagList_ForEach_Action): Integer;
var
 Hack : Pointer absolute anAction;
begin
 try
  Result := ForEach(anAction);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;

end.