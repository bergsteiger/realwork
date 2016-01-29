unit NOT_FINISHED_l3BaseStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3BaseStream.pas"
// �����: 29.08.2001 10:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3BaseStream
//
// ������� ����� �������, �������������� ������� ������ � ���������� IUnknown � IStream
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3InternalInterfaces,
  ActiveX,
  Classes,
  l3IID,
  l3PureMixIns
  ;

type
 _l3Unknown_Parent_ = TStream;
 {$Include ..\L3\l3Unknown.imp.pas}
 Tl3Stream = class(_l3Unknown_, Il3ObjectWrap, IStream)
  {* ������� ����� �������, �������������� ������� ������ � ���������� IUnknown � IStream }
 protected
 // realized methods
   function GetObject: TObject;
     {* �������� ������ �� �������. }
   function Read(var Buffer;
    Count: Integer): Integer; override;
   function Write(const Buffer;
    Count: Integer): Integer; override;
 protected
 // protected methods
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; virtual;
     {* ����� ��� ���������� QueryInterface (��� ���������� � ��������) }
 end;//Tl3Stream

implementation

uses
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked
  ;

{$Include ..\L3\l3Unknown.imp.pas}

// start class Tl3Stream

function Tl3Stream.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *48F475350256_48F4748E0192_var*
//#UC END# *48F475350256_48F4748E0192_var*
begin
//#UC START# *48F475350256_48F4748E0192_impl*
 !!! Needs to be implemented !!!
//#UC END# *48F475350256_48F4748E0192_impl*
end;//Tl3Stream.COMQueryInterface

function Tl3Stream.GetObject: TObject;
//#UC START# *476F6F6F00EE_48F4748E0192_var*
//#UC END# *476F6F6F00EE_48F4748E0192_var*
begin
//#UC START# *476F6F6F00EE_48F4748E0192_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F6F6F00EE_48F4748E0192_impl*
end;//Tl3Stream.GetObject

function Tl3Stream.Read(var Buffer;
  Count: Integer): Integer;
//#UC START# *49BE656C006E_48F4748E0192_var*
//#UC END# *49BE656C006E_48F4748E0192_var*
begin
//#UC START# *49BE656C006E_48F4748E0192_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BE656C006E_48F4748E0192_impl*
end;//Tl3Stream.Read

function Tl3Stream.Write(const Buffer;
  Count: Integer): Integer;
//#UC START# *49BE658C0261_48F4748E0192_var*
//#UC END# *49BE658C0261_48F4748E0192_var*
begin
//#UC START# *49BE658C0261_48F4748E0192_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BE658C0261_48F4748E0192_impl*
end;//Tl3Stream.Write

end.