unit sdsTips;
 {* Бизнес объект сборки "Совет дня" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\DayTips\sdsTips.pas"
// Стереотип: "UseCaseControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 TsdsTips = class(TsdsCommonDiction)
  {* Бизнес объект сборки "Совет дня" }
  protected
   function BaseDocumentClass: IdsBaseDocument; override;
   function MakeDocInfo(const aSource: IdeDocInfo): IdeCommonDiction; override;
   function MakeContents: IdsCommonDiction; override;
    {* Создаёт область оглавления }
 end;//TsdsTips
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsTipsDocument
 , dsTips
 , deTips
 , SysUtils
;

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
 {* Создаёт область оглавления }
//#UC START# *4936BA0D0286_493D0AFD02F6_var*
//#UC END# *4936BA0D0286_493D0AFD02F6_var*
begin
//#UC START# *4936BA0D0286_493D0AFD02F6_impl*
 Result := TdsTips.Make(Self, MakeDocInfo(pm_GetDocInfo).Clone);
//#UC END# *4936BA0D0286_493D0AFD02F6_impl*
end;//TsdsTips.MakeContents
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
