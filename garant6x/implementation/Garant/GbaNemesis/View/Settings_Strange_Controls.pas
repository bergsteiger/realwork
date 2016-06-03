unit Settings_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4AE824CB035A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IStyleEditor_ReloadStylesTree_Params = interface
  {* Параметры для операции StyleEditor.ReloadStylesTree }
  function Get_StyleName: Il3CString;
  property StyleName: Il3CString
   read Get_StyleName;
 end;//IStyleEditor_ReloadStylesTree_Params

 Op_StyleEditor_ReloadStylesTree = {final} class
  {* Класс для вызова операции StyleEditor.ReloadStylesTree }
  public
   class function Call(const aTarget: IvcmEntity;
    const aStyleName: Il3CString): Boolean; overload;
    {* Вызов операции StyleEditor.ReloadStylesTree у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aStyleName: Il3CString): Boolean; overload;
    {* Вызов операции StyleEditor.ReloadStylesTree у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aStyleName: Il3CString): Boolean; overload;
    {* Вызов операции StyleEditor.ReloadStylesTree у формы }
   class function Call(const aTarget: IvcmContainer;
    const aStyleName: Il3CString): Boolean; overload;
    {* Вызов операции StyleEditor.ReloadStylesTree у контейнера }
 end;//Op_StyleEditor_ReloadStylesTree

 IStyleEditor_RestoreStyleTable_Params = interface
  {* Параметры для операции StyleEditor.RestoreStyleTable }
  function Get_RestoreDefault: Boolean;
  property RestoreDefault: Boolean
   read Get_RestoreDefault;
 end;//IStyleEditor_RestoreStyleTable_Params

 Op_StyleEditor_RestoreStyleTable = {final} class
  {* Класс для вызова операции StyleEditor.RestoreStyleTable }
  public
   class function Call(const aTarget: IvcmEntity;
    aRestoreDefault: Boolean): Boolean; overload;
    {* Вызов операции StyleEditor.RestoreStyleTable у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aRestoreDefault: Boolean): Boolean; overload;
    {* Вызов операции StyleEditor.RestoreStyleTable у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aRestoreDefault: Boolean): Boolean; overload;
    {* Вызов операции StyleEditor.RestoreStyleTable у формы }
   class function Call(const aTarget: IvcmContainer;
    aRestoreDefault: Boolean): Boolean; overload;
    {* Вызов операции StyleEditor.RestoreStyleTable у контейнера }
 end;//Op_StyleEditor_RestoreStyleTable

 IStyleEditor_SaveStyleTable_Params = interface
  {* Параметры для операции StyleEditor.SaveStyleTable }
  function Get_SaveAsDefault: Boolean;
  property SaveAsDefault: Boolean
   read Get_SaveAsDefault;
 end;//IStyleEditor_SaveStyleTable_Params

 Op_StyleEditor_SaveStyleTable = {final} class
  {* Класс для вызова операции StyleEditor.SaveStyleTable }
  public
   class function Call(const aTarget: IvcmEntity;
    aSaveAsDefault: Boolean): Boolean; overload;
    {* Вызов операции StyleEditor.SaveStyleTable у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aSaveAsDefault: Boolean): Boolean; overload;
    {* Вызов операции StyleEditor.SaveStyleTable у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aSaveAsDefault: Boolean): Boolean; overload;
    {* Вызов операции StyleEditor.SaveStyleTable у формы }
   class function Call(const aTarget: IvcmContainer;
    aSaveAsDefault: Boolean): Boolean; overload;
    {* Вызов операции StyleEditor.SaveStyleTable у контейнера }
 end;//Op_StyleEditor_SaveStyleTable

 IStyleEditor_SetNewContent_Params = interface
  {* Параметры для операции StyleEditor.SetNewContent }
  function Get_StyleID: Integer;
  property StyleID: Integer
   read Get_StyleID;
 end;//IStyleEditor_SetNewContent_Params

 Op_StyleEditor_SetNewContent = {final} class
  {* Класс для вызова операции StyleEditor.SetNewContent }
  public
   class function Call(const aTarget: IvcmEntity;
    aStyleID: Integer): Boolean; overload;
    {* Вызов операции StyleEditor.SetNewContent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aStyleID: Integer): Boolean; overload;
    {* Вызов операции StyleEditor.SetNewContent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aStyleID: Integer): Boolean; overload;
    {* Вызов операции StyleEditor.SetNewContent у формы }
   class function Call(const aTarget: IvcmContainer;
    aStyleID: Integer): Boolean; overload;
    {* Вызов операции StyleEditor.SetNewContent у контейнера }
 end;//Op_StyleEditor_SetNewContent

 Op_StyleEditor_ReloadStyleTable = {final} class
  {* Класс для вызова операции StyleEditor.ReloadStyleTable }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции StyleEditor.ReloadStyleTable у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции StyleEditor.ReloadStyleTable у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции StyleEditor.ReloadStyleTable у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции StyleEditor.ReloadStyleTable у контейнера }
 end;//Op_StyleEditor_ReloadStyleTable

