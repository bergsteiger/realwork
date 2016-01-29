{$IfNDef sdsCommonDiction_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "CommonDiction"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/CommonDiction/sdsCommonDiction.imp.pas"
// Начат: 2008/03/05 09:35:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Core::Common::CommonDiction::CommonDiction::sdsCommonDiction
//
// Бизнес объект сборки "Обобщенный словарь"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define sdsCommonDiction_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _InitDataType_ = IdeDocInfo;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
 _sdsCommonDiction_ = {abstract ucc} class(_sdsBaseDocumentWithAttributes_, IsdsCommonDiction)
  {* Бизнес объект сборки "Обобщенный словарь" }
 private
 // private fields
   f_dsSaveLoad : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsSaveLoad}
   f_dsChild : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsChild}
 protected
 // realized methods
   function Get_CurrentNode: INodeBase;
   procedure Set_CurrentNode(const aValue: INodeBase);
   function Get_DeCommonDiction: IdeCommonDiction;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function DoGet_dsSaveLoad: IdsSaveLoad;
   function pm_GetDsChild: IdsChild;
   function DoGet_dsChild: IdsChild;
   function pm_GetDsContents: IdsCommonDiction;
   function DoGet_dsContents: IdsCommonDiction;
   function pm_GetdsContentsRef: IvcmViewAreaControllerRef;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DataExchange; override;
     {* - вызывается после получения данных инициализации. }
   {$IfEnd} //not NoVCM
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   function GetHasAttributes: Boolean; override;
     {* Реализация HasAttributes }
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
    {$If not defined(NoVCM)}
   function GetDataForClone: _InitDataType_; override;
    {$IfEnd} //not NoVCM
 protected
 // protected methods
   function MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction; virtual; abstract;
   procedure BeforeAssignDocument(const aDoc: IdeDocInfo); virtual;
   procedure AfterAssignDocument; virtual;
   function MakeContents: IdsCommonDiction; virtual; abstract;
     {* Создаёт область оглавления }
 end;//_sdsCommonDiction_
{$Else}

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
 _sdsCommonDiction_ = _sdsBaseDocumentWithAttributes_;

{$IfEnd} //not Admin AND not Monitorings

{$Else sdsCommonDiction_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}

// start class _sdsCommonDiction_

procedure _sdsCommonDiction_.BeforeAssignDocument(const aDoc: IdeDocInfo);
//#UC START# *4936B8B600F2_4936B666032A_var*
//#UC END# *4936B8B600F2_4936B666032A_var*
begin
//#UC START# *4936B8B600F2_4936B666032A_impl*
 // DoNothing;
//#UC END# *4936B8B600F2_4936B666032A_impl*
end;//_sdsCommonDiction_.BeforeAssignDocument

procedure _sdsCommonDiction_.AfterAssignDocument;
//#UC START# *4936B8C20119_4936B666032A_var*
//#UC END# *4936B8C20119_4936B666032A_var*
begin
//#UC START# *4936B8C20119_4936B666032A_impl*
 // DoNothing;
//#UC END# *4936B8C20119_4936B666032A_impl*
end;//_sdsCommonDiction_.AfterAssignDocument

function _sdsCommonDiction_.Get_CurrentNode: INodeBase;
//#UC START# *4B0EB10C02A3_4936B666032Aget_var*
//#UC END# *4B0EB10C02A3_4936B666032Aget_var*
begin
//#UC START# *4B0EB10C02A3_4936B666032Aget_impl*
 Result := SetData.CurrentNode;
//#UC END# *4B0EB10C02A3_4936B666032Aget_impl*
end;//_sdsCommonDiction_.Get_CurrentNode

procedure _sdsCommonDiction_.Set_CurrentNode(const aValue: INodeBase);
//#UC START# *4B0EB10C02A3_4936B666032Aset_var*
//#UC END# *4B0EB10C02A3_4936B666032Aset_var*
begin
//#UC START# *4B0EB10C02A3_4936B666032Aset_impl*
 SetData.CurrentNode := aValue;
//#UC END# *4B0EB10C02A3_4936B666032Aset_impl*
end;//_sdsCommonDiction_.Set_CurrentNode

function _sdsCommonDiction_.Get_DeCommonDiction: IdeCommonDiction;
//#UC START# *4B0EB7B10270_4936B666032Aget_var*
//#UC END# *4B0EB7B10270_4936B666032Aget_var*
begin
//#UC START# *4B0EB7B10270_4936B666032Aget_impl*
 Supports(SetData.DocInfo, IdeCommonDiction, Result);
