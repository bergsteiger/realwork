unit NOT_FINISHED_evdSchema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evdSchema.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Schemas::evdSchema
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest\evDefine.inc}

interface


implementation

uses
  evNative_Schema
  {$If defined(Archi)}
  ,
  evArchi_Schema
  {$IfEnd} //Archi
  
  {$If defined(evMyEditor)}
  ,
  My_Schema
  {$IfEnd} //evMyEditor
  ,
  Everest_Schema
  {$If defined(DesignTimeLibrary)}
  ,
  Design_Schema
  {$IfEnd} //DesignTimeLibrary
  
  ;

end.