unit CompareEditions_Controls;
 {* Операции специфичные для Сравнения редакций }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\CompareEditions_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "CompareEditions" MUID: (4A897A0F0097)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , Base_Operations_Editions_Controls
 , NavigationInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TGotoParaResult = (
  {* Результат перехода на параграф }
  gtprFail
   {* Неуспешно }
  , gtprOk
   {* Успешно }
  , gtprAlready
   {* Уже стояли на этом параграфе }
 );//TGotoParaResult

 IDocument_OpenEditionLocalLink_Params = interface
  {* Параметры для операции Document.OpenEditionLocalLink }
  function Get_Document: IDocument;
  function Get_Sub: Cardinal;
  function Get_Behaviour: TbsProcessHyperLinkBehaviour;
  property Document: IDocument
   read Get_Document;
  property Sub: Cardinal
   read Get_Sub;
  property Behaviour: TbsProcessHyperLinkBehaviour
   read Get_Behaviour;
 end;//IDocument_OpenEditionLocalLink_Params

 Op_Document_OpenEditionLocalLink = {final} class
  {* Класс для вызова операции Document.OpenEditionLocalLink }
  public
   class function Call(const aTarget: IvcmEntity;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload;
    {* Вызов операции Document.OpenEditionLocalLink у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload;
    {* Вызов операции Document.OpenEditionLocalLink у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload;
    {* Вызов операции Document.OpenEditionLocalLink у формы }
   class function Call(const aTarget: IvcmContainer;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload;
    {* Вызов операции Document.OpenEditionLocalLink у контейнера }
 end;//Op_Document_OpenEditionLocalLink

 Op_RightEdition_ReturnToDocument = {final} class
  {* Класс для вызова операции RightEdition.ReturnToDocument }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции RightEdition.ReturnToDocument у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции RightEdition.ReturnToDocument у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции RightEdition.ReturnToDocument у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции RightEdition.ReturnToDocument у контейнера }
 end;//Op_RightEdition_ReturnToDocument

 Op_RightEdition_SetFocusToText = {final} class
  {* Класс для вызова операции RightEdition.SetFocusToText }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции RightEdition.SetFocusToText у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции RightEdition.SetFocusToText у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции RightEdition.SetFocusToText у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции RightEdition.SetFocusToText у контейнера }
 end;//Op_RightEdition_SetFocusToText

 IRightEdition_IsCurrentPara_Params = interface
  {* Параметры для операции RightEdition.IsCurrentPara }
  function Get_Para: Integer;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Para: Integer
   read Get_Para;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IRightEdition_IsCurrentPara_Params

 Op_RightEdition_IsCurrentPara = {final} class
  {* Класс для вызова операции RightEdition.IsCurrentPara }
  public
   class function Call(const aTarget: IvcmEntity;
    aPara: Integer): Boolean; overload;
    {* Вызов операции RightEdition.IsCurrentPara у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aPara: Integer): Boolean; overload;
    {* Вызов операции RightEdition.IsCurrentPara у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aPara: Integer): Boolean; overload;
    {* Вызов операции RightEdition.IsCurrentPara у формы }
   class function Call(const aTarget: IvcmContainer;
    aPara: Integer): Boolean; overload;
    {* Вызов операции RightEdition.IsCurrentPara у контейнера }
 end;//Op_RightEdition_IsCurrentPara

 IFinder_GotoPara_Params = interface
  {* Параметры для операции Finder.GotoPara }
  function Get_Para: Integer;
  function Get_ResultValue: TGotoParaResult;
  procedure Set_ResultValue(aValue: TGotoParaResult);
  property Para: Integer
   read Get_Para;
  property ResultValue: TGotoParaResult
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFinder_GotoPara_Params

 Op_Finder_GotoPara = {final} class
  {* Класс для вызова операции Finder.GotoPara }
  public
   class function Call(const aTarget: IvcmEntity;
    aPara: Integer): TGotoParaResult; overload;
    {* Вызов операции Finder.GotoPara у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aPara: Integer): TGotoParaResult; overload;
    {* Вызов операции Finder.GotoPara у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aPara: Integer): TGotoParaResult; overload;
    {* Вызов операции Finder.GotoPara у формы }
   class function Call(const aTarget: IvcmContainer;
    aPara: Integer): TGotoParaResult; overload;
    {* Вызов операции Finder.GotoPara у контейнера }
 end;//Op_Finder_GotoPara

 Op_Finder_DisableForceDrawFocusRect = {final} class
  {* Класс для вызова операции Finder.DisableForceDrawFocusRect }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Finder.DisableForceDrawFocusRect у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Finder.DisableForceDrawFocusRect у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Finder.DisableForceDrawFocusRect у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Finder.DisableForceDrawFocusRect у контейнера }
 end;//Op_Finder_DisableForceDrawFocusRect

const
 en_Edition = Base_Operations_Editions_Controls.en_Edition;
 en_capEdition = Base_Operations_Editions_Controls.en_capEdition;
 op_PrevChange = 'PrevChange';
 op_capPrevChange = 'Предыдущее изменение';
 op_NextChange = 'NextChange';
 op_capNextChange = 'Следующее изменение';
 en_Document = 'Document';
 en_capDocument = '';
 op_OpenEditionLocalLink = 'OpenEditionLocalLink';
 op_capOpenEditionLocalLink = 'Переход по локальной ссылке на редакцию';
 en_RightEdition = 'RightEdition';
 en_capRightEdition = 'Текущая редакция';
 op_ReturnToDocument = 'ReturnToDocument';
 op_capReturnToDocument = 'Вернуться в текст документа';
 op_SetFocusToText = 'SetFocusToText';
 op_capSetFocusToText = 'Устанавливает фокус тексту';
 op_IsCurrentPara = 'IsCurrentPara';
 op_capIsCurrentPara = 'Является ли параграф текущим';
 en_Finder = 'Finder';
 en_capFinder = 'Инструмент для поиска';
 op_GotoPara = 'GotoPara';
 op_capGotoPara = 'Перейти к параграфу по номеру';
 op_DisableForceDrawFocusRect = 'DisableForceDrawFocusRect';
 op_capDisableForceDrawFocusRect = 'Запрещает рисование фокусной рамки';
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
 TDocument_OpenEditionLocalLink_Params = {final} class(Tl3CProtoObject, IDocument_OpenEditionLocalLink_Params)
  {* Реализация IDocument_OpenEditionLocalLink_Params }
  private
   f_Document: IDocument;
   f_Sub: Cardinal;
   f_Behaviour: TbsProcessHyperLinkBehaviour;
  protected
   function Get_Document: IDocument;
   function Get_Sub: Cardinal;
   function Get_Behaviour: TbsProcessHyperLinkBehaviour;
   procedure ClearFields; override;
  public
   constructor Create(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); reintroduce;
   class function Make(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): IDocument_OpenEditionLocalLink_Params; reintroduce;
 end;//TDocument_OpenEditionLocalLink_Params

 TRightEdition_IsCurrentPara_Params = {final} class(Tl3CProtoObject, IRightEdition_IsCurrentPara_Params)
  {* Реализация IRightEdition_IsCurrentPara_Params }
  private
   f_Para: Integer;
   f_ResultValue: Boolean;
  protected
   function Get_Para: Integer;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create(aPara: Integer); reintroduce;
   class function Make(aPara: Integer): IRightEdition_IsCurrentPara_Params; reintroduce;
 end;//TRightEdition_IsCurrentPara_Params

 TFinder_GotoPara_Params = {final} class(Tl3CProtoObject, IFinder_GotoPara_Params)
  {* Реализация IFinder_GotoPara_Params }
  private
   f_Para: Integer;
   f_ResultValue: TGotoParaResult;
  protected
   function Get_Para: Integer;
   function Get_ResultValue: TGotoParaResult;
   procedure Set_ResultValue(aValue: TGotoParaResult);
  public
   constructor Create(aPara: Integer); reintroduce;
   class function Make(aPara: Integer): IFinder_GotoPara_Params; reintroduce;
 end;//TFinder_GotoPara_Params

constructor TDocument_OpenEditionLocalLink_Params.Create(const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour);
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
end;//TDocument_OpenEditionLocalLink_Params.Make

function TDocument_OpenEditionLocalLink_Params.Get_Document: IDocument;
begin
 Result := f_Document;
end;//TDocument_OpenEditionLocalLink_Params.Get_Document

function TDocument_OpenEditionLocalLink_Params.Get_Sub: Cardinal;
begin
 Result := f_Sub;
end;//TDocument_OpenEditionLocalLink_Params.Get_Sub

function TDocument_OpenEditionLocalLink_Params.Get_Behaviour: TbsProcessHyperLinkBehaviour;
begin
 Result := f_Behaviour;
end;//TDocument_OpenEditionLocalLink_Params.Get_Behaviour

procedure TDocument_OpenEditionLocalLink_Params.ClearFields;
begin
 f_Document := nil;
 inherited;
end;//TDocument_OpenEditionLocalLink_Params.ClearFields

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmEntity;
 const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* Вызов операции Document.OpenEditionLocalLink у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenEditionLocalLink_Params.Make(aDocument, aSub, aBehaviour));
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
 {* Вызов операции Document.OpenEditionLocalLink у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_OpenEditionLocalLink_Params.Make(aDocument, aSub, aBehaviour));
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
 {* Вызов операции Document.OpenEditionLocalLink у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aDocument, aSub, aBehaviour);
