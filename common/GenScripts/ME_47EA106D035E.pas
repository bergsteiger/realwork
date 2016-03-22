{$IfNDef sdsBaseDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocument.imp.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "sdsBaseDocument" MUID: (47EA106D035E)
// Имя типа: "_sdsBaseDocument_"

{$Define sdsBaseDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}
 _sdsBaseDocument_ = {abstract} class(_vcmFormSetDataSource_, IsdsBaseDocument, IsdsGotoPointDataMaker, IsdsPrimDocument)
  {* БОС, базовый для прецедента с документом }
  protected
   function BaseDocumentClass: IdsBaseDocument; virtual; abstract;
   function DocumentData: IdeDocInfo;
    {* данные для инициализации бизнес объекта документа }
   procedure ClearAllDS; virtual;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; virtual;
   function DoMakeGotoPointData(const aDocument: IDocument;
    aRefType: TDocumentPositionType;
    aPos: Longword): IdeDocInfo; virtual;
    {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
           новой сборки вернуться как результат для вызова операции модуля }
   function NeedMakeDocument: Boolean; virtual;
    {* Определяет - нужно ли создавать область ввода для документа }
   procedure FillState; virtual;
   function As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
    {* Метод приведения нашего интерфейса к IsdsGotoPointDataMaker }
   function As_IsdsPrimDocument: IsdsPrimDocument;
    {* Метод приведения нашего интерфейса к IsdsPrimDocument }
   function ChangeDocument(const aDoc: IdeDocInfo): Boolean;
    {* изменился документ }
   function MakeGotoPointData(const aDocument: IDocument;
    aRefType: TDocumentPositionType;
    aPos: Longword): IdeDocInfo;
    {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
           новой сборки вернуться как результат для вызова операции модуля }
   function pm_GetDocInfo: IdeDocInfo;
   function pm_GetdsDocument: IdsBaseDocument;
   function pm_GetHasDocument: Boolean;
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
 end;//_sdsBaseDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}
_sdsBaseDocument_ = _vcmFormSetDataSource_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else sdsBaseDocument_imp}

{$IfNDef sdsBaseDocument_imp_impl}

{$Define sdsBaseDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}

function _sdsBaseDocument_.DocumentData: IdeDocInfo;
 {* данные для инициализации бизнес объекта документа }
//#UC START# *4925B4AD0340_47EA106D035E_var*
//#UC END# *4925B4AD0340_47EA106D035E_var*
begin
//#UC START# *4925B4AD0340_47EA106D035E_impl*
 // Обязательно клонируем, потому что иначе документ и сборка будут изменять
 // один и тот же IdeDocInfo
 if Assigned(SetData.DocInfo) then
  Result := SetData.DocInfo.Clone
 else
  Result := nil;
//#UC END# *4925B4AD0340_47EA106D035E_impl*
end;//_sdsBaseDocument_.DocumentData

procedure _sdsBaseDocument_.ClearAllDS;
//#UC START# *4925B7F00156_47EA106D035E_var*
//#UC END# *4925B7F00156_47EA106D035E_var*
begin
//#UC START# *4925B7F00156_47EA106D035E_impl*
 pm_GetdsDocumentRef.Referred := nil;
//#UC END# *4925B7F00156_47EA106D035E_impl*
end;//_sdsBaseDocument_.ClearAllDS

function _sdsBaseDocument_.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
//#UC START# *4925B9370022_47EA106D035E_var*
//#UC END# *4925B9370022_47EA106D035E_var*
begin
//#UC START# *4925B9370022_47EA106D035E_impl*
 Result := false;
//#UC END# *4925B9370022_47EA106D035E_impl*
end;//_sdsBaseDocument_.DoChangeDocument

function _sdsBaseDocument_.DoMakeGotoPointData(const aDocument: IDocument;
 aRefType: TDocumentPositionType;
 aPos: Longword): IdeDocInfo;
 {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
           новой сборки вернуться как результат для вызова операции модуля }
//#UC START# *4925BE3E0260_47EA106D035E_var*
//#UC END# *4925BE3E0260_47EA106D035E_var*
begin
//#UC START# *4925BE3E0260_47EA106D035E_impl*
 Result := TdeDocInfo.Make(aDocument, TbsDocPos_C(aRefType, aPos));
//#UC END# *4925BE3E0260_47EA106D035E_impl*
end;//_sdsBaseDocument_.DoMakeGotoPointData

function _sdsBaseDocument_.NeedMakeDocument: Boolean;
 {* Определяет - нужно ли создавать область ввода для документа }
//#UC START# *493D1BE601B1_47EA106D035E_var*
//#UC END# *493D1BE601B1_47EA106D035E_var*
begin
//#UC START# *493D1BE601B1_47EA106D035E_impl*
 Result := true;
//#UC END# *493D1BE601B1_47EA106D035E_impl*
end;//_sdsBaseDocument_.NeedMakeDocument

