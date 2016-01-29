unit PrimContentsOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimContentsOptions_Form.pas"
// Начат: 08.09.2010 17:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Contents::PrimContentsOptions
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
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  Base_Operations_F1Specific_Controls,
  PrimContents_Form
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimContentsOptionsForm = {form} class(TPrimContentsForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   procedure File_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
     {* Экспорт в Word }
   procedure File_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Экспорт в Word }
   {$If not defined(NoVCM)}
   procedure Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Свернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
     {* Перенос по словам }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_Wrap_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Перенос по словам }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure EntitiesInited; override;
     {* Вызывается после того как все операции зарегистрированы }
   {$IfEnd} //not NoVCM
 end;//TPrimContentsOptionsForm

 TvcmEntityFormRef = TPrimContentsOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwFacade,
  nevTools,
  nsExternalObjectPrim,
  l3Stream,
  k2CustomFileGenerator,
  l3BaseStream,
  l3Interfaces,
  nsTypes,
  nsToMSWordOp,
  nsTrialSupport,
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3String,
  nsFolders,
  l3Types,
  evdTypes,
  DocumentUnit,
  k2TagGen,
  nsExternalObjectModelPart
  {$If not defined(NoVCM)}
  ,
  vcmRepOperationsCollectionItem
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  Document_Strange_Controls,
  Base_Operations_Editions_Controls
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimContentsOptionsForm

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49521D8E0295_4C878FA60351test_var*
//#UC END# *49521D8E0295_4C878FA60351test_var*
begin
//#UC START# *49521D8E0295_4C878FA60351test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanPrint;
//#UC END# *49521D8E0295_4C878FA60351test_impl*
end;//TPrimContentsOptionsForm.File_Print_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49521D8E0295_4C878FA60351exec_var*
//#UC END# *49521D8E0295_4C878FA60351exec_var*
begin
//#UC START# *49521D8E0295_4C878FA60351exec_impl*
 if (afw.Application <> nil) and (afw.Application.PrintManager <> nil) then
  MakePreview.Print;
//#UC END# *49521D8E0295_4C878FA60351exec_impl*
end;//TPrimContentsOptionsForm.File_Print_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220DE0298_4C878FA60351test_var*
//#UC END# *495220DE0298_4C878FA60351test_var*
begin
//#UC START# *495220DE0298_4C878FA60351test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanPrint;
//#UC END# *495220DE0298_4C878FA60351test_impl*
end;//TPrimContentsOptionsForm.File_PrintDialog_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220DE0298_4C878FA60351exec_var*
//#UC END# *495220DE0298_4C878FA60351exec_var*
begin
//#UC START# *495220DE0298_4C878FA60351exec_impl*
 if (afw.Application <> nil) and (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(MakePreview);
//#UC END# *495220DE0298_4C878FA60351exec_impl*
end;//TPrimContentsOptionsForm.File_PrintDialog_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220F2033A_4C878FA60351test_var*
//#UC END# *495220F2033A_4C878FA60351test_var*
begin
//#UC START# *495220F2033A_4C878FA60351test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanPreview;
//#UC END# *495220F2033A_4C878FA60351test_impl*
end;//TPrimContentsOptionsForm.File_PrintPreview_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220F2033A_4C878FA60351exec_var*
//#UC END# *495220F2033A_4C878FA60351exec_var*
begin
//#UC START# *495220F2033A_4C878FA60351exec_impl*
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.ShowPreview(MakePreview);
//#UC END# *495220F2033A_4C878FA60351exec_impl*
end;//TPrimContentsOptionsForm.File_PrintPreview_Execute
{$IfEnd} //not NoVCM

procedure TPrimContentsOptionsForm.File_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495238EB0160_4C878FA60351test_var*
//#UC END# *495238EB0160_4C878FA60351test_var*
begin
//#UC START# *495238EB0160_4C878FA60351test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (ContentsTree.Total > 0);
 nsDisableOperationInTrialMode(aParams);
 TnsToMSWordOp.Test(aParams);
//#UC END# *495238EB0160_4C878FA60351test_impl*
end;//TPrimContentsOptionsForm.File_ToMSWord_Test

procedure TPrimContentsOptionsForm.File_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495238EB0160_4C878FA60351exec_var*

 function lp_CreateFileName(const aName: Il3CString): Il3CString;
 begin
  Result := nsPrepareFileName(vcmFmt(str_ContentsPrintTitle, [aName]));
 end;//lp_CreateFileName

var
 //l_PathName : Il3CString;
 l_Output: TnsGetGenOutputStruct;
 l_Stream   : Tl3Stream;
 l_F        : TnsFileFormat;
 l_G        : Tk2CustomFileGenerator;
 l_H        : Tk2TagGenerator;
//#UC END# *495238EB0160_4C878FA60351exec_var*
begin
//#UC START# *495238EB0160_4C878FA60351exec_impl*
 if (BaseContents <> nil) then
 begin
  with BaseContents.DocInfo do
   l_Output := TnsGetGenOutputStruct_Create(
                 nsMakeTemporaryFileName(lp_CreateFileName(DocShortName), '.rtf')
               );  
  l_F := ns_ffRTF;
  l_Stream := Tl3NamedTextStream.Create(l3PStr(l_Output.rName), l3_fmWrite, 0);
  try
   if nsGetGen(l_Output, l_F, l_G, l_H) then
    try
     l_G.Filer.Mode := l3_fmWrite;
     l_G.Filer.Stream := l_Stream;
     try
      l_H.Start;
      try
       MakeEVD.Store(nil, l_H);
      finally
       l_H.Finish;
      end;//try..finally
     finally
      l_G.Filer.Stream := nil;
     end;//try..finally
    finally
     FreeAndNil(l_G);
     FreeAndNil(l_H);
    end;//try..finally
   FreeAndNil(l_Stream);
   TnsToMSWordOp.Execute(l_Output.rName, aParams);
  finally
   FreeAndNil(l_Stream);
  end;//try..finally
 end;//(BaseContents <> nil)
//#UC END# *495238EB0160_4C878FA60351exec_impl*
end;//TPrimContentsOptionsForm.File_ToMSWord_Execute

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4BDAF7A2005C_4C878FA60351exec_var*
//#UC END# *4BDAF7A2005C_4C878FA60351exec_var*
begin
//#UC START# *4BDAF7A2005C_4C878FA60351exec_impl*
 with ContentsTree.TreeView.Tree do
 begin
  Changing;
  try
   aParams.CallControl;
   ExpandFirstLevel;
  finally
   Changed;
  end;//try..finally
 end;//with ContentsTree.TreeView.Tree
//#UC END# *4BDAF7A2005C_4C878FA60351exec_impl*
end;//TPrimContentsOptionsForm.Tree_CollapseAll_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7B803CF_4C878FA60351test_var*
//#UC END# *4BDAF7B803CF_4C878FA60351test_var*
begin
//#UC START# *4BDAF7B803CF_4C878FA60351test_impl*
 aParams.CallControl;
 if not aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] :=
   lstBookmarks.Visible OR
   lstComments.Visible OR
   lstExternalObjects.Visible;