const
 en_StyleEditor = 'StyleEditor';
 en_capStyleEditor = 'StyleEditor$ReloadStylesTree';
 op_ReloadStylesTree = 'ReloadStylesTree';
 op_capReloadStylesTree = 'ReloadStylesTree';
 op_RestoreStyleTable = 'RestoreStyleTable';
 op_capRestoreStyleTable = '';
 op_SaveStyleTable = 'SaveStyleTable';
 op_capSaveStyleTable = '';
 op_SetNewContent = 'SetNewContent';
 op_capSetNewContent = '';
 op_ReloadStyleTable = 'ReloadStyleTable';
 op_capReloadStyleTable = '';
 en_Result = 'Result';
 en_capResult = '';
 op_RestoreConf = 'RestoreConf';
 op_capRestoreConf = '';
 op_SaveAsDefaultConf = 'SaveAsDefaultConf';
 op_capSaveAsDefaultConf = '';
 op_RestoreAllSettings = 'RestoreAllSettings';
 op_capRestoreAllSettings = '';
 en_PopupMenu = 'PopupMenu';
 en_capPopupMenu = '';
 op_DoActive = 'DoActive';
 op_capDoActive = '';
 op_Modify = 'Modify';
 op_capModify = '';
 op_CopyConfig = 'CopyConfig';
 op_capCopyConfig = '';
 op_ConfInfo = 'ConfInfo';
 op_capConfInfo = '';
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
 TStyleEditor_ReloadStylesTree_Params = {final} class(Tl3CProtoObject, IStyleEditor_ReloadStylesTree_Params)
  {* Реализация IStyleEditor_ReloadStylesTree_Params }
  private
   f_StyleName: Il3CString;
  protected
   function Get_StyleName: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aStyleName: Il3CString); reintroduce;
   class function Make(const aStyleName: Il3CString): IStyleEditor_ReloadStylesTree_Params; reintroduce;
 end;//TStyleEditor_ReloadStylesTree_Params

 TStyleEditor_RestoreStyleTable_Params = {final} class(Tl3CProtoObject, IStyleEditor_RestoreStyleTable_Params)
  {* Реализация IStyleEditor_RestoreStyleTable_Params }
  private
   f_RestoreDefault: Boolean;
  protected
   function Get_RestoreDefault: Boolean;
  public
   constructor Create(aRestoreDefault: Boolean); reintroduce;
   class function Make(aRestoreDefault: Boolean): IStyleEditor_RestoreStyleTable_Params; reintroduce;
 end;//TStyleEditor_RestoreStyleTable_Params

 TStyleEditor_SaveStyleTable_Params = {final} class(Tl3CProtoObject, IStyleEditor_SaveStyleTable_Params)
  {* Реализация IStyleEditor_SaveStyleTable_Params }
  private
   f_SaveAsDefault: Boolean;
  protected
   function Get_SaveAsDefault: Boolean;
  public
   constructor Create(aSaveAsDefault: Boolean); reintroduce;
   class function Make(aSaveAsDefault: Boolean): IStyleEditor_SaveStyleTable_Params; reintroduce;
 end;//TStyleEditor_SaveStyleTable_Params

 TStyleEditor_SetNewContent_Params = {final} class(Tl3CProtoObject, IStyleEditor_SetNewContent_Params)
  {* Реализация IStyleEditor_SetNewContent_Params }
  private
   f_StyleID: Integer;
  protected
   function Get_StyleID: Integer;
  public
   constructor Create(aStyleID: Integer); reintroduce;
   class function Make(aStyleID: Integer): IStyleEditor_SetNewContent_Params; reintroduce;
 end;//TStyleEditor_SetNewContent_Params

