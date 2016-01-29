unit l3BaseWithID;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3BaseWithID.pas"
// Начат: 02.12.2003 13:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3BaseWithID
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject
  ;

type
 Tl3BaseWithID = class(Tl3ProtoObject)
 private
 // private fields
   f_ID : Integer;
    {* Поле для свойства ID}
 public
 // public methods
   constructor Create(aHandle: Integer); reintroduce; virtual;
 public
 // public properties
   property ID: Integer
     read f_ID;
 end;//Tl3BaseWithID

implementation

// start class Tl3BaseWithID

constructor Tl3BaseWithID.Create(aHandle: Integer);
//#UC START# *47BD8AF20271_47BD85FA015F_var*
//#UC END# *47BD8AF20271_47BD85FA015F_var*
begin
//#UC START# *47BD8AF20271_47BD85FA015F_impl*
 inherited Create;
 f_ID := aHandle;
//#UC END# *47BD8AF20271_47BD85FA015F_impl*
end;//Tl3BaseWithID.Create

end.