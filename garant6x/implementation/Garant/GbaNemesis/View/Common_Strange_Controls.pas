unit Common_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common_Strange_Controls.pas"
// �����: 02.11.2009 16:46
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Common::View::Strange
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
  DocumentUnit,
  l3TreeInterfaces,
  bsTypes,
  l3CProtoObject
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* Navigator = operations
   ['{3AFDC641-744E-44A7-A1D9-D5B7D228BF26}']
   query SetCurrent(const aNode: Il3SimpleNode);
 end;//Navigator*)

(* Document = operations
  {* �������� }
   ['{60DC4335-41A2-4A55-A988-E2C7D3E51AC8}']
   operation GetAttributesFrmAct; has states;
     {* ���������� � ��������� }
      Picture = state
       { ���������� � �������� }
      end;//Picture
   operation OpenCorrespondentList(aKind: TlstCRType;
    const aCRType: Il3SimpleNode);
     {* �������, ��� ���? }
   operation OpenRespondentList(aKind: TlstCRType;
    const aCRType: Il3SimpleNode);
     {* �������, ��� ���? }
   operation GetAttributesFrmAct;
     {* ���������� � ��������� }
   operation GetRelatedDocFrmAct;
     {* ������� � ��������� }
   operation GetCorrespondentList;
     {* ������ �� �������� }
   operation GetRespondentList;
     {* ������ �� ��������� }
   query AttributesCanBeClosed: Boolean;
     {* ��� �������� �� ������� � Facet ��� ���-�� �������� }
   query CommonDocumentOpenNewWindow(aUserType: Integer);
     {* ��� ���? }
   operation GetCorrespondentListExFrmAct;
     {* ������ �� �������� (��� ����������) }
   operation GetRespondentListExFrmAct;
     {* ������ �� ��������� (��� ����������) }
   query CommonDocumentOpenNewTab(aUserType: Integer);
 end;//Document*)

(* Document = operations
   ['{72B33973-6922-473A-9B51-C39A56D9F1E4}']
   operation Open;
   operation OpenInNewTab;
   operation OpenNewWindow;
   operation PrintDialog;
   operation PrintPreview;
   operation Save;
   operation Print;
 end;//Document*)

(* NavigatorElement = operations
   ['{C0F65908-CE7A-4F63-AAE7-3956008D42E7}']
   operation Info;
   operation Execute;
 end;//NavigatorElement*)

(* Fake = operations
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=236719144 }
   ['{D9C0A975-8339-4F55-AC58-3E07718997AC}']
   FormActivate Fake;
 end;//Fake*)

(* Redactions = operations
   ['{409D1058-3DC4-41A3-AE91-CD61CD05ED59}']
   operation OpenRedactionListFrmAct; has states;
     {* ������ �������� }
      ChooseAnotherEditions = state
       { ������� ������ �������� }
      end;//ChooseAnotherEditions
   query RedactionOnID(aRedactionID: TRedactionID);
   operation ActualRedaction;
   operation OpenRedactionListFrmAct; has states;
     {* ������ �������� }
   operation PrevRedaction;
   operation NextRedaction;
 end;//Redactions*)

type
 INavigator_SetCurrent_Params = interface(IUnknown)
  {* ��������� ��� �������� Navigator.SetCurrent }
   ['{4F1D0BCC-66F3-41EA-B7A5-C583BD86B54A}']
   function Get_Node: Il3SimpleNode;
   property Node: Il3SimpleNode
     read Get_Node;
     {* undefined }
 end;//INavigator_SetCurrent_Params

 Op_Navigator_SetCurrent = class
  {* ����� ��� ������ �������� Navigator.SetCurrent }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Navigator.SetCurrent � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Navigator.SetCurrent � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Navigator.SetCurrent � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Navigator.SetCurrent � ���������� }
 end;//Op_Navigator_SetCurrent

 IDocument_OpenCorrespondentList_Params = interface(IUnknown)
  {* ��������� ��� �������� Document.OpenCorrespondentList }
   ['{1B2A4163-9A33-4037-87A4-391412220698}']
   function Get_Kind: TlstCRType;
   function Get_CRType: Il3SimpleNode;
   property Kind: TlstCRType
     read Get_Kind;
     {* undefined }
   property CRType: Il3SimpleNode
     read Get_CRType;
     {* undefined }
 end;//IDocument_OpenCorrespondentList_Params

 Op_Document_OpenCorrespondentList = class
  {* ����� ��� ������ �������� Document.OpenCorrespondentList }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Document.OpenCorrespondentList � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Document.OpenCorrespondentList � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Document.OpenCorrespondentList � ����� }
   class function Call(const aTarget: IvcmContainer;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Document.OpenCorrespondentList � ���������� }
 end;//Op_Document_OpenCorrespondentList

 IDocument_OpenRespondentList_Params = interface(IUnknown)
  {* ��������� ��� �������� Document.OpenRespondentList }
   ['{A68D4EA7-1BFF-4C30-921A-66C442F2B7DB}']
   function Get_Kind: TlstCRType;
   function Get_CRType: Il3SimpleNode;
   property Kind: TlstCRType
     read Get_Kind;
     {* undefined }
   property CRType: Il3SimpleNode
     read Get_CRType;
     {* undefined }
 end;//IDocument_OpenRespondentList_Params

 Op_Document_OpenRespondentList = class
  {* ����� ��� ������ �������� Document.OpenRespondentList }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Document.OpenRespondentList � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Document.OpenRespondentList � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Document.OpenRespondentList � ����� }
   class function Call(const aTarget: IvcmContainer;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload; 
     {* ����� �������� Document.OpenRespondentList � ���������� }
 end;//Op_Document_OpenRespondentList

 IDocument_AttributesCanBeClosed_Params = interface(IUnknown)
  {* ��������� ��� �������� Document.AttributesCanBeClosed }
   ['{634A888C-D678-4FC7-9922-86C944C29BD4}']
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IDocument_AttributesCanBeClosed_Params

 Op_Document_AttributesCanBeClosed = class
  {* ����� ��� ������ �������� Document.AttributesCanBeClosed }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� Document.AttributesCanBeClosed � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� Document.AttributesCanBeClosed � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� Document.AttributesCanBeClosed � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� Document.AttributesCanBeClosed � ���������� }
 end;//Op_Document_AttributesCanBeClosed

 IDocument_CommonDocumentOpenNewWindow_Params = interface(IUnknown)
  {* ��������� ��� �������� Document.CommonDocumentOpenNewWindow }
   ['{86B3F0E0-FDF1-42F2-B847-94AAD63366A1}']
   function Get_UserType: Integer;
   property UserType: Integer
     read Get_UserType;
     {* undefined }
 end;//IDocument_CommonDocumentOpenNewWindow_Params

 Op_Document_CommonDocumentOpenNewWindow = class
  {* ����� ��� ������ �������� Document.CommonDocumentOpenNewWindow }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aUserType: Integer): Boolean; overload; 
     {* ����� �������� Document.CommonDocumentOpenNewWindow � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aUserType: Integer): Boolean; overload; 
     {* ����� �������� Document.CommonDocumentOpenNewWindow � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aUserType: Integer): Boolean; overload; 
     {* ����� �������� Document.CommonDocumentOpenNewWindow � ����� }
   class function Call(const aTarget: IvcmContainer;
    aUserType: Integer): Boolean; overload; 
     {* ����� �������� Document.CommonDocumentOpenNewWindow � ���������� }
 end;//Op_Document_CommonDocumentOpenNewWindow

 IDocument_CommonDocumentOpenNewTab_Params = interface(IUnknown)
  {* ��������� ��� �������� Document.CommonDocumentOpenNewTab }
   ['{9F649AA8-4BA6-4303-A57B-679A64120DCF}']
   function Get_UserType: Integer;
   property UserType: Integer
     read Get_UserType;
     {* undefined }
 end;//IDocument_CommonDocumentOpenNewTab_Params

 Op_Document_CommonDocumentOpenNewTab = class
  {* ����� ��� ������ �������� Document.CommonDocumentOpenNewTab }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aUserType: Integer): Boolean; overload; 
     {* ����� �������� Document.CommonDocumentOpenNewTab � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aUserType: Integer): Boolean; overload; 
     {* ����� �������� Document.CommonDocumentOpenNewTab � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aUserType: Integer): Boolean; overload; 
     {* ����� �������� Document.CommonDocumentOpenNewTab � ����� }
   class function Call(const aTarget: IvcmContainer;
    aUserType: Integer): Boolean; overload; 
     {* ����� �������� Document.CommonDocumentOpenNewTab � ���������� }
 end;//Op_Document_CommonDocumentOpenNewTab

 IRedactions_RedactionOnID_Params = interface(IUnknown)
  {* ��������� ��� �������� Redactions.RedactionOnID }
   ['{92C237BD-F783-4B25-A09E-8B35B9216491}']
   function Get_RedactionID: TRedactionID;
   property RedactionID: TRedactionID
     read Get_RedactionID;
     {* undefined }
 end;//IRedactions_RedactionOnID_Params

 Op_Redactions_RedactionOnID = class
  {* ����� ��� ������ �������� Redactions.RedactionOnID }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aRedactionID: TRedactionID): Boolean; overload; 
     {* ����� �������� Redactions.RedactionOnID � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aRedactionID: TRedactionID): Boolean; overload; 
     {* ����� �������� Redactions.RedactionOnID � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aRedactionID: TRedactionID): Boolean; overload; 
     {* ����� �������� Redactions.RedactionOnID � ����� }
   class function Call(const aTarget: IvcmContainer;
    aRedactionID: TRedactionID): Boolean; overload; 
     {* ����� �������� Redactions.RedactionOnID � ���������� }
 end;//Op_Redactions_RedactionOnID
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Navigator = 'Navigator';
 en_capNavigator = '';
 op_SetCurrent = 'SetCurrent';
 op_capSetCurrent = '';
 en_Document = 'Document';
 en_capDocument = '��������';
 op_GetAttributesFrmAct = 'GetAttributesFrmAct';
 op_capGetAttributesFrmAct = '���������� � ���������';
 op_OpenCorrespondentList = 'OpenCorrespondentList';
 op_capOpenCorrespondentList = '�������, ��� ���?';
 op_OpenRespondentList = 'OpenRespondentList';
 op_capOpenRespondentList = '�������, ��� ���?';
 op_GetRelatedDocFrmAct = 'GetRelatedDocFrmAct';
 op_capGetRelatedDocFrmAct = '������� � ���������';
 op_GetCorrespondentList = 'GetCorrespondentList';
 op_capGetCorrespondentList = '������ �� ��������';
 op_GetRespondentList = 'GetRespondentList';
 op_capGetRespondentList = '������ �� ���������';
 op_AttributesCanBeClosed = 'AttributesCanBeClosed';
 op_capAttributesCanBeClosed = '��� �������� �� ������� � Facet ��� ���-�� ��������';
 op_CommonDocumentOpenNewWindow = 'CommonDocumentOpenNewWindow';
 op_capCommonDocumentOpenNewWindow = '��� ���?';
 op_GetCorrespondentListExFrmAct = 'GetCorrespondentListExFrmAct';
 op_capGetCorrespondentListExFrmAct = '������ �� �������� (��� ����������)';
 op_GetRespondentListExFrmAct = 'GetRespondentListExFrmAct';
 op_capGetRespondentListExFrmAct = '������ �� ��������� (��� ����������)';
 op_CommonDocumentOpenNewTab = 'CommonDocumentOpenNewTab';
 op_capCommonDocumentOpenNewTab = '';
 op_Open = 'Open';
 op_capOpen = '';
 op_OpenInNewTab = 'OpenInNewTab';
 op_capOpenInNewTab = '';
 op_OpenNewWindow = 'OpenNewWindow';
 op_capOpenNewWindow = '';
 op_PrintDialog = 'PrintDialog';
 op_capPrintDialog = '';
 op_PrintPreview = 'PrintPreview';
 op_capPrintPreview = '';
 op_Save = 'Save';
 op_capSave = '';
 op_Print = 'Print';
 op_capPrint = '';
 en_NavigatorElement = 'NavigatorElement';
 en_capNavigatorElement = '';
 op_Info = 'Info';
 op_capInfo = '';
 op_Execute = 'Execute';
 op_capExecute = '';
 en_Fake = 'Fake';
 en_capFake = 'http://mdp.garant.ru/pages/viewpage.action?pageId=236719144';
 op_Fake = 'Fake';
 op_capFake = '';
 en_Redactions = 'Redactions';
 en_capRedactions = '';
 op_OpenRedactionListFrmAct = 'OpenRedactionListFrmAct';
 op_capOpenRedactionListFrmAct = '������ ��������';
 op_RedactionOnID = 'RedactionOnID';
 op_capRedactionOnID = '';
 op_ActualRedaction = 'ActualRedaction';
 op_capActualRedaction = '';
 op_PrevRedaction = 'PrevRedaction';
 op_capPrevRedaction = '';
 op_NextRedaction = 'NextRedaction';
 op_capNextRedaction = '';

