unit PrimDocumentListFromFile_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentListFromFile/PrimDocumentListFromFile_Module.pas"
// Начат: 12.04.2011 16:53
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Интерфейсные элементы::DocumentListFromFile::View::DocumentListFromFile::PrimDocumentListFromFile
//
// Список документов из файла
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
  l3StringIDEx,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmModule {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimDocumentListFromFileModule = {formspack} class(TvcmModule)
  {* Список документов из файла }
 protected
  procedure Loaded; override;
 private
 // private methods
   procedure opOpenDocumentListFromFileTest(const aParams: IvcmTestParamsPrim);
     {* Открыть список документов из файла }
   procedure opOpenDocumentListFromFile(const aParams: IvcmExecuteParamsPrim);
     {* Открыть список документов из файла }
 end;//TPrimDocumentListFromFileModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  DataAdapter,
  DynamicDocListUnit,
  SysUtils,
  nsTypes,
  deListSet,
  afwFacade
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  BaseTypesUnit
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  nsOpenDialog,
  bsOpenListInfo,
  PrimPrimListInterfaces
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_DocumentListFromFile_opOpenDocumentListFromFile
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  l3MessageID,
  vcmFormSetFactory {a},
  StdRes {a},
  vcmModuleDef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки Local }
  str_AccessDenied : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AccessDenied'; rValue : 'Нет доступа к файлу');
   { 'Нет доступа к файлу' }
  str_InvalidType : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InvalidType'; rValue : 'Неверный тип файла');
   { 'Неверный тип файла' }
  str_ImportDocuments : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ImportDocuments'; rValue : 'Импортируемых документов');
   { 'Импортируемых документов' }

// start class TPrimDocumentListFromFileModule

procedure TPrimDocumentListFromFileModule.opOpenDocumentListFromFileTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4DA44BDB01D9_4DA44B2C01BBtest_var*
//#UC END# *4DA44BDB01D9_4DA44B2C01BBtest_var*
begin
//#UC START# *4DA44BDB01D9_4DA44B2C01BBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal;
//#UC END# *4DA44BDB01D9_4DA44B2C01BBtest_impl*
end;//TPrimDocumentListFromFileModule.opOpenDocumentListFromFileTest

procedure TPrimDocumentListFromFileModule.opOpenDocumentListFromFile(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4DA44BDB01D9_4DA44B2C01BBexec_var*
 function IsEmptyList(const aL: IdeList): Boolean;
 var l_Info : TbsOpenListInfo;
 begin
  l_Info := TbsOpenListInfo.Create(aL);
  try
    Result := (l_Info.Data = nil);
  finally
    FreeAndNil(l_Info);
  end;//try..finally
 end;
var
 l_D : TnsOpenDialog;
 l_L : IDynList;
 l_deL: IdeList;
//#UC END# *4DA44BDB01D9_4DA44B2C01BBexec_var*
begin
//#UC START# *4DA44BDB01D9_4DA44B2C01BBexec_impl*
 l_D := TnsOpenDialog.Create(Self);
 try
  l_D.InnerNumbersEnabled := True;
  l_D.Filter := vcmConstString(str_AllFileFilter);
  if l_D.Execute then
  begin
   try
    DefDataAdapter.NativeAdapter.MakeDocListFactory.MakeList(nsAStr(l_D.FileName), l_D.InnerNumbersChecked, l_L);
   except
    on EAccessDenied do
    begin
     vcmSay(str_AccessDenied);
     Exit;
    end;//on EAccessDenied
    on EInvalidType do
    begin
     vcmSay(str_InvalidType);
     Exit;
    end;//on EInvalidType
   end;//try..except
   l_deL := TdeListSet.Make(l_L);
   if IsEmptyList(l_deL) then
    vcmSay(inf_ListMissing, [str_ImportDocuments.AsStr])
   else
    TdmStdRes.OpenList(l_deL, nil);
  end;//l_D.Execute
 finally
  FreeAndNil(l_D);
 end;//try..finally
//#UC END# *4DA44BDB01D9_4DA44B2C01BBexec_impl*
end;//TPrimDocumentListFromFileModule.opOpenDocumentListFromFile

procedure TPrimDocumentListFromFileModule.Loaded;
begin
 inherited;
 PublishOp('opOpenDocumentListFromFile', opOpenDocumentListFromFile, opOpenDocumentListFromFileTest);
 ShowInToolbar('opOpenDocumentListFromFile', false);
 SetShortCut('opOpenDocumentListFromFile', 'Shift-Alt-L');
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_AccessDenied
 str_AccessDenied.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_InvalidType
 str_InvalidType.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ImportDocuments
 str_ImportDocuments.Init;
{$IfEnd} //not Admin AND not Monitorings

end.