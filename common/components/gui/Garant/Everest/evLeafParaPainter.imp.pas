{$IfNDef evLeafParaPainter_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evLeafParaPainter.imp.pas"
// �����: 13.05.2005 13:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Drawing Framework::evLeafParaPainter
//
// ���������� ��������� ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define evLeafParaPainter_imp}
{$If defined(evNeedPainters)}
 {$Include ..\Everest\evLeafParaPainterPrim.imp.pas}
 _evLeafParaPainter_ = {mixin} class(_evLeafParaPainterPrim_)
  {* ���������� ��������� ����������. }
 protected
 // overridden protected methods
   function HackMargin: Integer; override;
     {* ������, ������� �� ���� �������� ����� �������� }
 protected
 // protected methods
   function DoDraw: Boolean;
 end;//_evLeafParaPainter_
{$Else}

 {$Include ..\Everest\evLeafParaPainterPrim.imp.pas}
 _evLeafParaPainter_ = _evLeafParaPainterPrim_;

{$IfEnd} //evNeedPainters

{$Else evLeafParaPainter_imp}

{$If defined(evNeedPainters)}

{$Include ..\Everest\evLeafParaPainterPrim.imp.pas}

// start class _evLeafParaPainter_

function _evLeafParaPainter_.DoDraw: Boolean;
//#UC START# *4804CB4B00B2_4804CB1B0328_var*
//#UC END# *4804CB4B00B2_4804CB1B0328_var*
begin
//#UC START# *4804CB4B00B2_4804CB1B0328_impl*
 Result := false;
 Assert(false);
//#UC END# *4804CB4B00B2_4804CB1B0328_impl*
end;//_evLeafParaPainter_.DoDraw

function _evLeafParaPainter_.HackMargin: Integer;
//#UC START# *4E6F459F0278_4804CB1B0328_var*
//#UC END# *4E6F459F0278_4804CB1B0328_var*
begin
//#UC START# *4E6F459F0278_4804CB1B0328_impl*
 Result := nevInch div 6;
//#UC END# *4E6F459F0278_4804CB1B0328_impl*
end;//_evLeafParaPainter_.HackMargin

{$IfEnd} //evNeedPainters

{$EndIf evLeafParaPainter_imp}