//#UC END# *4B0EB7B10270_4936B666032Aget_impl*
end;//_sdsCommonDiction_.Get_DeCommonDiction

function _sdsCommonDiction_.pm_GetDsSaveLoad: IdsSaveLoad;
//#UC START# *4D78AFC702D5_4936B666032Aget_var*
//#UC END# *4D78AFC702D5_4936B666032Aget_var*
begin
 if (f_dsSaveLoad = nil) then
 begin
  f_dsSaveLoad := TvcmViewAreaControllerRef.Make;
  //#UC START# *4D78AFC702D5_4936B666032Aget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4D78AFC702D5_4936B666032Aget_init*
 end;//f_dsSaveLoad = nil
 if f_dsSaveLoad.IsEmpty
  //#UC START# *4D78AFC702D5_4936B666032Aget_need*
  // - условие создания ViewArea
  //#UC END# *4D78AFC702D5_4936B666032Aget_need*
  then
   f_dsSaveLoad.Referred := DoGet_dsSaveLoad;
 Result := IdsSaveLoad(f_dsSaveLoad.Referred);
end;

function _sdsCommonDiction_.DoGet_dsSaveLoad: IdsSaveLoad;
//#UC START# *4D78AFC702D5_4936B666032Aarea_var*
//#UC END# *4D78AFC702D5_4936B666032Aarea_var*
begin
//#UC START# *4D78AFC702D5_4936B666032Aarea_impl*
 Result := TdsSaveLoad.Make(Self);
//#UC END# *4D78AFC702D5_4936B666032Aarea_impl*
end;//_sdsCommonDiction_.DoGet_dsSaveLoad

function _sdsCommonDiction_.pm_GetDsChild: IdsChild;
//#UC START# *4D7A7A9D016D_4936B666032Aget_var*
//#UC END# *4D7A7A9D016D_4936B666032Aget_var*
begin
 if (f_dsChild = nil) then
 begin
  f_dsChild := TvcmViewAreaControllerRef.Make;
  //#UC START# *4D7A7A9D016D_4936B666032Aget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4D7A7A9D016D_4936B666032Aget_init*
 end;//f_dsChild = nil
 if f_dsChild.IsEmpty
  //#UC START# *4D7A7A9D016D_4936B666032Aget_need*
  // - условие создания ViewArea
  //#UC END# *4D7A7A9D016D_4936B666032Aget_need*
  then
   f_dsChild.Referred := DoGet_dsChild;
 Result := IdsChild(f_dsChild.Referred);
end;

function _sdsCommonDiction_.DoGet_dsChild: IdsChild;
//#UC START# *4D7A7A9D016D_4936B666032Aarea_var*
//#UC END# *4D7A7A9D016D_4936B666032Aarea_var*
begin
//#UC START# *4D7A7A9D016D_4936B666032Aarea_impl*
 Result := TdsChild.Make(Self);
//#UC END# *4D7A7A9D016D_4936B666032Aarea_impl*
end;//_sdsCommonDiction_.DoGet_dsChild

function _sdsCommonDiction_.pm_GetDsContents: IdsCommonDiction;
//#UC START# *500D34960277_4936B666032Aget_var*
//#UC END# *500D34960277_4936B666032Aget_var*
begin
 with pm_GetdsContentsRef do
 begin
  if IsEmpty
   //#UC START# *500D34960277_4936B666032Aget_need*
   // - условие создания ViewArea
  //#UC END# *500D34960277_4936B666032Aget_need*
   then
    Referred := DoGet_dsContents;
  Result := IdsCommonDiction(Referred);
 end;//with pm_GetdsContentsRef
end;

function _sdsCommonDiction_.DoGet_dsContents: IdsCommonDiction;
//#UC START# *500D34960277_4936B666032Aarea_var*
//#UC END# *500D34960277_4936B666032Aarea_var*
begin
//#UC START# *500D34960277_4936B666032Aarea_impl*
 Result := MakeContents;
//#UC END# *500D34960277_4936B666032Aarea_impl*
end;//_sdsCommonDiction_.DoGet_dsContents

function _sdsCommonDiction_.pm_GetdsContentsRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsContentsRef;
end;

{$If not defined(NoVCM)}
procedure _sdsCommonDiction_.DataExchange;
//#UC START# *47F37DF001FE_4936B666032A_var*
//#UC END# *47F37DF001FE_4936B666032A_var*
begin
//#UC START# *47F37DF001FE_4936B666032A_impl*
 SetData.DocInfo := MakeDocInfo(InitialUseCaseData);
