unit m3NewVersionStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3$DB"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/m3/m3NewVersionStream.pas"
// �����: 17.03.2009 20:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3$DB::m3DB::Tm3NewVersionStream
//
// �����, ��������� ����� ������ ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3DBProxyWriteStream
  ;

type
 Tm3NewVersionStream = class(Tm3DBProxyWriteStream)
  {* �����, ��������� ����� ������ ��������� }
 protected
 // overridden property methods
   function pm_GetIsNewVersion: Boolean; override;
 end;//Tm3NewVersionStream

implementation

// start class Tm3NewVersionStream

function Tm3NewVersionStream.pm_GetIsNewVersion: Boolean;
//#UC START# *49BFE6600304_49BFE43D019Fget_var*
//#UC END# *49BFE6600304_49BFE43D019Fget_var*
begin
//#UC START# *49BFE6600304_49BFE43D019Fget_impl*
 Result := true;
//#UC END# *49BFE6600304_49BFE43D019Fget_impl*
end;//Tm3NewVersionStream.pm_GetIsNewVersion

end.