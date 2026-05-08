unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IOUtils,
  System.Diagnostics,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Mask,
  IniFiles,
  uBusinessCentralIntegration,
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
    lblBCTestStatus: TLabel;
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
    procedure WriteLog(const AMessage: string);
    function TestEndpointResult(const AName: string; ASuccess: Boolean;
      AResponse: TBusinessCentral_Response; AElapsedMs: Int64): string;
    procedure SetTestStatus(const AText: string);
    procedure SetUIEnabled(AEnabled: Boolean);
  public
    property iniFile: TIniFile read FiniFile write FiniFile;
    property iniFileName: string read FiniFileName write FiniFileName;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.WriteLog(const AMessage: string);
var
  LogFile: string;
  F: TextFile;
begin
  LogFile := ExtractFilePath(Application.ExeName) + 'Editor.log';
  AssignFile(F, LogFile);
  if FileExists(LogFile) then
    Append(F)
  else
    Rewrite(F);
  try
    WriteLn(F, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '  ' + AMessage);
  finally
    CloseFile(F);
  end;
end;

function TfrmMain.TestEndpointResult(const AName: string; ASuccess: Boolean;
  AResponse: TBusinessCentral_Response; AElapsedMs: Int64): string;
var
  lStatus: string;
begin
  if ASuccess then
  begin
    lStatus := 'OK (200)';
    WriteLog('    ' + AName + ': OK (' + IntToStr(AElapsedMs) + ' ms)');
  end
  else
  begin
    if (AResponse <> nil) and (AResponse is TBusinessCentral_ErrorResponse) then
      lStatus := IntToStr((AResponse as TBusinessCentral_ErrorResponse).StatusCode) +
        ' ' + (AResponse as TBusinessCentral_ErrorResponse).StatusText
    else
      lStatus := 'FAILED (unknown)';
    WriteLog('    ' + AName + ': ' + lStatus + ' (' + IntToStr(AElapsedMs) + ' ms)');
  end;
  Result := '  ' + AName + ': ' + lStatus + ' (' + IntToStr(AElapsedMs) + ' ms)' + #13#10;
end;

procedure TfrmMain.SetTestStatus(const AText: string);
begin
  lblBCTestStatus.Caption := AText;
  Application.ProcessMessages;
end;

procedure TfrmMain.SetUIEnabled(AEnabled: Boolean);
var
  i: Integer;
begin
  // Enable/disable all controls on the BC tab except the status label
  for i := 0 to PageControl1.ActivePage.ControlCount - 1 do
  begin
    if PageControl1.ActivePage.Controls[i] = lblBCTestStatus then
      Continue;
    PageControl1.ActivePage.Controls[i].Enabled := AEnabled;
  end;
  // Also disable tab switching
  PageControl1.Enabled := AEnabled;
  Application.ProcessMessages;
end;


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
  lBusinessCentralSetup: TBusinessCentralSetup;
  lBusinessCentral: TBusinessCentral;
  lResponse: TBusinessCentral_Response;
  lKind: Integer;
  lPort: string;
  lBaseURL: string;
  lContent: string;
  lEndpointResult: string;
  lStopwatch: TStopwatch;
  lSuccess: Boolean;
  ResultText: string;
  i: Integer;
