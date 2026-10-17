unit Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  VCL.Forms,
  VCL.TMSFNCCustomComponent,
  VCL.TMSFNCCloudBase,
  VCL.TMSFNCCloudTranslation;

type
  TMainView = class(TForm)
    Panel1: TPanel;
    cBoxService: TComboBox;
    TMSFNCCloudTranslation1: TTMSFNCCloudTranslation;
    edtAPIKey: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtAPIEndpoint: TEdit;
    Label4: TLabel;
    lbRegion: TLabel;
    edtRegion: TEdit;
    Panel2: TPanel;
    Label5: TLabel;
    lbDetectLanguage: TLabel;
    btnSupportedLanguages: TButton;
    ListBox1: TListBox;
    btnTranslateMemo: TButton;
    mmTranslate: TMemo;
    mmTranslateResult: TMemo;
    btnTranslateEdit: TButton;
    edtTranslate: TEdit;
    edtTranslateResult: TEdit;
    btnDetectLanguage: TButton;
    edtDetectLanguage: TEdit;
    procedure cBoxServiceChange(Sender: TObject);
    procedure btnSupportedLanguagesClick(Sender: TObject);
    procedure TMSFNCCloudTranslation1GetSupportedLanguages(Sender: TObject; const ALanguages: TStringList;
      const ARequestResult: TTMSFNCCloudBaseRequestResult);
    procedure edtAPIEndpointChange(Sender: TObject);
    procedure edtAPIKeyChange(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure btnTranslateMemoClick(Sender: TObject);
    procedure btnTranslateEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDetectLanguageClick(Sender: TObject);
    procedure edtRegionChange(Sender: TObject);
    procedure TMSFNCCloudTranslation1RequestComplete(Sender: TObject; const ARequestResult: TTMSFNCCloudBaseRequestResult);
  private
    FTranslationLanguage: String;
    procedure DoTranslateMemo(const ARequest: TTMSFNCCloudTranslationRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult);
    procedure DoTranslateEdit(const ARequest: TTMSFNCCloudTranslationRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult);
    procedure DoDetectEdit(const ARequest: TTMSFNCCloudTranslationRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult);
  public

  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.btnSupportedLanguagesClick(Sender: TObject);
begin
  TMSFNCCloudTranslation1.GetSupportedLanguages;
end;

procedure TMainView.btnTranslateMemoClick(Sender: TObject);
begin
  mmTranslateResult.Lines.Clear;
  var LText := TStringList.Create;
  try
    LText.Assign(mmTranslate.Lines);
    TMSFNCCloudTranslation1.Translate(LText, FTranslationLanguage, Self.DoTranslateMemo);
  finally
    LText.Free;
  end;
end;

procedure TMainView.btnTranslateEditClick(Sender: TObject);
begin
  TMSFNCCloudTranslation1.Translate(edtTranslate.Text, FTranslationLanguage, Self.DoTranslateEdit);
end;

procedure TMainView.btnDetectLanguageClick(Sender: TObject);
begin
  TMSFNCCloudTranslation1.Detect(EdtDetectLanguage.Text, Self.DoDetectEdit);
end;

procedure TMainView.cBoxServiceChange(Sender: TObject);
begin
  FTranslationLanguage := 'en';
  label5.Caption := 'Selected Language:';
  ListBox1.Items.Clear;
  TMSFNCCloudTranslation1.Service := TTMSFNCCloudTranslationService(cBoxService.ItemIndex);
  mmTranslateResult.Lines.Clear;
  edtTranslateResult.Text := '';
  lbDetectLanguage.Caption := 'Detected Language:';
  lbRegion.Enabled := TMSFNCCloudTranslation1.Service = tsMicrosoft;
  edtRegion.Enabled := lbRegion.Enabled;
  Self.edtAPIKeyChange(Sender);
  Self.edtAPIEndpointChange(Sender);
  Self.edtRegionChange(Sender);
end;

procedure TMainView.DoDetectEdit(const ARequest: TTMSFNCCloudTranslationRequest;
  const ARequestResult: TTMSFNCCloudBaseRequestResult);
begin
  if ARequest.Detections.Count > 0 then
    lbDetectLanguage.Caption := 'Detected Language: ' + ARequest.Detections[0].SourceLanguage;
end;

procedure TMainView.DoTranslateEdit(
  const ARequest: TTMSFNCCloudTranslationRequest;
  const ARequestResult: TTMSFNCCloudBaseRequestResult
  );
begin
  if ARequest.Translations.Count > 0 then
    edtTranslateResult.Text := ARequest.Translations[0].TranslatedText;
end;

procedure TMainView.DoTranslateMemo(
  const ARequest: TTMSFNCCloudTranslationRequest;
  const ARequestResult: TTMSFNCCloudBaseRequestResult
  );
begin
  for var I := 0 to Pred(ARequest.Translations.Count) do
    mmTranslateResult.Lines.Add(ARequest.Translations[I].TranslatedText);
end;

procedure TMainView.edtAPIKeyChange(Sender: TObject);
begin
  TMSFNCCloudTranslation1.APIKey := Trim(edtAPIKey.Text);
end;

procedure TMainView.edtAPIEndpointChange(Sender: TObject);
begin
  TMSFNCCloudTranslation1.ServiceEndPoint := Trim(edtAPIEndpoint.Text).TrimRight(['/']);
end;

procedure TMainView.edtRegionChange(Sender: TObject);
begin
  if TMSFNCCloudTranslation1.Service = tsMicrosoft then
    TMSFNCCloudTranslation1.ServiceRegion := Trim(edtRegion.Text).ToLower
  else
    TMSFNCCloudTranslation1.ServiceRegion := '';
end;

procedure TMainView.FormCreate(Sender: TObject);
begin
  Self.cBoxServiceChange(Sender);
end;

procedure TMainView.ListBox1Click(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0) and (ListBox1.ItemIndex <= Pred(ListBox1.Items.Count)) then
  begin
    Label5.Caption := 'Selected Language: ' + ListBox1.Items.Names[ListBox1.ItemIndex];
    FTranslationLanguage := ListBox1.Items.Values[ListBox1.Items.Names[ListBox1.ItemIndex]];
  end;
end;

procedure TMainView.TMSFNCCloudTranslation1GetSupportedLanguages(Sender: TObject;
  const ALanguages: TStringList;
  const ARequestResult: TTMSFNCCloudBaseRequestResult);
begin
  ListBox1.Items.Assign(ALanguages);
end;

procedure TMainView.TMSFNCCloudTranslation1RequestComplete(Sender: TObject;
  const ARequestResult: TTMSFNCCloudBaseRequestResult);
begin
  if ARequestResult.Success then
    Exit;

  var LMessage := Format('Falha na API de traducao (HTTP %d).', [ARequestResult.ResponseCode]);
  var LDetails := Trim(ARequestResult.ResultString);
  if not LDetails.IsEmpty then
    LMessage := LMessage + sLineBreak + LDetails;
  MessageDlg(LMessage, mtError, [mbOK], 0);
end;

end.
