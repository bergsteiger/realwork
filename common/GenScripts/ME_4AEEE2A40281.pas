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
  ['{4F1D0BCC-66F3-41EA-B7A5-C583BD86B54A}']
  function Get_Node: Il3SimpleNode;
  property Node: Il3SimpleNode
   read Get_Node;
 end;//INavigator_SetCurrent_Params

 Op_Navigator_SetCurrent = class
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
  ['{1B2A4163-9A33-4037-87A4-391412220698}']
  function Get_Kind: TlstCRType;
  function Get_CRType: Il3SimpleNode;
  property Kind: TlstCRType
   read Get_Kind;
  property CRType: Il3SimpleNode
   read Get_CRType;
 end;//IDocument_OpenCorrespondentList_Params

 Op_Document_OpenCorrespondentList = class
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
  ['{A68D4EA7-1BFF-4C30-921A-66C442F2B7DB}']
  function Get_Kind: TlstCRType;
  function Get_CRType: Il3SimpleNode;
  property Kind: TlstCRType
   read Get_Kind;
  property CRType: Il3SimpleNode
   read Get_CRType;
 end;//IDocument_OpenRespondentList_Params

 Op_Document_OpenRespondentList = class
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
  ['{634A888C-D678-4FC7-9922-86C944C29BD4}']
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_AttributesCanBeClosed_Params

 Op_Document_AttributesCanBeClosed = class
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
  ['{86B3F0E0-FDF1-42F2-B847-94AAD63366A1}']
  function Get_UserType: Integer;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_CommonDocumentOpenNewWindow_Params

 Op_Document_CommonDocumentOpenNewWindow = class
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
  ['{9F649AA8-4BA6-4303-A57B-679A64120DCF}']
  function Get_UserType: Integer;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_CommonDocumentOpenNewTab_Params

 Op_Document_CommonDocumentOpenNewTab = class
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
  ['{92C237BD-F783-4B25-A09E-8B35B9216491}']
  function Get_RedactionID: TRedactionID;
  property RedactionID: TRedactionID
   read Get_RedactionID;
 end;//IRedactions_RedactionOnID_Params

 Op_Redactions_RedactionOnID = class
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TNavigator_SetCurrent_Params = class(Tl3CProtoObject, INavigator_SetCurrent_Params)
  {* Реализация INavigator_SetCurrent_Params }
  private
   f_Node: Il3SimpleNode;
  protected
   function Get_Node: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3SimpleNode); reintroduce;
    {* Конструктор TNavigator_SetCurrent_Params }
   class function Make(const aNode: Il3SimpleNode): INavigator_SetCurrent_Params; reintroduce;
    {* Фабрика TNavigator_SetCurrent_Params }
 end;//TNavigator_SetCurrent_Params

 TDocument_OpenCorrespondentList_Params = class(Tl3CProtoObject, IDocument_OpenCorrespondentList_Params)
  {* Реализация IDocument_OpenCorrespondentList_Params }
  private
   f_Kind: TlstCRType;
   f_CRType: Il3SimpleNode;
  protected
   function Get_CRType: Il3SimpleNode;
   function Get_Kind: TlstCRType;
   procedure ClearFields; override;
  public
   constructor Create(aKind: TlstCRType;
    const aCRType: Il3SimpleNode); reintroduce;
    {* Конструктор TDocument_OpenCorrespondentList_Params }
   class function Make(aKind: TlstCRType;
    const aCRType: Il3SimpleNode): IDocument_OpenCorrespondentList_Params; reintroduce;
    {* Фабрика TDocument_OpenCorrespondentList_Params }
 end;//TDocument_OpenCorrespondentList_Params

 TDocument_OpenRespondentList_Params = class(Tl3CProtoObject, IDocument_OpenRespondentList_Params)
  {* Реализация IDocument_OpenRespondentList_Params }
  private
   f_Kind: TlstCRType;
   f_CRType: Il3SimpleNode;
  protected
   function Get_CRType: Il3SimpleNode;
   function Get_Kind: TlstCRType;
   procedure ClearFields; override;
  public
   constructor Create(aKind: TlstCRType;
    const aCRType: Il3SimpleNode); reintroduce;
    {* Конструктор TDocument_OpenRespondentList_Params }
   class function Make(aKind: TlstCRType;
    const aCRType: Il3SimpleNode): IDocument_OpenRespondentList_Params; reintroduce;
    {* Фабрика TDocument_OpenRespondentList_Params }
 end;//TDocument_OpenRespondentList_Params

 TDocument_AttributesCanBeClosed_Params = class(Tl3CProtoObject, IDocument_AttributesCanBeClosed_Params)
  {* Реализация IDocument_AttributesCanBeClosed_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create; reintroduce;
    {* Конструктор TDocument_AttributesCanBeClosed_Params }
   class function Make: IDocument_AttributesCanBeClosed_Params; reintroduce;
    {* Фабрика TDocument_AttributesCanBeClosed_Params }
 end;//TDocument_AttributesCanBeClosed_Params

 TDocument_CommonDocumentOpenNewWindow_Params = class(Tl3CProtoObject, IDocument_CommonDocumentOpenNewWindow_Params)
  {* Реализация IDocument_CommonDocumentOpenNewWindow_Params }
  private
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
  public
   constructor Create(aUserType: Integer); reintroduce;
    {* Конструктор TDocument_CommonDocumentOpenNewWindow_Params }
   class function Make(aUserType: Integer): IDocument_CommonDocumentOpenNewWindow_Params; reintroduce;
    {* Фабрика TDocument_CommonDocumentOpenNewWindow_Params }
 end;//TDocument_CommonDocumentOpenNewWindow_Params

 TDocument_CommonDocumentOpenNewTab_Params = class(Tl3CProtoObject, IDocument_CommonDocumentOpenNewTab_Params)
  {* Реализация IDocument_CommonDocumentOpenNewTab_Params }
  private
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
  public
   constructor Create(aUserType: Integer); reintroduce;
    {* Конструктор TDocument_CommonDocumentOpenNewTab_Params }
   class function Make(aUserType: Integer): IDocument_CommonDocumentOpenNewTab_Params; reintroduce;
    {* Фабрика TDocument_CommonDocumentOpenNewTab_Params }
 end;//TDocument_CommonDocumentOpenNewTab_Params

 TRedactions_RedactionOnID_Params = class(Tl3CProtoObject, IRedactions_RedactionOnID_Params)
  {* Реализация IRedactions_RedactionOnID_Params }
  private
   f_RedactionID: TRedactionID;
  protected
   function Get_RedactionID: TRedactionID;
  public
   constructor Create(aRedactionID: TRedactionID); reintroduce;
    {* Конструктор TRedactions_RedactionOnID_Params }
   class function Make(aRedactionID: TRedactionID): IRedactions_RedactionOnID_Params; reintroduce;
    {* Фабрика TRedactions_RedactionOnID_Params }
 end;//TRedactions_RedactionOnID_Params

constructor TNavigator_SetCurrent_Params.Create(const aNode: Il3SimpleNode);
 {* Конструктор TNavigator_SetCurrent_Params }
//#UC START# *A274CECAA04F_7EB44D4D1219_var*
//#UC END# *A274CECAA04F_7EB44D4D1219_var*
begin
//#UC START# *A274CECAA04F_7EB44D4D1219_impl*
 !!! Needs to be implemented !!!
//#UC END# *A274CECAA04F_7EB44D4D1219_impl*
end;//TNavigator_SetCurrent_Params.Create

class function TNavigator_SetCurrent_Params.Make(const aNode: Il3SimpleNode): INavigator_SetCurrent_Params;
 {* Фабрика TNavigator_SetCurrent_Params }
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
//#UC START# *8A2BD316FBB5_7EB44D4D1219get_var*
//#UC END# *8A2BD316FBB5_7EB44D4D1219get_var*
begin
//#UC START# *8A2BD316FBB5_7EB44D4D1219get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8A2BD316FBB5_7EB44D4D1219get_impl*
end;//TNavigator_SetCurrent_Params.Get_Node

procedure TNavigator_SetCurrent_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TNavigator_SetCurrent_Params.ClearFields

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmEntity;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции Navigator.SetCurrent у сущности }
//#UC START# *7093A6DBDD94_954223903EBB_var*
//#UC END# *7093A6DBDD94_954223903EBB_var*
begin
//#UC START# *7093A6DBDD94_954223903EBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *7093A6DBDD94_954223903EBB_impl*
end;//Op_Navigator_SetCurrent.Call

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmAggregate;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции Navigator.SetCurrent у агрегации }
//#UC START# *A0D366CA67E4_954223903EBB_var*
//#UC END# *A0D366CA67E4_954223903EBB_var*
begin
//#UC START# *A0D366CA67E4_954223903EBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *A0D366CA67E4_954223903EBB_impl*
end;//Op_Navigator_SetCurrent.Call

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции Navigator.SetCurrent у формы }
//#UC START# *5FBB426124DD_954223903EBB_var*
//#UC END# *5FBB426124DD_954223903EBB_var*
begin
//#UC START# *5FBB426124DD_954223903EBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5FBB426124DD_954223903EBB_impl*
end;//Op_Navigator_SetCurrent.Call

