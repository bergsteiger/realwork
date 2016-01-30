unit PrimFoldersTreeOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTreeOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersTree_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , Folders_Strange_Controls
 , L10nInterfaces
 , eeInterfaces
 , l3Interfaces
 , nsTypes
 , FoldersDomainInterfaces
 , l3TreeInterfaces
;

type
 TPrimFoldersTreeOptionsForm = class(TPrimFoldersTreeForm)
  private
   f_FilterMap: InsIntegerValueMap;
  protected
   function IsInSaveLoadState: Boolean;
   function GetCurrentFolder(const aNode: IeeNode): IeeNode;
   function CreateUniqName(const aNode: IeeNode): Il3CString;
   procedure DoSetShare(const aNode: IeeNode);
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
    {* прошла операция. }
   procedure ChildNodeAdded(const aNode: Il3SimpleNode);
    {* был добавлен дочерний узел }
   function BeginEdit(const aNode: IeeNode;
    WithPositioning: Boolean = False;
    IsNewFolder: Boolean = False): Boolean; override;
   procedure EndEdit(const aNode: IeeNode); override;
   function DeleteNode(const aNode: IeeNode;
    aAskConfirmation: Boolean): TnsDeleteResult; override;
   function GetFoldersInfo: InsFoldersInfo; override;
   procedure DoFoldersTreeCurrentChanged(Sender: TObject;
    NewCurrent: Integer;
    OldCurrent: Integer); override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure OpenQuery; override;
   procedure ExecuteQuery; override;
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Filtrate; override;
   procedure New; override;
   procedure AddToControl; override;
   procedure DelFromControl; override;
   procedure SetShare; override;
   procedure ExportToXML; override;
   procedure ImportFromXML; override;
   procedure Edit; override;
   procedure EditExt; override;
   procedure Open; override;
   procedure OpenNewWindow; override;
   procedure ControlStatus; override;
   procedure ExportForIntegration; override;
   procedure Open; override;
   procedure GiveMark; override;
   procedure ShowConsultationInfo; override;
   procedure ImportConsultation; override;
   procedure CreateFilter; override;
    {* Создать фильтр... }
   {$If NOT Defined(NoVCM)}
   procedure SetActiveControl; override;
    {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimFoldersTreeOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , BaseTreeSupportUnit
 , SysUtils
 , FoldersUnit
 , BaseTypesUnit
 , nsOpenUtils
 , SearchUnit
 , nsValueMapsIDs
 , nsValueMaps
 , Graphics
 , nsConst
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , nsFolders
 , l3Tree_TLB
 , nsFolderNodes
 {$If Defined(Nemesis)}
 , eeTreeMisc
 {$IfEnd} // Defined(Nemesis)
 , vtSaveDialog
 , l3Base
 , l3String
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsExternalObjectPrim
 , DataAdapter
 , nsUtils
 , Windows
 , l3InterfacesMisc
 , IOUnit
 , nsFormCoordinates
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , bsTypes
 , nsFiltersContainer
 , UnderControlUnit
 , nsQuestionsWithChoices
 , nsQueryUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TPrimFoldersTreeOptionsForm.IsInSaveLoadState: Boolean;
//#UC START# *4C7E73BD019F_4C7E651B0179_var*
//#UC END# *4C7E73BD019F_4C7E651B0179_var*
begin
//#UC START# *4C7E73BD019F_4C7E651B0179_impl*
 Result := (Op_FolderElement_GetState.Call(Aggregate) in [fiLoad, fiSelect, fiSave]);
//#UC END# *4C7E73BD019F_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.IsInSaveLoadState

function TPrimFoldersTreeOptionsForm.GetCurrentFolder(const aNode: IeeNode): IeeNode;
//#UC START# *4C7E772A036F_4C7E651B0179_var*
var
 l_AdapterNode: INode;
//#UC END# *4C7E772A036F_4C7E651B0179_var*
begin
//#UC START# *4C7E772A036F_4C7E651B0179_impl*
 Result := nil;
 if Supports(aNode, INode, l_AdapterNode) then
  if TFoldersItemType(l_AdapterNode.GetObjectType) = FIT_FOLDER then
   Result := aNode
  else
   Result := aNode.ParentNode;
//#UC END# *4C7E772A036F_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.GetCurrentFolder

function TPrimFoldersTreeOptionsForm.CreateUniqName(const aNode: IeeNode): Il3CString;
//#UC START# *4C7E77D901C5_4C7E651B0179_var*
var
 l_Name : Il3CString;

 function FindNode(const anIntf: IeeNode) : Boolean;
 begin//FindNode
  Result := l3Same(l_Name, anIntf.Text);
 end;//FindNode

var
 l_Node : IeeNode;
 I  : Integer;
//#UC END# *4C7E77D901C5_4C7E651B0179_var*
begin
//#UC START# *4C7E77D901C5_4C7E651B0179_impl*
 I := 1;
 repeat
  l_Name := vcmFmt(str_NewFolderDefaultName, [I]);
  l_Node := aNode.IterateF(eeL2NA(@FindNode), imOneLevel or imCheckResult);
  Inc(I);
 until l_Node = nil;
 Result := l_Name;
//#UC END# *4C7E77D901C5_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.CreateUniqName

procedure TPrimFoldersTreeOptionsForm.DoSetShare(const aNode: IeeNode);
//#UC START# *4C7E7A8000F8_4C7E651B0179_var*
var
 lFolder : IFolder;
//#UC END# *4C7E7A8000F8_4C7E651B0179_var*
begin
//#UC START# *4C7E7A8000F8_4C7E651B0179_impl*
 lFolder := GetIFolderFromIeeNode(aNode);
 if Assigned(lFolder) then
 try
  // установим доступ по умному, см. описание SharedFolder
  SharedFolder(aNode, not lFolder.GetShared);
  // проинформируем об изменениях
  op_UsersRights_FolderShareChanged.Call(Aggregate);
 finally
  lFolder := nil;
 end;
//#UC END# *4C7E7A8000F8_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.DoSetShare

procedure TPrimFoldersTreeOptionsForm.Notify(const aNotifier: Il3ChangeNotifier;
 aOperation: Integer;
 aIndex: Integer);
 {* прошла операция. }
//#UC START# *46A4504B03C4_4C7E651B0179_var*
//#UC END# *46A4504B03C4_4C7E651B0179_var*
begin
//#UC START# *46A4504B03C4_4C7E651B0179_impl*
 case TbsNotification(aOperation) of
  nConsultation:
   case TbsConsultationOperation(aIndex) of
    coUnreadChanged:
     FoldersTree.Invalidate;
   end;//case TbsConsultationOperation(aIndex) of
 end;//case TbsNotification(aOperation) of
//#UC END# *46A4504B03C4_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.Notify

procedure TPrimFoldersTreeOptionsForm.ChildNodeAdded(const aNode: Il3SimpleNode);
 {* был добавлен дочерний узел }
//#UC START# *49901C9600DD_4C7E651B0179_var*
//#UC END# *49901C9600DD_4C7E651B0179_var*
begin
//#UC START# *49901C9600DD_4C7E651B0179_impl*
 op_UsersRights_UpdateRights.Call(Aggregate, aNode As IeeNode);
 op_FolderElement_SetContent.Call(Aggregate, FoldersTree.TreeView.CurrentNode);
//#UC END# *49901C9600DD_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ChildNodeAdded

function TPrimFoldersTreeOptionsForm.BeginEdit(const aNode: IeeNode;
 WithPositioning: Boolean = False;
 IsNewFolder: Boolean = False): Boolean;
//#UC START# *4AE718F90254_4C7E651B0179_var*
var
 l_Coord  : TRect;
//#UC END# *4AE718F90254_4C7E651B0179_var*
begin
//#UC START# *4AE718F90254_4C7E651B0179_impl*
 Result := True;
 if (Aggregate <> nil) then
 begin
  if IsInSaveLoadState then
  begin
   //Assert(False, 'http://mdp.garant.ru/pages/viewpage.action?pageId=452373109&focusedCommentId=492624070#comment-492624070');
   //Нашлось:    http://mdp.garant.ru/pages/viewpage.action?pageId=506710748
   l_Coord  := FoldersTree.GetDrawTextRect(FoldersTree.TreeView.GoToNode(aNode));
   with l_Coord do
   begin
    TopLeft := FoldersTree.ClientToScreen(TopLeft);
    BottomRight := FoldersTree.ClientToScreen(BottomRight);
   end;
   Result := (TdmStdRes.EditInfoOpen(IsNewFolder, aNode, TnsFormCoordinates.Make(l_Coord)) = mrOk);
  end//IsInSaveLoadState
  else
  begin
   FoldersTree.Changing;
   try
    if IsNewFolder then
     Op_FolderElement_SetState.Call(Aggregate, fiNewFolder)
    else
     Op_FolderElement_SetState.Call(Aggregate, fiEdit);
    Op_FolderElement_SetContent.Call(Aggregate, aNode, IsNewFolder);
    Op_AdditionInfo_Show.Call(Aggregate);
    if WithPositioning then
     FoldersTree.TreeView.GoToNode(aNode);
   finally
    FoldersTree.Changed;
   end;//try..finally
  end;//IsInSaveLoadState
 end;//Aggregate <> nil
//#UC END# *4AE718F90254_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.BeginEdit

procedure TPrimFoldersTreeOptionsForm.EndEdit(const aNode: IeeNode);
//#UC START# *4AE7192B023C_4C7E651B0179_var*
//#UC END# *4AE7192B023C_4C7E651B0179_var*
begin
//#UC START# *4AE7192B023C_4C7E651B0179_impl*
 if Aggregate <> nil then
 begin
  op_FolderElement_SetContent.Call(Aggregate, aNode);
  Aggregate.Operation(TdmStdRes.opcode_AdditionInfo_Hide);
 end;//Aggregate <> nil
//#UC END# *4AE7192B023C_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.EndEdit

function TPrimFoldersTreeOptionsForm.DeleteNode(const aNode: IeeNode;
 aAskConfirmation: Boolean): TnsDeleteResult;
//#UC START# *4AE71F530142_4C7E651B0179_var*
var
 l_OldCurrent     : Integer;
 l_newCurrentNode : IeeNode;
 l_AdapterNode    : INode;
 l_Desision       : Boolean;
 l_String         : IString;
//#UC END# *4AE71F530142_4C7E651B0179_var*
begin
//#UC START# *4AE71F530142_4C7E651B0179_impl*
 Result := drCancel;
 if (dsFoldersTree <> nil) and
  dsFoldersTree.IsConsultation(aNode As Il3SimpleNode) then
 begin
  if Ask(qr_ObjectDelete, [aNode.Text]) then
  begin
   try
    dsFoldersTree.DeleteConsultation(aNode As Il3SimpleNode);
    Result := drOk;
   except
    on ECanNotFindData do
     Ask(inf_ConsultationAlreadyDelete);
   end;
  end;
 end//dsFoldersTree <> nil 
 else
  if CheckFolderElementRights(aNode, faDelete) then
   with FoldersTree.TreeView do
   begin
    Result := drCancel;
    if (aNode.NextNode <> nil) and
        not l3IEQ(aNode, aNode.NextNode) and
        not l3IEQ(aNode.ParentNode.ChildNode, aNode.NextNode) then
     l_newCurrentNode := aNode.NextNode
    else
     if (aNode.PrevNode <> nil) and
        not l3IEQ(aNode, aNode.PrevNode) then
      l_newCurrentNode := aNode.PrevNode
     else
      l_newCurrentNode := aNode.ParentNode;

    if aAskConfirmation then
    begin
     Supports(aNode, INode, l_AdapterNode);
     try
      if aNode.HasChild then
      begin
       {if (l_AdapterNode <> nil) and
          DefDataAdapter.Folders.IsLastUnderControl(l_AdapterNode as IFoldersNode) then
        l_Desision := Ask(qr_DeleteControlledFolder)
       else
       begin !STUB!  Это не нужно, т.к. теперь на контроле не связаны с папками}
        l_AdapterNode.GetCaption(l_String);
        try
         l_Desision := Ask(qr_ObjectDelete, [nsCStr(l_String)]);
        finally
         l_String := nil;
        end;//try..finally
       {end;}
      end//aNode.HasChild
      else
      if (l_AdapterNode <> nil) and
         (TFoldersItemType(l_AdapterNode.GetObjectType) <> FIT_FOLDER) then
      begin
       {if DefDataAdapter.Folders.IsLastUnderControl(l_AdapterNode as IFoldersNode) then
        l_Desision := Ask(qr_DeleteControlledObject, [l3CStr(aNode)])
       else !STUB!  Это не нужно, т.к. теперь на контроле не связаны с папками}
        l_Desision := Ask(qr_ObjectDelete, [aNode.Text]);
      end//l_AdapterNode <> nil..
      else
       l_Desision := Ask(qr_FolderEmptyQuery, [aNode.Text]);
     finally
      l_AdapterNode := nil;
     end;
    end
    else
     l_Desision := True;

    if l_Desision then
    begin
     aNode.Delete;
     Result := drOk;
    end;

    if (Result = drOk) and
       (l_newCurrentNode <> nil) then
    begin
     l_OldCurrent := Current;
     GoToNode(l_newCurrentNode);
     DoFoldersTreeCurrentChanged(self, Current, l_OldCurrent);
    end;
   end
  else
   Result := drDenied;
//#UC END# *4AE71F530142_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.DeleteNode

function TPrimFoldersTreeOptionsForm.GetFoldersInfo: InsFoldersInfo;
//#UC START# *4AF2F5E50289_4C7E651B0179_var*
//#UC END# *4AF2F5E50289_4C7E651B0179_var*
begin
//#UC START# *4AF2F5E50289_4C7E651B0179_impl*
 Result := FoldersInfo;
//#UC END# *4AF2F5E50289_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.GetFoldersInfo

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C7E651B0179_var*
//#UC END# *4BDAF7880236_4C7E651B0179_var*
begin
//#UC START# *4BDAF7880236_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C7E651B0179_var*
//#UC END# *4BDAF7A2005C_4C7E651B0179_var*
begin
//#UC START# *4BDAF7A2005C_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFoldersTreeOptionsForm.OpenQuery;
//#UC START# *4C3F3421036A_4C7E651B0179_var*
//#UC END# *4C3F3421036A_4C7E651B0179_var*
begin
//#UC START# *4C3F3421036A_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3F3421036A_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.OpenQuery

procedure TPrimFoldersTreeOptionsForm.ExecuteQuery;
//#UC START# *4C3F342E02AF_4C7E651B0179_var*
//#UC END# *4C3F342E02AF_4C7E651B0179_var*
begin
//#UC START# *4C3F342E02AF_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3F342E02AF_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ExecuteQuery

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7E651B0179_var*
//#UC END# *4C7D0CC90052_4C7E651B0179_var*
begin
//#UC START# *4C7D0CC90052_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFoldersTreeOptionsForm.Filtrate;
//#UC START# *4C7E65DF016E_4C7E651B0179_var*
//#UC END# *4C7E65DF016E_4C7E651B0179_var*
begin
//#UC START# *4C7E65DF016E_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E65DF016E_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.Filtrate

procedure TPrimFoldersTreeOptionsForm.New;
//#UC START# *4C7E66850144_4C7E651B0179_var*
//#UC END# *4C7E66850144_4C7E651B0179_var*
begin
//#UC START# *4C7E66850144_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E66850144_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.New

procedure TPrimFoldersTreeOptionsForm.AddToControl;
//#UC START# *4C7E66990246_4C7E651B0179_var*
//#UC END# *4C7E66990246_4C7E651B0179_var*
begin
//#UC START# *4C7E66990246_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E66990246_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.AddToControl

procedure TPrimFoldersTreeOptionsForm.DelFromControl;
//#UC START# *4C7E66B102FB_4C7E651B0179_var*
//#UC END# *4C7E66B102FB_4C7E651B0179_var*
begin
//#UC START# *4C7E66B102FB_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E66B102FB_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.DelFromControl

procedure TPrimFoldersTreeOptionsForm.SetShare;
//#UC START# *4C7E66C70264_4C7E651B0179_var*
//#UC END# *4C7E66C70264_4C7E651B0179_var*
begin
//#UC START# *4C7E66C70264_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E66C70264_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.SetShare

procedure TPrimFoldersTreeOptionsForm.ExportToXML;
//#UC START# *4C7E66DC00F5_4C7E651B0179_var*
//#UC END# *4C7E66DC00F5_4C7E651B0179_var*
begin
//#UC START# *4C7E66DC00F5_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E66DC00F5_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ExportToXML

procedure TPrimFoldersTreeOptionsForm.ImportFromXML;
//#UC START# *4C7E66F60347_4C7E651B0179_var*
//#UC END# *4C7E66F60347_4C7E651B0179_var*
begin
//#UC START# *4C7E66F60347_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E66F60347_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ImportFromXML

procedure TPrimFoldersTreeOptionsForm.Edit;
//#UC START# *4C7E679702DA_4C7E651B0179_var*
//#UC END# *4C7E679702DA_4C7E651B0179_var*
begin
//#UC START# *4C7E679702DA_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E679702DA_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.Edit

procedure TPrimFoldersTreeOptionsForm.EditExt;
//#UC START# *4C7E67B301FD_4C7E651B0179_var*
//#UC END# *4C7E67B301FD_4C7E651B0179_var*
begin
//#UC START# *4C7E67B301FD_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E67B301FD_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.EditExt

procedure TPrimFoldersTreeOptionsForm.Open;
//#UC START# *4C7E67CE01CB_4C7E651B0179_var*
//#UC END# *4C7E67CE01CB_4C7E651B0179_var*
begin
//#UC START# *4C7E67CE01CB_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E67CE01CB_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.Open

procedure TPrimFoldersTreeOptionsForm.OpenNewWindow;
//#UC START# *4C7E685801E5_4C7E651B0179_var*
//#UC END# *4C7E685801E5_4C7E651B0179_var*
begin
//#UC START# *4C7E685801E5_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E685801E5_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.OpenNewWindow

procedure TPrimFoldersTreeOptionsForm.ControlStatus;
//#UC START# *4C7E68D602DB_4C7E651B0179_var*
//#UC END# *4C7E68D602DB_4C7E651B0179_var*
begin
//#UC START# *4C7E68D602DB_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E68D602DB_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ControlStatus

procedure TPrimFoldersTreeOptionsForm.ExportForIntegration;
//#UC START# *4C7E68E900DC_4C7E651B0179_var*
//#UC END# *4C7E68E900DC_4C7E651B0179_var*
begin
//#UC START# *4C7E68E900DC_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E68E900DC_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ExportForIntegration

procedure TPrimFoldersTreeOptionsForm.Open;
//#UC START# *4C7E6AE10291_4C7E651B0179_var*
//#UC END# *4C7E6AE10291_4C7E651B0179_var*
begin
//#UC START# *4C7E6AE10291_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E6AE10291_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.Open

procedure TPrimFoldersTreeOptionsForm.GiveMark;
//#UC START# *4C7E6AF2031C_4C7E651B0179_var*
//#UC END# *4C7E6AF2031C_4C7E651B0179_var*
begin
//#UC START# *4C7E6AF2031C_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E6AF2031C_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.GiveMark

procedure TPrimFoldersTreeOptionsForm.ShowConsultationInfo;
//#UC START# *4C7E6B1A019D_4C7E651B0179_var*
//#UC END# *4C7E6B1A019D_4C7E651B0179_var*
begin
//#UC START# *4C7E6B1A019D_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E6B1A019D_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ShowConsultationInfo

procedure TPrimFoldersTreeOptionsForm.ImportConsultation;
//#UC START# *4C7E6B310055_4C7E651B0179_var*
//#UC END# *4C7E6B310055_4C7E651B0179_var*
begin
//#UC START# *4C7E6B310055_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E6B310055_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ImportConsultation

procedure TPrimFoldersTreeOptionsForm.DoFoldersTreeCurrentChanged(Sender: TObject;
 NewCurrent: Integer;
 OldCurrent: Integer);
//#UC START# *4C7E808A035E_4C7E651B0179_var*
var
 l_eeNode : IeeNode;
//#UC END# *4C7E808A035E_4C7E651B0179_var*
begin
//#UC START# *4C7E808A035E_4C7E651B0179_impl*
 if (Aggregate <> nil) and (NewCurrent <> -1) then
  with FoldersTree.TreeView do
  begin
   l_eeNode := GetNode(NewCurrent);
   try
    op_FolderElement_SetContent.Call(Aggregate, l_eeNode);
   finally
    l_eeNode := nil;
   end;//try..finally
  end;//with FoldersTree.TreeView
//#UC END# *4C7E808A035E_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.DoFoldersTreeCurrentChanged

procedure TPrimFoldersTreeOptionsForm.CreateFilter;
 {* Создать фильтр... }
//#UC START# *4CB5802D00CB_4C7E651B0179_var*
//#UC END# *4CB5802D00CB_4C7E651B0179_var*
begin
//#UC START# *4CB5802D00CB_4C7E651B0179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CB5802D00CB_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.CreateFilter

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4C7E651B0179_var*
//#UC END# *49803F5503AA_4C7E651B0179_var*
begin
//#UC START# *49803F5503AA_4C7E651B0179_impl*
 inherited;
 f_FilterMap := nsIntegerMapManager.Map[imap_FolderFilters];
//#UC END# *49803F5503AA_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.SetActiveControl;
 {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
//#UC START# *4AC3803A03CD_4C7E651B0179_var*
//#UC END# *4AC3803A03CD_4C7E651B0179_var*
begin
//#UC START# *4AC3803A03CD_4C7E651B0179_impl*
 Windows.SetFocus(FoldersTree.Handle);
//#UC END# *4AC3803A03CD_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.SetActiveControl
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFoldersTreeOptionsForm.ClearFields;
begin
 f_FilterMap := nil;
 inherited;
end;//TPrimFoldersTreeOptionsForm.ClearFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersTreeOptionsForm);
 {* Регистрация PrimFoldersTreeOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
