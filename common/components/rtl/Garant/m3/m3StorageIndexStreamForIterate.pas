unit m3StorageIndexStreamForIterate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3"
// ������: "w:/common/components/rtl/Garant/m3/m3StorageIndexStreamForIterate.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3StorageIndexStreamForIterate
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3StorageIndexStream
  ;

type
 Tm3StorageIndexStreamForIterate = class(Tm3StorageIndexStream)
 protected
 // overridden protected methods
   class function NeedBuffering: Boolean; override;
 end;//Tm3StorageIndexStreamForIterate

implementation

// start class Tm3StorageIndexStreamForIterate

class function Tm3StorageIndexStreamForIterate.NeedBuffering: Boolean;
//#UC START# *544A2D9F0368_544A2D800202_var*
//#UC END# *544A2D9F0368_544A2D800202_var*
begin
//#UC START# *544A2D9F0368_544A2D800202_impl*
 Result := true;
//#UC END# *544A2D9F0368_544A2D800202_impl*
end;//Tm3StorageIndexStreamForIterate.NeedBuffering

end.