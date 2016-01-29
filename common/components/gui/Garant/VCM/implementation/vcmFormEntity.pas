unit vcmFormEntity;
{* Сущность, связанная с формой. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmFormEntity - }
{ Начат: 27.02.2003 16:01 }
{ $Id: vcmFormEntity.pas,v 1.21 2014/04/23 11:13:44 lulin Exp $ }

// $Log: vcmFormEntity.pas,v $
// Revision 1.21  2014/04/23 11:13:44  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.20  2012/04/13 14:37:25  lulin
// {RequestLink:237994598}
//
// Revision 1.19  2010/07/12 17:23:24  lulin
// {RequestLink:207389954}.
// - переносим на модель форму "Документ".
//
// Revision 1.18  2009/11/12 18:06:59  lulin
// - убираем ненужные возвращаемые значения.
//
// Revision 1.17  2009/10/01 14:58:27  lulin
// - убираем сферического коня в вакууме.
//
// Revision 1.16  2009/02/20 17:29:18  lulin
// - чистка комментариев.
//
// Revision 1.15  2009/02/20 16:45:36  lulin
// - <K>: 136941122.
//
// Revision 1.14  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.13  2008/12/12 19:19:23  lulin
// - <K>: 129762414.
//
// Revision 1.12  2007/04/04 09:10:28  lulin
// - bug fix: не заполнялся контейнер в параметрах операции (CQ OIT5-24865).
//
// Revision 1.11  2007/01/20 17:35:43  lulin
// - разрешаем вызывать операции только по заранее известным идентификаторам.
//
// Revision 1.10  2007/01/18 13:13:42  lulin
// - разводим в стороны параметры для теста и для выполнения.
//
// Revision 1.9  2007/01/18 12:09:17  lulin
// - разводим в стороны параметры для теста и для выполнения.
//
// Revision 1.8  2005/01/21 09:24:46  demon
// - fix: при _broadcast'е операции доходили до форм, которые находились в процессе закрытия.
//
// Revision 1.7  2005/01/12 12:02:44  lulin
// - транслируем запрос интерфейсов от proxy объектов к форме.
//
// Revision 1.6  2004/03/26 10:21:20  mmorozov
// bugfix: aParams.Container не приходил в операцию;
//
// Revision 1.5  2003/06/23 14:27:04  law
// - new behavior: теперь контейнер восстанавливает свой GUID при операциях Back/Forward.
//
// Revision 1.4  2003/06/03 14:08:12  law
// - bug fix: не собиралось с опцией vcmNeedL3.
// - bug fix: при закрытии приложения не освобождались модули.
//
// Revision 1.3  2003/04/09 08:57:33  law
// - экспериментируем с ComboBox в Toolbar'е.
//
// Revision 1.2  2003/04/04 10:58:57  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - переименовываем MVC в VCM.
//
// Revision 1.7  2003/03/24 14:04:05  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.6  2003/03/24 13:25:46  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.5  2003/03/21 12:34:42  law
// - new behavior: операциям добавлен список параметров.
//
// Revision 1.4  2003/02/27 17:23:52  law
// - change: объединил методы ExecuteOperation и OperationEnabled.
//
// Revision 1.3  2003/02/27 16:26:56  law
// - new behavior: сделана возможность подвязывать несколько типов сущностей к одному контролу.
//
// Revision 1.2  2003/02/27 13:43:42  law
// - new method: _TvcmEntityForm._GetInnerForControl.
//
// Revision 1.1  2003/02/27 13:09:28  law
// - new unit: vcmFormEntity.
//

{$Include vcmDefine.inc }

interface

uses
  Windows,
  
  {$IfDef vcmNeedL3}
  l3IID,
  {$EndIf vcmNeedL3}

  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  
  vcmControlEntity,
  vcmEntityForm
  ;

