{$IfNDef sdsCommonDiction_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\sdsCommonDiction.imp.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "sdsCommonDiction" MUID: (4936B666032A)
// Имя типа: "_sdsCommonDiction_"

{$Define sdsCommonDiction_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _InitDataType_ = IdeDocInfo;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
 _sdsCommonDiction_ = {abstract} class(_sdsBaseDocumentWithAttributes_, IsdsCommonDiction)
  {* Бизнес объект сборки "Обобщенный словарь" }
  private
   f_dsSaveLoad: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsSaveLoad }
   f_dsChild: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsChild }
  protected
   function MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction; virtual; abstract;
   procedure BeforeAssignDocument(const aDoc: IdeDocInfo); virtual;
   procedure AfterAssignDocument; virtual;
   function MakeContents: IdsCommonDiction; virtual; abstract;
    {* Создаёт область оглавления }
   function Get_CurrentNode: INodeBase;
   procedure Set_CurrentNode(const aValue: INodeBase);
   function Get_DeCommonDiction: IdeCommonDiction;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function pm_GetDsChild: IdsChild;
   function pm_GetDsContents: IdsCommonDiction;
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   function GetHasAttributes: Boolean; override;
    {* Реализация HasAttributes }
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   {$If NOT Defined(NoVCM)}
   function GetDataForClone: _InitDataType_; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
 end;//_sdsCommonDiction_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
_sdsCommonDiction_ = _sdsBaseDocumentWithAttributes_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else sdsCommonDiction_imp}

{$IfNDef sdsCommonDiction_imp_impl}

{$Define sdsCommonDiction_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}

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
//#UC START# *4D78AFC702D5_4936B666032Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D78AFC702D5_4936B666032Aget_impl*
end;//_sdsCommonDiction_.pm_GetDsSaveLoad

function _sdsCommonDiction_.pm_GetDsChild: IdsChild;
//#UC START# *4D7A7A9D016D_4936B666032Aget_var*
//#UC END# *4D7A7A9D016D_4936B666032Aget_var*
begin
//#UC START# *4D7A7A9D016D_4936B666032Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D7A7A9D016D_4936B666032Aget_impl*
end;//_sdsCommonDiction_.pm_GetDsChild

function _sdsCommonDiction_.pm_GetDsContents: IdsCommonDiction;
//#UC START# *500D34960277_4936B666032Aget_var*
//#UC END# *500D34960277_4936B666032Aget_var*
begin
//#UC START# *500D34960277_4936B666032Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D34960277_4936B666032Aget_impl*
end;//_sdsCommonDiction_.pm_GetDsContents

{$If NOT Defined(NoVCM)}
procedure _sdsCommonDiction_.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_4936B666032A_var*
//#UC END# *47F37DF001FE_4936B666032A_var*
begin
//#UC START# *47F37DF001FE_4936B666032A_impl*
 SetData.DocInfo := MakeDocInfo(InitialUseCaseData);
//#UC END# *47F37DF001FE_4936B666032A_impl*
end;//_sdsCommonDiction_.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

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
 {* Реализация HasAttributes }
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

{$If NOT Defined(NoVCM)}
procedure _sdsCommonDiction_.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_4936B666032A_var*
//#UC END# *4938F7E702B7_4936B666032A_var*
begin
//#UC START# *4938F7E702B7_4936B666032A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_4936B666032A_impl*
end;//_sdsCommonDiction_.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

function _sdsCommonDiction_.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
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

{$If NOT Defined(NoVCM)}
function _sdsCommonDiction_.GetDataForClone: _InitDataType_;
//#UC START# *55C1DD070354_4936B666032A_var*
//#UC END# *55C1DD070354_4936B666032A_var*
begin
//#UC START# *55C1DD070354_4936B666032A_impl*
 Result := MakeDocInfo(pm_GetDocInfo);
//#UC END# *55C1DD070354_4936B666032A_impl*
end;//_sdsCommonDiction_.GetDataForClone
{$IfEnd} // NOT Defined(NoVCM)

procedure _sdsCommonDiction_.ClearFields;
begin
 f_dsSaveLoad := nil;
 f_dsChild := nil;
 inherited;
end;//_sdsCommonDiction_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf sdsCommonDiction_imp_impl}

{$EndIf sdsCommonDiction_imp}

