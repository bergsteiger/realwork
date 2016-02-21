unit BaseEditions_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\BaseEditions_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , eeInterfaces
 , EditionsInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypesNew
 , PrimLeftEdition_Form
 , CompareEditions_FormDefinitions_Controls
 , PrimRightEdition_Form
 , PrimEditionsContainer_Form
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimEditionsContainer_utEditionsContainer_UserType
 , l3Interfaces
 , PrimLeftEdition_utLeftEdition_UserType
 , nevTools
 , l3Tree_TLB
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentInterfaces
 , PrimRightEdition_utRightEdition_UserType
;

type
 TLeftEditionForm = {final} class(TPrimLeftEditionForm, LeftEditionFormDef)
  {* Предыдущая редакция }
 end;//TLeftEditionForm

 TRightEditionForm = {final} class(TPrimRightEditionForm, RightEditionFormDef)
  {* Текущая редакция }
 end;//TRightEditionForm

 TEditionsContainerForm = {final} class(TPrimEditionsContainerForm, EditionsContainerFormDef)
  {* Сравнение редакций документа }
 end;//TEditionsContainerForm

 // Left

 // Right

 // EditionsContainer

 Tfs_CompareEditions = {final} class(TvcmFormSetFactory)
  {* Сравнение редакций документа }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function EditionsContainer_Parent_utEditionsContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для EditionsContainer }
   function Left_Child_utLeftEdition_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Left }
   function Right_Main_utRightEdition_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Right }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_CompareEditions;
    {* Метод получения экземпляра синглетона Tfs_CompareEditions }
 end;//Tfs_CompareEditions

 TBaseEditionsModule = {abstract} class
  public
   procedure MakeCompareEditions(const aDoc: IDocument;
    const aPara: IeeLeafPara;
    aEditionForCompare: Integer;
    const aDocumentForReturn: TnsDocumentForReturnInfo;
    const aContainer: IvcmContainer = nil); overload;
    {* Создаёт представление прецедента "Сравнение редакций" }
   procedure MakeCompareEditions(const aDoc: IDocument;
    const aPara: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aLeft: IDocument;
    const aRight: IDocument;
    const aPara: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aDoc: IDocument;
    const aPara: IeeLeafPara;
    aEditionForCompare: Integer;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aLeft: IDocument;
    const aRight: IDocument;
    const aParaForPositionning: IeeLeafPara;
    const aDocumentForReturn: IDocument;
    const aParaForReturn: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aLeft: IDocument;
    const aRight: IDocument;
    const aPosition: TbsDocPos;
    const aDocumentForReturn: IDocument;
    const aParaForReturn: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
 end;//TBaseEditionsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , sdsCompareEditions
 , nsCompareEditionsInfo
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , LeftEditionKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , RightEditionKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , EditionsContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
;

var g_Tfs_CompareEditions: Tfs_CompareEditions = nil;
 {* Экземпляр синглетона Tfs_CompareEditions }

const
 {* Локализуемые строки CompareEditionsCaptionLocalConstants }
 str_fsCompareEditionsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsCompareEditionsCaption'; rValue : 'Сравнение редакций');
  {* Заголовок фабрики сборки форм "CompareEditions" }

const
 {* Локализуемые строки Local }
 str_NoPrevEdition: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NoPrevEdition'; rValue : 'Нет редакции для сравнения. У изучаемого Вами документа нет более ранних действовавших когда-либо редакций.');
  {* 'Нет редакции для сравнения. У изучаемого Вами документа нет более ранних действовавших когда-либо редакций.' }

procedure Tfs_CompareEditionsFree;
 {* Метод освобождения экземпляра синглетона Tfs_CompareEditions }
begin
 l3Free(g_Tfs_CompareEditions);
end;//Tfs_CompareEditionsFree

function Tfs_CompareEditions.EditionsContainer_Parent_utEditionsContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для EditionsContainer }
//#UC START# *220564C38BDB_4A6EBF8301FA_var*
//#UC END# *220564C38BDB_4A6EBF8301FA_var*
begin
//#UC START# *220564C38BDB_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *220564C38BDB_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.EditionsContainer_Parent_utEditionsContainer_NeedMakeForm

