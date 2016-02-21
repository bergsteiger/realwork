unit l3CObjectList;
 {* ���������� ������ ���������� �� �������. }

// ������: "w:\common\components\rtl\Garant\L3\l3CObjectList.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ObjectList
;

type
 Tl3CObjectList = class(Tl3ObjectList)
  {* ���������� ������ ���������� �� �������. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3CObjectList

implementation

uses
 l3ImplUses
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3CObjectList.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_4773DBEA0260_var*
//#UC END# *47A6FEE600FC_4773DBEA0260_var*
begin
//#UC START# *47A6FEE600FC_4773DBEA0260_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DBEA0260_impl*
end;//Tl3CObjectList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
