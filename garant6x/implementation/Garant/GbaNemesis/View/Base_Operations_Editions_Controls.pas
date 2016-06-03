unit Base_Operations_Editions_Controls;
 {* ������ � ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_Editions_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Editions" MUID: (4A77058200BA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , eeInterfaces
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IDocument_SetPosition_Params = interface
  {* ��������� ��� �������� Document.SetPosition }
  function Get_PointID: Cardinal;
  function Get_PointType: TDocumentPositionType;
  function Get_UserType: Integer;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property PointID: Cardinal
   read Get_PointID;
  property PointType: TDocumentPositionType
   read Get_PointType;
  property UserType: Integer
   read Get_UserType;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_SetPosition_Params

 Op_Document_SetPosition = {final} class
  {* ����� ��� ������ �������� Document.SetPosition }
  public
   class function Call(const aTarget: IvcmEntity;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): Boolean; overload;
    {* ����� �������� Document.SetPosition � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): Boolean; overload;
    {* ����� �������� Document.SetPosition � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): Boolean; overload;
    {* ����� �������� Document.SetPosition � ����� }
   class function Call(const aTarget: IvcmContainer;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): Boolean; overload;
    {* ����� �������� Document.SetPosition � ���������� }
 end;//Op_Document_SetPosition

 IDocument_GetParaForPositionning_Params = interface
  {* ��������� ��� �������� Document.GetParaForPositionning }
  function Get_ResultValue: IeeLeafPara;
  procedure Set_ResultValue(const aValue: IeeLeafPara);
  property ResultValue: IeeLeafPara
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_GetParaForPositionning_Params

 Op_Document_GetParaForPositionning = {final} class
  {* ����� ��� ������ �������� Document.GetParaForPositionning }
  public
   class function Call(const aTarget: IvcmEntity): IeeLeafPara; overload;
    {* ����� �������� Document.GetParaForPositionning � �������� }
   class function Call(const aTarget: IvcmAggregate): IeeLeafPara; overload;
    {* ����� �������� Document.GetParaForPositionning � ��������� }
   class function Call(const aTarget: IvcmEntityForm): IeeLeafPara; overload;
    {* ����� �������� Document.GetParaForPositionning � ����� }
   class function Call(const aTarget: IvcmContainer): IeeLeafPara; overload;
    {* ����� �������� Document.GetParaForPositionning � ���������� }
 end;//Op_Document_GetParaForPositionning

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

var st_user_Document_CompareEditions_ShowChanges: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������� �������� <-> �������� ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDocument_SetPosition_Params = {final} class(Tl3CProtoObject, IDocument_SetPosition_Params)
  {* ���������� IDocument_SetPosition_Params }
  private
   f_PointID: Cardinal;
   f_PointType: TDocumentPositionType;
   f_UserType: Integer;
   f_ResultValue: Boolean;
  protected
   function Get_PointID: Cardinal;
   function Get_PointType: TDocumentPositionType;
   function Get_UserType: Integer;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create(aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0); reintroduce;
   class function Make(aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): IDocument_SetPosition_Params; reintroduce;
 end;//TDocument_SetPosition_Params

 TDocument_GetParaForPositionning_Params = {final} class(Tl3CProtoObject, IDocument_GetParaForPositionning_Params)
  {* ���������� IDocument_GetParaForPositionning_Params }
  private
   f_ResultValue: IeeLeafPara;
  protected
   function Get_ResultValue: IeeLeafPara;
   procedure Set_ResultValue(const aValue: IeeLeafPara);
   procedure ClearFields; override;
  public
   class function Make: IDocument_GetParaForPositionning_Params; reintroduce;
 end;//TDocument_GetParaForPositionning_Params

constructor TDocument_SetPosition_Params.Create(aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0);
begin
 inherited Create;
 f_PointID := aPointID;
 f_PointType := aPointType;
 f_UserType := aUserType;
end;//TDocument_SetPosition_Params.Create

class function TDocument_SetPosition_Params.Make(aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): IDocument_SetPosition_Params;
var
 l_Inst : TDocument_SetPosition_Params;
begin
 l_Inst := Create(aPointID, aPointType, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_SetPosition_Params.Make

function TDocument_SetPosition_Params.Get_PointID: Cardinal;
begin
 Result := f_PointID;
end;//TDocument_SetPosition_Params.Get_PointID

function TDocument_SetPosition_Params.Get_PointType: TDocumentPositionType;
begin
 Result := f_PointType;
end;//TDocument_SetPosition_Params.Get_PointType

function TDocument_SetPosition_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_SetPosition_Params.Get_UserType

function TDocument_SetPosition_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TDocument_SetPosition_Params.Get_ResultValue

procedure TDocument_SetPosition_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TDocument_SetPosition_Params.Set_ResultValue

class function Op_Document_SetPosition.Call(const aTarget: IvcmEntity;
 aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): Boolean;
 {* ����� �������� Document.SetPosition � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SetPosition_Params.Make(aPointID, aPointType, aUserType));
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
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): Boolean;
 {* ����� �������� Document.SetPosition � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SetPosition_Params.Make(aPointID, aPointType, aUserType));
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
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): Boolean;
 {* ����� �������� Document.SetPosition � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aPointID, aPointType, aUserType);
end;//Op_Document_SetPosition.Call

class function Op_Document_SetPosition.Call(const aTarget: IvcmContainer;
 aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): Boolean;
 {* ����� �������� Document.SetPosition � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aPointID, aPointType, aUserType);
end;//Op_Document_SetPosition.Call

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
end;//TDocument_GetParaForPositionning_Params.Make

function TDocument_GetParaForPositionning_Params.Get_ResultValue: IeeLeafPara;
begin
 Result := f_ResultValue;
end;//TDocument_GetParaForPositionning_Params.Get_ResultValue

procedure TDocument_GetParaForPositionning_Params.Set_ResultValue(const aValue: IeeLeafPara);
begin
 f_ResultValue := aValue;
end;//TDocument_GetParaForPositionning_Params.Set_ResultValue

procedure TDocument_GetParaForPositionning_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TDocument_GetParaForPositionning_Params.ClearFields

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmEntity): IeeLeafPara;
 {* ����� �������� Document.GetParaForPositionning � �������� }
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
 {* ����� �������� Document.GetParaForPositionning � ��������� }
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
 {* ����� �������� Document.GetParaForPositionning � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_GetParaForPositionning.Call

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmContainer): IeeLeafPara;
 {* ����� �������� Document.GetParaForPositionning � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_GetParaForPositionning.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
