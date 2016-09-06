{$IfNDef msmConcreteModelOperation_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmConcreteModelOperation.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmConcreteModelOperation" MUID: (57CEB54C02B6)
// Имя типа: "_msmConcreteModelOperation_"

{$Define msmConcreteModelOperation_imp}

 // _ConcreteModel_

 _msmConcreteModelOperation_ = {abstract} class(TmsmOperation)
  private
   f_Model: _ConcreteModel_;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aCaption: AnsiString;
    const aModel: _ConcreteModel_); reintroduce;
   class function Make(const aCaption: AnsiString;
    const aModel: _ConcreteModel_): ImsmOperation; reintroduce;
  protected
   property Model: _ConcreteModel_
    read f_Model;
 end;//_msmConcreteModelOperation_

{$Else msmConcreteModelOperation_imp}

{$IfNDef msmConcreteModelOperation_imp_impl}

{$Define msmConcreteModelOperation_imp_impl}

constructor _msmConcreteModelOperation_.Create(const aCaption: AnsiString;
 const aModel: _ConcreteModel_);
//#UC START# *57CEB5F50141_57CEB54C02B6_var*
//#UC END# *57CEB5F50141_57CEB54C02B6_var*
begin
//#UC START# *57CEB5F50141_57CEB54C02B6_impl*
 f_Model := aModel;
 inherited Create(aCaption, aModel);
//#UC END# *57CEB5F50141_57CEB54C02B6_impl*
end;//_msmConcreteModelOperation_.Create

class function _msmConcreteModelOperation_.Make(const aCaption: AnsiString;
 const aModel: _ConcreteModel_): ImsmOperation;
var
 l_Inst : _msmConcreteModelOperation_;
begin
 l_Inst := Create(aCaption, aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_msmConcreteModelOperation_.Make

procedure _msmConcreteModelOperation_.ClearFields;
begin
 Finalize(f_Model);
 inherited;
end;//_msmConcreteModelOperation_.ClearFields

{$EndIf msmConcreteModelOperation_imp_impl}

{$EndIf msmConcreteModelOperation_imp}

