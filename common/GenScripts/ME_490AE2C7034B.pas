unit nsHistoryTree;
 {* �������� ���� � ������ ����� ��� �������� ���������� ��������� �������� ��������� � ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsHistoryTree.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsHistoryTree" MUID: (490AE2C7034B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsBaseMainMenuTree
;

type
 TnsHistoryTree = class(TnsBaseMainMenuTree)
  {* �������� ���� � ������ ����� ��� �������� ���������� ��������� �������� ��������� � ������� }
  private
   f_MaxCount: Integer;
    {* ���� ��� �������� MaxCount }
  public
   constructor Create(aMaxCount: Integer); reintroduce;
  public
   property MaxCount: Integer
    read f_MaxCount;
    {* ���������� ������������ ���������� ��������� � ������. ���� �������� �������������� ���������� ��������� }
 end;//TnsHistoryTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

constructor TnsHistoryTree.Create(aMaxCount: Integer);
//#UC START# *490AE2F50049_490AE2C7034B_var*
//#UC END# *490AE2F50049_490AE2C7034B_var*
begin
//#UC START# *490AE2F50049_490AE2C7034B_impl*
 inherited Create;
 f_MaxCount := aMaxCount;
//#UC END# *490AE2F50049_490AE2C7034B_impl*
end;//TnsHistoryTree.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
