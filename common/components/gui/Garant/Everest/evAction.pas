unit evAction;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evAction -      }
{ Начат: 03.10.2001 10:53 }
{ $Id: evAction.pas,v 1.11 2007/12/04 12:46:58 lulin Exp $ }

// $Log: evAction.pas,v $
// Revision 1.11  2007/12/04 12:46:58  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.10.56.2  2007/04/20 11:07:19  lulin
// - убираем ненужную функциональность.
//
// Revision 1.10.56.1  2005/07/15 10:14:02  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.10  2002/01/05 11:00:43  law
// - some cosmetics.
//
// Revision 1.9  2001/12/28 12:31:07  law
// - new prop: в описание операции добавлено свойство ShortCut.
//
// Revision 1.8  2001/10/10 10:56:39  law
// - new behavior: заточка под Action от Delphi 6.0.
//
// Revision 1.7  2001/10/04 12:42:36  law
// - new behavior: сделан котнроль за сохранением свойств Category и AutoCheck.
//
// Revision 1.6  2001/10/04 09:56:21  law
// - bug fix: совместимостьс Delphi 5.0.
//
// Revision 1.5  2001/10/04 09:55:27  law
// - bug fix: совместимостьс Delphi 5.0.
//
// Revision 1.4  2001/10/04 09:52:03  law
// - new behavior: сделана возможность определения парамеров операций по умолчанию.
//
// Revision 1.3  2001/10/04 08:05:52  law
// - new behavior: сделана возмозность определения парамеров операций по умолчанию.
//
// Revision 1.2  2001/10/03 16:52:43  law
// - new behavior: автоматическая установка имени TevCustomAction при дизайне.
//
// Revision 1.1  2001/10/03 14:51:08  law
// - new unit: evAction.
//

{$Include evDefine.inc }

interface

{$IfDef evNeedDisp}
uses
  Classes,
  ActnList,

  l3Types,
  
  evStandardActions
  ;

const
  evEverestActionCategory =
  {$IfDef evMyEditor}
  'My'
  {$Else  evMyEditor}
  'Everest'
  {$EndIf evMyEditor};
    
type
  TevCustomAction = class(TCustomAction)
    private
    {internal fields}
      f_Operation : TevOperation;
      {$IfNDef Delphi6}
      f_AutoCheck : Bool;
      {$EndIf  Delphi6}
    protected
    {property methods}
      procedure pm_SetOperation(Value: TevOperation);
        {-}
    protected
    {internal methods}
      function  CaptionStored: Boolean;
        {-}
      function  ShortCutStored: Boolean;
        {-}
      function  HintStored: Boolean;
        {-}
      function  EnabledStored: Bool;
        {-}
      function  IsCategoryStored: Boolean;
        {-}
      function  IsAutoCheckStored: Boolean;
        {-}
      {$IfDef Delphi6}
      function  IsGroupIndexStored: Boolean;
        {-}
      {$EndIf Delphi6}
      procedure DoExecute(Sender: TObject);
        {-}
      procedure OperationChanged;
        virtual;
        {-}
    public
    {public methods}
      constructor Create(AOwner: TComponent);
        override;
        {-}
      destructor Destroy;
        override;
        {-}
    protected
    // protected properties
      property Hint
        stored HintStored;
        {-}
      property Caption
        stored CaptionStored;
        {-}
      property Enabled
        stored EnabledStored;
        {-}  
    public
    //public properties
      property Operation: TevOperation
        read f_Operation
        write pm_SetOperation
        default ev_ccNone;
        {-}
      {$IfDef Delphi6}
      property AutoCheck
        stored IsAutoCheckStored;
        {-}
      property GroupIndex
        stored IsGroupIndexStored;
        {-}
      {$Else  Delphi6}
      property AutoCheck: Bool
        read f_AutoCheck
        write f_AutoCheck
        stored IsAutoCheckStored;
        {-}
      {$EndIf Delphi6}
      property ShortCut
        stored ShortCutStored;
        {-}
    published
    // published methods
      property Category
        stored IsCategoryStored;
        {-}
  end;//TevCustomAction

  TevAction = class(TevCustomAction)
    published
    // published methods
      property Operation;
      property AutoCheck;
      property Caption;
      property Checked;
      property Enabled;
      {$IfDef Delphi6}
      property GroupIndex;
      {$EndIf Delphi6}
      property HelpContext;
      {$IfDef Delphi6}
      property HelpKeyword;
      property HelpType;
      {$EndIf Delphi6}
      property Hint;
      property ImageIndex;
      property ShortCut;
      {$IfDef Delphi6}
      property SecondaryShortCuts;
      {$EndIf Delphi6}
      property Visible;
      //property OnExecute;
      property OnHint;
      property OnUpdate;
  end;//TevAction
{$EndIf  evNeedDisp}  

implementation

{$IfDef evNeedDisp}
uses
  SysUtils,
  TypInfo,

  l3InterfacesMisc,

  evActionInterfaces,
  evDisp
  ;

{ start class TevCustomAction }

constructor TevCustomAction.Create(AOwner: TComponent);
  //override;
  {-}
begin
 inherited;
 Category := evEverestActionCategory;
 OnExecute := DoExecute;
end;

