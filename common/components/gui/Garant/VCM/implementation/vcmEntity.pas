unit vcmEntity;
{* Сущность. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmEntity -     }
{ Начат: 27.02.2003 15:19 }
{ $Id: vcmEntity.pas,v 1.28 2012/10/26 18:33:19 lulin Exp $ }

// $Log: vcmEntity.pas,v $
// Revision 1.28  2012/10/26 18:33:19  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.27  2009/11/12 18:06:59  lulin
// - убираем ненужные возвращаемые значения.
//
// Revision 1.26  2009/11/06 13:06:17  lulin
// - избавился от ручной передачи параметров через поле Data.
//
// Revision 1.25  2009/10/01 14:58:27  lulin
// - убираем сферического коня в вакууме.
//
// Revision 1.24  2009/02/20 17:29:18  lulin
// - чистка комментариев.
//
// Revision 1.23  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.22  2007/07/10 12:40:09  lulin
// - теперь если у формы в фокусе нет операции, то транслируем операцию форме в Parent-зоне (CQ-25867, <K>-29392957).
//
// Revision 1.21  2007/01/20 17:35:43  lulin
// - разрешаем вызывать операции только по заранее известным идентификаторам.
//
// Revision 1.20  2007/01/20 15:31:07  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.19  2007/01/18 09:06:49  lulin
// - с общих параметров убраны тестовые опции.
//
// Revision 1.18  2007/01/17 14:02:43  lulin
// - вычищены последние нефиксированные параметры в тестах операций.
//
// Revision 1.17  2006/03/16 14:12:51  lulin
// - убрана возможность изменения входного параметра - идентификатора операции.
//
// Revision 1.16  2006/03/16 11:28:49  lulin
// - вычищены имена сущностей и операций - перешли на их идентификаторы.
//
// Revision 1.15  2005/07/14 16:02:46  lulin
// - new behavior: в run-time получаем ID операции по ее имени из информации, содержащейся в MenuManager'е.
//
// Revision 1.14  2004/11/18 17:33:58  lulin
// - new interface: IvcmParamsPrim.
//
// Revision 1.13  2004/10/07 14:16:58  lulin
// - new: теперь у _IvcmParams можно присваивать только свойство DoneStatus - код завершения. На основе этого "по-хитрому" обрабатываем ShortCut'ы для запрещенных операций (CQ OIT5-10123).
//
// Revision 1.12  2004/09/22 09:34:29  lulin
// - оптимизщация - кешируем результат преобразования Name -> ID при посылке операций.
//
// Revision 1.11  2004/09/07 16:19:41  law
// - перевел VCM на кшированные обьекты.
//
// Revision 1.10  2004/05/19 12:57:08  am
// change: дёргаем BeginOp\EndOp в _Operation с Mode = (vcm_omExecute, _vcm_omAggregateExecute)
//
// Revision 1.9  2004/03/16 10:59:30  law
// - new const: _vcm_omAggregateExecute.
// - new behavior: для операции агрегации не учитываем состояние Enabled.
//
// Revision 1.8  2003/11/30 13:18:09  law
// - new method version: IvcmEntity._Operation.
//
// Revision 1.7  2003/11/21 12:09:57  law
// - change: параметр aMode перенесен в конец и сделан необязательным.
//
// Revision 1.6  2003/11/20 20:37:53  law
// - new behavior: корректно генерируем список идентификаторов операций.
// - new behavior: вызов операций сущностей возможен теперь только по идентификатору.
// - cleanup: пытаемся в Design-Time отвязаться от GblAdapter (не получилось).
//
// Revision 1.5  2003/04/28 13:02:34  law
// - remove const: vcm_opDone.
// - new prop: _IvcmParams.Done.
//
// Revision 1.4  2003/04/08 13:10:35  law
// no message
//
// Revision 1.3  2003/04/08 12:52:48  law
// - new method version: IvcmEntity._Operation.
//
// Revision 1.2  2003/04/04 10:58:57  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - переименовываем MVC в VCM.
//
// Revision 1.9  2003/03/24 14:04:04  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.8  2003/03/24 13:25:46  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.7  2003/03/21 12:34:42  law
// - new behavior: операциям добавлен список параметров.
//
// Revision 1.6  2003/02/28 16:11:38  law
// - cleanup.
//
// Revision 1.5  2003/02/27 17:23:52  law
// - change: объединил методы ExecuteOperation и OperationEnabled.
//
// Revision 1.4  2003/02/27 16:26:56  law
// - new behavior: сделана возможность подвязывать несколько типов сущностей к одному контролу.
//
// Revision 1.3  2003/02/27 13:00:20  law
// - new prop: IvcmEntity._Inner.
//
// Revision 1.2  2003/02/27 12:55:50  law
// - new prop: IvcmEntity._Inner.
//
// Revision 1.1  2003/02/27 12:33:38  law
// - new units: vcmEntity, vcmControlEntity.
//