// ��������� ��������:
var st_user_Document_GetAttributesFrmAct_Picture : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ���������� � ��������� <-> ���������� � ��������
var st_user_Redactions_OpenRedactionListFrmAct_ChooseAnotherEditions : TvcmOperationStateIndex = (rID : -1);
  // Redactions -> ������ �������� <-> ������� ������ ��������
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TNavigator_SetCurrent_Params = class(Tl3CProtoObject, INavigator_SetCurrent_Params)
  {* ���������� INavigator_SetCurrent_Params }
 private
 // private fields
   f_Node : Il3SimpleNode;
 protected
 // realized methods
   function Get_Node: Il3SimpleNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(const aNode: Il3SimpleNode); reintroduce;
     {* ����������� TNavigator_SetCurrent_Params }
   class function Make(const aNode: Il3SimpleNode): INavigator_SetCurrent_Params; reintroduce;
     {* ������� TNavigator_SetCurrent_Params }
 end;//TNavigator_SetCurrent_Params

// start class TNavigator_SetCurrent_Params

constructor TNavigator_SetCurrent_Params.Create(const aNode: Il3SimpleNode);
 {-}
begin
 inherited Create;
 f_Node := aNode;
end;//TNavigator_SetCurrent_Params.Create

class function TNavigator_SetCurrent_Params.Make(const aNode: Il3SimpleNode): INavigator_SetCurrent_Params;
var
 l_Inst : TNavigator_SetCurrent_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TNavigator_SetCurrent_Params.Get_Node: Il3SimpleNode;
 {-}
