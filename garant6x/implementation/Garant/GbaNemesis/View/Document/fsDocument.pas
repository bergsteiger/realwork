unit fsDocument;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\fsDocument.pas"
// ���������: "VCMFormSetFactory"
// ������� ������: "Document" MUID: (4AA126C401AD)
// ��� ����: "Tfs_Document"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , fsAbstractDocument
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUserTypes_dftDocument_UserType
 , Common_FormDefinitions_Controls
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , l3Interfaces
 , bsTypesNew
 , BaloonWarningUserTypes_WarnJuror_UserType
 , WorkWithDocumentInterfaces
 , nsTypes
 , nevBase
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_WarnOnControl_UserType
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , BaloonWarningUserTypes_WarnTimeMachineOn_UserType
 , BaloonWarningUserTypes_WarnRedaction_UserType
 , BaloonWarningUserTypes_WarnTimeMachineWarning_UserType
 , BaloonWarningUserTypes_WarnTimeMachineException_UserType
;

type
 Tfs_Document = {final} class(Tfs_AbstractDocument)
  {* �������� }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextParentDftDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Text }
   function WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� WarnJuror }
   function WarnPreActiveChildWarnPreActiveNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� WarnPreActive }
   function WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� WarnIsAbolished }
   function WarnOnControlChildWarnOnControlNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� WarnOnControl }
   function WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� WarnInactualDocument }
   function WarnTimeMachineOnChildWarnTimeMachineOnNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� WarnTimeMachineOn }
   function WarnRedactionChildWarnRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� WarnRedaction }
   function WarnTimeMachineWarningChildWarnTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� WarnTimeMachineWarning }
   function WarnTimeMachineExceptionChildWarnTimeMachineExceptionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� WarnTimeMachineException }
   class function Instance: Tfs_Document;
    {* ����� ��������� ���������� ���������� Tfs_Document }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tfs_Document
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , bsUtils
 , SysUtils
 , l3Base
 //#UC START# *4AA126C401ADimpl_uses*
 //#UC END# *4AA126C401ADimpl_uses*
;

var g_Tfs_Document: Tfs_Document = nil;
 {* ��������� ���������� Tfs_Document }

const
 {* ������������ ������ DocumentCaptionLocalConstants }
 str_fsDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDocumentCaption'; rValue : '�����');
  {* ��������� ������� ������ ���� "Document" }

procedure Tfs_DocumentFree;
 {* ����� ������������ ���������� ���������� Tfs_Document }
begin
 l3Free(g_Tfs_Document);
end;//Tfs_DocumentFree

function Tfs_Document.TextParentDftDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Text }
var
 l_UseCase : IsdsBaseDocument;
begin
 if Supports(aDataSource, IsdsBaseDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsDocument;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.TextParentDftDocumentNeedMakeForm

function Tfs_Document.WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� WarnJuror }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnJurorChildWarnJurorNeedMakeForm

function Tfs_Document.WarnPreActiveChildWarnPreActiveNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� WarnPreActive }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnPreActiveChildWarnPreActiveNeedMakeForm

function Tfs_Document.WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� WarnIsAbolished }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm

function Tfs_Document.WarnOnControlChildWarnOnControlNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� WarnOnControl }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnOnControlChildWarnOnControlNeedMakeForm

function Tfs_Document.WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� WarnInactualDocument }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm

function Tfs_Document.WarnTimeMachineOnChildWarnTimeMachineOnNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� WarnTimeMachineOn }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsTimeMachineWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnTimeMachineOnChildWarnTimeMachineOnNeedMakeForm

function Tfs_Document.WarnRedactionChildWarnRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� WarnRedaction }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnRedactionChildWarnRedactionNeedMakeForm

function Tfs_Document.WarnTimeMachineWarningChildWarnTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� WarnTimeMachineWarning }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsTimeMachineWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnTimeMachineWarningChildWarnTimeMachineWarningNeedMakeForm

function Tfs_Document.WarnTimeMachineExceptionChildWarnTimeMachineExceptionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� WarnTimeMachineException }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsTimeMachineWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Document.WarnTimeMachineExceptionChildWarnTimeMachineExceptionNeedMakeForm

class function Tfs_Document.Instance: Tfs_Document;
 {* ����� ��������� ���������� ���������� Tfs_Document }
begin
 if (g_Tfs_Document = nil) then
 begin
  l3System.AddExitProc(Tfs_DocumentFree);
  g_Tfs_Document := Create;
 end;
 Result := g_Tfs_Document;
end;//Tfs_Document.Instance

class function Tfs_Document.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_Document <> nil;
end;//Tfs_Document.Exists

procedure Tfs_Document.InitFields;
begin
 inherited;
 with AddZone('Text', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftDocument;
  with AddZone('WarnJuror', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnJuror;
   OnNeedMakeForm := WarnJurorChildWarnJurorNeedMakeForm;
  end;
  with AddZone('WarnPreActive', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnPreActive;
   OnNeedMakeForm := WarnPreActiveChildWarnPreActiveNeedMakeForm;
  end;
  with AddZone('WarnIsAbolished', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnIsAbolished;
   OnNeedMakeForm := WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm;
  end;
  with AddZone('WarnOnControl', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnOnControl;
   OnNeedMakeForm := WarnOnControlChildWarnOnControlNeedMakeForm;
  end;
  with AddZone('WarnInactualDocument', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnInactualDocument;
   OnNeedMakeForm := WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm;
  end;
  with AddZone('WarnTimeMachineOn', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnTimeMachineOn;
   OnNeedMakeForm := WarnTimeMachineOnChildWarnTimeMachineOnNeedMakeForm;
  end;
  with AddZone('WarnRedaction', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnRedaction;
   OnNeedMakeForm := WarnRedactionChildWarnRedactionNeedMakeForm;
  end;
  with AddZone('WarnTimeMachineWarning', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnTimeMachineWarning;
   OnNeedMakeForm := WarnTimeMachineWarningChildWarnTimeMachineWarningNeedMakeForm;
  end;
  with AddZone('WarnTimeMachineException', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := WarnTimeMachineException;
   OnNeedMakeForm := WarnTimeMachineExceptionChildWarnTimeMachineExceptionNeedMakeForm;
  end;
  OnNeedMakeForm := TextParentDftDocumentNeedMakeForm;
 end;
 Caption := str_fsDocumentCaption.AsCStr;
 OwnerForm := 16;
end;//Tfs_Document.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_Document.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_Document.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_fsDocumentCaption.Init;
 {* ������������� str_fsDocumentCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
