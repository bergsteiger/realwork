unit hcQueryBuilder;

// Библиотека : Тестовый слой;
// Автор      : Морозов М.А.
// Описание   : Реализации построителей запросов к серверу консультаций;
// Версия     : $Id: hcQueryBuilder.pas,v 1.2 2008/03/03 06:56:32 mmorozov Exp $

{-------------------------------------------------------------------------------
  $Log: hcQueryBuilder.pas,v $
  Revision 1.2  2008/03/03 06:56:32  mmorozov
  - new: открывать форму запросов к серверу консультаций можно даже если в журнале не выбрано ни одной консультации, переименованы органы управления, область редактора запросов можно изменять;

  Revision 1.1  2008/02/27 06:10:49  mmorozov
  - new: и всё таки выделены построители запросов к серверу консультаций (CQ: OIT5-28426);

-------------------------------------------------------------------------------}

interface

uses
  Classes,

  l3Base,

  hcInterfaces
  ;

type
  ThcQueryBuilder = class(Tl3Base, IhcQueryBuilder)
  private
  // fields
    f_QueryXML  : String;
    f_AnswerXML : String;
    f_Manager   : IhcManager;
  protected
  // methods
    function pm_GetQueryXML: String;
      {* - запрос к серверу консультаций. }
    function pm_GetAnswerXML: String;
      {* - ответ от сервера консультаций. }
    procedure Build(const aQueryId: IhcQueryIdList);
      virtual;
      {* - выполнить запрос к серверу консультаций. }
    procedure AddQueryIdToXML(const aQueryId : IhcQueryIdList;
                              const aList    : TStrings);
      {-}
  protected
  // properties
    property QueryXML: String
      read f_QueryXML
      write f_QueryXML;
      {-}
    property AnswerXML: String
      read f_AnswerXML
      write f_AnswerXML;
      {-}
    property Manager: IhcManager
      read f_Manager;
      {-}
  public
  // methods
    constructor Create(const aManager : IhcManager;
                       const aQueryId : IhcQueryIdList);
      reintroduce;
      {-}
    class function Make(const aManager : IhcManager;
                        const aQueryId : IhcQueryIdList): IhcQueryBuilder;
      {-}
  end;

  ThcStatusQueryBuilder = class(ThcQueryBuilder)
  {* Запрос для получения статусов консультаций. }
  protected
  // methods
    procedure Build(const aQueryId: IhcQueryIdList);
      override;
      {* - выполнить запрос к серверу консультаций. }
  end;

  ThcDeleteQueryBuilder = class(ThcQueryBuilder)
  {* Запрос для удаления консультаций. }
  protected
  // methods
    procedure Build(const aQueryId: IhcQueryIdList);
      override;
      {* - выполнить запрос к серверу консультаций. }
  end;

implementation

uses
  SysUtils,
  Controls,

  hcDeleteQueryOptionsForm
  ;

procedure ThcQueryBuilder.AddQueryIdToXML(const aQueryId : IhcQueryIdList;
                                          const aList    : TStrings);
const
 c_QueryIdFrm = '<query id="%s" version="%s"/>';
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(aQueryId.Count) do
  if aQueryId.Items[l_Index] <> nil then
   with PhcConsultationId(aQueryId.Items[l_Index])^ do
    aList.Add(Format(c_QueryIdFrm, [rQueryId, rVersion]));
end;

{ ThcQueryBuilder }

procedure ThcQueryBuilder.Build(const aQueryId: IhcQueryIdList);
  {* - выполнить запрос к серверу консультаций. }
begin
 AnswerXML := '';
 QueryXML := '';
end;

constructor ThcQueryBuilder.Create(const aManager : IhcManager;
                                   const aQueryId : IhcQueryIdList);
begin
 inherited Create;
 f_Manager := aManager;
 Build(aQueryId);
end;

class function ThcQueryBuilder.Make(const aManager     : IhcManager;
                                    const aQueryId : IhcQueryIdList): IhcQueryBuilder;
var
 l_Class: ThcQueryBuilder;
begin
 l_Class := Create(aManager, aQueryId);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class)
 end;
end;

function ThcQueryBuilder.pm_GetAnswerXML: String;
begin
 Result := AnswerXML;
end;

function ThcQueryBuilder.pm_GetQueryXML: String;
begin
 Result := QueryXML;
end;

{ ThcStatusQueryBuilder }

procedure ThcStatusQueryBuilder.Build(const aQueryId: IhcQueryIdList);
  {* - выполнить запрос к серверу консультаций. }
const
 c_QueryIdFrm = '<query id="%s" version="%s"/>';
var
 l_XML      : TStrings;
 l_FileName : String;
begin
 inherited;
 if (aQueryId <> nil) and (aQueryId.Count <> 0) then
 begin
  l_XML := TStringList.Create;
  try
   l_XML.Add('<?xml version="1.0" encoding="UTF-8" standalone="no" ?>');
   l_XML.Add('<status_list>');
   AddQueryIdToXML(aQueryId, l_XML);
   l_XML.Add('</status_list>');
   l_FileName := ExtractFileDir(ParamStr(0)) + '\' + 'temp.xml';
   l_XML.SaveToFile(l_FileName);
   QueryXML := l_XML.Text;
   AnswerXML := Manager.PrintQueryStatus(l_FileName);
  finally
   FreeAndNil(l_XML);
  end;{try..finally}
 end;//if aQueryId.Count <> 0 then
end;

{ ThcDeleteQueryBuilder }

procedure ThcDeleteQueryBuilder.Build(const aQueryId: IhcQueryIdList);
  {* - выполнить запрос к серверу консультаций. }

  function lp_MakeDeleteOptions(var aValue: Boolean): Boolean;
  var
   l_Options: TfrmDeleteQueryOptions;
  begin
   l_Options := TfrmDeleteQueryOptions.Create(nil);
   try
    if l_Options.ShowModal = mrOk then
    begin
     Result := True;
     aValue := l_Options.ForceDelete;
    end
    else
     Result := False;
   finally
    FreeAndNil(l_Options);
   end;//try..finally
  end;//lp_MakeDeleteOptions
  
var
 l_XML         : TStrings;
 l_FileName    : String;
 l_ForceDelete : Boolean;
begin
 inherited;
 if (aQueryId <> nil) and
    (aQueryId.Count <> 0) and
    lp_MakeDeleteOptions(l_ForceDelete) then
 begin
  l_XML := TStringList.Create;
  try
   l_XML.Add('<?xml version="1.0" encoding="UTF-8" standalone="no" ?>');
   if l_ForceDelete then
    l_XML.Add('<erase force="yes">')
   else
    l_XML.Add('<erase force="no">');
   AddQueryIdToXML(aQueryId, l_XML);
   l_XML.Add('</erase>');
   l_FileName := ExtractFileDir(ParamStr(0)) + '\' + 'temp.xml';
   l_XML.SaveToFile(l_FileName);
   QueryXML := l_XML.Text;
   AnswerXML := Manager.DeleteQuery(l_FileName);
  finally
   FreeAndNil(l_XML);
  end;{try..finally}
 end;//if aQueryId.Count <> 0 then
end;

end.
