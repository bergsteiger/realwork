unit ChangesBetweenEditions_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ChangesBetweenEditons/ChangesBetweenEditions_Module.pas"
// �����: 24.05.2011 17:14
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 ���������������� �������::ChangesBetweenEditions::View::ChangesBetweenEditons::ChangesBetweenEditions
//
// �������� ������ ���������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimChangesBetweenEditons_Form,
  ChangesBetweenEditons_Form,
  ChangesBetweenEditionsInterfaces,
  PrimChangesBetweenEditons_DocumentChanges_UserType,
  l3MessageID
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  fsViewChangedFragments,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TChangesBetweenEditionsModule = {formspack} class(TvcmModule)
  {* �������� ������ ���������� ���������� }
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class procedure ViewChangedFragments(const aLeft: IDocument;
     const aRight: IDocument);
   class procedure ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
     {* �������� �������� ���������� � ��������� � ���������� ��������� }
 end;//TChangesBetweenEditionsModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  sdsChangesBetweenEditions,
  nsChangesBetweenEditionsInfo
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  l3Base {a},
  SysUtils,
  l3StringIDEx
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ Local }
  str_CannotShowChanges : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'CannotShowChanges'; rValue : '��������� �� ����� ���� ���������� � ������� ������');
   { '��������� �� ����� ���� ���������� � ������� ������' }

// start class TChangesBetweenEditionsModule

class procedure TChangesBetweenEditionsModule.ViewChangedFragments(const aLeft: IDocument;
  const aRight: IDocument);
var
 __WasEnter : Boolean;
//#UC START# *4DDCBB5D0298_4DDBAF2B0028_var*
var
 l_P : IDiffDocDataProvider;
//#UC END# *4DDCBB5D0298_4DDBAF2B0028_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4DDCBB5D0298_4DDBAF2B0028_impl*
  try
   l_P := DefDataAdapter.NativeAdapter.MakeDiffDocDataProvider(aLeft, aRight);
  except
   on EAllChangesInTables do // http://mdp.garant.ru/pages/viewpage.action?pageId=309592530
   begin
    vcmSay(str_CannotShowChanges);
    Exit;
   end;//on EAllChangesInTables
  end;//try..except
  Tfs_ViewChangedFragments.Make(
   TsdsChangesBetweenEditions.Make(
    TnsChangesBetweenEditionsInfo.Make(aLeft, aRight, l_P)),
   DefaultContainer);
//#UC END# *4DDCBB5D0298_4DDBAF2B0028_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TChangesBetweenEditionsModule.ViewChangedFragments

class procedure TChangesBetweenEditionsModule.ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
var
 __WasEnter : Boolean;
//#UC START# *4DE513C202B3_4DDBAF2B0028_var*
var
 l_PrevState : IDocumentState;
 l_State : IDocumentState;
 l_Prev  : IDocument;
//#UC END# *4DE513C202B3_4DDBAF2B0028_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4DE513C202B3_4DDBAF2B0028_impl*
  aDocument.GetCurrentState(l_PrevState);
  l_PrevState.Clone(l_State);
  l_State.SetPrevRedaction;
  aDocument.CreateView(l_State, l_Prev);
  Assert(l_Prev <> nil);
  ViewChangedFragments(l_Prev, aDocument);
//#UC END# *4DE513C202B3_4DDBAF2B0028_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TChangesBetweenEditionsModule.ViewChangedFragmentsForPrevEdition

class procedure TChangesBetweenEditionsModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TChangesBetweenEditonsForm);
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_CannotShowChanges
 str_CannotShowChanges.Init;
 str_CannotShowChanges.SetDlgType(mtWarning);
{$IfEnd} //not Admin AND not Monitorings

end.