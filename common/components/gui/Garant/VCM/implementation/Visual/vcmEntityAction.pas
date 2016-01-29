unit vcmEntityAction;
{* Базовая операция сущности библиотеки vcm для привязки к меню. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmEntityAction - }
{ Начат: 27.02.2003 13:29 }
{ $Id: vcmEntityAction.pas,v 1.31 2013/04/05 12:02:41 lulin Exp $ }

// $Log: vcmEntityAction.pas,v $
// Revision 1.31  2013/04/05 12:02:41  lulin
// - портируем.
//
// Revision 1.30  2012/11/01 09:42:25  lulin
// - забыл точку с запятой.
//
// Revision 1.29  2012/11/01 07:44:12  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.28  2012/04/11 15:29:02  lulin
// - пытаемся разобраться с "галочками".
//
// Revision 1.27  2009/11/12 18:08:13  lulin
// - убираем ненужные возвращаемые значения.
//
// Revision 1.26  2009/08/20 17:19:07  lulin
// {RequestLink:159360595}.
//
// Revision 1.25  2009/02/20 17:29:21  lulin
// - чистка комментариев.
//
// Revision 1.24  2009/02/20 15:19:08  lulin
// - <K>: 136941122.
//
// Revision 1.23  2008/04/02 14:22:15  lulin
// - cleanup.
//
// Revision 1.22  2007/01/24 14:58:07  lulin
// - cleanup.
//
// Revision 1.21  2007/01/20 17:35:47  lulin
// - разрешаем вызывать операции только по заранее известным идентификаторам.
//
// Revision 1.20  2007/01/20 15:31:10  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.19  2007/01/18 13:13:46  lulin
// - разводим в стороны параметры для теста и для выполнения.
//
// Revision 1.18  2007/01/18 09:06:53  lulin
// - с общих параметров убраны тестовые опции.
//
// Revision 1.17  2007/01/15 16:37:57  lulin
// - при построении меню используем операции сущности из списка строк.
//
// Revision 1.16  2006/09/21 13:06:31  mmorozov
// - new behaviour: в нотификации о выполнении операции подается выполняемая операция в виде IvcmOperationDef;
//
// Revision 1.15  2005/10/14 10:30:03  lulin
// - bug fix: был AV при прерывании построения _Preview (CQ OIT5-16964).
//
// Revision 1.14  2004/09/11 12:01:52  lulin
// - cleanup: избавляемся от прямого использования деструкторов.
//
// Revision 1.13  2004/08/11 16:14:25  law
// - более просто из ContextID вычисляем KeyWord.
//
// Revision 1.12  2004/08/11 14:30:00  law
// - new behavior: сделан вызов Help'а для пунктов меню.
//
// Revision 1.11  2003/11/21 12:10:01  law
// - change: параметр aMode перенесен в конец и сделан необязательным.
//
// Revision 1.10  2003/07/25 13:39:28  law
// - new behavior: toolbar'ы обновляются после настройки.
//
// Revision 1.9  2003/07/25 10:06:00  law
// - new method: TvcmAction.EQ.
//
// Revision 1.8  2003/04/24 15:47:27  law
// - new behavior: привязал кнопки дочернего окна только к сущностям этого окна, а не к сущностям текущей формы.
//
// Revision 1.7  2003/04/22 14:03:01  law
// - new behavior: сделана обработка операций, описанных на основной форме.
//
// Revision 1.6  2003/04/09 15:52:35  law
// - new _operation type: vcm_otDate.
//
// Revision 1.5  2003/04/09 14:51:34  law
// - new behavior: сделал обработку списка строк у ComboBox'а.
//
// Revision 1.4  2003/04/09 13:08:14  law
// - new behavior: в нулевом приближении сделал обработку операции с типом vcm_otCombo.
//
// Revision 1.3  2003/04/04 10:58:59  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.2  2003/04/03 11:17:57  law
// - bug fix: дублировались пункты меню.
//
// Revision 1.1  2003/04/01 12:54:49  law
// - переименовываем MVC в VCM.
//
// Revision 1.10  2003/03/26 14:58:06  law
// - change: добавляем ActionList по умолчанию для всей библиотеки.
//
// Revision 1.9  2003/03/26 13:18:42  law
// - new behavior: заведены списки уже созданных Action'ов для операций модуля и сущности.
//
// Revision 1.8  2003/03/25 11:28:48  law
// - change: из-за исправлений в библиотеке, поправлен пример.
//
// Revision 1.7  2003/03/24 14:04:07  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.6  2003/03/24 13:25:48  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.5  2003/03/19 17:11:16  law
// - new behavior: операции контекстного меню привязываем именно к сущности того управляющего элемента, над которым меню вызвали.
//
// Revision 1.4  2003/02/27 17:23:53  law
// - change: объединил методы ExecuteOperation и OperationEnabled.
//
// Revision 1.3  2003/02/27 12:12:05  law
// - new behavior: определяется разрешенность операций сущности.
//
// Revision 1.2  2003/02/27 10:59:50  law
// - comments: xHelpGen.
//
// Revision 1.1  2003/02/27 10:55:12  law
// - new unit: vcmEntityAction.
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
  TvcmBaseEntityAction = class(TvcmOperationAction)
    private
    // internal fields
      f_EntityID  : TvcmControlID;
    protected
    // internal methods
      function  EopID: TvcmOPID;
        {-}
    public
    // public methods
      function  EQ(anAction: TvcmAction): Boolean;
        override;
        {-}
    public
    // public properties
      property EntityID: TvcmControlID
        read f_EntityID;
        {* - код сущности. }
  end;//TvcmBaseEntityAction

  TvcmEntityAction = class(TvcmBaseEntityAction)
   {* Базовая операция сущности библиотеки vcm для привязки к меню. }
    private
    // internal fields
      f_EntityDef : IvcmEntityDef;
    protected
    // internal methods
      procedure DoExecute;
        override;
        {-}
      procedure DoUpdate;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      class function Make(const anEntityDef : IvcmEntityDef;
                          const anOpDef     : IvcmOperationDef): TvcmEntityAction;
        reintroduce;
        overload;
        {-}
      class function Make(const anID : TvcmOPID): TvcmEntityAction;
        overload;
        {-}
      constructor Create(anOwner           : TComponent;
                         const anEntityDef : IvcmEntityDef;
                         const anOpDef     : IvcmOperationDef);
        reintroduce;
        {-}
     public
     // public properties
       property EntityDef: IvcmEntityDef
         read f_EntityDef;
         {-}
  end;//TvcmEntityAction

  TvcmActiveEntityAction = class(TvcmBaseEntityAction)
   {* Базовая операция активной сущности библиотеки vcm для привязки к меню. }
    private
    // internal fields
      f_Entity    : IvcmEntity;
    protected
    // internal methods
      procedure DoExecute;
        override;
        {-}
      procedure DoUpdate;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}  
    public
    // public methods
      constructor Create(anOwner        : TComponent;
                         const anEntity : IvcmEntity;
                         const anOpDef  : IvcmOperationDef);
        reintroduce;
        {-}
    public
    // public properties
      property Entity: IvcmEntity
        read f_Entity;
        {-}
  end;//TvcmActiveEntityAction

  TvcmActiveEntityActionEx = class(TvcmActiveEntityAction)
    private
    // internal fields
      f_EntityDef : IvcmEntityDef;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner           : TComponent;
                         const anEntity    : IvcmEntity;
                         const anEntityDef : IvcmEntityDef;
                         const anOpDef     : IvcmOperationDef);
        reintroduce;
        {-}
     public
     // public properties
      property EntityDef: IvcmEntityDef
        read f_EntityDef;
        {-}
  end;//TvcmActiveEntityActionEx

