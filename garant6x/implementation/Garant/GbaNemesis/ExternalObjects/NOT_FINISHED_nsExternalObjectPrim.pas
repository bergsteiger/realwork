unit NOT_FINISHED_nsExternalObjectPrim;
 {* Утилитный функции для сохранения в файлы. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\NOT_FINISHED_nsExternalObjectPrim.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsExternalObjectPrim" MUID: (47F9C7C9010E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 TnsExternalObjectStream = class
 end;//TnsExternalObjectStream

 EDefaultMailCLientAbsent = class
 end;//EDefaultMailCLientAbsent

 TnsExternalObjectPrim = class
 end;//TnsExternalObjectPrim

procedure nsDoShellExecute;
procedure nsExecuteExternalLink;
procedure nsGetFileFormatExt;
procedure nsMakeTemporaryFileName;
procedure nsSendAttachedFile;
procedure nsPrepareFileName;

implementation

uses
 l3ImplUses
 , ddHTMLWriter
 , nsExternalObjectModelPart
 , nsExternalObject
 , nsBrowserInfo
 , evPDFWriter
 , nsDocumentStreamList
 {$If NOT Defined(NoScripts)}
 , F1ShellWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure nsDoShellExecute;
//#UC START# *4ABC7EA00088_47F9C7C9010E_var*
//#UC END# *4ABC7EA00088_47F9C7C9010E_var*
begin
//#UC START# *4ABC7EA00088_47F9C7C9010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABC7EA00088_47F9C7C9010E_impl*
end;//nsDoShellExecute

procedure nsExecuteExternalLink;
//#UC START# *4ACF0EAE02C3_47F9C7C9010E_var*
//#UC END# *4ACF0EAE02C3_47F9C7C9010E_var*
begin
//#UC START# *4ACF0EAE02C3_47F9C7C9010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ACF0EAE02C3_47F9C7C9010E_impl*
end;//nsExecuteExternalLink

procedure nsGetFileFormatExt;
//#UC START# *4AE1B32601AE_47F9C7C9010E_var*
//#UC END# *4AE1B32601AE_47F9C7C9010E_var*
begin
//#UC START# *4AE1B32601AE_47F9C7C9010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE1B32601AE_47F9C7C9010E_impl*
end;//nsGetFileFormatExt

procedure nsMakeTemporaryFileName;
//#UC START# *4C46CB7201BB_47F9C7C9010E_var*
//#UC END# *4C46CB7201BB_47F9C7C9010E_var*
begin
//#UC START# *4C46CB7201BB_47F9C7C9010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C46CB7201BB_47F9C7C9010E_impl*
end;//nsMakeTemporaryFileName

procedure nsSendAttachedFile;
//#UC START# *4C46CCDC01F6_47F9C7C9010E_var*
//#UC END# *4C46CCDC01F6_47F9C7C9010E_var*
begin
//#UC START# *4C46CCDC01F6_47F9C7C9010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C46CCDC01F6_47F9C7C9010E_impl*
end;//nsSendAttachedFile

procedure nsPrepareFileName;
//#UC START# *4C5305BB0005_47F9C7C9010E_var*
//#UC END# *4C5305BB0005_47F9C7C9010E_var*
begin
//#UC START# *4C5305BB0005_47F9C7C9010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C5305BB0005_47F9C7C9010E_impl*
end;//nsPrepareFileName

end.
