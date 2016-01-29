unit CompareEditions_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/CompareEditions_Controls.pas"
// �����: 17.08.2009 19:42
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 ���������������� �������::CompareEditions::View::CompareEditions
//
// �������� ����������� ��� ��������� ��������
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
  Base_Operations_Editions_Controls,
  NavigationInterfaces,
  l3CProtoObject
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* Edition = operations(Edition)
  {* �������� }
   ['{77590ED6-A851-4EE4-A8BB-C9845678E43D}']
   operation PrevChange;
     {* ���������� ��������� }
   operation NextChange;
     {* ��������� ��������� }
 end;//Edition*)

type
 TGotoParaResult = (
  {* ��������� �������� �� �������� }
   gtprFail // ���������
 , gtprOk // �������
 , gtprAlready // ��� ������ �� ���� ���������
 );//TGotoParaResult

(* Document = operations
   ['{AF1A5DE8-20AA-4177-81A6-8C3BFE9C95C5}']
   query OpenEditionLocalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour);
     {* ������� �� ��������� ������ �� �������� }
 end;//Document*)

(* RightEdition = operations
  {* ������� �������� }
   ['{5D657D01-C18A-4C17-B92E-5C655BA3BC0F}']
   query ReturnToDocument;
     {* ��������� � ����� ��������� }
   query SetFocusToText;
     {* ������������� ����� ������ }
   query IsCurrentPara(aPara: Integer): Boolean;
     {* �������� �� �������� ������� }
 end;//RightEdition*)

(* Finder = operations
  {* ���������� ��� ������ }
   ['{844484DD-424E-4430-AFED-E88BE3F7DC56}']
   query GotoPara(aPara: Integer): TGotoParaResult;
     {* ������� � ��������� �� ������ }
   query DisableForceDrawFocusRect;
     {* ��������� ��������� �������� ����� }
 end;//Finder*)

 IDocument_OpenEditionLocalLink_Params = interface(IUnknown)
  {* ��������� ��� �������� Document.OpenEditionLocalLink }
   ['{14D37F98-4FEA-468A-8938-DC976BB1F999}']
   function Get_Document: IDocument;
   function Get_Sub: Cardinal;
   function Get_Behaviour: TbsProcessHyperLinkBehaviour;
   property Document: IDocument
     read Get_Document;
     {* undefined }
   property Sub: Cardinal
     read Get_Sub;
     {* undefined }
   property Behaviour: TbsProcessHyperLinkBehaviour
     read Get_Behaviour;
     {* undefined }
 end;//IDocument_OpenEditionLocalLink_Params

 Op_Document_OpenEditionLocalLink = class
  {* ����� ��� ������ �������� Document.OpenEditionLocalLink }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload; 
     {* ����� �������� Document.OpenEditionLocalLink � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload; 
     {* ����� �������� Document.OpenEditionLocalLink � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload; 
     {* ����� �������� Document.OpenEditionLocalLink � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload; 
     {* ����� �������� Document.OpenEditionLocalLink � ���������� }
 end;//Op_Document_OpenEditionLocalLink

 Op_RightEdition_ReturnToDocument = class
  {* ����� ��� ������ �������� RightEdition.ReturnToDocument }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� RightEdition.ReturnToDocument � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� RightEdition.ReturnToDocument � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� RightEdition.ReturnToDocument � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� RightEdition.ReturnToDocument � ���������� }
 end;//Op_RightEdition_ReturnToDocument

 Op_RightEdition_SetFocusToText = class
  {* ����� ��� ������ �������� RightEdition.SetFocusToText }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� RightEdition.SetFocusToText � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� RightEdition.SetFocusToText � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� RightEdition.SetFocusToText � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� RightEdition.SetFocusToText � ���������� }
 end;//Op_RightEdition_SetFocusToText

 IRightEdition_IsCurrentPara_Params = interface(IUnknown)
  {* ��������� ��� �������� RightEdition.IsCurrentPara }
   ['{C973500C-ADAC-48EB-A19A-E362ADE07D19}']
   function Get_Para: Integer;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property Para: Integer
     read Get_Para;
     {* undefined }
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IRightEdition_IsCurrentPara_Params

 Op_RightEdition_IsCurrentPara = class
  {* ����� ��� ������ �������� RightEdition.IsCurrentPara }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aPara: Integer): Boolean; overload; 
     {* ����� �������� RightEdition.IsCurrentPara � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aPara: Integer): Boolean; overload; 
     {* ����� �������� RightEdition.IsCurrentPara � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aPara: Integer): Boolean; overload; 
     {* ����� �������� RightEdition.IsCurrentPara � ����� }
   class function Call(const aTarget: IvcmContainer;
    aPara: Integer): Boolean; overload; 
     {* ����� �������� RightEdition.IsCurrentPara � ���������� }
 end;//Op_RightEdition_IsCurrentPara

 IFinder_GotoPara_Params = interface(IUnknown)
  {* ��������� ��� �������� Finder.GotoPara }
   ['{C07EBC14-D098-4B33-A28C-40AEBC95BCCC}']
   function Get_Para: Integer;
   function Get_ResultValue: TGotoParaResult;
   procedure Set_ResultValue(aValue: TGotoParaResult);
   property Para: Integer
     read Get_Para;
     {* undefined }
   property ResultValue: TGotoParaResult
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IFinder_GotoPara_Params

 Op_Finder_GotoPara = class
  {* ����� ��� ������ �������� Finder.GotoPara }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aPara: Integer): TGotoParaResult; overload; 
     {* ����� �������� Finder.GotoPara � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aPara: Integer): TGotoParaResult; overload; 
     {* ����� �������� Finder.GotoPara � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aPara: Integer): TGotoParaResult; overload; 
     {* ����� �������� Finder.GotoPara � ����� }
   class function Call(const aTarget: IvcmContainer;
    aPara: Integer): TGotoParaResult; overload; 
     {* ����� �������� Finder.GotoPara � ���������� }
 end;//Op_Finder_GotoPara

 Op_Finder_DisableForceDrawFocusRect = class
  {* ����� ��� ������ �������� Finder.DisableForceDrawFocusRect }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� Finder.DisableForceDrawFocusRect � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� Finder.DisableForceDrawFocusRect � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� Finder.DisableForceDrawFocusRect � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� Finder.DisableForceDrawFocusRect � ���������� }
 end;//Op_Finder_DisableForceDrawFocusRect
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Edition = Base_Operations_Editions_Controls.en_Edition;
 en_capEdition = Base_Operations_Editions_Controls.en_capEdition;
 op_PrevChange = 'PrevChange';
 op_capPrevChange = '���������� ���������';
 op_NextChange = 'NextChange';
 op_capNextChange = '��������� ���������';
 en_Document = 'Document';
 en_capDocument = '';
 op_OpenEditionLocalLink = 'OpenEditionLocalLink';
 op_capOpenEditionLocalLink = '������� �� ��������� ������ �� ��������';
 en_RightEdition = 'RightEdition';
 en_capRightEdition = '������� ��������';
 op_ReturnToDocument = 'ReturnToDocument';
 op_capReturnToDocument = '��������� � ����� ���������';
 op_SetFocusToText = 'SetFocusToText';
 op_capSetFocusToText = '������������� ����� ������';
 op_IsCurrentPara = 'IsCurrentPara';
 op_capIsCurrentPara = '�������� �� �������� �������';
 en_Finder = 'Finder';
 en_capFinder = '���������� ��� ������';
 op_GotoPara = 'GotoPara';
 op_capGotoPara = '������� � ��������� �� ������';
 op_DisableForceDrawFocusRect = 'DisableForceDrawFocusRect';
 op_capDisableForceDrawFocusRect = '��������� ��������� �������� �����';
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TDocument_OpenEditionLocalLink_Params = class(Tl3CProtoObject, IDocument_OpenEditionLocalLink_Params)
  {* ���������� IDocument_OpenEditionLocalLink_Params }
 private
 // private fields
   f_Document : IDocument;
   f_Sub : Cardinal;
   f_Behaviour : TbsProcessHyperLinkBehaviour;
 protected
 // realized methods
   function Get_Sub: Cardinal;
   function Get_Document: IDocument;
   function Get_Behaviour: TbsProcessHyperLinkBehaviour;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); reintroduce;
     {* ����������� TDocument_OpenEditionLocalLink_Params }
   class function Make(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): IDocument_OpenEditionLocalLink_Params; reintroduce;
     {* ������� TDocument_OpenEditionLocalLink_Params }
 end;//TDocument_OpenEditionLocalLink_Params

