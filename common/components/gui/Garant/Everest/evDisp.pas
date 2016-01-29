unit evDisp;

{ Библиотека "Эверест"  }
{ Автор: Люлин А.В.     }
{ Модуль: evDisp - }
{ Начат: 08.10.98 15:02 }
{ $Id: evDisp.pas,v 1.55 2014/02/13 16:13:11 lulin Exp $ }

// $Log: evDisp.pas,v $
// Revision 1.55  2014/02/13 16:13:11  lulin
// - рефакторим безликие списки.
//
// Revision 1.54  2014/02/13 13:53:26  lulin
// - рефакторим безликие списки.
//
// Revision 1.53  2013/04/24 09:35:36  lulin
// - портируем.
//
// Revision 1.52  2012/11/01 09:41:35  lulin
// - забыл точку с запятой.
//
// Revision 1.51  2012/11/01 07:42:57  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.50  2011/06/10 09:54:35  lulin
// {RequestLink:269062848}.
//
// Revision 1.49  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.48  2011/05/19 10:35:57  lulin
// {RequestLink:266409354}.
//
// Revision 1.47  2010/02/27 07:24:33  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.46  2008/03/21 15:41:37  lulin
// - <K>: 87591144.
//
// Revision 1.45  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.44  2008/03/20 09:48:08  lulin
// - cleanup.
//
// Revision 1.43  2008/02/21 18:37:17  lulin
// - вычищен ненужный параметр.
//
// Revision 1.42  2008/02/21 18:13:20  lulin
// - избавляемся от ненужных типов.
//
// Revision 1.41  2008/02/19 11:38:35  lulin
// - восстановил компилируемость Архивариуса.
//
// Revision 1.40  2008/02/13 16:03:02  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.39  2008/02/07 14:44:22  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.38  2008/02/06 09:55:21  lulin
// - глобальные объекты сделаны индексированным свойством.
//
// Revision 1.37  2008/02/05 09:57:37  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.36  2008/02/01 15:14:29  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.35  2008/01/31 20:38:02  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.34  2007/12/04 12:47:00  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.32.4.7  2007/11/28 14:01:37  dinishev
// _CleanUp
//
// Revision 1.32.4.6  2007/09/11 09:15:30  lulin
// - bug fix: не запускался Эверест.
//
// Revision 1.32.4.5  2007/08/21 11:39:44  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.32.4.4  2007/04/20 11:07:19  lulin
// - убираем ненужную функциональность.
//
// Revision 1.32.4.3  2007/01/05 14:37:18  lulin
// - cleanup.
//
// Revision 1.32.4.2  2005/07/15 10:14:02  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.32.4.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.31.4.2  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.31.4.1  2005/04/28 09:18:28  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.31.10.1  2005/04/26 14:30:38  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.32  2005/04/28 15:03:37  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.31.10.1  2005/04/26 14:30:38  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.31  2005/01/14 11:02:18  lulin
// - методы Get*ParentForm переехали в библиотеку AFW.
//
// Revision 1.30  2004/09/28 17:21:56  lulin
// - в первом приближении сделал кеш документов. Пока без вымещения покументов на диск.
//
// Revision 1.29  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.28  2004/06/02 13:46:15  law
// - удален конструктор Tl3VList.MakeObject - пользуйтесь _Tl3ObjectList.Make.
//
// Revision 1.27  2004/06/02 08:30:24  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.26  2003/03/18 17:15:32  law
// - bug fix: падало при окончании приложения из которого забирали в буфер.
//
// Revision 1.25  2003/02/14 13:40:15  law
// - bug fix: Отключить ClipboardSpy для коллег из Гарант 6 (ee.dll) (№117).
//
// Revision 1.24  2002/01/10 15:23:59  law
// - bug fix: не компилировалось с директивой l3ConsoleApp.
//
// Revision 1.23  2001/10/11 12:42:10  law
// - bug fix: Action не привязывались к ActionList.
//
// Revision 1.22  2001/10/05 11:38:52  law
// - bug fix: запрещенные по умолчанию кнопки для работы с буфером обмена.
//
// Revision 1.21  2001/10/04 16:04:49  law
// - cleanup: убраны ссылки на TCustomToolbarButton97.
//
// Revision 1.20  2001/10/04 16:01:49  law
// - new behavior: в _TevCustomButton теперь используются TevCustomAction.
//
// Revision 1.19  2001/10/04 09:53:36  law
// - syntax fix: добавлена запятая.
//
// Revision 1.18  2001/10/04 09:52:03  law
// - new behavior: сделана возможность определения парамеров операций по умолчанию.
//
// Revision 1.17  2001/10/04 08:05:52  law
// - new behavior: сделана возмозность определения парамеров операций по умолчанию.
//
// Revision 1.16  2001/10/03 14:53:20  law
// - new unit: evAction.
//
// Revision 1.15  2001/10/01 14:06:44  law
// - new behavior: вставлена обработка изменения содержимого буфера обмена.
//
// Revision 1.14  2001/09/28 14:30:47  law
// - new version: заточка по Delphi 6.0
//
// Revision 1.13  2001/09/21 09:58:54  law
// - cleanup.
//
// Revision 1.12  2001/06/08 12:09:04  law
// - new behavior: сделана "расширенная" обработка операций.
//
// Revision 1.11  2001/03/15 17:21:44  law
// - немного поправлена обработка сообщений для меню.
//
// Revision 1.10  2001/01/31 10:37:29  law
// - оптимизировано использование QueryInterface.
//
// Revision 1.9  2000/12/15 15:10:34  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

