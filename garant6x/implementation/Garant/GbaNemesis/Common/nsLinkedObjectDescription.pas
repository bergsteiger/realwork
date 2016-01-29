unit nsLinkedObjectDescription;

{-----------------------------------------------------------------------------
 Название:   nsLinkedObjectDescription
 Автор:      Лукьянец Р. В.
 Назначение: Реализация интерфайса InsLinkedObjectDescription
 Версия:
   $Id: nsLinkedObjectDescription.pas,v 1.2 2009/02/10 18:11:59 lulin Exp $
 История:
   $Log: nsLinkedObjectDescription.pas,v $
   Revision 1.2  2009/02/10 18:11:59  lulin
   - <K>: 133891247. Выделяем интерфейсы работы с документом.

   Revision 1.1  2007/07/11 10:05:35  oman
   - new: Показ информации о графическом объекте - передаем всю
    нужную информацию (cq24711)

-----------------------------------------------------------------------------}

interface

uses
 l3Interfaces,
 l3Types,

 vcmBase,

 DocumentDomainInterfaces
 ;

type 
 TnsLinkedObjectDescription = class(TvcmBase, InsLinkedObjectDescription)
 protected
  // InsLinkedObjectDescription
  function InsLinkedObjectDescription.pm_GetName = Data_pm_GetName;
  function Data_pm_GetName: Il3CString;
    {-}
  function pm_GetShortName: Il3CString;
  function pm_GetID: Long;
 private
  f_Name: Il3CString;
  f_ShortName: Il3CString;
  f_ID: Long;
 protected
  procedure Cleanup;
   override;
    {-}
 public
  constructor Create(const aName: Il3CString;
                     const aShortName: Il3CString;
                     const aID: Long);
   reintroduce;
    {-}
  class function Make(const aName: Il3CString;
                      const aShortName: Il3CString;
                      const aID: Long): InsLinkedObjectDescription;
   reintroduce;
    {-}
 end;

implementation

{ TnsLinkedObjectDescription }

procedure TnsLinkedObjectDescription.Cleanup;
begin
 f_Name := nil;
 f_ShortName := nil;
 f_ID := 0;
 inherited Cleanup;
end;

constructor TnsLinkedObjectDescription.Create(const aName,
  aShortName: Il3CString; const aID: Long);
begin
 inherited Create;
 f_Name := aName;
 f_ShortName := aShortName;
 f_ID := aID;
end;

function TnsLinkedObjectDescription.Data_pm_GetName: Il3CString;
begin
 Result := f_Name;
end;

class function TnsLinkedObjectDescription.Make(const aName,
  aShortName: Il3CString; const aID: Long): InsLinkedObjectDescription;
var
 l_Instance: TnsLinkedObjectDescription;
begin
 l_Instance := Create(aName, aShortName, aID);
 try
  Result := l_Instance;
 finally
  vcmFree(l_Instance);
 end;
end;

function TnsLinkedObjectDescription.pm_GetID: Long;
begin
 Result := f_ID;
end;

function TnsLinkedObjectDescription.pm_GetShortName: Il3CString;
begin
 Result := f_ShortName;
end;

end.
