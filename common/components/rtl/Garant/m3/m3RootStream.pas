unit m3RootStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3"
// ������: "w:/common/components/rtl/Garant/m3/m3RootStream.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3RootStream
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  ActiveX,
  l3Logger,
  m3BaseHeaderStream
  ;

type
 Tm3RootStreamHeader = packed record
  {* ��������� ������ � ������� ����� IStorage.

������ ������������ ����� ���������������� ������, ����� ��� �� ��� ��� ������� �� �������������. }
//#UC START# *53FEFB4C03AEpubl*
    rZerroFrontierByte: Byte;
      {* - ��������� ����. }
    rFirstFreeFATElement: Int64;
      {* - ������ ��������� ������� FAT. }
    rRootStorageFATElement: Int64;
      {* - ��������� ������� ����� IStorage. }
    rFirstFreeCluster: Int64;
      {* - ������ ��������� �������. }
    rClusterBodySize: LongInt;
      {* - ������ ���� ��������. }
    rAllocatedStreamSize: Int64;
      {* - ������ ��������� ������. }
//#UC END# *53FEFB4C03AEpubl*
 end;//Tm3RootStreamHeader

 Rm3RootStream = class of Tm3RootStream;

 _HeaderType_ = Tm3RootStreamHeader;
 {$Include ..\m3\m3RootStream.imp.pas}
 Tm3RootStream = class(_m3RootStream_)
 public
 // realized methods
   class function HeaderID: TCLSID; override;
   class function DefaultHeaderValue: _HeaderType_; override;
 public
 // public methods
   procedure ForceLockHeader;
     {* �������������� ��������� ��������� ������. }
 end;//Tm3RootStream

implementation

uses
  Windows,
  m3StorageBlock,
  SysUtils,
  m2AddDbg,
  m2AddPrc,
  m2COMLib,
  m2MemLib,
  l3Base,
  ComObj,
  m3Const
  ;

{$Include ..\m3\m3RootStream.imp.pas}

// start class Tm3RootStream

procedure Tm3RootStream.ForceLockHeader;
//#UC START# *542BEDF501C7_53FDE7290320_var*
const
 cMaxTry = 1000;
var
 l_TryCount : Integer;
 l_S        : AnsiString;
//#UC END# *542BEDF501C7_53FDE7290320_var*
begin
//#UC START# *542BEDF501C7_53FDE7290320_impl*
 l_TryCount := 0;
 while (l_TryCount < cMaxTry) do
 begin
  Inc(l_TryCount);
  try
   LockHeader;
  except
   on E: EOleSysError do
    if (E.ErrorCode = STG_E_LOCKVIOLATION) then
    begin
     if (l_TryCount < cMaxTry) then
     begin
      l_S := '������� �������� ��������� ����� ' + IntToStr(l_TryCount);
      l3System.Msg2Log(l_S);
      if (Logger <> nil) then
       Logger.ToLog(l_S);
      Sleep(0);
      continue;
     end//l_TryCount < cMaxTry
     else
      raise;
    end//E.ErrorCode = STG_E_LOCKVIOLATION
    else
     raise;
  end;//try..except
  break;
 end;//while (l_TryCount < cMaxTry)
//#UC END# *542BEDF501C7_53FDE7290320_impl*
end;//Tm3RootStream.ForceLockHeader

class function Tm3RootStream.HeaderID: TCLSID;
//#UC START# *53FDFAF900ED_53FDE7290320_var*
const
 cHeaderID : TCLSID = '{37E90B6E-5CBC-4EB3-BF2C-75EDF2924172}';
//#UC END# *53FDFAF900ED_53FDE7290320_var*
begin
//#UC START# *53FDFAF900ED_53FDE7290320_impl*
 Result := cHeaderID;
//#UC END# *53FDFAF900ED_53FDE7290320_impl*
end;//Tm3RootStream.HeaderID

class function Tm3RootStream.DefaultHeaderValue: _HeaderType_;
//#UC START# *53FF37DC003A_53FDE7290320_var*
const
  CHeaderData000 : Tm3RootStreamHeader = (
   rZerroFrontierByte:
    0;
   rFirstFreeFATElement:
    Int64(-1);
   rRootStorageFATElement:
    Int64(-1);
   rFirstFreeCluster:
    Int64(-1);
   rClusterBodySize:
    m3ClusterSize - SizeOf(Tm3StorageBlockHeader);
   rAllocatedStreamSize:
    0
  );
//#UC END# *53FF37DC003A_53FDE7290320_var*
begin
//#UC START# *53FF37DC003A_53FDE7290320_impl*
 Result := CHeaderData000;
//#UC END# *53FF37DC003A_53FDE7290320_impl*
end;//Tm3RootStream.DefaultHeaderValue

end.