begin
 Result := f_Node;
end;//TNavigator_SetCurrent_Params.Get_Node

procedure TNavigator_SetCurrent_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TNavigator_SetCurrent_Params.ClearFields
// start class Op_Navigator_SetCurrent

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmEntity;
  const aNode: Il3SimpleNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TNavigator_SetCurrent_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_Navigator_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Navigator_SetCurrent.Call

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmAggregate;
  const aNode: Il3SimpleNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TNavigator_SetCurrent_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_Navigator_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Navigator_SetCurrent.Call

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmEntityForm;
  const aNode: Il3SimpleNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_Navigator_SetCurrent.Call

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmContainer;
  const aNode: Il3SimpleNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_Navigator_SetCurrent.Call

type
 TDocument_OpenCorrespondentList_Params = class(Tl3CProtoObject, IDocument_OpenCorrespondentList_Params)
  {* ���������� IDocument_OpenCorrespondentList_Params }
 private
 // private fields
   f_Kind : TlstCRType;
   f_CRType : Il3SimpleNode;
 protected
 // realized methods
   function Get_CRType: Il3SimpleNode;
   function Get_Kind: TlstCRType;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(aKind: TlstCRType;
    const aCRType: Il3SimpleNode); reintroduce;
     {* ����������� TDocument_OpenCorrespondentList_Params }
   class function Make(aKind: TlstCRType;
    const aCRType: Il3SimpleNode): IDocument_OpenCorrespondentList_Params; reintroduce;
     {* ������� TDocument_OpenCorrespondentList_Params }
 end;//TDocument_OpenCorrespondentList_Params

