unit Common_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4AEEE2A40281)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , l3TreeInterfaces
 , bsTypes
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 INavigator_SetCurrent_Params = interface
  {* Параметры для операции Navigator.SetCurrent }
  function Get_Node: Il3SimpleNode;
  property Node: Il3SimpleNode
   read Get_Node;
 end;//INavigator_SetCurrent_Params

 Op_Navigator_SetCurrent = {final} class
  {* Класс для вызова операции Navigator.SetCurrent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Navigator.SetCurrent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Navigator.SetCurrent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Navigator.SetCurrent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Navigator.SetCurrent у контейнера }
 end;//Op_Navigator_SetCurrent

 IDocument_OpenCorrespondentList_Params = interface
  {* Параметры для операции Document.OpenCorrespondentList }
  function Get_Kind: TlstCRType;
  function Get_CRType: Il3SimpleNode;
  property Kind: TlstCRType
   read Get_Kind;
  property CRType: Il3SimpleNode
   read Get_CRType;
 end;//IDocument_OpenCorrespondentList_Params

 Op_Document_OpenCorrespondentList = {final} class
  {* Класс для вызова операции Document.OpenCorrespondentList }
  public
   class function Call(const aTarget: IvcmEntity;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Document.OpenCorrespondentList у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Document.OpenCorrespondentList у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Document.OpenCorrespondentList у формы }
   class function Call(const aTarget: IvcmContainer;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Document.OpenCorrespondentList у контейнера }
 end;//Op_Document_OpenCorrespondentList

 IDocument_OpenRespondentList_Params = interface
  {* Параметры для операции Document.OpenRespondentList }
  function Get_Kind: TlstCRType;
  function Get_CRType: Il3SimpleNode;
  property Kind: TlstCRType
   read Get_Kind;
  property CRType: Il3SimpleNode
   read Get_CRType;
 end;//IDocument_OpenRespondentList_Params

 Op_Document_OpenRespondentList = {final} class
  {* Класс для вызова операции Document.OpenRespondentList }
  public
   class function Call(const aTarget: IvcmEntity;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Document.OpenRespondentList у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Document.OpenRespondentList у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Document.OpenRespondentList у формы }
   class function Call(const aTarget: IvcmContainer;
    aKind: TlstCRType;
    const aCRType: Il3SimpleNode): Boolean; overload;
    {* Вызов операции Document.OpenRespondentList у контейнера }
 end;//Op_Document_OpenRespondentList

 IDocument_AttributesCanBeClosed_Params = interface
  {* Параметры для операции Document.AttributesCanBeClosed }
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_AttributesCanBeClosed_Params

 Op_Document_AttributesCanBeClosed = {final} class
  {* Класс для вызова операции Document.AttributesCanBeClosed }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Document.AttributesCanBeClosed у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Document.AttributesCanBeClosed у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Document.AttributesCanBeClosed у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Document.AttributesCanBeClosed у контейнера }
 end;//Op_Document_AttributesCanBeClosed

 IDocument_CommonDocumentOpenNewWindow_Params = interface
  {* Параметры для операции Document.CommonDocumentOpenNewWindow }
  function Get_UserType: Integer;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_CommonDocumentOpenNewWindow_Params

 Op_Document_CommonDocumentOpenNewWindow = {final} class
  {* Класс для вызова операции Document.CommonDocumentOpenNewWindow }
  public
   class function Call(const aTarget: IvcmEntity;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CommonDocumentOpenNewWindow у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CommonDocumentOpenNewWindow у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CommonDocumentOpenNewWindow у формы }
   class function Call(const aTarget: IvcmContainer;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CommonDocumentOpenNewWindow у контейнера }
 end;//Op_Document_CommonDocumentOpenNewWindow

 IDocument_CommonDocumentOpenNewTab_Params = interface
  {* Параметры для операции Document.CommonDocumentOpenNewTab }
  function Get_UserType: Integer;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_CommonDocumentOpenNewTab_Params

 Op_Document_CommonDocumentOpenNewTab = {final} class
  {* Класс для вызова операции Document.CommonDocumentOpenNewTab }
  public
   class function Call(const aTarget: IvcmEntity;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CommonDocumentOpenNewTab у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CommonDocumentOpenNewTab у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CommonDocumentOpenNewTab у формы }
   class function Call(const aTarget: IvcmContainer;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CommonDocumentOpenNewTab у контейнера }
 end;//Op_Document_CommonDocumentOpenNewTab

 IRedactions_RedactionOnID_Params = interface
  {* Параметры для операции Redactions.RedactionOnID }
  function Get_RedactionID: TRedactionID;
  property RedactionID: TRedactionID
   read Get_RedactionID;
 end;//IRedactions_RedactionOnID_Params

 Op_Redactions_RedactionOnID = {final} class
  {* Класс для вызова операции Redactions.RedactionOnID }
  public
   class function Call(const aTarget: IvcmEntity;
    aRedactionID: TRedactionID): Boolean; overload;
    {* Вызов операции Redactions.RedactionOnID у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aRedactionID: TRedactionID): Boolean; overload;
    {* Вызов операции Redactions.RedactionOnID у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aRedactionID: TRedactionID): Boolean; overload;
    {* Вызов операции Redactions.RedactionOnID у формы }
   class function Call(const aTarget: IvcmContainer;
    aRedactionID: TRedactionID): Boolean; overload;
    {* Вызов операции Redactions.RedactionOnID у контейнера }
 end;//Op_Redactions_RedactionOnID

