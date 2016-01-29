unit TB97ExtInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "tb97"
// Модуль: "w:/common/components/rtl/external/tb97/TB97ExtInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::tb97::TB97ExtInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\tb97\TB97VER.INC}

interface

{$If not defined(NoTB97)}
type
 ITB97Ctrl = interface(IUnknown)
  {* интерфейс поддерживаемый по необходимости компонентами размещенными на toolbar-е }
   ['{239FBDAE-69C9-4CC1-A677-638DBAFFC648}']
   procedure DoFitToWidth(aWidth: Integer);
   procedure DoUnFitToWidth(aWidth: Integer);
   procedure Expand;
     {* Сигнатура метода Expand }
   function Get_FullWidth: Integer;
   function Get_IsSizeable: Boolean;
   function Get_MinWidth: Integer;
   property FullWidth: Integer
     read Get_FullWidth;
     {* обычный размер компонента, для вычисления и размещения компонентов }
   property IsSizeable: Boolean
     read Get_IsSizeable;
     {* компонент может изменять размеры }
   property MinWidth: Integer
     read Get_MinWidth;
     {* минимальный размер до которого может сжиматься компонент }
 end;//ITB97Ctrl
{$IfEnd} //not NoTB97

implementation

end.