unit hcQueryIdList;

// Библиотека : Тестовый слой;
// Автор      : Морозов М.А.
// Описание   : Список идентификаторов запросов;
// Версия     : $Id: hcQueryIdList.pas,v 1.1 2008/02/26 13:15:46 mmorozov Exp $

{-------------------------------------------------------------------------------
  $Log: hcQueryIdList.pas,v $
  Revision 1.1  2008/02/26 13:15:46  mmorozov
  - new: реализация удаления запросов (CQ: OIT5-28426);

-------------------------------------------------------------------------------}

interface

uses
  Classes,

  l3DataPtrList,

  hcInterfaces
  ;

type
  ThcQueryIdList = class(Tl3DataPtrList, IhcQueryIdList)
  private
  // IhcQueryIdList
    function pm_GetItems(aIndex: Integer): PhcConsultationId;
      {-}
    function pm_GetCount: Integer;
      {-}
    procedure AddQuery(const aQuery: IhcQuery);
      overload;
      {* - добавить идентификатор консультации. }
    procedure AddQuery(const aId      : String;
                       const aVersion : String);
      overload;
      {* - добавить идентификатор консультации. }
  public
  // methods
    procedure Clear;
      override;
      {-}
    class function Make: IhcQueryIdList;
      {-}
  end;//ThcQueryIdList

implementation

uses
  SysUtils,
  
  hcUtils
  ;

{ ThcQueryIdList }

procedure ThcQueryIdList.AddQuery(const aId      : String;
                                  const aVersion : String);
var
 l_Id: PhcConsultationId;
begin
 New(l_Id);
 FillChar(l_Id^, SizeOf(ThcConsultationId), 0);
 with l_Id^ do
 begin
  rVersion := aVersion;
  rQueryId := aId;
 end;
 Add(l_Id);
end;

procedure ThcQueryIdList.AddQuery(const aQuery: IhcQuery);
  {* - добавить идентификатор консультации. }
var
 l_Id: PhcConsultationId;
begin
 New(l_Id);
 hcCopyConsultationId(aQuery.Id, l_Id^);
 Add(l_Id);
end;

procedure ThcQueryIdList.Clear;
var
 l_Index : Integer;
 l_Id    : PhcConsultationId;
begin
 for l_Index := 0 to Pred(Count) do
 begin
  l_id := Items[l_Index];
  Dispose(l_Id);
  Items[l_Index] := nil;
 end;//for l_Index := 0 to Pred(Count) do
 inherited;
end;

class function ThcQueryIdList.Make: IhcQueryIdList;
var
 l_Class: ThcQueryIdList;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

function ThcQueryIdList.pm_GetCount: Integer;
begin
 Result := Count;
end;

function ThcQueryIdList.pm_GetItems(aIndex: Integer): PhcConsultationId;
begin
 Result := Items[aIndex];
end;

end.