const
 en_Navigator = 'Navigator';
 en_capNavigator = '';
 op_SetCurrent = 'SetCurrent';
 op_capSetCurrent = '';
 en_Document = 'Document';
 en_capDocument = 'Документ';
 op_GetAttributesFrmAct = 'GetAttributesFrmAct';
 op_capGetAttributesFrmAct = 'Информация о документе';
 op_OpenCorrespondentList = 'OpenCorrespondentList';
 op_capOpenCorrespondentList = 'Коллеги, это что?';
 op_OpenRespondentList = 'OpenRespondentList';
 op_capOpenRespondentList = 'Коллеги, это что?';
 op_GetRelatedDocFrmAct = 'GetRelatedDocFrmAct';
 op_capGetRelatedDocFrmAct = 'Справка к документу';
 op_GetCorrespondentList = 'GetCorrespondentList';
 op_capGetCorrespondentList = 'Ссылки на документ';
 op_GetRespondentList = 'GetRespondentList';
 op_capGetRespondentList = 'Ссылки из документа';
 op_AttributesCanBeClosed = 'AttributesCanBeClosed';
 op_capAttributesCanBeClosed = 'Это кандидат на перенос в Facet или что-то подобное';
 op_CommonDocumentOpenNewWindow = 'CommonDocumentOpenNewWindow';
 op_capCommonDocumentOpenNewWindow = 'Что это?';
 op_GetCorrespondentListExFrmAct = 'GetCorrespondentListExFrmAct';
 op_capGetCorrespondentListExFrmAct = 'Ссылки на документ (вид информации)';
 op_GetRespondentListExFrmAct = 'GetRespondentListExFrmAct';
 op_capGetRespondentListExFrmAct = 'Ссылки из документа (вид информации)';
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
 op_capOpenRedactionListFrmAct = 'Список редакций';
 op_RedactionOnID = 'RedactionOnID';
 op_capRedactionOnID = '';
 op_ActualRedaction = 'ActualRedaction';
 op_capActualRedaction = '';
 op_PrevRedaction = 'PrevRedaction';
 op_capPrevRedaction = '';
 op_NextRedaction = 'NextRedaction';
 op_capNextRedaction = '';

var opcode_Navigator_SetCurrent: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GetAttributesFrmAct: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Document_GetAttributesFrmAct_Picture: TvcmOperationStateIndex = (rID : -1);
 {* Документ -> Информация о документе <-> Информация о картинке }