//#UC END# *4BDAF7B803CF_4C878FA60351test_impl*
end;//TPrimContentsOptionsForm.Tree_Wrap_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.Tree_Wrap_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4BDAF7B803CF_4C878FA60351exec_var*
//#UC END# *4BDAF7B803CF_4C878FA60351exec_var*
begin
//#UC START# *4BDAF7B803CF_4C878FA60351exec_impl*
 aParams.CallControl;
 lstBookmarks.MultiStrokeItem := ContentsTree.MultiStrokeItem;
 lstComments.MultiStrokeItem := ContentsTree.MultiStrokeItem;
 lstExternalObjects.MultiStrokeItem := ContentsTree.MultiStrokeItem;
//#UC END# *4BDAF7B803CF_4C878FA60351exec_impl*
end;//TPrimContentsOptionsForm.Tree_Wrap_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7D0CC90052_4C878FA60351test_var*
//#UC END# *4C7D0CC90052_4C878FA60351test_var*
begin
//#UC START# *4C7D0CC90052_4C878FA60351test_impl*
 if (aParams.Control = ContentsTree) then
  aParams.Op.Flag[vcm_ofEnabled] := ContentItemType in [cltBookmark, cltUserComment]
 else
 if (aParams.Control = lstBookmarks) OR (aParams.Control = lstComments) then
  aParams.Op.Flag[vcm_ofEnabled] := true
 else
  aParams.CallControl;
//#UC END# *4C7D0CC90052_4C878FA60351test_impl*
end;//TPrimContentsOptionsForm.Edit_Delete_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7D0CC90052_4C878FA60351exec_var*
var
 l_Sub    : IevSub;
 l_Para   : InevPara;
 l_ParaID : Integer;
 l_D : TBookmark2;
//#UC END# *4C7D0CC90052_4C878FA60351exec_var*
begin
//#UC START# *4C7D0CC90052_4C878FA60351exec_impl*
 if (aParams.Control = ContentsTree) then
 begin
  if (ContentsTree.TreeView.Current >= 0) and
     Supports(ContentsTree.TreeView.CurrentNode, IevSub, l_Sub) then
   try
    case l_Sub.LayerID of
     Ord(ev_sbtBookmark):
     begin
      case nsDeleteBookmark(l_Sub.ID, BaseContents.Adornments) of
  //   Теперь не нужно, т.к. закладка удаляется у всех документов в кэше через нотификацию.
  //     drOk: l_Sub.Delete;
       drDenied: Say(err_CanNotDeleteBookmark);
      end;//case DeleteBookmark(l_Sub.ID) of
     end;//ev_sbtBookmark
     Ord(ev_sbtMark):
      if l_Sub.Para.QT(InevPara, l_Para) then
       l_Para.Edit.Delete(false);
    end;//case l_Sub.LayerID
   finally
    l_Sub := nil;
   end;//try..finally
 end//aParams.Control = ContentsTree
 else
 if (aParams.Control = lstComments) then
 begin
  if (BaseContents <> nil) then
   with BaseContents do
   if (lstComments.Current < Comments.Count) then
    begin
     l_ParaID := Comments.Items[lstComments.Current];
     Adornments.As_InevCommentTextProvider.DeleteCommentByParaID(l_ParaID);
    end;//lstComments.Current < Comments.Count
 end//aParams.Control = lstComments
 else
 if (aParams.Control = lstBookmarks) then
 begin
  if (BaseContents <> nil) then
   with BaseContents do
   if (lstBookmarks.Current < Bookmarks.Count) then
    begin
     Bookmarks.pm_GetItem(lstBookmarks.Current, l_D);
     case nsDeleteBookmark(l_D.rParaID, Adornments) of
 //   Теперь не нужно, т.к. закладка удаляется у всех документов в кэше через нотификацию.
 //     drOk: l_Sub.Delete;
      drDenied: Say(err_CanNotDeleteBookmark);
     end;//case DeleteBookmark(l_D.rParaID) of
    end;//lstBookmarks.Current < Bookmarks.Count
 end//aParams.Control = lstBookmarks
 else
  aParams.CallControl;