class function Op_Navigator_SetCurrent.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции Navigator.SetCurrent у контейнера }
//#UC START# *0F2381EC7734_954223903EBB_var*
//#UC END# *0F2381EC7734_954223903EBB_var*
begin
//#UC START# *0F2381EC7734_954223903EBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *0F2381EC7734_954223903EBB_impl*
end;//Op_Navigator_SetCurrent.Call

constructor TDocument_OpenCorrespondentList_Params.Create(aKind: TlstCRType;
 const aCRType: Il3SimpleNode);
 {* Конструктор TDocument_OpenCorrespondentList_Params }
//#UC START# *949F24F963B5_3DCC9B26A15A_var*
//#UC END# *949F24F963B5_3DCC9B26A15A_var*
begin
//#UC START# *949F24F963B5_3DCC9B26A15A_impl*
 !!! Needs to be implemented !!!
//#UC END# *949F24F963B5_3DCC9B26A15A_impl*
end;//TDocument_OpenCorrespondentList_Params.Create

class function TDocument_OpenCorrespondentList_Params.Make(aKind: TlstCRType;
 const aCRType: Il3SimpleNode): IDocument_OpenCorrespondentList_Params;
 {* Фабрика TDocument_OpenCorrespondentList_Params }
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

function TDocument_OpenCorrespondentList_Params.Get_CRType: Il3SimpleNode;
//#UC START# *980CAB42B047_3DCC9B26A15Aget_var*
//#UC END# *980CAB42B047_3DCC9B26A15Aget_var*
begin
//#UC START# *980CAB42B047_3DCC9B26A15Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *980CAB42B047_3DCC9B26A15Aget_impl*
end;//TDocument_OpenCorrespondentList_Params.Get_CRType