// start class TDocument_OpenCorrespondentList_Params

constructor TDocument_OpenCorrespondentList_Params.Create(aKind: TlstCRType;
  const aCRType: Il3SimpleNode);
 {-}
begin
 inherited Create;
 f_Kind := aKind;
 f_CRType := aCRType;
end;//TDocument_OpenCorrespondentList_Params.Create

class function TDocument_OpenCorrespondentList_Params.Make(aKind: TlstCRType;
  const aCRType: Il3SimpleNode): IDocument_OpenCorrespondentList_Params;
var
 l_Inst : TDocument_OpenCorrespondentList_Params;
begin
 l_Inst := Create(aKind, aCRType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_OpenCorrespondentList_Params.Get_CRType: Il3SimpleNode;
 {-}
begin
 Result := f_CRType;
end;//TDocument_OpenCorrespondentList_Params.Get_CRType

function TDocument_OpenCorrespondentList_Params.Get_Kind: TlstCRType;
 {-}
begin
 Result := f_Kind;
end;//TDocument_OpenCorrespondentList_Params.Get_Kind

procedure TDocument_OpenCorrespondentList_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_CRType := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_OpenCorrespondentList_Params.ClearFields
// start class Op_Document_OpenCorrespondentList

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmEntity;
  aKind: TlstCRType;
  const aCRType: Il3SimpleNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenCorrespondentList_Params.Make(aKind,aCRType));
  aTarget.Operation(TdmStdRes.opcode_Document_OpenCorrespondentList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenCorrespondentList.Call

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmAggregate;
  aKind: TlstCRType;
  const aCRType: Il3SimpleNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenCorrespondentList_Params.Make(aKind,aCRType));
  aTarget.Operation(TdmStdRes.opcode_Document_OpenCorrespondentList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenCorrespondentList.Call

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmEntityForm;
  aKind: TlstCRType;
  const aCRType: Il3SimpleNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aKind, aCRType);
