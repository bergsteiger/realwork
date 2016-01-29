unit evdNcsTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/evdNcsTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EVD::Standard::evdNcsTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

type
 TncsMessageKind = (
   ncs_mkMessage // Сообщение на которое ожидается ответ
 , ncs_mkReply // Ответ на сообщение
 , ncs_mkSignal // Сообщение на которое НЕ ожидается ответ
 );//TncsMessageKind

 TncsResultKind = (
   ncs_rkOk
 , ncs_rkFail
 , ncs_rkRetry
 , ncs_rkEmpty
 );//TncsResultKind

implementation

end.