{$IfNDef evNeedDisp}
 !!! модуль включен ошибочно
{$EndIf  evNeedDisp}

interface

uses
  Classes,
  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  Forms,
  {$EndIf l3ConsoleApp}
  l3Types,
  l3Msg,
  l3Base,
  l3ObjectRefList,
  l3ObjectWithHandleRefList,
  l3LongintList,
  l3ProtoObject,

  evStandardActions
  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  ,
  evAction
  {$EndIf l3ConsoleApp}
  ,
  l3ProtoObjectWithHandle
  ;

type
  TevOperationDescriptor = class(Tl3ProtoObjectWithHandle)
    private
    {internal fields}
      f_Code    : TevOperation;
      f_Enabled : Bool;
      f_ControlList : Tl3LongintList;
    protected
    {property methods}
      function pm_GetHandle: Tl3Handle; override;
      procedure pm_SetHandle(aValue: Tl3Handle); override;
      procedure pm_SetEnabled(Value: Bool);
        {-}
    protected
    {internal methods}
      procedure ChangeControlEnabled(Control: TObject);
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    {public methods}
      constructor Create(anOpCode : TevOperation);
        reintroduce;
        {-}
(*      procedure Assign(P: TPersistent);
        override;
        {-}*)
      procedure SetIntegerData(Value: Long);
        {-}
      procedure AddControl(Control: TObject);
        {-}
      procedure RemoveControl(Control: TObject);
        {-}
      function  CompareWith(anObject: Tl3ProtoObjectWithHandle): Long;
        override;
        {-}
    public
    {public properties}
      property Enabled: Bool
        read f_Enabled
        write pm_SetEnabled;
        {-}
      property Code: TevOperation
        read f_Code;
        {-}
  end;{TevOperationDescriptor}
  PevOperationDescriptor = ^TevOperationDescriptor;
  RevOperationDescriptor = class of TevOperationDescriptor;

  TevOperationDispatcher = class(Tl3ProtoObject)
    private
    {internal fields}
      f_OperationList : Tl3ObjectWithHandleRefList;
      f_ActiveControl : TObject;
    protected
    {property methods}
      function  pm_GetOperationEnabled(Op: TevOperation): Bool;
      procedure pm_SetOperationEnabled(Op: TevOperation; Value: Bool);
        {-}
      function  pm_GetEnabledOperations: TevOperationSet;
      procedure pm_SetEnabledOperations(Value: TevOperationSet);
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    {public methods}
      function  AddOperationDescriptor(anOpCode  : TevOperation;
                                       DescClass : RevOperationDescriptor = nil): TevOperationDescriptor;
        {-}
      function  ProcessOperation(Component: TObject; Op: TevOperation; Down: Bool): Bool;
        {-}
      function  AddControl(Op: TevOperation; Control: TObject): TevOperationDescriptor;
        {-}
      procedure RemoveControl(Op: TevOperation; Control: TObject);
        {-}
      procedure IncludeOperations(Ops: TevOperationSet);
        {-}
      procedure ExcludeOperations(Ops: TevOperationSet);
        {-}
      procedure FocusChanged(Control: TObject; Focused: Bool);
        {-}
      procedure SetOpIntegerData(Op: TevOperation; Value: Long);
        {-}
      {$IfDef l3ConsoleApp}
      {$Else  l3ConsoleApp}
      function  GetAction(anOpCode: TevOperation): TevCustomAction;
        {-}
      {$EndIf l3ConsoleApp}
      {$IfDef evNeedClipboardSpy}
      procedure ClipboardViewerChange(Sender: TObject);
        {-}
      {$EndIf evNeedClipboardSpy}
    public
    {public properties}
      property OperationEnabled[Op: TevOperation]: Bool
        read pm_GetOperationEnabled
        write pm_SetOperationEnabled;
        {-}
      property EnabledOperations: TevOperationSet
        read pm_GetEnabledOperations
        write pm_SetEnabledOperations;
        {-}
      property ActiveControl: TObject
        read f_ActiveControl;
        {-}
  end;{TevOperationDispatcher}