var opcode_Document_OpenCorrespondentList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_OpenRespondentList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GetRelatedDocFrmAct: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GetCorrespondentList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GetRespondentList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_AttributesCanBeClosed: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_CommonDocumentOpenNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GetCorrespondentListExFrmAct: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GetRespondentListExFrmAct: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_CommonDocumentOpenNewTab: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_Open: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_OpenInNewTab: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_OpenNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_PrintDialog: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_PrintPreview: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_Save: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_Print: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_NavigatorElement_Info: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_NavigatorElement_Execute: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Fake_Fake: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Redactions_OpenRedactionListFrmAct: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Redactions_OpenRedactionListFrmAct_ChooseAnotherEditions: TvcmOperationStateIndex = (rID : -1);
 {*  -> Список редакций <-> Выбрать другие редакции }
var opcode_Redactions_RedactionOnID: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Redactions_ActualRedaction: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Redactions_PrevRedaction: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Redactions_NextRedaction: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TNavigator_SetCurrent_Params = {final} class(Tl3CProtoObject, INavigator_SetCurrent_Params)
  {* Реализация INavigator_SetCurrent_Params }
  private
   f_Node: Il3SimpleNode;
  protected
   function Get_Node: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3SimpleNode); reintroduce;
   class function Make(const aNode: Il3SimpleNode): INavigator_SetCurrent_Params; reintroduce;
 end;//TNavigator_SetCurrent_Params

 TDocument_OpenCorrespondentList_Params = {final} class(Tl3CProtoObject, IDocument_OpenCorrespondentList_Params)
  {* Реализация IDocument_OpenCorrespondentList_Params }
  private
   f_Kind: TlstCRType;
   f_CRType: Il3SimpleNode;
  protected
   function Get_Kind: TlstCRType;
   function Get_CRType: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(aKind: TlstCRType;
    const aCRType: Il3SimpleNode); reintroduce;
   class function Make(aKind: TlstCRType;
    const aCRType: Il3SimpleNode): IDocument_OpenCorrespondentList_Params; reintroduce;
 end;//TDocument_OpenCorrespondentList_Params

 TDocument_OpenRespondentList_Params = {final} class(Tl3CProtoObject, IDocument_OpenRespondentList_Params)
  {* Реализация IDocument_OpenRespondentList_Params }
  private
   f_Kind: TlstCRType;
   f_CRType: Il3SimpleNode;
  protected
   function Get_Kind: TlstCRType;
   function Get_CRType: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(aKind: TlstCRType;
    const aCRType: Il3SimpleNode); reintroduce;
   class function Make(aKind: TlstCRType;
    const aCRType: Il3SimpleNode): IDocument_OpenRespondentList_Params; reintroduce;
 end;//TDocument_OpenRespondentList_Params

 TDocument_AttributesCanBeClosed_Params = {final} class(Tl3CProtoObject, IDocument_AttributesCanBeClosed_Params)
  {* Реализация IDocument_AttributesCanBeClosed_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   class function Make: IDocument_AttributesCanBeClosed_Params; reintroduce;
 end;//TDocument_AttributesCanBeClosed_Params

 TDocument_CommonDocumentOpenNewWindow_Params = {final} class(Tl3CProtoObject, IDocument_CommonDocumentOpenNewWindow_Params)
  {* Реализация IDocument_CommonDocumentOpenNewWindow_Params }
  private
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
  public
   constructor Create(aUserType: Integer); reintroduce;
   class function Make(aUserType: Integer): IDocument_CommonDocumentOpenNewWindow_Params; reintroduce;
 end;//TDocument_CommonDocumentOpenNewWindow_Params

 TDocument_CommonDocumentOpenNewTab_Params = {final} class(Tl3CProtoObject, IDocument_CommonDocumentOpenNewTab_Params)
  {* Реализация IDocument_CommonDocumentOpenNewTab_Params }
  private
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
  public
   constructor Create(aUserType: Integer); reintroduce;
   class function Make(aUserType: Integer): IDocument_CommonDocumentOpenNewTab_Params; reintroduce;
 end;//TDocument_CommonDocumentOpenNewTab_Params

 TRedactions_RedactionOnID_Params = {final} class(Tl3CProtoObject, IRedactions_RedactionOnID_Params)
  {* Реализация IRedactions_RedactionOnID_Params }
  private
   f_RedactionID: TRedactionID;
  protected
   function Get_RedactionID: TRedactionID;
  public
   constructor Create(aRedactionID: TRedactionID); reintroduce;
   class function Make(aRedactionID: TRedactionID): IRedactions_RedactionOnID_Params; reintroduce;
 end;//TRedactions_RedactionOnID_Params

constructor TNavigator_SetCurrent_Params.Create(const aNode: Il3SimpleNode);
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
end;//TNavigator_SetCurrent_Params.Make

function TNavigator_SetCurrent_Params.Get_Node: Il3SimpleNode;
begin
 Result := f_Node;
end;//TNavigator_SetCurrent_Params.Get_Node

procedure TNavigator_SetCurrent_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TNavigator_SetCurrent_Params.ClearFields

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmEntity;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции Navigator.SetCurrent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TNavigator_SetCurrent_Params.Make(aNode));
  aTarget.Operation(opcode_Navigator_SetCurrent, l_Params);
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
 {* Вызов операции Navigator.SetCurrent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TNavigator_SetCurrent_Params.Make(aNode));
  aTarget.Operation(opcode_Navigator_SetCurrent, l_Params);
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
 {* Вызов операции Navigator.SetCurrent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_Navigator_SetCurrent.Call

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции Navigator.SetCurrent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_Navigator_SetCurrent.Call

constructor TDocument_OpenCorrespondentList_Params.Create(aKind: TlstCRType;
 const aCRType: Il3SimpleNode);
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
end;//TDocument_OpenCorrespondentList_Params.Make

function TDocument_OpenCorrespondentList_Params.Get_Kind: TlstCRType;
begin
 Result := f_Kind;
end;//TDocument_OpenCorrespondentList_Params.Get_Kind

function TDocument_OpenCorrespondentList_Params.Get_CRType: Il3SimpleNode;
begin
 Result := f_CRType;
end;//TDocument_OpenCorrespondentList_Params.Get_CRType

procedure TDocument_OpenCorrespondentList_Params.ClearFields;
begin
 f_CRType := nil;
 inherited;
end;//TDocument_OpenCorrespondentList_Params.ClearFields

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmEntity;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenCorrespondentList у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenCorrespondentList_Params.Make(aKind, aCRType));
  aTarget.Operation(opcode_Document_OpenCorrespondentList, l_Params);
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
 {* Вызов операции Document.OpenCorrespondentList у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenCorrespondentList_Params.Make(aKind, aCRType));
  aTarget.Operation(opcode_Document_OpenCorrespondentList, l_Params);
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
 {* Вызов операции Document.OpenCorrespondentList у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aKind, aCRType);
