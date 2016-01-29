{$IfNDef l3Castable_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3Castable.imp.pas"
// �����: 30.01.2006 21:27
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::����������� �������::l3Castable
//
// �����-������� � ������� QueryInterface
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3Castable_imp}
 _l3Castable_ = {mixin} class(_l3Castable_Parent_)
  {* �����-������� � ������� QueryInterface }
 public
 // public methods
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; virtual; stdcall;
     {* �������� ������� ��������� � ��������������, ���� ��� ��������. }
 end;//_l3Castable_

{$Else l3Castable_imp}

// start class _l3Castable_

function _l3Castable_.QueryInterface(const IID: TGUID;
  out Obj): HResult;
//#UC START# *47A0AD3A01F7_47A0ACE90008_var*
//#UC END# *47A0AD3A01F7_47A0ACE90008_var*
begin
//#UC START# *47A0AD3A01F7_47A0ACE90008_impl*
 if TObject(Self).GetInterface(IID, Obj) then
  Result := S_Ok
 else
  Result := E_NoInterface;
//#UC END# *47A0AD3A01F7_47A0ACE90008_impl*
end;//_l3Castable_.QueryInterface

{$EndIf l3Castable_imp}
