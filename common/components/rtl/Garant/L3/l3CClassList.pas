unit l3CClassList;
 {* ���������� ������ �������. }

// ������: "w:\common\components\rtl\Garant\L3\l3CClassList.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3CClassList" MUID: (4773DC3502A7)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ClassList
;

type
 Tl3CClassList = class(Tl3ClassList)
  {* ���������� ������ �������. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3CClassList

implementation

uses
 l3ImplUses
 //#UC START# *4773DC3502A7impl_uses*
 //#UC END# *4773DC3502A7impl_uses*
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3CClassList.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_4773DC3502A7_var*
//#UC END# *47A6FEE600FC_4773DC3502A7_var*
begin
//#UC START# *47A6FEE600FC_4773DC3502A7_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DC3502A7_impl*
end;//Tl3CClassList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
