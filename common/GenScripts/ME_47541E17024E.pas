unit l3InterfacedComponent;

interface

uses
 l3IntfUses
 , Classes
 , l3IID
;

type
 Tl3InterfacedComponent = class(_l3Unknown_)
  {* ������� ����� �����������, �������������� ������� ������ � ���������� IUnknown. }
  function COMQueryInterface(const IID: Tl3GUID;
   out Obj): Tl3HResult;
   {* ����� ��� ���������� QueryInterface (��� ���������� � ��������). }
  procedure CreateX;
 end;//Tl3InterfacedComponent
 
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
