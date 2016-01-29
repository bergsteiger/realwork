unit LegalDomain_DocumentNotifications_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LegalDomain_DocumentNotifications_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 ������� ����������� ���������� �������::LegalDomain::View::DocumentNotifications
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* Comment = operations
   ['{180B0E4C-1DF0-4C40-9979-09CFB52B5C43}']
   query Changed;
 end;//Comment*)

type
 Op_Comment_Changed = class
  {* ����� ��� ������ �������� Comment.Changed }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� Comment.Changed � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� Comment.Changed � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� Comment.Changed � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� Comment.Changed � ���������� }
   class procedure Broadcast;
     {* ����� �������� Comment.Changed � ���� ������������������ ��������� }
 end;//Op_Comment_Changed

const
 en_Comment = 'Comment';
 en_capComment = '';
 op_Changed = 'Changed';
 op_capChanged = '';

implementation

uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

// start class Op_Comment_Changed

class function Op_Comment_Changed.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Comment_Changed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Comment_Changed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Comment_Changed.Call

class procedure Op_Comment_Changed.Broadcast;
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := vcmParams;
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_Comment_Changed, l_Params);
 end;//vcmDispatcher <> nil
end;//Op_Comment_Changed.Broadcast

end.