destructor TevCustomAction.Destroy;
  {override;}
  {-}
begin
 evOperationDispatcher.RemoveControl(f_Operation, Self);
 inherited;
end;

procedure TevCustomAction.pm_SetOperation(Value: TevOperation);
  {-}
var
 l_Name : String;
 l_ExtActionDescriptor : IevExtActionDescriptor;
begin
 if (f_Operation <> Value) then begin
  evOperationDispatcher.RemoveControl(f_Operation, Self);
  f_Operation := Value;
  if Supports(evOperationDispatcher.AddControl(f_Operation, Self),
                       IevExtActionDescriptor, l_ExtActionDescriptor) then
   try
    if (l_ExtActionDescriptor.Hint <> '') then
     Hint := l_ExtActionDescriptor.Hint;
    if (l_ExtActionDescriptor.Caption <> '') then
     Caption := l_ExtActionDescriptor.Caption;
    AutoCheck := l_ExtActionDescriptor.AutoCheck;
    {$IfDef Delphi6}
    if (l_ExtActionDescriptor.GroupIndex <> -1) then
     GroupIndex := l_ExtActionDescriptor.GroupIndex;
    {$EndIf Delphi6}
    if (l_ExtActionDescriptor.ShortCut <> 0) then
     ShortCut := l_ExtActionDescriptor.ShortCut;
   finally
    l_ExtActionDescriptor := nil;
   end;//try..finally
  if ([csDesigning, csLoading] * ComponentState = [csDesigning]) then begin
   l_Name := GetEnumName(TypeInfo(TevOperation), Ord(f_Operation));
   System.Delete(l_Name, 1, 5);
   l_Name := 'ac' + l_Name;
   Name := l_Name;
  end;//(csDesigning in ComponentState)
  OperationChanged;
 end;
end;

procedure TevCustomAction.OperationChanged;
  //virtual;
  {-}
begin
end;

function TevCustomAction.IsCategoryStored: Boolean;
  {-}
begin
 Result := (ANSICompareText(Category, evEverestActionCategory) <> 0);
end;
  
function TevCustomAction.CaptionStored: Boolean;
  {-}
var
 l_ExtActionDescriptor : IevExtActionDescriptor;
begin
 if Supports(evOperationDispatcher.AddOperationDescriptor(f_Operation),
                      IevExtActionDescriptor, l_ExtActionDescriptor) then
  try
   Result := (Hint <> l_ExtActionDescriptor.Hint);
  finally
   l_ExtActionDescriptor := nil;
  end//try..finally
 else
  Result := true;
end;

function TevCustomAction.ShortCutStored: Boolean;
  {-}
var
 l_ExtActionDescriptor : IevExtActionDescriptor;
begin
 if Supports(evOperationDispatcher.AddOperationDescriptor(f_Operation),
                      IevExtActionDescriptor, l_ExtActionDescriptor) then
  try
   Result := (ShortCut <> l_ExtActionDescriptor.ShortCut);
  finally
   l_ExtActionDescriptor := nil;
  end//try..finally
 else
  Result := true;
end;

function TevCustomAction.HintStored: Boolean;
  {-}
var
 l_ExtActionDescriptor : IevExtActionDescriptor;
begin
 if Supports(evOperationDispatcher.AddOperationDescriptor(f_Operation),
                      IevExtActionDescriptor, l_ExtActionDescriptor) then
  try
   Result := (Caption <> l_ExtActionDescriptor.Caption);
  finally
   l_ExtActionDescriptor := nil;
  end//try..finally
 else
  Result := true;
end;

function TevCustomAction.IsAutoCheckStored: Boolean;
  {-}
var
 l_ExtActionDescriptor : IevExtActionDescriptor;
begin
 if Supports(evOperationDispatcher.AddOperationDescriptor(f_Operation),
                      IevExtActionDescriptor, l_ExtActionDescriptor) then
  try
   Result := (AutoCheck <> l_ExtActionDescriptor.AutoCheck);
  finally
   l_ExtActionDescriptor := nil;
  end//try..finally
 else
  Result := true;
end;

{$IfDef Delphi6}
function TevCustomAction.IsGroupIndexStored: Boolean;
  {-}
var
 l_ExtActionDescriptor : IevExtActionDescriptor;
begin
 if Supports(evOperationDispatcher.AddOperationDescriptor(f_Operation),
                      IevExtActionDescriptor, l_ExtActionDescriptor) then
  try
   Result := (GroupIndex <> l_ExtActionDescriptor.GroupIndex);
  finally
   l_ExtActionDescriptor := nil;
  end//try..finally
 else
  Result := true;
end;

{$EndIf Delphi6}

function TevCustomAction.EnabledStored: Bool;
  {-}
begin
 Result := (Operation = ev_ccNone);
end;

procedure TevCustomAction.DoExecute(Sender: TObject);
  {-}
begin
 {$IfDef  Delphi6}
 evOperationDispatcher.ProcessOperation(Self, f_Operation, Checked);
 {$Else   Delphi6}
 if AutoCheck then Checked := not Checked;
 evOperationDispatcher.ProcessOperation(Self, f_Operation, Checked);
 {$EndIf  Delphi6}
end;
{$EndIf evNeedDisp}

end.