begin
  WriteLog('=== BC Connection Test started (via submodule) ===');
  WriteLog('  BC_BASEURL: ' + edBCBaseURL.Text);
  WriteLog('  BC_COMPANY_URL (Tenant): ' + edBCCompanyURL.Text);
  WriteLog('  BC_USERNAME (Client ID): ' + edBCUser.Text);
  WriteLog('  BC_PASSWORD (Client Secret): ****');
  WriteLog('  BC_ENVIRONMENT: ' + edEnvironment.Text);
  WriteLog('  BC_ACTIVECOMPANYID: ' + edBCActiveCompany.Text);
  WriteLog('  BC_PORT: ' + edBCPOrt.Text);
  WriteLog('  Online Business Central: ' + edBusinessCentralKunde.Text);

  if edBCBaseURL.Text = '' then
  begin
    WriteLog('  ABORT: Base URL is empty');
    ShowMessage('Business Central Base URL is empty.');
    Exit;
  end;
  if edBCUser.Text = '' then
  begin
    WriteLog('  ABORT: Client ID is empty');
    ShowMessage('BC Username / Client ID is empty.');
    Exit;
  end;
  if edBCPassword.Text = '' then
  begin
    WriteLog('  ABORT: Client Secret is empty');
    ShowMessage('BC Password / Client Secret is empty.');
    Exit;
  end;
  if edBCCompanyURL.Text = '' then
  begin
    WriteLog('  ABORT: Tenant ID is empty');
    ShowMessage('BC Company URL / Tenant ID is empty.');
    Exit;
  end;
  if edEnvironment.Text = '' then
  begin
    WriteLog('  ABORT: Environment is empty');
    ShowMessage('BC Environment is empty.');
    Exit;
  end;

  // Determine kind from customer name (same logic as main service)
  if UpperCase(edBusinessCentralKunde.Text) = 'KAUFMANN' then
    lKind := 0
  else if UpperCase(edBusinessCentralKunde.Text) = 'NYFORM' then
    lKind := 2
  else
  begin
    WriteLog('  ABORT: Unknown BC customer: ' + edBusinessCentralKunde.Text);
    ShowMessage('Unknown Business Central customer: ' + edBusinessCentralKunde.Text + #13#10 +
      'Must be KAUFMANN or NYFORM.');
    Exit;
  end;
  WriteLog('  Kind: ' + IntToStr(lKind));

  // Create setup using same class as main service
  // Port 0 or empty means no port
  if (Trim(edBCPOrt.Text) = '') or (Trim(edBCPOrt.Text) = '0') then
    lPort := ''
  else
    lPort := Trim(edBCPOrt.Text);

  // BaseURL must include /v2.0/ for online BC
  lBaseURL := Trim(edBCBaseURL.Text);
  if not lBaseURL.EndsWith('/') then
    lBaseURL := lBaseURL + '/';
  if not lBaseURL.EndsWith('v2.0/') then
    lBaseURL := lBaseURL + 'v2.0/';

  lBusinessCentralSetup := TBusinessCentralSetup.Create(
    lBaseURL,                     // aIP (BaseURL incl. /v2.0/)
    lPort,                        // aPort (empty = no port suffix)
    Trim(edBCCompanyURL.Text),    // aEndPointTenant
    Trim(edBCActiveCompany.Text), // aCompanyID
    Trim(edEnvironment.Text),     // aEnvironment
    Trim(edBCUser.Text),          // aUserName (Client ID)
    Trim(edBCPassword.Text),      // aPassword (Client Secret)
    lKind);

  WriteLog('  Setup created. BaseUrl: ' + lBusinessCentralSetup.BaseUrl);
  WriteLog('  CompaniesAPI: ' + lBusinessCentralSetup.CompaniesAPI);

  lBusinessCentral := TBusinessCentral.Create(ExtractFilePath(Application.ExeName));
  try
    SetUIEnabled(False);
    Screen.Cursor := crHourGlass;
    try
      // --- Test 1: GetCompanies ---
      SetTestStatus('1/10: Testing Companies...');
      WriteLog('  Calling GetCompanies...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetCompanies(lBusinessCentralSetup, lResponse);
      lStopwatch.Stop;
      WriteLog('  GetCompanies completed in ' + IntToStr(lStopwatch.ElapsedMilliseconds) + ' ms');

      if lSuccess then
      begin
        WriteLog('  SUCCESS: GetCompanies returned OK');
        ResultText := 'Business Central connection OK!' + #13#10 +
          'Environment: ' + Trim(edEnvironment.Text) + #13#10 +
          'Kind: ' + IntToStr(lKind) + ' (' + edBusinessCentralKunde.Text + ')' + #13#10 +
          'Companies call: ' + IntToStr(lStopwatch.ElapsedMilliseconds) + ' ms' + #13#10 +
          '-------------------------------------------' + #13#10 +
          'Companies found: ' + IntToStr((lResponse as TBCCompanies).Value.Count) + #13#10;

        WriteLog('  Companies count: ' + IntToStr((lResponse as TBCCompanies).Value.Count));

        for i := 0 to (lResponse as TBCCompanies).Value.Count - 1 do
        begin
          ResultText := ResultText + '  - ' +
            (lResponse as TBCCompanies).Value[i].Name +
            ' [' + (lResponse as TBCCompanies).Value[i].id + ']' + #13#10;
          WriteLog('    ' + IntToStr(i) + ': ' +
            (lResponse as TBCCompanies).Value[i].Name +
            ' (' + (lResponse as TBCCompanies).Value[i].id + ')');
        end;
        lResponse.Free;
        lResponse := nil;
      end
      else
      begin
        WriteLog('  FAILED: StatusCode=' +
          IntToStr((lResponse as TBusinessCentral_ErrorResponse).StatusCode) +
          ' StatusText=' + (lResponse as TBusinessCentral_ErrorResponse).StatusText);
        ResultText := 'GetCompanies FAILED:' + #13#10 +
          'Status: ' + IntToStr((lResponse as TBusinessCentral_ErrorResponse).StatusCode) +
          ' ' + (lResponse as TBusinessCentral_ErrorResponse).StatusText + #13#10;
        lResponse.Free;
        lResponse := nil;
        ShowMessage(ResultText);
        Exit;
      end;

      // --- Test 2: Custom API Endpoints ---
      if Trim(edBCActiveCompany.Text) = '' then
      begin
        ResultText := ResultText + #13#10 +
          'Skipping endpoint tests - no Active Company ID set.';
        WriteLog('  Skipping endpoint tests - no Active Company ID');
        ShowMessage(ResultText);
        Exit;
      end;

      ResultText := ResultText + #13#10 +
        '-------------------------------------------' + #13#10 +
        'Custom API Endpoints:' + #13#10;
      WriteLog('  Testing custom API endpoints...');

      // CashStatements
      SetTestStatus('2/10: Testing Cashstatements...');
      WriteLog('    Testing Cashstatements...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetkmCashstatements(lBusinessCentralSetup, lResponse, lKind);
      lStopwatch.Stop;
      lEndpointResult := TestEndpointResult('Cashstatements', lSuccess, lResponse, lStopwatch.ElapsedMilliseconds);
      ResultText := ResultText + lEndpointResult;
      FreeAndNil(lResponse);

      // Items
      SetTestStatus('3/10: Testing Item...');
      WriteLog('    Testing Item...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetkmItems(lBusinessCentralSetup, lResponse, lKind);
      lStopwatch.Stop;
      lEndpointResult := TestEndpointResult('Item', lSuccess, lResponse, lStopwatch.ElapsedMilliseconds);
      ResultText := ResultText + lEndpointResult;
      FreeAndNil(lResponse);

      // VariantId
      SetTestStatus('4/10: Testing VariantId...');
      WriteLog('    Testing VariantId...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetkmVariantIds(lBusinessCentralSetup, lResponse, lKind);
      lStopwatch.Stop;
      lEndpointResult := TestEndpointResult('VariantId', lSuccess, lResponse, lStopwatch.ElapsedMilliseconds);
      ResultText := ResultText + lEndpointResult;
      FreeAndNil(lResponse);

      // ItemSales
      SetTestStatus('5/10: Testing ItemSale...');
      WriteLog('    Testing ItemSale...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetkmItemSales(lBusinessCentralSetup, lResponse, lContent, lKind);
      lStopwatch.Stop;
      lEndpointResult := TestEndpointResult('ItemSale', lSuccess, lResponse, lStopwatch.ElapsedMilliseconds);
      ResultText := ResultText + lEndpointResult;
      FreeAndNil(lResponse);

      // ItemMoves
      SetTestStatus('6/10: Testing ItemMove...');
      WriteLog('    Testing ItemMove...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetkmItemMoves(lBusinessCentralSetup, lResponse, lKind);
      lStopwatch.Stop;
      lEndpointResult := TestEndpointResult('ItemMove', lSuccess, lResponse, lStopwatch.ElapsedMilliseconds);
      ResultText := ResultText + lEndpointResult;
      FreeAndNil(lResponse);

      // ItemStocks
      SetTestStatus('7/10: Testing ItemStock...');
      WriteLog('    Testing ItemStock...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetkmItemStocks(lBusinessCentralSetup, lResponse, lKind);
      lStopwatch.Stop;
      lEndpointResult := TestEndpointResult('ItemStock', lSuccess, lResponse, lStopwatch.ElapsedMilliseconds);
      ResultText := ResultText + lEndpointResult;
      FreeAndNil(lResponse);

      // ItemAccess
      SetTestStatus('8/10: Testing ItemAccess...');
      WriteLog('    Testing ItemAccess...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetkmItemAccesss(lBusinessCentralSetup, lResponse, lKind);
      lStopwatch.Stop;
      lEndpointResult := TestEndpointResult('ItemAccess', lSuccess, lResponse, lStopwatch.ElapsedMilliseconds);
      ResultText := ResultText + lEndpointResult;
      FreeAndNil(lResponse);

      // CostPrice
      SetTestStatus('9/10: Testing CostPrice...');
      WriteLog('    Testing CostPrice...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetkmCostprice(lBusinessCentralSetup, lResponse, lKind, FALSE, lContent);
      lStopwatch.Stop;
      lEndpointResult := TestEndpointResult('CostPrice', lSuccess, lResponse, lStopwatch.ElapsedMilliseconds);
      ResultText := ResultText + lEndpointResult;
      FreeAndNil(lResponse);

      // Vendors
      SetTestStatus('10/10: Testing Vendor...');
      WriteLog('    Testing Vendor...');
      lStopwatch := TStopwatch.StartNew;
      lSuccess := lBusinessCentral.GetkmVendors(lBusinessCentralSetup, lResponse, lKind);
      lStopwatch.Stop;
      lEndpointResult := TestEndpointResult('Vendor', lSuccess, lResponse, lStopwatch.ElapsedMilliseconds);
      ResultText := ResultText + lEndpointResult;
      FreeAndNil(lResponse);

      ShowMessage(ResultText);
    finally
      Screen.Cursor := crDefault;
      SetTestStatus('');
      SetUIEnabled(True);
      lResponse.Free;
    end;
  finally
    lBusinessCentral.Free;
    lBusinessCentralSetup.Free;
  end;
  WriteLog('=== BC Connection Test ended ===');
end;

procedure TfrmMain.btnParseURLClick(Sender: TObject);
var
  URL, lPath, lPart, lCompany: string;
  Parts: TArray<string>;
  i, iEnd: Integer;
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
      // BaseURL includes the version path segment
      lBaseURL := lBaseURL + '/' + lPart + '/';
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

  // Try to extract Company name from URL: Company('Name') or Company(%27Name%27)
  lCompany := '';
  i := Pos('Company(', URL);
  if i > 0 then
  begin
    lPart := Copy(URL, i + Length('Company('), Length(URL));
    // Remove leading quote variants
    if lPart.StartsWith('''') then
      lPart := Copy(lPart, 2, Length(lPart))
    else if lPart.StartsWith('%27') then
      lPart := Copy(lPart, 4, Length(lPart));
    // Find closing
    iEnd := Pos('''', lPart);
    if iEnd = 0 then
      iEnd := Pos('%27', lPart);
    if iEnd = 0 then
      iEnd := Pos(')', lPart);
    if iEnd > 0 then
      lCompany := Copy(lPart, 1, iEnd - 1);
    // URL-decode %20 etc.
    lCompany := lCompany.Replace('%20', ' ');
  end;

  // Apply to fields
  edBCBaseURL.Text := lBaseURL;
  edBCPOrt.Text := '0';
  edBCCompanyURL.Text := lTenant;
  if lEnvironment <> '' then
    edEnvironment.Text := lEnvironment;
  if lCompany <> '' then
    edBCActiveCompany.Text := lCompany;
  edBusinessCentralKunde.Text := 'NYFORM';

  ShowMessage('URL parsed successfully!' + #13#10 +
    '-----------------------------------' + #13#10 +
    'Fields updated:' + #13#10 +
    '  Base URL: ' + lBaseURL + #13#10 +
    '  Tenant: ' + lTenant + #13#10 +
    '  Environment: ' + lEnvironment + #13#10 +
    '  Company: ' + lCompany + #13#10 +
    '  Port: 0 (not used for cloud)' + #13#10 +
    '  Customer: NYFORM' + #13#10 +
    #13#10 +
    'Still needs manual input:' + #13#10 +
    '  - Client ID (OAuth2 App Registration)' + #13#10 +
    '  - Client Secret (OAuth2 App Registration)');
end;

procedure TfrmMain.ReadSettingsFromINIFile;
begin
  WriteLog('--- Reading settings from: ' + FiniFileName);
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
  WriteLog('--- Writing settings to: ' + FiniFileName);
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

  WriteLog('--- Settings saved successfully');
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