function TDocument_OpenCorrespondentList_Params.Get_Kind: TlstCRType;
//#UC START# *ED88FAF633C7_3DCC9B26A15Aget_var*
//#UC END# *ED88FAF633C7_3DCC9B26A15Aget_var*
begin
//#UC START# *ED88FAF633C7_3DCC9B26A15Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *ED88FAF633C7_3DCC9B26A15Aget_impl*
end;//TDocument_OpenCorrespondentList_Params.Get_Kind

procedure TDocument_OpenCorrespondentList_Params.ClearFields;
begin
 f_CRType := nil;
 inherited;
end;//TDocument_OpenCorrespondentList_Params.ClearFields

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmEntity;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenCorrespondentList у сущности }
//#UC START# *C8BE0BEEF518_A5D8B757A11C_var*
//#UC END# *C8BE0BEEF518_A5D8B757A11C_var*
begin
//#UC START# *C8BE0BEEF518_A5D8B757A11C_impl*
 !!! Needs to be implemented !!!
//#UC END# *C8BE0BEEF518_A5D8B757A11C_impl*
end;//Op_Document_OpenCorrespondentList.Call

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmAggregate;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenCorrespondentList у агрегации }
//#UC START# *F8FDCBDD7F68_A5D8B757A11C_var*
//#UC END# *F8FDCBDD7F68_A5D8B757A11C_var*
begin
//#UC START# *F8FDCBDD7F68_A5D8B757A11C_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8FDCBDD7F68_A5D8B757A11C_impl*
end;//Op_Document_OpenCorrespondentList.Call

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmEntityForm;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenCorrespondentList у формы }
//#UC START# *6FF90E99046D_A5D8B757A11C_var*
//#UC END# *6FF90E99046D_A5D8B757A11C_var*
begin
//#UC START# *6FF90E99046D_A5D8B757A11C_impl*
 !!! Needs to be implemented !!!
