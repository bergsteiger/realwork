{$IfNDef msmConcreteModelAndConcreteViewController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmConcreteModelAndConcreteViewController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmConcreteModelAndConcreteViewController" MUID: (57DAAADC01B7)
// Имя типа: "_msmConcreteModelAndConcreteViewController_"

{$Define msmConcreteModelAndConcreteViewController_imp}

 // _ViewClass_

 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelViewController.imp.pas}
 _msmConcreteModelAndConcreteViewController_ = {abstract} class(_msmConcreteModelViewController_)
  private
   f_View: _ViewClass_;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aView: _ViewClass_;
    const aModel: _ConcreteModel_); reintroduce;
   class function Make(const aView: _ViewClass_;
    const aModel: _ConcreteModel_): ImsmViewController; reintroduce;
  protected
   property View: _ViewClass_
    read f_View;
 end;//_msmConcreteModelAndConcreteViewController_

{$Else msmConcreteModelAndConcreteViewController_imp}

{$IfNDef msmConcreteModelAndConcreteViewController_imp_impl}

{$Define msmConcreteModelAndConcreteViewController_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelViewController.imp.pas}

constructor _msmConcreteModelAndConcreteViewController_.Create(const aView: _ViewClass_;
 const aModel: _ConcreteModel_);
//#UC START# *57DAB04A00F5_57DAAADC01B7_var*
//#UC END# *57DAB04A00F5_57DAAADC01B7_var*
begin
//#UC START# *57DAB04A00F5_57DAAADC01B7_impl*
 f_View := aView;
 inherited Create(aView, aModel);
//#UC END# *57DAB04A00F5_57DAAADC01B7_impl*
end;//_msmConcreteModelAndConcreteViewController_.Create

class function _msmConcreteModelAndConcreteViewController_.Make(const aView: _ViewClass_;
 const aModel: _ConcreteModel_): ImsmViewController;
var
 l_Inst : _msmConcreteModelAndConcreteViewController_;
begin
 l_Inst := Create(aView, aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_msmConcreteModelAndConcreteViewController_.Make

procedure _msmConcreteModelAndConcreteViewController_.ClearFields;
begin
 Finalize(f_View);
 inherited;
end;//_msmConcreteModelAndConcreteViewController_.ClearFields

{$EndIf msmConcreteModelAndConcreteViewController_imp_impl}

{$EndIf msmConcreteModelAndConcreteViewController_imp}

