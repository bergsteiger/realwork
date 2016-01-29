unit NOT_FINISHED_m3StgMgr;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3$DB"
// Модуль: "w:/common/components/rtl/Garant/m3/NOT_FINISHED_m3StgMgr.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::m3$DB::m3DB::m3StgMgr
//
// Классы-менеджеры для работы с IStorage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\m3\m3Define.inc}

interface

type
 Tm3StorageManager = class
 end;//Tm3StorageManager

 Tm3FullModeStorageManager = class(Tm3StorageManager)
 end;//Tm3FullModeStorageManager

 Tm3ReadModeStorageManager = class(Tm3StorageManager)
 end;//Tm3ReadModeStorageManager

implementation

uses
  m3FileStream,
  m3SplittedFileStream,
  m3ArchiveStorage,
  m3StorageService
  ;

end.