end;//Op_Document_OpenCorrespondentList.Call

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmContainer;
  aKind: TlstCRType;
  const aCRType: Il3SimpleNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aKind, aCRType);
end;//Op_Document_OpenCorrespondentList.Call

type
 TDocument_OpenRespondentList_Params = class(Tl3CProtoObject, IDocument_OpenRespondentList_Params)
  {* ���������� IDocument_OpenRespondentList_Params }
 private
 // private fields
   f_Kind : TlstCRType;
   f_CRType : Il3SimpleNode;
 protected
 // realized methods
   function Get_CRType: Il3SimpleNode;
   function Get_Kind: TlstCRType;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(aKind: TlstCRType;
    const aCRType: Il3SimpleNode); reintroduce;
     {* ����������� TDocument_OpenRespondentList_Params }
   class function Make(aKind: TlstCRType;
    const aCRType: Il3SimpleNode): IDocument_OpenRespondentList_Params; reintroduce;
     {* ������� TDocument_OpenRespondentList_Params }
 end;//TDocument_OpenRespondentList_Params

// start class TDocument_OpenRespondentList_Params

constructor TDocument_OpenRespondentList_Params.Create(aKind: TlstCRType;
  const aCRType: Il3SimpleNode);
 {-}
begin
 inherited Create;
 f_Kind := aKind;
 f_CRType := aCRType;
end;//TDocument_OpenRespondentList_Params.Create

class function TDocument_OpenRespondentList_Params.Make(aKind: TlstCRType;
  const aCRType: Il3SimpleNode): IDocument_OpenRespondentList_Params;
var
 l_Inst : TDocument_OpenRespondentList_Params;
begin
 l_Inst := Create(aKind, aCRType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_OpenRespondentList_Params.Get_CRType: Il3SimpleNode;
 {-}
begin
 Result := f_CRType;
end;//TDocument_OpenRespondentList_Params.Get_CRType

function TDocument_OpenRespondentList_Params.Get_Kind: TlstCRType;
 {-}
begin
 Result := f_Kind;
end;//TDocument_OpenRespondentList_Params.Get_Kind

procedure TDocument_OpenRespondentList_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_CRType := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_OpenRespondentList_Params.ClearFields
// start class Op_Document_OpenRespondentList

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmEntity;
  aKind: TlstCRType;
  const aCRType: Il3SimpleNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenRespondentList_Params.Make(aKind,aCRType));
  aTarget.Operation(TdmStdRes.opcode_Document_OpenRespondentList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenRespondentList.Call

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmAggregate;
  aKind: TlstCRType;
  const aCRType: Il3SimpleNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenRespondentList_Params.Make(aKind,aCRType));
  aTarget.Operation(TdmStdRes.opcode_Document_OpenRespondentList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenRespondentList.Call

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmEntityForm;
  aKind: TlstCRType;
  const aCRType: Il3SimpleNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aKind, aCRType);
