unit Settings_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings_Strange_Controls.pas"
// Начат: 28.10.2009 14:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Основные прецеденты::Settings::View::Strange
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
  l3Interfaces,
  l3CProtoObject
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* StyleEditor = operations
  {* StyleEditor$ReloadStylesTree }
   ['{263F2F5D-16CF-4370-B090-852B8EC2A769}']
   query ReloadStylesTree(const aStyleName: Il3CString);
     {* ReloadStylesTree }
 end;//StyleEditor*)

(* StyleEditor = operations
   ['{FC0C9D99-D9B6-41F0-BBB8-411CEEE1F980}']
   query RestoreStyleTable(aRestoreDefault: Boolean);
   query SaveStyleTable(aSaveAsDefault: Boolean);
   query SetNewContent(aStyleID: Integer);
 end;//StyleEditor*)

(* StyleEditor = operations
   ['{E91573CE-43BB-42B9-8F61-2BE63B4240F1}']
   query ReloadStyleTable;
 end;//StyleEditor*)

(* Result = operations
   ['{A8587FF6-9974-462A-9540-F1D9433A4659}']
   operation RestoreConf;
   operation SaveAsDefaultConf;
   operation RestoreAllSettings;
 end;//Result*)

(* PopupMenu = operations
   ['{AC6B52EC-71CE-4D83-8A71-82C015C165D4}']
   operation DoActive;
   operation Modify;
   operation CopyConfig;
   query ConfInfo;
   query RestoreAllSettings;
   operation RestoreConf;
   operation SaveAsDefaultConf;
 end;//PopupMenu*)

type
 IStyleEditor_ReloadStylesTree_Params = interface(IUnknown)
  {* Параметры для операции StyleEditor.ReloadStylesTree }
   ['{44E58188-3AF4-4C21-83BC-CD468E83F8D6}']
   function Get_StyleName: Il3CString;
   property StyleName: Il3CString
     read Get_StyleName;
     {* undefined }
 end;//IStyleEditor_ReloadStylesTree_Params

 Op_StyleEditor_ReloadStylesTree = class
  {* Класс для вызова операции StyleEditor.ReloadStylesTree }
 public
 // public methods
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

 IStyleEditor_RestoreStyleTable_Params = interface(IUnknown)
  {* Параметры для операции StyleEditor.RestoreStyleTable }
   ['{325BF732-0BD7-4E61-BEC5-48A77132247C}']
   function Get_RestoreDefault: Boolean;
   property RestoreDefault: Boolean
     read Get_RestoreDefault;
     {* undefined }
 end;//IStyleEditor_RestoreStyleTable_Params

 Op_StyleEditor_RestoreStyleTable = class
  {* Класс для вызова операции StyleEditor.RestoreStyleTable }
 public
 // public methods
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

 IStyleEditor_SaveStyleTable_Params = interface(IUnknown)
  {* Параметры для операции StyleEditor.SaveStyleTable }
   ['{71D351FB-D271-45F9-A89E-75908DCA75A2}']
   function Get_SaveAsDefault: Boolean;
   property SaveAsDefault: Boolean
     read Get_SaveAsDefault;
     {* undefined }
 end;//IStyleEditor_SaveStyleTable_Params

 Op_StyleEditor_SaveStyleTable = class
  {* Класс для вызова операции StyleEditor.SaveStyleTable }
 public
 // public methods
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

 IStyleEditor_SetNewContent_Params = interface(IUnknown)
  {* Параметры для операции StyleEditor.SetNewContent }
   ['{23154956-86C0-45EA-A8AE-5A3CDA3D0F9A}']
   function Get_StyleID: Integer;
   property StyleID: Integer
     read Get_StyleID;
     {* undefined }
 end;//IStyleEditor_SetNewContent_Params

 Op_StyleEditor_SetNewContent = class
  {* Класс для вызова операции StyleEditor.SetNewContent }
 public
 // public methods
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

 Op_StyleEditor_ReloadStyleTable = class
  {* Класс для вызова операции StyleEditor.ReloadStyleTable }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции StyleEditor.ReloadStyleTable у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции StyleEditor.ReloadStyleTable у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции StyleEditor.ReloadStyleTable у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции StyleEditor.ReloadStyleTable у контейнера }
 end;//Op_StyleEditor_ReloadStyleTable
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TStyleEditor_ReloadStylesTree_Params = class(Tl3CProtoObject, IStyleEditor_ReloadStylesTree_Params)
  {* Реализация IStyleEditor_ReloadStylesTree_Params }
 private
 // private fields
   f_StyleName : Il3CString;
 protected
 // realized methods
   function Get_StyleName: Il3CString;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aStyleName: Il3CString); reintroduce;
     {* Конструктор TStyleEditor_ReloadStylesTree_Params }
   class function Make(const aStyleName: Il3CString): IStyleEditor_ReloadStylesTree_Params; reintroduce;
     {* Фабрика TStyleEditor_ReloadStylesTree_Params }
 end;//TStyleEditor_ReloadStylesTree_Params

// start class TStyleEditor_ReloadStylesTree_Params

constructor TStyleEditor_ReloadStylesTree_Params.Create(const aStyleName: Il3CString);
 {-}
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
end;

function TStyleEditor_ReloadStylesTree_Params.Get_StyleName: Il3CString;
 {-}
begin
 Result := f_StyleName;
end;//TStyleEditor_ReloadStylesTree_Params.Get_StyleName

procedure TStyleEditor_ReloadStylesTree_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_StyleName := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TStyleEditor_ReloadStylesTree_Params.ClearFields
// start class Op_StyleEditor_ReloadStylesTree

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmEntity;
  const aStyleName: Il3CString): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aStyleName);