//#UC END# *6FF90E99046D_A5D8B757A11C_impl*
end;//Op_Document_OpenCorrespondentList.Call

class function Op_Document_OpenCorrespondentList.Call(const aTarget: IvcmContainer;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenCorrespondentList у контейнера }
//#UC START# *AFB97C2C5A23_A5D8B757A11C_var*
//#UC END# *AFB97C2C5A23_A5D8B757A11C_var*
begin
//#UC START# *AFB97C2C5A23_A5D8B757A11C_impl*
 !!! Needs to be implemented !!!
//#UC END# *AFB97C2C5A23_A5D8B757A11C_impl*
end;//Op_Document_OpenCorrespondentList.Call

constructor TDocument_OpenRespondentList_Params.Create(aKind: TlstCRType;
 const aCRType: Il3SimpleNode);
 {* Конструктор TDocument_OpenRespondentList_Params }
//#UC START# *A3B3B20DC762_E3785754B7A7_var*
//#UC END# *A3B3B20DC762_E3785754B7A7_var*
begin
//#UC START# *A3B3B20DC762_E3785754B7A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *A3B3B20DC762_E3785754B7A7_impl*
end;//TDocument_OpenRespondentList_Params.Create

class function TDocument_OpenRespondentList_Params.Make(aKind: TlstCRType;
 const aCRType: Il3SimpleNode): IDocument_OpenRespondentList_Params;
 {* Фабрика TDocument_OpenRespondentList_Params }
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

function TDocument_OpenRespondentList_Params.Get_CRType: Il3SimpleNode;
//#UC START# *BB4ABDDF23B4_E3785754B7A7get_var*
//#UC END# *BB4ABDDF23B4_E3785754B7A7get_var*
begin
//#UC START# *BB4ABDDF23B4_E3785754B7A7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *BB4ABDDF23B4_E3785754B7A7get_impl*
end;//TDocument_OpenRespondentList_Params.Get_CRType

function TDocument_OpenRespondentList_Params.Get_Kind: TlstCRType;
//#UC START# *DDB7A082A271_E3785754B7A7get_var*
//#UC END# *DDB7A082A271_E3785754B7A7get_var*
begin
//#UC START# *DDB7A082A271_E3785754B7A7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *DDB7A082A271_E3785754B7A7get_impl*
end;//TDocument_OpenRespondentList_Params.Get_Kind

procedure TDocument_OpenRespondentList_Params.ClearFields;
begin
 f_CRType := nil;
 inherited;
end;//TDocument_OpenRespondentList_Params.ClearFields

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmEntity;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenRespondentList у сущности }
//#UC START# *9E7B920B407A_42773A3BDA4E_var*
//#UC END# *9E7B920B407A_42773A3BDA4E_var*
begin
//#UC START# *9E7B920B407A_42773A3BDA4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *9E7B920B407A_42773A3BDA4E_impl*
end;//Op_Document_OpenRespondentList.Call

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmAggregate;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenRespondentList у агрегации }
//#UC START# *CEBB51FACACA_42773A3BDA4E_var*
//#UC END# *CEBB51FACACA_42773A3BDA4E_var*
begin
//#UC START# *CEBB51FACACA_42773A3BDA4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *CEBB51FACACA_42773A3BDA4E_impl*
end;//Op_Document_OpenRespondentList.Call

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmEntityForm;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenRespondentList у формы }
//#UC START# *457C4B1FF4AB_42773A3BDA4E_var*
//#UC END# *457C4B1FF4AB_42773A3BDA4E_var*
begin
//#UC START# *457C4B1FF4AB_42773A3BDA4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *457C4B1FF4AB_42773A3BDA4E_impl*
end;//Op_Document_OpenRespondentList.Call

class function Op_Document_OpenRespondentList.Call(const aTarget: IvcmContainer;
 aKind: TlstCRType;
 const aCRType: Il3SimpleNode): Boolean;
 {* Вызов операции Document.OpenRespondentList у контейнера }
