unit evEmptyTableEliminator;
 {* Фильтр, выкидывающий пустые таблицы }

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evEmptyTableEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevEmptyTableEliminator" MUID: (4CF7B733015E)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , l3Variant
 , k2Base
;

type
 TevEmptyTableEliminator = class(TevdBufferedFilter)
  {* Фильтр, выкидывающий пустые таблицы }
  private
   f_WasSomeLeaf: Boolean;
  protected
   procedure StartChild(TypeID: Tl3Type); override;
   procedure OpenStream; override;
    {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
   procedure DoStartChild(TypeID: Tk2Type); override;
   function NeedStartBuffering(aID: Integer): Boolean; override;
   function NeedFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer): Boolean; override;
   procedure DoFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer;
    aNeedCloseBracket: Boolean); override;
 end;//TevEmptyTableEliminator

implementation

uses
 l3ImplUses
 , LeafPara_Const
 , Table_Const
 , SBS_Const
 , k2Facade
 , ParaList_Const
 , TableCell_Const
;

procedure TevEmptyTableEliminator.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_4CF7B733015E_var*
//#UC END# *4836D4650177_4CF7B733015E_var*
begin
//#UC START# *4836D4650177_4CF7B733015E_impl*
 if (SkipLevel > 0) then
 begin
  if not f_WasSomeLeaf then
  begin
   if TypeID.IsKindOf(k2_typLeafPara) then
    f_WasSomeLeaf := true;
  end//not f_WasSomeLeaf
  else
  if (SkipLevel = 2) then
  begin
   StopBufferingAndFlush(False, TopObject[0], False);
   f_WasSomeLeaf := false;
  end;//SkipLevel = 2
 end;//SkipLevel > 0 
 inherited;
//#UC END# *4836D4650177_4CF7B733015E_impl*
end;//TevEmptyTableEliminator.StartChild

procedure TevEmptyTableEliminator.OpenStream;
 {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
//#UC START# *4836D49800CA_4CF7B733015E_var*
//#UC END# *4836D49800CA_4CF7B733015E_var*
begin
//#UC START# *4836D49800CA_4CF7B733015E_impl*
 inherited;
 f_WasSomeLeaf := false;
//#UC END# *4836D49800CA_4CF7B733015E_impl*
end;//TevEmptyTableEliminator.OpenStream

procedure TevEmptyTableEliminator.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_4CF7B733015E_var*
//#UC END# *4A2D1217037A_4CF7B733015E_var*
begin
//#UC START# *4A2D1217037A_4CF7B733015E_impl*
 inherited;
//#UC END# *4A2D1217037A_4CF7B733015E_impl*
end;//TevEmptyTableEliminator.DoStartChild

function TevEmptyTableEliminator.NeedStartBuffering(aID: Integer): Boolean;
//#UC START# *4C56D54B002A_4CF7B733015E_var*
//#UC END# *4C56D54B002A_4CF7B733015E_var*
begin
//#UC START# *4C56D54B002A_4CF7B733015E_impl*
 Result := (aID = -k2_idTable) OR (aID = -k2_idSBS);
 if Result then
  f_WasSomeLeaf := false;
//#UC END# *4C56D54B002A_4CF7B733015E_impl*
end;//TevEmptyTableEliminator.NeedStartBuffering

function TevEmptyTableEliminator.NeedFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer): Boolean;
//#UC START# *4CF7BC520161_4CF7B733015E_var*

 procedure CheckEmptyLists(aList : Tl3Variant);
 var
  l_Index : Integer;
  l_Child : Tl3Variant;
 begin//CheckEmptyLists
  l_Index := 0;
  while (l_Index < aList.ChildrenCount) do
  begin
   l_Child := aList.Child[l_Index];
   if l_Child.IsKindOf(k2_typParaList) then
   begin
    CheckEmptyLists(l_Child);
    if (l_Child.ChildrenCount = 0) then
    begin
     if not l_Child.IsKindOf(k2_typTableCell) then
     begin
      aList.DeleteChild(l_Index);
      continue;
     end;//not l_Child.IsKindOf(k2_typTableCell)
    end;//l_Child.ChildrenCount = 0
   end;//l_Child.IsKindOf(k2_typParaList)
   Inc(l_Index);
  end;//l_Index < aList.ChildrenCount
 end;//CheckEmptyLists

//#UC END# *4CF7BC520161_4CF7B733015E_var*
begin
//#UC START# *4CF7BC520161_4CF7B733015E_impl*
 Result := f_WasSomeLeaf;
 if Result then
  CheckEmptyLists(aLeaf);
//#UC END# *4CF7BC520161_4CF7B733015E_impl*
end;//TevEmptyTableEliminator.NeedFlushBuffer

procedure TevEmptyTableEliminator.DoFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer;
 aNeedCloseBracket: Boolean);
//#UC START# *4CF7BEC40130_4CF7B733015E_var*
//#UC END# *4CF7BEC40130_4CF7B733015E_var*
begin
//#UC START# *4CF7BEC40130_4CF7B733015E_impl*
 inherited;
 f_WasSomeLeaf := false;
//#UC END# *4CF7BEC40130_4CF7B733015E_impl*
end;//TevEmptyTableEliminator.DoFlushBuffer

end.