end;//Op_StyleEditor_ReloadStylesTree.Call

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmContainer;
  const aStyleName: Il3CString): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aStyleName);
end;//Op_StyleEditor_ReloadStylesTree.Call

type
 TStyleEditor_RestoreStyleTable_Params = class(Tl3CProtoObject, IStyleEditor_RestoreStyleTable_Params)
  {* Реализация IStyleEditor_RestoreStyleTable_Params }
 private
 // private fields
   f_RestoreDefault : Boolean;
 protected
 // realized methods
   function Get_RestoreDefault: Boolean;
 public
 // public methods
   constructor Create(aRestoreDefault: Boolean); reintroduce;
     {* Конструктор TStyleEditor_RestoreStyleTable_Params }
   class function Make(aRestoreDefault: Boolean): IStyleEditor_RestoreStyleTable_Params; reintroduce;
     {* Фабрика TStyleEditor_RestoreStyleTable_Params }
 end;//TStyleEditor_RestoreStyleTable_Params

// start class TStyleEditor_RestoreStyleTable_Params

constructor TStyleEditor_RestoreStyleTable_Params.Create(aRestoreDefault: Boolean);
 {-}
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
end;

function TStyleEditor_RestoreStyleTable_Params.Get_RestoreDefault: Boolean;
 {-}
begin
 Result := f_RestoreDefault;
end;//TStyleEditor_RestoreStyleTable_Params.Get_RestoreDefault
// start class Op_StyleEditor_RestoreStyleTable

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmEntity;
  aRestoreDefault: Boolean): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aRestoreDefault);
end;//Op_StyleEditor_RestoreStyleTable.Call

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmContainer;
  aRestoreDefault: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aRestoreDefault);
end;//Op_StyleEditor_RestoreStyleTable.Call

type
 TStyleEditor_SaveStyleTable_Params = class(Tl3CProtoObject, IStyleEditor_SaveStyleTable_Params)
  {* Реализация IStyleEditor_SaveStyleTable_Params }
 private
 // private fields
   f_SaveAsDefault : Boolean;
 protected
 // realized methods
   function Get_SaveAsDefault: Boolean;
 public
 // public methods
   constructor Create(aSaveAsDefault: Boolean); reintroduce;
     {* Конструктор TStyleEditor_SaveStyleTable_Params }
   class function Make(aSaveAsDefault: Boolean): IStyleEditor_SaveStyleTable_Params; reintroduce;
     {* Фабрика TStyleEditor_SaveStyleTable_Params }
 end;//TStyleEditor_SaveStyleTable_Params

// start class TStyleEditor_SaveStyleTable_Params

constructor TStyleEditor_SaveStyleTable_Params.Create(aSaveAsDefault: Boolean);
 {-}
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
end;

function TStyleEditor_SaveStyleTable_Params.Get_SaveAsDefault: Boolean;
 {-}
begin
 Result := f_SaveAsDefault;
end;//TStyleEditor_SaveStyleTable_Params.Get_SaveAsDefault
// start class Op_StyleEditor_SaveStyleTable

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmEntity;
  aSaveAsDefault: Boolean): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSaveAsDefault);
end;//Op_StyleEditor_SaveStyleTable.Call

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmContainer;
  aSaveAsDefault: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSaveAsDefault);
end;//Op_StyleEditor_SaveStyleTable.Call

type
 TStyleEditor_SetNewContent_Params = class(Tl3CProtoObject, IStyleEditor_SetNewContent_Params)
  {* Реализация IStyleEditor_SetNewContent_Params }
 private
 // private fields
   f_StyleID : Integer;
 protected
 // realized methods
   function Get_StyleID: Integer;
 public
 // public methods
   constructor Create(aStyleID: Integer); reintroduce;
     {* Конструктор TStyleEditor_SetNewContent_Params }
   class function Make(aStyleID: Integer): IStyleEditor_SetNewContent_Params; reintroduce;
     {* Фабрика TStyleEditor_SetNewContent_Params }
 end;//TStyleEditor_SetNewContent_Params

// start class TStyleEditor_SetNewContent_Params

constructor TStyleEditor_SetNewContent_Params.Create(aStyleID: Integer);
 {-}
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
end;

function TStyleEditor_SetNewContent_Params.Get_StyleID: Integer;
 {-}
begin
 Result := f_StyleID;
end;//TStyleEditor_SetNewContent_Params.Get_StyleID
// start class Op_StyleEditor_SetNewContent

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmEntity;
  aStyleID: Integer): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aStyleID);
end;//Op_StyleEditor_SetNewContent.Call

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmContainer;
  aStyleID: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aStyleID);
end;//Op_StyleEditor_SetNewContent.Call
// start class Op_StyleEditor_ReloadStyleTable

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_StyleEditor_ReloadStyleTable.Call

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_StyleEditor_ReloadStyleTable.Call
{$IfEnd} //not Admin AND not Monitorings


end.