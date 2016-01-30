unit evdEmptySubsEliminator;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdEmptySubsEliminator.pas"
// Стереотип: "SimpleClass"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , l3Variant
;

type
 TevdEmptySubsEliminator = class(TevdBufferedFilter)
  protected
   function NeedStartBuffering(aID: Integer): Boolean; override;
   function NeedFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer): Boolean; override;
 end;//TevdEmptySubsEliminator

implementation

uses
 l3ImplUses
 , k2Tags
;

function TevdEmptySubsEliminator.NeedStartBuffering(aID: Integer): Boolean;
//#UC START# *4C56D54B002A_4F9BFA1F007E_var*
//#UC END# *4C56D54B002A_4F9BFA1F007E_var*
begin
//#UC START# *4C56D54B002A_4F9BFA1F007E_impl*
 Result := (aID = k2_tiSubs);
//#UC END# *4C56D54B002A_4F9BFA1F007E_impl*
end;//TevdEmptySubsEliminator.NeedStartBuffering

function TevdEmptySubsEliminator.NeedFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer): Boolean;
//#UC START# *4CF7BC520161_4F9BFA1F007E_var*
var
 l_Index : Integer;
//#UC END# *4CF7BC520161_4F9BFA1F007E_var*
begin
//#UC START# *4CF7BC520161_4F9BFA1F007E_impl*
 Result := (aLeaf.ChildrenCount > 0);
 if Result then
 begin
  Result := false;
  l_Index := 0;
  while (l_Index < aLeaf.ChildrenCount) do
  begin
   if (aLeaf.Child[l_Index].ChildrenCount > 0) then
   begin
    Result := true;
    Inc(l_Index);
   end//aLeaf.Child[l_Index].ChildrenCount > 0
   else
    aLeaf.DeleteChild(l_Index);
  end;//l_Index < aLeaf.ChildrenCount
  Result := (aLeaf.ChildrenCount > 0);
  if Result then
   if (aLeaf.ChildrenCount = 1) then
    if (aLeaf.Child[0].ChildrenCount = 1) then
     if (aLeaf.Child[0].Child[0].IntA[k2_tiHandle] = 0) then
      Result := false;
      // - отрезаем мусорный саб от документа
 end;//Result
//#UC END# *4CF7BC520161_4F9BFA1F007E_impl*
end;//TevdEmptySubsEliminator.NeedFlushBuffer

end.
