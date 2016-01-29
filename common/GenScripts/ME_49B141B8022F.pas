unit m3BackupTools;

interface

uses
 l3IntfUses
 , l3Interfaces
 , m3StorageInterfaces
 , m3DBInterfaces
;

type
 Tm3BaseSummary = record
  {* Информация о диапазоне номеров долкументов }
 end;//Tm3BaseSummary
 
 Tm3DocPartSelector_Names_Array = array [Tm3DocPartSelector] of AnsiString;
  {* Массив Tm3DocPartSelector }
 
implementation

uses
 l3ImplUses
 , SysUtils
 , m3StorageTools
 , ComObj
 , l3String
 , l3Base
 , l3Const
 , m2COMLib
 , m3StgMgr
 , Windows
 , l3Date
 , m3StorageElementIDList
;

end.
