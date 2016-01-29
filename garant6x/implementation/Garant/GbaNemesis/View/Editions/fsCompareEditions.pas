unit fsCompareEditions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/fsCompareEditions.pas"
// �����: 28.07.2009 13:07
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 ���������������� �������::CompareEditions::View::Editions::BaseEditions::CompareEditions
//
// ��������� �������� ���������
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
  Classes
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
  EditionsInterfaces,
  LeftEdition_Form,
  RightEdition_Form,
  EditionsContainer_Form,
  l3StringIDEx,
  PrimLeftEdition_utLeftEdition_UserType,
  PrimRightEdition_utRightEdition_UserType,
  PrimEditionsContainer_utEditionsContainer_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  nevTools,
  eeInterfaces,
  DocumentUnit,
  l3Interfaces,
  l3Tree_TLB,
  afwInterfaces,
  FoldersDomainInterfaces,
  DocumentInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_CompareEditions = {final fsf} class(TvcmFormSetFactory)
   {* ��������� �������� ��������� }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function EditionsContainerParentUtEditionsContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* ���������� OnNeedMakeForm ��� EditionsContainer }
   function LeftChildUtLeftEditionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* ���������� OnNeedMakeForm ��� Left }
   function RightMainUtRightEditionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* ���������� OnNeedMakeForm ��� Right }
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
  public
  // singleton factory method
    class function Instance: Tfs_CompareEditions;
     {- ���������� ��������� ����������. }
  end;//Tfs_CompareEditions
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  CompareEditions_FormDefinitions_Controls,
  l3MessageID,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_CompareEditions

var g_Tfs_CompareEditions : Tfs_CompareEditions = nil;

procedure Tfs_CompareEditionsFree;
begin
 l3Free(g_Tfs_CompareEditions);
end;

class function Tfs_CompareEditions.Instance: Tfs_CompareEditions;
begin
 if (g_Tfs_CompareEditions = nil) then
 begin
  l3System.AddExitProc(Tfs_CompareEditionsFree);
  g_Tfs_CompareEditions := Create;
 end;
 Result := g_Tfs_CompareEditions;
end;

var
    { ������������ ������ CompareEditionsCaptionLocalConstants }
   str_fsCompareEditionsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsCompareEditionsCaption'; rValue : '��������� ��������');
    { ��������� ������� ������ ���� "CompareEditions" }

// start class Tfs_CompareEditions

function Tfs_CompareEditions.EditionsContainerParentUtEditionsContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsCompareEditions;
begin
 if Supports(aDataSource, IsdsCompareEditions, l_UseCase) then
  try
   aNew := l_UseCase.EditionsContainerData;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_CompareEditions.EditionsContainerParentUtEditionsContainerNeedMakeForm

function Tfs_CompareEditions.LeftChildUtLeftEditionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsCompareEditions;
begin
 if Supports(aDataSource, IsdsCompareEditions, l_UseCase) then
  try
   aNew := l_UseCase.Left;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_CompareEditions.LeftChildUtLeftEditionNeedMakeForm

function Tfs_CompareEditions.RightMainUtRightEditionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsCompareEditions;
begin
 if Supports(aDataSource, IsdsCompareEditions, l_UseCase) then
  try
   aNew := l_UseCase.Right;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_CompareEditions.RightMainUtRightEditionNeedMakeForm

class function Tfs_CompareEditions.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_CompareEditions <> nil;
end;//Tfs_CompareEditions.Exists

procedure Tfs_CompareEditions.InitFields;
 {-}
begin
 inherited;
 with AddZone('EditionsContainer', vcm_ztParent, fm_EditionsContainerForm) do
 begin
  UserType := utEditionsContainer;
  with AddZone('Left', vcm_ztChild, fm_LeftEditionForm) do
  begin
   UserType := utLeftEdition;
   OnNeedMakeForm := LeftChildUtLeftEditionNeedMakeForm;
  end;
  with AddZone('Right', vcm_ztMain, fm_RightEditionForm) do
  begin
   UserType := utRightEdition;
   OnNeedMakeForm := RightMainUtRightEditionNeedMakeForm;
  end;
  OnNeedMakeForm := EditionsContainerParentUtEditionsContainerNeedMakeForm;
 end;
 Caption := str_fsCompareEditionsCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_CompareEditions.InitFields

{$If not defined(NoVCM)}
class function Tfs_CompareEditions.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_CompareEditions.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_fsCompareEditionsCaption
 str_fsCompareEditionsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.