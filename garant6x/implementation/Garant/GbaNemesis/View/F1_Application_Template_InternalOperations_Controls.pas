unit F1_Application_Template_InternalOperations_Controls;
 {* Внутренние операции. Кандидаты на превращение в фасеты }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Application_Template_InternalOperations_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "InternalOperations" MUID: (4A8EC95E015F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
 ISystem_InitShutdown_Params = interface
  {* Параметры для операции System.InitShutdown }
  function Get_Shotdown: Boolean;
  function Get_CloseInterval: Integer;
  property Shotdown: Boolean
   read Get_Shotdown;
  property CloseInterval: Integer
   read Get_CloseInterval;
 end;//ISystem_InitShutdown_Params

 Op_System_InitShutdown = {final} class
  {* Класс для вызова операции System.InitShutdown }
  public
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
 TSystem_InitShutdown_Params = {final} class(Tl3CProtoObject, ISystem_InitShutdown_Params)
  {* Реализация ISystem_InitShutdown_Params }
  private
   f_Shotdown: Boolean;
   f_CloseInterval: Integer;
  protected
   function Get_Shotdown: Boolean;
   function Get_CloseInterval: Integer;
  public
   constructor Create(aShotdown: Boolean;
    aCloseInterval: Integer); reintroduce;
   class function Make(aShotdown: Boolean;
    aCloseInterval: Integer): ISystem_InitShutdown_Params; reintroduce;
 end;//TSystem_InitShutdown_Params

constructor TSystem_InitShutdown_Params.Create(aShotdown: Boolean;
 aCloseInterval: Integer);
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
end;//TSystem_InitShutdown_Params.Make

function TSystem_InitShutdown_Params.Get_Shotdown: Boolean;
begin
 Result := f_Shotdown;
end;//TSystem_InitShutdown_Params.Get_Shotdown

function TSystem_InitShutdown_Params.Get_CloseInterval: Integer;
begin
 Result := f_CloseInterval;
end;//TSystem_InitShutdown_Params.Get_CloseInterval

class function Op_System_InitShutdown.Call(const aTarget: IvcmEntity;
 aShotdown: Boolean;
 aCloseInterval: Integer): Boolean;
 {* Вызов операции System.InitShutdown у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_InitShutdown_Params.Make(aShotdown, aCloseInterval));
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
 {* Вызов операции System.InitShutdown у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_InitShutdown_Params.Make(aShotdown, aCloseInterval));
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
 {* Вызов операции System.InitShutdown у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aShotdown, aCloseInterval);
end;//Op_System_InitShutdown.Call

class function Op_System_InitShutdown.Call(const aTarget: IvcmContainer;
 aShotdown: Boolean;
 aCloseInterval: Integer): Boolean;
 {* Вызов операции System.InitShutdown у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aShotdown, aCloseInterval);
end;//Op_System_InitShutdown.Call

end.
