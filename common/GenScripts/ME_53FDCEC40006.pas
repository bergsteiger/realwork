unit m3CustomHeaderStream.imp;

interface

uses
 l3IntfUses
 , m3BaseHeaderStream
 , ActiveX
;

type
 // _HeaderType_
 
 _m3CustomHeaderStream_ = class(Tm3BaseHeaderStream)
  {* ����� � ����������-��������������� }
  procedure Create(const aStream: IStream;
   aAccess: Integer);
  function DefaultHeaderValue: _HeaderType_;
  function NeedHeaderAlignment: Boolean;
  procedure DoLoadHeader;
   {* ��������� ��������� � ������ }
  procedure DoSaveHeader(aForceSave: Boolean);
   {* ��������� ��������� }
 end;//_m3CustomHeaderStream_
 
implementation

uses
 l3ImplUses
 , m2AddDbg
 , m2AddPrc
 , m2COMLib
 , m2MemLib
 , l3Base
 , ComObj
 , m3Const
;

end.
