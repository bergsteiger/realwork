unit NOT_FINISHED_csMessageRecepient;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_csMessageRecepient.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsMessageRecepient
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  ddClientMessageSortableList
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsMessageRecepient = class(Tl3ProtoObject)
 private
 // private fields
   f_Messages : TddClientMessageSortableList;
    {* Поле для свойства Messages}
 public
 // public properties
   property Messages: TddClientMessageSortableList
     read f_Messages;
 end;//TcsMessageRecepient
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.