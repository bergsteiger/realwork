{$IfNDef msmModelToModelOperation_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmModelToModelOperation.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmModelToModelOperation" MUID: (57CEBA960062)
// Имя типа: "_msmModelToModelOperation_"

{$Define msmModelToModelOperation_imp}

 // _ModelToListen_

 // _ModelToFire_

 _ConcreteModel_ = _ModelToListen_;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOperation.imp.pas}
 _msmModelToModelOperation_ = {abstract} class(_msmConcreteModelOperation_)
  private
   f_ModelToListen: _ModelToListen_;
   f_ModelToFire: _ModelToFire_;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aCaption: AnsiString;
    const aModelToListen: _ModelToListen_;
    const aModelToFire: _ModelToFire_); reintroduce;
   class function Make(const aCaption: AnsiString;
    const aModelToListen: _ModelToListen_;
    const aModelToFire: _ModelToFire_): ImsmOperation; reintroduce;
  protected
   property ModelToListen: _ModelToListen_
    read f_ModelToListen;
  public
   property ModelToFire: _ModelToFire_
    read f_ModelToFire;
 end;//_msmModelToModelOperation_

{$Else msmModelToModelOperation_imp}

{$IfNDef msmModelToModelOperation_imp_impl}

{$Define msmModelToModelOperation_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOperation.imp.pas}

constructor _msmModelToModelOperation_.Create(const aCaption: AnsiString;
 const aModelToListen: _ModelToListen_;
 const aModelToFire: _ModelToFire_);
//#UC START# *57CEBB400249_57CEBA960062_var*
//#UC END# *57CEBB400249_57CEBA960062_var*
begin
//#UC START# *57CEBB400249_57CEBA960062_impl*
 Assert(aModelToListen <> nil);
 Assert(aModelToFire <> nil);
 f_ModelToListen := aModelToListen;
 f_ModelToFire := aModelToFire;
 inherited Create(aCaption, aModelToListen);
//#UC END# *57CEBB400249_57CEBA960062_impl*
end;//_msmModelToModelOperation_.Create

class function _msmModelToModelOperation_.Make(const aCaption: AnsiString;
 const aModelToListen: _ModelToListen_;
 const aModelToFire: _ModelToFire_): ImsmOperation;
var
 l_Inst : _msmModelToModelOperation_;
begin
 l_Inst := Create(aCaption, aModelToListen, aModelToFire);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_msmModelToModelOperation_.Make

procedure _msmModelToModelOperation_.ClearFields;
begin
 Finalize(f_ModelToListen);
 Finalize(f_ModelToFire);
 inherited;
end;//_msmModelToModelOperation_.ClearFields

{$EndIf msmModelToModelOperation_imp_impl}

{$EndIf msmModelToModelOperation_imp}

