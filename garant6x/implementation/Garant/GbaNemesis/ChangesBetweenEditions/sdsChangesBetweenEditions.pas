unit sdsChangesBetweenEditions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChangesBetweenEditions$Domain"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/ChangesBetweenEditions/sdsChangesBetweenEditions.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::ChangesBetweenEditions$Domain::ChangesBetweenEditionsImplementation::TsdsChangesBetweenEditions
//
// Прецедент ОИД
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
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  ChangesBetweenEditionsInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  DocumentAndListInterfaces {a},
  DocumentUnit,
  nevTools,
  DocumentInterfaces,
  l3TreeInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _InitDataType_ = InsChangesBetweenEditionsInfo;
 _SetDataType_ = IsdsChangesBetweenEditionsData;
 _SetType_ = IsdsChangesBetweenEditions;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}
 TsdsChangesBetweenEditions = {final ucc} class(_vcmFormSetDataSource_, IsdsChangesBetweenEditions, IsdsPrimDocument {from IsdsChangesBetweenEditions}, IsdsEditionsHolder {from IsdsChangesBetweenEditions})
  {* Прецедент ОИД }
 private
 // private fields
   f_Changes : IvcmViewAreaControllerRef;
    {* Поле для области вывода Changes}
   f_EditionsList : IvcmViewAreaControllerRef;
    {* Поле для области вывода EditionsList}
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
   function pm_GetChanges: IdsChangesBetweenEditions;
   function DoGet_Changes: IdsChangesBetweenEditions;
   function pm_GetDocInfo: IdeDocInfo;
   function pm_GetEditionsList: IdsEditions;
   function DoGet_EditionsList: IdsEditions;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
    {$IfEnd} //not NoVCM
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IsdsPrimDocument: IsdsPrimDocument;
   function As_IsdsEditionsHolder: IsdsEditionsHolder;
 end;//TsdsChangesBetweenEditions
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsChangesBetweenEditions,
  sdsChangesBetweenEditionsData,
  deDocInfo,
  dsEditions,
  nsTabbedInterfaceTypes
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  SysUtils,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsChangesBetweenEditions;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}

// start class TsdsChangesBetweenEditions

{$If not defined(NoVCM)}
function TsdsChangesBetweenEditions.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_4DDCD7D0002E_var*
//#UC END# *47F3778403D9_4DDCD7D0002E_var*
begin
//#UC START# *47F3778403D9_4DDCD7D0002E_impl*
 Result := TsdsChangesBetweenEditionsData.Make(InitialUseCaseData);
//#UC END# *47F3778403D9_4DDCD7D0002E_impl*
end;//TsdsChangesBetweenEditions.MakeData
{$IfEnd} //not NoVCM

function TsdsChangesBetweenEditions.pm_GetChanges: IdsChangesBetweenEditions;
//#UC START# *4DDCD7520351_4DDCD7D0002Eget_var*
//#UC END# *4DDCD7520351_4DDCD7D0002Eget_var*
begin
 if (f_Changes = nil) then
 begin
  f_Changes := TvcmViewAreaControllerRef.Make;
  //#UC START# *4DDCD7520351_4DDCD7D0002Eget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4DDCD7520351_4DDCD7D0002Eget_init*
 end;//f_Changes = nil
 if f_Changes.IsEmpty
  //#UC START# *4DDCD7520351_4DDCD7D0002Eget_need*
  // - условие создания ViewArea
  //#UC END# *4DDCD7520351_4DDCD7D0002Eget_need*
  then
   f_Changes.Referred := DoGet_Changes;
 Result := IdsChangesBetweenEditions(f_Changes.Referred);
end;

function TsdsChangesBetweenEditions.DoGet_Changes: IdsChangesBetweenEditions;
//#UC START# *4DDCD7520351_4DDCD7D0002Earea_var*
//#UC END# *4DDCD7520351_4DDCD7D0002Earea_var*
begin
//#UC START# *4DDCD7520351_4DDCD7D0002Earea_impl*
 Result := TdsChangesBetweenEditions.Make(Self, InitialUseCaseData);
//#UC END# *4DDCD7520351_4DDCD7D0002Earea_impl*
end;//TsdsChangesBetweenEditions.DoGet_Changes

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
 if (f_EditionsList = nil) then
 begin
  f_EditionsList := TvcmViewAreaControllerRef.Make;
  //#UC START# *4ED906420134_4DDCD7D0002Eget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4ED906420134_4DDCD7D0002Eget_init*
 end;//f_EditionsList = nil
 if f_EditionsList.IsEmpty
  //#UC START# *4ED906420134_4DDCD7D0002Eget_need*
  // - условие создания ViewArea
  //#UC END# *4ED906420134_4DDCD7D0002Eget_need*
  then
   f_EditionsList.Referred := DoGet_EditionsList;
 Result := IdsEditions(f_EditionsList.Referred);
end;

function TsdsChangesBetweenEditions.DoGet_EditionsList: IdsEditions;
//#UC START# *4ED906420134_4DDCD7D0002Earea_var*
//#UC END# *4ED906420134_4DDCD7D0002Earea_var*
begin
//#UC START# *4ED906420134_4DDCD7D0002Earea_impl*
 Result := TdsEditions.Make(Self);
//#UC END# *4ED906420134_4DDCD7D0002Earea_impl*
end;//TsdsChangesBetweenEditions.DoGet_EditionsList

{$If not defined(NoVCM)}
procedure TsdsChangesBetweenEditions.ClearAreas;
 {-}
begin
 if (f_Changes <> nil) then f_Changes.Referred := nil;
 if (f_EditionsList <> nil) then f_EditionsList.Referred := nil;
 inherited;
end;//TsdsChangesBetweenEditions.ClearAreas
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TsdsChangesBetweenEditions.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_4DDCD7D0002E_var*
//#UC END# *53B3BF9C00EF_4DDCD7D0002E_var*
begin
//#UC START# *53B3BF9C00EF_4DDCD7D0002E_impl*
 Result := nsTabIconIndex(titChangesBetweenEditions);
//#UC END# *53B3BF9C00EF_4DDCD7D0002E_impl*
end;//TsdsChangesBetweenEditions.DoGetFormSetImageIndex
{$IfEnd} //not NoVCM

// Методы преобразования к реализуемым интерфейсам

function TsdsChangesBetweenEditions.As_IsdsPrimDocument: IsdsPrimDocument;
begin
 Result := Self;
end;

function TsdsChangesBetweenEditions.As_IsdsEditionsHolder: IsdsEditionsHolder;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

end.