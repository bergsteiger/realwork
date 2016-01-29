unit vcmModuleAction;
{* Базовая операция модуля библиотеки vcm для привязки к меню. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmModuleAction - }
{ Начат: 25.02.2003 19:54 }
{ $Id: vcmModuleAction.pas,v 1.23 2012/11/01 09:42:25 lulin Exp $ }

// $Log: vcmModuleAction.pas,v $
// Revision 1.23  2012/11/01 09:42:25  lulin
// - забыл точку с запятой.
//
// Revision 1.22  2012/11/01 07:44:12  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.21  2012/04/11 15:29:02  lulin
// - пытаемся разобраться с "галочками".
//
// Revision 1.20  2009/11/12 18:08:13  lulin
// - убираем ненужные возвращаемые значения.
//
// Revision 1.19  2009/09/28 18:50:38  lulin
// - убираем лишние ручки для вызова операций.
//
// Revision 1.18  2009/08/20 17:19:07  lulin
// {RequestLink:159360595}.
//
// Revision 1.17  2009/02/20 17:29:22  lulin
// - чистка комментариев.
//
// Revision 1.16  2009/02/20 15:19:08  lulin
// - <K>: 136941122.
//
// Revision 1.15  2007/01/20 17:35:47  lulin
// - разрешаем вызывать операции только по заранее известным идентификаторам.
//
// Revision 1.14  2007/01/20 15:31:10  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.13  2007/01/18 13:13:46  lulin
// - разводим в стороны параметры для теста и для выполнения.
//
// Revision 1.12  2007/01/18 09:06:53  lulin
// - с общих параметров убраны тестовые опции.
//
// Revision 1.11  2007/01/15 16:37:57  lulin
// - при построении меню используем операции сущности из списка строк.
//
// Revision 1.10  2006/09/21 13:06:31  mmorozov
// - new behaviour: в нотификации о выполнении операции подается выполняемая операция в виде IvcmOperationDef;
//
// Revision 1.9  2004/08/11 14:30:01  law
// - new behavior: сделан вызов Help'а для пунктов меню.
//
// Revision 1.8  2003/11/21 13:00:47  law
// - change: параметр aMode перенесен в конец и сделан необязательным.
//
// Revision 1.7  2003/07/25 10:06:00  law
// - new method: TvcmAction.EQ.
//
// Revision 1.6  2003/04/22 14:03:01  law
// - new behavior: сделана обработка операций, описанных на основной форме.
//
// Revision 1.5  2003/04/09 15:52:35  law
// - new _operation type: vcm_otDate.
//
// Revision 1.4  2003/04/09 14:51:34  law
// - new behavior: сделал обработку списка строк у ComboBox'а.
//
// Revision 1.3  2003/04/09 13:08:14  law
// - new behavior: в нулевом приближении сделал обработку операции с типом vcm_otCombo.
//
// Revision 1.2  2003/04/04 10:58:59  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:49  law
// - переименовываем MVC в VCM.
//
// Revision 1.11  2003/03/26 14:58:06  law
// - change: добавляем ActionList по умолчанию для всей библиотеки.
//
// Revision 1.10  2003/03/26 13:18:42  law
// - new behavior: заведены списки уже созданных Action'ов для операций модуля и сущности.
//
// Revision 1.9  2003/03/25 11:28:49  law
// - change: из-за исправлений в библиотеке, поправлен пример.
//
// Revision 1.8  2003/03/24 13:25:48  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.7  2003/03/21 16:00:28  law
// - new behavior: сделана поверка разрешенности операции модуля.
//
// Revision 1.6  2003/03/20 16:03:54  law
// - new behavior: убрал из TvcmModuleAction непосредственную ссылку на экземпляр модуля.
//
// Revision 1.5  2003/02/27 17:35:12  law
// - change: объединил методы ExecuteOperation и OperationEnabled.
//
// Revision 1.4  2003/02/27 10:55:12  law
// - new unit: vcmEntityAction.
//
// Revision 1.3  2003/02/27 10:36:26  law
// - new unit: vcmOperationAction.
//
// Revision 1.2  2003/02/26 16:22:43  law
// - new behavior: сделана обработка операция и создание форм.
//
// Revision 1.1  2003/02/25 17:59:46  law
// - new behavior: начал писать обвязку для выполнения операций модуля.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,
  
  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmAction,
  vcmOperationAction
  ;