// start class TDocument_OpenEditionLocalLink_Params

constructor TDocument_OpenEditionLocalLink_Params.Create(const aDocument: IDocument;
  aSub: Cardinal;
  aBehaviour: TbsProcessHyperLinkBehaviour);
 {-}
begin
 inherited Create;
 f_Document := aDocument;
 f_Sub := aSub;
 f_Behaviour := aBehaviour;
end;//TDocument_OpenEditionLocalLink_Params.Create

class function TDocument_OpenEditionLocalLink_Params.Make(const aDocument: IDocument;
  aSub: Cardinal;
  aBehaviour: TbsProcessHyperLinkBehaviour): IDocument_OpenEditionLocalLink_Params;
var
 l_Inst : TDocument_OpenEditionLocalLink_Params;
begin
 l_Inst := Create(aDocument, aSub, aBehaviour);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_OpenEditionLocalLink_Params.Get_Sub: Cardinal;
 {-}
begin
 Result := f_Sub;
end;//TDocument_OpenEditionLocalLink_Params.Get_Sub

function TDocument_OpenEditionLocalLink_Params.Get_Document: IDocument;
 {-}
begin
 Result := f_Document;
end;//TDocument_OpenEditionLocalLink_Params.Get_Document

function TDocument_OpenEditionLocalLink_Params.Get_Behaviour: TbsProcessHyperLinkBehaviour;
 {-}
