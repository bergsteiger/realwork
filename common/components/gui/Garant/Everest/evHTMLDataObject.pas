unit evHTMLDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evHTMLDataObject.pas"
// �����: 16.12.2004 14:48
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevHTMLDataObject
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
 TevHTMLDataObject = class(TevReaderDataObject)
 protected
 // realized methods
   function ReaderClass: Rk2CustomReader; override;
 end;//TevHTMLDataObject

implementation

uses
  ddHTMLReader
  ;

// start class TevHTMLDataObject

function TevHTMLDataObject.ReaderClass: Rk2CustomReader;
//#UC START# *48EB6A0700D9_4802FF6101DE_var*
//#UC END# *48EB6A0700D9_4802FF6101DE_var*
begin
//#UC START# *48EB6A0700D9_4802FF6101DE_impl*
 Result := TddHTMLReader;
//#UC END# *48EB6A0700D9_4802FF6101DE_impl*
end;//TevHTMLDataObject.ReaderClass

end.