unit l3GraphicContainerStack;

// Модуль: "w:\common\components\rtl\Garant\L3\l3GraphicContainerStack.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3GraphicContainerStack" MUID: (4DD3CD0B0193)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ObjectList
;

type
 Tl3GraphicContainerStack = class(Tl3ObjectList)
  public
   class function Exists: Boolean;
   class function Instance: Tl3GraphicContainerStack;
    {* Метод получения экземпляра синглетона Tl3GraphicContainerStack }
 end;//Tl3GraphicContainerStack

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3GraphicContainerStack: Tl3GraphicContainerStack = nil;
 {* Экземпляр синглетона Tl3GraphicContainerStack }

procedure Tl3GraphicContainerStackFree;
 {* Метод освобождения экземпляра синглетона Tl3GraphicContainerStack }
begin
 l3Free(g_Tl3GraphicContainerStack);
end;//Tl3GraphicContainerStackFree

class function Tl3GraphicContainerStack.Exists: Boolean;
//#UC START# *4DD3CE6A00B7_4DD3CD0B0193_var*
//#UC END# *4DD3CE6A00B7_4DD3CD0B0193_var*
begin
//#UC START# *4DD3CE6A00B7_4DD3CD0B0193_impl*
 Result := (g_Tl3GraphicContainerStack <> nil);
//#UC END# *4DD3CE6A00B7_4DD3CD0B0193_impl*
end;//Tl3GraphicContainerStack.Exists

class function Tl3GraphicContainerStack.Instance: Tl3GraphicContainerStack;
 {* Метод получения экземпляра синглетона Tl3GraphicContainerStack }
begin
 if (g_Tl3GraphicContainerStack = nil) then
 begin
  l3System.AddExitProc(Tl3GraphicContainerStackFree);
  g_Tl3GraphicContainerStack := Create;
 end;
 Result := g_Tl3GraphicContainerStack;
end;//Tl3GraphicContainerStack.Instance

end.
