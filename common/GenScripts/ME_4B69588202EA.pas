unit sdsCompareEditionsState;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\sdsCompareEditionsState.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , sdsCompareEditions
 , DocumentUnit
 , EditionsInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwInterfaces
;

type
 _IvcmRealData_ = IsdsCompareEditionsState;
 {$Include vcmData.imp.pas}
 _afwApplicationDataUpdate_Parent_ = _vcmData_;
 {$Include afwApplicationDataUpdate.imp.pas}
 TsdsCompareEditionsState = class(_afwApplicationDataUpdate_, IsdsCompareEditionsState)
  private
   f_EditionForCompare: TRedactionID;
   f_UseCaseData: InsCompareEditionsInfo;
   f_Compared: Boolean;
    {* Было ли проведено сравнение }
   f_CompareRootPair: TnsDiffData;
    {* Результат сравнения }
  private
   procedure CheckCompare;
    {* Проверяет было ли проведено сравнение и если не было, то сравнивает }
  protected
   function Get_EditionForCompare: TRedactionID;
   function Get_UseCaseData: InsCompareEditionsInfo;
   function Get_CompareRootPair: TnsDiffData;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   constructor Create(const aUseCaseData: InsCompareEditionsInfo;
    anEditionForCompare: TRedactionID); reintroduce;
   class function Make(const aUseCaseData: InsCompareEditionsInfo;
    anEditionForCompare: TRedactionID): _afwApplicationDataUpdate_; reintroduce;
 end;//TsdsCompareEditionsState
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , BaseTypesUnit
;

type _Instance_R_ = TsdsCompareEditionsState;

{$Include vcmData.imp.pas}

{$Include afwApplicationDataUpdate.imp.pas}

constructor TsdsCompareEditionsState.Create(const aUseCaseData: InsCompareEditionsInfo;
 anEditionForCompare: TRedactionID);
//#UC START# *4B695A9C0194_4B69588202EA_var*
//#UC END# *4B695A9C0194_4B69588202EA_var*
begin
//#UC START# *4B695A9C0194_4B69588202EA_impl*
 inherited Create;
 f_UseCaseData := aUseCaseData;
 f_EditionForCompare := anEditionForCompare;
//#UC END# *4B695A9C0194_4B69588202EA_impl*
end;//TsdsCompareEditionsState.Create

class function TsdsCompareEditionsState.Make(const aUseCaseData: InsCompareEditionsInfo;
 anEditionForCompare: TRedactionID): _afwApplicationDataUpdate_;
var
 l_Inst : TsdsCompareEditionsState;
begin
 l_Inst := Create(aUseCaseData, anEditionForCompare);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TsdsCompareEditionsState.Make

procedure TsdsCompareEditionsState.CheckCompare;
 {* Проверяет было ли проведено сравнение и если не было, то сравнивает }
//#UC START# *4A785700011C_4B69588202EA_var*
//#UC END# *4A785700011C_4B69588202EA_var*
begin
//#UC START# *4A785700011C_4B69588202EA_impl*
 if not f_Compared then
 begin
  f_UseCaseData.State.DiffWithRedactionById(f_EditionForCompare, f_CompareRootPair);
  if (f_UseCaseData.RedactionCurrentPara <> nil) then
   try
    f_CompareRootPair.rDiffIterator.MoveTo(f_UseCaseData.RedactionCurrentPara.ID);
   except
    on ECannotFindData do
     ;
   end;//try..except
  f_Compared := true;
 end;//not f_Compared
//#UC END# *4A785700011C_4B69588202EA_impl*
end;//TsdsCompareEditionsState.CheckCompare

function TsdsCompareEditionsState.Get_EditionForCompare: TRedactionID;
//#UC START# *4B69581F0199_4B69588202EAget_var*
//#UC END# *4B69581F0199_4B69588202EAget_var*
begin
//#UC START# *4B69581F0199_4B69588202EAget_impl*
 Result := f_EditionForCompare;
//#UC END# *4B69581F0199_4B69588202EAget_impl*
end;//TsdsCompareEditionsState.Get_EditionForCompare

function TsdsCompareEditionsState.Get_UseCaseData: InsCompareEditionsInfo;
//#UC START# *4B69683A00C4_4B69588202EAget_var*
//#UC END# *4B69683A00C4_4B69588202EAget_var*
begin
//#UC START# *4B69683A00C4_4B69588202EAget_impl*
 Result := f_UseCaseData;
//#UC END# *4B69683A00C4_4B69588202EAget_impl*
end;//TsdsCompareEditionsState.Get_UseCaseData

function TsdsCompareEditionsState.Get_CompareRootPair: TnsDiffData;
//#UC START# *4B6972AA017A_4B69588202EAget_var*
//#UC END# *4B6972AA017A_4B69588202EAget_var*
begin
//#UC START# *4B6972AA017A_4B69588202EAget_impl*
 CheckCompare;
 Result := f_CompareRootPair;
//#UC END# *4B6972AA017A_4B69588202EAget_impl*
end;//TsdsCompareEditionsState.Get_CompareRootPair

procedure TsdsCompareEditionsState.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B69588202EA_var*
//#UC END# *479731C50290_4B69588202EA_var*
begin
//#UC START# *479731C50290_4B69588202EA_impl*
 f_Compared := false;
 inherited;
//#UC END# *479731C50290_4B69588202EA_impl*
end;//TsdsCompareEditionsState.Cleanup

procedure TsdsCompareEditionsState.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4B69588202EA_var*
//#UC END# *47EA4E9002C6_4B69588202EA_var*
begin
//#UC START# *47EA4E9002C6_4B69588202EA_impl*
 inherited;
 f_Compared := false;
 Finalize(f_CompareRootPair);
//#UC END# *47EA4E9002C6_4B69588202EA_impl*
end;//TsdsCompareEditionsState.FinishDataUpdate

{$If NOT Defined(NoVCM)}
procedure TsdsCompareEditionsState.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_4B69588202EA_var*
//#UC END# *4B16B8CF0307_4B69588202EA_var*
begin
//#UC START# *4B16B8CF0307_4B69588202EA_impl*
 inherited;
 f_UseCaseData := aData.UseCaseData;
 f_EditionForCompare := aData.EditionForCompare;
 f_CompareRootPair := aData.CompareRootPair;
 f_Compared := true;
//#UC END# *4B16B8CF0307_4B69588202EA_impl*
end;//TsdsCompareEditionsState.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsCompareEditionsState.ClearFields;
begin
 f_UseCaseData := nil;
 inherited;
end;//TsdsCompareEditionsState.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
