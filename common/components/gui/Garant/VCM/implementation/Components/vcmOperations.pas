unit vcmOperations;
{* Компонент для определения списка операций. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmOperations - }
{ Начат: 13.03.2003 18:11 }
{ $Id: vcmOperations.pas,v 1.5 2011/07/29 15:08:37 lulin Exp $ }

// $Log: vcmOperations.pas,v $
// Revision 1.5  2011/07/29 15:08:37  lulin
// {RequestLink:209585097}.
//
// Revision 1.4  2010/09/15 18:15:01  lulin
// {RequestLink:235047275}.
//
// Revision 1.3  2004/09/11 12:29:10  lulin
// - cleanup: избавляемся от прямого использования деструкторов.
// - new unit: vcmComponent.
//
// Revision 1.2  2003/11/30 15:15:31  law
// - new behavior: добавлена генерация констант для операций модуля.
//
// Revision 1.1  2003/04/01 12:54:44  law
// - переименовываем MVC в VCM.
//
// Revision 1.1  2003/03/12 15:29:18  law
// - new component: _TvcmOperations.
//

{$I vcmDefine.inc }

interface

{$IfNDef NoVCM}
uses
  Classes,

  vcmInterfaces,
  vcmComponent,
  vcmOperationsCollection
  ;

type
  TvcmCustomOperations = class(TvcmComponent)
   {* Компонент для определения списка операций. }
    private
    // internal fields
      f_Operations: TvcmOperationsCollection;
    protected
    // property methods
      function  pm_GetOperations: TvcmOperationsCollection;
      procedure pm_SetOperations(aValue: TvcmOperationsCollection);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
      procedure RegisterInRep;
        {-}  
    public
    // public properties
      property Operations: TvcmOperationsCollection
        read pm_GetOperations
        write pm_SetOperations;
        {* - коллекция операций. }
  end;//TvcmCustomOperations
{$EndIf NoVCM}

implementation

{$IfNDef NoVCM}
uses
  SysUtils
  ;

// start class TvcmCustomOpertions

constructor TvcmCustomOperations.Create(anOwner: TComponent);
  //override;
  {-}
begin
 inherited;
 f_Operations := TvcmOperationsCollection.Create(Self);
end;

procedure TvcmCustomOperations.Cleanup;
  //override;
  {-}
begin
 FreeAndNil(f_Operations);
 inherited;
end;

function TvcmCustomOperations.pm_GetOperations: TvcmOperationsCollection;
  {-}
begin
 Result := f_Operations;
end;

procedure TvcmCustomOperations.pm_SetOperations(aValue: TvcmOperationsCollection);
  {-}
begin
 f_Operations.Assign(aValue);
end;

procedure TvcmCustomOperations.RegisterInRep;
  {-}
begin
 if (Operations <> nil) then
  Operations.RegisterInRep;
end;
{$EndIf NoVCM}

end.

