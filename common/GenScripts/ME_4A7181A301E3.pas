unit sdsCompareEditions;
 {* Реализация прецедента "Сравнение редакций документа" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\sdsCompareEditions.pas"
// Стереотип: "UseCaseControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , EditionsInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , DocumentInterfaces
 , bsTypesNew
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 TnsDiffData = TDiffData;

 IsdsCompareEditionsState = interface(IvcmData)
  {* Состояние прецедента TsdsCompareEditions }
  ['{58401E22-1A19-4B3D-90EE-616BC5328B1A}']
  function Get_EditionForCompare: TRedactionID;
  function Get_UseCaseData: InsCompareEditionsInfo;
  function Get_CompareRootPair: TnsDiffData;
  property EditionForCompare: TRedactionID
   read Get_EditionForCompare;
  property UseCaseData: InsCompareEditionsInfo
   read Get_UseCaseData;
  property CompareRootPair: TnsDiffData
   read Get_CompareRootPair;
 end;//IsdsCompareEditionsState

 _InitDataType_ = InsCompareEditionsInfo;
 _SetDataType_ = IsdsCompareEditionsState;
 _SetType_ = IsdsCompareEditions;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}
 _VScroll_Parent_ = _vcmFormSetDataSource_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\VScroll.imp.pas}
 TsdsCompareEditions = {final} class(_VScroll_, IsdsCompareEditions, InsVScrollController, InsDocumentTextProviderFactory, IsdsPrimDocument, IsdsEditionsHolder)
  {* Реализация прецедента "Сравнение редакций документа" }
  private
   f_Left: IvcmViewAreaControllerRef;
    {* Поле для области вывода Left }
   f_Right: IvcmViewAreaControllerRef;
    {* Поле для области вывода Right }
   f_EditionsContainerData: IvcmViewAreaControllerRef;
    {* Поле для области вывода EditionsContainerData }
   f_EditionsList: IvcmViewAreaControllerRef;
    {* Поле для области вывода EditionsList }
  private
   procedure NotifyEditionChanged;
    {* Нотификация о смене редакции }
  protected
   function As_InsVScrollController: InsVScrollController;
    {* Метод приведения нашего интерфейса к InsVScrollController }
   function As_InsDocumentTextProviderFactory: InsDocumentTextProviderFactory;
    {* Метод приведения нашего интерфейса к InsDocumentTextProviderFactory }
   function As_IsdsPrimDocument: IsdsPrimDocument;
    {* Метод приведения нашего интерфейса к IsdsPrimDocument }
   function As_IsdsEditionsHolder: IsdsEditionsHolder;
    {* Метод приведения нашего интерфейса к IsdsEditionsHolder }
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
   function pm_GetLeft: IdsLeftEdition;
   function pm_GetRight: IdsRightEdition;
   function pm_GetEditionsContainerData: IdsEditionsContainerData;
   function Get_ChangedParas: IDiffIterator;
   function Get_EditionForCompare: TRedactionID;
   procedure Set_EditionForCompare(aValue: TRedactionID);
   function pm_GetDocInfo: IdeDocInfo;
   function Get_Node(aIsLeft: Boolean): TDocumentRoot;
   function pm_GetEditionsList: IdsEditions;
   function Get_Position: TbsDocPos;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsCompareEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsEditionsContainerData
 , dsRightEdition
 , dsLeftEdition
 , nsEditionDiffData
 , nsEditionsContainerData
 {$If NOT Defined(NoVCM)}
 , vcmFormSetRefreshParams
 {$IfEnd} // NOT Defined(NoVCM)
 , sdsCompareEditionsState
 , deDocInfo
 , dsEditions
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
;

type _Instance_R_ = TsdsCompareEditions;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\VScroll.imp.pas}

procedure TsdsCompareEditions.NotifyEditionChanged;
 {* Нотификация о смене редакции }
//#UC START# *4A841D40037E_4A7181A301E3_var*
var
 l_Index : Integer;
 l_Intf  : InsEditionListener;
 l_Item  : IUnknown;
