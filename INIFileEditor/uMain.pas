unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IOUtils,
  System.Net.HttpClient,
  System.Net.URLClient,
  System.NetEncoding,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Mask,
  IniFiles,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Comp.Client;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    tsProgram: TTabSheet;
    edPassword: TEdit;
    edDepartment: TEdit;
    edMachine: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edTimer: TEdit;
    edLogFolder: TEdit;
    lblDatabase: TLabel;
    edDatabase: TEdit;
    edUser: TEdit;
    lblUser: TLabel;
    lblPassword: TLabel;
    lblDepartment: TLabel;
    lblMachine: TLabel;
    cbOnlyTest: TCheckBox;
    btnSelectFolder: TBitBtn;
    btnTestDB: TButton;
    TabSheet1: TTabSheet;
    lblBaseURL: TLabel;
    edBCBaseURL: TEdit;
    edBCPOrt: TEdit;
    lblPort: TLabel;
    edBCCompanyURL: TEdit;
    lblTenant: TLabel;
    edBCUser: TEdit;
    lblClientID: TLabel;
    edBCPassword: TEdit;
    lblClientPassword: TLabel;
    edBCActiveCompany: TEdit;
    lblActiveCompany: TLabel;
    TabSheet2: TTabSheet;
    edMailSenderName: TEdit;
    lblFromName: TLabel;
    lblRecipientMail: TLabel;
    lblSubject: TLabel;
    lblHost: TLabel;
    lblPort2: TLabel;
    lblUsername: TLabel;
    lblFromMail: TLabel;
    lblReplyToName: TLabel;
    lblReplyToMail: TLabel;
    lblMailPassword: TLabel;
    edMailSenderMail: TEdit;
    edMailReplyToName: TEdit;
    edMailReplyToMail: TEdit;
    edMailReciever: TEdit;
    edMailSubject: TEdit;
    edMailSMTPHost: TEdit;
    edMailSMTPPort: TEdit;
    edMailSMTPUSername: TEdit;
    edMailSMTPPassword: TEdit;
    TabSheet3: TTabSheet;
    cbSyncItems: TCheckBox;
    cbSyncFinancialRecords: TCheckBox;
    cbSyncSalesTrans: TCheckBox;
    cbSyncMovements: TCheckBox;
    tsItems: TTabSheet;
    lblItemsDays: TLabel;
    edItemsDAys: TEdit;
    lblItemsLastRun: TLabel;
    edItemsLastRun: TEdit;
    lblItemsDepartment: TLabel;
    edItemsDeparetment: TEdit;
    lblItemsLastTry: TLabel;
    edItemsLastTry: TEdit;
    TabSheet4: TTabSheet;
    lblFinDays: TLabel;
    edFinancialRecordsDAys: TEdit;
    lblFinLastRun: TLabel;
    edFinancialRecordsLastRun: TEdit;
    lblFinLastTry: TLabel;
    edFinancialRecordsLastTry: TEdit;
    tsGeneralLog: TTabSheet;
    mmoLog: TMemo;
    lbLogFiles: TListBox;
    TabSheet5: TTabSheet;
    lbBCLogFiles: TListBox;
    mmoBCLogs: TMemo;
    TabSheet6: TTabSheet;
    lbFinansLogFiles: TListBox;
    mmoFinansLog: TMemo;
    lblLastruntime: TLabel;
    cbUseTLS: TCheckBox;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    lblSalesDays: TLabel;
    edSalesTransactionsDays: TEdit;
    edSalesTransactionsLastRun: TEdit;
    edSalesTransactionsLastTry: TEdit;
    lblSalesLastTry: TLabel;
    lblSalesLastRun: TLabel;
    lblMovDays: TLabel;
    edMovementsTransactionsDays: TEdit;
    edMovementTransactionsLastRun: TEdit;
    edMovementTransactionsLastTry: TEdit;
    lblMovLastTry: TLabel;
    lblMovLastRun: TLabel;
    lblStockDays: TLabel;
    edStockRegulationTransactionsDays: TEdit;
    edStockRegulationTransactionsLastRun: TEdit;
    edStockRegulationTransactionsLastTry: TEdit;
    lblStockLastTry: TLabel;
    lblStockLastRun: TLabel;
    cbSyncStockRegulations: TCheckBox;
    cbHvertMinut: TCheckBox;
    edEnvironment: TEdit;
    lblEnvironment: TLabel;
    cbSyncCostpriceToEasyPOS: TCheckBox;
    TabSheet10: TTabSheet;
    lblCostpriceItems: TLabel;
    edNumberofUtemsToUpdateCostprice: TEdit;
    edBusinessCentralKunde: TEdit;
    lblCustomer: TLabel;
    btnTestBC: TButton;
    edBCFullURL: TEdit;
    lblBCFullURL: TLabel;
    btnParseURL: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectFolderClick(Sender: TObject);
    procedure btnTestDBClick(Sender: TObject);
    procedure btnTestBCClick(Sender: TObject);
    procedure btnParseURLClick(Sender: TObject);
    procedure tsGeneralLogShow(Sender: TObject);
    procedure lbLogFilesClick(Sender: TObject);
    procedure TabSheet5Show(Sender: TObject);
    procedure lbBCLogFilesClick(Sender: TObject);
    procedure TabSheet6Show(Sender: TObject);
    procedure lbFinansLogFilesClick(Sender: TObject);
  private
    FiniFile: TIniFile;
    FiniFileName: string;
    procedure ReadSettingsFromINIFile;
    procedure WriteSettingsFromINIFile;
  public
    property iniFile: TIniFile read FiniFile write FiniFile;
    property iniFileName: string read FiniFileName write FiniFileName;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


