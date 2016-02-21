unit sdsAutoreferat;
 {* Бизнес объект сборки "Автореферат" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\sdsAutoreferat.pas"
// Стереотип: "UseCaseControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AutoreferatInterfaces
 , DocumentAndListInterfaces
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , bsTypesNew
 , l3IID
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
 _SetDataType_ = IdBaseDocument;
 _InitDataType_ = IdeDocInfo;
 _SetType_ = IsdsAutoreferat;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocument.imp.pas}
 TsdsAutoreferat = class(_sdsBaseDocument_, IsdsAutoreferat)
  {* Бизнес объект сборки "Автореферат" }
  private
   f_MakeNewsLineFakeDS: IvcmViewAreaControllerRef;
    {* Поле для области вывода MakeNewsLineFakeDS }
  protected
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
   function BaseDocumentClass: IdsBaseDocument; override;
   function pm_GetMakeNewsLineFakeDS: IdsNewsLine;
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsAutoreferat
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsAutoreferat
 , dsNewsLine
 , dBaseDocument
 , nsTabbedInterfaceTypes
 , SysUtils
 , deDocInfo
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
;

type _Instance_R_ = TsdsAutoreferat;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocument.imp.pas}

{$If NOT Defined(NoVCM)}
function TsdsAutoreferat.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_492FDB1603A9_var*
//#UC END# *47F3778403D9_492FDB1603A9_var*
begin
//#UC START# *47F3778403D9_492FDB1603A9_impl*
 Result := TdBaseDocument.Make;
//#UC END# *47F3778403D9_492FDB1603A9_impl*
end;//TsdsAutoreferat.MakeData
{$IfEnd} // NOT Defined(NoVCM)

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
//#UC START# *492F060800A2_492FDB1603A9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *492F060800A2_492FDB1603A9get_impl*
end;//TsdsAutoreferat.pm_GetMakeNewsLineFakeDS

{$If NOT Defined(NoVCM)}
procedure TsdsAutoreferat.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_492FDB1603A9_var*
//#UC END# *47F37DF001FE_492FDB1603A9_var*
begin
//#UC START# *47F37DF001FE_492FDB1603A9_impl*
 SetData.DocInfo := InitialUseCaseData;
//#UC END# *47F37DF001FE_492FDB1603A9_impl*
end;//TsdsAutoreferat.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TsdsAutoreferat.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_492FDB1603A9_var*
//#UC END# *4938F7E702B7_492FDB1603A9_var*
begin
//#UC START# *4938F7E702B7_492FDB1603A9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_492FDB1603A9_impl*
end;//TsdsAutoreferat.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TsdsAutoreferat.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_492FDB1603A9_var*
//#UC END# *53B3BF9C00EF_492FDB1603A9_var*
begin
//#UC START# *53B3BF9C00EF_492FDB1603A9_impl*
 Result := nsTabIconIndex(titPrime);
//#UC END# *53B3BF9C00EF_492FDB1603A9_impl*
end;//TsdsAutoreferat.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
