{$IfNDef msmConcreteModelController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmConcreteModelController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmConcreteModelController" MUID: (57B2B7FF03E4)
// Имя типа: "_msmConcreteModelController_"

{$Define msmConcreteModelController_imp}

 // _ConcreteModel_

 _msmConcreteModelController_ = {abstract} class(TmsmController)
  private
   f_Model: _ConcreteModel_;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aModel: _ConcreteModel_); reintroduce;
   class function Make(const aModel: _ConcreteModel_): ImsmController; reintroduce;
  protected
   property Model: _ConcreteModel_
    read f_Model;
 end;//_msmConcreteModelController_

{$Else msmConcreteModelController_imp}

{$IfNDef msmConcreteModelController_imp_impl}

{$Define msmConcreteModelController_imp_impl}

constructor _msmConcreteModelController_.Create(const aModel: _ConcreteModel_);
//#UC START# *57B2B8940291_57B2B7FF03E4_var*
//#UC END# *57B2B8940291_57B2B7FF03E4_var*
begin
//#UC START# *57B2B8940291_57B2B7FF03E4_impl*
 Assert(aModel <> nil);
 f_Model := aModel;
 inherited Create(aModel);
//#UC END# *57B2B8940291_57B2B7FF03E4_impl*
end;//_msmConcreteModelController_.Create

class function _msmConcreteModelController_.Make(const aModel: _ConcreteModel_): ImsmController;
var
 l_Inst : _msmConcreteModelController_;
begin
 l_Inst := Create(aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_msmConcreteModelController_.Make

procedure _msmConcreteModelController_.ClearFields;
begin
 Finalize(f_Model);
 inherited;
end;//_msmConcreteModelController_.ClearFields

{$EndIf msmConcreteModelController_imp_impl}

{$EndIf msmConcreteModelController_imp}

