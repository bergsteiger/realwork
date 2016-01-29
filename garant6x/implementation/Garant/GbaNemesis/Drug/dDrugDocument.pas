unit dDrugDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Drug"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Drug/dDrugDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Drug::DrugData::TdDrugDocument
//
// Данные описания препарата.
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
  DocumentAndListInterfaces,
  MedicInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  l3Types,
  BaseDocumentWithAttributesInterfaces,
  DocumentInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _IvcmRealData_ = IdDrugDocument;
 {$Include ..\Drug\dBaseDrugDocument.imp.pas}
 TdDrugDocument = class(_dBaseDrugDocument_, IdDrugDocument)
  {* Данные описания препарата. }
 private
 // private fields
   f_ContentsTree : IdeSimpleTree;
   f_dsContentsRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsContentsRef}
 protected
 // realized methods
   function pm_GetDsContentsRef: IvcmFormDataSourceRef;
   function pm_GetContentsTree: IdeSimpleTree;
   procedure pm_SetContentsTree(const aValue: IdeSimpleTree);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Make: IdDrugDocument; reintroduce;
 end;//TdDrugDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmFormDataSourceRef
  {$IfEnd} //not NoVCM
  ,
  l3Utils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdDrugDocument;

{$Include ..\Drug\dBaseDrugDocument.imp.pas}

// start class TdDrugDocument

class function TdDrugDocument.Make: IdDrugDocument;
var
 l_Inst : TdDrugDocument;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdDrugDocument.pm_GetDsContentsRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsContentsRef);
end;//TdDrugDocument.pm_GetDsContentsRef

function TdDrugDocument.pm_GetContentsTree: IdeSimpleTree;
//#UC START# *493925D603CF_47F4CCAD037Fget_var*
//#UC END# *493925D603CF_47F4CCAD037Fget_var*
begin
//#UC START# *493925D603CF_47F4CCAD037Fget_impl*
 Result := f_ContentsTree;
//#UC END# *493925D603CF_47F4CCAD037Fget_impl*
end;//TdDrugDocument.pm_GetContentsTree

procedure TdDrugDocument.pm_SetContentsTree(const aValue: IdeSimpleTree);
//#UC START# *493925D603CF_47F4CCAD037Fset_var*
//#UC END# *493925D603CF_47F4CCAD037Fset_var*
begin
//#UC START# *493925D603CF_47F4CCAD037Fset_impl*
 f_ContentsTree := aValue;
//#UC END# *493925D603CF_47F4CCAD037Fset_impl*
end;//TdDrugDocument.pm_SetContentsTree

procedure TdDrugDocument.Cleanup;
//#UC START# *479731C50290_47F4CCAD037F_var*
//#UC END# *479731C50290_47F4CCAD037F_var*
begin
//#UC START# *479731C50290_47F4CCAD037F_impl*
 f_ContentsTree := nil;
 inherited;
//#UC END# *479731C50290_47F4CCAD037F_impl*
end;//TdDrugDocument.Cleanup

{$If not defined(NoVCM)}
procedure TdDrugDocument.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_47F4CCAD037F_var*
//#UC END# *4B16B8CF0307_47F4CCAD037F_var*
begin
//#UC START# *4B16B8CF0307_47F4CCAD037F_impl*
 f_ContentsTree := aData.ContentsTree;
 pm_GetDsContentsRef.Assign(aData.dsContentsRef);
 inherited;
//#UC END# *4B16B8CF0307_47F4CCAD037F_impl*
end;//TdDrugDocument.AssignData
{$IfEnd} //not NoVCM

procedure TdDrugDocument.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ContentsTree := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsContentsRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdDrugDocument.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.