procedure TfrmMain.btnSelectFolderClick(Sender: TObject);
var
  Dlg: TFileOpenDialog;
begin
  Dlg := TFileOpenDialog.Create(Self);
  try
    Dlg.Title := 'Select folder for log files';
    Dlg.Options := [fdoPickFolders, fdoPathMustExist];
    if edLogFolder.Text <> '' then
      Dlg.DefaultFolder := edLogFolder.Text;
    if Dlg.Execute then
      edLogFolder.Text := Dlg.FileName + '\';
  finally
    Dlg.Free;
  end;
end;

procedure TfrmMain.btnTestDBClick(Sender: TObject);
var
  Conn: TFDConnection;
  lServer, lDatabase: string;
  lConnStr: string;
begin
  lConnStr := edDatabase.Text;
  if lConnStr = '' then
  begin
    ShowMessage('Database connection string is empty.');
    Exit;
  end;

  if Pos(':', lConnStr) = 0 then
  begin
    ShowMessage('Invalid format. Expected: server:path_to_database');
    Exit;
  end;

  lServer := Copy(lConnStr, 1, Pos(':', lConnStr) - 1);
  lDatabase := Copy(lConnStr, Pos(':', lConnStr) + 1, Length(lConnStr));

  Conn := TFDConnection.Create(nil);
  try
    Screen.Cursor := crHourGlass;
    try
      Conn.Params.Clear;
      Conn.Params.Add('DriverID=FB');
      Conn.Params.Add('Server=' + lServer);
      Conn.Params.Add('Database=' + lDatabase);
      Conn.Params.Add('User_Name=' + edUser.Text);
      Conn.Params.Add('Password=' + edPassword.Text);
      Conn.LoginPrompt := False;
      Conn.Open;
      Conn.Close;
      ShowMessage('Database connection OK!');
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on E: Exception do
      ShowMessage('Database connection FAILED:'#13#10#13#10 + E.Message);
  end;
  Conn.Free;
end;

procedure TfrmMain.btnTestBCClick(Sender: TObject);
var
  Http: THTTPClient;
  Response: IHTTPResponse;
  URL: string;
  lPort: Integer;
begin
  if edBCBaseURL.Text = '' then
  begin
    ShowMessage('Business Central Base URL is empty.');
    Exit;
  end;

  URL := edBCBaseURL.Text;
  if not URL.EndsWith('/') then
    URL := URL + '/';

  lPort := StrToIntDef(edBCPOrt.Text, 0);
  if lPort > 0 then
    URL := URL + ':' + IntToStr(lPort) + '/';

  if edBCCompanyURL.Text <> '' then
    URL := URL + edBCCompanyURL.Text;

  Http := THTTPClient.Create;
  try
    Screen.Cursor := crHourGlass;
    try
      Http.ConnectionTimeout := 10000;
      Http.ResponseTimeout := 15000;

      if (edBCUser.Text <> '') and (edBCPassword.Text <> '') then
        Http.CustomHeaders['Authorization'] := 'Basic ' +
          TNetEncoding.Base64.Encode(edBCUser.Text + ':' + edBCPassword.Text);

      Response := Http.Get(URL);

      if (Response.StatusCode = 200) or (Response.StatusCode = 401) or (Response.StatusCode = 403) then
        ShowMessage('Business Central connection OK!' + #13#10 +
          'Status: ' + IntToStr(Response.StatusCode) + ' ' + Response.StatusText + #13#10 +
          'URL: ' + URL)
      else
        ShowMessage('Business Central responded with:' + #13#10 +
          'Status: ' + IntToStr(Response.StatusCode) + ' ' + Response.StatusText + #13#10 +
          'URL: ' + URL);
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on E: Exception do
      ShowMessage('Business Central connection FAILED:'#13#10#13#10 +
        E.Message + #13#10#13#10 + 'URL: ' + URL);
  end;
  Http.Free;
end;

procedure TfrmMain.btnParseURLClick(Sender: TObject);
var
  URL, lPath, lPart: string;
  Parts: TArray<string>;
  i: Integer;
  lBaseURL, lTenant, lEnvironment: string;
begin
  URL := Trim(edBCFullURL.Text);
  if URL = '' then
  begin
    ShowMessage('Paste a Business Central URL first.');
    Exit;
  end;

  // Expected format:
  // https://api.businesscentral.dynamics.com/v2.0/{tenant}/{environment}/ODataV4/Company('{name}')/...
  // or variations with /api/... paths

  // Extract base URL (scheme + host)
  if URL.StartsWith('https://') then
    lPath := Copy(URL, 9, Length(URL))
  else if URL.StartsWith('http://') then
    lPath := Copy(URL, 8, Length(URL))
  else
    lPath := URL;

  // Split by /
  Parts := lPath.Split(['/']);
  if Length(Parts) < 2 then
  begin
    ShowMessage('Could not parse URL. Expected format:' + #13#10 +
      'https://api.businesscentral.dynamics.com/v2.0/{tenant}/{environment}/...');
    Exit;
  end;

  // Base URL is the host part
  lBaseURL := 'https://' + Parts[0];

  // Find tenant and environment after v2.0
  lTenant := '';
  lEnvironment := '';
  for i := 1 to High(Parts) do
  begin
    lPart := Parts[i];
    if lPart.StartsWith('v2.0') or lPart.StartsWith('v1.0') then
    begin
      if i + 1 <= High(Parts) then
        lTenant := Parts[i + 1];
      if i + 2 <= High(Parts) then
        lEnvironment := Parts[i + 2];
      Break;
    end;
  end;

  if lTenant = '' then
  begin
    ShowMessage('Could not find tenant ID in URL.');
    Exit;
  end;

  // Apply to fields
  edBCBaseURL.Text := lBaseURL;
  edBCPOrt.Text := '0';
  edBCCompanyURL.Text := lTenant;
  if lEnvironment <> '' then
    edEnvironment.Text := lEnvironment;
  edBusinessCentralKunde.Text := 'NYFORM';

  ShowMessage('URL parsed successfully!' + #13#10 +
    '-----------------------------------' + #13#10 +
    'Fields updated:' + #13#10 +
    '  Base URL: ' + lBaseURL + #13#10 +
    '  Tenant: ' + lTenant + #13#10 +
    '  Environment: ' + lEnvironment + #13#10 +
    '  Port: 0 (not used for cloud)' + #13#10 +
    '  Customer: NYFORM' + #13#10 +
    #13#10 +
    'Still needs manual input:' + #13#10 +
    '  - Client ID (OAuth2 App Registration)' + #13#10 +
    '  - Client Secret (OAuth2 App Registration)' + #13#10 +
    '  - Active Company ID (GUID from BC)');
end;

procedure TfrmMain.ReadSettingsFromINIFile;
begin
  edTimer.Text := IntToStr(FiniFile.ReadInteger('PROGRAM', 'RUNTIME', 60));
  cbHvertMinut.Checked := FiniFile.ReadBool('PROGRAM', 'RUN AT EACH MINUTE', FALSE);
  lblLastruntime.Caption := Format('Routine ran last time at: %s',[FiniFile.ReadString('PROGRAM', 'LAST RUN', '')]);
  edLogFolder.Text := FiniFile.ReadString('PROGRAM', 'LOGFILEFOLDER', '');
  edDatabase.Text := FiniFile.ReadString('PROGRAM', 'DATABASE', '');
  edUser.Text := FiniFile.ReadString('PROGRAM', 'USER', '');
  edPassword.Text := FiniFile.ReadString('PROGRAM', 'PASSWORD', '');
  edDepartment.Text := FiniFile.ReadString('PROGRAM', 'Department', '');
  edMachine.Text := FiniFile.ReadString('PROGRAM', 'Machine', '');
  cbOnlyTest.Checked := FiniFile.ReadBool('PROGRAM', 'TestRoutine', FALSE);

  edBCBaseURL.Text := FiniFile.ReadString('BUSINESS CENTRAL', 'BC_BASEURL', '');
  edBCCompanyURL.Text := FiniFile.ReadString('BUSINESS CENTRAL', 'BC_COMPANY_URL', '');
  edBCUser.Text := FiniFile.ReadString('BUSINESS CENTRAL', 'BC_USERNAME', '');
  edBCPassword.Text := FiniFile.ReadString('BUSINESS CENTRAL', 'BC_PASSWORD', '');
  edBCActiveCompany.Text := FiniFile.ReadString('BUSINESS CENTRAL', 'BC_ACTIVECOMPANYID', '');
  edBCPOrt.Text := FiniFile.ReadString('BUSINESS CENTRAL', 'BC_PORT', '');
  edBusinessCentralKunde.Text := iniFile.ReadString('BUSINESS CENTRAL', 'Online Business Central', '');
  edEnvironment.Text := FiniFile.ReadString('BUSINESS CENTRAL', 'BC_ENVIRONMENT', '');

  edMailSenderName.Text := FiniFile.ReadString('MAIL', 'From name', '');
  edMailSenderMail.Text := FiniFile.ReadString('MAIL', 'From mail', '');
  edMailReplyToName.Text := FiniFile.ReadString('MAIL', 'Reply name', '');
  edMailReplyToMail.Text := FiniFile.ReadString('MAIL', 'Reply mail', '');
  edMailReciever.Text := FiniFile.ReadString('MAIL', 'Recipient Mail', '');
  edMailSubject.Text := FiniFile.ReadString('MAIL', 'Subject', '');
  edMailSMTPHost.Text := FiniFile.ReadString('MAIL', 'Host', '');
  edMailSMTPPort.Text := FiniFile.ReadString('MAIL', 'Port', '');
  cbUseTLS.Checked := FiniFile.ReadBool('MAIL', 'UseTSL', FALSE);
  edMailSMTPUSername.Text := FiniFile.ReadString('MAIL', 'Username', '');
  edMailSMTPPassword.Text := FiniFile.ReadString('MAIL', 'password', '');

  cbSyncFinancialRecords.Checked := FiniFile.ReadBool('SYNCRONIZE', 'FinancialRecords', FALSE);
  cbSyncItems.Checked := FiniFile.ReadBool('SYNCRONIZE', 'Items', FALSE);
  cbSyncSalesTrans.Checked := FiniFile.ReadBool('SYNCRONIZE', 'SalesTransactions', FALSE);
  cbSyncMovements.Checked := FiniFile.ReadBool('SYNCRONIZE', 'MovementsTransactions', FALSE);
  cbSyncStockRegulations.Checked := FiniFile.ReadBool('SYNCRONIZE', 'StockRegulationsTransactions', FALSE);
  cbSyncCostpriceToEasyPOS.Checked := FiniFile.ReadBool('SYNCRONIZE', 'Costprice from BC', FALSE);

  edItemsDAys.Text := FiniFile.ReadString('ITEMS', 'Days to look for records', '5');
  edItemsDeparetment.Text := FiniFile.ReadString('ITEMS', 'Department', '');
  edItemsLastRun.Text := FiniFile.ReadString('ITEMS', 'Last run', '');
  edItemsLastTry.Text := FiniFile.ReadString('ITEMS', 'Last time sync to BC was tried', '');

  edFinancialRecordsDAys.Text := FiniFile.ReadString('FinancialRecords', 'Days to look for records', '5');
  edFinancialRecordsLastRun.Text := FiniFile.ReadString('FinancialRecords', 'Last run', '');
  edFinancialRecordsLastTry.Text := FiniFile.ReadString('FinancialRecords', 'Last time sync to BC was tried', '');

  edSalesTransactionsDays.Text := FiniFile.ReadString('SalesTransaction', 'Days to look for records', '5');
  edSalesTransactionsLastRun.Text := FiniFile.ReadString('SalesTransaction', 'Last run', '');
  edSalesTransactionsLastTry.Text := FiniFile.ReadString('SalesTransaction', 'Last time sync to BC was tried', '');

  edMovementsTransactionsDays.Text := FiniFile.ReadString('MovementsTransaction', 'Days to look for records', '5');
  edMovementTransactionsLastRun.Text := FiniFile.ReadString('MovementsTransaction', 'Last run', '');
  edMovementTransactionsLastTry.Text := FiniFile.ReadString('MovementsTransaction', 'Last time sync to BC was tried', '');

  edStockRegulationTransactionsDays.Text := FiniFile.ReadString('StockRegulation', 'Days to look for records', '5');
  edStockRegulationTransactionsLastRun.Text := FiniFile.ReadString('StockRegulation', 'Last run', '');
  edStockRegulationTransactionsLastTry.Text := FiniFile.ReadString('StockRegulation', 'Last time sync to BC was tried', '');

  edNumberofUtemsToUpdateCostprice.Text := FiniFile.ReadString('Costprice', 'Items to handle per cycle', '50');
end;

procedure TfrmMain.TabSheet5Show(Sender: TObject);
var
  lFilSti: string;
  lFilNavn: string;
  FileAttrs: Integer;
  sr: TSearchRec;
begin
  lbBCLogFiles.Items.Clear;

  lFilSti := edLogFolder.Text + 'BC_Log\';
  // Set log file wildcard
  lFilNavn := lFilSti + 'BusinessCentral*.*';
  FileAttrs := faAnyFile;
  // Find first logfile
  if FindFirst(lFilNavn, FileAttrs, sr) = 0 then
  begin
    lbBCLogFiles.Items.Add(sr.Name);
  end;
  // Find next logfile
  while (FindNext(sr) = 0) do
  begin
    lbBCLogFiles.Items.Add(sr.Name);
  end;
  lbBCLogFiles.ItemIndex := 0;
  mmoBCLogs.Lines.LoadFromFile(lFilSti + lbBCLogFiles.Items[lbBCLogFiles.ItemIndex]);
end;

procedure TfrmMain.TabSheet6Show(Sender: TObject);
var
  lFilSti: string;
  lFilNavn: string;
  FileAttrs: Integer;
  sr: TSearchRec;
begin
  lbBCLogFiles.Items.Clear;

  lFilSti := edLogFolder.Text + 'FinansEksport\';
  // Set log file wildcard
  lFilNavn := lFilSti + 'EkspFinancialRecordsToBC*.*';
  FileAttrs := faAnyFile;
  // Find first logfile
  if FindFirst(lFilNavn, FileAttrs, sr) = 0 then
  begin
    lbFinansLogFiles.Items.Add(sr.Name);
  end;
  // Find next logfile
  while (FindNext(sr) = 0) do
  begin
    lbFinansLogFiles.Items.Add(sr.Name);
  end;
  lbFinansLogFiles.ItemIndex := 0;
  mmoFinansLog.Lines.LoadFromFile(lFilSti + lbFinansLogFiles.Items[lbFinansLogFiles.ItemIndex]);
end;

procedure TfrmMain.tsGeneralLogShow(Sender: TObject);
var
  lFilSti: string;
  lFilNavn: string;
  FileAttrs: Integer;
  sr: TSearchRec;
begin
  lbLogFiles.Items.Clear;

  lFilSti := edLogFolder.Text;
  // Set log file wildcard
  lFilNavn := lFilSti + 'Log*.*';
  FileAttrs := faAnyFile;
  // Find first logfile
  if FindFirst(lFilNavn, FileAttrs, sr) = 0 then
  begin
    lbLogFiles.Items.Add(sr.Name);
  end;
  // Find next logfile
  while (FindNext(sr) = 0) do
  begin
    lbLogFiles.Items.Add(sr.Name);
  end;

  // Set log file wildcard
  lFilNavn := lFilSti + 'Err*.*';
  FileAttrs := faAnyFile;
  // Find first logfile
  if FindFirst(lFilNavn, FileAttrs, sr) = 0 then
  begin
    lbLogFiles.Items.Add(sr.Name);
  end;
  // Find next logfile
  while (FindNext(sr) = 0) do
  begin
    lbLogFiles.Items.Add(sr.Name);
  end;

  lbLogFiles.ItemIndex := 0;
  mmoLog.Lines.LoadFromFile(lFilSti + lbLogFiles.Items[lbLogFiles.ItemIndex]);
end;

procedure TfrmMain.WriteSettingsFromINIFile;
begin
  FiniFile.WriteInteger('PROGRAM', 'RUNTIME', StrToInt(edTimer.Text));
  FiniFile.WriteBool('PROGRAM', 'RUN AT EACH MINUTE', cbHvertMinut.Checked);
  FiniFile.WriteString('PROGRAM', 'LOGFILEFOLDER', edLogFolder.Text);
  FiniFile.WriteString('PROGRAM', 'DATABASE', edDatabase.Text);
  FiniFile.WriteString('PROGRAM', 'USER', edUser.Text);
  FiniFile.WriteString('PROGRAM', 'PASSWORD', edPassword.Text);
  FiniFile.WriteString('PROGRAM', 'Department', edDepartment.Text);
  FiniFile.WriteString('PROGRAM', 'Machine', edMachine.Text);
  FiniFile.WriteBool('PROGRAM', 'TestRoutine', cbOnlyTest.Checked);

  FiniFile.WriteString('BUSINESS CENTRAL', 'BC_BASEURL', edBCBaseURL.Text);
  FiniFile.WriteString('BUSINESS CENTRAL', 'BC_COMPANY_URL', edBCCompanyURL.Text);
  FiniFile.WriteString('BUSINESS CENTRAL', 'BC_USERNAME', edBCUser.Text);
  FiniFile.WriteString('BUSINESS CENTRAL', 'BC_PASSWORD', edBCPassword.Text);
  FiniFile.WriteString('BUSINESS CENTRAL', 'BC_ACTIVECOMPANYID', edBCActiveCompany.Text);
  FiniFile.WriteString('BUSINESS CENTRAL', 'BC_ENVIRONMENT', edEnvironment.Text);
  FiniFile.WriteInteger('BUSINESS CENTRAL', 'BC_PORT', StrToIntDef(edBCPOrt.Text, 0));
  FiniFile.WriteString('BUSINESS CENTRAL', 'Online Business Central', edBusinessCentralKunde.Text);


  FiniFile.WriteString('MAIL', 'From name', edMailSenderName.Text);
  FiniFile.WriteString('MAIL', 'From mail', edMailSenderMail.Text);
  FiniFile.WriteString('MAIL', 'Reply name', edMailReplyToName.Text);
  FiniFile.WriteString('MAIL', 'Reply mail', edMailReplyToMail.Text);
  FiniFile.WriteString('MAIL', 'Recipient Mail', edMailReciever.Text);
  FiniFile.WriteString('MAIL', 'Subject', edMailSubject.Text);
  FiniFile.WriteString('MAIL', 'Host', edMailSMTPHost.Text);
  FiniFile.WriteInteger('MAIL', 'Port', StrToIntDef(edMailSMTPPort.Text, 0));
  FiniFile.WriteBool('MAIL', 'UseTSL', cbUseTLS.Checked);

  FiniFile.WriteString('MAIL', 'Username', edMailSMTPUSername.Text);
  FiniFile.WriteString('MAIL', 'password', edMailSMTPPassword.Text);

  FiniFile.WriteBool('SYNCRONIZE', 'FinancialRecords', cbSyncFinancialRecords.Checked);
  FiniFile.WriteBool('SYNCRONIZE', 'Items', cbSyncItems.Checked);
  FiniFile.WriteBool('SYNCRONIZE', 'SalesTransactions', cbSyncSalesTrans.Checked);
  FiniFile.WriteBool('SYNCRONIZE', 'MovementsTransactions', cbSyncMovements.Checked);
  FiniFile.WriteBool('SYNCRONIZE', 'StockRegulationsTransactions', cbSyncStockRegulations.Checked);
  FiniFile.WriteBool('SYNCRONIZE', 'Costprice from BC', cbSyncCostpriceToEasyPOS.Checked);

  FiniFile.WriteString('ITEMS', 'Days to look for records', edItemsDAys.Text);
  FiniFile.WriteString('ITEMS', 'Department', edItemsDeparetment.Text);
  FiniFile.WriteString('ITEMS', 'Last run', edItemsLastRun.Text);
  FiniFile.WriteString('ITEMS', 'Last time sync to BC was tried', edItemsLastTry.Text);

  FiniFile.WriteString('FinancialRecords', 'Days to look for records', edFinancialRecordsDAys.Text);
  FiniFile.WriteString('FinancialRecords', 'Last run', edFinancialRecordsLastRun.Text);
  FiniFile.WriteString('FinancialRecords', 'Last time sync to BC was tried', edFinancialRecordsLastTry.Text);

  FiniFile.WriteString('SalesTransaction', 'Days to look for records', edSalesTransactionsDays.Text);
  FiniFile.WriteString('SalesTransaction', 'Last run', edSalesTransactionsLastRun.Text);
  FiniFile.WriteString('SalesTransaction', 'Last time sync to BC was tried', edSalesTransactionsLastTry.Text);

  FiniFile.WriteString('MovementsTransaction', 'Days to look for records', edMovementsTransactionsDays.Text);
  FiniFile.WriteString('MovementsTransaction', 'Last run', edMovementTransactionsLastRun.Text);
  FiniFile.WriteString('MovementsTransaction', 'Last time sync to BC was tried', edMovementTransactionsLastTry.Text);

  FiniFile.WriteString('StockRegulation', 'Days to look for records', edStockRegulationTransactionsDays.Text);
  FiniFile.WriteString('StockRegulation', 'Last run', edStockRegulationTransactionsLastRun.Text);
  FiniFile.WriteString('StockRegulation', 'Last time sync to BC was tried', edStockRegulationTransactionsLastTry.Text);

  FiniFile.WriteString('Costprice', 'Items to handle per cycle', edNumberofUtemsToUpdateCostprice.Text);

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  lSourceFile: string;
  lDestinationFile: string;
begin
  lSourceFile := ExtractFilePath(Application.ExeName) + '\' + FiniFileName;
  lDestinationFile := ExtractFilePath(Application.ExeName) + '\' + TPath.GetFileNameWithoutExtension(FiniFileName) + '.BAK';
  TFile.Copy(lSourceFile, lDestinationFile, true);
  WriteSettingsFromINIFile;
  FiniFile.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FiniFileName := 'Settings.ini';
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  lFileName: string;
begin
  lFileName := ExtractFilePath(Application.ExeName) + '\' + FiniFileName;
  if FileExists(lFileName) then
  begin
    FiniFile := TINIFile.Create(lFileName);
    ReadSettingsFromINIFile;
  end
  else
  begin
    ShowMessage('INI fil (settings.ini) ikke fundet.');
  end;
end;

procedure TfrmMain.lbBCLogFilesClick(Sender: TObject);
begin
  mmoBCLogs.Lines.LoadFromFile(edLogFolder.Text + 'BC_Log\' + lbBCLogFiles.Items[lbBCLogFiles.ItemIndex]);
end;

procedure TfrmMain.lbFinansLogFilesClick(Sender: TObject);
begin
  mmoFinansLog.Lines.LoadFromFile(edLogFolder.Text + 'FinansEksport\' + lbFinansLogFiles.Items[lbFinansLogFiles.ItemIndex]);
end;

procedure TfrmMain.lbLogFilesClick(Sender: TObject);
begin
  mmoLog.Lines.LoadFromFile(edLogFolder.Text + lbLogFiles.Items[lbLogFiles.ItemIndex]);
end;

end.
