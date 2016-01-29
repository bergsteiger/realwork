unit l3BaseStream;

interface

uses
 l3IntfUses
 , Classes
 , l3InternalInterfaces
 , ActiveX
 , l3IID
;

type
 Tl3Stream = class(_l3Unknown_, Il3ObjectWrap, IStream)
  {* ������� ����� �������, �������������� ������� ������ � ���������� IUnknown � IStream }
  function COMQueryInterface(const IID: Tl3GUID;
   out Obj): Tl3HResult;
   {* ����� ��� ���������� QueryInterface (��� ���������� � ��������) }
  function GetObject: TObject;
   {* �������� ������ �� �������. }
  function Read(var Buffer;
   Count: Integer): Integer;
  function Write(Buffer;
   Count: Integer): Integer;
 end;//Tl3Stream
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
