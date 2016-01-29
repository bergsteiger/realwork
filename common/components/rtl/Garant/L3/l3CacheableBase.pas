unit l3CacheableBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3CacheableBase.pas"
// �����: 12.04.1998 16:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CacheableBase
//
// ������� ����� ��� ���������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleObject
  ;

type
 Tl3CacheableBase = class(Tl3SimpleObject)
  {* ������� ����� ��� ���������� �������� }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tl3CacheableBase

implementation

// start class Tl3CacheableBase

{$If not defined(DesignTimeLibrary)}
class function Tl3CacheableBase.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_46780E690001_var*
//#UC END# *47A6FEE600FC_46780E690001_var*
begin
//#UC START# *47A6FEE600FC_46780E690001_impl*
 Result := true;
//#UC END# *47A6FEE600FC_46780E690001_impl*
end;//Tl3CacheableBase.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.