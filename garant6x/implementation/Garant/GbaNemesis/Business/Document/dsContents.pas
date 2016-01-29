unit dsContents;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsContents.pas"
// Начат: 2005/09/28 12:40:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::Document::TdsContents
//
// бизнес объект формы ContentsForm
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
  WorkWithDocumentInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  bsInterfaces
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  DocumentInterfaces,
  DocumentUnit,
  F1TagDataProviderInterface,
  nsTypesNew,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsContents;
 {$Include ..\Document\dsBaseContents.imp.pas}
 TdsContents = {final vac} class(_dsBaseContents_, IdsContents)
  {* бизнес объект формы ContentsForm }
 private
 // private fields
   ucc_IsdsDocument : IsdsDocument;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   function MakeSimpleTree: Il3SimpleTree; override;
     {* Создать данные дерева }
   function pm_GetHasRespondents: Boolean;
   function pm_GetHasCorrespondents: Boolean;
   function HasSimilarToFragment(anId: Integer): Boolean;
   procedure OpenSimilarDocuments;
   procedure OpenSimilarDocumentsToFragment(aBlockId: Integer);
 end;//TdsContents
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  vtUtils,
  DocumentRes,
  l3String
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  dsBaseContentsRes,
  SysUtils,
  l3Base,
  vtStdRes,
  DynamicTreeUnit,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  {$If defined(Nemesis)}
  ,
  nscContextFilterState
  {$IfEnd} //Nemesis
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsContents;

{$Include ..\Document\dsBaseContents.imp.pas}

// start class TdsContents

function TdsContents.MakeSimpleTree: Il3SimpleTree;
//#UC START# *47F4C2B9014A_4925730902E4_var*
//#UC END# *47F4C2B9014A_4925730902E4_var*
begin
//#UC START# *47F4C2B9014A_4925730902E4_impl*
 Result := nil;
 //Assert(false);
 // - временно закомментировал для http://mdp.garant.ru/pages/viewpage.action?pageId=248195582 
 // Если попадём сюда, то читаем http://mdp.garant.ru/pages/viewpage.action?pageId=135605187
//#UC END# *47F4C2B9014A_4925730902E4_impl*
end;//TdsContents.MakeSimpleTree

function TdsContents.pm_GetHasRespondents: Boolean;
//#UC START# *492571BE02C8_4925730902E4get_var*
//#UC END# *492571BE02C8_4925730902E4get_var*
begin
//#UC START# *492571BE02C8_4925730902E4get_impl*
 Result := ucc_IsdsDocument.HasRespondents;
//#UC END# *492571BE02C8_4925730902E4get_impl*
end;//TdsContents.pm_GetHasRespondents

function TdsContents.pm_GetHasCorrespondents: Boolean;
//#UC START# *492571CF017C_4925730902E4get_var*
//#UC END# *492571CF017C_4925730902E4get_var*
begin
//#UC START# *492571CF017C_4925730902E4get_impl*
 Result := ucc_IsdsDocument.HasCorrespondents;
//#UC END# *492571CF017C_4925730902E4get_impl*
end;//TdsContents.pm_GetHasCorrespondents

function TdsContents.HasSimilarToFragment(anId: Integer): Boolean;
//#UC START# *55880E2802C5_4925730902E4_var*
//#UC END# *55880E2802C5_4925730902E4_var*
begin
//#UC START# *55880E2802C5_4925730902E4_impl*
 Result := ucc_IsdsDocument.HasSimilarToFragment(anId);
//#UC END# *55880E2802C5_4925730902E4_impl*
end;//TdsContents.HasSimilarToFragment

procedure TdsContents.OpenSimilarDocuments;
//#UC START# *55925FB9019A_4925730902E4_var*
//#UC END# *55925FB9019A_4925730902E4_var*
begin
//#UC START# *55925FB9019A_4925730902E4_impl*
 ucc_IsdsDocument.OpenSimilarDocuments;
//#UC END# *55925FB9019A_4925730902E4_impl*
end;//TdsContents.OpenSimilarDocuments

procedure TdsContents.OpenSimilarDocumentsToFragment(aBlockId: Integer);
//#UC START# *5594F4DB0203_4925730902E4_var*
//#UC END# *5594F4DB0203_4925730902E4_var*
begin
//#UC START# *5594F4DB0203_4925730902E4_impl*
 ucc_IsdsDocument.OpenSimilarDocumentsToFragment(aBlockId);
//#UC END# *5594F4DB0203_4925730902E4_impl*
end;//TdsContents.OpenSimilarDocumentsToFragment

procedure TdsContents.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 ucc_IsdsDocument := aDS As IsdsDocument;
end;

procedure TdsContents.ClearRefs;
begin
 inherited;
 ucc_IsdsDocument := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.