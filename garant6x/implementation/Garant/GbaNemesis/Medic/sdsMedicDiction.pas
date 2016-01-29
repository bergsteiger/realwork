unit sdsMedicDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/sdsMedicDiction.pas"
// Начат: 2008/03/06 10:02:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TsdsMedicDiction
//
// Бизнес объект сборки "Совет дня"
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
  sdsCommonDiction,
  DocumentAndListInterfaces,
  CommonDictionInterfaces,
  DocumentInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TsdsMedicDiction = {ucc} class(TsdsCommonDiction)
  {* Бизнес объект сборки "Совет дня" }
 protected
 // realized methods
   function BaseDocumentClass: IdsBaseDocument; override;
   function MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction; override;
   function MakeContents: IdsCommonDiction; override;
     {* Создаёт область оглавления }
 protected
 // overridden protected methods
    {$If not defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
    {$IfEnd} //not NoVCM
 end;//TsdsMedicDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsMedicDictionDocument,
  dsMedicDiction,
  deMedicDiction,
  SysUtils,
  nsTabbedInterfaceTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TsdsMedicDiction

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
//#UC START# *4936BA0D0286_493D11EA0286_var*
//#UC END# *4936BA0D0286_493D11EA0286_var*
begin
//#UC START# *4936BA0D0286_493D11EA0286_impl*
 Result := TdsMedicDiction.Make(Self, MakeDocInfo(pm_GetDocInfo).Clone);
//#UC END# *4936BA0D0286_493D11EA0286_impl*
end;//TsdsMedicDiction.MakeContents

{$If not defined(NoVCM)}
function TsdsMedicDiction.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_493D11EA0286_var*
//#UC END# *53B3BF9C00EF_493D11EA0286_var*
begin
//#UC START# *53B3BF9C00EF_493D11EA0286_impl*
 Result := nsTabIconIndex(titMedicDictionary);
//#UC END# *53B3BF9C00EF_493D11EA0286_impl*
end;//TsdsMedicDiction.DoGetFormSetImageIndex
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.