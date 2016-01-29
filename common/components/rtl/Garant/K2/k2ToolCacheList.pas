unit k2ToolCacheList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2ToolCacheList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2ToolCacheList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2ToolPrim,
  k2ToolPrimList
  ;

type
 Tk2ToolCacheList = class(Tk2ToolPrimList)
 public
 // public methods
   function GetFree: Tk2ToolPrim;
 end;//Tk2ToolCacheList

implementation

uses
  l3Base
  ;

// start class Tk2ToolCacheList

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