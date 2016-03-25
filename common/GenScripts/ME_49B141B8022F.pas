unit m3BackupTools;
 {* ������� ��� ������ � ���������� ���������� ����������� }

// ������: "w:\common\components\rtl\Garant\m3\m3BackupTools.pas"
// ���������: "UtilityPack"
// ������� ������: "m3BackupTools" MUID: (49B141B8022F)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , m3StorageInterfaces
 , m3DBInterfaces
;

type
 Tm3BaseSummary = record
  {* ���������� � ��������� ������� ����������� }
  rMin: Int64;
  rMax: Int64;
 end;//Tm3BaseSummary

 Tm3DocPartSelector_Names_Array = array [Tm3DocPartSelector] of AnsiString;
  {* ������ Tm3DocPartSelector }

const
 m3_cExchangeExt = '.sav';
 m3_cMainExt = '.stg';
 m3_cSummary = 'summary';
 m3_cObject = 'object';
 m3_cDocPartName: Tm3DocPartSelector_Names_Array = ('main', 'anno', m3_cSummary, m3_cObject);

function m3GetBaseSummary(const aBase: Im3IndexedStorage;
 out theSumm: Tm3BaseSummary): Boolean; overload;
 {* �������� ����������� �� �������� ��������� }
function m3GetBaseSummary(const aBase: Im3IndexedStorage;
 aMode: Tm3StoreAccess): IStream; overload;
 {* �������� ����� � ����������� �� �������� ��������� }

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

function m3GetBaseSummary(const aBase: Im3IndexedStorage;
 out theSumm: Tm3BaseSummary): Boolean;
 {* �������� ����������� �� �������� ��������� }
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
 {* �������� ����� � ����������� �� �������� ��������� }
//#UC START# *49B92E450104_49B141B8022F_var*
//#UC END# *49B92E450104_49B141B8022F_var*
begin
//#UC START# *49B92E450104_49B141B8022F_impl*
 m3COMSafeOpenStream(aBase, l3PCharLen(AnsiString(m3_cSummary)), aMode, aMode <> m3_saRead, Result, false);
//#UC END# *49B92E450104_49B141B8022F_impl*
end;//m3GetBaseSummary

end.
