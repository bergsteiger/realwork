unit evdPDFHyperLinkEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/evdPDFHyperLinkEliminator.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdPDFHyperLinkEliminator
//
// ������, ��������� ������ ��� PDF.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  evdHyperlinkEliminator,
  l3Variant
  ;

type
 TevdPDFHyperLinkEliminator = class(TevdHyperlinkEliminator)
  {* ������, ��������� ������ ��� PDF. }
 protected
 // overridden protected methods
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevdPDFHyperLinkEliminator

implementation

uses
  k2Tags,
  k2VariantImpl,
  k2Types,
  evdStyles
  ;

// start class TevdPDFHyperLinkEliminator

procedure TevdPDFHyperLinkEliminator.AddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4836D52400D9_541A7EEC0051_var*
var
 l_Value: Tk2Variant;
//#UC END# *4836D52400D9_541A7EEC0051_var*
begin
//#UC START# *4836D52400D9_541A7EEC0051_impl*
 if (AtomIndex = k2_tiStyle) and (Value.AsInteger = ev_saHyperLinkCont) then
 begin
  l_Value := Tk2VariantImpl.Make(ev_saContents);
  try
   inherited AddAtomEx(AtomIndex, l_Value);
  finally
   l_Value := nil;
  end;
 end // if (AtomIndex = k2_tiStyle) and (Value.AsInteger = ev_saHyperLinkCont) then
 else
  inherited;
//#UC END# *4836D52400D9_541A7EEC0051_impl*
end;//TevdPDFHyperLinkEliminator.AddAtomEx

end.