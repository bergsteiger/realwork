unit k2InterfacedTagList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2InterfacedTagList.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2SimpleTagList
 , k2InterfacesEx
 , l3PureMixIns
;

type
 _ListType_ = Ik2TagListPrim;
 _l3InterfacedList_Parent_ = Tk2SimpleTagList;
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}
 Tk2InterfacedTagList = class(_l3InterfacedList_, Ik2TagList)
  public
   class function MakeI: Ik2TagList; reintroduce;
 end;//Tk2InterfacedTagList

implementation

uses
 l3ImplUses
 , l3Base
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

end.
