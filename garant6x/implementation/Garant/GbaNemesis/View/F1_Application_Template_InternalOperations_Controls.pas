unit F1_Application_Template_InternalOperations_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/F1_Application_Template_InternalOperations_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Базовые определения предметной области::F1 Application Template::View::InternalOperations
//
// Внутренние операции. Кандидаты на превращение в фасеты
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3CProtoObject,
  vcmExternalInterfaces {a}
  ;

(* System = operations
  {* Система }
   ['{780A81CE-0B59-4482-940E-E67B7F1CED5E}']
   query InitShutdown(aShotdown: Boolean;
    aCloseInterval: Integer);
     {* Начать процесс завершения работы }
 end;//System*)

(* Help = operations
   ['{24A611DF-722D-4B06-A67B-BEDF5A1B77C3}']
   operation HelpTopics;
 end;//Help*)

type
 ISystem_InitShutdown_Params = interface(IUnknown)
  {* Параметры для операции System.InitShutdown }
   ['{DB584516-0B73-41CF-9721-9C57CAF90FDE}']
   function Get_Shotdown: Boolean;
   function Get_CloseInterval: Integer;
   property Shotdown: Boolean
     read Get_Shotdown;
     {* undefined }
   property CloseInterval: Integer
     read Get_CloseInterval;
     {* undefined }
 end;//ISystem_InitShutdown_Params

 Op_System_InitShutdown = class
  {* Класс для вызова операции System.InitShutdown }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aShotdown: Boolean;
    aCloseInterval: Integer): Boolean; overload; 
     {* Вызов операции System.InitShutdown у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aShotdown: Boolean;
    aCloseInterval: Integer): Boolean; overload; 
     {* Вызов операции System.InitShutdown у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aShotdown: Boolean;
    aCloseInterval: Integer): Boolean; overload; 
     {* Вызов операции System.InitShutdown у формы }
   class function Call(const aTarget: IvcmContainer;
    aShotdown: Boolean;
    aCloseInterval: Integer): Boolean; overload; 
     {* Вызов операции System.InitShutdown у контейнера }
 end;//Op_System_InitShutdown

const
 en_System = 'System';
 en_capSystem = 'Система';
 op_InitShutdown = 'InitShutdown';
 op_capInitShutdown = 'Начать процесс завершения работы';
 en_Help = 'Help';
 en_capHelp = '';
 op_HelpTopics = 'HelpTopics';
 op_capHelpTopics = '';

implementation

uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TSystem_InitShutdown_Params = class(Tl3CProtoObject, ISystem_InitShutdown_Params)
  {* Реализация ISystem_InitShutdown_Params }
 private
 // private fields
   f_Shotdown : Boolean;
   f_CloseInterval : Integer;
 protected
 // realized methods
   function Get_Shotdown: Boolean;
   function Get_CloseInterval: Integer;
 public
 // public methods
   constructor Create(aShotdown: Boolean;
    aCloseInterval: Integer); reintroduce;
     {* Конструктор TSystem_InitShutdown_Params }
   class function Make(aShotdown: Boolean;
    aCloseInterval: Integer): ISystem_InitShutdown_Params; reintroduce;
     {* Фабрика TSystem_InitShutdown_Params }
 end;//TSystem_InitShutdown_Params

// start class TSystem_InitShutdown_Params

constructor TSystem_InitShutdown_Params.Create(aShotdown: Boolean;
  aCloseInterval: Integer);
 {-}
begin
 inherited Create;
 f_Shotdown := aShotdown;
 f_CloseInterval := aCloseInterval;
end;//TSystem_InitShutdown_Params.Create

class function TSystem_InitShutdown_Params.Make(aShotdown: Boolean;
  aCloseInterval: Integer): ISystem_InitShutdown_Params;
var
 l_Inst : TSystem_InitShutdown_Params;
begin
 l_Inst := Create(aShotdown, aCloseInterval);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TSystem_InitShutdown_Params.Get_Shotdown: Boolean;
 {-}
begin
 Result := f_Shotdown;
end;//TSystem_InitShutdown_Params.Get_Shotdown

function TSystem_InitShutdown_Params.Get_CloseInterval: Integer;
 {-}
begin
 Result := f_CloseInterval;
end;//TSystem_InitShutdown_Params.Get_CloseInterval
// start class Op_System_InitShutdown

class function Op_System_InitShutdown.Call(const aTarget: IvcmEntity;
  aShotdown: Boolean;
  aCloseInterval: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_InitShutdown_Params.Make(aShotdown,aCloseInterval));
  aTarget.Operation(TdmStdRes.opcode_System_InitShutdown, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_System_InitShutdown.Call

class function Op_System_InitShutdown.Call(const aTarget: IvcmAggregate;
  aShotdown: Boolean;
  aCloseInterval: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_InitShutdown_Params.Make(aShotdown,aCloseInterval));
  aTarget.Operation(TdmStdRes.opcode_System_InitShutdown, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_System_InitShutdown.Call

class function Op_System_InitShutdown.Call(const aTarget: IvcmEntityForm;
  aShotdown: Boolean;
  aCloseInterval: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aShotdown, aCloseInterval);
end;//Op_System_InitShutdown.Call

class function Op_System_InitShutdown.Call(const aTarget: IvcmContainer;
  aShotdown: Boolean;
  aCloseInterval: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aShotdown, aCloseInterval);
end;//Op_System_InitShutdown.Call

end.