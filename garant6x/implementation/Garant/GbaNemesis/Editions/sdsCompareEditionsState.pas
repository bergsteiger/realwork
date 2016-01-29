unit sdsCompareEditionsState;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/sdsCompareEditionsState.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::Editions::TsdsCompareEditionsState
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  EditionsInterfaces,
  sdsCompareEditions
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject,
  afwInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _IvcmRealData_ = IsdsCompareEditionsState;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}
 _afwApplicationDataUpdate_Parent_ = _vcmData_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TsdsCompareEditionsState = class(_afwApplicationDataUpdate_, IsdsCompareEditionsState)
 private
 // private fields
   f_EditionForCompare : TRedactionID;
   f_UseCaseData : InsCompareEditionsInfo;
   f_Compared : Boolean;
    {* Было ли проведено сравнение}
   f_CompareRootPair : TnsDiffData;
    {* Результат сравнения}
 private
 // private methods
   procedure CheckCompare;
     {* Проверяет было ли проведено сравнение и если не было, то сравнивает }
 protected
 // realized methods
   function Get_EditionForCompare: TRedactionID;
   function Get_UseCaseData: InsCompareEditionsInfo;
   function Get_CompareRootPair: TnsDiffData;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aUseCaseData: InsCompareEditionsInfo;
     anEditionForCompare: TRedactionID); reintroduce;
   class function Make(const aUseCaseData: InsCompareEditionsInfo;
     anEditionForCompare: TRedactionID): IsdsCompareEditionsState; reintroduce;
     {* Сигнатура фабрики TsdsCompareEditionsState.Make }
 end;//TsdsCompareEditionsState
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaseTypesUnit,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsCompareEditionsState;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TsdsCompareEditionsState

procedure TsdsCompareEditionsState.CheckCompare;
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
  anEditionForCompare: TRedactionID): IsdsCompareEditionsState;
var
 l_Inst : TsdsCompareEditionsState;
begin
 l_Inst := Create(aUseCaseData, anEditionForCompare);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

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

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

procedure TsdsCompareEditionsState.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_UseCaseData := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TsdsCompareEditionsState.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.