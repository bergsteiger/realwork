unit PostingOrder_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PostingOrder_Strange_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Common For Shell And Monitoring::PostingOrder::View::Strange
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* PostingToolBar = operations
  {* ������ �������� }
   ['{1C5CA247-E15B-44F0-8FF5-2C7887F5ED15}']
   operation ptNewTheme;
   operation ptEditPosting;
   operation ptDeletePosting;
   operation SavePostList;
   operation ExportSelected;
 end;//PostingToolBar*)

(* SearchSupport = operations
   ['{3901AE6B-FAAB-4959-B7E7-F28A64A3C7CC}']
   FormActivate ActivatePostingsListForm;
 end;//SearchSupport*)

type
 Op_SearchSupport_ActivatePostingsListForm = class
  {* ����� ��� ������ �������� SearchSupport.ActivatePostingsListForm }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� SearchSupport.ActivatePostingsListForm � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� SearchSupport.ActivatePostingsListForm � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� SearchSupport.ActivatePostingsListForm � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� SearchSupport.ActivatePostingsListForm � ���������� }
   class procedure Broadcast;
     {* ����� �������� SearchSupport.ActivatePostingsListForm � ���� ������������������ ��������� }
 end;//Op_SearchSupport_ActivatePostingsListForm
{$IfEnd} //not Admin

{$If not defined(Admin)}
const
 en_PostingToolBar = 'PostingToolBar';
 en_capPostingToolBar = '������ ��������';
 op_ptNewTheme = 'ptNewTheme';
 op_capptNewTheme = '';
 op_ptEditPosting = 'ptEditPosting';
 op_capptEditPosting = '';
 op_ptDeletePosting = 'ptDeletePosting';
 op_capptDeletePosting = '';
 op_SavePostList = 'SavePostList';
 op_capSavePostList = '';
 op_ExportSelected = 'ExportSelected';
 op_capExportSelected = '';
 en_SearchSupport = 'SearchSupport';
 en_capSearchSupport = '';
 op_ActivatePostingsListForm = 'ActivatePostingsListForm';
 op_capActivatePostingsListForm = '';
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

// start class Op_SearchSupport_ActivatePostingsListForm

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchSupport_ActivatePostingsListForm, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchSupport_ActivatePostingsListForm, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class procedure Op_SearchSupport_ActivatePostingsListForm.Broadcast;
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := vcmParams;
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_SearchSupport_ActivatePostingsListForm, l_Params);
 end;//vcmDispatcher <> nil
end;//Op_SearchSupport_ActivatePostingsListForm.Broadcast
{$IfEnd} //not Admin


end.