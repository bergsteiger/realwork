unit sdsDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/sdsDiction.pas"
// Начат: 2005/10/06 12:32:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Встроенные продукты::Diction::Diction::Diction::TsdsDiction
//
// Бизнес объект сборки "Толковый словарь"
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
  bsTypes,
  DictionInterfaces,
  DictionInterfacesPrim,
  CommonDictionInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  DocumentInterfaces,
  BaseDocumentWithAttributesInterfaces,
  DocumentAndListInterfaces,
  bsTypesNew
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  l3IID,
  nevTools,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  DynamicTreeUnit,
  QueryCardInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetDataType_ = IdDiction;
 _SetType_ = IsdsDiction;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\sdsCommonDiction.imp.pas}
 TsdsDiction = {ucc} class(_sdsCommonDiction_, IsdsDiction)
  {* Бизнес объект сборки "Толковый словарь" }
 private
 // private methods
   procedure LoadLanguages(const aDocument: IDocument);
     {* загружает доступные для документа языки }
   procedure ClearTranslators;
   function NewDSDocument(aLanguage: TbsLanguage): IdsDictionDocument;
     {* создать бизнес объект для документа }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
   function BaseDocumentClass: IdsBaseDocument; override;
   procedure OpenLiteratureList;
     {* открыть список литературы для толкового словаря }
   function IsShowLiteratureList: Boolean;
   function pm_GetTranslationForms: Integer;
   function pm_GetDefaultLanguage: TbsLanguage;
   function MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction; override;
   function MakeContents: IdsCommonDiction; override;
     {* Создаёт область оглавления }
   function pm_GetDsTranslate(aLanguageId: Integer): IdsDictionDocument;
   function pm_GetContextMap: InsLangToContextMap;
   function pm_GetDsDiction: IdsDiction;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure DataExchange; override;
     {* - вызывается после получения данных инициализации. }
   {$IfEnd} //not NoVCM
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   function DoMakeGotoPointData(const aDocument: IDocument;
    aRefType: TDocumentPositionType;
    aPos: Longword): IdeDocInfo; override;
     {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
           новой сборки вернуться как результат для вызова операции модуля }
   procedure BeforeAssignDocument(const aDoc: IdeDocInfo); override;
   procedure AfterAssignDocument; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
    {$If not defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
    {$IfEnd} //not NoVCM
 end;//TsdsDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsDiction,
  dsDictionDocument,
  deDocInfo,
  SysUtils,
  dDiction,
  l3Base,
  nsUtils,
  bsConst,
  DataAdapter,
  BaseTypesUnit,
  deDiction,
  dsSaveLoad,
  dsChild,
  nsTabbedInterfaceTypes
  {$If not defined(NoVCM)}
  ,
  vcmFormSetRefreshParams
  {$IfEnd} //not NoVCM
  ,
  afwFacade,
  dCommonDiction,
  dsAttributes,
  l3Types,
  bsUtils,
  l3Utils,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsDiction;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\sdsCommonDiction.imp.pas}

// start class TsdsDiction

procedure TsdsDiction.LoadLanguages(const aDocument: IDocument);
//#UC START# *4936CD5100A6_4936CB1B0022_var*
var
 l_List      : ILanguagesList;
 l_Index     : Integer;
 l_Languages : TbsLanguages;
//#UC END# *4936CD5100A6_4936CB1B0022_var*
begin
//#UC START# *4936CD5100A6_4936CB1B0022_impl*
 l_Languages := [];
 if Assigned(aDocument) then
 begin
  aDocument.GetTextLanguages(l_List);
  try
   Assert(l_List <> nil);
   if (l_List = nil) then
    Include(l_Languages, LG_RUSSIAN)
   else
    for l_Index := 0 to Pred(l_List.Count) do
     Include(l_Languages, l_List[l_Index]);
  finally
   l_List := nil;
  end;{try..finally}
 end;//if Assigned(aDocument) then
 SetData.Languages := l_Languages;
//#UC END# *4936CD5100A6_4936CB1B0022_impl*
end;//TsdsDiction.LoadLanguages