end;//Op_Document_OpenEditionLocalLink.Call

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmContainer;
 const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* Вызов операции Document.OpenEditionLocalLink у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aDocument, aSub, aBehaviour);
end;//Op_Document_OpenEditionLocalLink.Call

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции RightEdition.ReturnToDocument у сущности }
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
 {* Вызов операции RightEdition.ReturnToDocument у агрегации }
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
 {* Вызов операции RightEdition.ReturnToDocument у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_RightEdition_ReturnToDocument.Call

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции RightEdition.ReturnToDocument у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_RightEdition_ReturnToDocument.Call

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции RightEdition.SetFocusToText у сущности }
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
 {* Вызов операции RightEdition.SetFocusToText у агрегации }
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
 {* Вызов операции RightEdition.SetFocusToText у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_RightEdition_SetFocusToText.Call

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции RightEdition.SetFocusToText у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_RightEdition_SetFocusToText.Call

constructor TRightEdition_IsCurrentPara_Params.Create(aPara: Integer);
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
end;//TRightEdition_IsCurrentPara_Params.Make

function TRightEdition_IsCurrentPara_Params.Get_Para: Integer;
begin
 Result := f_Para;
end;//TRightEdition_IsCurrentPara_Params.Get_Para

function TRightEdition_IsCurrentPara_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TRightEdition_IsCurrentPara_Params.Get_ResultValue

procedure TRightEdition_IsCurrentPara_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TRightEdition_IsCurrentPara_Params.Set_ResultValue

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmEntity;
 aPara: Integer): Boolean;
 {* Вызов операции RightEdition.IsCurrentPara у сущности }
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
 {* Вызов операции RightEdition.IsCurrentPara у агрегации }
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
 {* Вызов операции RightEdition.IsCurrentPara у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aPara);