begin
 Result := f_Behaviour;
end;//TDocument_OpenEditionLocalLink_Params.Get_Behaviour

procedure TDocument_OpenEditionLocalLink_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Document := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_OpenEditionLocalLink_Params.ClearFields
// start class Op_Document_OpenEditionLocalLink

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmEntity;
  const aDocument: IDocument;
  aSub: Cardinal;
  aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenEditionLocalLink_Params.Make(aDocument,aSub,aBehaviour));
  aTarget.Operation(TdmStdRes.opcode_Document_OpenEditionLocalLink, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenEditionLocalLink.Call

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmAggregate;
  const aDocument: IDocument;
  aSub: Cardinal;
  aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenEditionLocalLink_Params.Make(aDocument,aSub,aBehaviour));
  aTarget.Operation(TdmStdRes.opcode_Document_OpenEditionLocalLink, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenEditionLocalLink.Call

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmEntityForm;
  const aDocument: IDocument;
  aSub: Cardinal;
  aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aDocument, aSub, aBehaviour);
end;//Op_Document_OpenEditionLocalLink.Call

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmContainer;
  const aDocument: IDocument;
  aSub: Cardinal;
  aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aDocument, aSub, aBehaviour);
end;//Op_Document_OpenEditionLocalLink.Call
// start class Op_RightEdition_ReturnToDocument

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_RightEdition_ReturnToDocument, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_RightEdition_ReturnToDocument.Call

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_RightEdition_ReturnToDocument, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_RightEdition_ReturnToDocument.Call

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_RightEdition_ReturnToDocument.Call

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_RightEdition_ReturnToDocument.Call
// start class Op_RightEdition_SetFocusToText

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_RightEdition_SetFocusToText, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_RightEdition_SetFocusToText.Call

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_RightEdition_SetFocusToText, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_RightEdition_SetFocusToText.Call

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_RightEdition_SetFocusToText.Call

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_RightEdition_SetFocusToText.Call

type
 TRightEdition_IsCurrentPara_Params = class(Tl3CProtoObject, IRightEdition_IsCurrentPara_Params)
  {* ���������� IRightEdition_IsCurrentPara_Params }
 private
 // private fields
   f_Para : Integer;
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_Para: Integer;
 public
 // public methods
   constructor Create(aPara: Integer); reintroduce;
     {* ����������� TRightEdition_IsCurrentPara_Params }
   class function Make(aPara: Integer): IRightEdition_IsCurrentPara_Params; reintroduce;
     {* ������� TRightEdition_IsCurrentPara_Params }
 end;//TRightEdition_IsCurrentPara_Params

// start class TRightEdition_IsCurrentPara_Params

constructor TRightEdition_IsCurrentPara_Params.Create(aPara: Integer);
 {-}
begin
 inherited Create;
 f_Para := aPara;
end;//TRightEdition_IsCurrentPara_Params.Create

class function TRightEdition_IsCurrentPara_Params.Make(aPara: Integer): IRightEdition_IsCurrentPara_Params;
var
 l_Inst : TRightEdition_IsCurrentPara_Params;
begin
 l_Inst := Create(aPara);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TRightEdition_IsCurrentPara_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TRightEdition_IsCurrentPara_Params.Get_ResultValue