procedure TsdsDiction.ClearTranslators;
//#UC START# *4936CD8700C8_4936CB1B0022_var*
var
 l_Index: Integer;
//#UC END# *4936CD8700C8_4936CB1B0022_var*
begin
//#UC START# *4936CD8700C8_4936CB1B0022_impl*
 for l_Index := 0 to Pred(pm_GetTranslationForms) do
  SetData.refTranslation[l_Index].Clear;
//#UC END# *4936CD8700C8_4936CB1B0022_impl*
end;//TsdsDiction.ClearTranslators

function TsdsDiction.NewDSDocument(aLanguage: TbsLanguage): IdsDictionDocument;
//#UC START# *4936CDB00318_4936CB1B0022_var*
var
 l_DocInfo: IdeDocInfo;
//#UC END# *4936CDB00318_4936CB1B0022_var*
begin
//#UC START# *4936CDB00318_4936CB1B0022_impl*
 l_DocInfo := pm_GetDocInfo.Clone;
 l_DocInfo.CorrectLanguage(aLanguage);
 Result := TdsDictionDocument.Make(Self, l_DocInfo) as IdsDictionDocument;
//#UC END# *4936CDB00318_4936CB1B0022_impl*
end;//TsdsDiction.NewDSDocument

{$If not defined(NoVCM)}
function TsdsDiction.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_4936CB1B0022_var*
//#UC END# *47F3778403D9_4936CB1B0022_var*
begin
//#UC START# *47F3778403D9_4936CB1B0022_impl*
 Result := TdDiction.Make;
//#UC END# *47F3778403D9_4936CB1B0022_impl*
end;//TsdsDiction.MakeData
{$IfEnd} //not NoVCM

function TsdsDiction.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_4936CB1B0022_var*
//#UC END# *4925B1EC0100_4936CB1B0022_var*
begin
//#UC START# *4925B1EC0100_4936CB1B0022_impl*
 Result := TdsDictionDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_4936CB1B0022_impl*
end;//TsdsDiction.BaseDocumentClass

procedure TsdsDiction.OpenLiteratureList;
//#UC START# *49368311029E_4936CB1B0022_var*
var
 l_Document: IDocument;
//#UC END# *49368311029E_4936CB1B0022_var*
begin
//#UC START# *49368311029E_4936CB1B0022_impl*
 if nsOpenDocumentByNumber(c_LiteratureListForDictionary, l_Document) then
 try
  ChangeDocument(TdeDocInfo.Make(l_Document));
  SetData.IsShowLiteratureList := True;
 finally
  l_Document := nil;
 end;{try..finally}
//#UC END# *49368311029E_4936CB1B0022_impl*
end;//TsdsDiction.OpenLiteratureList

function TsdsDiction.IsShowLiteratureList: Boolean;
//#UC START# *49368336033D_4936CB1B0022_var*
//#UC END# *49368336033D_4936CB1B0022_var*
begin
//#UC START# *49368336033D_4936CB1B0022_impl*
 Result := SetData.IsShowLiteratureList;
//#UC END# *49368336033D_4936CB1B0022_impl*
end;//TsdsDiction.IsShowLiteratureList

function TsdsDiction.pm_GetTranslationForms: Integer;
//#UC START# *4936835F01D2_4936CB1B0022get_var*
//#UC END# *4936835F01D2_4936CB1B0022get_var*
begin
//#UC START# *4936835F01D2_4936CB1B0022get_impl*
 Result := SetData.refTranslationCount;
//#UC END# *4936835F01D2_4936CB1B0022get_impl*
end;//TsdsDiction.pm_GetTranslationForms

function TsdsDiction.pm_GetDefaultLanguage: TbsLanguage;
//#UC START# *4936837F0304_4936CB1B0022get_var*
//#UC END# *4936837F0304_4936CB1B0022get_var*
begin
//#UC START# *4936837F0304_4936CB1B0022get_impl*
 Result := DefDataAdapter.DocDefaultLang;
//#UC END# *4936837F0304_4936CB1B0022get_impl*
end;//TsdsDiction.pm_GetDefaultLanguage

