unit NOT_FINISHED_l3BaseStream;
 {* ������� ����� �������, �������������� ������� ������ � ���������� IUnknown � IStream }

// ������: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3BaseStream.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , Classes
 , l3InternalInterfaces
 , ActiveX
 , l3IID
 , l3PureMixIns
;

type
 _l3Unknown_Parent_ = TStream;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 Tl3Stream = class(_l3Unknown_, Il3ObjectWrap, IStream)
  {* ������� ����� �������, �������������� ������� ������ � ���������� IUnknown � IStream }
  protected
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; virtual;
    {* ����� ��� ���������� QueryInterface (��� ���������� � ��������) }
   function GetObject: TObject;
    {* �������� ������ �� �������. }
  public
   function Read(var Buffer;
    Count: Integer): Integer; override;
   function Write(const Buffer;
    Count: Integer): Integer; override;
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

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

function Tl3Stream.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* ����� ��� ���������� QueryInterface (��� ���������� � ��������) }
//#UC START# *48F475350256_48F4748E0192_var*
//#UC END# *48F475350256_48F4748E0192_var*
begin
//#UC START# *48F475350256_48F4748E0192_impl*
 !!! Needs to be implemented !!!
//#UC END# *48F475350256_48F4748E0192_impl*
end;//Tl3Stream.COMQueryInterface

function Tl3Stream.GetObject: TObject;
 {* �������� ������ �� �������. }
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
