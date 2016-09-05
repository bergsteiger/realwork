unit BaseEditions_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\BaseEditions_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "BaseEditions" MUID: (4A6D5F3D03A9)
// Имя типа: "TBaseEditionsModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TBaseEditionsModule = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TBaseEditionsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , DocumentUnit
 , eeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypesNew
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , nsCompareEditionsInfo
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 , sdsCompareEditions
 , SysUtils
 , l3Base
 , LeftEdition_Form
 , RightEdition_Form
 , EditionsContainer_Form
 , fsCompareEditions
 , CompareEditions_FormDefinitions_Controls
 //#UC START# *4A6D5F3D03A9impl_uses*
 //#UC END# *4A6D5F3D03A9impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TEditionsServiceImpl = {final} class(TvcmModuleContractImplementation, IEditionsService)
  public
   procedure MakeCompareEditions(const aLeft: IDocument;
    const aRight: IDocument;
    const aParaForPositionning: IeeLeafPara;
    const aDocumentForReturn: IDocument;
    const aParaForReturn: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
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
    const aPosition: TbsDocPos;
    const aDocumentForReturn: IDocument;
    const aParaForReturn: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aDoc: IDocument;
    const aPara: IeeLeafPara;
    aEditionForCompare: Integer;
    const aDocumentForReturn: TnsDocumentForReturnInfo;
    const aContainer: IvcmContainer = nil); overload;
    {* Создаёт представление прецедента "Сравнение редакций" }
   class function Instance: TEditionsServiceImpl;
    {* Метод получения экземпляра синглетона TEditionsServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TEditionsServiceImpl

var g_TEditionsServiceImpl: TEditionsServiceImpl = nil;
 {* Экземпляр синглетона TEditionsServiceImpl }

const
 {* Локализуемые строки Local }
 str_NoPrevEdition: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NoPrevEdition'; rValue : 'Нет редакции для сравнения. У изучаемого Вами документа нет более ранних действовавших когда-либо редакций.');
  {* 'Нет редакции для сравнения. У изучаемого Вами документа нет более ранних действовавших когда-либо редакций.' }

procedure TEditionsServiceImplFree;
 {* Метод освобождения экземпляра синглетона TEditionsServiceImpl }
begin
 l3Free(g_TEditionsServiceImpl);
end;//TEditionsServiceImplFree

procedure TEditionsServiceImpl.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aParaForPositionning: IeeLeafPara;
 const aDocumentForReturn: IDocument;
 const aParaForReturn: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *5211D23D038A_4A6D5F3D03A9_var*
var
 l_LeftState : IDocumentState;
//#UC END# *5211D23D038A_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *5211D23D038A_4A6D5F3D03A9_impl*
 aLeft.GetCurrentState(l_LeftState);
 MakeCompareEditions(aRight,
                     aParaForPositionning,
                     l_LeftState.Redaction,
                     TnsDocumentForReturnInfo_C(aDocumentForReturn, aParaForReturn));
//#UC END# *5211D23D038A_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TEditionsServiceImpl.MakeCompareEditions

procedure TEditionsServiceImpl.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *4B60761E0096_4A6D5F3D03A9_var*
//#UC END# *4B60761E0096_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4B60761E0096_4A6D5F3D03A9_impl*
 MakeCompareEditions(aDoc, aPara, -1, TnsDocumentForReturnInfo_C(aDoc, aPara));
//#UC END# *4B60761E0096_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TEditionsServiceImpl.MakeCompareEditions

procedure TEditionsServiceImpl.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aPara: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *4EC4FB3002FF_4A6D5F3D03A9_var*
var
 l_LeftState : IDocumentState;
//#UC END# *4EC4FB3002FF_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4EC4FB3002FF_4A6D5F3D03A9_impl*
  aLeft.GetCurrentState(l_LeftState);
  TEditionsService.Instance.MakeCompareEditions(aRight,
                                aPara,
                                l_LeftState.Redaction,
                                TnsDocumentForReturnInfo_C(aRight, aPara));
//#UC END# *4EC4FB3002FF_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TEditionsServiceImpl.MakeCompareEditions

procedure TEditionsServiceImpl.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 aEditionForCompare: Integer;
 const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *4F2BEE7302EB_4A6D5F3D03A9_var*
//#UC END# *4F2BEE7302EB_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4F2BEE7302EB_4A6D5F3D03A9_impl*
 MakeCompareEditions(aDoc, aPara,
                     aEditionForCompare,
                     TnsDocumentForReturnInfo_C(aDoc, aPara));
//#UC END# *4F2BEE7302EB_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TEditionsServiceImpl.MakeCompareEditions

procedure TEditionsServiceImpl.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aPosition: TbsDocPos;
 const aDocumentForReturn: IDocument;
 const aParaForReturn: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *5214A1820193_4A6D5F3D03A9_var*
var
 l_LeftState: IDocumentState;
 l_Container: IvcmContainer;
//#UC END# *5214A1820193_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TEditionsServiceImpl.MakeCompareEditions

procedure TEditionsServiceImpl.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 aEditionForCompare: Integer;
 const aDocumentForReturn: TnsDocumentForReturnInfo;
 const aContainer: IvcmContainer = nil);
 {* Создаёт представление прецедента "Сравнение редакций" }
var
 __WasEnter : Boolean;
//#UC START# *4A71ADFC00B4_4A6D5F3D03A9_var*
 l_Container: IvcmContainer;
//#UC END# *4A71ADFC00B4_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TEditionsServiceImpl.MakeCompareEditions

class function TEditionsServiceImpl.Instance: TEditionsServiceImpl;
 {* Метод получения экземпляра синглетона TEditionsServiceImpl }
begin
 if (g_TEditionsServiceImpl = nil) then
 begin
  l3System.AddExitProc(TEditionsServiceImplFree);
  g_TEditionsServiceImpl := Create;
 end;
 Result := g_TEditionsServiceImpl;
end;//TEditionsServiceImpl.Instance

class function TEditionsServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TEditionsServiceImpl <> nil;
end;//TEditionsServiceImpl.Exists

class procedure TBaseEditionsModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TLeftEditionForm);
 aList.Add(TRightEditionForm);
 aList.Add(TEditionsContainerForm);
end;//TBaseEditionsModule.GetEntityForms

initialization
 str_NoPrevEdition.Init;
 {* Инициализация str_NoPrevEdition }
 TEditionsService.Instance.Alien := TEditionsServiceImpl.Instance;
 {* Регистрация TEditionsServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
