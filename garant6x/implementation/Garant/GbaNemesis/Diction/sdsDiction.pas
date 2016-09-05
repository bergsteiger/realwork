unit sdsDiction;
 {* Бизнес объект сборки "Толковый словарь" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\sdsDiction.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsDiction" MUID: (4936CB1B0022)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DictionInterfaces
 , DictionInterfacesPrim
 , DocumentUnit
 , bsTypes
 , DocumentAndListInterfaces
 , CommonDictionInterfaces
 , DocumentInterfaces
 , l3IID
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicTreeUnit
 , QueryCardInterfaces
 , BaseDocumentWithAttributesInterfaces
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
 _SetDataType_ = IdDiction;
 _SetType_ = IsdsDiction;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\sdsCommonDiction.imp.pas}
 TsdsDiction = class(_sdsCommonDiction_, IsdsDiction)
  {* Бизнес объект сборки "Толковый словарь" }
  private
   procedure LoadLanguages(const aDocument: IDocument);
    {* загружает доступные для документа языки }
   procedure ClearTranslators;
   function NewDSDocument(aLanguage: TbsLanguage): IdsDictionDocument;
    {* создать бизнес объект для документа }
  protected
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
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
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
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
   {$If NOT Defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetDataForClone: _InitDataType_; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsDiction
 , dsDictionDocument
 , deDocInfo
 , SysUtils
 , dDiction
 , l3Base
 , nsUtils
 , bsConst
 , DataAdapter
 , BaseTypesUnit
 , deDiction
 , dsSaveLoad
 , dsChild
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM)}
 , vcmFormSetRefreshParams
 {$IfEnd} // NOT Defined(NoVCM)
 , afwFacade
 , dCommonDiction
 , dsAttributes
 , l3Types
 , bsUtils
 , l3Utils
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4936CB1B0022impl_uses*
 //#UC END# *4936CB1B0022impl_uses*
;

type _Instance_R_ = TsdsDiction;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\sdsCommonDiction.imp.pas}

procedure TsdsDiction.LoadLanguages(const aDocument: IDocument);
 {* загружает доступные для документа языки }
//#UC START# *4936CD5100A6_4936CB1B0022_var*
var
 l_List      : ILanguagesList;
 l_Index     : Integer;
 l_Languages : TbsLanguages;
 l_deDiction: IdeDiction;
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
 if Supports(InitialUseCaseData, IdeDiction, l_deDiction) then
 try
  SetData.CurrentLanguage := l_deDiction.DictLanguage;
 finally
  l_deDiction := nil;
 end;
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
 {* создать бизнес объект для документа }
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

{$If NOT Defined(NoVCM)}
function TsdsDiction.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_4936CB1B0022_var*
//#UC END# *47F3778403D9_4936CB1B0022_var*
begin
//#UC START# *47F3778403D9_4936CB1B0022_impl*
 Result := TdDiction.Make;
//#UC END# *47F3778403D9_4936CB1B0022_impl*
end;//TsdsDiction.MakeData
{$IfEnd} // NOT Defined(NoVCM)

function TsdsDiction.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_4936CB1B0022_var*
//#UC END# *4925B1EC0100_4936CB1B0022_var*
begin
//#UC START# *4925B1EC0100_4936CB1B0022_impl*
 Result := TdsDictionDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_4936CB1B0022_impl*
end;//TsdsDiction.BaseDocumentClass

procedure TsdsDiction.OpenLiteratureList;
 {* открыть список литературы для толкового словаря }
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
 {* Создаёт область оглавления }
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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4936CB1B0022_var*
//#UC END# *479731C50290_4936CB1B0022_var*
begin
//#UC START# *479731C50290_4936CB1B0022_impl*
 inherited;
//#UC END# *479731C50290_4936CB1B0022_impl*
end;//TsdsDiction.Cleanup

{$If NOT Defined(NoVCM)}
procedure TsdsDiction.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_4936CB1B0022_var*
//#UC END# *47F37DF001FE_4936CB1B0022_var*
begin
//#UC START# *47F37DF001FE_4936CB1B0022_impl*
 inherited;
 LoadLanguages(SetData.DocInfo.Doc);
//#UC END# *47F37DF001FE_4936CB1B0022_impl*
end;//TsdsDiction.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

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
 {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
           новой сборки вернуться как результат для вызова операции модуля }
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
 {* Реализация запроса интерфейса }
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

{$If NOT Defined(NoVCM)}
function TsdsDiction.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_4936CB1B0022_var*
//#UC END# *53B3BF9C00EF_4936CB1B0022_var*
begin
//#UC START# *53B3BF9C00EF_4936CB1B0022_impl*
 Result := nsTabIconIndex(titDictionary);
//#UC END# *53B3BF9C00EF_4936CB1B0022_impl*
end;//TsdsDiction.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TsdsDiction.GetDataForClone: _InitDataType_;
//#UC START# *55C1DD070354_4936CB1B0022_var*
var
 l_Diction: IdeDiction;
//#UC END# *55C1DD070354_4936CB1B0022_var*
begin
//#UC START# *55C1DD070354_4936CB1B0022_impl*
 Result := MakeDocInfo(pm_GetDocInfo).Clone;
 if Supports(Result, IdeDiction, l_Diction) then
 try
  l_Diction.DictLanguage := pm_GetDsDiction.Language;
 finally
  l_Diction := nil;
 end;
// Result.DictLanguage := pm_GetDsDiction.Language; 
//#UC END# *55C1DD070354_4936CB1B0022_impl*
end;//TsdsDiction.GetDataForClone
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