procedure _sdsBaseDocument_.FillState;
//#UC START# *493D51ED0329_47EA106D035E_var*
//#UC END# *493D51ED0329_47EA106D035E_var*
begin
//#UC START# *493D51ED0329_47EA106D035E_impl*
 // - ничего не делаем, надеемся на потомков
//#UC END# *493D51ED0329_47EA106D035E_impl*
end;//_sdsBaseDocument_.FillState

function _sdsBaseDocument_.As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
 {* Метод приведения нашего интерфейса к IsdsGotoPointDataMaker }
begin
 Result := Self;
end;//_sdsBaseDocument_.As_IsdsGotoPointDataMaker

function _sdsBaseDocument_.As_IsdsPrimDocument: IsdsPrimDocument;
 {* Метод приведения нашего интерфейса к IsdsPrimDocument }
begin
 Result := Self;
end;//_sdsBaseDocument_.As_IsdsPrimDocument

function _sdsBaseDocument_.ChangeDocument(const aDoc: IdeDocInfo): Boolean;
 {* изменился документ }
//#UC START# *4925978F00FA_47EA106D035E_var*
//#UC END# *4925978F00FA_47EA106D035E_var*
begin
//#UC START# *4925978F00FA_47EA106D035E_impl*
 Result := DoChangeDocument(aDoc);
//#UC END# *4925978F00FA_47EA106D035E_impl*
end;//_sdsBaseDocument_.ChangeDocument

function _sdsBaseDocument_.MakeGotoPointData(const aDocument: IDocument;
 aRefType: TDocumentPositionType;
 aPos: Longword): IdeDocInfo;
 {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
           новой сборки вернуться как результат для вызова операции модуля }
//#UC START# *492597A602F6_47EA106D035E_var*
//#UC END# *492597A602F6_47EA106D035E_var*
begin
//#UC START# *492597A602F6_47EA106D035E_impl*
 Result := DoMakeGotoPointData(aDocument, aRefType, aPos);
//#UC END# *492597A602F6_47EA106D035E_impl*
end;//_sdsBaseDocument_.MakeGotoPointData

function _sdsBaseDocument_.pm_GetDocInfo: IdeDocInfo;
//#UC START# *4DF9D63B0360_47EA106D035Eget_var*
//#UC END# *4DF9D63B0360_47EA106D035Eget_var*
begin
//#UC START# *4DF9D63B0360_47EA106D035Eget_impl*
 Result := SetData.DocInfo;
//#UC END# *4DF9D63B0360_47EA106D035Eget_impl*
end;//_sdsBaseDocument_.pm_GetDocInfo

function _sdsBaseDocument_.pm_GetdsDocument: IdsBaseDocument;
//#UC START# *50002EC80001_47EA106D035Eget_var*
//#UC END# *50002EC80001_47EA106D035Eget_var*
begin
//#UC START# *50002EC80001_47EA106D035Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *50002EC80001_47EA106D035Eget_impl*
end;//_sdsBaseDocument_.pm_GetdsDocument

function _sdsBaseDocument_.pm_GetHasDocument: Boolean;
//#UC START# *5111C2BAF24F_47EA106D035Eget_var*
//#UC END# *5111C2BAF24F_47EA106D035Eget_var*
begin
//#UC START# *5111C2BAF24F_47EA106D035Eget_impl*
 with SetData do
  Result := Assigned(DocInfo) and Assigned(DocInfo.Doc);
//#UC END# *5111C2BAF24F_47EA106D035Eget_impl*
end;//_sdsBaseDocument_.pm_GetHasDocument

{$If NOT Defined(NoVCM)}
procedure _sdsBaseDocument_.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_47EA106D035E_var*
var
 l_DocInfo: IdeDocInfo;
//#UC END# *47F37DF001FE_47EA106D035E_var*
begin
//#UC START# *47F37DF001FE_47EA106D035E_impl*
 Assert(false, 'Ловим инициализацию абстрактного прецедента');
 Supports(InitialUseCaseData, IdeDocInfo, l_DocInfo);
 SetData.DocInfo := l_DocInfo;
//#UC END# *47F37DF001FE_47EA106D035E_impl*
end;//_sdsBaseDocument_.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _sdsBaseDocument_.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_47EA106D035E_var*
//#UC END# *4938F7E702B7_47EA106D035E_var*
begin
//#UC START# *4938F7E702B7_47EA106D035E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_47EA106D035E_impl*
end;//_sdsBaseDocument_.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

function _sdsBaseDocument_.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_47EA106D035E_var*
//#UC END# *4A60B23E00C3_47EA106D035E_var*
begin
//#UC START# *4A60B23E00C3_47EA106D035E_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IDocument) and pm_GetHasDocument then
  begin
   IDocument(Obj) := pm_GetDocInfo.Doc;
   Result.SetOK;
  end;//if IID.EQ(IDocument) and pm_GetHasDocument then
//#UC END# *4A60B23E00C3_47EA106D035E_impl*
end;//_sdsBaseDocument_.COMQueryInterface
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf sdsBaseDocument_imp_impl}

{$EndIf sdsBaseDocument_imp}

