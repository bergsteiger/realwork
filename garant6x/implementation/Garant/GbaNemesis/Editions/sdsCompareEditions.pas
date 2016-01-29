unit sdsCompareEditions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/sdsCompareEditions.pas"
// Начат: 30.07.2009 15:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::Editions::TsdsCompareEditions
//
// Реализация прецедента "Сравнение редакций документа"
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
  DocumentUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  EditionsInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  DocumentAndListInterfaces {a},
  nevTools,
  eeInterfaces,
  l3Tree_TLB,
  afwInterfaces,
  FoldersDomainInterfaces,
  DocumentInterfaces,
  l3TreeInterfaces,
  bsTypesNew
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  TnsDiffData = DocumentUnit.TDiffData;

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
 {$Include ..\Editions\VScroll.imp.pas}
 TsdsCompareEditions = {final ucc} class(_VScroll_, IsdsCompareEditions, InsVScrollController {from IsdsCompareEditions}, InsDocumentTextProviderFactory {from IsdsCompareEditions}, IsdsPrimDocument {from IsdsCompareEditions}, IsdsEditionsHolder {from IsdsCompareEditions})
  {* Реализация прецедента "Сравнение редакций документа" }
 private
 // private fields
   f_Left : IvcmViewAreaControllerRef;
    {* Поле для области вывода Left}
   f_Right : IvcmViewAreaControllerRef;
    {* Поле для области вывода Right}
   f_EditionsContainerData : IvcmViewAreaControllerRef;
    {* Поле для области вывода EditionsContainerData}
   f_EditionsList : IvcmViewAreaControllerRef;
    {* Поле для области вывода EditionsList}
 private
 // private methods
   procedure NotifyEditionChanged;
     {* Нотификация о смене редакции }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
   function pm_GetLeft: IdsLeftEdition;
   function DoGet_Left: IdsLeftEdition;
   function pm_GetRight: IdsRightEdition;
   function DoGet_Right: IdsRightEdition;
   function pm_GetEditionsContainerData: IdsEditionsContainerData;
   function DoGet_EditionsContainerData: IdsEditionsContainerData;
   function Get_ChangedParas: IDiffIterator;
   function Get_EditionForCompare: TRedactionID;
   procedure Set_EditionForCompare(aValue: TRedactionID);
   function pm_GetDocInfo: IdeDocInfo;
   function Get_Node(aIsLeft: Boolean): TDocumentRoot;
   function pm_GetEditionsList: IdsEditions;
   function DoGet_EditionsList: IdsEditions;
   function Get_Position: TbsDocPos;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
    {$IfEnd} //not NoVCM
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_InsVScrollController: InsVScrollController;
   function As_InsDocumentTextProviderFactory: InsDocumentTextProviderFactory;
   function As_IsdsPrimDocument: IsdsPrimDocument;
   function As_IsdsEditionsHolder: IsdsEditionsHolder;
 end;//TsdsCompareEditions
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsEditionsContainerData,
  dsRightEdition,
  dsLeftEdition,
  nsEditionDiffData,
  nsEditionsContainerData
  {$If not defined(NoVCM)}
  ,
  vcmFormSetRefreshParams
  {$IfEnd} //not NoVCM
  ,
  sdsCompareEditionsState,
  deDocInfo,
  dsEditions,
  nsTabbedInterfaceTypes
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  SysUtils,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsCompareEditions;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}

{$Include ..\Editions\VScroll.imp.pas}

// start class TsdsCompareEditions

procedure TsdsCompareEditions.NotifyEditionChanged;
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

{$If not defined(NoVCM)}
function TsdsCompareEditions.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_4A7181A301E3_var*
//#UC END# *47F3778403D9_4A7181A301E3_var*
begin
//#UC START# *47F3778403D9_4A7181A301E3_impl*
 Result := TsdsCompareEditionsState.Make(InitialUseCaseData, InitialUseCaseData.EditionForCompare);