implementation

uses
  vcmBase,
  vcmOVCCommands
  ;

// start class TvcmModuleAction

constructor TvcmEntityAction.Create(anOwner           : TComponent;
                                    const anEntityDef : IvcmEntityDef;
                                    const anOpDef     : IvcmOperationDef);
  //reintroduce;
  {-}
begin
 inherited Create(anOwner, anOpDef);
 f_EntityID := anEntityDef.ID;
 f_EntityDef := anEntityDef;
 HelpType := htContext;
 HelpContext := vcmCommandID(anEntityDef.ID, false, anOpDef.ID);
end;

procedure TvcmEntityAction.Cleanup;
  //override;
  {-}
begin
 f_EntityDef := nil;
 inherited;
end;

var
 g_EntityActions : array of TvcmEntityAction = nil;

class function TvcmEntityAction.Make(const anEntityDef : IvcmEntityDef;
                                     const anOpDef     : IvcmOperationDef): TvcmEntityAction;
  {-}
var
 l_Length : Integer;
 l_ID     : TvcmOPID;
begin
 l_ID.rEnID := anEntityDef.ID;
 l_ID.rOpID := anOpDef.ID;
 Result := TvcmEntityAction.Make(l_ID);
 if (Result = nil) then
 begin
  l_Length := Length(g_EntityActions);
  SetLength(g_EntityActions, Succ(l_Length));
  Result := Create(nil, anEntityDef, anOpDef);
  g_EntityActions[l_Length] := Result;
 end;//Result = nil