function  evOperationDispatcher: TevOperationDispatcher;

implementation

uses
  Messages,
  
  SysUtils,

  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  ActnList,
  Controls,
  Menus,
  {$EndIf l3ConsoleApp}
  l3InternalInterfaces,
  l3InterfacesMisc,

  afwFacade
  
  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  ,
  evMenu
  {$EndIf l3ConsoleApp}
  {$IfDef evNeedClipboardSpy}
  ,
  vtClipSpy
  {$EndIf evNeedClipboardSpy}
  ,
  evOperationDispatcherEx
  ;

{ start class TevOperationDispatcher }

function TevOperationDispatcher.pm_GetOperationEnabled(Op: TevOperation): Bool;
  {-}
var
 i : Long;
begin
 if (Op = ev_ccNone) OR (f_OperationList = nil) then
  Result := false
 else begin
  if f_OperationList.FindData(Long(Op), i) then
   Result := TevOperationDescriptor(f_OperationList.Items[i]).Enabled
  else
   Result := false;
 end;
end;

procedure TevOperationDispatcher.pm_SetOperationEnabled(Op: TevOperation; Value: Bool);
  {-}
var
 i  : Long;
begin
 if (Op = ev_ccNone) then
  Exit
 else 
 if (f_OperationList = nil) then 
 begin
  if Value then
   AddOperationDescriptor(Op).Enabled := true;
  Exit;
 end;//f_OperationList = nil
 if f_OperationList.FindData(Long(Op), i) then
  TevOperationDescriptor(f_OperationList.Items[i]).Enabled := Value
 else 
 if Value then
  AddOperationDescriptor(Op).Enabled := true;
end;

function TevOperationDispatcher.pm_GetEnabledOperations: TevOperationSet;
  {-}
var
 EO : TevOperationSet absolute Result;

 function GEO(pOD: PevOperationDescriptor; Index: Long): Bool; far;
 begin
  Result := true;
  with pOD^ do if Enabled then Include(EO, Code);
 end;

begin
 Result := [];
 if (f_OperationList <> nil) then 
  f_OperationList.IterateAllF(l3L2IA(@GEO));
end;

procedure TevOperationDispatcher.pm_SetEnabledOperations(Value: TevOperationSet);
  {-}
var
 Op : TevOperation;
begin
 for Op := Low(TevOperation) to High(TevOperation) do
  OperationEnabled[Op] := (Op in Value);
end;

procedure TevOperationDispatcher.Cleanup;
  {override;}
  {-}
begin
 {$IfDef evNeedClipboardSpy}
 if (ClipboardSpy <> nil) then 
  ClipboardSpy.OnChange := nil;  
 {$EndIf evNeedClipboardSpy}
 l3Free(f_OperationList);
 inherited;
end;

function TevOperationDispatcher.ProcessOperation(Component: TObject; Op: TevOperation; Down: Bool): Bool;
  {-}
var
 {$IfDef l3ConsoleApp}
 {$Else  l3ConsoleApp}
 l_Form            : TCustomForm;
 l_ActiveControl   : TForm;
 {$EndIf l3ConsoleApp}
 l_ActionProcessor : Il3ActionProcessor;
