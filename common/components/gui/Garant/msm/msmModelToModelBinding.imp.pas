{$IfNDef msmModelToModelBinding_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmModelToModelBinding" MUID: (57B2B8FA0333)
// Имя типа: "_msmModelToModelBinding_"

{$Define msmModelToModelBinding_imp}

 // _ModelToListen_

 // _ModelToFire_

 _ConcreteModel_ = _ModelToListen_;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelController.imp.pas}
 _msmModelToModelBinding_ = {abstract} class(_msmConcreteModelController_)
  private
   f_ModelToListen: _ModelToListen_;
   f_ModelToFire: _ModelToFire_;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aModelToListen: _ModelToListen_;
    const aModelToFire: _ModelToFire_); reintroduce;
   class function Make(const aModelToListen: _ModelToListen_;
    const aModelToFire: _ModelToFire_): ImsmController; reintroduce;
  protected
   property ModelToListen: _ModelToListen_
    read f_ModelToListen;
   property ModelToFire: _ModelToFire_
    read f_ModelToFire;
 end;//_msmModelToModelBinding_

{$Else msmModelToModelBinding_imp}

{$IfNDef msmModelToModelBinding_imp_impl}

{$Define msmModelToModelBinding_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelController.imp.pas}

constructor _msmModelToModelBinding_.Create(const aModelToListen: _ModelToListen_;
 const aModelToFire: _ModelToFire_);
//#UC START# *57B2BA1B039B_57B2B8FA0333_var*
//#UC END# *57B2BA1B039B_57B2B8FA0333_var*
begin
//#UC START# *57B2BA1B039B_57B2B8FA0333_impl*
 Assert(aModelToListen <> nil);
 Assert(aModelToFire <> nil);
 f_ModelToListen := aModelToListen;
 f_ModelToFire := aModelToFire;
 inherited Create(aModelToListen);
//#UC END# *57B2BA1B039B_57B2B8FA0333_impl*
end;//_msmModelToModelBinding_.Create

class function _msmModelToModelBinding_.Make(const aModelToListen: _ModelToListen_;
 const aModelToFire: _ModelToFire_): ImsmController;
var
 l_Inst : _msmModelToModelBinding_;
begin
 l_Inst := Create(aModelToListen, aModelToFire);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_msmModelToModelBinding_.Make

procedure _msmModelToModelBinding_.ClearFields;
begin
 Finalize(f_ModelToListen);
 Finalize(f_ModelToFire);
 inherited;
end;//_msmModelToModelBinding_.ClearFields

{$EndIf msmModelToModelBinding_imp_impl}

{$EndIf msmModelToModelBinding_imp}

