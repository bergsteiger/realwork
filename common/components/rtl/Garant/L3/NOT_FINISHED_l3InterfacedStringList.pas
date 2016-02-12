unit NOT_FINISHED_l3InterfacedStringList;
 {* ����� ����������� ������ ����� �� ���������� ������������ }

// ������: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3InterfacedStringList.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3StringList
 , l3_String
;

type
 Tl3InterfacedString = class(Tl3_String)
  {* ����� ����������� ������ � ������������ �������� ���������� }
  private
   f_Intf: IUnknown;
    {* ���� ��� �������� Intf }
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure ClearFields; override;
  public
   property Intf: IUnknown
    read f_Intf
    write f_Intf;
 end;//Tl3InterfacedString

 Tl3InterfacedStringList = class(Tl3StringList)
  {* ����� ����������� ������ ����� �� ���������� ������������ }
 end;//Tl3InterfacedStringList

implementation

uses
 l3ImplUses
;

procedure Tl3InterfacedString.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4912AA1802AD_var*
//#UC END# *479731C50290_4912AA1802AD_var*
begin
//#UC START# *479731C50290_4912AA1802AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_4912AA1802AD_impl*
end;//Tl3InterfacedString.Cleanup

procedure Tl3InterfacedString.ClearFields;
begin
 Intf := nil;
 inherited;
end;//Tl3InterfacedString.ClearFields

end.