function Tfs_CompareEditions.Left_Child_utLeftEdition_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Left }
//#UC START# *2F2577A83E0B_4A6EBF8301FA_var*
//#UC END# *2F2577A83E0B_4A6EBF8301FA_var*
begin
//#UC START# *2F2577A83E0B_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *2F2577A83E0B_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.Left_Child_utLeftEdition_NeedMakeForm

function Tfs_CompareEditions.Right_Main_utRightEdition_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Right }
//#UC START# *B8C95E6B157E_4A6EBF8301FA_var*
//#UC END# *B8C95E6B157E_4A6EBF8301FA_var*
begin
//#UC START# *B8C95E6B157E_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *B8C95E6B157E_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.Right_Main_utRightEdition_NeedMakeForm

class function Tfs_CompareEditions.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_CompareEditions <> nil;
end;//Tfs_CompareEditions.Exists

class function Tfs_CompareEditions.Instance: Tfs_CompareEditions;
 {* Метод получения экземпляра синглетона Tfs_CompareEditions }
begin
 if (g_Tfs_CompareEditions = nil) then
 begin
  l3System.AddExitProc(Tfs_CompareEditionsFree);
  g_Tfs_CompareEditions := Create;
 end;
 Result := g_Tfs_CompareEditions;
end;//Tfs_CompareEditions.Instance

procedure Tfs_CompareEditions.InitFields;
//#UC START# *47A042E100E2_4A6EBF8301FA_var*
//#UC END# *47A042E100E2_4A6EBF8301FA_var*
begin
//#UC START# *47A042E100E2_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_CompareEditions.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4A6EBF8301FA_var*
//#UC END# *4FFE854A009B_4A6EBF8301FA_var*
begin
//#UC START# *4FFE854A009B_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

procedure TBaseEditionsModule.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 aEditionForCompare: Integer;
 const aDocumentForReturn: TnsDocumentForReturnInfo;
 const aContainer: IvcmContainer = nil);
 {* Создаёт представление прецедента "Сравнение редакций" }
//#UC START# *4A71ADFC00B4_4A6D5F3D03A9_var*
 l_Container: IvcmContainer;
//#UC END# *4A71ADFC00B4_4A6D5F3D03A9_var*
begin
//#UC START# *4A71ADFC00B4_4A6D5F3D03A9_impl*
  try
   if Assigned(aContainer)
    then l_Container := aContainer
    else l_Container := DefaultContainer;
   Tfs_CompareEditions.Make(
    TsdsCompareEditions.Make(TnsCompareEditionsInfo.Make(aDoc, aPara, aEditionForCompare, aDocumentForReturn)),
    l_Container);
  except
   on ERedactionNotFound do
    vcmSay(inf_AnyInformation, [str_NoPrevEdition.AsCStr]);
  end;//try..except
//#UC END# *4A71ADFC00B4_4A6D5F3D03A9_impl*
end;//TBaseEditionsModule.MakeCompareEditions

procedure TBaseEditionsModule.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
//#UC START# *4B60761E0096_4A6D5F3D03A9_var*
//#UC END# *4B60761E0096_4A6D5F3D03A9_var*
begin
//#UC START# *4B60761E0096_4A6D5F3D03A9_impl*
 MakeCompareEditions(aDoc, aPara, -1, TnsDocumentForReturnInfo_C(aDoc, aPara));
//#UC END# *4B60761E0096_4A6D5F3D03A9_impl*
end;//TBaseEditionsModule.MakeCompareEditions

procedure TBaseEditionsModule.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aPara: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
//#UC START# *4EC4FB3002FF_4A6D5F3D03A9_var*
var
 l_LeftState : IDocumentState;
//#UC END# *4EC4FB3002FF_4A6D5F3D03A9_var*
begin
//#UC START# *4EC4FB3002FF_4A6D5F3D03A9_impl*
  aLeft.GetCurrentState(l_LeftState);
  TdmStdRes.MakeCompareEditions(aRight,
                                aPara,
                                l_LeftState.Redaction,
                                TnsDocumentForReturnInfo_C(aRight, aPara));
