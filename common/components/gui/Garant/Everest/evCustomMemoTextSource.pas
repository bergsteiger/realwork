unit evCustomMemoTextSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evCustomMemoTextSource.pas"
// �����: 23.05.1997 09:10
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevCustomMemoTextSource
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evTextSource,
  Classes,
  nevTools
  ;

type
 TevCustomMemoTextSource = class(TevTextSource)
 protected
 // overridden protected methods
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 end;//TevCustomMemoTextSource

implementation

uses
  evCustomMemoContainer
  ;

// start class TevCustomMemoTextSource

constructor TevCustomMemoTextSource.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_482D98A20190_var*
//#UC END# *47D1602000C6_482D98A20190_var*
begin
//#UC START# *47D1602000C6_482D98A20190_impl*
 inherited Create(AOwner);
 LinkEditor(AOwner);
//#UC END# *47D1602000C6_482D98A20190_impl*
end;//TevCustomMemoTextSource.Create

function TevCustomMemoTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_482D98A20190_var*
//#UC END# *482D9A030221_482D98A20190_var*
begin
//#UC START# *482D9A030221_482D98A20190_impl*
 Result := TevCustomMemoContainer.Make;
//#UC END# *482D9A030221_482D98A20190_impl*
end;//TevCustomMemoTextSource.DoMakeDocumentContainer

end.