unit sdsTips;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DayTips"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/DayTips/sdsTips.pas"
// Начат: 2008/02/20 13:01:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Интерфейсные элементы::DayTips::DayTips::DayTips::TsdsTips
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
 TsdsTips = {ucc} class(TsdsCommonDiction)
  {* Бизнес объект сборки "Совет дня" }
 protected
 // realized methods
   function BaseDocumentClass: IdsBaseDocument; override;
   function MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction; override;
   function MakeContents: IdsCommonDiction; override;
     {* Создаёт область оглавления }
 end;//TsdsTips
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsTipsDocument,
  dsTips,
  deTips,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TsdsTips

function TsdsTips.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_493D0AFD02F6_var*
//#UC END# *4925B1EC0100_493D0AFD02F6_var*
begin
//#UC START# *4925B1EC0100_493D0AFD02F6_impl*
 Result := TdsTipsDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_493D0AFD02F6_impl*
end;//TsdsTips.BaseDocumentClass

function TsdsTips.MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction;
//#UC START# *4936B89C037F_493D0AFD02F6_var*
//#UC END# *4936B89C037F_493D0AFD02F6_var*
begin
//#UC START# *4936B89C037F_493D0AFD02F6_impl*
 if not Supports(aSource, IdeCommonDiction, Result) then
  Result := TdeTips.Convert(aSource);
//#UC END# *4936B89C037F_493D0AFD02F6_impl*
end;//TsdsTips.MakeDocInfo

function TsdsTips.MakeContents: IdsCommonDiction;
//#UC START# *4936BA0D0286_493D0AFD02F6_var*
//#UC END# *4936BA0D0286_493D0AFD02F6_var*
begin
//#UC START# *4936BA0D0286_493D0AFD02F6_impl*
 Result := TdsTips.Make(Self, MakeDocInfo(pm_GetDocInfo).Clone);
//#UC END# *4936BA0D0286_493D0AFD02F6_impl*
end;//TsdsTips.MakeContents

{$IfEnd} //not Admin AND not Monitorings

end.