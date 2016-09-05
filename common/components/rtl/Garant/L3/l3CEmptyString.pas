unit l3CEmptyString;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CEmptyString.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3CEmptyString" MUID: (4F5CBEC30305)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CEmptyStringPrim
;

type
 Tl3CEmptyString = class(Tl3CEmptyStringPrim)
  public
   class function Instance: Tl3CEmptyString;
    {* Метод получения экземпляра синглетона Tl3CEmptyString }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3CEmptyString

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4F5CBEC30305impl_uses*
 //#UC END# *4F5CBEC30305impl_uses*
;

var g_Tl3CEmptyString: Tl3CEmptyString = nil;
 {* Экземпляр синглетона Tl3CEmptyString }

procedure Tl3CEmptyStringFree;
 {* Метод освобождения экземпляра синглетона Tl3CEmptyString }
begin
 l3Free(g_Tl3CEmptyString);
end;//Tl3CEmptyStringFree

class function Tl3CEmptyString.Instance: Tl3CEmptyString;
 {* Метод получения экземпляра синглетона Tl3CEmptyString }
begin
 if (g_Tl3CEmptyString = nil) then
 begin
  l3System.AddExitProc(Tl3CEmptyStringFree);
  g_Tl3CEmptyString := Create;
 end;
 Result := g_Tl3CEmptyString;
end;//Tl3CEmptyString.Instance

class function Tl3CEmptyString.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3CEmptyString <> nil;
end;//Tl3CEmptyString.Exists

end.
