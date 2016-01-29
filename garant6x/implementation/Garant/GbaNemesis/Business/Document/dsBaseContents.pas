unit dsBaseContents;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsBaseContents.pas"
// Начат: 26.11.2008 20:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::BaseDocument::TdsBaseContents
//
// Простое оглавление
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
  DocumentAndListInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  bsInterfaces
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TreeInterfaces
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
  l3NotifyPtrList
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  DocumentInterfaces,
  DocumentUnit,
  F1TagDataProviderInterface,
  nsTypesNew,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsBaseContents;
 {$Include ..\Document\dsBaseContents.imp.pas}
 TdsBaseContents = {vac} class(_dsBaseContents_)
  {* Простое оглавление }
 protected
 // realized methods
   function MakeSimpleTree: Il3SimpleTree; override;
     {* Создать данные дерева }
 end;//TdsBaseContents
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  vtUtils,
  DocumentRes,
  l3String
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  dsBaseContentsRes,
  SysUtils,
  l3Base,
  vtStdRes,
  DynamicTreeUnit,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  {$If defined(Nemesis)}
  ,
  nscContextFilterState
  {$IfEnd} //Nemesis
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsBaseContents;

{$Include ..\Document\dsBaseContents.imp.pas}

// start class TdsBaseContents

function TdsBaseContents.MakeSimpleTree: Il3SimpleTree;
//#UC START# *47F4C2B9014A_492D854C0189_var*
//#UC END# *47F4C2B9014A_492D854C0189_var*
begin
//#UC START# *47F4C2B9014A_492D854C0189_impl*
  Result := nil;

  // Отключаем Assert, см:
  // http://mdp.garant.ru/pages/viewpage.action?pageId=303858407
  // http://mdp.garant.ru/pages/viewpage.action?pageId=297704301

  // Assert(false);

  // На будущее надо еще посмотреть, см. задачу:
  // http://mdp.garant.ru/pages/viewpage.action?pageId=320742140

// Если попадём сюда, то читаем http://mdp.garant.ru/pages/viewpage.action?pageId=135605187
//#UC END# *47F4C2B9014A_492D854C0189_impl*
end;//TdsBaseContents.MakeSimpleTree

{$IfEnd} //not Admin AND not Monitorings

end.