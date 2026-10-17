unit Main;

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
  VCL.TMSFNCCustomComponent,
  VCL.TMSFNCCloudBase,
  VCL.TMSFNCCloudTranslation,
  Vcl.ExtCtrls,
  VCL.Forms;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    TMSFNCCloudTranslation1: TTMSFNCCloudTranslation;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    Label5: TLabel;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Button3: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Button4: TButton;
    Edit5: TEdit;
    Label6: TLabel;
    lbRegiao: TLabel;
    edtRegiao: TEdit;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TMSFNCCloudTranslation1GetSupportedLanguages(Sender: TObject;
      const ALanguages: TStringList;
      const ARequestResult: TTMSFNCCloudBaseRequestResult);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure edtRegiaoChange(Sender: TObject);
    procedure TMSFNCCloudTranslation1RequestComplete(Sender: TObject;
      const ARequestResult: TTMSFNCCloudBaseRequestResult);
  private
    { Private declarations }
    FTranslationLanguage: String;
    procedure DoTranslateMemo(const ARequest: TTMSFNCCloudTranslationRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult);
    procedure DoTranslateEdit(const ARequest: TTMSFNCCloudTranslationRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult);
    procedure DoDetectEdit(const ARequest: TTMSFNCCloudTranslationRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  TMSFNCCloudTranslation1.GetSupportedLanguages;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Memo2.Lines.Clear;
  var LText := TStringList.Create;
  try
    LText.Assign(Memo1.Lines);
    TMSFNCCloudTranslation1.Translate(LText, FTranslationLanguage, Self.DoTranslateMemo);
  finally
    LText.Free;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  TMSFNCCloudTranslation1.Translate(Edit3.Text, FTranslationLanguage, Self.DoTranslateEdit);
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  TMSFNCCloudTranslation1.Detect(Edit5.Text, Self.DoDetectEdit);
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
  FTranslationLanguage := 'en';
  label5.Caption := 'Selected Language:';
  ListBox1.Items.Clear;
  TMSFNCCloudTranslation1.Service := TTMSFNCCloudTranslationService(ComboBox1.ItemIndex);
  Memo2.Lines.Clear;
  Edit4.Text := '';
  Label6.Caption := 'Detected Language:';
  lbRegiao.Enabled := TMSFNCCloudTranslation1.Service = tsMicrosoft;
  edtRegiao.Enabled := lbRegiao.Enabled;
  Self.Edit1Change(Sender);
  Self.Edit2Change(Sender);
  Self.edtRegiaoChange(Sender);
end;

procedure TForm2.DoDetectEdit(const ARequest: TTMSFNCCloudTranslationRequest;
  const ARequestResult: TTMSFNCCloudBaseRequestResult);
begin
  if ARequest.Detections.Count > 0 then
    Label6.Caption := 'Detected Language: ' + ARequest.Detections[0].SourceLanguage;
end;

procedure TForm2.DoTranslateEdit(
  const ARequest: TTMSFNCCloudTranslationRequest;
  const ARequestResult: TTMSFNCCloudBaseRequestResult
  );
begin
  if ARequest.Translations.Count > 0 then
    Edit4.Text := ARequest.Translations[0].TranslatedText;
end;

procedure TForm2.DoTranslateMemo(
  const ARequest: TTMSFNCCloudTranslationRequest;
  const ARequestResult: TTMSFNCCloudBaseRequestResult
  );
begin
  for var I := 0 to Pred(ARequest.Translations.Count) do
    Memo2.Lines.Add(ARequest.Translations[I].TranslatedText);
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
  TMSFNCCloudTranslation1.APIKey := Trim(Edit1.Text);
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin
  TMSFNCCloudTranslation1.ServiceEndPoint := Trim(Edit2.Text).TrimRight(['/']);
end;

procedure TForm2.edtRegiaoChange(Sender: TObject);
begin
  if TMSFNCCloudTranslation1.Service = tsMicrosoft then
    TMSFNCCloudTranslation1.ServiceRegion := Trim(edtRegiao.Text).ToLower
  else
    TMSFNCCloudTranslation1.ServiceRegion := '';
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Self.ComboBox1Change(Sender);
end;

procedure TForm2.ListBox1Click(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0) and (ListBox1.ItemIndex <= Pred(ListBox1.Items.Count)) then
  begin
    Label5.Caption := 'Selected Language: ' + ListBox1.Items.Names[ListBox1.ItemIndex];
    FTranslationLanguage := ListBox1.Items.Values[ListBox1.Items.Names[ListBox1.ItemIndex]];
  end;
end;

procedure TForm2.TMSFNCCloudTranslation1GetSupportedLanguages(Sender: TObject;
  const ALanguages: TStringList;
  const ARequestResult: TTMSFNCCloudBaseRequestResult);
begin
  ListBox1.Items.Assign(ALanguages);
end;

procedure TForm2.TMSFNCCloudTranslation1RequestComplete(Sender: TObject;
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
