{$IfNDef vcmData_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas"
// Стереотип: "Impurity"

{$Define vcmData_imp}

{$If NOT Defined(NoVCM)}
type
 // _IvcmRealData_

 _vcmData_ = class(Tl3ProtoObject, IvcmData)
  protected
   procedure AssignData(const aData: _IvcmRealData_); virtual;
   function Clone: IvcmData;
    {* сделать копию }
  public
   constructor Create(const aData: _IvcmRealData_); reintroduce; overload;
   class function MakeFrom(const aData: _IvcmRealData_): IvcmData; reintroduce;
   constructor Create; reintroduce; overload; virtual;
 end;//_vcmData_

{$Else NOT Defined(NoVCM)}

_vcmData_ = Tl3ProtoObject;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmData_imp}

{$IfNDef vcmData_imp_impl}

{$Define vcmData_imp_impl}

{$If NOT Defined(NoVCM)}
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
end;//_vcmData_.MakeFrom

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
 {* сделать копию }
//#UC START# *4995768F007A_4B16B85D03A1_var*
//#UC END# *4995768F007A_4B16B85D03A1_var*
begin
//#UC START# *4995768F007A_4B16B85D03A1_impl*
 Result := MakeFrom(_Instance_R_(Self));
//#UC END# *4995768F007A_4B16B85D03A1_impl*
end;//_vcmData_.Clone
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmData_imp_impl}

{$EndIf vcmData_imp}