constructor TStyleEditor_ReloadStylesTree_Params.Create(const aStyleName: Il3CString);
begin
 inherited Create;
 f_StyleName := aStyleName;
end;//TStyleEditor_ReloadStylesTree_Params.Create

class function TStyleEditor_ReloadStylesTree_Params.Make(const aStyleName: Il3CString): IStyleEditor_ReloadStylesTree_Params;
var
 l_Inst : TStyleEditor_ReloadStylesTree_Params;
begin
 l_Inst := Create(aStyleName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TStyleEditor_ReloadStylesTree_Params.Make

function TStyleEditor_ReloadStylesTree_Params.Get_StyleName: Il3CString;
begin
 Result := f_StyleName;
end;//TStyleEditor_ReloadStylesTree_Params.Get_StyleName

procedure TStyleEditor_ReloadStylesTree_Params.ClearFields;
begin
 f_StyleName := nil;
 inherited;
end;//TStyleEditor_ReloadStylesTree_Params.ClearFields

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmEntity;
 const aStyleName: Il3CString): Boolean;
 {* Вызов операции StyleEditor.ReloadStylesTree у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TStyleEditor_ReloadStylesTree_Params.Make(aStyleName));
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_ReloadStylesTree, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_ReloadStylesTree.Call

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmAggregate;
 const aStyleName: Il3CString): Boolean;
 {* Вызов операции StyleEditor.ReloadStylesTree у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TStyleEditor_ReloadStylesTree_Params.Make(aStyleName));
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_ReloadStylesTree, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_ReloadStylesTree.Call

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmEntityForm;
 const aStyleName: Il3CString): Boolean;
 {* Вызов операции StyleEditor.ReloadStylesTree у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aStyleName);
end;//Op_StyleEditor_ReloadStylesTree.Call

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmContainer;
 const aStyleName: Il3CString): Boolean;
 {* Вызов операции StyleEditor.ReloadStylesTree у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aStyleName);
end;//Op_StyleEditor_ReloadStylesTree.Call

constructor TStyleEditor_RestoreStyleTable_Params.Create(aRestoreDefault: Boolean);
begin
 inherited Create;
 f_RestoreDefault := aRestoreDefault;
end;//TStyleEditor_RestoreStyleTable_Params.Create

class function TStyleEditor_RestoreStyleTable_Params.Make(aRestoreDefault: Boolean): IStyleEditor_RestoreStyleTable_Params;
var
 l_Inst : TStyleEditor_RestoreStyleTable_Params;
begin
 l_Inst := Create(aRestoreDefault);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TStyleEditor_RestoreStyleTable_Params.Make

function TStyleEditor_RestoreStyleTable_Params.Get_RestoreDefault: Boolean;
begin
 Result := f_RestoreDefault;
end;//TStyleEditor_RestoreStyleTable_Params.Get_RestoreDefault

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmEntity;
 aRestoreDefault: Boolean): Boolean;
 {* Вызов операции StyleEditor.RestoreStyleTable у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TStyleEditor_RestoreStyleTable_Params.Make(aRestoreDefault));
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_RestoreStyleTable, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_RestoreStyleTable.Call

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmAggregate;
 aRestoreDefault: Boolean): Boolean;
 {* Вызов операции StyleEditor.RestoreStyleTable у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TStyleEditor_RestoreStyleTable_Params.Make(aRestoreDefault));
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_RestoreStyleTable, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_RestoreStyleTable.Call

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmEntityForm;
 aRestoreDefault: Boolean): Boolean;
 {* Вызов операции StyleEditor.RestoreStyleTable у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aRestoreDefault);
