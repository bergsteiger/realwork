unit evPersistentDataObjectEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evPersistentDataObjectEx.pas"
// �����: 17.10.2008 18:21
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevPersistentDataObjectEx
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  evPersistentDataObject
  ;

type
 TevPersistentDataObjectEx = class(TevPersistentDataObject)
 protected
 // overridden protected methods
   function Sharp: Boolean; override;
 protected
 // protected methods
   function Holder: InevObjectHolder;
 end;//TevPersistentDataObjectEx

implementation

uses
  nevPersistentDocumentContainer
  ;

// start class TevPersistentDataObjectEx

function TevPersistentDataObjectEx.Holder: InevObjectHolder;
//#UC START# *48F89F810133_48F89F4302E3_var*
//#UC END# *48F89F810133_48F89F4302E3_var*
begin
//#UC START# *48F89F810133_48F89F4302E3_impl*
 Result := TnevPersistentDocumentContainer.Make;
//#UC END# *48F89F810133_48F89F4302E3_impl*
end;//TevPersistentDataObjectEx.Holder

function TevPersistentDataObjectEx.Sharp: Boolean;
//#UC START# *48F479680376_48F89F4302E3_var*
//#UC END# *48F479680376_48F89F4302E3_var*
begin
//#UC START# *48F479680376_48F89F4302E3_impl*
 Result := true;
//#UC END# *48F479680376_48F89F4302E3_impl*
end;//TevPersistentDataObjectEx.Sharp

end.