//#UC END# *4A841D40037E_4A7181A301E3_var*
begin
//#UC START# *4A841D40037E_4A7181A301E3_impl*
 if (NotifiedObjList <> nil) then
  for l_Index := NotifiedObjList.Hi downto 0 do
   try
    l_Item := f_NotifiedObjList[l_Index];
    if Supports(l_Item, InsEditionListener, l_Intf) AND
       (l_Item = l_Intf) then
     try
      l_Intf.EditionChanged;
     finally
      l_Intf := nil;
     end;//try..finaly
   except
    on E: Exception do
     l3System.Exception2Log(E);
   end;//try..except
//#UC END# *4A841D40037E_4A7181A301E3_impl*
end;//TsdsCompareEditions.NotifyEditionChanged

function TsdsCompareEditions.As_InsVScrollController: InsVScrollController;
 {* Метод приведения нашего интерфейса к InsVScrollController }
begin
 Result := Self;
end;//TsdsCompareEditions.As_InsVScrollController

function TsdsCompareEditions.As_InsDocumentTextProviderFactory: InsDocumentTextProviderFactory;
 {* Метод приведения нашего интерфейса к InsDocumentTextProviderFactory }
begin
 Result := Self;
end;//TsdsCompareEditions.As_InsDocumentTextProviderFactory

function TsdsCompareEditions.As_IsdsPrimDocument: IsdsPrimDocument;
 {* Метод приведения нашего интерфейса к IsdsPrimDocument }
begin
 Result := Self;
end;//TsdsCompareEditions.As_IsdsPrimDocument

function TsdsCompareEditions.As_IsdsEditionsHolder: IsdsEditionsHolder;
 {* Метод приведения нашего интерфейса к IsdsEditionsHolder }
begin
 Result := Self;
end;//TsdsCompareEditions.As_IsdsEditionsHolder

{$If NOT Defined(NoVCM)}
function TsdsCompareEditions.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_4A7181A301E3_var*
//#UC END# *47F3778403D9_4A7181A301E3_var*
begin
//#UC START# *47F3778403D9_4A7181A301E3_impl*
 Result := TsdsCompareEditionsState.Make(InitialUseCaseData, InitialUseCaseData.EditionForCompare);
//#UC END# *47F3778403D9_4A7181A301E3_impl*
end;//TsdsCompareEditions.MakeData
{$IfEnd} // NOT Defined(NoVCM)

function TsdsCompareEditions.pm_GetLeft: IdsLeftEdition;
//#UC START# *4A6D579203BC_4A7181A301E3get_var*
//#UC END# *4A6D579203BC_4A7181A301E3get_var*
begin
//#UC START# *4A6D579203BC_4A7181A301E3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A6D579203BC_4A7181A301E3get_impl*
end;//TsdsCompareEditions.pm_GetLeft

function TsdsCompareEditions.pm_GetRight: IdsRightEdition;
//#UC START# *4A6D57C80079_4A7181A301E3get_var*
//#UC END# *4A6D57C80079_4A7181A301E3get_var*
begin
//#UC START# *4A6D57C80079_4A7181A301E3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A6D57C80079_4A7181A301E3get_impl*
end;//TsdsCompareEditions.pm_GetRight

function TsdsCompareEditions.pm_GetEditionsContainerData: IdsEditionsContainerData;
//#UC START# *4A6EC18E02E3_4A7181A301E3get_var*
//#UC END# *4A6EC18E02E3_4A7181A301E3get_var*
begin
//#UC START# *4A6EC18E02E3_4A7181A301E3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A6EC18E02E3_4A7181A301E3get_impl*
end;//TsdsCompareEditions.pm_GetEditionsContainerData

function TsdsCompareEditions.Get_ChangedParas: IDiffIterator;
//#UC START# *4B4F2EAD0183_4A7181A301E3get_var*
//#UC END# *4B4F2EAD0183_4A7181A301E3get_var*
begin
//#UC START# *4B4F2EAD0183_4A7181A301E3get_impl*
 Result := SetData.CompareRootPair.rDiffIterator;
//#UC END# *4B4F2EAD0183_4A7181A301E3get_impl*
end;//TsdsCompareEditions.Get_ChangedParas

