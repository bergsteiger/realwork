unit sdsAutoreferat;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Autoreferat"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/sdsAutoreferat.pas"
// Начат: 2005/10/06 12:32:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Пользовательские сервисы::Autoreferat::Autoreferat::Autoreferat::TsdsAutoreferat
//
// Бизнес объект сборки "Автореферат"
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
  AutoreferatInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  DocumentInterfaces,
  DocumentUnit,
  bsTypesNew
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
  l3IID,
  nevTools,
  bsTypes,
  afwInterfaces,
  FoldersDomainInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetDataType_ = IdBaseDocument;
 _InitDataType_ = IdeDocInfo;
 _SetType_ = IsdsAutoreferat;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocument.imp.pas}
 TsdsAutoreferat = {ucc} class(_sdsBaseDocument_, IsdsAutoreferat)
  {* Бизнес объект сборки "Автореферат" }
 private
 // private fields
   f_MakeNewsLineFakeDS : IvcmViewAreaControllerRef;
    {* Поле для области вывода MakeNewsLineFakeDS}
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
   function BaseDocumentClass: IdsBaseDocument; override;
   function pm_GetMakeNewsLineFakeDS: IdsNewsLine;
   function DoGet_MakeNewsLineFakeDS: IdsNewsLine;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DataExchange; override;
     {* - вызывается после получения данных инициализации. }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
    {$IfEnd} //not NoVCM
 end;//TsdsAutoreferat
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsAutoreferat,
  dsNewsLine,
  dBaseDocument,
  nsTabbedInterfaceTypes,
  SysUtils,
  deDocInfo,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsAutoreferat;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocument.imp.pas}

// start class TsdsAutoreferat

{$If not defined(NoVCM)}
function TsdsAutoreferat.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_492FDB1603A9_var*
//#UC END# *47F3778403D9_492FDB1603A9_var*
begin
//#UC START# *47F3778403D9_492FDB1603A9_impl*
 Result := TdBaseDocument.Make;
//#UC END# *47F3778403D9_492FDB1603A9_impl*
end;//TsdsAutoreferat.MakeData
{$IfEnd} //not NoVCM

function TsdsAutoreferat.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_492FDB1603A9_var*
//#UC END# *4925B1EC0100_492FDB1603A9_var*
begin
//#UC START# *4925B1EC0100_492FDB1603A9_impl*
 Result := TdsAutoreferat.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_492FDB1603A9_impl*
end;//TsdsAutoreferat.BaseDocumentClass

function TsdsAutoreferat.pm_GetMakeNewsLineFakeDS: IdsNewsLine;
//#UC START# *492F060800A2_492FDB1603A9get_var*
//#UC END# *492F060800A2_492FDB1603A9get_var*
begin
 if (f_MakeNewsLineFakeDS = nil) then
 begin
  f_MakeNewsLineFakeDS := TvcmViewAreaControllerRef.Make;
  //#UC START# *492F060800A2_492FDB1603A9get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492F060800A2_492FDB1603A9get_init*
 end;//f_MakeNewsLineFakeDS = nil
 if f_MakeNewsLineFakeDS.IsEmpty
  //#UC START# *492F060800A2_492FDB1603A9get_need*
  // - условие создания ViewArea
  //#UC END# *492F060800A2_492FDB1603A9get_need*
  then
   f_MakeNewsLineFakeDS.Referred := DoGet_MakeNewsLineFakeDS;
 Result := IdsNewsLine(f_MakeNewsLineFakeDS.Referred);
end;

function TsdsAutoreferat.DoGet_MakeNewsLineFakeDS: IdsNewsLine;
//#UC START# *492F060800A2_492FDB1603A9area_var*
//#UC END# *492F060800A2_492FDB1603A9area_var*
begin
//#UC START# *492F060800A2_492FDB1603A9area_impl*
 Result := TdsNewsLine.Make(Self);
//#UC END# *492F060800A2_492FDB1603A9area_impl*
end;//TsdsAutoreferat.DoGet_MakeNewsLineFakeDS

{$If not defined(NoVCM)}
procedure TsdsAutoreferat.DataExchange;
//#UC START# *47F37DF001FE_492FDB1603A9_var*
//#UC END# *47F37DF001FE_492FDB1603A9_var*
begin
//#UC START# *47F37DF001FE_492FDB1603A9_impl*
 SetData.DocInfo := InitialUseCaseData;
//#UC END# *47F37DF001FE_492FDB1603A9_impl*
end;//TsdsAutoreferat.DataExchange
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TsdsAutoreferat.ClearAreas;
 {-}
begin
 if (f_MakeNewsLineFakeDS <> nil) then f_MakeNewsLineFakeDS.Referred := nil;
 inherited;
end;//TsdsAutoreferat.ClearAreas
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TsdsAutoreferat.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_492FDB1603A9_var*
//#UC END# *53B3BF9C00EF_492FDB1603A9_var*
begin
//#UC START# *53B3BF9C00EF_492FDB1603A9_impl*
 Result := nsTabIconIndex(titPrime);
//#UC END# *53B3BF9C00EF_492FDB1603A9_impl*
end;//TsdsAutoreferat.DoGetFormSetImageIndex
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.