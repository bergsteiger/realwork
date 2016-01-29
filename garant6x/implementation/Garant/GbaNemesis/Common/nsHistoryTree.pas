unit nsHistoryTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Common$Lib"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsHistoryTree.pas"
// �����: 2004/12/06 10:34:07
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::MainMenu::TnsHistoryTree
//
// �������� ���� � ������ ����� ��� �������� ���������� ��������� �������� ��������� � �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsBaseMainMenuTree
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsHistoryTree = class(TnsBaseMainMenuTree)
  {* �������� ���� � ������ ����� ��� �������� ���������� ��������� �������� ��������� � ������� }
 private
 // private fields
   f_MaxCount : Integer;
    {* ���� ��� �������� MaxCount}
 public
 // public methods
   constructor Create(aMaxCount: Integer); reintroduce;
 public
 // public properties
   property MaxCount: Integer
     read f_MaxCount;
     {* ���������� ������������ ���������� ��������� � ������. ���� �������� �������������� ���������� ��������� }
 end;//TnsHistoryTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsHistoryTree

constructor TnsHistoryTree.Create(aMaxCount: Integer);
//#UC START# *490AE2F50049_490AE2C7034B_var*
//#UC END# *490AE2F50049_490AE2C7034B_var*
begin
//#UC START# *490AE2F50049_490AE2C7034B_impl*
 inherited Create;
 f_MaxCount := aMaxCount;
//#UC END# *490AE2F50049_490AE2C7034B_impl*
end;//TnsHistoryTree.Create

{$IfEnd} //not Admin AND not Monitorings

end.