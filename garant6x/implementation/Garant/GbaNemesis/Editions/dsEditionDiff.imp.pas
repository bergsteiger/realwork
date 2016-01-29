{$IfNDef dsEditionDiff_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/dsEditionDiff.imp.pas"
// Начат: 30.07.2009 15:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::Editions::dsEditionDiff
//
// Разница редакций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsEditionDiff_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _InitDataType_ = InsEditionDiffData;
 {$Include ..\Editions\dsEdition.imp.pas}
 _UnderControlBehaviour_Parent_ = _dsEdition_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\UnderControl\UnderControlBehaviour.imp.pas}
 _ucpHAFMacroReplacerFactory_Parent_ = _UnderControlBehaviour_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Presentation\ucpHAFMacroReplacerFactory.imp.pas}
 _dsEditionDiff_ = {abstract vac} class(_ucpHAFMacroReplacerFactory_, IdsEditionDiff, InsEditionListener {from IdsEditionDiff}, IucpFilterInfoFactory {from IdsEditionDiff})
  {* Разница редакций }
 private
 // private fields
   f_Cont : InevDocumentContainer;
    {* Контейнер документа}
 protected
 // realized methods
   function Get_DocumentContainer: InevDocumentContainer;
   function Get_RedactionCurrentPara: IeeLeafPara;
   function Get_Document: IDocument;
   function Get_RedactionName: Il3CString;
   procedure EditionChanged;
   function MakeFilterInfo(aType: TnsFolderFilter;
    aShowFolders: TnsShowFolders = sfAll): InsFolderFilterInfo;
   function Get_DocumentForReturn: TnsDocumentForReturnInfo;
   function DoGetControllable: IControllable; override;
   function DocumentForDocInfoProvider: IDocument; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   function DoGetDocument: IDocument; virtual;
     {* Возвращает документ сответствующий данной редакции }
   procedure SignalEditionChanged; virtual;
     {* Сообщение о смене редакции }
   function IsLeft: Boolean; virtual; abstract;
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_InsEditionListener: InsEditionListener;
   function As_IucpHAFMacroReplacerFactory: IucpHAFMacroReplacerFactory;
   function As_IucpFilterInfoFactory: IucpFilterInfoFactory;
 end;//_dsEditionDiff_
{$Else}

 {$Include ..\Editions\dsEdition.imp.pas}
 _UnderControlBehaviour_Parent_ = _dsEdition_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\UnderControl\UnderControlBehaviour.imp.pas}
 _ucpHAFMacroReplacerFactory_Parent_ = _UnderControlBehaviour_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Presentation\ucpHAFMacroReplacerFactory.imp.pas}
 _dsEditionDiff_ = _ucpHAFMacroReplacerFactory_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dsEditionDiff_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\Editions\dsEdition.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\UnderControl\UnderControlBehaviour.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Presentation\ucpHAFMacroReplacerFactory.imp.pas}

// start class _dsEditionDiff_

function _dsEditionDiff_.DoGetDocument: IDocument;
//#UC START# *4A80573D03A7_4A7188E40294_var*
//#UC END# *4A80573D03A7_4A7188E40294_var*
begin
//#UC START# *4A80573D03A7_4A7188E40294_impl*
 Result := PartData.Document;
//#UC END# *4A80573D03A7_4A7188E40294_impl*
end;//_dsEditionDiff_.DoGetDocument

procedure _dsEditionDiff_.SignalEditionChanged;
//#UC START# *4A8426C0002A_4A7188E40294_var*
//#UC END# *4A8426C0002A_4A7188E40294_var*
begin
//#UC START# *4A8426C0002A_4A7188E40294_impl*
 // - ничего не делаем
//#UC END# *4A8426C0002A_4A7188E40294_impl*
end;//_dsEditionDiff_.SignalEditionChanged

function _dsEditionDiff_.Get_DocumentContainer: InevDocumentContainer;
//#UC START# *4A786E2A00A2_4A7188E40294get_var*
//#UC END# *4A786E2A00A2_4A7188E40294get_var*
begin
//#UC START# *4A786E2A00A2_4A7188E40294get_impl*
 if (f_Cont = nil) then
  f_Cont := TnsEditionFromDTPDocumentContainer.Make(IsLeft, ucc_CompareEditions.As_InsDocumentTextProviderFactory);
 Result := f_Cont; 
//#UC END# *4A786E2A00A2_4A7188E40294get_impl*
end;//_dsEditionDiff_.Get_DocumentContainer

function _dsEditionDiff_.Get_RedactionCurrentPara: IeeLeafPara;
//#UC START# *4A7FF1AC035C_4A7188E40294get_var*
//#UC END# *4A7FF1AC035C_4A7188E40294get_var*
begin
//#UC START# *4A7FF1AC035C_4A7188E40294get_impl*
 Result := PartData.RedactionCurrentPara;
//#UC END# *4A7FF1AC035C_4A7188E40294get_impl*
end;//_dsEditionDiff_.Get_RedactionCurrentPara

