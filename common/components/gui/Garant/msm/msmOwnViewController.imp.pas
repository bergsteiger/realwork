{$IfNDef msmOwnViewController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmOwnViewController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmOwnViewController" MUID: (57AB5C9A00F3)
// Имя типа: "_msmOwnViewController_"

{$Define msmOwnViewController_imp}

 // _OwnViewClass_

 // _InitContext_

 _msmOwnViewController_ = {abstract} class(TmsmParentedViewController)
  private
   f_OwnView: _OwnViewClass_;
   f_InitContext: _InitContext_;
  protected
   procedure InitOwnView; virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aModel: ImsmModel;
    const aParent: ImsmViewParent); reintroduce; overload;
   class function Make(const aModel: ImsmModel;
    const aParent: ImsmViewParent): ImsmViewController; reintroduce; overload;
   constructor Create(const aModel: ImsmModel;
    const aParent: ImsmViewParent;
    const anInitContext: _InitContext_); reintroduce; overload;
   class function Make(const aModel: ImsmModel;
    const aParent: ImsmViewParent;
    const anInitContext: _InitContext_): ImsmViewController; reintroduce; overload;
  protected
   property OwnView: _OwnViewClass_
    read f_OwnView;
   property InitContext: _InitContext_
    read f_InitContext;
 end;//_msmOwnViewController_

{$Else msmOwnViewController_imp}

{$IfNDef msmOwnViewController_imp_impl}

{$Define msmOwnViewController_imp_impl}

constructor _msmOwnViewController_.Create(const aModel: ImsmModel;
 const aParent: ImsmViewParent);
//#UC START# *57AB589001D7_57AB5C9A00F3_var*
var
 l_InitContext : _InitContext_;
//#UC END# *57AB589001D7_57AB5C9A00F3_var*
begin
//#UC START# *57AB589001D7_57AB5C9A00F3_impl*
 Finalize(l_InitContext);
 System.FillChar(l_InitContext, SizeOf(l_InitContext), 0);
 Create(aModel, aParent, l_InitContext);
//#UC END# *57AB589001D7_57AB5C9A00F3_impl*
end;//_msmOwnViewController_.Create

class function _msmOwnViewController_.Make(const aModel: ImsmModel;
 const aParent: ImsmViewParent): ImsmViewController;
var
 l_Inst : _msmOwnViewController_;
begin
 l_Inst := Create(aModel, aParent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_msmOwnViewController_.Make

constructor _msmOwnViewController_.Create(const aModel: ImsmModel;
 const aParent: ImsmViewParent;
 const anInitContext: _InitContext_);
//#UC START# *57B45A7F000E_57AB5C9A00F3_var*
//#UC END# *57B45A7F000E_57AB5C9A00F3_var*
begin
//#UC START# *57B45A7F000E_57AB5C9A00F3_impl*
 f_InitContext := anInitContext;
 f_OwnView := _OwnViewClass_.Create(nil);
 inherited Create(OwnView, aModel, aParent);
 InitOwnView;
//#UC END# *57B45A7F000E_57AB5C9A00F3_impl*
end;//_msmOwnViewController_.Create

class function _msmOwnViewController_.Make(const aModel: ImsmModel;
 const aParent: ImsmViewParent;
 const anInitContext: _InitContext_): ImsmViewController;
var
 l_Inst : _msmOwnViewController_;
begin
 l_Inst := Create(aModel, aParent, anInitContext);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_msmOwnViewController_.Make

procedure _msmOwnViewController_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57AB5C9A00F3_var*
//#UC END# *479731C50290_57AB5C9A00F3_var*
begin
//#UC START# *479731C50290_57AB5C9A00F3_impl*
 inherited;
 FreeAndNil(f_OwnView);
//#UC END# *479731C50290_57AB5C9A00F3_impl*
end;//_msmOwnViewController_.Cleanup

procedure _msmOwnViewController_.ClearFields;
begin
 Finalize(f_OwnView);
 Finalize(f_InitContext);
 inherited;
end;//_msmOwnViewController_.ClearFields

{$EndIf msmOwnViewController_imp_impl}

{$EndIf msmOwnViewController_imp}

