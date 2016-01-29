unit m3BackupTools;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3$DB"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/m3/m3BackupTools.pas"
// Начат: 01.12.2002 15:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::m3$DB::m3DB::m3BackupTools
//
// Утилиты для работы с хранилищем документов Архивариуса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Interfaces,
  m3DBInterfaces,
  m3StorageInterfaces
  ;

type
 Tm3BaseSummary = record
  {* Информация о диапазоне номеров долкументов }
   rMin : Int64;
   rMax : Int64;
 end;//Tm3BaseSummary

 Tm3DocPartSelector_Names_Array = array [Tm3DocPartSelector] of AnsiString;
  {* Массив Tm3DocPartSelector }

const
  { Constants }
 m3_cExchangeExt = '.sav';
 m3_cMainExt = '.stg';
 m3_cSummary = 'summary';
 m3_cObject = 'object';
 m3_cDocPartName : Tm3DocPartSelector_Names_Array = ('main', 'anno', m3_cSummary, m3_cObject);

function m3GetBaseSummary(const aBase: Im3IndexedStorage;
  out theSumm: Tm3BaseSummary): Boolean; overload; 
   {* получить информациею об основном хранилище }
function m3GetBaseSummary(const aBase: Im3IndexedStorage;
  aMode: Tm3StoreAccess): IStream; overload; 
   {* получить поток с информацией об основном хранилище }

implementation

uses
  SysUtils,
  m3StorageTools,
  ComObj,
  l3String,
  l3Base,
  l3Const,
  m2COMLib,
  m3StgMgr,
  Windows,
  l3Date,
  m3StorageElementIDList
  ;

// unit methods

function m3GetBaseSummary(const aBase: Im3IndexedStorage;
  out theSumm: Tm3BaseSummary): Boolean;
//#UC START# *49B92E2D02CD_49B141B8022F_var*
var
 l_Stream : IStream;
 l_Read   : Integer;
//#UC END# *49B92E2D02CD_49B141B8022F_var*
begin
//#UC START# *49B92E2D02CD_49B141B8022F_impl*
 l_Stream := m3GetBaseSummary(aBase, m3_saRead);
 try
  Result := (l_Stream <> nil) AND
            (l_Stream.Read(@theSumm, SizeOf(theSumm), @l_Read) = S_Ok) AND
            (l_Read = SizeOf(theSumm));
 finally
  l_Stream := nil;
 end;//try..finally
 if not Result then
 begin
  l3FillChar(theSumm, SizeOf(theSumm), 0);
  theSumm.rMin := High(theSumm.rMin);
 end;//not Result
//#UC END# *49B92E2D02CD_49B141B8022F_impl*
end;//m3GetBaseSummary

function m3GetBaseSummary(const aBase: Im3IndexedStorage;
  aMode: Tm3StoreAccess): IStream;
//#UC START# *49B92E450104_49B141B8022F_var*
//#UC END# *49B92E450104_49B141B8022F_var*
begin
//#UC START# *49B92E450104_49B141B8022F_impl*
 m3COMSafeOpenStream(aBase, l3PCharLen(AnsiString(m3_cSummary)), aMode, aMode <> m3_saRead, Result, false);
//#UC END# *49B92E450104_49B141B8022F_impl*
end;//m3GetBaseSummary

end.