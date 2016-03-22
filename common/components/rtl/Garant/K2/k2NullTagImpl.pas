unit k2NullTagImpl;
 {* Реализация пустого тега }

// Модуль: "w:\common\components\rtl\Garant\K2\k2NullTagImpl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2NullTagImpl" MUID: (49A6ABFB02BA)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2NullTagImplPrim
;

type
 Tk2NullTagImpl = class(Tk2NullTagImplPrim)
  {* Реализация пустого тега }
  public
   class function Instance: Tk2NullTagImpl;
    {* Метод получения экземпляра синглетона Tk2NullTagImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tk2NullTagImpl

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tk2NullTagImpl: Tk2NullTagImpl = nil;
 {* Экземпляр синглетона Tk2NullTagImpl }

procedure Tk2NullTagImplFree;
 {* Метод освобождения экземпляра синглетона Tk2NullTagImpl }
begin
 l3Free(g_Tk2NullTagImpl);
end;//Tk2NullTagImplFree

class function Tk2NullTagImpl.Instance: Tk2NullTagImpl;
 {* Метод получения экземпляра синглетона Tk2NullTagImpl }
begin
 if (g_Tk2NullTagImpl = nil) then
 begin
  l3System.AddExitProc(Tk2NullTagImplFree);
  g_Tk2NullTagImpl := Create;
 end;
 Result := g_Tk2NullTagImpl;
end;//Tk2NullTagImpl.Instance

class function Tk2NullTagImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tk2NullTagImpl <> nil;
end;//Tk2NullTagImpl.Exists

end.
