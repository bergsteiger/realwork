unit m3RootStream;

interface

uses
 l3IntfUses
 , ActiveX
;

type
 Tm3RootStreamHeader = record
  {* ��������� ������ � ������� ����� IStorage.

������ ������������ ����� ���������������� ������, ����� ��� �� ��� ��� ������� �� �������������. }
 end;//Tm3RootStreamHeader
 
 Rm3RootStream = class of Tm3RootStream;
 
 Tm3RootStream = class(_m3RootStream_)
  procedure ForceLockHeader;
   {* �������������� ��������� ��������� ������. }
  function HeaderID: TCLSID;
  function DefaultHeaderValue: _HeaderType_;
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

end.