end;//Op_Document_OpenCorrespondentList.Call

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmContainer;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenCorrespondentList у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aKind, aCRType);
end;//Op_Document_OpenCorrespondentList.Call

constructor TDocument_OpenRespondentList_Params.Create(aKind: TlstCRType;
 const aCRType: Il3SimpleNode);
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
end;//TDocument_OpenRespondentList_Params.Make

function TDocument_OpenRespondentList_Params.Get_Kind: TlstCRType;
begin
 Result := f_Kind;
end;//TDocument_OpenRespondentList_Params.Get_Kind

function TDocument_OpenRespondentList_Params.Get_CRType: Il3SimpleNode;
begin
 Result := f_CRType;
end;//TDocument_OpenRespondentList_Params.Get_CRType

procedure TDocument_OpenRespondentList_Params.ClearFields;
begin
 f_CRType := nil;
 inherited;
end;//TDocument_OpenRespondentList_Params.ClearFields

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmEntity;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenRespondentList у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenRespondentList_Params.Make(aKind, aCRType));
  aTarget.Operation(opcode_Document_OpenRespondentList, l_Params);
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
 {* Вызов операции Document.OpenRespondentList у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenRespondentList_Params.Make(aKind, aCRType));
  aTarget.Operation(opcode_Document_OpenRespondentList, l_Params);
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
 {* Вызов операции Document.OpenRespondentList у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aKind, aCRType);
end;//Op_Document_OpenRespondentList.Call

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmContainer;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenRespondentList у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aKind, aCRType);
end;//Op_Document_OpenRespondentList.Call

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
end;//TDocument_AttributesCanBeClosed_Params.Make

