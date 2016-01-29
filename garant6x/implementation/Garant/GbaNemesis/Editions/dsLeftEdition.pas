unit dsLeftEdition;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/dsLeftEdition.pas"
// Начат: 30.07.2009 15:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::Editions::TdsLeftEdition
//
// Предыдущая редакция
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
  DocumentUnit,
  l3Tree_TLB,
  EditionsInterfaces,
  nevTools
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  vcmControllers {a},
  UnderControlUnit,
  l3Types,
  UnderControlInterfaces,
  afwInterfaces,
  DocumentAndListInterfaces,
  DocumentInterfaces,
  eeInterfaces,
  FoldersDomainInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsLeftEdition;
 {$Include ..\Editions\dsEditionDiff.imp.pas}
 TdsLeftEdition = {final vac} class(_dsEditionDiff_, IdsLeftEdition)
  {* Предыдущая редакция }
 private
 // private fields
   f_OwnDocument : IDocument;
    {* Собственный документ предыдущей редакции. Чтобы правильно работала обработка гиперссылок}
   f_PrevEditions : Il3Node;
 protected
 // property methods
   function pm_GetOriginalDocument: IDocument;
 protected
 // realized methods
   function Get_PrevEditions: Il3Node;
   function IsLeft: Boolean; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DoGetDocument: IDocument; override;
     {* Возвращает документ сответствующий данной редакции }
   procedure SignalEditionChanged; override;
     {* Сообщение о смене редакции }
 protected
 // protected properties
   property OriginalDocument: IDocument
     read pm_GetOriginalDocument;
     {* Документ из которого производится сравнение }
 end;//TdsLeftEdition
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  nsEditionNodes,
  nsTypes,
  deDocInfo,
  nsDocInfoHAFMacroReplacer,
  nsFolderFilterInfo,
  nsEditionFromDTPDocumentContainer,
  l3InterfacesMisc,
  SysUtils,
  l3Base,
  l3Utils,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsLeftEdition;

{$Include ..\Editions\dsEditionDiff.imp.pas}

// start class TdsLeftEdition

function TdsLeftEdition.pm_GetOriginalDocument: IDocument;
//#UC START# *4A83D53600CD_4A717F9600F4get_var*
//#UC END# *4A83D53600CD_4A717F9600F4get_var*
begin
//#UC START# *4A83D53600CD_4A717F9600F4get_impl*
 Result := inherited DoGetDocument;
//#UC END# *4A83D53600CD_4A717F9600F4get_impl*
end;//TdsLeftEdition.pm_GetOriginalDocument

function TdsLeftEdition.Get_PrevEditions: Il3Node;
//#UC START# *4A83D4CA00D0_4A717F9600F4get_var*
//#UC END# *4A83D4CA00D0_4A717F9600F4get_var*
begin
//#UC START# *4A83D4CA00D0_4A717F9600F4get_impl*
 if (f_PrevEditions = nil) then
  f_PrevEditions := TnsEditionsRoot.MakeForPrevEditions(OriginalDocument);
 Result := f_PrevEditions;
//#UC END# *4A83D4CA00D0_4A717F9600F4get_impl*
end;//TdsLeftEdition.Get_PrevEditions

function TdsLeftEdition.IsLeft: Boolean;
//#UC START# *4A8443C30125_4A717F9600F4_var*
//#UC END# *4A8443C30125_4A717F9600F4_var*
begin
//#UC START# *4A8443C30125_4A717F9600F4_impl*
 Result := true;
//#UC END# *4A8443C30125_4A717F9600F4_impl*
end;//TdsLeftEdition.IsLeft

procedure TdsLeftEdition.Cleanup;
//#UC START# *479731C50290_4A717F9600F4_var*
//#UC END# *479731C50290_4A717F9600F4_var*
begin
//#UC START# *479731C50290_4A717F9600F4_impl*
 f_PrevEditions := nil;
 inherited;
 f_OwnDocument := nil;
//#UC END# *479731C50290_4A717F9600F4_impl*
end;//TdsLeftEdition.Cleanup

function TdsLeftEdition.DoGetDocument: IDocument;
//#UC START# *4A80573D03A7_4A717F9600F4_var*
var
 l_Doc       : IDocument;
 l_PrevState : IDocumentState;
 l_State     : IDocumentState;
 l_EID       : TRedactionID;
 l_Info      : TRedactionInfo; 
//#UC END# *4A80573D03A7_4A717F9600F4_var*
begin
//#UC START# *4A80573D03A7_4A717F9600F4_impl*
 l_EID := ucc_CompareEditions.EditionForCompare;
 if (f_OwnDocument <> nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=185828256&focusedCommentId=185829892#comment-185829892
 // - проверка на безобразие с рассинхронизацией состояний
 begin
  if not f_OwnDocument.IsAlive then
  begin
   Result := f_OwnDocument;
   Exit;
  end;
  f_OwnDocument.GetCurrentState(l_State);
  l_State.GetCurrentRedaction(l_Info);
  Assert(l_Info.rId = l_EID);
  if (l_Info.rId <> l_EID) then
   f_OwnDocument := nil;
 end;//f_OwnDocument <> nil
 if (f_OwnDocument = nil) then
 begin
  l_Doc := OriginalDocument;
  Assert(l_Doc <> nil);
  l_Doc.GetCurrentState(l_PrevState);
  l_PrevState.Clone(l_State);
  Assert(l_EID <> -1);
  // - т.к. архитектура поменялась и EditionForCompare д.б. определена ВСЕГДА
  //   см. обработку f_EditionForCompare в TsdsCompareEditions.CheckCompare
  if (l_EID <> -1) then
   l_State.SetRedactionOnId(l_EID)
  else
   l_State.SetPrevActiveRedaction;
  l_Doc.CreateView(l_State, f_OwnDocument);
  Assert(f_OwnDocument <> nil);
  Assert(not f_OwnDocument.IsSameView(l_Doc));
 end;//f_OwnDocument = nil
 Result := f_OwnDocument;
//#UC END# *4A80573D03A7_4A717F9600F4_impl*
end;//TdsLeftEdition.DoGetDocument

procedure TdsLeftEdition.SignalEditionChanged;
//#UC START# *4A8426C0002A_4A717F9600F4_var*
//#UC END# *4A8426C0002A_4A717F9600F4_var*
begin
//#UC START# *4A8426C0002A_4A717F9600F4_impl*
 inherited;
 f_OwnDocument := nil;
//#UC END# *4A8426C0002A_4A717F9600F4_impl*
end;//TdsLeftEdition.SignalEditionChanged

{$IfEnd} //not Admin AND not Monitorings

end.