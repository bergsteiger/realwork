unit NOT_FINISHED_m3NewStorage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/NOT_FINISHED_m3NewStorage.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::m3::Storage::m3NewStorage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3CustomNewStorage
  ;

type
 Tm3NewStorage = class(Tm3CustomNewStorage)
 end;//Tm3NewStorage

implementation

uses
  m3TempEnumStatStg,
  m3RootStream,
  m3StoreHeaderData,
  m3RootStreamNew,
  m3StoreHeaderDataNew,
  m3StoreHeader,
  m3StorageBlock,
  m3NewRootStreamManager,
  m3TOCHandle,
  m3ReadOnlyRootStreamManager,
  m3NewStorageStream,
  m3StorageIndexStream,
  m3StorageTableOfContentsStream,
  m3StorageIndexStreamForIterate
  ;

end.