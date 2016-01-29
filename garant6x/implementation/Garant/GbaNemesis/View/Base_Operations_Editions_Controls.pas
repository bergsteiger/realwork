unit Base_Operations_Editions_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Base_Operations_Editions_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Base Operations::View::Editions
//
// ������ � ����������
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
  eeInterfaces,
  l3CProtoObject
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  bsTypesNew,
  vcmExternalInterfaces {a}
  ;

(* Document = operations
  {* �������� }
   ['{E6133E72-90FC-42BD-8185-B948516EF928}']
   operation CompareEditions; has states;
     {* ��������� �������� }
      ShowChanges = state
       { �������� ��������� }
      end;//ShowChanges
 end;//Document*)

(* Document = operations
  {* �������� }
   ['{B5689339-7724-4B4B-BA49-AC5935A3C21C}']
   operation ShowChanges; has states;
     {* �������� ��������� }
 end;//Document*)

(* Document = operations
  {* �������� }
   ['{B4889A6E-0CC4-419E-A0FC-159BD1C51512}']
   operation ViewChangedFragments;
     {* ����� ��������� ��������� }
 end;//Document*)

(* Document = operations({, �� ��������� ��������� ��������� ������ ���� ����������� ������������ � ��������� ��������, ���� � ������ �� �������� ������� Sub, �� ���� ���������� �� ���� Sub ����� ���������� �������})
   ['{26F4B9DD-3130-4CCC-8C3B-473BF52AC5F5}']
   query SetPosition(aPointID: Cardinal;
    aPointType: TDocumentPositionType = dptSub;
    aUserType: Integer = 0): Boolean;
 end;//Document*)

(* Edition = operations
  {* �������� }
   ['{704999C7-AD3A-4C0A-B8F3-6674237E8B6A}']
   operation ReturnToDocument;
     {* ��������� � ����� ��������� }
 end;//Edition*)

(* Document = operations(Document{, ���� �� ������ �������� ����������� ��� ��� ��, �� �� ����������� ������ ����������� ������� ������� ��������})
   ['{CDF479C1-910F-404F-985D-6969A340448A}']
   operation GetParaForPositionning: IeeLeafPara;
 end;//Document*)

type
 IDocument_SetPosition_Params = interface(IUnknown)
  {* ��������� ��� �������� Document.SetPosition }
   ['{1787C467-17B6-4E3F-B610-EF24112F0BBE}']
   function Get_PointID: Cardinal;
   function Get_PointType: TDocumentPositionType;
   function Get_UserType: Integer;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property PointID: Cardinal
     read Get_PointID;
     {* undefined }
   property PointType: TDocumentPositionType
     read Get_PointType;
     {* undefined }
   property UserType: Integer
     read Get_UserType;
     {* undefined }
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IDocument_SetPosition_Params

 Op_Document_SetPosition = class
  {* ����� ��� ������ �������� Document.SetPosition }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = dptSub;
    aUserType: Integer = 0): Boolean; overload; 
     {* ����� �������� Document.SetPosition � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = dptSub;
    aUserType: Integer = 0): Boolean; overload; 
     {* ����� �������� Document.SetPosition � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = dptSub;
    aUserType: Integer = 0): Boolean; overload; 
     {* ����� �������� Document.SetPosition � ����� }
   class function Call(const aTarget: IvcmContainer;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = dptSub;
    aUserType: Integer = 0): Boolean; overload; 
     {* ����� �������� Document.SetPosition � ���������� }
 end;//Op_Document_SetPosition

 IDocument_GetParaForPositionning_Params = interface(IUnknown)
  {* ��������� ��� �������� Document.GetParaForPositionning }
   ['{E79D0E07-76C9-4606-9FE2-95A75EDF5769}']
   function Get_ResultValue: IeeLeafPara;
   procedure Set_ResultValue(const aValue: IeeLeafPara);
   property ResultValue: IeeLeafPara
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IDocument_GetParaForPositionning_Params

 Op_Document_GetParaForPositionning = class
  {* ����� ��� ������ �������� Document.GetParaForPositionning }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): IeeLeafPara; overload; 
     {* ����� �������� Document.GetParaForPositionning � �������� }
   class function Call(const aTarget: IvcmAggregate): IeeLeafPara; overload; 
     {* ����� �������� Document.GetParaForPositionning � ��������� }
   class function Call(const aTarget: IvcmEntityForm): IeeLeafPara; overload; 
     {* ����� �������� Document.GetParaForPositionning � ����� }
   class function Call(const aTarget: IvcmContainer): IeeLeafPara; overload; 
     {* ����� �������� Document.GetParaForPositionning � ���������� }
 end;//Op_Document_GetParaForPositionning
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Document = 'Document';
 en_capDocument = '��������';
 op_CompareEditions = 'CompareEditions';
 op_capCompareEditions = '��������� ��������';
 op_ShowChanges = 'ShowChanges';
 op_capShowChanges = '�������� ���������';
 op_ViewChangedFragments = 'ViewChangedFragments';
 op_capViewChangedFragments = '����� ��������� ���������';
 op_SetPosition = 'SetPosition';
 op_capSetPosition = '';
 en_Edition = 'Edition';
 en_capEdition = '��������';
 op_ReturnToDocument = 'ReturnToDocument';
 op_capReturnToDocument = '��������� � ����� ���������';
 op_GetParaForPositionning = 'GetParaForPositionning';
 op_capGetParaForPositionning = '';

// ��������� ��������:
var st_user_Document_CompareEditions_ShowChanges : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ��������� �������� <-> �������� ���������
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TDocument_SetPosition_Params = class(Tl3CProtoObject, IDocument_SetPosition_Params)
  {* ���������� IDocument_SetPosition_Params }
 private
 // private fields
   f_PointID : Cardinal;
   f_PointType : TDocumentPositionType;
   f_UserType : Integer;
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_UserType: Integer;
   function Get_PointType: TDocumentPositionType;
   function Get_PointID: Cardinal;
 public
 // public methods
   constructor Create(aPointID: Cardinal;
    aPointType: TDocumentPositionType;
    aUserType: Integer); reintroduce;
     {* ����������� TDocument_SetPosition_Params }
   class function Make(aPointID: Cardinal;
    aPointType: TDocumentPositionType;
    aUserType: Integer): IDocument_SetPosition_Params; reintroduce;
     {* ������� TDocument_SetPosition_Params }
 end;//TDocument_SetPosition_Params

// start class TDocument_SetPosition_Params

constructor TDocument_SetPosition_Params.Create(aPointID: Cardinal;
  aPointType: TDocumentPositionType;
  aUserType: Integer);
 {-}
begin
 inherited Create;
 f_PointID := aPointID;
 f_PointType := aPointType;
 f_UserType := aUserType;
end;//TDocument_SetPosition_Params.Create

class function TDocument_SetPosition_Params.Make(aPointID: Cardinal;
  aPointType: TDocumentPositionType;
  aUserType: Integer): IDocument_SetPosition_Params;
var
 l_Inst : TDocument_SetPosition_Params;
begin
 l_Inst := Create(aPointID, aPointType, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_SetPosition_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TDocument_SetPosition_Params.Get_ResultValue

procedure TDocument_SetPosition_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TDocument_SetPosition_Params.Set_ResultValue

function TDocument_SetPosition_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_SetPosition_Params.Get_UserType

function TDocument_SetPosition_Params.Get_PointType: TDocumentPositionType;
 {-}
begin
 Result := f_PointType;
end;//TDocument_SetPosition_Params.Get_PointType

function TDocument_SetPosition_Params.Get_PointID: Cardinal;
 {-}
begin
 Result := f_PointID;
end;//TDocument_SetPosition_Params.Get_PointID
// start class Op_Document_SetPosition

class function Op_Document_SetPosition.Call(const aTarget: IvcmEntity;
  aPointID: Cardinal;
  aPointType: TDocumentPositionType = dptSub;
  aUserType: Integer = 0): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SetPosition_Params.Make(aPointID,aPointType,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_SetPosition, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_SetPosition_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SetPosition.Call

class function Op_Document_SetPosition.Call(const aTarget: IvcmAggregate;
  aPointID: Cardinal;
  aPointType: TDocumentPositionType = dptSub;
  aUserType: Integer = 0): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SetPosition_Params.Make(aPointID,aPointType,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_SetPosition, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_SetPosition_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SetPosition.Call

class function Op_Document_SetPosition.Call(const aTarget: IvcmEntityForm;
  aPointID: Cardinal;
  aPointType: TDocumentPositionType = dptSub;
  aUserType: Integer = 0): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aPointID, aPointType, aUserType);
end;//Op_Document_SetPosition.Call

class function Op_Document_SetPosition.Call(const aTarget: IvcmContainer;
  aPointID: Cardinal;
  aPointType: TDocumentPositionType = dptSub;
  aUserType: Integer = 0): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aPointID, aPointType, aUserType);
end;//Op_Document_SetPosition.Call

type
 TDocument_GetParaForPositionning_Params = class(Tl3CProtoObject, IDocument_GetParaForPositionning_Params)
  {* ���������� IDocument_GetParaForPositionning_Params }
 private
 // private fields
   f_ResultValue : IeeLeafPara;
 protected
 // realized methods
   function Get_ResultValue: IeeLeafPara;
   procedure Set_ResultValue(const aValue: IeeLeafPara);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create; reintroduce;
     {* ����������� TDocument_GetParaForPositionning_Params }
   class function Make: IDocument_GetParaForPositionning_Params; reintroduce;
     {* ������� TDocument_GetParaForPositionning_Params }
 end;//TDocument_GetParaForPositionning_Params

// start class TDocument_GetParaForPositionning_Params

constructor TDocument_GetParaForPositionning_Params.Create;
 {-}
begin
 inherited Create;
end;//TDocument_GetParaForPositionning_Params.Create

class function TDocument_GetParaForPositionning_Params.Make: IDocument_GetParaForPositionning_Params;
var
 l_Inst : TDocument_GetParaForPositionning_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_GetParaForPositionning_Params.Get_ResultValue: IeeLeafPara;
 {-}
begin
 Result := f_ResultValue;
end;//TDocument_GetParaForPositionning_Params.Get_ResultValue

procedure TDocument_GetParaForPositionning_Params.Set_ResultValue(const aValue: IeeLeafPara);
 {-}
begin
 f_ResultValue := aValue;
end;//TDocument_GetParaForPositionning_Params.Set_ResultValue

procedure TDocument_GetParaForPositionning_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ResultValue := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_GetParaForPositionning_Params.ClearFields
// start class Op_Document_GetParaForPositionning

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmEntity): IeeLeafPara;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GetParaForPositionning_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Document_GetParaForPositionning, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GetParaForPositionning_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GetParaForPositionning.Call

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmAggregate): IeeLeafPara;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GetParaForPositionning_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Document_GetParaForPositionning, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GetParaForPositionning_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GetParaForPositionning.Call

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmEntityForm): IeeLeafPara;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_GetParaForPositionning.Call

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmContainer): IeeLeafPara;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_GetParaForPositionning.Call
{$IfEnd} //not Admin AND not Monitorings


end.