//#UC START# *EBAA5EC86D2E_42773A3BDA4E_var*
//#UC END# *EBAA5EC86D2E_42773A3BDA4E_var*
begin
//#UC START# *EBAA5EC86D2E_42773A3BDA4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *EBAA5EC86D2E_42773A3BDA4E_impl*
end;//Op_Document_OpenRespondentList.Call

constructor TDocument_AttributesCanBeClosed_Params.Create;
 {* Конструктор TDocument_AttributesCanBeClosed_Params }
//#UC START# *4A9209AD5EE0_511CCA5AE295_var*
//#UC END# *4A9209AD5EE0_511CCA5AE295_var*
begin
//#UC START# *4A9209AD5EE0_511CCA5AE295_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9209AD5EE0_511CCA5AE295_impl*
end;//TDocument_AttributesCanBeClosed_Params.Create

class function TDocument_AttributesCanBeClosed_Params.Make: IDocument_AttributesCanBeClosed_Params;
 {* Фабрика TDocument_AttributesCanBeClosed_Params }
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
//#UC START# *7688A1B173E2_511CCA5AE295get_var*
//#UC END# *7688A1B173E2_511CCA5AE295get_var*
begin
//#UC START# *7688A1B173E2_511CCA5AE295get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7688A1B173E2_511CCA5AE295get_impl*
end;//TDocument_AttributesCanBeClosed_Params.Get_ResultValue

procedure TDocument_AttributesCanBeClosed_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *7688A1B173E2_511CCA5AE295set_var*
//#UC END# *7688A1B173E2_511CCA5AE295set_var*
begin
//#UC START# *7688A1B173E2_511CCA5AE295set_impl*
 !!! Needs to be implemented !!!
//#UC END# *7688A1B173E2_511CCA5AE295set_impl*
end;//TDocument_AttributesCanBeClosed_Params.Set_ResultValue

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Document.AttributesCanBeClosed у сущности }
//#UC START# *EA44DB5FD4D6_9831378DFEA3_var*
//#UC END# *EA44DB5FD4D6_9831378DFEA3_var*
begin
//#UC START# *EA44DB5FD4D6_9831378DFEA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *EA44DB5FD4D6_9831378DFEA3_impl*
end;//Op_Document_AttributesCanBeClosed.Call

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Document.AttributesCanBeClosed у агрегации }
//#UC START# *1A849B4F5F27_9831378DFEA3_var*
//#UC END# *1A849B4F5F27_9831378DFEA3_var*
begin
//#UC START# *1A849B4F5F27_9831378DFEA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *1A849B4F5F27_9831378DFEA3_impl*
end;//Op_Document_AttributesCanBeClosed.Call

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Document.AttributesCanBeClosed у формы }
//#UC START# *316A52EBE006_9831378DFEA3_var*
//#UC END# *316A52EBE006_9831378DFEA3_var*
begin
//#UC START# *316A52EBE006_9831378DFEA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *316A52EBE006_9831378DFEA3_impl*
end;//Op_Document_AttributesCanBeClosed.Call

class function Op_Document_AttributesCanBeClosed.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Document.AttributesCanBeClosed у контейнера }
//#UC START# *7A951C6B98E4_9831378DFEA3_var*
//#UC END# *7A951C6B98E4_9831378DFEA3_var*
begin
//#UC START# *7A951C6B98E4_9831378DFEA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A951C6B98E4_9831378DFEA3_impl*
end;//Op_Document_AttributesCanBeClosed.Call

constructor TDocument_CommonDocumentOpenNewWindow_Params.Create(aUserType: Integer);
 {* Конструктор TDocument_CommonDocumentOpenNewWindow_Params }
//#UC START# *1758EF18022B_7E9B206690A9_var*
//#UC END# *1758EF18022B_7E9B206690A9_var*
begin
//#UC START# *1758EF18022B_7E9B206690A9_impl*
 !!! Needs to be implemented !!!
//#UC END# *1758EF18022B_7E9B206690A9_impl*
end;//TDocument_CommonDocumentOpenNewWindow_Params.Create

