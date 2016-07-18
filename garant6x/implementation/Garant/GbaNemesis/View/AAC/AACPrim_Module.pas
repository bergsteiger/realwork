unit AACPrim_Module;
 {* Реализация прецедента "Актуальная аналитика". [RequestLink:365838080] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\AACPrim_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "AACPrim" MUID: (4FF2E5C70060)
// Имя типа: "TAACPrimModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TAACPrimModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Реализация прецедента "Актуальная аналитика". [RequestLink:365838080] }
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class procedure MakeAAC(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Создаёт сборку для документа ААК }
   class procedure MakeAACContents(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Создаёт сборку для документа ОГЛАВЛЕНИЯ ААК }
 end;//TAACPrimModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , sdsAAC
 , AACContainer_Form
 , AACContentsContainer_Form
 , fsAACContents
 , fsAAC
 //#UC START# *4FF2E5C70060impl_uses*
 //#UC END# *4FF2E5C70060impl_uses*
;

{$If NOT Defined(NoVCM)}
class procedure TAACPrimModule.MakeAAC(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Создаёт сборку для документа ААК }
var
 __WasEnter : Boolean;
//#UC START# *4FF3FEC70302_4FF2E5C70060_var*
//#UC END# *4FF3FEC70302_4FF2E5C70060_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4FF3FEC70302_4FF2E5C70060_impl*
  Tfs_AAC.Make(TsdsAAC.Make(aDocInfo), CheckContainer(aContainer));
//#UC END# *4FF3FEC70302_4FF2E5C70060_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TAACPrimModule.MakeAAC

class procedure TAACPrimModule.MakeAACContents(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Создаёт сборку для документа ОГЛАВЛЕНИЯ ААК }
var
 __WasEnter : Boolean;
//#UC START# *4FF428150001_4FF2E5C70060_var*
//#UC END# *4FF428150001_4FF2E5C70060_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4FF428150001_4FF2E5C70060_impl*
  Tfs_AACContents.Make(TsdsAAC.Make(aDocInfo), CheckContainer(aContainer));
//#UC END# *4FF428150001_4FF2E5C70060_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TAACPrimModule.MakeAACContents

class procedure TAACPrimModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TAACContainerForm);
 aList.Add(TAACContentsContainerForm);
end;//TAACPrimModule.GetEntityForms
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