{$Include vcmDefine.inc }

interface

uses
  vcmUserControls,
  vcmInterfaces,
  vcmExternalInterfaces,
  vcmBaseMenuManager,

  vcmBase
  ;

type
  TvcmEntity = class(TvcmCacheableBase, IvcmEntity)
   {* Сущность. }
    protected
    // interface methods
      //IvcmEntity
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmParams;
                         aMode         : TvcmOperationMode): Boolean;
        overload;
        virtual;
        {* - выполняет операцию сущности. }
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmExecuteParams): Boolean;
        overload;
        { Выполнение операции по имени сущности. }
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmTestParams): Boolean;
        overload;
        { Выполнение операции по имени сущности. }
      function Operation(const anOp : TvcmOPID;
                         aMode      : TvcmOperationMode = vcm_omExecute): Boolean;
        overload;
        { Выполнение операции по имени сущности. }
      function Get_ID: TvcmControlID;
        virtual;
        {* - возвращает идентификатор сущности. Для перекрытия в потомках. }
      function Get_Inner(const anEntityID : TvcmControlID): IvcmEntity;
        virtual;
        {* - возвращает вложенную сущность. Для перекрытия в потомках. }
      function Get_AsForm: IvcmEntityForm;
        virtual;
    protected
    // internal methods
      procedure SelfOperation(const anOperationID : TvcmControlID;
                             aMode               : TvcmOperationMode;
                             const aParams       : IvcmParams);
        virtual;
        {* - выполняет операцию сущности. Для перекрытия в потомках. }
  end;//TvcmEntity

implementation

uses
  vcmRepositoryEx
  ;

// start class TvcmEntity

function TvcmEntity.Operation(const anOp    : TvcmOPID;
                              const aParams : IvcmParams;
                              aMode         : TvcmOperationMode): Boolean;
  //overload;
  {* - выполняет операцию сущности. }
var
 l_Inner : IvcmEntity;
begin
 if (aMode in [vcm_omExecute, vcm_omAggregateExecute]) then
  g_MenuManager.BeginOp;
 try
  if (anOp.rEnID = Get_ID) then
   SelfOperation(anOp.rOpID, aMode, aParams)
  else
  begin
   l_Inner := Get_Inner(anOp.rEnID);
   if (l_Inner = nil) then
   begin
    Case aMode of
     vcm_omTest :
      aParams.TestPart.Op.Flag[vcm_ofEnabled] := false;
     vcm_omExecute,
     vcm_omAggregateExecute :
      {Result.DoneStatus := vcm_dsNoEntity};
    end;//Case aMode
    aParams.DoneStatus := vcm_dsNoEntity;
   end//l_Inner = nil
   else
    l_Inner.Operation(anOp, aParams, aMode);
  end;//anEntityID = Get_ID
 finally
  if (aMode in [vcm_omExecute, vcm_omAggregateExecute]) then
   g_MenuManager.EndOp;
 end;//try..finally
 Result := aParams.Done;
end;

function TvcmEntity.Operation(const anOp    : TvcmOPID;
                              const aParams : IvcmExecuteParams): Boolean;
  //overload;
  { Выполнение операции по имени сущности. }
begin
 Result := Operation(anOp, aParams.BasePart, vcm_omExecute);
end;

function TvcmEntity.Operation(const anOp    : TvcmOPID;
                              const aParams : IvcmTestParams): Boolean;
  //overload;
  { Выполнение операции по имени сущности. }
begin
 Result := Operation(anOp, aParams.BasePart, vcm_omTest);
end;

function TvcmEntity.Operation(const anOp : TvcmOPID;
                              aMode      : TvcmOperationMode = vcm_omExecute): Boolean;
  //overload;
  { Выполнение операции по имени сущности. }
begin
 if (aMode = vcm_omTest) then
  Result := Operation(anOp, TvcmTestParams.Make.BasePart, aMode)
 else
  Result := Operation(anOp, vcmParams.BasePart, aMode);
end;

function TvcmEntity.Get_ID: TvcmControlID;
  //virtual;
  {-}
begin
 Result := vcm_cidEmpty;
end;

function TvcmEntity.Get_Inner(const anEntityID : TvcmControlID): IvcmEntity;
  //virtual;
  {-}
begin
 Result := nil;
end;

function TvcmEntity.Get_AsForm: IvcmEntityForm;
  //virtual;
begin
 Result := nil;
 Assert(false);
end;

procedure TvcmEntity.SelfOperation(const anOperationID : TvcmControlID;
                                  aMode               : TvcmOperationMode;
                                  const aParams       : IvcmParams);
  //virtual;
  {* - выполняет операцию сущности. }
begin
end;

end.

