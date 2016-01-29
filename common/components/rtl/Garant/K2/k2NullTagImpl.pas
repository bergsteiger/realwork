unit k2NullTagImpl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2NullTagImpl.pas"
// Начат: 26.02.2009 17:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2NullTagImpl
//
// Реализация пустого тега
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2NullTagImplPrim
  ;

type
 Tk2NullTagImpl = class(Tk2NullTagImplPrim)
  {* Реализация пустого тега }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tk2NullTagImpl;
    {- возвращает экземпляр синглетона. }
 end;//Tk2NullTagImpl

implementation

uses
  l3Base {a}
  ;


// start class Tk2NullTagImpl

var g_Tk2NullTagImpl : Tk2NullTagImpl = nil;

procedure Tk2NullTagImplFree;
begin
 l3Free(g_Tk2NullTagImpl);
end;

class function Tk2NullTagImpl.Instance: Tk2NullTagImpl;
begin
 if (g_Tk2NullTagImpl = nil) then
 begin
  l3System.AddExitProc(Tk2NullTagImplFree);
  g_Tk2NullTagImpl := Create;
 end;
 Result := g_Tk2NullTagImpl;
end;


class function Tk2NullTagImpl.Exists: Boolean;
 {-}
begin
 Result := g_Tk2NullTagImpl <> nil;
end;//Tk2NullTagImpl.Exists

end.