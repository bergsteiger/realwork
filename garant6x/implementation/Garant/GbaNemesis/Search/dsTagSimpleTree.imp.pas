{$IfNDef dsTagSimpleTree_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/dsTagSimpleTree.imp.pas"
// Начат: 02.08.2005 11.17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Базовые определения предметной области::SearchLite::Search::Search::dsTagSimpleTree
//
// Бизнес объекта для словарных атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsTagSimpleTree_imp}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 _dsTagSimpleTree_ = {abstract vac} class(_dsSimpleTree_, IdsTagSimpleTree)
  {* Бизнес объекта для словарных атрибутов }
 private
 // private fields
   f_Operations : TLogicOperationSet;
    {* Поле для свойства Operations}
 private
 // private methods
   procedure UpdateOperations;
 protected
 // realized methods
   function pm_GetSearch: IdeSearch;
   function pm_GetOperations: TLogicOperationSet;
   function pm_GetIsOneOperation: Boolean;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure GotData; override;
     {* - данные изменились. }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function GetOperations: TLogicOperationSet; virtual;
 protected
 // protected properties
   property Operations: TLogicOperationSet
     read f_Operations;
 end;//_dsTagSimpleTree_

{$Else dsTagSimpleTree_imp}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}

// start class _dsTagSimpleTree_

procedure _dsTagSimpleTree_.UpdateOperations;
//#UC START# *492404C20046_4924015202CD_var*
//#UC END# *492404C20046_4924015202CD_var*
begin
//#UC START# *492404C20046_4924015202CD_impl*
 f_Operations := bsGetOperations(PartData.Tag);
//#UC END# *492404C20046_4924015202CD_impl*
end;//_dsTagSimpleTree_.UpdateOperations

function _dsTagSimpleTree_.GetOperations: TLogicOperationSet;
//#UC START# *492406340209_4924015202CD_var*
//#UC END# *492406340209_4924015202CD_var*
begin
//#UC START# *492406340209_4924015202CD_impl*
 Result := f_Operations;
//#UC END# *492406340209_4924015202CD_impl*
end;//_dsTagSimpleTree_.GetOperations

function _dsTagSimpleTree_.pm_GetSearch: IdeSearch;
//#UC START# *4923FDA60287_4924015202CDget_var*
//#UC END# *4923FDA60287_4924015202CDget_var*
begin
//#UC START# *4923FDA60287_4924015202CDget_impl*
 Result := PartData;
//#UC END# *4923FDA60287_4924015202CDget_impl*
end;//_dsTagSimpleTree_.pm_GetSearch

function _dsTagSimpleTree_.pm_GetOperations: TLogicOperationSet;
//#UC START# *4923FDDB026F_4924015202CDget_var*
//#UC END# *4923FDDB026F_4924015202CDget_var*
begin
//#UC START# *4923FDDB026F_4924015202CDget_impl*
 Result := GetOperations;
//#UC END# *4923FDDB026F_4924015202CDget_impl*
end;//_dsTagSimpleTree_.pm_GetOperations

function _dsTagSimpleTree_.pm_GetIsOneOperation: Boolean;
//#UC START# *4923FDFA00F7_4924015202CDget_var*
//#UC END# *4923FDFA00F7_4924015202CDget_var*
begin
//#UC START# *4923FDFA00F7_4924015202CDget_impl*
 Result := bsIsOneOperation(GetOperations);
//#UC END# *4923FDFA00F7_4924015202CDget_impl*
end;//_dsTagSimpleTree_.pm_GetIsOneOperation

{$If not defined(NoVCM)}
procedure _dsTagSimpleTree_.GotData;
//#UC START# *492ACF630072_4924015202CD_var*
//#UC END# *492ACF630072_4924015202CD_var*
begin
//#UC START# *492ACF630072_4924015202CD_impl*
 inherited;
 UpdateOperations;
//#UC END# *492ACF630072_4924015202CD_impl*
end;//_dsTagSimpleTree_.GotData
{$IfEnd} //not NoVCM

{$EndIf dsTagSimpleTree_imp}
