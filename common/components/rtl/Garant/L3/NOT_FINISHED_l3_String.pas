unit NOT_FINISHED_l3_String;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3_String.pas"
// Начат: 18.01.2008 15:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3_String
//
// Класс реализующий строки с собственным методом хранения данных.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3CustomString
  ;

type
 Tl3_String = class(Tl3CustomString)
  {* Класс реализующий строки с собственным методом хранения данных. }
 private
 // private fields
   f_String : Tl3WStrCast;
 public
 // public methods
   procedure NotifyDeletion(aPos: Integer;
     aLen: Integer); virtual;
 end;//Tl3_String

implementation

// start class Tl3_String

procedure Tl3_String.NotifyDeletion(aPos: Integer;
  aLen: Integer);
//#UC START# *4FB10B1D016B_4773DED9004C_var*
//#UC END# *4FB10B1D016B_4773DED9004C_var*
begin
//#UC START# *4FB10B1D016B_4773DED9004C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FB10B1D016B_4773DED9004C_impl*
end;//Tl3_String.NotifyDeletion

end.