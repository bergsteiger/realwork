unit NOT_FINISHED_m3Exceptions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/NOT_FINISHED_m3Exceptions.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::m3::Streams::m3Exceptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Except
  ;

type
 Em3Exception = class(El3Exception)
 end;//Em3Exception

 Em3InvalidStream = class(Em3Exception)
 end;//Em3InvalidStream

 Em3NilStream = class(Em3InvalidStream)
 end;//Em3NilStream

 Em3NoIndex = class(Em3Exception)
 end;//Em3NoIndex

implementation

uses
  SysUtils
  ;

end.