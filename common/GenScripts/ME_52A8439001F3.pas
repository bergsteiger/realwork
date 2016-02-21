unit TB97ExtInterfaces;

// Модуль: "w:\common\components\rtl\external\tb97\TB97ExtInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\external\tb97\TB97VER.INC}

interface

{$If NOT Defined(NoTB97)}
uses
 l3IntfUses
;

type
 ITB97Ctrl = interface
  {* интерфейс поддерживаемый по необходимости компонентами размещенными на toolbar-е }
  ['{239FBDAE-69C9-4CC1-A677-638DBAFFC648}']
  function Get_FullWidth: Integer;
  function Get_IsSizeable: Boolean;
  function Get_MinWidth: Integer;
  procedure DoFitToWidth(aWidth: Integer);
  procedure DoUnFitToWidth(aWidth: Integer);
  procedure Expand;
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
{$IfEnd} // NOT Defined(NoTB97)

implementation

{$If NOT Defined(NoTB97)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoTB97)

end.
