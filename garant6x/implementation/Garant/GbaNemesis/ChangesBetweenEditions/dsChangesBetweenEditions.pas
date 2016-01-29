unit dsChangesBetweenEditions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChangesBetweenEditions$Domain"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/ChangesBetweenEditions/dsChangesBetweenEditions.pas"
// Начат: 25.05.2011 14:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::ChangesBetweenEditions$Domain::ChangesBetweenEditionsImplementation::TdsChangesBetweenEditions
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
  nevTools,
  DocumentAndListInterfaces,
  l3StringIDEx,
  ChangesBetweenEditionsInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  DocumentUnit,
  DocumentInterfaces,
  afwInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _InitDataType_ = InsChangesBetweenEditionsInfo;
 _FormDataSourceType_ = IdsChangesBetweenEditions;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 _deDocInfoProvider_Parent_ = _vcmFormDataSource_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Presentation\deDocInfoProvider.imp.pas}
 TdsChangesBetweenEditions = {vac} class(_deDocInfoProvider_, IucpHAFMacroReplacerFactory, IdsChangesBetweenEditions)
 private
 // private fields
   f_Cont : InevDocumentContainer;
 protected
 // realized methods
   function MakeHAFMacroReplacer: IafwHAFMacroReplacer;
   function Get_RightEdition: IDocument;
   function Get_DocumentContainer: InevDocumentContainer;
   function Get_LeftEdition: IDocument;
   function DocumentForDocInfoProvider: IDocument; override;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//TdsChangesBetweenEditions
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsChangesBetweenEditionsDocumentContainer,
  evFormatHAFMacroReplacer,
  nsDocInfoHAFMacroReplacer,
  IOUnit,
  nsTypes,
  l3String,
  l3MessageID,
  l3InterfacesMisc,
  SysUtils,
  l3Base,
  deDocInfo
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsChangesBetweenEditions;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Presentation\deDocInfoProvider.imp.pas}

var
   { Локализуемые строки Обзор изменений документа }
  str_cnevChangesBetweenEditions : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cnevChangesBetweenEditions'; rValue : 'Обзор изменений документа: ');
   { 'Обзор изменений документа: ' }

// start class TdsChangesBetweenEditions

function TdsChangesBetweenEditions.MakeHAFMacroReplacer: IafwHAFMacroReplacer;
//#UC START# *4AE56DE80093_4DDCDD68019E_var*
var
 l_IDocName: IString;
 l_DocName: Tl3WString;
//#UC END# *4AE56DE80093_4DDCDD68019E_var*
begin
//#UC START# *4AE56DE80093_4DDCDD68019E_impl*
 Get_RightEdition.GetName(l_IDocName);
 l_DocName := nsWStr(l_IDocName);

 Result := TevFormatHAFMacroReplacer.Make(TnsDocInfoHAFMacroReplacer.Make(nil, Self.pm_GetDocInfo),
                                          l3Cat(str_cnevChangesBetweenEditions.AsCStr, l_DocName));
//#UC END# *4AE56DE80093_4DDCDD68019E_impl*
end;//TdsChangesBetweenEditions.MakeHAFMacroReplacer

function TdsChangesBetweenEditions.Get_RightEdition: IDocument;
//#UC START# *4DDCE9110130_4DDCDD68019Eget_var*
//#UC END# *4DDCE9110130_4DDCDD68019Eget_var*
begin
//#UC START# *4DDCE9110130_4DDCDD68019Eget_impl*
 Result := PartData.RightEdition;
//#UC END# *4DDCE9110130_4DDCDD68019Eget_impl*
end;//TdsChangesBetweenEditions.Get_RightEdition

function TdsChangesBetweenEditions.Get_DocumentContainer: InevDocumentContainer;
//#UC START# *4DDD0C170344_4DDCDD68019Eget_var*
//#UC END# *4DDD0C170344_4DDCDD68019Eget_var*
begin
//#UC START# *4DDD0C170344_4DDCDD68019Eget_impl*
 if (f_Cont = nil) then
  f_Cont := TnsChangesBetweenEditionsDocumentContainer.Make(PartData);
 Result := f_Cont;
//#UC END# *4DDD0C170344_4DDCDD68019Eget_impl*
end;//TdsChangesBetweenEditions.Get_DocumentContainer

function TdsChangesBetweenEditions.Get_LeftEdition: IDocument;
//#UC START# *4F2BF187026F_4DDCDD68019Eget_var*
//#UC END# *4F2BF187026F_4DDCDD68019Eget_var*
begin
//#UC START# *4F2BF187026F_4DDCDD68019Eget_impl*
 Result := PartData.LeftEdition;
//#UC END# *4F2BF187026F_4DDCDD68019Eget_impl*
end;//TdsChangesBetweenEditions.Get_LeftEdition

function TdsChangesBetweenEditions.DocumentForDocInfoProvider: IDocument;
//#UC START# *4F548A0D0096_4DDCDD68019E_var*
//#UC END# *4F548A0D0096_4DDCDD68019E_var*
begin
//#UC START# *4F548A0D0096_4DDCDD68019E_impl*
 Result := Get_RightEdition;
//#UC END# *4F548A0D0096_4DDCDD68019E_impl*
end;//TdsChangesBetweenEditions.DocumentForDocInfoProvider

procedure TdsChangesBetweenEditions.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Cont := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdsChangesBetweenEditions.ClearFields

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_cnevChangesBetweenEditions
 str_cnevChangesBetweenEditions.Init;
{$IfEnd} //not Admin AND not Monitorings

end.