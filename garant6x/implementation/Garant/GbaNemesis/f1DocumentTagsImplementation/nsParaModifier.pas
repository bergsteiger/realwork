unit nsParaModifier;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "f1DocumentTagsImplementation"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsParaModifier.pas"
// �����: 25.11.2010 16:34
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::f1DocumentTagsImplementation::EVD Schema Tuning::TnsParaModifier
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  evPara_Wrap,
  l3Variant
  ;

type
 TnsParaModifier = class(TevdParaModifier)
 public
 // overridden public methods
   class function MarkModified(aTag: Tl3Variant): Boolean; override;
 end;//TnsParaModifier

implementation

// start class TnsParaModifier

class function TnsParaModifier.MarkModified(aTag: Tl3Variant): Boolean;
//#UC START# *4CEE6187015A_4CEE65B701A4_var*
//#UC END# *4CEE6187015A_4CEE65B701A4_var*
begin
//#UC START# *4CEE6187015A_4CEE65B701A4_impl*
 Result := aTag.Owner.MarkModified;
//#UC END# *4CEE6187015A_4CEE65B701A4_impl*
end;//TnsParaModifier.MarkModified

initialization
//#UC START# *4CEE685E0003*
 g_ParaModifier := TnsParaModifier;
//#UC END# *4CEE685E0003*

end.