//#UC END# *47F3778403D9_4A7181A301E3_impl*
end;//TsdsCompareEditions.MakeData
{$IfEnd} //not NoVCM

function TsdsCompareEditions.pm_GetLeft: IdsLeftEdition;
//#UC START# *4A6D579203BC_4A7181A301E3get_var*
//#UC END# *4A6D579203BC_4A7181A301E3get_var*
begin
 if (f_Left = nil) then
 begin
  f_Left := TvcmViewAreaControllerRef.Make;
  //#UC START# *4A6D579203BC_4A7181A301E3get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4A6D579203BC_4A7181A301E3get_init*
 end;//f_Left = nil
 if f_Left.IsEmpty
  //#UC START# *4A6D579203BC_4A7181A301E3get_need*
  // - условие создания ViewArea
  //#UC END# *4A6D579203BC_4A7181A301E3get_need*
  then
   f_Left.Referred := DoGet_Left;
 Result := IdsLeftEdition(f_Left.Referred);
end;

function TsdsCompareEditions.DoGet_Left: IdsLeftEdition;
//#UC START# *4A6D579203BC_4A7181A301E3area_var*
//#UC END# *4A6D579203BC_4A7181A301E3area_var*
begin
//#UC START# *4A6D579203BC_4A7181A301E3area_impl*
 SetData.CompareRootPair;
 Result := TdsLeftEdition.Make(Self,
                               TnsEditionDiffData.Make(InitialUseCaseData.Document,
                                                       InitialUseCaseData.RedactionCurrentPara,
                                                       InitialUseCaseData.DocumentForReturn));
//#UC END# *4A6D579203BC_4A7181A301E3area_impl*
end;//TsdsCompareEditions.DoGet_Left

function TsdsCompareEditions.pm_GetRight: IdsRightEdition;
//#UC START# *4A6D57C80079_4A7181A301E3get_var*
//#UC END# *4A6D57C80079_4A7181A301E3get_var*
begin
 if (f_Right = nil) then
 begin
  f_Right := TvcmViewAreaControllerRef.Make;
  //#UC START# *4A6D57C80079_4A7181A301E3get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4A6D57C80079_4A7181A301E3get_init*
 end;//f_Right = nil
 if f_Right.IsEmpty
  //#UC START# *4A6D57C80079_4A7181A301E3get_need*
  // - условие создания ViewArea
  //#UC END# *4A6D57C80079_4A7181A301E3get_need*
  then
   f_Right.Referred := DoGet_Right;
 Result := IdsRightEdition(f_Right.Referred);
end;

function TsdsCompareEditions.DoGet_Right: IdsRightEdition;
//#UC START# *4A6D57C80079_4A7181A301E3area_var*
//#UC END# *4A6D57C80079_4A7181A301E3area_var*
begin
//#UC START# *4A6D57C80079_4A7181A301E3area_impl*
 SetData.CompareRootPair;
 Result := TdsRightEdition.Make(Self,
                                TnsEditionDiffData.Make(InitialUseCaseData.Document,
                                                        InitialUseCaseData.RedactionCurrentPara,
                                                        InitialUseCaseData.DocumentForReturn));
//#UC END# *4A6D57C80079_4A7181A301E3area_impl*
end;//TsdsCompareEditions.DoGet_Right

function TsdsCompareEditions.pm_GetEditionsContainerData: IdsEditionsContainerData;
//#UC START# *4A6EC18E02E3_4A7181A301E3get_var*
//#UC END# *4A6EC18E02E3_4A7181A301E3get_var*
begin
 if (f_EditionsContainerData = nil) then
 begin
  f_EditionsContainerData := TvcmViewAreaControllerRef.Make;
  //#UC START# *4A6EC18E02E3_4A7181A301E3get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4A6EC18E02E3_4A7181A301E3get_init*
 end;//f_EditionsContainerData = nil
 if f_EditionsContainerData.IsEmpty
  //#UC START# *4A6EC18E02E3_4A7181A301E3get_need*
  // - условие создания ViewArea
  //#UC END# *4A6EC18E02E3_4A7181A301E3get_need*
  then
   f_EditionsContainerData.Referred := DoGet_EditionsContainerData;
 Result := IdsEditionsContainerData(f_EditionsContainerData.Referred);
