unit k2InterfacedTagList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2InterfacedTagList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2InterfacedTagList" MUID: (47E37EF20114)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2SimpleTagList
 , k2InterfacesEx
 , l3Variant
 , l3PureMixIns
;

type
 _ListType_ = Ik2TagListPrim;
 _l3InterfacedList_Parent_ = Tk2SimpleTagList;
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}
 Tk2InterfacedTagList = class(_l3InterfacedList_, Ik2TagList)
  protected
   function ForEach(anAction: Ik2TagList_ForEach_Action): Integer; virtual;
    {* Перебирает элементы списка.

<!> Временно. Надо будет перенести на Ml3List. }
   function ForEachF(anAction: Ik2TagList_ForEach_Action): Integer;
    {* Перебирает элементы списка.

<!> Временно. Надо будет перенести на Ml3List. }
  public
   class function MakeI: Ik2TagList; reintroduce;
 end;//Tk2InterfacedTagList

implementation

uses
 l3ImplUses
 , l3Base
 , l3Memory
;

type _Instance_R_ = Tk2InterfacedTagList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}

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
end;//Tk2InterfacedTagList.MakeI

function Tk2InterfacedTagList.ForEach(anAction: Ik2TagList_ForEach_Action): Integer;
 {* Перебирает элементы списка.

<!> Временно. Надо будет перенести на Ml3List. }
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

function Tk2InterfacedTagList.ForEachF(anAction: Ik2TagList_ForEach_Action): Integer;
 {* Перебирает элементы списка.

<!> Временно. Надо будет перенести на Ml3List. }
var
 Hack : Pointer absolute anAction;
begin
 try
  Result := ForEach(anAction);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;//Tk2InterfacedTagList.ForEachF

end.
