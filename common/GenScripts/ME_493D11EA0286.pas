unit sdsMedicDiction;
 {* Бизнес объект сборки "Совет дня" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicDiction.pas"
// Стереотип: "UseCaseControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , sdsCommonDiction
 , DocumentAndListInterfaces
 , CommonDictionInterfaces
 , DocumentInterfaces
;

type
 TsdsMedicDiction = class(TsdsCommonDiction)
  {* Бизнес объект сборки "Совет дня" }
  protected
   function BaseDocumentClass: IdsBaseDocument; override;
   function MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction; override;
   function MakeContents: IdsCommonDiction; override;
    {* Создаёт область оглавления }
   {$If NOT Defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsMedicDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsMedicDictionDocument
 , dsMedicDiction
 , deMedicDiction
 , SysUtils
 , nsTabbedInterfaceTypes
;

function TsdsMedicDiction.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_493D11EA0286_var*
//#UC END# *4925B1EC0100_493D11EA0286_var*
begin
//#UC START# *4925B1EC0100_493D11EA0286_impl*
 Result := TdsMedicDictionDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_493D11EA0286_impl*
end;//TsdsMedicDiction.BaseDocumentClass

function TsdsMedicDiction.MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction;
//#UC START# *4936B89C037F_493D11EA0286_var*
//#UC END# *4936B89C037F_493D11EA0286_var*
begin
//#UC START# *4936B89C037F_493D11EA0286_impl*
 if not Supports(aSource, IdeCommonDiction, Result) then
  Result := TdeMedicDiction.Convert(aSource);
//#UC END# *4936B89C037F_493D11EA0286_impl*
end;//TsdsMedicDiction.MakeDocInfo

function TsdsMedicDiction.MakeContents: IdsCommonDiction;
 {* Создаёт область оглавления }
//#UC START# *4936BA0D0286_493D11EA0286_var*
//#UC END# *4936BA0D0286_493D11EA0286_var*
begin
//#UC START# *4936BA0D0286_493D11EA0286_impl*
 Result := TdsMedicDiction.Make(Self, MakeDocInfo(pm_GetDocInfo).Clone);
//#UC END# *4936BA0D0286_493D11EA0286_impl*
end;//TsdsMedicDiction.MakeContents

{$If NOT Defined(NoVCM)}
function TsdsMedicDiction.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_493D11EA0286_var*
//#UC END# *53B3BF9C00EF_493D11EA0286_var*
begin
//#UC START# *53B3BF9C00EF_493D11EA0286_impl*
 Result := nsTabIconIndex(titMedicDictionary);
//#UC END# *53B3BF9C00EF_493D11EA0286_impl*
end;//TsdsMedicDiction.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
