{$IfNDef l3Changing_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3Changing.imp.pas"
// ���������: "Impurity"
// ������� ������: "l3Changing" MUID: (4A5CBFAB03AF)
// ��� ����: "_l3Changing_"

{$Define l3Changing_imp}

 _l3Changing_ = class(_l3Changing_Parent_)
  {* ������ � ������������ �� ��������� ��������� }
  protected
   procedure DoChanged; virtual;
   procedure DoChanging; virtual;
  public
   procedure Changing;
    {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
   procedure Changed;
    {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
 end;//_l3Changing_

{$Else l3Changing_imp}

{$IfNDef l3Changing_imp_impl}

{$Define l3Changing_imp_impl}

procedure _l3Changing_.DoChanged;
//#UC START# *54D9E08D0212_4A5CBFAB03AF_var*
//#UC END# *54D9E08D0212_4A5CBFAB03AF_var*
begin
//#UC START# *54D9E08D0212_4A5CBFAB03AF_impl*
//#UC END# *54D9E08D0212_4A5CBFAB03AF_impl*
end;//_l3Changing_.DoChanged

procedure _l3Changing_.DoChanging;
//#UC START# *54D9E09D018D_4A5CBFAB03AF_var*
//#UC END# *54D9E09D018D_4A5CBFAB03AF_var*
begin
//#UC START# *54D9E09D018D_4A5CBFAB03AF_impl*
//#UC END# *54D9E09D018D_4A5CBFAB03AF_impl*
end;//_l3Changing_.DoChanging

procedure _l3Changing_.Changing;
 {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
//#UC START# *4A5CBFFE0157_4A5CBFAB03AF_var*
//#UC END# *4A5CBFFE0157_4A5CBFAB03AF_var*
begin
//#UC START# *4A5CBFFE0157_4A5CBFAB03AF_impl*
 DoChanging;
//#UC END# *4A5CBFFE0157_4A5CBFAB03AF_impl*
end;//_l3Changing_.Changing

procedure _l3Changing_.Changed;
 {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
//#UC START# *4A5CC00B03D5_4A5CBFAB03AF_var*
//#UC END# *4A5CC00B03D5_4A5CBFAB03AF_var*
begin
//#UC START# *4A5CC00B03D5_4A5CBFAB03AF_impl*
 DoChanged;
//#UC END# *4A5CC00B03D5_4A5CBFAB03AF_impl*
end;//_l3Changing_.Changed

{$EndIf l3Changing_imp_impl}

{$EndIf l3Changing_imp}

