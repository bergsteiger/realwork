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
 end;//TAACPrimModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , sdsAAC
 , SysUtils
 , l3Base
 , AACContainer_Form
 , AACContentsContainer_Form
 , fsAACContents
 , fsAAC
 //#UC START# *4FF2E5C70060impl_uses*
 //#UC END# *4FF2E5C70060impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TAACServiceImpl = {final} class(TvcmModuleContractImplementation, IAACService)
  public
   procedure MakeAAC(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Создаёт сборку для документа ААК }
   procedure MakeAACContents(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Создаёт сборку для документа ОГЛАВЛЕНИЯ ААК }
   class function Instance: TAACServiceImpl;
    {* Метод получения экземпляра синглетона TAACServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TAACServiceImpl

var g_TAACServiceImpl: TAACServiceImpl = nil;
 {* Экземпляр синглетона TAACServiceImpl }

procedure TAACServiceImplFree;
 {* Метод освобождения экземпляра синглетона TAACServiceImpl }
begin
 l3Free(g_TAACServiceImpl);
end;//TAACServiceImplFree

procedure TAACServiceImpl.MakeAAC(const aDocInfo: IdeDocInfo;
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
end;//TAACServiceImpl.MakeAAC

procedure TAACServiceImpl.MakeAACContents(const aDocInfo: IdeDocInfo;
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
end;//TAACServiceImpl.MakeAACContents

class function TAACServiceImpl.Instance: TAACServiceImpl;
 {* Метод получения экземпляра синглетона TAACServiceImpl }
begin
 if (g_TAACServiceImpl = nil) then
 begin
  l3System.AddExitProc(TAACServiceImplFree);
  g_TAACServiceImpl := Create;
 end;
 Result := g_TAACServiceImpl;
end;//TAACServiceImpl.Instance

class function TAACServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TAACServiceImpl <> nil;
end;//TAACServiceImpl.Exists

class procedure TAACPrimModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TAACContainerForm);
 aList.Add(TAACContentsContainerForm);
end;//TAACPrimModule.GetEntityForms

initialization
 TAACService.Instance.Alien := TAACServiceImpl.Instance;
 {* Регистрация TAACServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
