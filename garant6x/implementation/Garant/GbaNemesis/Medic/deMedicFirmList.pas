unit deMedicFirmList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/deMedicFirmList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TdeMedicFirmList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicTreeUnit,
  l3TreeInterfaces,
  MedicInterfaces,
  l3ProtoObject,
  DocumentInterfaces,
  bsTypesNew,
  DocumentUnit,
  nsTypes,
  AdapterFacade,
  bsTypes,
  DynamicDocListUnit,
  l3Interfaces,
  PrimPrimListInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeMedicFirmList = class(Tl3ProtoObject, IdeMedicFirmList, IdeDocInfo {from IdeMedicFirmList})
 private
 // private fields
   f_CountryFilterTree : Il3SimpleTree;
   f_CurrentCountryFilter : Il3SimpleNode;
   f_Current : INodeBase;
   f_DocInfo : IdeDocInfo;
 protected
 // realized methods
   function IsSame(const aDocInfo: IdeDocInfo;
    aView: Boolean = True;
    aPosition: Boolean = True): Boolean;
     {* сравнить документы.
           - aView: возвращает равенство документов с учетом их состояния (в
                    отличии от is_same_entity, который возвращает равенство без
                    учета состояния). Состоянием документа является суперпозиция
                    номера редакции, языка и списка извлечений.
           - aPosition: сравнивать с учетом позиций. }
   procedure SetPosition(const aPos: TbsDocPos);
   function ChangeRedaction(aChangeType: TnsChangeRedactionType;
    aRedaction: TRedactionID = 0): Boolean; overload; 
   function ChangeRedaction(const aDate: AdapterDate): Boolean; overload; 
   function ChangeRedaction(const aDocument: IDocument): Boolean; overload; 
   procedure InitListNode(const aRoot: INodeBase;
    const aListNode: INodeBase);
     {* документ открывается из списка }
   procedure CorrectLanguage(aLanguage: TbsLanguage);
   function Clone: IdeDocInfo;
   function pm_GetDoc: IDocument;
   procedure pm_SetDoc(const aValue: IDocument);
   function pm_GetDocumentState: IDocumentState;
   function pm_GetPos: TbsDocPos;
   procedure pm_SetPos(const aValue: TbsDocPos);
   function pm_GetLanguage: TbsLanguage;
   function pm_GetList: IDynList;
   function pm_GetListNode: INodeBase;
   function pm_GetDocName: Il3CString;
   function pm_GetDocShortName: Il3CString;
   function pm_GetCurEditionName: Il3CString;
   function pm_GetDataSize: Il3CString;
   function pm_GetInternalNumber: Il3CString;
   function pm_GetListRoot: INodeBase;
   function Get_DocType: TDocumentType;
   function pm_GetSearchInfo: IdeSearchInfo;
   procedure pm_SetSearchInfo(const aValue: IdeSearchInfo);
   function pm_GetFilePosition: Il3CString;
   procedure ClearListNode;
     {* http://mdp.garant.ru/pages/viewpage.action?pageId=124453871&focusedCommentId=173507098#comment-173507098 }
   function pm_GetCurrent: INodeBase;
   procedure pm_SetCurrent(const aValue: INodeBase);
   function pm_GetCountryFilterTree: Il3SimpleTree;
   procedure pm_SetCountryFilterTree(const aValue: Il3SimpleTree);
   function pm_GetCurrentCountryFilter: Il3SimpleNode;
   procedure pm_SetCurrentCountryFilter(const aValue: Il3SimpleNode);
 public
 // public methods
   constructor Create(const aDocInfo: IdeDocInfo;
     const aCurrent: INodeBase;
     const aCountryFilter: Il3SimpleTree;
     const aCurrentCountryFilter: Il3SimpleNode); reintroduce;
   class function Make(const aDocInfo: IdeDocInfo;
     const aCurrent: INodeBase;
     const aCountryFilter: Il3SimpleTree;
     const aCurrentCountryFilter: Il3SimpleNode): IdeMedicFirmList; reintroduce;
     {* Сигнатура фабрики TdeMedicFirmList.Make }
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IdeDocInfo: IdeDocInfo;
 end;//TdeMedicFirmList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeMedicFirmList

constructor TdeMedicFirmList.Create(const aDocInfo: IdeDocInfo;
  const aCurrent: INodeBase;
  const aCountryFilter: Il3SimpleTree;
  const aCurrentCountryFilter: Il3SimpleNode);
//#UC START# *561F6E61019E_561F6D380330_var*
//#UC END# *561F6E61019E_561F6D380330_var*
begin
//#UC START# *561F6E61019E_561F6D380330_impl*
 inherited Create;
 f_DocInfo := aDocInfo;
 // Лучше заковырять IdeDocInfo внутрь и перетранслировать запросы ему,
 // чем писать QueryInterface.
 // Хотя всё это - признак кривизны архитектуры всей этой конструкции с sds/ds/de/d
 f_Current := aCurrent;
 f_CountryFilterTree := aCountryFilter;
 f_CurrentCountryFilter := aCurrentCountryFilter;
//#UC END# *561F6E61019E_561F6D380330_impl*
end;//TdeMedicFirmList.Create

class function TdeMedicFirmList.Make(const aDocInfo: IdeDocInfo;
  const aCurrent: INodeBase;
  const aCountryFilter: Il3SimpleTree;
  const aCurrentCountryFilter: Il3SimpleNode): IdeMedicFirmList;
var
 l_Inst : TdeMedicFirmList;
begin
 l_Inst := Create(aDocInfo, aCurrent, aCountryFilter, aCurrentCountryFilter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdeMedicFirmList.IsSame(const aDocInfo: IdeDocInfo;
  aView: Boolean = True;
  aPosition: Boolean = True): Boolean;
//#UC START# *4B1D118000EA_561F6D380330_var*
//#UC END# *4B1D118000EA_561F6D380330_var*
begin
//#UC START# *4B1D118000EA_561F6D380330_impl*
 Result := f_DocInfo.IsSame(aDocInfo, aView, aPosition);
//#UC END# *4B1D118000EA_561F6D380330_impl*
end;//TdeMedicFirmList.IsSame

procedure TdeMedicFirmList.SetPosition(const aPos: TbsDocPos);
//#UC START# *4B1D11B00164_561F6D380330_var*
//#UC END# *4B1D11B00164_561F6D380330_var*
begin
//#UC START# *4B1D11B00164_561F6D380330_impl*
 f_DocInfo.SetPosition(aPos);
//#UC END# *4B1D11B00164_561F6D380330_impl*
end;//TdeMedicFirmList.SetPosition

function TdeMedicFirmList.ChangeRedaction(aChangeType: TnsChangeRedactionType;
  aRedaction: TRedactionID = 0): Boolean;
//#UC START# *4B1D11CF0265_561F6D380330_var*
//#UC END# *4B1D11CF0265_561F6D380330_var*
begin
//#UC START# *4B1D11CF0265_561F6D380330_impl*
 Result := f_DocInfo.ChangeRedaction(aChangeType);
//#UC END# *4B1D11CF0265_561F6D380330_impl*
end;//TdeMedicFirmList.ChangeRedaction

function TdeMedicFirmList.ChangeRedaction(const aDate: AdapterDate): Boolean;
//#UC START# *4B1D11E00385_561F6D380330_var*
//#UC END# *4B1D11E00385_561F6D380330_var*
begin
//#UC START# *4B1D11E00385_561F6D380330_impl*
 f_DocInfo.ChangeRedaction(aDate);
//#UC END# *4B1D11E00385_561F6D380330_impl*
end;//TdeMedicFirmList.ChangeRedaction

function TdeMedicFirmList.ChangeRedaction(const aDocument: IDocument): Boolean;
//#UC START# *4B1D11F0033E_561F6D380330_var*
//#UC END# *4B1D11F0033E_561F6D380330_var*
begin
//#UC START# *4B1D11F0033E_561F6D380330_impl*
 Result := f_DocInfo.ChangeRedaction(aDocument);
//#UC END# *4B1D11F0033E_561F6D380330_impl*
end;//TdeMedicFirmList.ChangeRedaction

procedure TdeMedicFirmList.InitListNode(const aRoot: INodeBase;
  const aListNode: INodeBase);
//#UC START# *4B1D11FE0117_561F6D380330_var*
//#UC END# *4B1D11FE0117_561F6D380330_var*
begin
//#UC START# *4B1D11FE0117_561F6D380330_impl*
 f_DocInfo.InitListNode(aRoot, aListNode);
//#UC END# *4B1D11FE0117_561F6D380330_impl*
end;//TdeMedicFirmList.InitListNode

procedure TdeMedicFirmList.CorrectLanguage(aLanguage: TbsLanguage);
//#UC START# *4B1D121B03D0_561F6D380330_var*
//#UC END# *4B1D121B03D0_561F6D380330_var*
begin
//#UC START# *4B1D121B03D0_561F6D380330_impl*
 f_DocInfo.CorrectLanguage(aLanguage);
//#UC END# *4B1D121B03D0_561F6D380330_impl*
end;//TdeMedicFirmList.CorrectLanguage

function TdeMedicFirmList.Clone: IdeDocInfo;
//#UC START# *4B1D12260038_561F6D380330_var*
//#UC END# *4B1D12260038_561F6D380330_var*
begin
//#UC START# *4B1D12260038_561F6D380330_impl*
 Result := f_DocInfo.Clone;
//#UC END# *4B1D12260038_561F6D380330_impl*
end;//TdeMedicFirmList.Clone

function TdeMedicFirmList.pm_GetDoc: IDocument;
//#UC START# *4B1D126203E6_561F6D380330get_var*
//#UC END# *4B1D126203E6_561F6D380330get_var*
begin
//#UC START# *4B1D126203E6_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetDoc;
//#UC END# *4B1D126203E6_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetDoc

procedure TdeMedicFirmList.pm_SetDoc(const aValue: IDocument);
//#UC START# *4B1D126203E6_561F6D380330set_var*
//#UC END# *4B1D126203E6_561F6D380330set_var*
begin
//#UC START# *4B1D126203E6_561F6D380330set_impl*
 f_DocInfo.pm_SetDoc(aValue);
//#UC END# *4B1D126203E6_561F6D380330set_impl*
end;//TdeMedicFirmList.pm_SetDoc

function TdeMedicFirmList.pm_GetDocumentState: IDocumentState;
//#UC START# *4B1D127600DC_561F6D380330get_var*
//#UC END# *4B1D127600DC_561F6D380330get_var*
begin
//#UC START# *4B1D127600DC_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetDocumentState;
//#UC END# *4B1D127600DC_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetDocumentState

function TdeMedicFirmList.pm_GetPos: TbsDocPos;
//#UC START# *4B1D12A30083_561F6D380330get_var*
//#UC END# *4B1D12A30083_561F6D380330get_var*
begin
//#UC START# *4B1D12A30083_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetPos;
//#UC END# *4B1D12A30083_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetPos

procedure TdeMedicFirmList.pm_SetPos(const aValue: TbsDocPos);
//#UC START# *4B1D12A30083_561F6D380330set_var*
//#UC END# *4B1D12A30083_561F6D380330set_var*
begin
//#UC START# *4B1D12A30083_561F6D380330set_impl*
 f_DocInfo.pm_SetPos(aValue);
//#UC END# *4B1D12A30083_561F6D380330set_impl*
end;//TdeMedicFirmList.pm_SetPos

function TdeMedicFirmList.pm_GetLanguage: TbsLanguage;
//#UC START# *4B1D12C103CC_561F6D380330get_var*
//#UC END# *4B1D12C103CC_561F6D380330get_var*
begin
//#UC START# *4B1D12C103CC_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetLanguage;
//#UC END# *4B1D12C103CC_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetLanguage

function TdeMedicFirmList.pm_GetList: IDynList;
//#UC START# *4B1D12F10074_561F6D380330get_var*
//#UC END# *4B1D12F10074_561F6D380330get_var*
begin
//#UC START# *4B1D12F10074_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetList;
//#UC END# *4B1D12F10074_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetList

function TdeMedicFirmList.pm_GetListNode: INodeBase;
//#UC START# *4B1D13200333_561F6D380330get_var*
//#UC END# *4B1D13200333_561F6D380330get_var*
begin
//#UC START# *4B1D13200333_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetListNode;
//#UC END# *4B1D13200333_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetListNode

function TdeMedicFirmList.pm_GetDocName: Il3CString;
//#UC START# *4B1D137202D9_561F6D380330get_var*
//#UC END# *4B1D137202D9_561F6D380330get_var*
begin
//#UC START# *4B1D137202D9_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetDocName;
//#UC END# *4B1D137202D9_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetDocName

function TdeMedicFirmList.pm_GetDocShortName: Il3CString;
//#UC START# *4B1D13AF006C_561F6D380330get_var*
//#UC END# *4B1D13AF006C_561F6D380330get_var*
begin
//#UC START# *4B1D13AF006C_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetDocShortName;
//#UC END# *4B1D13AF006C_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetDocShortName

function TdeMedicFirmList.pm_GetCurEditionName: Il3CString;
//#UC START# *4B1D13C500CA_561F6D380330get_var*
//#UC END# *4B1D13C500CA_561F6D380330get_var*
begin
//#UC START# *4B1D13C500CA_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetCurEditionName;
//#UC END# *4B1D13C500CA_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetCurEditionName

function TdeMedicFirmList.pm_GetDataSize: Il3CString;
//#UC START# *4B1D13D501CF_561F6D380330get_var*
//#UC END# *4B1D13D501CF_561F6D380330get_var*
begin
//#UC START# *4B1D13D501CF_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetDataSize;
//#UC END# *4B1D13D501CF_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetDataSize

function TdeMedicFirmList.pm_GetInternalNumber: Il3CString;
//#UC START# *4B1D13E30017_561F6D380330get_var*
//#UC END# *4B1D13E30017_561F6D380330get_var*
begin
//#UC START# *4B1D13E30017_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetInternalNumber;
//#UC END# *4B1D13E30017_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetInternalNumber

function TdeMedicFirmList.pm_GetListRoot: INodeBase;
//#UC START# *4B1D142201E3_561F6D380330get_var*
//#UC END# *4B1D142201E3_561F6D380330get_var*
begin
//#UC START# *4B1D142201E3_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetListRoot;
//#UC END# *4B1D142201E3_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetListRoot

function TdeMedicFirmList.Get_DocType: TDocumentType;
//#UC START# *4B1D144802C3_561F6D380330get_var*
//#UC END# *4B1D144802C3_561F6D380330get_var*
begin
//#UC START# *4B1D144802C3_561F6D380330get_impl*
 Result := f_DocInfo.Get_DocType;
//#UC END# *4B1D144802C3_561F6D380330get_impl*
end;//TdeMedicFirmList.Get_DocType

function TdeMedicFirmList.pm_GetSearchInfo: IdeSearchInfo;
//#UC START# *4B1D14B701DF_561F6D380330get_var*
//#UC END# *4B1D14B701DF_561F6D380330get_var*
begin
//#UC START# *4B1D14B701DF_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetSearchInfo;
//#UC END# *4B1D14B701DF_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetSearchInfo

procedure TdeMedicFirmList.pm_SetSearchInfo(const aValue: IdeSearchInfo);
//#UC START# *4B1D14B701DF_561F6D380330set_var*
//#UC END# *4B1D14B701DF_561F6D380330set_var*
begin
//#UC START# *4B1D14B701DF_561F6D380330set_impl*
 f_DocInfo.pm_SetSearchInfo(aValue);
//#UC END# *4B1D14B701DF_561F6D380330set_impl*
end;//TdeMedicFirmList.pm_SetSearchInfo

function TdeMedicFirmList.pm_GetFilePosition: Il3CString;
//#UC START# *4B1D14CE0062_561F6D380330get_var*
//#UC END# *4B1D14CE0062_561F6D380330get_var*
begin
//#UC START# *4B1D14CE0062_561F6D380330get_impl*
 Result := f_DocInfo.pm_GetFilePosition;
//#UC END# *4B1D14CE0062_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetFilePosition

procedure TdeMedicFirmList.ClearListNode;
//#UC START# *4B1FA0B003E1_561F6D380330_var*
//#UC END# *4B1FA0B003E1_561F6D380330_var*
begin
//#UC START# *4B1FA0B003E1_561F6D380330_impl*
 f_DocInfo.ClearListNode;
//#UC END# *4B1FA0B003E1_561F6D380330_impl*
end;//TdeMedicFirmList.ClearListNode

function TdeMedicFirmList.pm_GetCurrent: INodeBase;
//#UC START# *561F637B0070_561F6D380330get_var*
//#UC END# *561F637B0070_561F6D380330get_var*
begin
//#UC START# *561F637B0070_561F6D380330get_impl*
 Result := f_Current;
//#UC END# *561F637B0070_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetCurrent

procedure TdeMedicFirmList.pm_SetCurrent(const aValue: INodeBase);
//#UC START# *561F637B0070_561F6D380330set_var*
//#UC END# *561F637B0070_561F6D380330set_var*
begin
//#UC START# *561F637B0070_561F6D380330set_impl*
 f_Current := aValue;
//#UC END# *561F637B0070_561F6D380330set_impl*
end;//TdeMedicFirmList.pm_SetCurrent

function TdeMedicFirmList.pm_GetCountryFilterTree: Il3SimpleTree;
//#UC START# *561F638A0039_561F6D380330get_var*
//#UC END# *561F638A0039_561F6D380330get_var*
begin
//#UC START# *561F638A0039_561F6D380330get_impl*
 Result := f_CountryFilterTree;
//#UC END# *561F638A0039_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetCountryFilterTree

procedure TdeMedicFirmList.pm_SetCountryFilterTree(const aValue: Il3SimpleTree);
//#UC START# *561F638A0039_561F6D380330set_var*
//#UC END# *561F638A0039_561F6D380330set_var*
begin
//#UC START# *561F638A0039_561F6D380330set_impl*
 f_CountryFilterTree := aValue;
//#UC END# *561F638A0039_561F6D380330set_impl*
end;//TdeMedicFirmList.pm_SetCountryFilterTree

function TdeMedicFirmList.pm_GetCurrentCountryFilter: Il3SimpleNode;
//#UC START# *561F6394002D_561F6D380330get_var*
//#UC END# *561F6394002D_561F6D380330get_var*
begin
//#UC START# *561F6394002D_561F6D380330get_impl*
 Result := f_CurrentCountryFilter;
//#UC END# *561F6394002D_561F6D380330get_impl*
end;//TdeMedicFirmList.pm_GetCurrentCountryFilter

procedure TdeMedicFirmList.pm_SetCurrentCountryFilter(const aValue: Il3SimpleNode);
//#UC START# *561F6394002D_561F6D380330set_var*
//#UC END# *561F6394002D_561F6D380330set_var*
begin
//#UC START# *561F6394002D_561F6D380330set_impl*
 f_CurrentCountryFilter := aValue;
//#UC END# *561F6394002D_561F6D380330set_impl*
end;//TdeMedicFirmList.pm_SetCurrentCountryFilter

// Методы преобразования к реализуемым интерфейсам

function TdeMedicFirmList.As_IdeDocInfo: IdeDocInfo;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

end.