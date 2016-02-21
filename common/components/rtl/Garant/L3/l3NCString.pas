unit l3NCString;
 {* �������������� ������������ ������. }

// ������: "w:\common\components\rtl\Garant\L3\l3NCString.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3_String
;

type
 Tl3NCString = class(Tl3_String)
  {* �������������� ������������ ������. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3NCString

implementation

uses
 l3ImplUses
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3NCString.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_47BC50F5038E_var*
//#UC END# *47A6FEE600FC_47BC50F5038E_var*
begin
//#UC START# *47A6FEE600FC_47BC50F5038E_impl*
 Result := false;
//#UC END# *47A6FEE600FC_47BC50F5038E_impl*
end;//Tl3NCString.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