function TDocument_AttributesCanBeClosed_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TDocument_AttributesCanBeClosed_Params.Get_ResultValue

procedure TDocument_AttributesCanBeClosed_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TDocument_AttributesCanBeClosed_Params.Set_ResultValue

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Document.AttributesCanBeClosed у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_AttributesCanBeClosed_Params.Make);
  aTarget.Operation(opcode_Document_AttributesCanBeClosed, l_Params);
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
 {* Вызов операции Document.AttributesCanBeClosed у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_AttributesCanBeClosed_Params.Make);
  aTarget.Operation(opcode_Document_AttributesCanBeClosed, l_Params);
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
 {* Вызов операции Document.AttributesCanBeClosed у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_AttributesCanBeClosed.Call

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Document.AttributesCanBeClosed у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_AttributesCanBeClosed.Call

constructor TDocument_CommonDocumentOpenNewWindow_Params.Create(aUserType: Integer);
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
end;//TDocument_CommonDocumentOpenNewWindow_Params.Make

function TDocument_CommonDocumentOpenNewWindow_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_CommonDocumentOpenNewWindow_Params.Get_UserType

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmEntity;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewWindow у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CommonDocumentOpenNewWindow_Params.Make(aUserType));
  aTarget.Operation(opcode_Document_CommonDocumentOpenNewWindow, l_Params);
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
 {* Вызов операции Document.CommonDocumentOpenNewWindow у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CommonDocumentOpenNewWindow_Params.Make(aUserType));
  aTarget.Operation(opcode_Document_CommonDocumentOpenNewWindow, l_Params);
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
 {* Вызов операции Document.CommonDocumentOpenNewWindow у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aUserType);
end;//Op_Document_CommonDocumentOpenNewWindow.Call

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmContainer;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewWindow у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aUserType);
end;//Op_Document_CommonDocumentOpenNewWindow.Call

constructor TDocument_CommonDocumentOpenNewTab_Params.Create(aUserType: Integer);
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
end;//TDocument_CommonDocumentOpenNewTab_Params.Make

function TDocument_CommonDocumentOpenNewTab_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_CommonDocumentOpenNewTab_Params.Get_UserType

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmEntity;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewTab у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CommonDocumentOpenNewTab_Params.Make(aUserType));
  aTarget.Operation(opcode_Document_CommonDocumentOpenNewTab, l_Params);
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
 {* Вызов операции Document.CommonDocumentOpenNewTab у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CommonDocumentOpenNewTab_Params.Make(aUserType));
  aTarget.Operation(opcode_Document_CommonDocumentOpenNewTab, l_Params);
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
 {* Вызов операции Document.CommonDocumentOpenNewTab у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aUserType);
end;//Op_Document_CommonDocumentOpenNewTab.Call

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmContainer;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewTab у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aUserType);
end;//Op_Document_CommonDocumentOpenNewTab.Call

constructor TRedactions_RedactionOnID_Params.Create(aRedactionID: TRedactionID);
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
end;//TRedactions_RedactionOnID_Params.Make

function TRedactions_RedactionOnID_Params.Get_RedactionID: TRedactionID;
begin
 Result := f_RedactionID;
end;//TRedactions_RedactionOnID_Params.Get_RedactionID

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmEntity;
 aRedactionID: TRedactionID): Boolean;
 {* Вызов операции Redactions.RedactionOnID у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRedactions_RedactionOnID_Params.Make(aRedactionID));
  aTarget.Operation(opcode_Redactions_RedactionOnID, l_Params);
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
 {* Вызов операции Redactions.RedactionOnID у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRedactions_RedactionOnID_Params.Make(aRedactionID));
  aTarget.Operation(opcode_Redactions_RedactionOnID, l_Params);
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
 {* Вызов операции Redactions.RedactionOnID у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aRedactionID);
end;//Op_Redactions_RedactionOnID.Call

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmContainer;
 aRedactionID: TRedactionID): Boolean;
 {* Вызов операции Redactions.RedactionOnID у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aRedactionID);