begin
 Result := False;
 if OperationEnabled[Op] then 
 begin
  if Supports(ActiveControl, Il3ActionProcessor, l_ActionProcessor) then
   try
    Result := l_ActionProcessor.Process(Component, nil, Long(Op), Down);
    if Result then Exit;
   finally
    l_ActionProcessor := nil;
   end;
  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  if (Component is TPersistent) then
   l_Form := afw.GetParentForm(TPersistent(Component))
  else
   Exit;
  if (l_Form <> nil) then 
  begin
   if Supports(l_Form, Il3ActionProcessor, l_ActionProcessor) then
    try
     Result := l_ActionProcessor.Process(Component, nil, Long(Op), Down);
     if Result then Exit;
    finally
     l_ActionProcessor := nil;
    end;
   if Supports(ActiveControl, Il3ActionProcessor, l_ActionProcessor) then
    try
     Result := l_ActionProcessor.Process(l_Form.ActiveControl, nil, Long(Op), Down);
     if Result then Exit;
    finally
     l_ActionProcessor := nil;
    end;
   if (l_Form is TForm) then
    l_ActiveControl := TForm(l_Form).ActiveMDIChild
   else
    l_ActiveControl := nil;
   // l_Form <> nil
  end 
  else
   l_ActiveControl := nil;
  if (l_ActiveControl = nil) then
   l_ActiveControl := Application.MainForm;
  if (l_ActiveControl <> nil) then 
  begin
   if Supports(l_ActiveControl, Il3ActionProcessor, l_ActionProcessor) then
    try
     Result := l_ActionProcessor.Process(Component, nil, Long(Op), Down);
     if Result then Exit;
    finally
     l_ActionProcessor := nil;
    end;
   if Supports(l_ActiveControl.ActiveControl, Il3ActionProcessor, l_ActionProcessor) then
    try
     Result := l_ActionProcessor.Process(Component, nil, Long(Op), Down);
     if Result then Exit;
    finally
     l_ActionProcessor := nil;
    end;
   if (l_Form = nil) then 
   begin
    if Supports(l_ActiveControl.ActiveMDIChild, Il3ActionProcessor, l_ActionProcessor) then
     try
      Result := l_ActionProcessor.Process(Component, nil, Long(Op), Down);
      if Result then Exit;
     finally
      l_ActionProcessor := nil;
     end;
   end;//l_Form = nil
  end;{l_ActiveControl <> nil}
  {$EndIf l3ConsoleApp}
 end;{Op <> ev_ccNone}
end;

function TevOperationDispatcher.AddOperationDescriptor(anOpCode  : TevOperation;
                                                       DescClass : RevOperationDescriptor = nil): TevOperationDescriptor;
  {-}
var
 l_Index : Long;
begin
 Result := nil;
 if (anOpCode <> ev_ccNone) then 
 begin
  if (DescClass = nil) then DescClass := TevOperationDescriptor;
  if (f_OperationList = nil) then
   f_OperationList := Tl3ObjectWithHandleRefList.MakeSorted(l3_dupChange)
  else 
  begin
   with f_OperationList do 
   begin
    if FindData(Long(anOpCode), l_Index) then 
    begin
     Result := TevOperationDescriptor(Items[l_Index]);
     if Result.InheritsFrom(DescClass) then
      Exit;
    end;
   end;//with f_OperationList
  end;
  Result := DescClass.Create(anOpCode);
  try
   f_OperationList.Add(Result);
   {$IfDef evNeedClipboardSpy}
   Result.Enabled := (anOpCode in [ev_ccPaste, ev_ccSpecialPaste]) AND not ClipboardIsEmpty;
   {$EndIf evNeedClipboardSpy}
  finally
   Result := Result.Free;
  end;//try..finally
 end;//anOpCode <> ev_ccNone
end;

function TevOperationDispatcher.AddControl(Op      : TevOperation;
                                           Control : TObject): TevOperationDescriptor;
  {-}
begin
 Result := AddOperationDescriptor(Op);
 Result.AddControl(Control);
end;

procedure TevOperationDispatcher.RemoveControl(Op: TevOperation; Control: TObject);
  {-}
var
 i : Long;
begin
 if (Op <> ev_ccNone) AND (f_OperationList <> nil) AND
    f_OperationList.FindData(Long(Op), i) then
  TevOperationDescriptor(f_OperationList.Items[i]).RemoveControl(Control);
end;

procedure TevOperationDispatcher.IncludeOperations(Ops: TevOperationSet);
  {-}

 function ExO(pOD: PevOperationDescriptor; Index: Long): Bool; far;
 begin
  Result := true;
  with pOD^ do 
   if (Code in Ops) then 
   begin
    Enabled := true;
    Exclude(Ops, Code);
   end;
 end;

