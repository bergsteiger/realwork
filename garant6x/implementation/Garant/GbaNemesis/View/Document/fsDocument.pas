unit fsDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/fsDocument.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::Document
//
// Документ
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  DocumentUserTypes_dftDocument_UserType,
  l3StringIDEx,
  Common_FormDefinitions_Controls,
  WorkWithDocumentInterfaces,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_WarnPreActive_UserType,
  BaloonWarningUserTypes_WarnIsAbolished_UserType,
  BaloonWarningUserTypes_WarnOnControl_UserType,
  BaloonWarningUserTypes_WarnInactualDocument_UserType,
  BaloonWarningUserTypes_WarnTimeMachineOn_UserType,
  BaloonWarningUserTypes_WarnRedaction_UserType,
  BaloonWarningUserTypes_WarnTimeMachineWarning_UserType,
  BaloonWarningUserTypes_WarnTimeMachineException_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  fsAbstractDocument,
  nevBase,
  nsTypes,
  DocumentInterfaces,
  nevTools,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  ,
  vcmFormSetFactory {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_Document = {final fsf} class(Tfs_AbstractDocument)
   {* Документ }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function TextParentDftDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Text }
   function WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnJuror }
   function WarnPreActiveChildWarnPreActiveNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnPreActive }
   function WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnIsAbolished }
   function WarnOnControlChildWarnOnControlNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnOnControl }
   function WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnInactualDocument }
   function WarnTimeMachineOnChildWarnTimeMachineOnNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnTimeMachineOn }
   function WarnRedactionChildWarnRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnRedaction }
   function WarnTimeMachineWarningChildWarnTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnTimeMachineWarning }
   function WarnTimeMachineExceptionChildWarnTimeMachineExceptionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnTimeMachineException }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_Document;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_Document
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  bsUtils,
  l3MessageID,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_Document

var g_Tfs_Document : Tfs_Document = nil;

procedure Tfs_DocumentFree;
begin
 l3Free(g_Tfs_Document);
end;

class function Tfs_Document.Instance: Tfs_Document;
begin
 if (g_Tfs_Document = nil) then
 begin
  l3System.AddExitProc(Tfs_DocumentFree);
  g_Tfs_Document := Create;
 end;
 Result := g_Tfs_Document;
end;

var
    { Локализуемые строки DocumentCaptionLocalConstants }
   str_fsDocumentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDocumentCaption'; rValue : 'Текст');
    { Заголовок фабрики сборки форм "Document" }

// start class Tfs_Document

function Tfs_Document.TextParentDftDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsBaseDocument;
begin
 if Supports(aDataSource, IsdsBaseDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsDocument;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.TextParentDftDocumentNeedMakeForm

function Tfs_Document.WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnJurorChildWarnJurorNeedMakeForm

function Tfs_Document.WarnPreActiveChildWarnPreActiveNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnPreActiveChildWarnPreActiveNeedMakeForm

function Tfs_Document.WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm

function Tfs_Document.WarnOnControlChildWarnOnControlNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnOnControlChildWarnOnControlNeedMakeForm

function Tfs_Document.WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm

function Tfs_Document.WarnTimeMachineOnChildWarnTimeMachineOnNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsTimeMachineWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnTimeMachineOnChildWarnTimeMachineOnNeedMakeForm

function Tfs_Document.WarnRedactionChildWarnRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnRedactionChildWarnRedactionNeedMakeForm

function Tfs_Document.WarnTimeMachineWarningChildWarnTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsTimeMachineWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnTimeMachineWarningChildWarnTimeMachineWarningNeedMakeForm

function Tfs_Document.WarnTimeMachineExceptionChildWarnTimeMachineExceptionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsTimeMachineWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnTimeMachineExceptionChildWarnTimeMachineExceptionNeedMakeForm

class function Tfs_Document.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_Document <> nil;
end;//Tfs_Document.Exists

procedure Tfs_Document.InitFields;
 {-}
begin
 inherited;
 with AddZone('Text', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftDocument;
  with AddZone('WarnJuror', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnJuror;
   OnNeedMakeForm := WarnJurorChildWarnJurorNeedMakeForm;
  end;
  with AddZone('WarnPreActive', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnPreActive;
   OnNeedMakeForm := WarnPreActiveChildWarnPreActiveNeedMakeForm;
  end;
  with AddZone('WarnIsAbolished', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnIsAbolished;
   OnNeedMakeForm := WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm;
  end;
  with AddZone('WarnOnControl', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnOnControl;
   OnNeedMakeForm := WarnOnControlChildWarnOnControlNeedMakeForm;
  end;
  with AddZone('WarnInactualDocument', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnInactualDocument;
   OnNeedMakeForm := WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm;
  end;
  with AddZone('WarnTimeMachineOn', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnTimeMachineOn;
   OnNeedMakeForm := WarnTimeMachineOnChildWarnTimeMachineOnNeedMakeForm;
  end;
  with AddZone('WarnRedaction', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnRedaction;
   OnNeedMakeForm := WarnRedactionChildWarnRedactionNeedMakeForm;
  end;
  with AddZone('WarnTimeMachineWarning', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnTimeMachineWarning;
   OnNeedMakeForm := WarnTimeMachineWarningChildWarnTimeMachineWarningNeedMakeForm;
  end;
  with AddZone('WarnTimeMachineException', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnTimeMachineException;
   OnNeedMakeForm := WarnTimeMachineExceptionChildWarnTimeMachineExceptionNeedMakeForm;
  end;
  OnNeedMakeForm := TextParentDftDocumentNeedMakeForm;
 end;
 Caption := str_fsDocumentCaption.AsCStr;
 OwnerForm := 16;
end;//Tfs_Document.InitFields

{$If not defined(NoVCM)}
class function Tfs_Document.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_Document.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsDocumentCaption
 str_fsDocumentCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.