//#UC END# *4C7D0CC90052_4C878FA60351exec_impl*
end;//TPrimContentsOptionsForm.Edit_Delete_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContentsOptionsForm.EntitiesInited;
//#UC START# *4AE1948900DE_4C878FA60351_var*
//#UC END# *4AE1948900DE_4C878FA60351_var*
begin
//#UC START# *4AE1948900DE_4C878FA60351_impl*
 Entities.Entities.CheckEntityForControl(en_Edit).Controls.PublishEntity(lstBookmarks, nil);
 Entities.Entities.CheckEntityForControl(en_Edit).Controls.PublishEntity(lstComments, nil);
 inherited;
//#UC END# *4AE1948900DE_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.EntitiesInited
{$IfEnd} //not NoVCM

procedure TPrimContentsOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Tree, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Cut, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Cut, false);
  ShowInToolbar(en_Edit, op_Cut, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, File_Print_Execute, File_Print_Test, nil);
  ShowInContextMenu(en_File, op_Print, false);
  ShowInToolbar(en_File, op_Print, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, File_PrintDialog_Test, nil);
  ShowInContextMenu(en_File, op_PrintDialog, false);
  ShowInToolbar(en_File, op_PrintDialog, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, File_PrintPreview_Test, nil);
  ShowInContextMenu(en_File, op_PrintPreview, false);
  ShowInToolbar(en_File, op_PrintPreview, false);
  {$IfEnd} //not NoVCM

  PublishOp(en_File, op_ToMSWord, File_ToMSWord_Execute, File_ToMSWord_Test, nil);
  ShowInContextMenu(en_File, op_ToMSWord, false);
  ShowInToolbar(en_File, op_ToMSWord, false);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Paste, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Paste, false);
  ShowInToolbar(en_Edit, op_Paste, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_SelectAll, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_SelectAll, false);
  ShowInToolbar(en_Edit, op_SelectAll, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Deselect, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Deselect, false);
  ShowInToolbar(en_Edit, op_Deselect, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, Tree_CollapseAll_Execute, nil, nil);
  ShowInContextMenu(en_Tree, op_CollapseAll, true);
  ShowInToolbar(en_Tree, op_CollapseAll, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_Wrap, Tree_Wrap_Execute, Tree_Wrap_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Copy, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Copy, false);
  ShowInToolbar(en_Edit, op_Copy, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, nil);
  ShowInContextMenu(en_Edit, op_Delete, true);
  ShowInToolbar(en_Edit, op_Delete, true);
  {$IfEnd} //not NoVCM

  ShowInContextMenu(en_DocumentBlock, op_GetCorrespondentList, true);
  ShowInToolbar(en_DocumentBlock, op_GetCorrespondentList, false);
  
  ShowInContextMenu(en_DocumentBlock, op_GetRespondentList, true);
  ShowInToolbar(en_DocumentBlock, op_GetRespondentList, false);
  
  ShowInContextMenu(en_DocumentBlock, op_GetTypedCorrespondentList, false);
  ShowInToolbar(en_DocumentBlock, op_GetTypedCorrespondentList, true);
  
  ShowInContextMenu(en_DocumentBlock, op_GetTypedRespondentList, false);
  ShowInToolbar(en_DocumentBlock, op_GetTypedRespondentList, true);
  
  ShowInContextMenu(en_DocumentBlockBookmarks, op_AddBookmark, true);
  ShowInToolbar(en_DocumentBlockBookmarks, op_AddBookmark, false);
  
  ShowInContextMenu(en_DocumentBlock, op_ToMSWord, true);
  ShowInToolbar(en_DocumentBlock, op_ToMSWord, false);
  
  ShowInContextMenu(en_DocumentBlock, op_PrintDialog, true);
  ShowInToolbar(en_DocumentBlock, op_PrintDialog, false);
  
  ShowInContextMenu(en_DocumentBlock, op_Copy, true);
  ShowInToolbar(en_DocumentBlock, op_Copy, false);
  
  ShowInContextMenu(en_DocumentBlock, op_Print, false);
  ShowInToolbar(en_DocumentBlock, op_Print, false);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimContentsOptions
 TtfwClassRef.Register(TPrimContentsOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.