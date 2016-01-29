unit l3AsyncTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3AsyncTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::MultiThread::Tl3AsyncTask
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
 Tl3AsyncTask = class(Tl3ProtoObject)
 public
 // public methods
   procedure Exec; virtual; abstract;
     {* Сигнатура метода Exec }
 end;//Tl3AsyncTask

implementation

end.