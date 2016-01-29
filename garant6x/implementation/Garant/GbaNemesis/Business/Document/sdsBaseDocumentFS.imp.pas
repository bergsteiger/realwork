{$IfNDef sdsBaseDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/sdsBaseDocument.imp.pas"
// Начат: 06.10.2005 13:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Core::Common::Business::BaseDocument::sdsBaseDocument
//
// БОС, базовый для прецедента с документом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define sdsBaseDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}

 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithFlexFormSetType.imp.pas}
 _sdsBaseDocument_ = {abstract ucc} class(_vcmFormSetDataSourceWithFlexFormSetType_, IsdsBaseDocument, IsdsGotoPointDataMaker {from IsdsBaseDocument}, IsdsPrimDocument {from IsdsBaseDocument})
  {* БОС, базовый для прецедента с документом }
 protected
 // realized methods
   function ChangeDocument(const aDoc: IdeDocInfo): Boolean;
     {* изменился документ }
   function MakeGotoPointData(const aDocument: IDocument;
    aRefType: TDocumentPositionType;
    aPos: Longword): IdeDocInfo;
     {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
           новой сборки вернуться как результат для вызова операции модуля }
   function pm_GetDocInfo: IdeDocInfo;
   function pm_GetDsDocument: IdsBaseDocument;
   function DoGet_dsDocument: IdsBaseDocument;
   function pm_GetdsDocumentRef: IvcmViewAreaControllerRef;
   function pm_GetHasDocument: Boolean;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DataExchange; override;
     {* - вызывается после получения данных инициализации. }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 protected
 // protected methods
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
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
   function As_IsdsPrimDocument: IsdsPrimDocument;
 end;//_sdsBaseDocument_
{$IfEnd} //not Admin AND not Monitorings

{$Else sdsBaseDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithFlexFormSetType.imp.pas}

// start class _sdsBaseDocument_

function _sdsBaseDocument_.DocumentData: IdeDocInfo;
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
//#UC START# *4925BE3E0260_47EA106D035E_var*
//#UC END# *4925BE3E0260_47EA106D035E_var*
begin
//#UC START# *4925BE3E0260_47EA106D035E_impl*
 Result := TdeDocInfo.Make(aDocument, TbsDocPos_C(aRefType, aPos));
//#UC END# *4925BE3E0260_47EA106D035E_impl*
end;//_sdsBaseDocument_.DoMakeGotoPointData

function _sdsBaseDocument_.NeedMakeDocument: Boolean;
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

function _sdsBaseDocument_.ChangeDocument(const aDoc: IdeDocInfo): Boolean;
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

function _sdsBaseDocument_.pm_GetDsDocument: IdsBaseDocument;
//#UC START# *50002EC80001_47EA106D035Eget_var*
//#UC END# *50002EC80001_47EA106D035Eget_var*
begin
 with pm_GetdsDocumentRef do
 begin
  if IsEmpty
   //#UC START# *50002EC80001_47EA106D035Eget_need*
   AND NeedMakeDocument
   // - условие создания ViewArea
  //#UC END# *50002EC80001_47EA106D035Eget_need*
   then
    Referred := DoGet_dsDocument;
  Result := IdsBaseDocument(Referred);
 end;//with pm_GetdsDocumentRef
end;

function _sdsBaseDocument_.DoGet_dsDocument: IdsBaseDocument;
//#UC START# *50002EC80001_47EA106D035Earea_var*
//#UC END# *50002EC80001_47EA106D035Earea_var*
begin
//#UC START# *50002EC80001_47EA106D035Earea_impl*
 Result := BaseDocumentClass;
//#UC END# *50002EC80001_47EA106D035Earea_impl*
end;//_sdsBaseDocument_.DoGet_dsDocument

function _sdsBaseDocument_.pm_GetdsDocumentRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsDocumentRef;
end;

function _sdsBaseDocument_.pm_GetHasDocument: Boolean;
//#UC START# *5111C2BAF24F_47EA106D035Eget_var*
//#UC END# *5111C2BAF24F_47EA106D035Eget_var*
begin
//#UC START# *5111C2BAF24F_47EA106D035Eget_impl*
 with SetData do
  Result := Assigned(DocInfo) and Assigned(DocInfo.Doc);
//#UC END# *5111C2BAF24F_47EA106D035Eget_impl*
end;//_sdsBaseDocument_.pm_GetHasDocument

{$If not defined(NoVCM)}
procedure _sdsBaseDocument_.DataExchange;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _sdsBaseDocument_.ClearAreas;
 {-}
begin
 pm_GetdsDocumentRef.Referred := nil;
 inherited;
end;//_sdsBaseDocument_.ClearAreas
{$IfEnd} //not NoVCM

function _sdsBaseDocument_.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
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

// Методы преобразования к реализуемым интерфейсам

function _sdsBaseDocument_.As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
begin
 Result := Self;
end;

function _sdsBaseDocument_.As_IsdsPrimDocument: IsdsPrimDocument;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf sdsBaseDocument_imp}
