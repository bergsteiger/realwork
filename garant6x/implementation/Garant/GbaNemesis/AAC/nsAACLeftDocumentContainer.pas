unit nsAACLeftDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AAC$DataSources"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/AAC/nsAACLeftDocumentContainer.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������������� �������::AAC::AAC$DataSources::AACImplementation::TnsAACLeftDocumentContainer
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
 TnsAACLeftDocumentContainer = class(TnsAACDocumentContainerPrim)
 protected
 // realized methods
   function AcceptableBlockViewKinds: TnsBlockViewKinds; override;
 end;//TnsAACLeftDocumentContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  evdTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsAACLeftDocumentContainer

function TnsAACLeftDocumentContainer.AcceptableBlockViewKinds: TnsBlockViewKinds;
//#UC START# *500E7677002B_500E75A000B0_var*
//#UC END# *500E7677002B_500E75A000B0_var*
begin
//#UC START# *500E7677002B_500E75A000B0_impl*
 Result := [ev_bvkLeft];
//#UC END# *500E7677002B_500E75A000B0_impl*
end;//TnsAACLeftDocumentContainer.AcceptableBlockViewKinds

{$IfEnd} //not Admin AND not Monitorings

end.