function _dsEditionDiff_.Get_Document: IDocument;
//#UC START# *4A8006FC02A1_4A7188E40294get_var*
//#UC END# *4A8006FC02A1_4A7188E40294get_var*
begin
//#UC START# *4A8006FC02A1_4A7188E40294get_impl*
 Result := DoGetDocument;
//#UC END# *4A8006FC02A1_4A7188E40294get_impl*
end;//_dsEditionDiff_.Get_Document

function _dsEditionDiff_.Get_RedactionName: Il3CString;
//#UC START# *4A83CD9502BE_4A7188E40294get_var*
var
 l_State : IDocumentState;
 l_Info  : TRedactionInfo;
//#UC END# *4A83CD9502BE_4A7188E40294get_var*
begin
//#UC START# *4A83CD9502BE_4A7188E40294get_impl*
 Get_Document.GetCurrentState(l_State);
 l_State.GetCurrentRedaction(l_Info);
 Result := nsCStr(l_Info.rName);
//#UC END# *4A83CD9502BE_4A7188E40294get_impl*
end;//_dsEditionDiff_.Get_RedactionName

procedure _dsEditionDiff_.EditionChanged;
//#UC START# *4A841BEF002A_4A7188E40294_var*
var
 l_Index : Integer;
 l_Intf  : InsEditionListener;
 l_Item  : IUnknown;
//#UC END# *4A841BEF002A_4A7188E40294_var*
begin
//#UC START# *4A841BEF002A_4A7188E40294_impl*
 SignalEditionChanged;
 f_Cont := nil;
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
//#UC END# *4A841BEF002A_4A7188E40294_impl*
end;//_dsEditionDiff_.EditionChanged

function _dsEditionDiff_.MakeFilterInfo(aType: TnsFolderFilter;
  aShowFolders: TnsShowFolders = sfAll): InsFolderFilterInfo;
//#UC START# *4AE575FA030B_4A7188E40294_var*
//#UC END# *4AE575FA030B_4A7188E40294_var*
begin
//#UC START# *4AE575FA030B_4A7188E40294_impl*
 Result := TnsFolderFilterInfo.Make(aType, ns_ffDocument, aShowFolders)
//#UC END# *4AE575FA030B_4A7188E40294_impl*
end;//_dsEditionDiff_.MakeFilterInfo

function _dsEditionDiff_.Get_DocumentForReturn: TnsDocumentForReturnInfo;
//#UC START# *4B5852A800F5_4A7188E40294get_var*
//#UC END# *4B5852A800F5_4A7188E40294get_var*
begin
//#UC START# *4B5852A800F5_4A7188E40294get_impl*
 Result := PartData.DocumentForReturn;
//#UC END# *4B5852A800F5_4A7188E40294get_impl*
end;//_dsEditionDiff_.Get_DocumentForReturn

function _dsEditionDiff_.DoGetControllable: IControllable;
//#UC START# *4B9A37C90253_4A7188E40294_var*
//#UC END# *4B9A37C90253_4A7188E40294_var*
begin
//#UC START# *4B9A37C90253_4A7188E40294_impl*
 Supports(DoGetDocument, IControllable, Result);
//#UC END# *4B9A37C90253_4A7188E40294_impl*
end;//_dsEditionDiff_.DoGetControllable

function _dsEditionDiff_.DocumentForDocInfoProvider: IDocument;
//#UC START# *4F548A0D0096_4A7188E40294_var*
//#UC END# *4F548A0D0096_4A7188E40294_var*
begin
//#UC START# *4F548A0D0096_4A7188E40294_impl*
 Result := Get_Document;
//#UC END# *4F548A0D0096_4A7188E40294_impl*
end;//_dsEditionDiff_.DocumentForDocInfoProvider

procedure _dsEditionDiff_.Cleanup;
//#UC START# *479731C50290_4A7188E40294_var*
//#UC END# *479731C50290_4A7188E40294_var*
begin
//#UC START# *479731C50290_4A7188E40294_impl*
 UseCaseController.As_Il3ChangeNotifier.Unsubscribe(InsEditionListener(Self));
 inherited;
 f_Cont := nil;
//#UC END# *479731C50290_4A7188E40294_impl*
end;//_dsEditionDiff_.Cleanup

procedure _dsEditionDiff_.InitFields;
//#UC START# *47A042E100E2_4A7188E40294_var*
//#UC END# *47A042E100E2_4A7188E40294_var*
begin
//#UC START# *47A042E100E2_4A7188E40294_impl*
 inherited;
 UseCaseController.As_Il3ChangeNotifier.Subscribe(InsEditionListener(Self));
//#UC END# *47A042E100E2_4A7188E40294_impl*
end;//_dsEditionDiff_.InitFields

// Методы преобразования к реализуемым интерфейсам

function _dsEditionDiff_.As_InsEditionListener: InsEditionListener;
begin
 Result := Self;
end;

function _dsEditionDiff_.As_IucpHAFMacroReplacerFactory: IucpHAFMacroReplacerFactory;
begin
 Result := Self;
end;

function _dsEditionDiff_.As_IucpFilterInfoFactory: IucpFilterInfoFactory;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dsEditionDiff_imp}
