unit l3IEBitmapContainerStack;

// Модуль: "w:\common\components\rtl\Garant\L3\l3IEBitmapContainerStack.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ObjectList
;

type
 Tl3IEBitmapContainerStack = class(Tl3ObjectList)
  public
   class function Exists: Boolean;
   class function Instance: Tl3IEBitmapContainerStack;
    {* Метод получения экземпляра синглетона Tl3IEBitmapContainerStack }
 end;//Tl3IEBitmapContainerStack

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3IEBitmapContainerStack: Tl3IEBitmapContainerStack = nil;
 {* Экземпляр синглетона Tl3IEBitmapContainerStack }

procedure Tl3IEBitmapContainerStackFree;
 {* Метод освобождения экземпляра синглетона Tl3IEBitmapContainerStack }
begin
 l3Free(g_Tl3IEBitmapContainerStack);
end;//Tl3IEBitmapContainerStackFree

class function Tl3IEBitmapContainerStack.Exists: Boolean;
//#UC START# *4DD3D0BB03BD_4DD3D054004A_var*
//#UC END# *4DD3D0BB03BD_4DD3D054004A_var*
begin
//#UC START# *4DD3D0BB03BD_4DD3D054004A_impl*
 Result := (g_Tl3IEBitmapContainerStack <> nil);
//#UC END# *4DD3D0BB03BD_4DD3D054004A_impl*
end;//Tl3IEBitmapContainerStack.Exists

class function Tl3IEBitmapContainerStack.Instance: Tl3IEBitmapContainerStack;
 {* Метод получения экземпляра синглетона Tl3IEBitmapContainerStack }
begin
 if (g_Tl3IEBitmapContainerStack = nil) then
 begin
  l3System.AddExitProc(Tl3IEBitmapContainerStackFree);
  g_Tl3IEBitmapContainerStack := Create;
 end;
 Result := g_Tl3IEBitmapContainerStack;
end;//Tl3IEBitmapContainerStack.Instance

end.
