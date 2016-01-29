unit vcmIdentifiedControlEntity;
{* Сущность имеющая идентификатор привязанная к элементу управления. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmIdentifiedControlEntity - }
{ Начат: 27.02.2003 16:50 }
{ $Id: vcmIdentifiedControlEntity.pas,v 1.2 2003/04/07 15:10:46 law Exp $ }

// $Log: vcmIdentifiedControlEntity.pas,v $
// Revision 1.2  2003/04/07 15:10:46  law
// - bug fix: сделано, чтобы компилировалось под Builder'ом.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - переименовываем MVC в VCM.
//
// Revision 1.2  2003/02/27 15:21:52  law
// - new unit: vcmEventedIdentifiedControlEntity.
//
// Revision 1.1  2003/02/27 13:58:30  law
// - new unit: vcmIdentifiedControlEntity.
//

{$I vcmDefine.inc }

interface

uses
  Classes,
  
  vcmInterfaces,

  vcmControlEntity
  ;

type
  TvcmIdentifiedControlEntity = class(TvcmControlEntity)
   {* Сущность имеющая идентификатор привязанная к элементу управления. }
    private
    // internal fields
      f_ID : TvcmControlID;
    protected
    // interface methods
      function Get_ID: TvcmControlID;
        override;
        {* - возвращает идентификатор сущности. }
    public
    // public methods
      constructor Create(aControl   : TComponent;
                         const anID : TvcmControlID);
        reintroduce;
        {* - создает объект. }
  end;//TvcmIdentifiedControlEntity

implementation

// start class TvcmIdentifiedControlEntity

constructor TvcmIdentifiedControlEntity.Create(aControl   : TComponent;
                                               const anID : TvcmControlID);
  //reintroduce;
  {-}
begin
 inherited Create(aControl);
 f_ID := anID;
end;

function TvcmIdentifiedControlEntity.Get_ID: TvcmControlID;
  //override;
  {* - возвращает идентификатор сущности. }
begin
 Result := f_ID;
end;

end.

