unit m3BaseHeaderStream;

interface

uses
 l3IntfUses
 , m3LinkedStream
 , Classes
 , m3Const
;

type
 Tm3BaseHeaderStream = class(Tm3LinkedStream)
  procedure LockHeader;
   {* ��������� ��������� }
  procedure UnlockHeader;
   {* ��������� ��������� }
  procedure DoSaveHeader(aForceSave: Boolean);
   {* ��������� ��������� }
  procedure DoLoadHeader;
   {* ��������� ��������� � ������ }
  procedure LoadHeader;
  procedure SaveHeader(aForceSave: Boolean);
  procedure DefaultInitAction;
  procedure DefaultDoneAction;
  function DoLockHeader: Boolean;
  function DoUnlockHeader: Boolean;
 end;//Tm3BaseHeaderStream
 
implementation

uses
 l3ImplUses
 , ComObj
 , m2COMLib
 , ActiveX
 , l3Base
 , l3Interlocked
;

end.