var
 Op : TevOperation; 
begin
 if (f_OperationList <> nil) then 
  f_OperationList.IterateAllF(l3L2IA(@ExO));
 if (Ops <> []) then begin
  for Op := Low(TevOperation) to High(TevOperation) do 
  begin
   if (Op in Ops) then
    AddOperationDescriptor(Op).Enabled := True;
  end;//for Op
 end;//Ops <> []
end;

procedure TevOperationDispatcher.ExcludeOperations(Ops: TevOperationSet);
  {-}

 function ExO(pOD: PevOperationDescriptor; Index: Long): Bool; far;
 begin
  Result := True;
  with pOD^ do if (Code in Ops) then Enabled := false;
 end;

begin
 if (f_OperationList <> nil) then
  f_OperationList.IterateAllF(l3L2IA(@ExO));
end;

procedure TevOperationDispatcher.FocusChanged(Control: TObject; Focused: Bool);
  {-}
begin
 if Focused then
  f_ActiveControl := Control
 else 
  if (f_ActiveControl = Control) then f_ActiveControl := nil;
end;

procedure TevOperationDispatcher.SetOpIntegerData(Op: TevOperation; Value: Long);
  {-}
var
 i : Long;
begin
 if (f_OperationList <> nil) AND f_OperationList.FindData(Long(Op), i) then
  TevOperationDescriptor(f_OperationList.Items[i]).SetIntegerData(Value);
end;

{$IfDef l3ConsoleApp}
{$Else  l3ConsoleApp}

var
 g_ActionList : TActionList;

function TevOperationDispatcher.GetAction(anOpCode: TevOperation): TevCustomAction;
  {-}

 function _GetAction(C: PObject; Index: Long): Bool; far;
 begin
  if (C^ Is TevCustomAction) then begin
   GetAction := TevCustomAction(C^);
   Result := false;
  end else
   Result := true;
 end;

begin
 Result := nil;
 if (anOpCode <> ev_ccNone) then
  with AddOperationDescriptor(anOpCode) do begin
   if (f_ControlList <> nil) then
    f_ControlList.IterateAllF(l3L2IA(@_GetAction));
   if (Result = nil) then begin
    if (g_ActionList = nil) then g_ActionList := TActionList.Create(Application);
    Result := TevCustomAction.Create(Application);
    Result.ActionList := g_ActionList;
    Result.Operation := anOpCode;
   end;//Result = nil
  end;//with AddOperationDescriptor(anOpCode)
end;
{$EndIf l3ConsoleApp}

{$IfDef evNeedClipboardSpy}
procedure TevOperationDispatcher.ClipboardViewerChange(Sender: TObject);
  {-}
begin
 OperationEnabled[ev_ccPaste] := not ClipboardIsEmpty;
 OperationEnabled[ev_ccSpecialPaste] := not ClipboardIsEmpty;
end;
{$EndIf evNeedClipboardSpy}

{ dispatcher routines }

function evOperationDispatcher: TevOperationDispatcher;
begin
 Result := TevOperationDispatcherEx.Instance;
end;

{ start class TevOperationDescriptor }

constructor TevOperationDescriptor.Create(anOpCode : TevOperation);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Code := anOpCode;
end;

procedure TevOperationDescriptor.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_ControlList);
 inherited;
end;

(*procedure TevOperationDescriptor.Assign(P: TPersistent);
  //override;
  {-}
begin
 if (P Is TevOperationDescriptor) then begin
  f_Code := TevOperationDescriptor(P).Code;
  f_Enabled := TevOperationDescriptor(P).Enabled;
  if TevOperationDescriptor(P).f_ControlList.Empty then
   l3Free(f_ControlList)
  else begin
   if (f_ControlList = nil) then f_ControlList := Tl3LongintList.MakeSorted;
   f_ControlList.Assign(TevOperationDescriptor(P).f_ControlList);
  end;
 end else
  inherited;
end;*)

