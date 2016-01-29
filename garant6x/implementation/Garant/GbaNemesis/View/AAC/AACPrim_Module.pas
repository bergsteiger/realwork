unit AACPrim_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/AACPrim_Module.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACPrim
//
// Реализация прецедента "Актуальная аналитика". {RequestLink:365838080}
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
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  vtLabel,
  DocumentInterfaces,
  l3StringIDEx,
  Common_FormDefinitions_Controls,
  WorkWithDocumentInterfaces,
  nscSimpleEditorForDialogs,
  BaloonWarningUserTypes_WarnJuror_UserType
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  AACContainerPrim_Form,
  AACContainer_Form,
  AACContainerPrim_AACContainer_UserType,
  DocumentUserTypes_dftAACLeft_UserType,
  DocumentUserTypes_dftAACRight_UserType,
  DocumentUserTypes_dftAACContentsLeft_UserType,
  DocumentUserTypes_dftAACContentsRight_UserType,
  AACContentsContainer_Form
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  AACTextContainerPrim_Form,
  fsAbstractDocument,
  vtScrollBar,
  AACContainerPrim_AACContentsContainer_UserType
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  ,
  fsAACContents,
  fsAAC
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  AACContainerKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  AACContentsContainerKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TAACPrimModule = {formspack} class(TvcmModule)
  {* Реализация прецедента "Актуальная аналитика". [RequestLink:365838080] }
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class procedure MakeAAC(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Создаёт сборку для документа ААК }
   class procedure MakeAACContents(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Создаёт сборку для документа ОГЛАВЛЕНИЯ ААК }
 end;//TAACPrimModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  sdsAAC,
  l3Base {a},
  DocumentUnit,
  l3String,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TAACPrimModule

class procedure TAACPrimModule.MakeAAC(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
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

class procedure TAACPrimModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TAACContainerForm);
 aList.Add(TAACContentsContainerForm);
end;

{$IfEnd} //not Admin AND not Monitorings

end.