//#UC END# *4EC4FB3002FF_4A6D5F3D03A9_impl*
end;//TBaseEditionsModule.MakeCompareEditions

procedure TBaseEditionsModule.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 aEditionForCompare: Integer;
 const aContainer: IvcmContainer = nil);
//#UC START# *4F2BEE7302EB_4A6D5F3D03A9_var*
//#UC END# *4F2BEE7302EB_4A6D5F3D03A9_var*
begin
//#UC START# *4F2BEE7302EB_4A6D5F3D03A9_impl*
 MakeCompareEditions(aDoc, aPara,
                     aEditionForCompare,
                     TnsDocumentForReturnInfo_C(aDoc, aPara));
//#UC END# *4F2BEE7302EB_4A6D5F3D03A9_impl*
end;//TBaseEditionsModule.MakeCompareEditions

procedure TBaseEditionsModule.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aParaForPositionning: IeeLeafPara;
 const aDocumentForReturn: IDocument;
 const aParaForReturn: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
//#UC START# *5211D23D038A_4A6D5F3D03A9_var*
var
 l_LeftState : IDocumentState;
//#UC END# *5211D23D038A_4A6D5F3D03A9_var*
begin
//#UC START# *5211D23D038A_4A6D5F3D03A9_impl*
 aLeft.GetCurrentState(l_LeftState);
 MakeCompareEditions(aRight,
                     aParaForPositionning,
                     l_LeftState.Redaction,
                     TnsDocumentForReturnInfo_C(aDocumentForReturn, aParaForReturn));
//#UC END# *5211D23D038A_4A6D5F3D03A9_impl*
end;//TBaseEditionsModule.MakeCompareEditions

procedure TBaseEditionsModule.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aPosition: TbsDocPos;
 const aDocumentForReturn: IDocument;
 const aParaForReturn: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
//#UC START# *5214A1820193_4A6D5F3D03A9_var*
var
 l_LeftState: IDocumentState;
 l_Container: IvcmContainer;
//#UC END# *5214A1820193_4A6D5F3D03A9_var*
begin
//#UC START# *5214A1820193_4A6D5F3D03A9_impl*
  try
   aLeft.GetCurrentState(l_LeftState);
   try
    if Assigned(aContainer)
     then l_Container := aContainer
     else l_Container := DefaultContainer;
    Tfs_CompareEditions.Make(
     TsdsCompareEditions.Make(TnsCompareEditionsInfo.Make(aRight,
                                                          aPosition,
                                                          l_LeftState.Redaction,
                                                          TnsDocumentForReturnInfo_C(aDocumentForReturn, aParaForReturn))),
     l_Container);
   finally
    l_LeftState := nil;
   end;
  except
   on ERedactionNotFound do
    vcmSay(inf_AnyInformation, [str_NoPrevEdition.AsCStr]);
  end;//try..except
//#UC END# *5214A1820193_4A6D5F3D03A9_impl*
end;//TBaseEditionsModule.MakeCompareEditions

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLeftEditionForm);
 {* Регистрация LeftEdition }
{$IfEnd} // NOT Defined(NoScripts)
 fm_LeftEditionForm.SetFactory(TLeftEditionForm.Make);
 {* Регистрация фабрики формы LeftEdition }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRightEditionForm);
 {* Регистрация RightEdition }
{$IfEnd} // NOT Defined(NoScripts)
 fm_RightEditionForm.SetFactory(TRightEditionForm.Make);
 {* Регистрация фабрики формы RightEdition }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TEditionsContainerForm);
 {* Регистрация EditionsContainer }
{$IfEnd} // NOT Defined(NoScripts)
 fm_EditionsContainerForm.SetFactory(TEditionsContainerForm.Make);
 {* Регистрация фабрики формы EditionsContainer }
 str_fsCompareEditionsCaption.Init;
 {* Инициализация str_fsCompareEditionsCaption }
 str_NoPrevEdition.Init;
 {* Инициализация str_NoPrevEdition }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