end;//Op_Document_OpenRespondentList.Call

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmContainer;
  aKind: TlstCRType;
  const aCRType: Il3SimpleNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aKind, aCRType);
end;//Op_Document_OpenRespondentList.Call

type
 TDocument_AttributesCanBeClosed_Params = class(Tl3CProtoObject, IDocument_AttributesCanBeClosed_Params)
  {* ���������� IDocument_AttributesCanBeClosed_Params }
 private
 // private fields
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
 public
 // public methods
   constructor Create; reintroduce;
     {* ����������� TDocument_AttributesCanBeClosed_Params }
   class function Make: IDocument_AttributesCanBeClosed_Params; reintroduce;
     {* ������� TDocument_AttributesCanBeClosed_Params }
 end;//TDocument_AttributesCanBeClosed_Params

// start class TDocument_AttributesCanBeClosed_Params

constructor TDocument_AttributesCanBeClosed_Params.Create;
 {-}
begin
 inherited Create;
end;//TDocument_AttributesCanBeClosed_Params.Create

class function TDocument_AttributesCanBeClosed_Params.Make: IDocument_AttributesCanBeClosed_Params;
var
 l_Inst : TDocument_AttributesCanBeClosed_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_AttributesCanBeClosed_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TDocument_AttributesCanBeClosed_Params.Get_ResultValue

procedure TDocument_AttributesCanBeClosed_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TDocument_AttributesCanBeClosed_Params.Set_ResultValue
// start class Op_Document_AttributesCanBeClosed

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_AttributesCanBeClosed_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Document_AttributesCanBeClosed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_AttributesCanBeClosed_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_AttributesCanBeClosed.Call

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_AttributesCanBeClosed_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Document_AttributesCanBeClosed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_AttributesCanBeClosed_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_AttributesCanBeClosed.Call

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_AttributesCanBeClosed.Call

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_AttributesCanBeClosed.Call

type
 TDocument_CommonDocumentOpenNewWindow_Params = class(Tl3CProtoObject, IDocument_CommonDocumentOpenNewWindow_Params)
  {* ���������� IDocument_CommonDocumentOpenNewWindow_Params }
 private
 // private fields
   f_UserType : Integer;
 protected
 // realized methods
   function Get_UserType: Integer;
 public
 // public methods
   constructor Create(aUserType: Integer); reintroduce;
     {* ����������� TDocument_CommonDocumentOpenNewWindow_Params }
   class function Make(aUserType: Integer): IDocument_CommonDocumentOpenNewWindow_Params; reintroduce;
     {* ������� TDocument_CommonDocumentOpenNewWindow_Params }
 end;//TDocument_CommonDocumentOpenNewWindow_Params

// start class TDocument_CommonDocumentOpenNewWindow_Params

constructor TDocument_CommonDocumentOpenNewWindow_Params.Create(aUserType: Integer);
 {-}
begin
 inherited Create;
 f_UserType := aUserType;
end;//TDocument_CommonDocumentOpenNewWindow_Params.Create

class function TDocument_CommonDocumentOpenNewWindow_Params.Make(aUserType: Integer): IDocument_CommonDocumentOpenNewWindow_Params;
var
 l_Inst : TDocument_CommonDocumentOpenNewWindow_Params;