type
  TvcmModuleAction = class(TvcmOperationAction)
   {* Базовая операция модуля библиотеки vcm для привязки к меню. }
    private
    // internal fields
      f_ModuleID : TvcmControlID;
    protected
    // property methods
      function pm_GetModuleDef: IvcmModuleDef;
        {-}
    protected
    // internal methods
      function  MopID: TvcmMOPID;
        {-}
      procedure DoExecute;
        override;
        {-}
      procedure DoUpdate;
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner          : TComponent;
                         const aModuleDef : IvcmModuleDef;
                         const anOpDef    : IvcmOperationDef);
        reintroduce;
        {-}
      class function Make(const aModuleDef : IvcmModuleDef;
                          const anOpDef    : IvcmOperationDef): TvcmModuleAction;
        reintroduce;
        overload;
        {-}
      class function Make(const anID : TvcmMOPID): TvcmModuleAction;
        overload;
        {-}
      function  EQ(anAction: TvcmAction): Boolean;
        override;
        {-}
    public
    // public properties
      property ModuleID: TvcmControlID
        read f_ModuleID;
        {* - идентификатор модуля к которому привязана операция. }
      property ModuleDef: IvcmModuleDef
        read pm_GetModuleDef;
        {-}
  end;//TvcmModuleAction

implementation

uses
  vcmBase,
  vcmOVCCommands
  ;

// start class TvcmModuleAction

constructor TvcmModuleAction.Create(anOwner          : TComponent;
                                    const aModuleDef : IvcmModuleDef;
                                    const anOpDef    : IvcmOperationDef);
  //reintroduce;
  {-}
begin
 inherited Create(anOwner, anOpDef);
 f_ModuleID := aModuleDef.ID;
 HelpType := htContext;
 HelpContext := vcmCommandID(aModuleDef.ID, true, anOpDef.ID);
end;

var
 g_ModuleActions : array of TvcmModuleAction = nil;

class function TvcmModuleAction.Make(const aModuleDef : IvcmModuleDef;
                                     const anOpDef    : IvcmOperationDef): TvcmModuleAction;
  {-}
var
 l_Length : Integer;
 l_ID     : TvcmMOPID;
begin
 l_ID.rMoID := aModuleDef.ID;
 l_ID.rOpID := anOpDef.ID;
 Result := TvcmModuleAction.Make(l_ID);
 if (Result = nil) then
 begin
  l_Length := Length(g_ModuleActions);
  SetLength(g_ModuleActions, Succ(l_Length));
  Result := Create(nil, aModuleDef, anOpDef);
  g_ModuleActions[l_Length] := Result;
 end;//Result = nil
end;

class function TvcmModuleAction.Make(const anID : TvcmMOPID): TvcmModuleAction;
  //overload;
  {-}
var
 l_Index  : Integer;
begin
 for l_Index := Low(g_ModuleActions) to High(g_ModuleActions) do begin
  Result := g_ModuleActions[l_Index];
  with Result do
   if (ModuleID = anID.rMoID) AND
      (OperationID = anID.rOpID) then
    Exit;
 end;//for l_Index
 Result := nil;
end;

function TvcmModuleAction.EQ(anAction: TvcmAction): Boolean;
  //override;
  {-}
begin
 Result := inherited EQ(anAction) OR
           ((anAction Is TvcmModuleAction) AND
            (ModuleID = TvcmModuleAction(anAction).ModuleID) AND
            (OperationID = TvcmModuleAction(anAction).OperationID));
end;

function TvcmModuleAction.pm_GetModuleDef: IvcmModuleDef;
  {-}
begin
 Result := Dispatcher.GetModuleByID(ModuleID).ModuleDef;
end;

function TvcmModuleAction.MopID: TvcmMOPID;
  {-}
begin
 Result.rMoID := ModuleID;
 Result.rOpID := OperationID;
end;

procedure TvcmModuleAction.DoExecute;
  //override;
  {-}
begin
 inherited;
 Dispatcher.CallModuleOperation(MopID, MakeExecuteParams);
end;

procedure TvcmModuleAction.DoUpdate;
  //override;
  {-}
var
 l_P : IvcmTestParams;
begin
 inherited;
 if (Dispatcher <> nil) then
 begin
  l_P := MakeTestParams;
  Dispatcher.ModuleOperation(MopID, l_P);
  SetParams(l_P);
 end;//Dispatcher <> nil
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\Visual\vcmModuleAction.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\Visual\vcmModuleAction.pas initialization leave'); {$EndIf}
finalization
 g_ModuleActions := nil;

end.

