unit vcmLocalInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , vcmUserControls
;

type
 IvcmFormSetDataSourceListener = interface(Il3Notify)
  {* Слушатель событий бизнес объекта сборки }
  procedure DataChanged;
   {* данные изменились }
 end;//IvcmFormSetDataSourceListener
 
 IvcmDock = interface
  {* интерфейс поддерживаемый dock-ом toolbar-ов }
 end;//IvcmDock
 
implementation

uses
 l3ImplUses
;

end.
