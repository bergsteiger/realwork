unit NOT_FINISHED_eePicture;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest Engine"
// ������: "w:/common/components/gui/Garant/Everest_Engine/NOT_FINISHED_eePicture.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::Engine Core::TeePicture
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  eeInterfaces,
  eePara,
  l3Interfaces,
  ActiveX
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeePicture = class(TeePara, IeePicture)
 protected
 // realized methods
   function Get_Name: Il3CString;
   procedure SaveToStream(const aStream: IStream);
 end;//TeePicture
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}

// start class TeePicture

function TeePicture.Get_Name: Il3CString;
//#UC START# *54819CB60119_54BE4DB30227get_var*
//#UC END# *54819CB60119_54BE4DB30227get_var*
begin
//#UC START# *54819CB60119_54BE4DB30227get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819CB60119_54BE4DB30227get_impl*
end;//TeePicture.Get_Name

procedure TeePicture.SaveToStream(const aStream: IStream);
//#UC START# *54819D1601EF_54BE4DB30227_var*
//#UC END# *54819D1601EF_54BE4DB30227_var*
begin
//#UC START# *54819D1601EF_54BE4DB30227_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819D1601EF_54BE4DB30227_impl*
end;//TeePicture.SaveToStream

{$IfEnd} //Nemesis

end.