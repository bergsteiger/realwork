unit vcmControlEntity;
{* Сущность привязанная к элементу управления. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmControlEntity - }
{ Начат: 27.02.2003 15:25 }
{ $Id: vcmControlEntity.pas,v 1.8 2013/05/16 16:24:06 lulin Exp $ }

// $Log: vcmControlEntity.pas,v $
// Revision 1.8  2013/05/16 16:24:06  lulin
// - ищем странную ошибку в пачке тестов.
//
// Revision 1.7  2013/05/16 16:17:15  lulin
// - ищем странную ошибку в пачке тестов.
//
// Revision 1.6  2009/11/12 18:06:59  lulin
// - убираем ненужные возвращаемые значения.
//
// Revision 1.5  2009/02/20 17:57:35  lulin
// - <K>: 136941122. Чистка кода.
//
// Revision 1.4  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.3  2007/04/04 09:10:28  lulin
// - bug fix: не заполнялся контейнер в параметрах операции (CQ OIT5-24865).
//
// Revision 1.2  2004/10/22 10:21:27  demon
// - bug fix: не очищалось поле f_Control.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - переименовываем MVC в VCM.
//
// Revision 1.3  2003/02/27 15:21:52  law
// - new unit: vcmEventedIdentifiedControlEntity.
//
// Revision 1.2  2003/02/27 13:58:30  law
// - new unit: vcmIdentifiedControlEntity.
//
// Revision 1.1  2003/02/27 12:33:38  law
// - new units: vcmEntity, vcmControlEntity.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,

  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmEntity
  ;

type
  TvcmControlEntity = class(TvcmEntity)
   {* Сущность привязанная к элементу управления. }
    private
    // interfal fields
      f_Control : TComponent;
    protected
    // internal methods
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmParams;
                         aMode         : TvcmOperationMode): Boolean;
        override;
        {* - выполняет операцию сущности. }
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(aControl: TComponent);
        reintroduce;
        {* - создает объект. }
    public
    // public properties
      property Control: TComponent
        read f_Control;
        {* - компонент, представляющий сущность. }
  end;//TvcmControlEntity

implementation

uses
  SysUtils,

  Controls,

  l3Base,
  
  afwFacade,
  
  vcmEntityForm
  ;

// start class TvcmControlEntity

constructor TvcmControlEntity.Create(aControl: TComponent);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Control := aControl;
end;

procedure TvcmControlEntity.Cleanup;
  //override;
  {-}
begin
 f_Control := nil;
 inherited;
end;

type
  THackControl = class(TControl)
  end;//THackControl

function TvcmControlEntity.Operation(const anOp    : TvcmOPID;
                                     const aParams : IvcmParams;
                                     aMode         : TvcmOperationMode): Boolean;
  //override;
  {* - выполняет операцию сущности. }
var  
 l_Container : IvcmContainer;
 l_Form      : TvcmEntityForm;
begin
 if not aParams.HasContainer then
 begin
  try
   if Supports(Control, IvcmContainer, l_Container) then
    try
     aParams.SetContainerPrim(l_Container, false);
    finally
     l_Container := nil;
    end//try..finally
   else
   begin
    l_Form := afw.GetParentForm(Control) As TvcmEntityForm;
    l_Container := l_Form.Container;
    if not l_Container.IsNull then
     aParams.SetContainerPrim(l_Container, false);
   end;//Supports(Control, IvcmContainer, l_Container)
  except
   l3System.Msg2Log('TvcmControlEntity.Operation fail');
   try
    l3System.Msg2Log(Control.Name);
    l3System.Msg2Log(Control.ClassName);
    l3System.Msg2Log(THackControl(Control).Caption);
   except
    l3System.Msg2Log('TvcmControlEntity.Operation control info fail');
   end;//try...except
   f_Control := nil;
   Result := false;
   Exit;
  end;//try..except
 end;//not aParams.HasContainer
 Result := inherited Operation(anOp, aParams, aMode);
end;

end.

