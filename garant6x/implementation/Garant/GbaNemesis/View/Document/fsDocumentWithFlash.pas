unit fsDocumentWithFlash;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/fsDocumentWithFlash.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::DocumentWithFlash$FSF
//
// Схема
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
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  DocumentWithFlashUserTypes_dwftMain_UserType,
  Common_FormDefinitions_Controls,
  DocInfoInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  fsAbstractDocument,
  DocumentInterfaces,
  nevTools,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  evdInterfaces,
  DocumentAndListInterfaces,
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
  Tfs_DocumentWithFlash = {final fsf} class(Tfs_AbstractDocument)
   {* Схема }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function TextParentDwftMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Text }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_DocumentWithFlash;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_DocumentWithFlash
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  l3MessageID,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_DocumentWithFlash

var g_Tfs_DocumentWithFlash : Tfs_DocumentWithFlash = nil;

procedure Tfs_DocumentWithFlashFree;
begin
 l3Free(g_Tfs_DocumentWithFlash);
end;

class function Tfs_DocumentWithFlash.Instance: Tfs_DocumentWithFlash;
begin
 if (g_Tfs_DocumentWithFlash = nil) then
 begin
  l3System.AddExitProc(Tfs_DocumentWithFlashFree);
  g_Tfs_DocumentWithFlash := Create;
 end;
 Result := g_Tfs_DocumentWithFlash;
end;

var
    { Локализуемые строки DocumentWithFlash$FSFCaptionLocalConstants }
   str_fsDocumentWithFlashCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDocumentWithFlashCaption'; rValue : 'Схема');
    { Заголовок фабрики сборки форм "DocumentWithFlash$FSF" }

// start class Tfs_DocumentWithFlash

function Tfs_DocumentWithFlash.TextParentDwftMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsDocumentWithFlash;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DocumentWithFlash.TextParentDwftMainNeedMakeForm

class function Tfs_DocumentWithFlash.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_DocumentWithFlash <> nil;
end;//Tfs_DocumentWithFlash.Exists

procedure Tfs_DocumentWithFlash.InitFields;
 {-}
begin
 inherited;
 with AddZone('Text', vcm_ztParent, fm_DocumentWithFlashForm) do
 begin
  UserType := dwftMain;
  OnNeedMakeForm := TextParentDwftMainNeedMakeForm;
 end;
 Caption := str_fsDocumentWithFlashCaption.AsCStr;
 OwnerForm := 16;
end;//Tfs_DocumentWithFlash.InitFields

{$If not defined(NoVCM)}
class function Tfs_DocumentWithFlash.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_DocumentWithFlash.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsDocumentWithFlashCaption
 str_fsDocumentWithFlashCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.