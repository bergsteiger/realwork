{$IfNDef vcmData_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Морозов М.А.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmData.imp.pas"
// Начат: 2006/07/13 13:29:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmData_imp}
{$If not defined(NoVCM)}
 _vcmData_ = {mixin} class(Tl3ProtoObject, IvcmData)
 protected
 // realized methods
   function Clone: IvcmData;
     {* сделать копию }
 protected
 // protected methods
   procedure AssignData(const aData: _IvcmRealData_); virtual;
 public
 // public methods
   constructor Create(const aData: _IvcmRealData_); reintroduce; overload; 
   class function MakeFrom(const aData: _IvcmRealData_): IvcmData; reintroduce;
     {* Сигнатура фабрики vcmData.MakeFrom }
   constructor Create; reintroduce; overload;  virtual;
 end;//_vcmData_
{$Else}

 _vcmData_ = Tl3ProtoObject;

{$IfEnd} //not NoVCM

{$Else vcmData_imp}

{$If not defined(NoVCM)}

// start class _vcmData_

constructor _vcmData_.Create(const aData: _IvcmRealData_);
//#UC START# *4B16B95802AF_4B16B85D03A1_var*
//#UC END# *4B16B95802AF_4B16B85D03A1_var*
begin
//#UC START# *4B16B95802AF_4B16B85D03A1_impl*
 Create;
 AssignData(aData);
//#UC END# *4B16B95802AF_4B16B85D03A1_impl*
end;//_vcmData_.Create

class function _vcmData_.MakeFrom(const aData: _IvcmRealData_): IvcmData;
var
 l_Inst : _vcmData_;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure _vcmData_.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_4B16B85D03A1_var*
//#UC END# *4B16B8CF0307_4B16B85D03A1_var*
begin
//#UC START# *4B16B8CF0307_4B16B85D03A1_impl*
 // - ничего не делаем
//#UC END# *4B16B8CF0307_4B16B85D03A1_impl*
end;//_vcmData_.AssignData

constructor _vcmData_.Create;
//#UC START# *4B16B8E3013F_4B16B85D03A1_var*
//#UC END# *4B16B8E3013F_4B16B85D03A1_var*
begin
//#UC START# *4B16B8E3013F_4B16B85D03A1_impl*
 inherited Create;
//#UC END# *4B16B8E3013F_4B16B85D03A1_impl*
end;//_vcmData_.Create

function _vcmData_.Clone: IvcmData;
//#UC START# *4995768F007A_4B16B85D03A1_var*
//#UC END# *4995768F007A_4B16B85D03A1_var*
begin
//#UC START# *4995768F007A_4B16B85D03A1_impl*
 Result := MakeFrom(_Instance_R_(Self));
//#UC END# *4995768F007A_4B16B85D03A1_impl*
end;//_vcmData_.Clone

{$IfEnd} //not NoVCM

{$EndIf vcmData_imp}
