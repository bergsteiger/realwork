unit evDocument_Wrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evDocument_Wrap.pas"
// �����: 16.04.1998 10:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Wrapper::Class>> Shared Delphi::Everest::Standard::WevDocument
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evPara_Wrap,
  k2Base,
  l3Variant
  ;

type
 WevDocument = class(WevPara)
 protected
 // overridden protected methods
   function GetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; override;
 end;//WevDocument

implementation

uses
  k2Tags,
  evdTypes,
  Para_Const
  ;

// start class WevDocument

function WevDocument.GetAtomData(AE: Tl3Variant;
  aProp: Tk2CustomProperty;
  out Data: Tl3Variant): Boolean;
//#UC START# *4857A995029E_4857B5D901D7_var*
//#UC END# *4857A995029E_4857B5D901D7_var*
begin
//#UC START# *4857A995029E_4857B5D901D7_impl*
 if (aProp.TagIndex = k2_tiFixedWidth) then
 begin
  if AE.Owner.IsKindOf(k2_typPara) then
  // - ��������� ��������� �� ������ �������� ���� ������ ��� ��������������
  begin
   Result := true;
   Data := aProp.MakeTag(Ord(false)).AsObject;
   Exit;
  end;//IsKindOf(k2_typPara)
 end;//aProp.TagIndex = k2_tiFixedWidth
 Result := inherited GetAtomData(AE, aProp, Data);
//#UC END# *4857A995029E_4857B5D901D7_impl*
end;//WevDocument.GetAtomData

end.