class function TDocument_CommonDocumentOpenNewWindow_Params.Make(aUserType: Integer): IDocument_CommonDocumentOpenNewWindow_Params;
 {* Фабрика TDocument_CommonDocumentOpenNewWindow_Params }
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
//#UC START# *752AC9528539_7E9B206690A9get_var*
//#UC END# *752AC9528539_7E9B206690A9get_var*
begin
//#UC START# *752AC9528539_7E9B206690A9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *752AC9528539_7E9B206690A9get_impl*
end;//TDocument_CommonDocumentOpenNewWindow_Params.Get_UserType

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmEntity;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewWindow у сущности }
//#UC START# *A8FB2EFD4648_7B6D313F7FE5_var*
//#UC END# *A8FB2EFD4648_7B6D313F7FE5_var*
begin
//#UC START# *A8FB2EFD4648_7B6D313F7FE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *A8FB2EFD4648_7B6D313F7FE5_impl*
end;//Op_Document_CommonDocumentOpenNewWindow.Call

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmAggregate;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewWindow у агрегации }
//#UC START# *8BFEEBE0D099_7B6D313F7FE5_var*
//#UC END# *8BFEEBE0D099_7B6D313F7FE5_var*
begin
//#UC START# *8BFEEBE0D099_7B6D313F7FE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *8BFEEBE0D099_7B6D313F7FE5_impl*
end;//Op_Document_CommonDocumentOpenNewWindow.Call

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmEntityForm;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewWindow у формы }
//#UC START# *D627EB7E47E2_7B6D313F7FE5_var*
//#UC END# *D627EB7E47E2_7B6D313F7FE5_var*
begin
//#UC START# *D627EB7E47E2_7B6D313F7FE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *D627EB7E47E2_7B6D313F7FE5_impl*
end;//Op_Document_CommonDocumentOpenNewWindow.Call

class function Op_Document_CommonDocumentOpenNewWindow.Call(const aTarget: IvcmContainer;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewWindow у контейнера }
//#UC START# *2CEC2F43B4A7_7B6D313F7FE5_var*
//#UC END# *2CEC2F43B4A7_7B6D313F7FE5_var*
begin
//#UC START# *2CEC2F43B4A7_7B6D313F7FE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *2CEC2F43B4A7_7B6D313F7FE5_impl*
end;//Op_Document_CommonDocumentOpenNewWindow.Call

constructor TDocument_CommonDocumentOpenNewTab_Params.Create(aUserType: Integer);
 {* Конструктор TDocument_CommonDocumentOpenNewTab_Params }
//#UC START# *87D2E9F9C3C7_7C686B8B8D69_var*
//#UC END# *87D2E9F9C3C7_7C686B8B8D69_var*
begin
//#UC START# *87D2E9F9C3C7_7C686B8B8D69_impl*
 !!! Needs to be implemented !!!
//#UC END# *87D2E9F9C3C7_7C686B8B8D69_impl*
end;//TDocument_CommonDocumentOpenNewTab_Params.Create

class function TDocument_CommonDocumentOpenNewTab_Params.Make(aUserType: Integer): IDocument_CommonDocumentOpenNewTab_Params;
 {* Фабрика TDocument_CommonDocumentOpenNewTab_Params }
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
//#UC START# *0C82262DB84D_7C686B8B8D69get_var*
//#UC END# *0C82262DB84D_7C686B8B8D69get_var*
begin
//#UC START# *0C82262DB84D_7C686B8B8D69get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0C82262DB84D_7C686B8B8D69get_impl*
end;//TDocument_CommonDocumentOpenNewTab_Params.Get_UserType

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmEntity;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewTab у сущности }
//#UC START# *893A014A7BD7_C70148BC39FF_var*
//#UC END# *893A014A7BD7_C70148BC39FF_var*
begin
//#UC START# *893A014A7BD7_C70148BC39FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *893A014A7BD7_C70148BC39FF_impl*
end;//Op_Document_CommonDocumentOpenNewTab.Call

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmAggregate;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewTab у агрегации }
//#UC START# *B979C13A0627_C70148BC39FF_var*
//#UC END# *B979C13A0627_C70148BC39FF_var*
begin
//#UC START# *B979C13A0627_C70148BC39FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *B979C13A0627_C70148BC39FF_impl*
end;//Op_Document_CommonDocumentOpenNewTab.Call

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmEntityForm;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewTab у формы }
//#UC START# *46D8BE46DEBB_C70148BC39FF_var*
//#UC END# *46D8BE46DEBB_C70148BC39FF_var*
begin
//#UC START# *46D8BE46DEBB_C70148BC39FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *46D8BE46DEBB_C70148BC39FF_impl*
end;//Op_Document_CommonDocumentOpenNewTab.Call

