unit evCustomEditTextSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evCustomEditTextSource.pas"
// �����: 13.05.2008 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevCustomEditTextSource
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evCustomMemoTextSource,
  nevTools
  ;

type
 TevCustomEditTextSource = class(TevCustomMemoTextSource)
 protected
 // overridden protected methods
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TevCustomEditTextSource

implementation

uses
  evEditDocumentContainer,
  evCustomMemo
  ;

// start class TevCustomEditTextSource

function TevCustomEditTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_482D988102EC_var*
//#UC END# *482D9A030221_482D988102EC_var*
begin
//#UC START# *482D9A030221_482D988102EC_impl*
 Result := TevEditDocumentContainer.Make;
//#UC END# *482D9A030221_482D988102EC_impl*
end;//TevCustomEditTextSource.DoMakeDocumentContainer

end.