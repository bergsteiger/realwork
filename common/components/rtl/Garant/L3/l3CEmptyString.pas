unit l3CEmptyString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3CEmptyString.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CEmptyString
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3CEmptyStringPrim
  ;

type
 Tl3CEmptyString = class(Tl3CEmptyStringPrim)
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tl3CEmptyString;
    {- возвращает экземпляр синглетона. }
 end;//Tl3CEmptyString

implementation

uses
  l3Base {a}
  ;


// start class Tl3CEmptyString

var g_Tl3CEmptyString : Tl3CEmptyString = nil;

procedure Tl3CEmptyStringFree;
begin
 l3Free(g_Tl3CEmptyString);
end;

class function Tl3CEmptyString.Instance: Tl3CEmptyString;
begin
 if (g_Tl3CEmptyString = nil) then
 begin
  l3System.AddExitProc(Tl3CEmptyStringFree);
  g_Tl3CEmptyString := Create;
 end;
 Result := g_Tl3CEmptyString;
end;


class function Tl3CEmptyString.Exists: Boolean;
 {-}
begin
 Result := g_Tl3CEmptyString <> nil;
end;//Tl3CEmptyString.Exists

end.