end;//Op_RightEdition_IsCurrentPara.Call

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmContainer;
 aPara: Integer): Boolean;
 {* Вызов операции RightEdition.IsCurrentPara у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aPara);
end;//Op_RightEdition_IsCurrentPara.Call

constructor TFinder_GotoPara_Params.Create(aPara: Integer);
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
end;//TFinder_GotoPara_Params.Make

function TFinder_GotoPara_Params.Get_Para: Integer;
begin
 Result := f_Para;
end;//TFinder_GotoPara_Params.Get_Para

function TFinder_GotoPara_Params.Get_ResultValue: TGotoParaResult;
begin
 Result := f_ResultValue;
end;//TFinder_GotoPara_Params.Get_ResultValue

procedure TFinder_GotoPara_Params.Set_ResultValue(aValue: TGotoParaResult);
begin
 f_ResultValue := aValue;
end;//TFinder_GotoPara_Params.Set_ResultValue

class function Op_Finder_GotoPara.Call(const aTarget: IvcmEntity;
 aPara: Integer): TGotoParaResult;
 {* Вызов операции Finder.GotoPara у сущности }
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
 {* Вызов операции Finder.GotoPara у агрегации }
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
 {* Вызов операции Finder.GotoPara у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aPara);
end;//Op_Finder_GotoPara.Call

class function Op_Finder_GotoPara.Call(const aTarget: IvcmContainer;
 aPara: Integer): TGotoParaResult;
 {* Вызов операции Finder.GotoPara у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aPara);
end;//Op_Finder_GotoPara.Call

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Finder.DisableForceDrawFocusRect у сущности }
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
 {* Вызов операции Finder.DisableForceDrawFocusRect у агрегации }
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
 {* Вызов операции Finder.DisableForceDrawFocusRect у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Finder_DisableForceDrawFocusRect.Call

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Finder.DisableForceDrawFocusRect у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Finder_DisableForceDrawFocusRect.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