type
  TvcmFormEntity = class(TvcmControlEntity)
   {* Сущность, связанная с формой. }
    protected
    // interface methods
      //IvcmEntity
      function Get_ID: TvcmControlID;
        override;
        {-}
      function Get_Inner(const anEntityID : TvcmControlID): IvcmEntity;
        override;
        {* - возвращает вложенную сущность формы. }
    protected
    // property methods
      function pm_GetForm: TvcmEntityForm;
        {-}
    protected
    // internal methods
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmParams;
                         aMode         : TvcmOperationMode): Boolean;
        override;
        {* - выполняет операцию сущности. }
      procedure SelfOperation(const anOperationID : TvcmControlID;
                             aMode               : TvcmOperationMode;
                             const aParams       : IvcmParams);
        override;
        {* - выполняет операцию сущности, передавая ее форме. }
      function Get_AsForm: IvcmEntityForm;
        override;
    public
    // public methods
      constructor Create(aForm: TvcmEntityForm);
        reintroduce;
        {-}
      {$IfDef vcmNeedL3}
      function  COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
      {$Else  vcmNeedL3}
      function  QueryInterface(const IID: TGUID; out Obj): HResult;
        override;
        {-}
      {$EndIf vcmNeedL3}
    public
    // public properties
      property Form: TvcmEntityForm
        read pm_GetForm;
        {* - форма, связанная с сущностью. }    
  end;//TvcmFormEntity

implementation

uses
  SysUtils,

  vcmBase
  ;

// start class TvcmFormEntity

constructor TvcmFormEntity.Create(aForm: TvcmEntityForm);
  //reintroduce;
  {-}
begin
 inherited Create(aForm);
end;

function TvcmFormEntity.pm_GetForm: TvcmEntityForm;
  {-}
begin
 Result := TvcmEntityForm(Control);
end;

function TvcmFormEntity.Operation(const anOp    : TvcmOPID;
                                  const aParams : IvcmParams;
                                  aMode         : TvcmOperationMode): Boolean;
  //override;
  {-}
begin
 if Form.VCMClosing then
 begin
  aParams.DoneStatus := vcm_dsFormInClose;
  Result := false;
 end//Form.VCMClosing
 else
  Result := inherited Operation(anOp, aParams, aMode);
end;

procedure TvcmFormEntity.SelfOperation(const anOperationID : TvcmControlID;
                                      aMode               : TvcmOperationMode;
                                      const aParams       : IvcmParams);
  //override;
  {* - выполняет операцию сущности. }
begin
 Form.Operation(anOperationID, aMode, aParams);
end;

function TvcmFormEntity.Get_AsForm: IvcmEntityForm;
  //override;
begin
 Result := Form.As_IvcmEntityForm;
end;

function TvcmFormEntity.Get_ID: TvcmControlID;
  //override;
  {-}
begin
 Result := Form.GetEntityID;
end;

function TvcmFormEntity.Get_Inner(const anEntityID : TvcmControlID): IvcmEntity;
  //override;
  {-}
begin
 Result := Form.GetInner(anEntityID);
end;

{$IfDef vcmNeedL3}
function TvcmFormEntity.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.SomeOf([IvcmEntityForm, IvcmContainer]) then
  Result := Tl3HResult_C(Form.QueryInterface(IID.IID, Obj))
 else
 begin
  Result := inherited COMQueryInterface(IID, Obj);
  if Result.Fail then
  begin
   if Supports(Form, IID.IID, Obj) then
    Result.SetOk
   else
    Result.SetNoInterface;
  end;//Failed(Result)
 end;//IID.SomeOf([IvcmEntityForm, IvcmContainer])
end;
{$Else  vcmNeedL3}
function TvcmFormEntity.QueryInterface(const IID: TGUID; out Obj): HResult;
  //override;
  {-}
begin
 if IsEqualGUID(IID, IvcmEntityForm) OR
    IsEqualGUID(IID, IvcmContainer) then
  Result := Form.QueryInterface(IID, Obj)
 else
 begin
  Result := inherited QueryInterface(IID, Obj);
  if Failed(Result) then
  begin
   if Supports(Form, IID, Obj) then
    Result := S_Ok
   else
    Result := E_NoInterface;
  end;//Failed(Result)
 end;//IsEqualGUID(IID, IvcmEntityForm)..
end;
{$EndIf vcmNeedL3}

end.

