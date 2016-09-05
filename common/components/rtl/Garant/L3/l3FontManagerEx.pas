unit l3FontManagerEx;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FontManagerEx.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3FontManagerEx" MUID: (4B88F0F00211)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3FontManager
;

type
 Tl3FontManagerEx = class(Tl3FontManager)
  public
   class function Instance: Tl3FontManagerEx;
    {* Метод получения экземпляра синглетона Tl3FontManagerEx }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3FontManagerEx

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4B88F0F00211impl_uses*
 //#UC END# *4B88F0F00211impl_uses*
;

var g_Tl3FontManagerEx: Tl3FontManagerEx = nil;
 {* Экземпляр синглетона Tl3FontManagerEx }

procedure Tl3FontManagerExFree;
 {* Метод освобождения экземпляра синглетона Tl3FontManagerEx }
begin
 l3Free(g_Tl3FontManagerEx);
end;//Tl3FontManagerExFree

class function Tl3FontManagerEx.Instance: Tl3FontManagerEx;
 {* Метод получения экземпляра синглетона Tl3FontManagerEx }
begin
 if (g_Tl3FontManagerEx = nil) then
 begin
  l3System.AddExitProc(Tl3FontManagerExFree);
  g_Tl3FontManagerEx := Create;
 end;
 Result := g_Tl3FontManagerEx;
end;//Tl3FontManagerEx.Instance

class function Tl3FontManagerEx.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3FontManagerEx <> nil;
end;//Tl3FontManagerEx.Exists

end.
