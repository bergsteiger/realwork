unit evEvdDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evEvdDataObject.pas"
// �����: 28.09.1999 10:18
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevEvdDataObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evReaderDataObject
  ;

type
 TevEvdDataObject = class(TevReaderDataObject)
 protected
 // realized methods
   function ReaderClass: Rk2CustomReader; override;
 end;//TevEvdDataObject

implementation

uses
  evdNativeReader
  ;

// start class TevEvdDataObject

function TevEvdDataObject.ReaderClass: Rk2CustomReader;
//#UC START# *48EB6A0700D9_48EA3A2A0142_var*
//#UC END# *48EB6A0700D9_48EA3A2A0142_var*
begin
//#UC START# *48EB6A0700D9_48EA3A2A0142_impl*
 Result := TevdNativeReader;
//#UC END# *48EB6A0700D9_48EA3A2A0142_impl*
end;//TevEvdDataObject.ReaderClass

end.