begin
 l_Inst := Create(aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_CommonDocumentOpenNewWindow_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_CommonDocumentOpenNewWindow_Params.Get_UserType
// start class Op_Document_CommonDocumentOpenNewWindow

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmEntity;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CommonDocumentOpenNewWindow_Params.Make(aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_CommonDocumentOpenNewWindow, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_CommonDocumentOpenNewWindow.Call

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmAggregate;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CommonDocumentOpenNewWindow_Params.Make(aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_CommonDocumentOpenNewWindow, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_CommonDocumentOpenNewWindow.Call

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmEntityForm;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aUserType);
end;//Op_Document_CommonDocumentOpenNewWindow.Call

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmContainer;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aUserType);
end;//Op_Document_CommonDocumentOpenNewWindow.Call

type
 TDocument_CommonDocumentOpenNewTab_Params = class(Tl3CProtoObject, IDocument_CommonDocumentOpenNewTab_Params)
  {* ���������� IDocument_CommonDocumentOpenNewTab_Params }
 private
 // private fields
   f_UserType : Integer;
 protected
 // realized methods
   function Get_UserType: Integer;
 public
 // public methods
   constructor Create(aUserType: Integer); reintroduce;
     {* ����������� TDocument_CommonDocumentOpenNewTab_Params }
   class function Make(aUserType: Integer): IDocument_CommonDocumentOpenNewTab_Params; reintroduce;
     {* ������� TDocument_CommonDocumentOpenNewTab_Params }
 end;//TDocument_CommonDocumentOpenNewTab_Params

// start class TDocument_CommonDocumentOpenNewTab_Params

constructor TDocument_CommonDocumentOpenNewTab_Params.Create(aUserType: Integer);
 {-}
begin
 inherited Create;
 f_UserType := aUserType;
end;//TDocument_CommonDocumentOpenNewTab_Params.Create

class function TDocument_CommonDocumentOpenNewTab_Params.Make(aUserType: Integer): IDocument_CommonDocumentOpenNewTab_Params;
var
 l_Inst : TDocument_CommonDocumentOpenNewTab_Params;
begin
 l_Inst := Create(aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_CommonDocumentOpenNewTab_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_CommonDocumentOpenNewTab_Params.Get_UserType
// start class Op_Document_CommonDocumentOpenNewTab

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmEntity;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CommonDocumentOpenNewTab_Params.Make(aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_CommonDocumentOpenNewTab, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_CommonDocumentOpenNewTab.Call

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmAggregate;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CommonDocumentOpenNewTab_Params.Make(aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_CommonDocumentOpenNewTab, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_CommonDocumentOpenNewTab.Call

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmEntityForm;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aUserType);
end;//Op_Document_CommonDocumentOpenNewTab.Call

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmContainer;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aUserType);
end;//Op_Document_CommonDocumentOpenNewTab.Call

type
 TRedactions_RedactionOnID_Params = class(Tl3CProtoObject, IRedactions_RedactionOnID_Params)
  {* ���������� IRedactions_RedactionOnID_Params }
 private
 // private fields
   f_RedactionID : TRedactionID;
 protected
 // realized methods
   function Get_RedactionID: TRedactionID;
 public
 // public methods
   constructor Create(aRedactionID: TRedactionID); reintroduce;
     {* ����������� TRedactions_RedactionOnID_Params }
   class function Make(aRedactionID: TRedactionID): IRedactions_RedactionOnID_Params; reintroduce;
     {* ������� TRedactions_RedactionOnID_Params }
 end;//TRedactions_RedactionOnID_Params

// start class TRedactions_RedactionOnID_Params

constructor TRedactions_RedactionOnID_Params.Create(aRedactionID: TRedactionID);
 {-}
begin
 inherited Create;
 f_RedactionID := aRedactionID;
end;//TRedactions_RedactionOnID_Params.Create

class function TRedactions_RedactionOnID_Params.Make(aRedactionID: TRedactionID): IRedactions_RedactionOnID_Params;
var
 l_Inst : TRedactions_RedactionOnID_Params;
begin
 l_Inst := Create(aRedactionID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TRedactions_RedactionOnID_Params.Get_RedactionID: TRedactionID;
 {-}
begin
 Result := f_RedactionID;
end;//TRedactions_RedactionOnID_Params.Get_RedactionID
// start class Op_Redactions_RedactionOnID

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmEntity;
  aRedactionID: TRedactionID): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRedactions_RedactionOnID_Params.Make(aRedactionID));
  aTarget.Operation(TdmStdRes.opcode_Redactions_RedactionOnID, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Redactions_RedactionOnID.Call

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmAggregate;
  aRedactionID: TRedactionID): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRedactions_RedactionOnID_Params.Make(aRedactionID));
  aTarget.Operation(TdmStdRes.opcode_Redactions_RedactionOnID, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Redactions_RedactionOnID.Call

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmEntityForm;
  aRedactionID: TRedactionID): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aRedactionID);
end;//Op_Redactions_RedactionOnID.Call

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmContainer;
  aRedactionID: TRedactionID): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aRedactionID);
end;//Op_Redactions_RedactionOnID.Call
{$IfEnd} //not Admin AND not Monitorings


end.