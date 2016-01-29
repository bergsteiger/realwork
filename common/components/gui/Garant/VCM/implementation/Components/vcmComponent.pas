unit vcmComponent;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmComponent -  }
{ Начат: 11.09.2004 16:03 }
{ $Id: vcmComponent.pas,v 1.6 2014/07/16 15:56:56 lulin Exp $ }

// $Log: vcmComponent.pas,v $
// Revision 1.6  2014/07/16 15:56:56  lulin
// - чистим код и упрощаем наследование.
//
// Revision 1.5  2004/09/13 08:56:10  lulin
// - new behavior: TvcmPrimCollectionItem теперь может кешироваться и распределяться в пуле объектов.
//
// Revision 1.4  2004/09/13 07:33:02  lulin
// - new behavior: _Tl3InterfacedComponent теперь может распределять свою память в пуле объектов.
//
// Revision 1.3  2004/09/11 13:43:14  lulin
// - еще один шаг к кешируемости _Tl3InterfacedComponent.
//
// Revision 1.2  2004/09/11 12:46:34  lulin
// - bug fix: не компилировался VCM.
//
// Revision 1.1  2004/09/11 12:29:09  lulin
// - cleanup: избавляемся от прямого использования деструкторов.
// - new unit: vcmComponent.
//

{$I vcmDefine.inc }

interface

uses
  Classes

  {$IfDef vcmNeedL3}
  ,
  l3InterfacedComponent
  {$EndIf vcmNeedL3}
  ;

type
  TvcmComponent = class({$IfDef vcmNeedL3}
                        Tl3InterfacedComponent
                        {$Else  vcmNeedL3}
                        TComponent
                        {$EndIf vcmNeedL3}
                        )
    protected
    // internal methods
      class function IsCacheable: Boolean;
        {$IfDef vcmNeedL3}
        override;
        {$Else  vcmNeedL3}
        virtual;
        {$EndIf vcmNeedL3}
        {-}
    {$IfNDef vcmNeedL3}
      procedure Cleanup;
        virtual;
        {-}
      procedure Release;
        virtual;
        {-}
    public
    // public methods
      destructor Destroy;
        override;
        {-}    
    {$EndIf  vcmNeedL3}
  end;//TvcmComponent

implementation

// start class TvcmComponent

class function TvcmComponent.IsCacheable: Boolean;
  {$IfDef vcmNeedL3}
  //override;
  {$Else  vcmNeedL3}
  //virtual;
  {$EndIf vcmNeedL3}
  {-}
begin
 Result := true;
end;

{$IfNDef vcmNeedL3}
destructor TvcmComponent.Destroy;
  //override;
  {-}
begin
 Release;
 inherited;
end;

procedure TvcmComponent.Cleanup;
  //virtual;
  {-}
begin
end;

procedure TvcmComponent.Release;
  //virtual;
  {-}
begin
 Cleanup;
end;

{$EndIf  vcmNeedL3}

end.

