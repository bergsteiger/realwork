unit l3ConvertersList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3ConvertersList.pas"
// Начат: 19.05.2011 14:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3ConvertersList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3StringList
  ;

type
 Tl3ConvertersList = class(Tl3StringList)
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tl3ConvertersList;
    {- возвращает экземпляр синглетона. }
 end;//Tl3ConvertersList

implementation

uses
  l3Base {a}
  ;


// start class Tl3ConvertersList

var g_Tl3ConvertersList : Tl3ConvertersList = nil;

procedure Tl3ConvertersListFree;
begin
 l3Free(g_Tl3ConvertersList);
end;

class function Tl3ConvertersList.Instance: Tl3ConvertersList;
begin
 if (g_Tl3ConvertersList = nil) then
 begin
  l3System.AddExitProc(Tl3ConvertersListFree);
  g_Tl3ConvertersList := Create;
 end;
 Result := g_Tl3ConvertersList;
end;


class function Tl3ConvertersList.Exists: Boolean;
 {-}
begin
 Result := g_Tl3ConvertersList <> nil;
end;//Tl3ConvertersList.Exists

procedure Tl3ConvertersList.InitFields;
//#UC START# *47A042E100E2_4DD4F30E00C6_var*
//#UC END# *47A042E100E2_4DD4F30E00C6_var*
begin
//#UC START# *47A042E100E2_4DD4F30E00C6_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4DD4F30E00C6_impl*
end;//Tl3ConvertersList.InitFields

end.