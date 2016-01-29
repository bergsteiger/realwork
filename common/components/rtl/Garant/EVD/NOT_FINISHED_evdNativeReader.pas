unit NOT_FINISHED_evdNativeReader;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/NOT_FINISHED_evdNativeReader.pas"
// Начат: 05.10.1999 13:53
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Readers::TevdNativeReader
//
// Читатель тегов в формате evd.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2CustomFileParser
  ;

type
 TevdNativeReader = class(Tk2CustomFileParser)
  {* Читатель тегов в формате evd. }
 end;//TevdNativeReader

implementation

uses
  evdNativeReaderServices
  ;

end.