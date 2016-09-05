{$IfNDef msmConcreteModelViewController_imp}

// ������: "w:\common\components\gui\Garant\msm\msmConcreteModelViewController.imp.pas"
// ���������: "Impurity"
// ������� ������: "msmConcreteModelViewController" MUID: (57AE0566006E)
// ��� ����: "_msmConcreteModelViewController_"

{$Define msmConcreteModelViewController_imp}

 // _ConcreteModel_

 _msmConcreteModelViewController_ = {abstract} class(TmsmViewController)
  private
   f_Model: _ConcreteModel_;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure ClearFields; override;
  public
   constructor Create(aView: TmsmView;
    const aModel: _ConcreteModel_); reintroduce;
   class function Make(aView: TmsmView;
    const aModel: _ConcreteModel_): ImsmViewController; reintroduce;
  protected
   property Model: _ConcreteModel_
    read f_Model;
 end;//_msmConcreteModelViewController_

{$Else msmConcreteModelViewController_imp}

{$IfNDef msmConcreteModelViewController_imp_impl}

{$Define msmConcreteModelViewController_imp_impl}

constructor _msmConcreteModelViewController_.Create(aView: TmsmView;
 const aModel: _ConcreteModel_);
//#UC START# *57AE067703DB_57AE0566006E_var*
//#UC END# *57AE067703DB_57AE0566006E_var*
begin
//#UC START# *57AE067703DB_57AE0566006E_impl*
 Assert(aModel <> nil);
 f_Model := aModel;
 inherited Create(aView, aModel);
//#UC END# *57AE067703DB_57AE0566006E_impl*
end;//_msmConcreteModelViewController_.Create

class function _msmConcreteModelViewController_.Make(aView: TmsmView;
 const aModel: _ConcreteModel_): ImsmViewController;
var
 l_Inst : _msmConcreteModelViewController_;
begin
 l_Inst := Create(aView, aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_msmConcreteModelViewController_.Make

procedure _msmConcreteModelViewController_.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_57AE0566006E_var*
//#UC END# *479731C50290_57AE0566006E_var*
begin
//#UC START# *479731C50290_57AE0566006E_impl*
 inherited;
 f_Model := nil;
//#UC END# *479731C50290_57AE0566006E_impl*
end;//_msmConcreteModelViewController_.Cleanup

procedure _msmConcreteModelViewController_.ClearFields;
begin
 Finalize(f_Model);
 inherited;
end;//_msmConcreteModelViewController_.ClearFields

{$EndIf msmConcreteModelViewController_imp_impl}

{$EndIf msmConcreteModelViewController_imp}