function TsdsDiction.MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction;
//#UC START# *4936B89C037F_4936CB1B0022_var*
//#UC END# *4936B89C037F_4936CB1B0022_var*
begin
//#UC START# *4936B89C037F_4936CB1B0022_impl*
 if not Supports(aSource, IdeDiction, Result) then
  Result := TdeDiction.Convert(aSource, pm_GetDefaultLanguage);
//#UC END# *4936B89C037F_4936CB1B0022_impl*
end;//TsdsDiction.MakeDocInfo

function TsdsDiction.MakeContents: IdsCommonDiction;
//#UC START# *4936BA0D0286_4936CB1B0022_var*
//#UC END# *4936BA0D0286_4936CB1B0022_var*
begin
//#UC START# *4936BA0D0286_4936CB1B0022_impl*
 Result := TdsDiction.Make(Self, MakeDocInfo(pm_GetDocInfo).Clone As IdeDiction);
//#UC END# *4936BA0D0286_4936CB1B0022_impl*
end;//TsdsDiction.MakeContents

function TsdsDiction.pm_GetDsTranslate(aLanguageId: Integer): IdsDictionDocument;
//#UC START# *4936C62102DD_4936CB1B0022get_var*
var
 l_Lang: TbsLanguage;
//#UC END# *4936C62102DD_4936CB1B0022get_var*
begin
//#UC START# *4936C62102DD_4936CB1B0022get_impl*
 Result := nil;
 // Перечислымый тип языка
 l_Lang := TbsLanguage(aLanguageId);
 // Перевод для языка присутствует
 if (l_Lang <> DefDataAdapter.DocDefaultLang) and (l_Lang in SetData.Languages) then
 begin
  // Нужно создать
  with SetData.refTranslation[aLanguageId] do
  begin
   if IsEmpty then
    Referred := NewDSDocument(l_Lang);
   // Вернем Referred
   Result := Referred As IdsDictionDocument;
  end;//with SetData.refTranslation[aLanguageId] do
 end;//if (l_Lang <> DefDataAdapter.DocDefaultLang)
//#UC END# *4936C62102DD_4936CB1B0022get_impl*
end;//TsdsDiction.pm_GetDsTranslate

function TsdsDiction.pm_GetContextMap: InsLangToContextMap;
//#UC START# *52D3C29C008E_4936CB1B0022get_var*
var
 l_dsDiction: IdsDiction;
//#UC END# *52D3C29C008E_4936CB1B0022get_var*
begin
//#UC START# *52D3C29C008E_4936CB1B0022get_impl*
 Result := nil;
 l_dsDiction := pm_GetdsDiction;
 if (l_dsDiction <> nil) then
  Result := l_dsDiction.ContextMap;
//#UC END# *52D3C29C008E_4936CB1B0022get_impl*
end;//TsdsDiction.pm_GetContextMap

function TsdsDiction.pm_GetDsDiction: IdsDiction;
//#UC START# *52D8D3B9012D_4936CB1B0022get_var*
var
 l_ds: IdsDiction;
//#UC END# *52D8D3B9012D_4936CB1B0022get_var*
begin
//#UC START# *52D8D3B9012D_4936CB1B0022get_impl*
 Result := nil;
 if Supports(pm_GetdsContents, IdsDiction, l_ds) then
 try
  Result := l_ds;
 finally
  l_ds := nil;
 end;
//#UC END# *52D8D3B9012D_4936CB1B0022get_impl*
end;//TsdsDiction.pm_GetDsDiction

procedure TsdsDiction.Cleanup;
//#UC START# *479731C50290_4936CB1B0022_var*
//#UC END# *479731C50290_4936CB1B0022_var*
begin
//#UC START# *479731C50290_4936CB1B0022_impl*
 inherited;
//#UC END# *479731C50290_4936CB1B0022_impl*
end;//TsdsDiction.Cleanup

