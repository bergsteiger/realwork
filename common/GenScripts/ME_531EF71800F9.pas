unit k2InterfaceCache;

// ������: "w:\common\components\rtl\Garant\K2\k2InterfaceCache.pas"
// ���������: "UtilityPack"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2InterfaceList
 , k2ToolPrim
;

type
 Tk2InterfaceCache = object(Tk2InterfaceList)
  public
   function GetInterface: Tk2ToolPrim;
   procedure SetInterface;
   procedure IterateInterfaces;
 end;//Tk2InterfaceCache

implementation

uses
 l3ImplUses
 , k2ToolCacheList
 , k2ToolPrimList
 , SysUtils
 , l3ProtoObject
 , l3ProtoObjectRefList
;

function Tk2InterfaceCache.GetInterface: Tk2ToolPrim;
//#UC START# *531EF76E016B_531EF73702F9_var*
//#UC END# *531EF76E016B_531EF73702F9_var*
begin
//#UC START# *531EF76E016B_531EF73702F9_impl*
 Result := Tk2ToolCacheList(GetItem(ID)).GetFree;
//#UC END# *531EF76E016B_531EF73702F9_impl*
end;//Tk2InterfaceCache.GetInterface

procedure Tk2InterfaceCache.SetInterface;
//#UC START# *531EF77E0278_531EF73702F9_var*
var
 L : Tk2ToolCacheList;
//#UC END# *531EF77E0278_531EF73702F9_var*
begin
//#UC START# *531EF77E0278_531EF73702F9_impl*
 L := GetItem(ID).Use;
 try
  if (L = nil) then
  begin
   L := Tk2ToolCacheList.Make;
   SetItem(ID, L);
  end;//L = nil
  L.Add(Item);
 finally
  FreeAndNil(L);
 end;//try..except
//#UC END# *531EF77E0278_531EF73702F9_impl*
end;//Tk2InterfaceCache.SetInterface

procedure Tk2InterfaceCache.IterateInterfaces;
//#UC START# *531EF7920193_531EF73702F9_var*
var
 i    : Long;
 Intf : Tk2ToolPrim;
 L    : Tk2ToolCacheList;
 L1   : Tk2ToolPrimList;
//#UC END# *531EF7920193_531EF73702F9_var*
begin
//#UC START# *531EF7920193_531EF73702F9_impl*
 if Assigned(Action) then
 begin
  L := Tk2ToolCacheList(GetItem(ID));
  if not L.Empty then
  begin
   L1 := Tk2ToolPrimList.Create;
   try
    for i := L.Lo to L.Hi do
    begin
     Intf := L.Items[i];
     if (Intf.RefCount > 1) then
      L1.Add(Intf);
    end;//for i
    L1.IterateAll(Action);
   finally
    FreeAndNil(L1);
   end;//try..finally
  end;//not L.Empty
 end;//Assigned(Action)
//#UC END# *531EF7920193_531EF73702F9_impl*
end;//Tk2InterfaceCache.IterateInterfaces

end.
