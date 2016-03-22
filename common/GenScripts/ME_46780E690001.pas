unit l3CacheableBase;
 {* ������� ����� ��� ���������� �������� }

// ������: "w:\common\components\rtl\Garant\L3\l3CacheableBase.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3CacheableBase" MUID: (46780E690001)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
;

type
 Tl3CacheableBase = class(Tl3SimpleObject)
  {* ������� ����� ��� ���������� �������� }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3CacheableBase

implementation

uses
 l3ImplUses
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3CacheableBase.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_46780E690001_var*
//#UC END# *47A6FEE600FC_46780E690001_var*
begin
//#UC START# *47A6FEE600FC_46780E690001_impl*
 Result := true;
//#UC END# *47A6FEE600FC_46780E690001_impl*
end;//Tl3CacheableBase.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
