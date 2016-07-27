unit PrimDocumentListFromFile_Module;
 {* ������ ���������� �� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentListFromFile\PrimDocumentListFromFile_Module.pas"
// ���������: "VCMFormsPack"
// ������� ������: "PrimDocumentListFromFile" MUID: (4DA44B2C01BB)
// ��� ����: "TPrimDocumentListFromFileModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimDocumentListFromFileModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ������ ���������� �� ����� }
  private
   procedure opOpenDocumentListFromFileTest(const aParams: IvcmTestParamsPrim);
    {* ������� ������ ���������� �� ����� }
   procedure opOpenDocumentListFromFileExecute(const aParams: IvcmExecuteParamsPrim);
    {* ������� ������ ���������� �� ����� }
  protected
   procedure Loaded; override;
 end;//TPrimDocumentListFromFileModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3ProtoObject
 , Base_Operations_F1Services_Contracts
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , bsOpenListInfo
 , deListSet
 , nsOpenDialog
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsTypes
 , afwFacade
 , DataAdapter
 , DynamicDocListUnit
 , SysUtils
 , BaseTypesUnit
 , PrimPrimListInterfaces
 , l3Base
 //#UC START# *4DA44B2C01BBimpl_uses*
 , StdRes
 //#UC END# *4DA44B2C01BBimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TDocumentListFromFileServiceImpl = {final} class(Tl3ProtoObject, IDocumentListFromFileService)
  public
   class function Instance: TDocumentListFromFileServiceImpl;
    {* ����� ��������� ���������� ���������� TDocumentListFromFileServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TDocumentListFromFileServiceImpl

var g_TDocumentListFromFileServiceImpl: TDocumentListFromFileServiceImpl = nil;
 {* ��������� ���������� TDocumentListFromFileServiceImpl }

const
 {* ������������ ������ Local }
 str_AccessDenied: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AccessDenied'; rValue : '��� ������� � �����');
  {* '��� ������� � �����' }
 str_InvalidType: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InvalidType'; rValue : '�������� ��� �����');
  {* '�������� ��� �����' }
 str_ImportDocuments: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ImportDocuments'; rValue : '������������� ����������');
  {* '������������� ����������' }

procedure TDocumentListFromFileServiceImplFree;
 {* ����� ������������ ���������� ���������� TDocumentListFromFileServiceImpl }
begin
 l3Free(g_TDocumentListFromFileServiceImpl);
end;//TDocumentListFromFileServiceImplFree

class function TDocumentListFromFileServiceImpl.Instance: TDocumentListFromFileServiceImpl;
 {* ����� ��������� ���������� ���������� TDocumentListFromFileServiceImpl }
begin
 if (g_TDocumentListFromFileServiceImpl = nil) then
 begin
  l3System.AddExitProc(TDocumentListFromFileServiceImplFree);
  g_TDocumentListFromFileServiceImpl := Create;
 end;
 Result := g_TDocumentListFromFileServiceImpl;
end;//TDocumentListFromFileServiceImpl.Instance

class function TDocumentListFromFileServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TDocumentListFromFileServiceImpl <> nil;
end;//TDocumentListFromFileServiceImpl.Exists

procedure TPrimDocumentListFromFileModule.opOpenDocumentListFromFileTest(const aParams: IvcmTestParamsPrim);
 {* ������� ������ ���������� �� ����� }
//#UC START# *4DA44BDB01D9_4DA44B2C01BBtest_var*
//#UC END# *4DA44BDB01D9_4DA44B2C01BBtest_var*
begin
//#UC START# *4DA44BDB01D9_4DA44B2C01BBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal;
//#UC END# *4DA44BDB01D9_4DA44B2C01BBtest_impl*
end;//TPrimDocumentListFromFileModule.opOpenDocumentListFromFileTest

procedure TPrimDocumentListFromFileModule.opOpenDocumentListFromFileExecute(const aParams: IvcmExecuteParamsPrim);
 {* ������� ������ ���������� �� ����� }
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
end;//TPrimDocumentListFromFileModule.opOpenDocumentListFromFileExecute

procedure TPrimDocumentListFromFileModule.Loaded;
begin
 inherited;
 PublishOp('opOpenDocumentListFromFile', opOpenDocumentListFromFileExecute, opOpenDocumentListFromFileTest);
 ShowInToolbar('opOpenDocumentListFromFile', False);
 SetShortCut('opOpenDocumentListFromFile', 'Shift-Alt-L');
end;//TPrimDocumentListFromFileModule.Loaded

initialization
 str_AccessDenied.Init;
 {* ������������� str_AccessDenied }
 str_InvalidType.Init;
 {* ������������� str_InvalidType }
 str_ImportDocuments.Init;
 {* ������������� str_ImportDocuments }
 TDocumentListFromFileService.Instance.Alien := TDocumentListFromFileServiceImpl.Instance;
 {* ����������� TDocumentListFromFileServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