class function Op_Document_CommonDocumentOpenNewTab.Call(const aTarget: IvcmContainer;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CommonDocumentOpenNewTab у контейнера }
//#UC START# *E16BEB8FF841_C70148BC39FF_var*
//#UC END# *E16BEB8FF841_C70148BC39FF_var*
begin
//#UC START# *E16BEB8FF841_C70148BC39FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *E16BEB8FF841_C70148BC39FF_impl*
end;//Op_Document_CommonDocumentOpenNewTab.Call

constructor TRedactions_RedactionOnID_Params.Create(aRedactionID: TRedactionID);
 {* Конструктор TRedactions_RedactionOnID_Params }
//#UC START# *F8565F381532_4E9155C2F90E_var*
//#UC END# *F8565F381532_4E9155C2F90E_var*
begin
//#UC START# *F8565F381532_4E9155C2F90E_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8565F381532_4E9155C2F90E_impl*
end;//TRedactions_RedactionOnID_Params.Create

class function TRedactions_RedactionOnID_Params.Make(aRedactionID: TRedactionID): IRedactions_RedactionOnID_Params;
 {* Фабрика TRedactions_RedactionOnID_Params }
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
//#UC START# *57ABD76EB71D_4E9155C2F90Eget_var*
//#UC END# *57ABD76EB71D_4E9155C2F90Eget_var*
begin
//#UC START# *57ABD76EB71D_4E9155C2F90Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *57ABD76EB71D_4E9155C2F90Eget_impl*
end;//TRedactions_RedactionOnID_Params.Get_RedactionID

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmEntity;
 aRedactionID: TRedactionID): Boolean;
 {* Вызов операции Redactions.RedactionOnID у сущности }
//#UC START# *C192DC3F666F_A3E2B1849573_var*
//#UC END# *C192DC3F666F_A3E2B1849573_var*
begin
//#UC START# *C192DC3F666F_A3E2B1849573_impl*
 !!! Needs to be implemented !!!
//#UC END# *C192DC3F666F_A3E2B1849573_impl*
end;//Op_Redactions_RedactionOnID.Call

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmAggregate;
 aRedactionID: TRedactionID): Boolean;
 {* Вызов операции Redactions.RedactionOnID у агрегации }
//#UC START# *F1D29C2EF0BF_A3E2B1849573_var*
//#UC END# *F1D29C2EF0BF_A3E2B1849573_var*
begin
//#UC START# *F1D29C2EF0BF_A3E2B1849573_impl*
 !!! Needs to be implemented !!!
//#UC END# *F1D29C2EF0BF_A3E2B1849573_impl*
end;//Op_Redactions_RedactionOnID.Call

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmEntityForm;
 aRedactionID: TRedactionID): Boolean;
 {* Вызов операции Redactions.RedactionOnID у формы }
//#UC START# *5710BD0C3655_A3E2B1849573_var*
//#UC END# *5710BD0C3655_A3E2B1849573_var*
begin
//#UC START# *5710BD0C3655_A3E2B1849573_impl*
 !!! Needs to be implemented !!!
//#UC END# *5710BD0C3655_A3E2B1849573_impl*
end;//Op_Redactions_RedactionOnID.Call

class function Op_Redactions_RedactionOnID.Call(const aTarget: IvcmContainer;
 aRedactionID: TRedactionID): Boolean;
 {* Вызов операции Redactions.RedactionOnID у контейнера }
//#UC START# *D4E4EEE340E5_A3E2B1849573_var*
//#UC END# *D4E4EEE340E5_A3E2B1849573_var*
begin
//#UC START# *D4E4EEE340E5_A3E2B1849573_impl*
 !!! Needs to be implemented !!!
//#UC END# *D4E4EEE340E5_A3E2B1849573_impl*
end;//Op_Redactions_RedactionOnID.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
