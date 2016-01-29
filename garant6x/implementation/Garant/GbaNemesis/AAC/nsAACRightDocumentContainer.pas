unit nsAACRightDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AAC$DataSources"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/AAC/nsAACRightDocumentContainer.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������������� �������::AAC::AAC$DataSources::AACImplementation::TnsAACRightDocumentContainer
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
  nsAACDocumentContainerPrim
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsAACRightDocumentContainer = class(TnsAACDocumentContainerPrim)
 protected
 // realized methods
   function AcceptableBlockViewKinds: TnsBlockViewKinds; override;
 end;//TnsAACRightDocumentContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  evdTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsAACRightDocumentContainer

function TnsAACRightDocumentContainer.AcceptableBlockViewKinds: TnsBlockViewKinds;
//#UC START# *500E7677002B_500E75C90024_var*
//#UC END# *500E7677002B_500E75C90024_var*
begin
//#UC START# *500E7677002B_500E75C90024_impl*
 Result := [ev_bvkRight];
//#UC END# *500E7677002B_500E75C90024_impl*
end;//TnsAACRightDocumentContainer.AcceptableBlockViewKinds

{$IfEnd} //not Admin AND not Monitorings

end.