{$If not defined(NoVCM)}
procedure TsdsDiction.DataExchange;
//#UC START# *47F37DF001FE_4936CB1B0022_var*
//#UC END# *47F37DF001FE_4936CB1B0022_var*
begin
//#UC START# *47F37DF001FE_4936CB1B0022_impl*
 inherited;
 LoadLanguages(SetData.DocInfo.Doc);
//#UC END# *47F37DF001FE_4936CB1B0022_impl*
end;//TsdsDiction.DataExchange
{$IfEnd} //not NoVCM

function TsdsDiction.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
//#UC START# *4925B9370022_4936CB1B0022_var*
var
 l_deDiction: IdeDiction;
//#UC END# *4925B9370022_4936CB1B0022_var*
begin
//#UC START# *4925B9370022_4936CB1B0022_impl*
 Result := inherited DoChangeDocument(aDoc);
 if Supports(aDoc, IdeDiction, l_deDiction) then
  pm_GetdsDiction.ContextMap := l_deDiction.ContextMap;
 SetData.IsShowLiteratureList := False;
//#UC END# *4925B9370022_4936CB1B0022_impl*
end;//TsdsDiction.DoChangeDocument

function TsdsDiction.DoMakeGotoPointData(const aDocument: IDocument;
  aRefType: TDocumentPositionType;
  aPos: Longword): IdeDocInfo;
//#UC START# *4925BE3E0260_4936CB1B0022_var*
var
 lDS: IdsDiction;
 lDE: IdeDiction;
//#UC END# *4925BE3E0260_4936CB1B0022_var*
begin
//#UC START# *4925BE3E0260_4936CB1B0022_impl*
 Result := inherited DoMakeGotoPointData(aDocument, aRefType, aPos);
 if (aDocument.GetDocType = DT_EXPLANATORY) and Assigned(Result) then
 try
  lDS := pm_GetdsDiction;
  if (lDS <> nil) then
  begin
   Result := MakeDocInfo(Result);
   lDE := Result as IdeDiction;
   lDE.DictLanguage := lDS.Language;
   lDE.ContextMap := lDS.ContextMap;
  end;
 finally
  lDS := nil;
  lDE := nil;
 end{try..finally}
//#UC END# *4925BE3E0260_4936CB1B0022_impl*
end;//TsdsDiction.DoMakeGotoPointData

procedure TsdsDiction.BeforeAssignDocument(const aDoc: IdeDocInfo);
//#UC START# *4936B8B600F2_4936CB1B0022_var*
//#UC END# *4936B8B600F2_4936CB1B0022_var*
begin
//#UC START# *4936B8B600F2_4936CB1B0022_impl*
 inherited;
 LoadLanguages(aDoc.Doc);
//#UC END# *4936B8B600F2_4936CB1B0022_impl*
end;//TsdsDiction.BeforeAssignDocument

procedure TsdsDiction.AfterAssignDocument;
//#UC START# *4936B8C20119_4936CB1B0022_var*
//#UC END# *4936B8C20119_4936CB1B0022_var*
begin
//#UC START# *4936B8C20119_4936CB1B0022_impl*
 inherited;
 ClearTranslators;
//#UC END# *4936B8C20119_4936CB1B0022_impl*
end;//TsdsDiction.AfterAssignDocument

function TsdsDiction.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_4936CB1B0022_var*
//#UC END# *4A60B23E00C3_4936CB1B0022_var*
begin
//#UC START# *4A60B23E00C3_4936CB1B0022_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IdDiction) then
  begin
   IdDiction(Obj) := SetData;
   Result.SetOK;
  end;//if IID.EQ(IdDiction) then
//#UC END# *4A60B23E00C3_4936CB1B0022_impl*
end;//TsdsDiction.COMQueryInterface

{$If not defined(NoVCM)}
function TsdsDiction.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_4936CB1B0022_var*
//#UC END# *53B3BF9C00EF_4936CB1B0022_var*
begin
//#UC START# *53B3BF9C00EF_4936CB1B0022_impl*
 Result := nsTabIconIndex(titDictionary);
//#UC END# *53B3BF9C00EF_4936CB1B0022_impl*
end;//TsdsDiction.DoGetFormSetImageIndex
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.