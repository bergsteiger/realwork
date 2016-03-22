{$IfNDef evStyleTableListenerPrim_imp}

// ������: "w:\common\components\gui\Garant\Everest\evStyleTableListenerPrim.imp.pas"
// ���������: "Impurity"
// ������� ������: "evStyleTableListenerPrim" MUID: (4A485B0D0223)
// ��� ����: "_evStyleTableListenerPrim_"

{$Define evStyleTableListenerPrim_imp}

{$If NOT Defined(DesignTimeLibrary)}
 _evStyleTableListenerPrim_ = class(_evStyleTableListenerPrim_Parent_, IafwStyleTableSpy)
  protected
   procedure DoStyleTableChanged; virtual; abstract;
   function NeedListen: Boolean; virtual;
    {* ����� �� ������������� � ������� ������ (����� �� ��� �����������) }
   function AtEnd: Boolean; virtual;
    {* ������������� � ����� ������ ����������� }
   procedure StyleTableChanged;
    {* ������� ������ ����������. }
   procedure InitFields; override;
 end;//_evStyleTableListenerPrim_

{$Else NOT Defined(DesignTimeLibrary)}

_evStyleTableListenerPrim_ = _evStyleTableListenerPrim_Parent_;

{$IfEnd} // NOT Defined(DesignTimeLibrary)
{$Else evStyleTableListenerPrim_imp}

{$IfNDef evStyleTableListenerPrim_imp_impl}

{$Define evStyleTableListenerPrim_imp_impl}

{$If NOT Defined(DesignTimeLibrary)}
function _evStyleTableListenerPrim_.NeedListen: Boolean;
 {* ����� �� ������������� � ������� ������ (����� �� ��� �����������) }
//#UC START# *4A485DBE0293_4A485B0D0223_var*
//#UC END# *4A485DBE0293_4A485B0D0223_var*
begin
//#UC START# *4A485DBE0293_4A485B0D0223_impl*
 Result := true;
//#UC END# *4A485DBE0293_4A485B0D0223_impl*
end;//_evStyleTableListenerPrim_.NeedListen

function _evStyleTableListenerPrim_.AtEnd: Boolean;
 {* ������������� � ����� ������ ����������� }
//#UC START# *4A4867A20049_4A485B0D0223_var*
//#UC END# *4A4867A20049_4A485B0D0223_var*
begin
//#UC START# *4A4867A20049_4A485B0D0223_impl*
 Result := true;
//#UC END# *4A4867A20049_4A485B0D0223_impl*
end;//_evStyleTableListenerPrim_.AtEnd

procedure _evStyleTableListenerPrim_.StyleTableChanged;
 {* ������� ������ ����������. }
//#UC START# *467D2CB10135_4A485B0D0223_var*
//#UC END# *467D2CB10135_4A485B0D0223_var*
begin
//#UC START# *467D2CB10135_4A485B0D0223_impl*
 DoStyleTableChanged;
//#UC END# *467D2CB10135_4A485B0D0223_impl*
end;//_evStyleTableListenerPrim_.StyleTableChanged

procedure _evStyleTableListenerPrim_.InitFields;
//#UC START# *47A042E100E2_4A485B0D0223_var*
//#UC END# *47A042E100E2_4A485B0D0223_var*
begin
//#UC START# *47A042E100E2_4A485B0D0223_impl*
 inherited;
 if NeedListen then
  evAddStyleTableSpy(Self, false, AtEnd);
//#UC END# *47A042E100E2_4A485B0D0223_impl*
end;//_evStyleTableListenerPrim_.InitFields
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$EndIf evStyleTableListenerPrim_imp_impl}

{$EndIf evStyleTableListenerPrim_imp}

