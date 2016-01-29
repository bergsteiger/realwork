unit WebModule;

interface

uses
  Windows, SysUtils, HTTPApp, DB, ADODB, Classes;

type
  TWebModule1 = class(TWebModule)
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    ADOTable1sl_no: TAutoIncField;
    ADOTable1name: TWideStringField;
    ADOTable1company: TWideStringField;
    ADOTable1email_id: TWideStringField;
    ADOTable1gender: TWideStringField;
    ADOTable1country: TWideStringField;
    ADOTable1profession: TWideStringField;
    ADOTable1subscribe: TBooleanField;
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  end;

var
  WebModule1: TWebModule1;

implementation

{$R *.DFM}

uses
  StrUtils, ExtCtrls;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  HtmlResult: string;
begin
  try
    try
      // Open database table and connections
      ADOTable1.Open;
      ADOTable1.Append;

      with Request.ContentFields do
      begin
        // Fill database table with data from the request.
        ADOTable1name.AsString := Values['name'];
        ADOTable1company.AsString := Values['company'];
        ADOTable1email_id.AsString := Values['email_id'];
        ADOTable1gender.AsString := Values['gender'];
        ADOTable1country.AsString := Values['country'];
        ADOTable1profession.AsString := Values['profession'];
        ADOTable1subscribe.Value := (Values['subscribe'] = 'Yes');

        // Create the HTML for response.
        HtmlResult := '<html><head>' +
          '<title>Form Submit Demo</title>' +
          '</head><body>' +
          '<h1><center>Form Submit Demo</center></h1><br>' +
          '<p><h3>The database has been updated with the following data:</h3></p>' +
          '<Table Width="50%" CellSpacing=1 CellPadding=5 Border=1>' +
          '<TR><TD BgColor="Silver"><b>Name:</b></TD><TD><b>' + Values['name'] + '</b></TD>' +
          '<TR><TD BgColor="Silver"><b>Company:</b></TD><TD><b>' + Values['company'] + '</b></TD>' +
          '<TR><TD BgColor="Silver"><b>Email ID:</b></TD><TD><b>' + Values['email_id'] + '</b></TD>' +
          '<TR><TD BgColor="Silver"><b>Gender:</b></TD><TD><b>' + Values['gender'] + '</b></TD>' +
          '<TR><TD BgColor="Silver"><b>Country:</b></TD><TD><b>' + Values['country'] + '</b></TD>' +
          '<TR><TD BgColor="Silver"><b>Profession:</b></TD><TD><b>' + Values['profession'] + '</b></TD>' +
          '<TR><TD BgColor="Silver"><b>Subscribe:</b></TD><TD><b>' + IfThen(Values['subscribe']='', 'No', 'Yes') + '</b></TD>' +
          '</body></html>';
      end;

      // Close connections.
      ADOTable1.Post;
    except
      HtmlResult := '<html><head>' +
        '<title>Form Submit Demo - Error</title>' +
        '</head><body>' +
        '<h1><center>Form Submit Demo</center></h1><br>' +
        '<h2>Error occured while connecting to database!</h2>' +
        '</body></head>';
    end;
  finally
    ADOTable1.Close;
    ADOConnection1.Close;
  end;

  // Set the response to HtmlResult.
  Response.Content := HtmlResult;
end;

end.
