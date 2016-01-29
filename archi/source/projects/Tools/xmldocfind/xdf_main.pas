unit xdf_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, ComCtrls;

type
  TMainForm = class(TForm)
    feXMLFile: TFilenameEdit;
    btnDo: TButton;
    ProgressBar: TProgressBar;
    procedure btnDoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 ddUtils,
 ddMailTools,

 l3Base,

 dt_Types,
 dt_Const,
 dt_Doc,
 dt_Sab,
 dt_Query,
 dt_SrchQueries,
 dt_LinkServ,
 Dt_ReNum,

 JclStreams,
 JclSimpleXML;
{$R *.dfm}

procedure TMainForm.btnDoClick(Sender: TObject);
var
 I, J: Integer;
 l_BakFileName: string;
 l_DocIDStr: string;
 l_Elem: TJclSimpleXMLElem;
 l_ID: TDocID;
 l_Idx: Integer;
 l_Prop, l_GarProp: TJclSimpleXMLProp;
 l_XML: TJclSimpleXML;
 l_Q : TdtQuery;
 l_Res: ISabCursor;
 l_XMLIsUpdated: Boolean;
begin
 if FileExists(feXMLFile.FileName) then
 begin
  Screen.Cursor := crHourGlass;
  btnDo.Enabled := False;
  ProgressBar.Visible := True;
  ProgressBar.Position := 0;
  l_XMLIsUpdated := False;
  try
   l3System.Msg2Log('Обработка файла %s', [feXMLFile.FileName]);
   l_XML := TJclSimpleXML.Create;
   try
    l_XML.LoadFromFile(feXMLFile.FileName);
    if l_XML.Root.Name = 'list' then
    begin
     ProgressBar.Max := l_XML.Root.Items.Count;
     for I := 0 to l_XML.Root.Items.Count - 1 do
     begin
      l_Elem := l_XML.Root.Items[I];
      if l_Elem.Name = 'material' then
      begin
       l_GarProp := l_Elem.Properties.ItemNamed['garant'];
       if (l_GarProp <> nil) and (l_GarProp.Value = '') then
       begin
        l_Prop := l_Elem.Properties.ItemNamed['full_title'];
        if l_Prop <> nil then
        begin
         l_Q := SQText2Query(l_Prop.Value);
         try
          if (l_Q <> nil) and (l_Q.FoundList.Count > 0) then
          begin
           l_Res := l_Q.FoundList.MakeSabCursor([fId_Fld]);
           try
            if l_Res.Count = 1 then
            begin
             l_ID := PDocID(l_Res.GetItem(0))^;
             l_ID := LinkServer(CurrentFamily).Renum.GetExtDocID(l_ID);
             l_GarProp.IntValue := l_ID;
             l_XMLIsUpdated := True;
            end
            else
            begin
             if l_Res.Count <= 5 then
             begin
              l_DocIDStr := '';
              for J := 0 to l_Res.Count - 1 do
              begin
               l_ID := PDocID(l_Res.GetItem(J))^;
               l_ID := LinkServer(CurrentFamily).Renum.GetExtDocID(l_ID);
               if J > 0 then
                l_DocIDStr := l_DocIDStr + ', ';
               l_DocIDStr := l_DocIDStr + IntToStr(l_ID);
              end;
              l3System.Msg2Log('"%s": документы %s', [l_Prop.Value, l_DocIDStr]);
             end
             else
              l3System.Msg2Log('"%s": %s', [l_Prop.Value, NumSuffix(l_Res.Count, 'документ', 'документа', 'документов')]);
            end;
           finally
            l_Res := nil;
           end;
          end
          else
           l3System.Msg2Log('"%s": не найдено ни одного документа', [l_Prop.Value]);
         finally
          FreeAndNil(l_Q);
         end;
        end;
       end;
      end
      else
       l3System.Msg2Log('Невалидное имя элемента: %s', [l_Elem.Name]);
      ProgressBar.Position := I;
      Application.ProcessMessages;
     end;
    end
    else
     l3System.Msg2Log('Неверный формат XML');
    if l_XMLIsUpdated then
    begin
     l_BakFileName := ChangeFileExt(feXMLFile.FileName, '.bak');
     DeleteFile(l_BakFileName);
     RenameFile(feXMLFile.FileName, l_BakFileName);
     l_XML.Options := [sxoAutoIndent, sxoAutoEncodeEntity];
     l_XML.SaveToFile(feXMLFile.FileName);
    end;
   finally
    FreeAndNil(l_XML);
   end;
  finally
   Screen.Cursor := crDefault;
   btnDo.Enabled := True;
  end;
 end
 else
  MessageDlg('Файл не найден.', mtError, [mbOK], 0);
end;

end.
