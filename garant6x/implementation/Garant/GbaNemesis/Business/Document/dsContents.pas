unit dsContents;
 {* бизнес объект формы ContentsForm }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsContents.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsContents" MUID: (4925730902E4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , WorkWithDocumentInterfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentInterfaces
 , DocumentUnit
 , F1TagDataProviderInterface
 , nsTypesNew
 , l3InternalInterfaces
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
;

type
 _FormDataSourceType_ = IdsContents;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseContents.imp.pas}
 TdsContents = {final} class(_dsBaseContents_, IdsContents)
  {* бизнес объект формы ContentsForm }
  private
   ucc_IsdsDocument: IsdsDocument;
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* Создать данные дерева }
   function pm_GetHasRespondents: Boolean;
   function pm_GetHasCorrespondents: Boolean;
   function HasSimilarToFragment(anId: Integer): Boolean;
   procedure OpenSimilarDocuments;
   procedure OpenSimilarDocumentsToFragment(aBlockId: Integer);
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* Инициализирует ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* Очищает ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsContents
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , vtUtils
 , DocumentRes
 , l3String
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , dsBaseContentsRes
 , SysUtils
 , l3Base
 , vtStdRes
 , DynamicTreeUnit
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
 {$If Defined(Nemesis)}
 , nscContextFilterState
 {$IfEnd} // Defined(Nemesis)
 //#UC START# *4925730902E4impl_uses*
 //#UC END# *4925730902E4impl_uses*
;

type _Instance_R_ = TdsContents;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseContents.imp.pas}

function TdsContents.MakeSimpleTree: Il3SimpleTree;
 {* Создать данные дерева }
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

{$If NOT Defined(NoVCM)}
procedure TdsContents.InitRefs(const aDS: IvcmFormSetDataSource);
 {* Инициализирует ссылки на различные представления прецедента }
begin
 inherited;
 ucc_IsdsDocument := aDS As IsdsDocument;
end;//TdsContents.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsContents.ClearRefs;
 {* Очищает ссылки на различные представления прецедента }
begin
 inherited;
 ucc_IsdsDocument := nil;
end;//TdsContents.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
