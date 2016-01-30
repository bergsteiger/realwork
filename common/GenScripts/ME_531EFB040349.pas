unit k2ToolCacheList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2ToolCacheList.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2ToolPrimList
 , k2ToolPrim
;

type
 Tk2ToolCacheList = class(Tk2ToolPrimList)
  public
   function GetFree: Tk2ToolPrim;
 end;//Tk2ToolCacheList

implementation

uses
 l3ImplUses
 , l3Base
;

function Tk2ToolCacheList.GetFree: Tk2ToolPrim;
//#UC START# *531EFB1C03E0_531EFB040349_var*

type
 Pl3_CBase = ^Tk2ToolPrim;

 function _GetFree(O: Pl3_CBase; Index: Integer): Boolean; 
 begin{_GetFree}
  if (O^.RefCount = 1) then
  begin
   GetFree := O^;
   Result := false;
  end//O^.RefCount = 1
  else
   Result := true;
 end;{_GetFree}

//#UC END# *531EFB1C03E0_531EFB040349_var*
begin
//#UC START# *531EFB1C03E0_531EFB040349_impl*
 Result := nil;
 if not Empty then
  IterateAllF(l3L2IA(@_GetFree));
//#UC END# *531EFB1C03E0_531EFB040349_impl*
end;//Tk2ToolCacheList.GetFree

end.
