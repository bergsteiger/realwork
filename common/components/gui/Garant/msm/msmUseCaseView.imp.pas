{$IfNDef msmUseCaseView_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmUseCaseView.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmUseCaseView" MUID: (57EA6BAE038E)
// Имя типа: "_msmUseCaseView_"

{$Define msmUseCaseView_imp}

 // _ConcreteUseCase_

 _msmUseCaseView_ = {abstract} class(TmsmUseCase)
  private
   f_UseCase: _ConcreteUseCase_;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoActivate; override;
   procedure DoActivated; override;
   procedure ClearFields; override;
  public
   constructor Create(const aUseCase: _ConcreteUseCase_); reintroduce;
   class function Make(const aUseCase: _ConcreteUseCase_): ImsmUseCase; reintroduce;
  protected
   property UseCase: _ConcreteUseCase_
    read f_UseCase;
 end;//_msmUseCaseView_

{$Else msmUseCaseView_imp}

{$IfNDef msmUseCaseView_imp_impl}

{$Define msmUseCaseView_imp_impl}

constructor _msmUseCaseView_.Create(const aUseCase: _ConcreteUseCase_);
//#UC START# *57EA6C2C02EA_57EA6BAE038E_var*
//#UC END# *57EA6C2C02EA_57EA6BAE038E_var*
begin
//#UC START# *57EA6C2C02EA_57EA6BAE038E_impl*
 Assert(aUseCase <> nil);
 f_UseCase := aUseCase;
 inherited Create;
//#UC END# *57EA6C2C02EA_57EA6BAE038E_impl*
end;//_msmUseCaseView_.Create

class function _msmUseCaseView_.Make(const aUseCase: _ConcreteUseCase_): ImsmUseCase;
var
 l_Inst : _msmUseCaseView_;
begin
 l_Inst := Create(aUseCase);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_msmUseCaseView_.Make

procedure _msmUseCaseView_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57EA6BAE038E_var*
//#UC END# *479731C50290_57EA6BAE038E_var*
begin
//#UC START# *479731C50290_57EA6BAE038E_impl*
 f_UseCase := nil;
 inherited;
//#UC END# *479731C50290_57EA6BAE038E_impl*
end;//_msmUseCaseView_.Cleanup

procedure _msmUseCaseView_.DoActivate;
//#UC START# *57D2B82102BD_57EA6BAE038E_var*
//#UC END# *57D2B82102BD_57EA6BAE038E_var*
begin
//#UC START# *57D2B82102BD_57EA6BAE038E_impl*
 inherited;
 Assert(f_UseCase <> nil);
 f_UseCase.Activate;
//#UC END# *57D2B82102BD_57EA6BAE038E_impl*
end;//_msmUseCaseView_.DoActivate

procedure _msmUseCaseView_.DoActivated;
//#UC START# *57DAB38900EF_57EA6BAE038E_var*
//#UC END# *57DAB38900EF_57EA6BAE038E_var*
begin
//#UC START# *57DAB38900EF_57EA6BAE038E_impl*
 inherited;
 Assert(f_UseCase <> nil);
 f_UseCase.Activated;
//#UC END# *57DAB38900EF_57EA6BAE038E_impl*
end;//_msmUseCaseView_.DoActivated

procedure _msmUseCaseView_.ClearFields;
begin
 Finalize(f_UseCase);
 inherited;
end;//_msmUseCaseView_.ClearFields

{$EndIf msmUseCaseView_imp_impl}

{$EndIf msmUseCaseView_imp}

