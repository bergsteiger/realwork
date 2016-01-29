unit evAutoreferatDocument_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evAutoreferatDocument_InterfaceFactory.pas"
// �����: 02.03.2011 19:09
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevAutoreferatDocument
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  evDocument_InterfaceFactory,
  l3IID,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevAutoreferatDocumentInterfaceFactory = class(TevDocumentInterfaceFactory)
 protected
 // overridden protected methods
   function COMQueryTool(aTag: Tl3Tag;
     const aIID: Tl3GUID;
     out theTool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TevAutoreferatDocumentInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevTools,
  nevAutoreferatDocumentAnchor
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevAutoreferatDocumentInterfaceFactory

function TevAutoreferatDocumentInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevAnchor) then
  InevAnchor(theTool) := TnevAutoreferatDocumentAnchor.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevAutoreferatDocumentInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.