end;

class function TvcmEntityAction.Make(const anID : TvcmOPID): TvcmEntityAction;
  //overload;
  {-}
var
 l_Index  : Integer;
begin
 for l_Index := Low(g_EntityActions) to High(g_EntityActions) do begin
  Result := g_EntityActions[l_Index];
  with Result do
   if (EntityID = anID.rEnID) AND
      (OperationID = anID.rOpID) then
    Exit;
 end;//for l_Index
 Result := nil;
end;

procedure TvcmEntityAction.DoExecute;
  //override;
  {-}
begin
 inherited;
 if (Dispatcher <> nil) then
  Dispatcher.EntityOperation(EopID, MakeExecuteParams);
end;

procedure TvcmEntityAction.DoUpdate;
  //override;
  {-}
var
 l_P : IvcmTestParams;
begin
 inherited;
 if (Dispatcher <> nil) then
 begin
  l_P := MakeTestParams;
  Dispatcher.EntityOperation(EopID, l_P);
  SetParams(l_P);
 end;//Dispatcher <> nil
end;

// start class TvcmActiveEntityAction

constructor TvcmActiveEntityAction.Create(anOwner        : TComponent;
                                          const anEntity : IvcmEntity;
                                          const anOpDef  : IvcmOperationDef);
  //reintroduce;
  {-}
begin
 inherited Create(anOwner, anOpDef);
 f_Entity := anEntity;
 f_EntityID := f_Entity.ID;
 HelpType := htContext;
 HelpContext := vcmCommandID(anEntity.ID, false, anOpDef.ID);
end;

procedure TvcmActiveEntityAction.Cleanup;
  //override;
  {-}
begin
 f_Entity := nil;
 inherited;
end;

procedure TvcmActiveEntityAction.DoExecute;
  //override;
  {-}
begin
 inherited;
 f_Entity.Operation(EopID, MakeExecuteParams);
end;

procedure TvcmActiveEntityAction.DoUpdate;
  //override;
  {-}
var
 l_P : IvcmTestParams;
begin
 inherited;
 if ({$ifDef XE}ClientCount > 0{$Else}FClients <> nil{$EndIf}) then
 begin
  l_P := MakeTestParams;
  f_Entity.Operation(EopID, l_P);
  SetParams(l_P);
 end;//FClients <> nil
end;

// start class TvcmActiveEntityActionEx

constructor TvcmActiveEntityActionEx.Create(anOwner           : TComponent;
                                            const anEntity    : IvcmEntity;
                                            const anEntityDef : IvcmEntityDef;
                                            const anOpDef     : IvcmOperationDef);
  //reintroduce;
  {-}
begin
 inherited Create(anOwner, anEntity, anOpDef);
 f_EntityID := anEntityDef.ID;
 f_EntityDef := anEntityDef;
 HelpType := htContext;
 HelpContext := vcmCommandID(anEntityDef.ID, false, anOpDef.ID);
end;

procedure TvcmActiveEntityActionEx.Cleanup;
  //override;
  {-}
begin
 f_EntityDef := nil;
 inherited;
end;

// start class TvcmBaseEntityAction

function TvcmBaseEntityAction.EopID: TvcmOPID;
  {-}
begin
 Result.rEnID := EntityID;
 Result.rOpID := OperationID;
end;

function TvcmBaseEntityAction.EQ(anAction: TvcmAction): Boolean;
  //override;
  {-}
begin
 Result := inherited EQ(anAction) OR
           ((anAction Is TvcmBaseEntityAction) AND
            (EntityID = TvcmBaseEntityAction(anAction).EntityID) AND
            (OperationID = TvcmBaseEntityAction(anAction).OperationID));
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityAction.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityAction.pas initialization leave'); {$EndIf}
finalization
 g_EntityActions := nil;

end.