function TsdsCompareEditions.Get_EditionForCompare: TRedactionID;
//#UC START# *4B6BD5E001F4_4A7181A301E3get_var*
//#UC END# *4B6BD5E001F4_4A7181A301E3get_var*
begin
//#UC START# *4B6BD5E001F4_4A7181A301E3get_impl*
 Result := SetData.EditionForCompare;
//#UC END# *4B6BD5E001F4_4A7181A301E3get_impl*
end;//TsdsCompareEditions.Get_EditionForCompare

procedure TsdsCompareEditions.Set_EditionForCompare(aValue: TRedactionID);
//#UC START# *4B6BD5E001F4_4A7181A301E3set_var*
var
 l_Data : IvcmData;
//#UC END# *4B6BD5E001F4_4A7181A301E3set_var*
begin
//#UC START# *4B6BD5E001F4_4A7181A301E3set_impl*
 if (SetData.EditionForCompare <> aValue) then
 begin
  l_Data := Self.SetData.Clone;
  ClearAreas;
  f_SetData := TsdsCompareEditionsState.Make(InitialUseCaseData, aValue);
  NotifyEditionChanged;
  Refresh(vcmMakeDataRefreshParams(sfsOnlyIfDataSourceChanged, l_Data));
 end;//aValue <> SetData.EditionForCompare
//#UC END# *4B6BD5E001F4_4A7181A301E3set_impl*
end;//TsdsCompareEditions.Set_EditionForCompare

function TsdsCompareEditions.pm_GetDocInfo: IdeDocInfo;
//#UC START# *4DF9D63B0360_4A7181A301E3get_var*
//#UC END# *4DF9D63B0360_4A7181A301E3get_var*
begin
//#UC START# *4DF9D63B0360_4A7181A301E3get_impl*
 Result := TdeDocInfo.Make(InitialUseCaseData.Document);
//#UC END# *4DF9D63B0360_4A7181A301E3get_impl*
end;//TsdsCompareEditions.pm_GetDocInfo

function TsdsCompareEditions.Get_Node(aIsLeft: Boolean): TDocumentRoot;
//#UC START# *4EA7F1C400B0_4A7181A301E3get_var*
//#UC END# *4EA7F1C400B0_4A7181A301E3get_var*
begin
//#UC START# *4EA7F1C400B0_4A7181A301E3get_impl*
 if aIsLeft then
  Result := SetData.CompareRootPair.rPrev
 else
  Result := SetData.CompareRootPair.rCur;
//#UC END# *4EA7F1C400B0_4A7181A301E3get_impl*
end;//TsdsCompareEditions.Get_Node

function TsdsCompareEditions.pm_GetEditionsList: IdsEditions;
//#UC START# *4ED906420134_4A7181A301E3get_var*
//#UC END# *4ED906420134_4A7181A301E3get_var*
begin
//#UC START# *4ED906420134_4A7181A301E3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ED906420134_4A7181A301E3get_impl*
end;//TsdsCompareEditions.pm_GetEditionsList

function TsdsCompareEditions.Get_Position: TbsDocPos;
//#UC START# *5214A46601C7_4A7181A301E3get_var*
//#UC END# *5214A46601C7_4A7181A301E3get_var*
begin
//#UC START# *5214A46601C7_4A7181A301E3get_impl*
 Result := InitialUseCaseData.Position;
//#UC END# *5214A46601C7_4A7181A301E3get_impl*
end;//TsdsCompareEditions.Get_Position

{$If NOT Defined(NoVCM)}
procedure TsdsCompareEditions.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_4A7181A301E3_var*
//#UC END# *4938F7E702B7_4A7181A301E3_var*
begin
//#UC START# *4938F7E702B7_4A7181A301E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_4A7181A301E3_impl*
end;//TsdsCompareEditions.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TsdsCompareEditions.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_4A7181A301E3_var*
//#UC END# *53B3BF9C00EF_4A7181A301E3_var*
begin
//#UC START# *53B3BF9C00EF_4A7181A301E3_impl*
 Result := nsTabIconIndex(titCompareEditions);
//#UC END# *53B3BF9C00EF_4A7181A301E3_impl*
end;//TsdsCompareEditions.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
