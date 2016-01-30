unit sdsChangesBetweenEditions;
 {* Прецедент ОИД }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\sdsChangesBetweenEditions.pas"
// Стереотип: "UseCaseControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ChangesBetweenEditionsInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentInterfaces
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _InitDataType_ = InsChangesBetweenEditionsInfo;
 _SetDataType_ = IsdsChangesBetweenEditionsData;
 _SetType_ = IsdsChangesBetweenEditions;
 {$Include vcmFormSetDataSource.imp.pas}
 TsdsChangesBetweenEditions = {final} class(_vcmFormSetDataSource_, IsdsChangesBetweenEditions, IsdsPrimDocument, IsdsEditionsHolder)
  {* Прецедент ОИД }
  private
   f_Changes: IvcmViewAreaControllerRef;
    {* Поле для области вывода Changes }
   f_EditionsList: IvcmViewAreaControllerRef;
    {* Поле для области вывода EditionsList }
  protected
   function As_IsdsPrimDocument: IsdsPrimDocument;
    {* Метод приведения нашего интерфейса к IsdsPrimDocument }
   function As_IsdsEditionsHolder: IsdsEditionsHolder;
    {* Метод приведения нашего интерфейса к IsdsEditionsHolder }
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
   function pm_GetChanges: IdsChangesBetweenEditions;
   function pm_GetDocInfo: IdeDocInfo;
   function pm_GetEditionsList: IdsEditions;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsChangesBetweenEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsChangesBetweenEditions
 , sdsChangesBetweenEditionsData
 , deDocInfo
 , dsEditions
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
;

type _Instance_R_ = TsdsChangesBetweenEditions;

{$Include vcmFormSetDataSource.imp.pas}

function TsdsChangesBetweenEditions.As_IsdsPrimDocument: IsdsPrimDocument;
 {* Метод приведения нашего интерфейса к IsdsPrimDocument }
begin
 Result := Self;
end;//TsdsChangesBetweenEditions.As_IsdsPrimDocument

function TsdsChangesBetweenEditions.As_IsdsEditionsHolder: IsdsEditionsHolder;
 {* Метод приведения нашего интерфейса к IsdsEditionsHolder }
begin
 Result := Self;
end;//TsdsChangesBetweenEditions.As_IsdsEditionsHolder

{$If NOT Defined(NoVCM)}
function TsdsChangesBetweenEditions.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_4DDCD7D0002E_var*
//#UC END# *47F3778403D9_4DDCD7D0002E_var*
begin
//#UC START# *47F3778403D9_4DDCD7D0002E_impl*
 Result := TsdsChangesBetweenEditionsData.Make(InitialUseCaseData);
//#UC END# *47F3778403D9_4DDCD7D0002E_impl*
end;//TsdsChangesBetweenEditions.MakeData
{$IfEnd} // NOT Defined(NoVCM)

function TsdsChangesBetweenEditions.pm_GetChanges: IdsChangesBetweenEditions;
//#UC START# *4DDCD7520351_4DDCD7D0002Eget_var*
//#UC END# *4DDCD7520351_4DDCD7D0002Eget_var*
begin
//#UC START# *4DDCD7520351_4DDCD7D0002Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDCD7520351_4DDCD7D0002Eget_impl*
end;//TsdsChangesBetweenEditions.pm_GetChanges

function TsdsChangesBetweenEditions.pm_GetDocInfo: IdeDocInfo;
//#UC START# *4DF9D63B0360_4DDCD7D0002Eget_var*
//#UC END# *4DF9D63B0360_4DDCD7D0002Eget_var*
begin
//#UC START# *4DF9D63B0360_4DDCD7D0002Eget_impl*
 Result := TdeDocInfo.Make(InitialUseCaseData.RightEdition);
//#UC END# *4DF9D63B0360_4DDCD7D0002Eget_impl*
end;//TsdsChangesBetweenEditions.pm_GetDocInfo

function TsdsChangesBetweenEditions.pm_GetEditionsList: IdsEditions;
//#UC START# *4ED906420134_4DDCD7D0002Eget_var*
//#UC END# *4ED906420134_4DDCD7D0002Eget_var*
begin
//#UC START# *4ED906420134_4DDCD7D0002Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ED906420134_4DDCD7D0002Eget_impl*
end;//TsdsChangesBetweenEditions.pm_GetEditionsList

{$If NOT Defined(NoVCM)}
procedure TsdsChangesBetweenEditions.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_4DDCD7D0002E_var*
//#UC END# *4938F7E702B7_4DDCD7D0002E_var*
begin
//#UC START# *4938F7E702B7_4DDCD7D0002E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_4DDCD7D0002E_impl*
end;//TsdsChangesBetweenEditions.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TsdsChangesBetweenEditions.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_4DDCD7D0002E_var*
//#UC END# *53B3BF9C00EF_4DDCD7D0002E_var*
begin
//#UC START# *53B3BF9C00EF_4DDCD7D0002E_impl*
 Result := nsTabIconIndex(titChangesBetweenEditions);
//#UC END# *53B3BF9C00EF_4DDCD7D0002E_impl*
end;//TsdsChangesBetweenEditions.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
