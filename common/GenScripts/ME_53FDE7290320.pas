unit m3RootStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3RootStream.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , ActiveX
 , l3Logger
 , m3BaseHeaderStream
;

type
 Rm3RootStream = class of Tm3RootStream;

 Tm3RootStreamHeader = packed record
  {* Заголовок потока в котором живет IStorage.

Данные определяются через пользовательскую секцию, чтобы они не дай бог местами не переставились. }
 //#UC START# *53FEFB4C03AEpubl*
    rZerroFrontierByte: Byte;
      {* - начальный ноль. }
    rFirstFreeFATElement: Int64;
      {* - первый свободный элемент FAT. }
    rRootStorageFATElement: Int64;
      {* - начальная позиция корня IStorage. }
    rFirstFreeCluster: Int64;
      {* - первый свободный кластер. }
    rClusterBodySize: LongInt;
      {* - размер ТЕЛА кластера. }
    rAllocatedStreamSize: Int64;
      {* - размер корневого потока. }
 //#UC END# *53FEFB4C03AEpubl*
 end;//Tm3RootStreamHeader

 _HeaderType_ = Tm3RootStreamHeader;
 {$Include w:\common\components\rtl\Garant\m3\m3RootStream.imp.pas}
 Tm3RootStream = class(_m3RootStream_)
  public
   procedure ForceLockHeader;
    {* Гарантированно блокирует заголовок потока. }
   class function HeaderID: TCLSID; override;
   class function DefaultHeaderValue: _HeaderType_; override;
 end;//Tm3RootStream

implementation

uses
 l3ImplUses
 , m3StorageBlock
 , SysUtils
 , m2AddDbg
 , m2AddPrc
 , m2COMLib
 , m2MemLib
 , l3Base
 , ComObj
 , m3Const
 , Windows
;

{$Include w:\common\components\rtl\Garant\m3\m3RootStream.imp.pas}

procedure Tm3RootStream.ForceLockHeader;
 {* Гарантированно блокирует заголовок потока. }
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
      l_S := 'Попытка залочить заголовок номер ' + IntToStr(l_TryCount);
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