end;

function TsdsCompareEditions.DoGet_EditionsContainerData: IdsEditionsContainerData;
//#UC START# *4A6EC18E02E3_4A7181A301E3area_var*
//#UC END# *4A6EC18E02E3_4A7181A301E3area_var*
begin
//#UC START# *4A6EC18E02E3_4A7181A301E3area_impl*
 SetData.CompareRootPair;
 Result :=
  TdsEditionsContainerData.Make(Self,
   TnsEditionsContainerData.Make(InitialUseCaseData.Document,
                                 InitialUseCaseData.DocumentForReturn));
//#UC END# *4A6EC18E02E3_4A7181A301E3area_impl*
end;//TsdsCompareEditions.DoGet_EditionsContainerData

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
 if (f_EditionsList = nil) then
 begin
  f_EditionsList := TvcmViewAreaControllerRef.Make;
  //#UC START# *4ED906420134_4A7181A301E3get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4ED906420134_4A7181A301E3get_init*
 end;//f_EditionsList = nil
 if f_EditionsList.IsEmpty
  //#UC START# *4ED906420134_4A7181A301E3get_need*
  // - условие создания ViewArea
  //#UC END# *4ED906420134_4A7181A301E3get_need*
  then
   f_EditionsList.Referred := DoGet_EditionsList;
 Result := IdsEditions(f_EditionsList.Referred);
end;

function TsdsCompareEditions.DoGet_EditionsList: IdsEditions;
//#UC START# *4ED906420134_4A7181A301E3area_var*
//#UC END# *4ED906420134_4A7181A301E3area_var*
begin
//#UC START# *4ED906420134_4A7181A301E3area_impl*
 Result := TdsEditions.Make(Self);
//#UC END# *4ED906420134_4A7181A301E3area_impl*
end;//TsdsCompareEditions.DoGet_EditionsList

function TsdsCompareEditions.Get_Position: TbsDocPos;
//#UC START# *5214A46601C7_4A7181A301E3get_var*
//#UC END# *5214A46601C7_4A7181A301E3get_var*
begin
//#UC START# *5214A46601C7_4A7181A301E3get_impl*
 Result := InitialUseCaseData.Position;
//#UC END# *5214A46601C7_4A7181A301E3get_impl*
end;//TsdsCompareEditions.Get_Position

{$If not defined(NoVCM)}
procedure TsdsCompareEditions.ClearAreas;
 {-}
begin
 if (f_Left <> nil) then f_Left.Referred := nil;
 if (f_Right <> nil) then f_Right.Referred := nil;
 if (f_EditionsContainerData <> nil) then f_EditionsContainerData.Referred := nil;
 if (f_EditionsList <> nil) then f_EditionsList.Referred := nil;
 inherited;
end;//TsdsCompareEditions.ClearAreas
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TsdsCompareEditions.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_4A7181A301E3_var*
//#UC END# *53B3BF9C00EF_4A7181A301E3_var*
begin
//#UC START# *53B3BF9C00EF_4A7181A301E3_impl*
 Result := nsTabIconIndex(titCompareEditions);
//#UC END# *53B3BF9C00EF_4A7181A301E3_impl*
end;//TsdsCompareEditions.DoGetFormSetImageIndex
{$IfEnd} //not NoVCM

// Методы преобразования к реализуемым интерфейсам

function TsdsCompareEditions.As_InsVScrollController: InsVScrollController;
begin
 Result := Self;
end;

function TsdsCompareEditions.As_InsDocumentTextProviderFactory: InsDocumentTextProviderFactory;
begin
 Result := Self;
end;

function TsdsCompareEditions.As_IsdsPrimDocument: IsdsPrimDocument;
begin
 Result := Self;
end;

function TsdsCompareEditions.As_IsdsEditionsHolder: IsdsEditionsHolder;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

end.