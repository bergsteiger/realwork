unit dsEditionsContainerData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/dsEditionsContainerData.pas"
// Начат: 30.07.2009 15:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::Editions::TdsEditionsContainerData
//
// Контейнер для сравниваемых редакций
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
  EditionsInterfaces
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
  vcmControllers {a},
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsEditionsContainerData;
 _InitDataType_ = InsEditionsContainerData;
 {$Include ..\Editions\dsEdition.imp.pas}
 TdsEditionsContainerData = {final vac} class(_dsEdition_, IdsEditionsContainerData)
  {* Контейнер для сравниваемых редакций }
 protected
 // realized methods
   function Get_DocumentNameForCaption: Il3CString;
   function Get_ChangedParas: IDiffIterator;
   function Get_Right: IdsRightEdition;
   function Get_Left: IdsLeftEdition;
   function Get_DocumentFullNameForCaption: Il3CString;
 end;//TdsEditionsContainerData
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsTypes,
  IOUnit,
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsEditionsContainerData;

{$Include ..\Editions\dsEdition.imp.pas}

// start class TdsEditionsContainerData

function TdsEditionsContainerData.Get_DocumentNameForCaption: Il3CString;
//#UC START# *4A800ED00011_4A717F6E0327get_var*
var
 l_S : IString;
//#UC END# *4A800ED00011_4A717F6E0327get_var*
begin
//#UC START# *4A800ED00011_4A717F6E0327get_impl*
 Assert(PartData <> nil);
 PartData.Document.GetShortName(l_S);
 Result := nsCStr(l_S);
//#UC END# *4A800ED00011_4A717F6E0327get_impl*
end;//TdsEditionsContainerData.Get_DocumentNameForCaption

function TdsEditionsContainerData.Get_ChangedParas: IDiffIterator;
//#UC START# *4B4F2EAD0183_4A717F6E0327get_var*
//#UC END# *4B4F2EAD0183_4A717F6E0327get_var*
begin
//#UC START# *4B4F2EAD0183_4A717F6E0327get_impl*
 Assert(PartData <> nil);
 Result := ucc_CompareEditions.ChangedParas;
//#UC END# *4B4F2EAD0183_4A717F6E0327get_impl*
end;//TdsEditionsContainerData.Get_ChangedParas

function TdsEditionsContainerData.Get_Right: IdsRightEdition;
//#UC START# *4DDCC27802BA_4A717F6E0327get_var*
//#UC END# *4DDCC27802BA_4A717F6E0327get_var*
begin
//#UC START# *4DDCC27802BA_4A717F6E0327get_impl*
 Result := ucc_CompareEditions.Right;
//#UC END# *4DDCC27802BA_4A717F6E0327get_impl*
end;//TdsEditionsContainerData.Get_Right

function TdsEditionsContainerData.Get_Left: IdsLeftEdition;
//#UC START# *4DDCC30E0361_4A717F6E0327get_var*
//#UC END# *4DDCC30E0361_4A717F6E0327get_var*
begin
//#UC START# *4DDCC30E0361_4A717F6E0327get_impl*
 Result := ucc_CompareEditions.Left;
//#UC END# *4DDCC30E0361_4A717F6E0327get_impl*
end;//TdsEditionsContainerData.Get_Left

function TdsEditionsContainerData.Get_DocumentFullNameForCaption: Il3CString;
//#UC START# *54743B1A00AC_4A717F6E0327get_var*
var
 l_S: IString;
//#UC END# *54743B1A00AC_4A717F6E0327get_var*
begin
//#UC START# *54743B1A00AC_4A717F6E0327get_impl*
 Assert(PartData <> nil);
 PartData.Document.GetName(l_S);
 Result := nsCStr(l_S);
//#UC END# *54743B1A00AC_4A717F6E0327get_impl*
end;//TdsEditionsContainerData.Get_DocumentFullNameForCaption

{$IfEnd} //not Admin AND not Monitorings

end.