//#UC END# *47F37DF001FE_4936B666032A_impl*
end;//_sdsCommonDiction_.DataExchange
{$IfEnd} //not NoVCM

function _sdsCommonDiction_.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
//#UC START# *4925B9370022_4936B666032A_var*
var
 l_Data              : IvcmData;
 l_NeedSaveToHistory : Boolean;
//#UC END# *4925B9370022_4936B666032A_var*
begin
//#UC START# *4925B9370022_4936B666032A_impl*
 Result := True;
 l_NeedSaveToHistory := pm_GetHasDocument;
  // - при открытии толкового словаря и инициализации первым толкованием не
  //   сохраняем состояние сборки в историю (CQ: OIT5-28343);
 if l_NeedSaveToHistory and (SetData <> nil) then
  l_Data := SetData.Clone
 else
  l_Data := nil;
 BeforeAssignDocument(aDoc);
 with SetData do
 begin
  DocInfo := MakeDocInfo(aDoc);
  dsDocumentRef.Clear;
  dsAttributesRef.Referred := nil;
 end;//with dTips do
 AfterAssignDocument;
 if l_NeedSaveToHistory then
  Refresh(vcmMakeDataRefreshParams(sfsOnlyIfDataSourceChanged, l_Data))
 else
  Refresh;
//#UC END# *4925B9370022_4936B666032A_impl*
end;//_sdsCommonDiction_.DoChangeDocument

function _sdsCommonDiction_.GetHasAttributes: Boolean;
//#UC START# *49352CEF0222_4936B666032A_var*
//#UC END# *49352CEF0222_4936B666032A_var*
begin
//#UC START# *49352CEF0222_4936B666032A_impl*
 // Информация о документе для толкового словарая доступна только для внутренней
 // версии системы (CQ: OIT5-24247):
 if afw.Application.IsInternal then
  Result := inherited GetHasAttributes
 else
  Result := False;
//#UC END# *49352CEF0222_4936B666032A_impl*
end;//_sdsCommonDiction_.GetHasAttributes

{$If not defined(NoVCM)}
procedure _sdsCommonDiction_.ClearAreas;
 {-}
begin
 if (f_dsSaveLoad <> nil) then f_dsSaveLoad.Referred := nil;
 if (f_dsChild <> nil) then f_dsChild.Referred := nil;
 pm_GetdsContentsRef.Referred := nil;
 inherited;
end;//_sdsCommonDiction_.ClearAreas
{$IfEnd} //not NoVCM

function _sdsCommonDiction_.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_4936B666032A_var*
//#UC END# *4A60B23E00C3_4936B666032A_var*
begin
//#UC START# *4A60B23E00C3_4936B666032A_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IDocument) and (SetData.DocInfo <> nil) and
    (SetData.DocInfo.Doc <> nil) then
  begin
   Assert(false, 'И по хорошему бы открутить на UseCaseController.COMQueryInterface чтоб он свои данные наружу не выставлял. Уж лучше пусть на нем свойство будет UseCaseController.Data: IdRightInterface;');
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=145098116
   IDocument(Obj) := SetData.DocInfo.Doc;
   Result.SetOK;
  end//if IID.EQ(IDocument) and (f_deTips <> nil)
  else
  if IID.EQ(IdCommonDiction) then
  begin
   Assert(false, 'И по хорошему бы открутить на UseCaseController.COMQueryInterface чтоб он свои данные наружу не выставлял. Уж лучше пусть на нем свойство будет UseCaseController.Data: IdRightInterface;');
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=145098116
   IdCommonDiction(Obj) := SetData;
   Result.SetOK;
  end;//if IID.EQ(IdCommonDiction) then
//#UC END# *4A60B23E00C3_4936B666032A_impl*
end;//_sdsCommonDiction_.COMQueryInterface

{$If not defined(NoVCM)}
function _sdsCommonDiction_.GetDataForClone: _InitDataType_;
//#UC START# *55C1DD070354_4936B666032A_var*
//#UC END# *55C1DD070354_4936B666032A_var*
begin
//#UC START# *55C1DD070354_4936B666032A_impl*
 Result := MakeDocInfo(pm_GetDocInfo);
//#UC END# *55C1DD070354_4936B666032A_impl*
end;//_sdsCommonDiction_.GetDataForClone
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

{$EndIf sdsCommonDiction_imp}
