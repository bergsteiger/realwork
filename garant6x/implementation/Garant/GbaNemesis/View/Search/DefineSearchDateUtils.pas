unit DefineSearchDateUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/DefineSearchDateUtils.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 �������� ����������::Search::View::Search::DefineSearchDateUtils
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
function CompareButtons(Item1: Pointer;
  Item2: Pointer): Integer;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;

// unit methods

function CompareButtons(Item1: Pointer;
  Item2: Pointer): Integer;
//#UC START# *51B5CA81031F_51B5CB1100AE_var*
//#UC END# *51B5CA81031F_51B5CB1100AE_var*
begin
//#UC START# *51B5CA81031F_51B5CB1100AE_impl*
 Result := TWinControl(Item1).TabOrder - TWinControl(Item2).TabOrder;
//#UC END# *51B5CA81031F_51B5CB1100AE_impl*
end;//CompareButtons
{$IfEnd} //not Admin AND not Monitorings

end.