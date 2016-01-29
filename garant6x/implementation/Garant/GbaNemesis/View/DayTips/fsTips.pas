unit fsTips;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DayTips/fsTips.pas"
// Начат: 04.09.2009 12:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Интерфейсные элементы::DayTips::View::DayTips::DayTips::Tips
//
// Советы дня
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
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  ,
  DocumentAndListInterfaces,
  CommonDictionInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  DocumentUserTypes_dftTips_UserType,
  l3StringIDEx,
  AttributesUserTypes_fDocAttribute_UserType,
  PrimCommonDiction_utTips_UserType,
  Common_FormDefinitions_Controls,
  BaseDocumentWithAttributesInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  nevTools,
  DocumentInterfaces,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3Interfaces,
  l3InternalInterfaces,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_Tips = {final fsf} class(TvcmFormSetFactory)
   {* Советы дня }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function TextFormParentDftTipsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для TextForm }
   function AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Attributes }
   function CommonDictionNavigatorUtTipsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для CommonDiction }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_Tips;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_Tips
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


// start class Tfs_Tips

var g_Tfs_Tips : Tfs_Tips = nil;

procedure Tfs_TipsFree;
begin
 l3Free(g_Tfs_Tips);
end;

class function Tfs_Tips.Instance: Tfs_Tips;
begin
 if (g_Tfs_Tips = nil) then
 begin
  l3System.AddExitProc(Tfs_TipsFree);
  g_Tfs_Tips := Create;
 end;
 Result := g_Tfs_Tips;
end;

var
    { Локализуемые строки TipsCaptionLocalConstants }
   str_fsTipsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsTipsCaption'; rValue : '#1057#1086#1074#1077#1090 #1076#1085#1103');
    { Заголовок фабрики сборки форм "Tips" }

// start class Tfs_Tips

function Tfs_Tips.TextFormParentDftTipsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_Tips.TextFormParentDftTipsNeedMakeForm

function Tfs_Tips.AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsBaseDocumentWithAttributes;
begin
 if Supports(aDataSource, IsdsBaseDocumentWithAttributes, l_UseCase) then
  try
   aNew := l_UseCase.dsAttributes;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Tips.AttributesChildFDocAttributeNeedMakeForm

function Tfs_Tips.CommonDictionNavigatorUtTipsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsCommonDiction;
begin
 if Supports(aDataSource, IsdsCommonDiction, l_UseCase) then
  try
   aNew := l_UseCase.dsContents;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Tips.CommonDictionNavigatorUtTipsNeedMakeForm

class function Tfs_Tips.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_Tips <> nil;
end;//Tfs_Tips.Exists

procedure Tfs_Tips.InitFields;
 {-}
begin
 inherited;
 with AddZone('TextForm', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftTips;
  OnNeedMakeForm := TextFormParentDftTipsNeedMakeForm;
 end;
 with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
 begin
  UserType := fDocAttribute;
  OnNeedMakeForm := AttributesChildFDocAttributeNeedMakeForm;
 end;
 with AddZone('CommonDiction', vcm_ztNavigator, fm_en_CommonDiction) do
 begin
  UserType := utTips;
  ActivateIfUpdate := wafAlways;
  OnNeedMakeForm := CommonDictionNavigatorUtTipsNeedMakeForm;
 end;
 Caption := str_fsTipsCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_Tips.InitFields

{$If not defined(NoVCM)}
class function Tfs_Tips.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_Tips.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsTipsCaption
 str_fsTipsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.