end;//Op_Redactions_RedactionOnID.Call

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Navigator, op_SetCurrent, en_capNavigator, op_capSetCurrent, True, False, opcode_Navigator_SetCurrent)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetAttributesFrmAct, en_capDocument, op_capGetAttributesFrmAct, False, False, opcode_Document_GetAttributesFrmAct)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Picture', st_user_Document_GetAttributesFrmAct_Picture))^ do
  begin
   rCaption := 'Информация о картинке';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_OpenCorrespondentList, en_capDocument, op_capOpenCorrespondentList, True, False, opcode_Document_OpenCorrespondentList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_OpenRespondentList, en_capDocument, op_capOpenRespondentList, True, False, opcode_Document_OpenRespondentList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetAttributesFrmAct, en_capDocument, op_capGetAttributesFrmAct, False, False, opcode_Document_GetAttributesFrmAct)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetRelatedDocFrmAct, en_capDocument, op_capGetRelatedDocFrmAct, False, False, opcode_Document_GetRelatedDocFrmAct)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetCorrespondentList, en_capDocument, op_capGetCorrespondentList, False, False, opcode_Document_GetCorrespondentList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetRespondentList, en_capDocument, op_capGetRespondentList, False, False, opcode_Document_GetRespondentList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_AttributesCanBeClosed, en_capDocument, op_capAttributesCanBeClosed, True, False, opcode_Document_AttributesCanBeClosed)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_CommonDocumentOpenNewWindow, en_capDocument, op_capCommonDocumentOpenNewWindow, True, False, opcode_Document_CommonDocumentOpenNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetCorrespondentListExFrmAct, en_capDocument, op_capGetCorrespondentListExFrmAct, False, False, opcode_Document_GetCorrespondentListExFrmAct)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetRespondentListExFrmAct, en_capDocument, op_capGetRespondentListExFrmAct, False, False, opcode_Document_GetRespondentListExFrmAct)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_CommonDocumentOpenNewTab, en_capDocument, op_capCommonDocumentOpenNewTab, True, False, opcode_Document_CommonDocumentOpenNewTab)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_Open, en_capDocument, op_capOpen, False, False, opcode_Document_Open)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_OpenInNewTab, en_capDocument, op_capOpenInNewTab, False, False, opcode_Document_OpenInNewTab)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_OpenNewWindow, en_capDocument, op_capOpenNewWindow, False, False, opcode_Document_OpenNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_PrintDialog, en_capDocument, op_capPrintDialog, False, False, opcode_Document_PrintDialog)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_PrintPreview, en_capDocument, op_capPrintPreview, False, False, opcode_Document_PrintPreview)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_Save, en_capDocument, op_capSave, False, False, opcode_Document_Save)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_Print, en_capDocument, op_capPrint, False, False, opcode_Document_Print)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_NavigatorElement, op_Info, en_capNavigatorElement, op_capInfo, False, False, opcode_NavigatorElement_Info)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_NavigatorElement, op_Execute, en_capNavigatorElement, op_capExecute, False, False, opcode_NavigatorElement_Execute)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Fake, op_Fake, en_capFake, op_capFake, False, False, opcode_Fake_Fake)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Redactions, op_OpenRedactionListFrmAct, en_capRedactions, op_capOpenRedactionListFrmAct, False, False, opcode_Redactions_OpenRedactionListFrmAct)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('ChooseAnotherEditions', st_user_Redactions_OpenRedactionListFrmAct_ChooseAnotherEditions))^ do
  begin
   rCaption := 'Выбрать другие редакции';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Redactions, op_RedactionOnID, en_capRedactions, op_capRedactionOnID, True, False, opcode_Redactions_RedactionOnID)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Redactions, op_ActualRedaction, en_capRedactions, op_capActualRedaction, False, False, opcode_Redactions_ActualRedaction)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Redactions, op_OpenRedactionListFrmAct, en_capRedactions, op_capOpenRedactionListFrmAct, False, False, opcode_Redactions_OpenRedactionListFrmAct)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Redactions, op_PrevRedaction, en_capRedactions, op_capPrevRedaction, False, False, opcode_Redactions_PrevRedaction)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Redactions, op_NextRedaction, en_capRedactions, op_capNextRedaction, False, False, opcode_Redactions_NextRedaction)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