procedure TevOperationDescriptor.SetIntegerData(Value: Long);
  {-}

 function _SetControlData(C: PObject; Index: Long): Bool; far;
 var
  l_ActionControl: Il3ActionControl;
 begin
  Result := true;
  if Supports(C^, Il3ActionControl, l_ActionControl) then
   try
    l_ActionControl.ActionData[Long(Code)] := Value;
    Exit;
   finally
    l_ActionControl := nil;
   end;{try..finally}
  {$IfNDef l3ConsoleApp}
  {$IfDef Delphi6}
  if (C^ Is TMenuItem) then begin
   with TMenuItem(C^) do
    if AutoCheck OR RadioItem then
     Checked := (Value <> 0);
  end else if (C^ Is TCustomAction) then begin
   with TCustomAction(C^) do
    if AutoCheck then
     Checked := (Value <> 0);
  {$Else  Delphi6}
  if (C^ Is TMenuItem) then begin
   if (C^ Is TevMenuItem) AND TevMenuItem(C^).AutoCheck then
    TMenuItem(C^).Checked := (Value <> 0)
   else if TMenuItem(C^).RadioItem then
    TMenuItem(C^).Checked := (Value <> 0);
  end else if (C^ Is TevCustomAction) then begin
   with TevCustomAction(C^) do
    if AutoCheck then
     Checked := (Value <> 0);
  {$EndIf Delphi6}
  end;
  {$EndIf  l3ConsoleApp}
 end;

var
 OE : Bool;
begin
 OE := f_Enabled;
 try
  f_Enabled := false;
  if (f_ControlList <> nil) then
   f_ControlList.IterateAllF(l3L2IA(@_SetControlData));
 finally
  f_Enabled := OE;
 end;{try..finally}
end;

function TevOperationDescriptor.pm_GetHandle: Tl3Handle; //override;
begin
 Result := Tl3Handle(f_Code);
end;

procedure TevOperationDescriptor.pm_SetHandle(aValue: Tl3Handle); //override;
begin
 f_Code := TevOperation(aValue);
end;

procedure TevOperationDescriptor.pm_SetEnabled(Value: Bool);
  {-}

 function _ChangeControlEnabled(C: PObject; Index: Long): Bool; far;
 begin
  ChangeControlEnabled(C^);
  Result := true;
 end;

begin
 if (Self <> nil) then begin
  if (f_Enabled <> Value) then begin
   f_Enabled := Value;
   if (f_ControlList <> nil) then
    f_ControlList.IterateAllF(l3L2IA(@_ChangeControlEnabled));
  end;{f_Enabled <> Value}
 end;//Self <> nil 
end;

procedure TevOperationDescriptor.ChangeControlEnabled(Control: TObject);
  {-}
var
 l_Control : Il3Control;
begin
 {$IfDef l3ConsoleApp}
 {$Else  l3ConsoleApp}
 if (Control Is TControl) then
  TControl(Control).Enabled := Enabled
 else if (Control Is TMenuItem) then
  TMenuItem(Control).Enabled := Enabled
 else if (Control Is TCustomAction) then
  TCustomAction(Control).Enabled := Enabled
 else
 {$EndIf l3ConsoleApp}
 begin
  if Supports(Control, Il3Control, l_Control) then
   try
    l_Control.Enabled := Enabled;
   finally
    l_Control := nil;
   end;{try..finally}
 end;
end;

procedure TevOperationDescriptor.AddControl(Control: TObject);
  {-}
begin
 if (Self <> nil) then begin
  if (f_ControlList = nil) then f_ControlList := Tl3LongintList.MakeSorted;
  if (f_ControlList.IndexOf(Integer(Control)) < 0) then
   f_ControlList.Add(Integer(Control));
  ChangeControlEnabled(Control);
 end;//Self <> nil 
end;

procedure TevOperationDescriptor.RemoveControl(Control: TObject);
  {-}
begin
 if (f_ControlList <> nil) then begin
  f_ControlList.Remove(Integer(Control));
  if (f_ControlList.Count = 0) then l3Free(f_ControlList);
 end;{f_ControlList <> nil}
end;

function  TevOperationDescriptor.CompareWith(anObject: Tl3ProtoObjectWithHandle): Long;
  {override;}
  {-}
begin
  if (anObject Is TevOperationDescriptor) then
   Result := Ord(Code) - Ord(TevOperationDescriptor(anObject).Code)
  else
   raise Exception.Create('Invalid Compare Data');
end;

{$IfDef evNeedClipboardSpy}
initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evDisp.pas initialization enter'); {$EndIf}
 ClipboardSpy.OnChange := evOperationDispatcher.ClipboardViewerChange;
{$EndIf evNeedClipboardSpy}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evDisp.pas initialization leave'); {$EndIf}
end.