procedure TRightEdition_IsCurrentPara_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TRightEdition_IsCurrentPara_Params.Set_ResultValue

function TRightEdition_IsCurrentPara_Params.Get_Para: Integer;
 {-}
begin
 Result := f_Para;
end;//TRightEdition_IsCurrentPara_Params.Get_Para
// start class Op_RightEdition_IsCurrentPara

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmEntity;
  aPara: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRightEdition_IsCurrentPara_Params.Make(aPara));
  aTarget.Operation(TdmStdRes.opcode_RightEdition_IsCurrentPara, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IRightEdition_IsCurrentPara_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_RightEdition_IsCurrentPara.Call

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmAggregate;
  aPara: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRightEdition_IsCurrentPara_Params.Make(aPara));
  aTarget.Operation(TdmStdRes.opcode_RightEdition_IsCurrentPara, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IRightEdition_IsCurrentPara_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_RightEdition_IsCurrentPara.Call

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmEntityForm;
  aPara: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aPara);
end;//Op_RightEdition_IsCurrentPara.Call

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmContainer;
  aPara: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aPara);
end;//Op_RightEdition_IsCurrentPara.Call

type
 TFinder_GotoPara_Params = class(Tl3CProtoObject, IFinder_GotoPara_Params)
  {* ���������� IFinder_GotoPara_Params }
 private
 // private fields
   f_Para : Integer;
   f_ResultValue : TGotoParaResult;
 protected
 // realized methods
   function Get_ResultValue: TGotoParaResult;
   procedure Set_ResultValue(aValue: TGotoParaResult);
   function Get_Para: Integer;
 public
 // public methods
   constructor Create(aPara: Integer); reintroduce;
     {* ����������� TFinder_GotoPara_Params }
   class function Make(aPara: Integer): IFinder_GotoPara_Params; reintroduce;
     {* ������� TFinder_GotoPara_Params }
 end;//TFinder_GotoPara_Params

// start class TFinder_GotoPara_Params

constructor TFinder_GotoPara_Params.Create(aPara: Integer);
 {-}
begin
 inherited Create;
 f_Para := aPara;
end;//TFinder_GotoPara_Params.Create

class function TFinder_GotoPara_Params.Make(aPara: Integer): IFinder_GotoPara_Params;
var
 l_Inst : TFinder_GotoPara_Params;
begin
 l_Inst := Create(aPara);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFinder_GotoPara_Params.Get_ResultValue: TGotoParaResult;
 {-}
begin
 Result := f_ResultValue;
end;//TFinder_GotoPara_Params.Get_ResultValue

procedure TFinder_GotoPara_Params.Set_ResultValue(aValue: TGotoParaResult);
 {-}
begin
 f_ResultValue := aValue;
end;//TFinder_GotoPara_Params.Set_ResultValue

function TFinder_GotoPara_Params.Get_Para: Integer;
 {-}
begin
 Result := f_Para;
end;//TFinder_GotoPara_Params.Get_Para
// start class Op_Finder_GotoPara

class function Op_Finder_GotoPara.Call(const aTarget: IvcmEntity;
  aPara: Integer): TGotoParaResult;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFinder_GotoPara_Params.Make(aPara));
  aTarget.Operation(TdmStdRes.opcode_Finder_GotoPara, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFinder_GotoPara_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Finder_GotoPara.Call

class function Op_Finder_GotoPara.Call(const aTarget: IvcmAggregate;
  aPara: Integer): TGotoParaResult;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFinder_GotoPara_Params.Make(aPara));
  aTarget.Operation(TdmStdRes.opcode_Finder_GotoPara, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFinder_GotoPara_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Finder_GotoPara.Call

class function Op_Finder_GotoPara.Call(const aTarget: IvcmEntityForm;
  aPara: Integer): TGotoParaResult;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aPara);
end;//Op_Finder_GotoPara.Call

class function Op_Finder_GotoPara.Call(const aTarget: IvcmContainer;
  aPara: Integer): TGotoParaResult;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aPara);
end;//Op_Finder_GotoPara.Call
// start class Op_Finder_DisableForceDrawFocusRect

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Finder_DisableForceDrawFocusRect, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Finder_DisableForceDrawFocusRect.Call

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Finder_DisableForceDrawFocusRect, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Finder_DisableForceDrawFocusRect.Call

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Finder_DisableForceDrawFocusRect.Call

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Finder_DisableForceDrawFocusRect.Call
{$IfEnd} //not Admin AND not Monitorings


end.