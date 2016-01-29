unit l3FontManagerEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3FontManagerEx.pas"
// Начат: 27.02.2010 13:16
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Canvas::Tl3FontManagerEx
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3FontManager
  ;

type
 Tl3FontManagerEx = class(Tl3FontManager)
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tl3FontManagerEx;
    {- возвращает экземпляр синглетона. }
 end;//Tl3FontManagerEx

implementation

uses
  l3Base {a}
  ;


// start class Tl3FontManagerEx

var g_Tl3FontManagerEx : Tl3FontManagerEx = nil;

procedure Tl3FontManagerExFree;
begin
 l3Free(g_Tl3FontManagerEx);
end;

class function Tl3FontManagerEx.Instance: Tl3FontManagerEx;
begin
 if (g_Tl3FontManagerEx = nil) then
 begin
  l3System.AddExitProc(Tl3FontManagerExFree);
  g_Tl3FontManagerEx := Create;
 end;
 Result := g_Tl3FontManagerEx;
end;


class function Tl3FontManagerEx.Exists: Boolean;
 {-}
begin
 Result := g_Tl3FontManagerEx <> nil;
end;//Tl3FontManagerEx.Exists

end.