end;//Op_StyleEditor_RestoreStyleTable.Call

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmContainer;
 aRestoreDefault: Boolean): Boolean;
 {* Вызов операции StyleEditor.RestoreStyleTable у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aRestoreDefault);
end;//Op_StyleEditor_RestoreStyleTable.Call

constructor TStyleEditor_SaveStyleTable_Params.Create(aSaveAsDefault: Boolean);
begin
 inherited Create;
 f_SaveAsDefault := aSaveAsDefault;
end;//TStyleEditor_SaveStyleTable_Params.Create

class function TStyleEditor_SaveStyleTable_Params.Make(aSaveAsDefault: Boolean): IStyleEditor_SaveStyleTable_Params;
var
 l_Inst : TStyleEditor_SaveStyleTable_Params;
begin
 l_Inst := Create(aSaveAsDefault);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TStyleEditor_SaveStyleTable_Params.Make

function TStyleEditor_SaveStyleTable_Params.Get_SaveAsDefault: Boolean;
begin
 Result := f_SaveAsDefault;
end;//TStyleEditor_SaveStyleTable_Params.Get_SaveAsDefault

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmEntity;
 aSaveAsDefault: Boolean): Boolean;
 {* Вызов операции StyleEditor.SaveStyleTable у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TStyleEditor_SaveStyleTable_Params.Make(aSaveAsDefault));
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_SaveStyleTable, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_SaveStyleTable.Call

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmAggregate;
 aSaveAsDefault: Boolean): Boolean;
 {* Вызов операции StyleEditor.SaveStyleTable у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TStyleEditor_SaveStyleTable_Params.Make(aSaveAsDefault));
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_SaveStyleTable, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_SaveStyleTable.Call

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmEntityForm;
 aSaveAsDefault: Boolean): Boolean;
 {* Вызов операции StyleEditor.SaveStyleTable у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSaveAsDefault);
end;//Op_StyleEditor_SaveStyleTable.Call

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmContainer;
 aSaveAsDefault: Boolean): Boolean;
 {* Вызов операции StyleEditor.SaveStyleTable у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSaveAsDefault);
end;//Op_StyleEditor_SaveStyleTable.Call

constructor TStyleEditor_SetNewContent_Params.Create(aStyleID: Integer);
begin
 inherited Create;
 f_StyleID := aStyleID;
end;//TStyleEditor_SetNewContent_Params.Create

class function TStyleEditor_SetNewContent_Params.Make(aStyleID: Integer): IStyleEditor_SetNewContent_Params;
var
 l_Inst : TStyleEditor_SetNewContent_Params;
begin
 l_Inst := Create(aStyleID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TStyleEditor_SetNewContent_Params.Make

function TStyleEditor_SetNewContent_Params.Get_StyleID: Integer;
begin
 Result := f_StyleID;
end;//TStyleEditor_SetNewContent_Params.Get_StyleID

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmEntity;
 aStyleID: Integer): Boolean;
 {* Вызов операции StyleEditor.SetNewContent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TStyleEditor_SetNewContent_Params.Make(aStyleID));
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_SetNewContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_SetNewContent.Call

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmAggregate;
 aStyleID: Integer): Boolean;
 {* Вызов операции StyleEditor.SetNewContent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TStyleEditor_SetNewContent_Params.Make(aStyleID));
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_SetNewContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_SetNewContent.Call

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmEntityForm;
 aStyleID: Integer): Boolean;
 {* Вызов операции StyleEditor.SetNewContent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aStyleID);
end;//Op_StyleEditor_SetNewContent.Call

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmContainer;
 aStyleID: Integer): Boolean;
 {* Вызов операции StyleEditor.SetNewContent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aStyleID);
end;//Op_StyleEditor_SetNewContent.Call

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции StyleEditor.ReloadStyleTable у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_ReloadStyleTable, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_ReloadStyleTable.Call

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции StyleEditor.ReloadStyleTable у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_StyleEditor_ReloadStyleTable, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_StyleEditor_ReloadStyleTable.Call

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции StyleEditor.ReloadStyleTable у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_StyleEditor_ReloadStyleTable.Call

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции StyleEditor.ReloadStyleTable у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_StyleEditor_ReloadStyleTable.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
