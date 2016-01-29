unit vcmControlsCollectionItem;
{* Элемент коллекции управляющих элементов, привязанных к сущностям. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmControlsCollectionItem - }
{ Начат: 11.03.2003 16:12 }
{ $Id: vcmControlsCollectionItem.pas,v 1.8 2015/06/03 12:26:27 lulin Exp $ }

// $Log: vcmControlsCollectionItem.pas,v $
// Revision 1.8  2015/06/03 12:26:27  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.7  2011/12/22 14:46:43  lulin
// {RequestLink:320745296}
//
// Revision 1.6  2005/01/14 10:42:30  lulin
// - методы Get*ParentForm переехали в библиотеку AFW.
//
// Revision 1.5  2004/10/07 12:44:50  mmorozov
// - место для комментария;
//
// Revision 1.4  2004/09/13 08:56:10  lulin
// - new behavior: TvcmPrimCollectionItem теперь может кешироваться и распределяться в пуле объектов.
//
// Revision 1.3  2003/04/22 15:50:51  law
// - new behavior: при докинге пользователем проверяем тип зоны, куда пользователь пытается вставить форму.
//
// Revision 1.2  2003/04/03 09:26:17  law
// - new behavior: сделал возможность подписки на события.
//
// Revision 1.1  2003/04/01 12:54:44  law
// - переименовываем MVC в VCM.
//
// Revision 1.4  2003/03/20 17:26:38  law
// - change: сделаны более удобочитаемые пути к сущностям и операциям.
//
// Revision 1.3  2003/03/13 12:31:04  law
// no message
//
// Revision 1.2  2003/03/11 15:34:30  law
// - new behavior: сделаны обработчики операций.
//
// Revision 1.1  2003/03/11 13:37:24  law
// - new behavior: сделано привязывание управляющих элементов к сущностям.
//

{$I vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Classes,

  vcmPrimCollectionItem
  ;

type
  TvcmControlsCollectionItem = class(TvcmPrimCollectionItem)
   {* Элемент коллекции управляющих элементов, привязанных к сущностям. }
    private
    // internal fields
      f_Control : TComponent;
    protected
    // property methods
      function  pm_GetControl : TComponent;
        {-}
      procedure pm_SetControl(aValue: TComponent);
        virtual;
        {-}
    protected
    // internal methods
      function GetDisplayName: string;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      procedure Assign(P: TPersistent);
        override;
        {-}
    published
    // published properties
      property Control: TComponent
        read pm_GetControl
        write pm_SetControl;
        {* - управляющий элемент, обрабатываюший операции сущности. }    
  end;//TvcmControlsCollectionItem
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
uses
  Forms,

  afwFacade,
  
  vcmForm
  ;

// start class TvcmControlsCollectionItem

procedure TvcmControlsCollectionItem.Assign(P: TPersistent);
  //override;
  {-}
begin
 if (P Is TvcmControlsCollectionItem) then begin
  Control := TvcmControlsCollectionItem(P).Control;
 end else
  inherited;
end;

function TvcmControlsCollectionItem.pm_GetControl : TComponent;
  {-}
begin
 Result := f_Control;
end;

procedure TvcmControlsCollectionItem.pm_SetControl(aValue: TComponent);
  {-}
begin
 f_Control := aValue;
end;

function TvcmControlsCollectionItem.GetDisplayName: string;
  //override;
  {-}
var
 l_Form : TCustomForm;
begin
 if (f_Control = nil) then begin
  l_Form := afw.GetParentForm(Self);
  if (l_Form = nil) then
   Result := inherited GetDisplayName
  else
   Result := l_Form.Name;
 end else
  Result := f_Control.Name;
end;

procedure TvcmControlsCollectionItem.Cleanup;
  //override;
  {-}
begin
 Control := nil;
 inherited;
end;
{$IfEnd}

end.

