unit dsEditionsContainerData;
 {* Контейнер для сравниваемых редакций }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsEditionsContainerData.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsEditionsContainerData" MUID: (4A717F6E0327)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , EditionsInterfaces
 , l3Interfaces
 , DocumentUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
;

type
 _InitDataType_ = InsEditionsContainerData;
 _FormDataSourceType_ = IdsEditionsContainerData;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsEdition.imp.pas}
 TdsEditionsContainerData = {final} class(_dsEdition_, IdsEditionsContainerData)
  {* Контейнер для сравниваемых редакций }
  protected
   function Get_DocumentNameForCaption: Il3CString;
   function Get_ChangedParas: IDiffIterator;
   function Get_Right: IdsRightEdition;
   function Get_Left: IdsLeftEdition;
   function Get_DocumentFullNameForCaption: Il3CString;
 end;//TdsEditionsContainerData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsTypes
 , IOUnit
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

type _Instance_R_ = TdsEditionsContainerData;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsEdition.imp.pas}

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
