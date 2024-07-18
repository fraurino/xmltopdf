unit uXMLtoPDF;

interface

uses
IniFiles, ShellAPI, FileCtrl , Windows, Messages, SysUtils, Variants, Classes, Graphics,
Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls,System.Zip, System.IOUtils ,

{uses clientdataset}
Data.DB, Datasnap.DBClient, Datasnap.Provider,

{uses adicionais}
XMLDoc, zlib, Spin, OleCtrls, SHDocVw,

{uses ACBr}
ACBrNFe, pcnConversao, ACBrUtil, ACBrNFeDANFEClass, ACBrNFeDANFeESCPOS,ACBrBase, ACBrDFe, XMLIntf,
ACBrMail, ACBrNFeDANFeRLClass,ACBrDANFCeFortesFr, ACBrPosPrinter, ACBrDFeReport, ACBrDFeDANFeReport,
ACBrIntegrador, ACBrNFeDANFEFR,pcnConversaoNFe,ACBrDANFCeFortesFrA4,  ACBrSAT, ACBrSATExtratoClass,
ACBrSATExtratoReportClass, ACBrSATExtratoFortesFr, ACBrMDFeDAMDFeClass, ACBrMDFeDAMDFeRLClass, ACBrMDFe,
ACBrNFSe, ACBrNFSeDANFSeClass, ACBrNFSeDANFSeRLClass, ACBrCTeDACTEClass, ACBrCTeDACTeRLClass, ACBrCTe,
ACBrBPe, ACBrGNRE2, ACBrGNREGuiaClass, ACBrGNReGuiaRLClass,  ACBrNFSeDANFSeFR, pcnRetConsReciDFe,
  Vcl.Menus ;

type
TfrmGerador = class(TForm)
  Panel1: TPanel;
  btnBuscar: TSpeedButton;
  btnExportar: TSpeedButton;
  lblNotifica: TLabel;
  Panel2: TPanel;
  dadosanexos: TGroupBox;
  ProgressBar1: TProgressBar;
  GroupBox1: TGroupBox;
  CheckBox1: TCheckBox;
  edtDiretorio: TEdit;
  btnDir: TSpeedButton;
    Label1: TLabel;
    tipodados: TComboBox;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    acbrnota: TACBrNFe;
    MainMenu1: TMainMenu;
    Exportar1: TMenuItem;
    ExportarXML1: TMenuItem;
    PageControl1: TPageControl;
    tsArquivos: TTabSheet;
    ListBox1: TListBox;
    Chaves: TTabSheet;
    chavesdeacessos: TMemo;
  procedure btnBuscarClick(Sender: TObject);
  procedure btnLimparAnexosClick(Sender: TObject);
  procedure btnExportarClick(Sender: TObject);
  procedure FormCreate(Sender: TObject);
  procedure btnBuscarMouseEnter(Sender: TObject);
  procedure btnBuscarMouseLeave(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure CheckBox1Click(Sender: TObject);
  procedure btnDirClick(Sender: TObject);
    procedure chavesdeacessosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
private
  { Private declarations }
public
  { Public declarations }

  var
    DirExporta : String;
end;

var
frmGerador: TfrmGerador;
Arquivos : TStringList;

implementation

{$R *.dfm}

function GetFileList(const Path: string): TStringList;
var
   I: Integer;
   SearchRec: TSearchRec;
begin
   Result := TStringList.Create;
   try
     I := FindFirst(Path, 0, SearchRec);
     while I = 0 do
     begin
       Result.Add(copy(SearchRec.Name,1,Pos('.',SearchRec.Name)-1));  // alterar esta linha
       I := FindNext(SearchRec);
     end;
   except
     Result.Free;
     raise;
   end;
end;

function NomedoUsuario: String;
var
UserName: String;
UserNameLen: DWord;
begin
UserNameLen := 255;
SetLength (UserName, UserNameLen);
if GetUserName (PChar(UserName), UserNameLen) Then
 Result := Copy (UserName,1,UserNameLen - 1)
else
 Result := 'Desconhecido';
end;


Function VersaoExe: String;
type
PFFI = ^vs_FixedFileInfo;
var
F : PFFI;
Handle : Dword;
Len : Longint;
Data : Pchar;
Buffer : Pointer;
Tamanho : Dword;
Parquivo: Pchar;
Arquivo : String;
begin
Arquivo := Application.ExeName;
Parquivo := StrAlloc(Length(Arquivo) + 1);
StrPcopy(Parquivo, Arquivo);
Len := GetFileVersionInfoSize(Parquivo, Handle);
Result := '';
if Len > 0 then
begin
Data:=StrAlloc(Len+1);
if GetFileVersionInfo(Parquivo,Handle,Len,Data) then
begin
VerQueryValue(Data, '\',Buffer,Tamanho);
F := PFFI(Buffer);
Result := Format('%d.%d.%d.%d',
[HiWord(F^.dwFileVersionMs),
LoWord(F^.dwFileVersionMs),
HiWord(F^.dwFileVersionLs),
Loword(F^.dwFileVersionLs)]
);
end;
StrDispose(Data);
end;
StrDispose(Parquivo);
end;

Procedure SleepNoFreeze(PtimeOut:Integer);
var
LIni: Cardinal;
Lpass : Integer;
Begin
LIni := GetTickCount;
Lpass:= 0;
Application.ProcessMessages;
Repeat
  inc(Lpass);
  Sleep(1);
  if (Lpass > 10) then
  Begin
    Lpass:= 0;
    Application.ProcessMessages;
  end;
Until (GetTickCount - LIni) >= Cardinal(PtimeOut) ;
End;


procedure TfrmGerador.btnBuscarClick(Sender: TObject);
var
  i : integer;
  OpenDialog1 : TOpenDialog;
  FileNameWithoutExt: string;
Begin

     if tipodados.ItemIndex <> -1  then
     begin
        try
          Arquivos := TStringList.Create;
          ListBox1.Clear;

          OpenDialog1 := TOpenDialog.Create(self);
          {configurando para selecionar varios arquivos  [ofAllowMultiSelect = true ] }
          OpenDialog1.Options := [ofHideReadOnly,ofAllowMultiSelect,ofEnableSizing];
            case tipodados.itemIndex of
              0:
                begin
                  OpenDialog1.Title := 'Selecione a NFE';
                  OpenDialog1.DefaultExt := '*-nfe.XML';
                  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
                end;
              1:
                begin
                  OpenDialog1.Title := 'Selecione a SAT';
                  OpenDialog1.DefaultExt := '*.xml';
                  OpenDialog1.Filter := 'Arquivos SAT (*.xml)|*xml|Arquivos XML (*.xml)|*.XML|Todos os Arquivos (*.*)|*.*';
                end;
              2:
                begin
                  OpenDialog1.Title := 'Selecione o MDFe';
                  OpenDialog1.DefaultExt := '*-MDFe.xml';
                  OpenDialog1.Filter := 'Arquivos MDFe (*-MDFe.xml)|*-MDFe.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
                end;
              3:
                begin
                  OpenDialog1.Title := 'Selecione a NFSe';
                  OpenDialog1.DefaultExt := '*-NFSe.xml';
                  OpenDialog1.Filter :=
                  'Arquivos NFSe (*-NFSe.xml)|*-NFSe.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
                end;
              4:
                begin
                  OpenDialog1.Title := 'Selecione o CTe';
                  OpenDialog1.DefaultExt := '*-cte.xml';
                  OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
                end;

              5:
                begin
                  OpenDialog1.Title := 'Selecione o BPe';
                  OpenDialog1.DefaultExt := '*-bpe.xml';
                  OpenDialog1.Filter := 'Arquivos BPe (*-bpe.xml)|*-bpe.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
                end;

              6:
                begin
                  OpenDialog1.Title := 'Selecione o GNRE';
                  OpenDialog1.DefaultExt := '*-gnre.txt';
                  OpenDialog1.Filter := 'Arquivos GNRE (*-gnre.txt)|*-gnre.txt|Arquivos TXT (*.txt)|*.txt|Todos os Arquivos (*.*)|*.*';
                end;
            end;

          OpenDialog1.InitialDir := 'c:\' ;
          {abrindo tela de seleção de arquivos}
          if (OpenDialog1.Execute) then
          begin
             ProgressBar1.Position := 0 ;
            if OpenDialog1.Files.Count > 0 then
             begin
              ProgressBar1.Visible := not ProgressBar1.Visible;
              ProgressBar1.Max := OpenDialog1.Files.Count ;
              for I := 0 to OpenDialog1.Files.Count - 1 do
                begin
                  dadosanexos.Caption := '';
                  dadosanexos.Caption := '[Anexos] quantidade de arquivos ' + IntToStr(OpenDialog1.Files.Count) ;
                  Arquivos.Add(OpenDialog1.Files.Strings[i]);
                  ListBox1.Items.Add( OpenDialog1.Files.Strings[i]);

                  // Extrai o nome do arquivo completo
                  FileNameWithoutExt := ExtractFileName(OpenDialog1.Files.Strings[i]);
                  // Remove a extensão do arquivo
                  FileNameWithoutExt := ChangeFileExt(FileNameWithoutExt, '');
                  // Adiciona ao Memo
                  chavesdeacessos.Lines.Add(acbrutil.OnlyNumber(FileNameWithoutExt));

                  //ListBox1.Items.Add( ExtractFileName(OpenDialog1.Files.Strings[i]));
                end;
                ProgressBar1.Position := 0 ;
                ProgressBar1.Visible := not ProgressBar1.Visible;
              {enviando mensagem após envio dos arquivos}
             end
          end;

         FreeAndNil(OpenDialog1);
         btnExportar.Enabled := true;

        except
          on E: Exception do
          begin
             ShowMessage('erro de arquivo:'+ e.Message);
          end;
        end
     end
     else
       begin
        ShowMessage('Informe o tipo de documento');
        tipodados.DroppedDown := True;
       end;

End;

procedure TfrmGerador.btnBuscarMouseEnter(Sender: TObject);
begin
with lblNotifica do
begin
  Visible := true;
  Caption := (Sender as TSpeedButton).Hint ;
end;
end;

procedure TfrmGerador.btnBuscarMouseLeave(Sender: TObject);
begin
with lblNotifica do
begin
  Visible := false;
  Caption := '';
end;
end;

procedure TfrmGerador.btnDirClick(Sender: TObject);
var
Dir: string;
i : integer;
begin
SelectDirectory('Selecione uma pasta para exportar os arquivos pdf', 'C:\users\'+NomedoUsuario+'\', Dir);
if Dir <> '' then
  edtDiretorio.Text := Dir + '\'
else
  edtDiretorio.Text := '';
DirExporta          :=  edtDiretorio.Text ;
end;

procedure TfrmGerador.btnExportarClick(Sender: TObject);
var
Sua_Thread : TThread ;

  ACBrNFe1     :  TACbrNFe;
  ACBrNFCe1    :  TACbrNFe;
  ACBrSAT1     :  TACBrSAT;
  ACBrMDFe1    :  TACBrMDFe;
  ACBrCTe1     :  TACBrCTe;
  ACBrNFSe1    :  TACBrNFSe;
  ACBrGNRE1    :  TACBrGNRE;
  ACBrBPe1     :  TACBrBPe;
  {danfes}
  danfeCTe     : TACBrCTeDACTeRL;
  danfeGNRe    : TACBrGNREGuiaRL;
  danfenfe     : TACBrNFeDANFeRL;
  danfenfce    : TACBrNFeDANFCeFortes;
  danfeNFSe    : TACBrNFSeDANFSeRL;
  danfeMDFe    : TACBrMDFeDAMDFeRL;
  danfeSat     : TACBrSATExtratoFortes;
  I       : integer;
  vChave  : String;
  vMes    : string;
  vcnpj   : string;
  a       : integer;
  erro : string ;
begin
  if  (edtDiretorio.Text = '') and (CheckBox1.Checked = true) then
  begin
    Application.MessageBox('Diretório para exportar não foi informado.' +
    #13#10 + 'Verifique e tente novamente.', 'XML to PDF', MB_OK +
    MB_ICONINFORMATION);
    edtDiretorio.SetFocus;
    abort;
  end;

      try
          try
            {abrindo tela de seleção de arquivos}
                ProgressBar1.Max := ListBox1.Items.Count ;
                ProgressBar1.Position := 0 ;
                {enviando apenas várias imagens e 1 mensagem de texto}
                for i := 0 to ListBox1.Items.Count - 1 do
                  begin
                    ProgressBar1.Visible := true ;

                    Application.ProcessMessages;
                    {enviando arquivo por arquivo até concluir todos os arquivos selecionados}



                    {nfe}
                    ACBrNFe1          := TACBrNFe.Create(self);
                    danfenfe          := TACBrNFeDANFeRL.Create(self);
                    danfeNFe.ACBrNFe  := ACBrNFe1;
                    ACBrNFe1.NotasFiscais.Clear;

                    {nfce}
                    ACBrNFCe1         := TACBrNFe.Create(self);
                    danfeNFCe         := TACBrNFeDANFCeFortes.Create(self);
                    danfeNFCe.ACBrNFe := ACBrNFCe1;
                    ACBrNFCe1.NotasFiscais.Clear;

                    {sat}
                    ACBrSAT1           := TACBrSAT.Create(self);
                    danfeSat           := TACBrSATExtratoFortes.Create(self);
                    danfeSat.ACBrSAT   := ACBrSAT1;
                    ACBrSAT1.CFe.Clear;

                    {mdfe}
                    ACBrMDFe1          := TACBrMDFe.Create(self);
                    danfeMDFe          := TACBrMDFeDAMDFeRL.Create(self);
                    danfeMDFe.ACBrMDFe := AcbrMDFe1;
                    ACBrMDFe1.Manifestos.Clear;

                    {cte}
                    ACBrCTe1            := TACBrCTe.Create(self);
                    danfeCTe            := TACBrCTeDACTeRL.Create(self);
                    danfeCTe.ACBrCTE    := ACBrCTe1;
                    ACBrCTe1.Conhecimentos.Clear;

                    {NFSe}
                    ACBrNFSe1           := TACBrNFSe.Create(self);
                    danfeNFSe           := TACBrNFSeDANFSeRL.Create(self);
                    danfeNFSe.ACBrNFSe  := ACBrNFSe1;
                    ACBrNFSe1.NotasFiscais.Clear;

                   {gnre}
                    ACBrGNRE1           := TACBrGNRE.Create(self);
                    danfeGNRe           := TACBrGNREGuiaRL.Create(self);
                    danfeGNRe.ACBrGNRE  := ACBrGNRE1;
                    ACBrGNRE1.Guias.Clear;


                   {Bpe}
                    ACBrBPe1            := TACBrBPe.Create(self);

                    ACBrBPe1.Bilhetes.Clear;


                    {config component}
                    with ACBrNFe1.Configuracoes.Arquivos do
                    begin
                    Salvar             := true;
                    SepararPorMes      := true;
                    AdicionarLiteral   := true;
                    EmissaoPathNFe     := true;
                    SalvarEvento       := true;
                    SepararPorCNPJ     := true;
                    SepararPorModelo   := true;
                    PathSchemas        := ExtractFilePath(Application.ExeName) + '\schemas\';
                    end;

                   with ACBrNFCe1.Configuracoes.Arquivos do
                    begin
                    Salvar             := true;
                    SepararPorMes      := true;
                    AdicionarLiteral   := true;
                    EmissaoPathNFe     := true;
                    SalvarEvento       := true;
                    SepararPorCNPJ     := true;
                    SepararPorModelo   := true;
                    PathSchemas        := ExtractFilePath(Application.ExeName) + '\schemas\';
                    end;





                    case tipodados.itemIndex of
                      0:
                      begin
                        ACBrNFe1.Configuracoes.Geral.VersaoDF := ve200;
                        ACBrNFe1.NotasFiscais.LoadFromFile(ListBox1.Items[i]);
                      end;
                      1: ACBrSAT1.CFe.LoadFromFile(ListBox1.Items[i]);
                      2: ACBrMDFe1.Manifestos.LoadFromFile(ListBox1.Items[i]);
                      3: ACBrNFSe1.NotasFiscais.LoadFromFile(ListBox1.Items[i]);
                      4: ACBrCTe1.Conhecimentos.LoadFromFile(ListBox1.Items[i]);
                      5: ACBrBPe1.Bilhetes.LoadFromFile(ListBox1.Items[i]);
                      6: ACBrGNRE1.GuiasRetorno.LoadFromFile(ListBox1.Items[i]);
                    end;


                    listBox1.ItemIndex:=listBox1.Items.IndexOf(ListBox1.Items[i]);

                    vchave := '';
                    vmes   := '';
                    vcnpj  := '';

                    case tipodados.itemIndex of
                      0:
                      begin


                        vchave := Copy (ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, 44);

                        vmes   :=  FormatDateTime('yyyymm', ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi) ;
                        //'20'+Copy (vchave , 3, 4 ) ;
                       // vcnpj  := Copy (vchave , 7, 14 ) ;

                        vcnpj  := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CNPJCPF + ' - ' + ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.xNome ;

                        if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.modelo = 55 then  // nfe
                          begin

                            if CheckBox1.Checked = false then
                            begin
                              if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'files\' + vcnpj+'\nfe\pdf\'+ vmes) then
                              ForceDirectories(ExtractFilePath(Application.ExeName) + 'files\'+ vcnpj +'\nfe\pdf\'+ vmes)   ;
                              if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'files\' + vcnpj+'\nfe\xml\'+ vmes) then
                              ForceDirectories(ExtractFilePath(Application.ExeName) + 'files\'+ vcnpj +'\nfe\xml\'+ vmes)   ;
                            end
                            else
                            begin
                              if not DirectoryExists(edtDiretorio.Text + vcnpj+'\nfe\pdf\'+ vmes) then
                              ForceDirectories(edtDiretorio.Text + vcnpj+'\nfe\pdf\'+ vmes)   ;
                              if not DirectoryExists(edtDiretorio.Text + vcnpj+'\nfe\xml\'+ vmes) then
                              ForceDirectories(edtDiretorio.Text + vcnpj+'\nfe\xml\'+ vmes)   ;
                            end;

                           // danfeNFe.TipoDANFE              := tiRetrato;
                           // danfeNFe.ACBrNFe                := ACBrNFe1;

                            if (edtDiretorio.Text <> '') and (CheckBox1.Checked = true) then
                              begin
                                danfeNFe.PathPDF  := edtDiretorio.Text + vcnpj+'\nfe\pdf\'+ vmes+'\' ;
                                ACBrNFe1.NotasFiscais.Items[0].GravarXML(vchave+'-nfe.xml',edtDiretorio.Text + vcnpj+'\nfe\xml\'+ vmes+'\') ;
                              end
                            else
                              begin
                                danfeNFe.PathPDF := ExtractFilePath(Application.ExeName) + 'files\'+ vcnpj+'\nfe\pdf\'+ vmes+'\';
                                ACBrNFe1.NotasFiscais.Items[0].GravarXML(vchave+'-nfe.xml',ExtractFilePath(Application.ExeName) + 'files\'+ vcnpj+'\nfe\xml\'+ vmes+'\') ;
                              end;



                            danfeNFe.MostraStatus           := false;
                            ACBrNFe1.NotasFiscais.ImprimirPDF;

                            {alterando o nome do arquivo pdf}
                           // Memo1.Visible := true;
                            Memo1.Lines.Clear;

                            if CheckBox1.Checked = false then
                            begin
                            Memo1.Lines := GetFileList(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfe\pdf\'+ vmes+'\*.pdf');
                              for a := 0 to Memo1.Lines.Count - 1 do
                              begin
                              if vChave+'-nfe' = Memo1.Lines[a] then
                              begin
                              RenameFile(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfe\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                              ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfe\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                              end;
                              end;
                            end;

                            if CheckBox1.Checked = true then
                            begin
                            Memo1.Lines := GetFileList(edtDiretorio.Text + vcnpj+'\nfe\pdf\'+ vmes+'\*.pdf');
                              for a := 0 to Memo1.Lines.Count - 1 do
                              begin
                              if vChave+'-nfe' = Memo1.Lines[a] then
                              begin
                              RenameFile(edtDiretorio.Text + vcnpj+'\nfe\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                              edtDiretorio.Text + vcnpj+'\nfe\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                              end;
                              end;
                            end;




                          end
                        else
                        if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.modelo = 65 then  // nfce
                          begin

                            if CheckBox1.Checked = false then
                            begin
                              if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\nfce\pdf\'+ vmes) then
                              ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\nfce\pdf\'+ vmes)   ;
                              if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\nfce\xml\'+ vmes) then
                              ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\nfce\xml\'+ vmes)   ;
                            end
                            else
                            begin
                              if not DirectoryExists(edtDiretorio.Text + vcnpj+'\nfce\pdf\'+ vmes) then
                              ForceDirectories(edtDiretorio.Text + vcnpj+'\nfce\pdf\'+ vmes)   ;
                              if not DirectoryExists(edtDiretorio.Text + vcnpj+'\nfce\xml\'+ vmes) then
                              ForceDirectories(edtDiretorio.Text + vcnpj+'\nfce\xml\'+ vmes)   ;
                            end;

                            //danfeNFe.TipoDANFE              := tiRetrato;
                           // danfeNFe.ACBrNFe                := ACBrNFe1;

                            if (edtDiretorio.Text <> '') and (CheckBox1.Checked = true) then
                              begin
                                danfeNFe.PathPDF  := edtDiretorio.Text + vcnpj+'\nfce\pdf\'+ vmes+'\' ;
                                ACBrNFe1.NotasFiscais.Items[0].GravarXML(vchave+'-nfe.xml',edtDiretorio.Text + vcnpj+'\nfce\xml\'+ vmes+'\') ;
                              end
                            else
                              begin
                                //IncludeTrailingPathDelimiter(ACBrNFe1.DANFE.PathPDF)+'Numero '+ Copy (vchave , 27,9)+' - ' + vchave+'.pdf';
                                danfeNFe.PathPDF                := ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfce\pdf\'+ vmes+'\';
                                ACBrNFe1.NotasFiscais.Items[0].GravarXML(vchave+'-nfe.xml',ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfce\xml\'+ vmes+'\') ;
                              end;

                            danfeNFe.MostraStatus           := false;
                            ACBrNFe1.NotasFiscais.ImprimirPDF;


                            //Memo1.Visible := true;
                            Memo1.Lines.Clear;

                            if CheckBox1.Checked = false then
                            begin
                            Memo1.Lines := GetFileList(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfce\pdf\'+ vmes+'\*.pdf');
                              for a := 0 to Memo1.Lines.Count - 1 do
                              begin
                              if vChave+'-nfe' = Memo1.Lines[a] then
                              begin
                              RenameFile(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfce\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                              ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfce\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                              end;
                              end;
                            end;

                            if CheckBox1.Checked = true then
                            begin
                            Memo1.Lines := GetFileList(edtDiretorio.Text + vcnpj+'\nfce\pdf\'+ vmes+'\*.pdf');
                              for a := 0 to Memo1.Lines.Count - 1 do
                              begin
                              if vChave+'-nfe' = Memo1.Lines[a] then
                              begin
                              RenameFile(edtDiretorio.Text + vcnpj+'\nfce\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                              edtDiretorio.Text + vcnpj+'\nfce\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                              end;
                              end;
                            end;

                          end ;
                      end;
                      1:
                      begin
                        vchave := Copy (ACBrSAT1.CFe.infCFe.ID, 4, 44);

                        vmes   := '20'+Copy (vchave , 3, 4 ) ;


                        vcnpj  := ACBrSAT1.CFe.ide.CNPJ;

                        if CheckBox1.Checked = false then
                        begin
                          if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\sat\pdf\'+ vmes) then
                          ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\sat\pdf\'+ vmes)   ;
                          if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\sat\xml\'+ vmes) then
                          ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\sat\xml\'+ vmes)   ;
                        end
                        else
                        begin
                          if not DirectoryExists(edtDiretorio.Text + vcnpj+'\sat\pdf\'+ vmes) then
                          ForceDirectories(edtDiretorio.Text + vcnpj+'\sat\pdf\'+ vmes)   ;
                          if not DirectoryExists(edtDiretorio.Text + vcnpj+'\sat\xml\'+ vmes) then
                          ForceDirectories(edtDiretorio.Text + vcnpj+'\sat\xml\'+ vmes)   ;
                        end;

                        danfeSat.Filtro := fiPDF;
                        if (edtDiretorio.Text <> '') and (CheckBox1.Checked = true) then
                        begin
                          danfeSat.PathPDF  := edtDiretorio.Text + vcnpj+'\sat\pdf\'+ vmes+'\' ;
                        end
                        else
                        begin
                          danfeSat.PathPDF := ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\sat\pdf\'+ vmes+'\';
                        end;

                        danfeSat.MostraStatus           := false;
                        danfeSat.ImprimirExtrato;

                       {alterando o nome do arquivo pdf}
                        Memo1.Visible := true;
                        Memo1.Lines.Clear;

                        if CheckBox1.Checked = false then
                        begin
                          Memo1.Lines := GetFileList(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\sat\pdf\'+ vmes+'\*.pdf');
                          for a := 0 to Memo1.Lines.Count - 1 do
                          begin
                          if vChave+'-nfe' = Memo1.Lines[a] then
                          begin
                          RenameFile(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\sat\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                          ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\sat\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                          end;
                          end;
                        end;

                        if CheckBox1.Checked = true then
                        begin
                          Memo1.Lines := GetFileList(edtDiretorio.Text + vcnpj+'\sat\pdf\'+ vmes+'\*.pdf');
                          for a := 0 to Memo1.Lines.Count - 1 do
                          begin
                          if vChave+'-nfe' = Memo1.Lines[a] then
                          begin
                          RenameFile(edtDiretorio.Text + vcnpj+'\sat\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                          edtDiretorio.Text + vcnpj+'\sat\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                          end;
                          end;
                        end;
                      end;
                      2:
                      begin


                        vchave := Copy (ACBrMDFe1.Manifestos.Items[0].MDFe.infMDFe.Id, 4, 44);

                        vmes   := '20'+Copy (vchave , 3, 4 ) ;


                        vcnpj  := ACBrMDFe1.Manifestos.Items[0].MDFe.emit.CNPJCPF;



                        if CheckBox1.Checked = false then
                        begin
                        if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\mdfe\pdf\'+ vmes) then
                        ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\mdfe\pdf\'+ vmes)   ;
                        if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\mdfe\xml\'+ vmes) then
                        ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\mdfe\xml\'+ vmes)   ;
                        end
                        else
                        begin
                        if not DirectoryExists(edtDiretorio.Text + vcnpj+'\mdfe\pdf\'+ vmes) then
                        ForceDirectories(edtDiretorio.Text + vcnpj+'\mdfe\pdf\'+ vmes)   ;
                        if not DirectoryExists(edtDiretorio.Text + vcnpj+'\mdfe\xml\'+ vmes) then
                        ForceDirectories(edtDiretorio.Text + vcnpj+'\mdfe\xml\'+ vmes)   ;
                        end;


                        if (edtDiretorio.Text <> '') and (CheckBox1.Checked = true) then
                        begin
                        danfeMDFe.PathPDF  := edtDiretorio.Text + vcnpj+'\mdfe\pdf\'+ vmes+'\' ;
                        end
                        else
                        begin
                        danfeMDFe.PathPDF := ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\mdfe\pdf\'+ vmes+'\';
                        end;
                        danfeMDFe.MostraStatus           := false;
                        ACBrMDFe1.Manifestos.ImprimirPDF;
                                           {alterando o nome do arquivo pdf}
                        Memo1.Visible := true;
                        Memo1.Lines.Clear;

                        if CheckBox1.Checked = false then
                        begin
                          Memo1.Lines := GetFileList(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\mdfe\pdf\'+ vmes+'\*.pdf');
                          for a := 0 to Memo1.Lines.Count - 1 do
                          begin
                          if vChave+'-nfe' = Memo1.Lines[a] then
                          begin
                          RenameFile(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\mdfe\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                          ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\mdfe\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                          end;
                          end;
                        end;

                        if CheckBox1.Checked = true then
                        begin
                          Memo1.Lines := GetFileList(edtDiretorio.Text + vcnpj+'\mdfe\pdf\'+ vmes+'\*.pdf');
                          for a := 0 to Memo1.Lines.Count - 1 do
                          begin
                          if vChave+'-nfe' = Memo1.Lines[a] then
                          begin
                          RenameFile(edtDiretorio.Text + vcnpj+'\mdfe\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                          edtDiretorio.Text + vcnpj+'\mdfe\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                          end;
                          end;
                        end;
                      end;
                      3:
                      begin

                        vchave := ACBrNFSe1.NotasFiscais.Items[0].NFSe.ChaveNFSe;

                        vmes   := '20'+Copy (vchave , 3, 4 ) ;


                        vcnpj  := ACBrNFSe1.NotasFiscais.Items[0].NFSe.Prestador.Cnpj;


                        if CheckBox1.Checked = false then
                        begin
                          if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\nfse\pdf\'+ vmes) then
                          ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\nfse\pdf\'+ vmes)   ;
                          if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\nfse\xml\'+ vmes) then
                          ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\nfse\xml\'+ vmes)   ;
                        end
                        else
                        begin
                          if not DirectoryExists(edtDiretorio.Text + vcnpj+'\nfse\pdf\'+ vmes) then
                          ForceDirectories(edtDiretorio.Text + vcnpj+'\nfse\pdf\'+ vmes)   ;
                          if not DirectoryExists(edtDiretorio.Text + vcnpj+'\nfse\xml\'+ vmes) then
                          ForceDirectories(edtDiretorio.Text + vcnpj+'\nfse\xml\'+ vmes)   ;
                        end;


                        if (edtDiretorio.Text <> '') and (CheckBox1.Checked = true) then
                        begin
                        danfeNFSe.PathPDF  := edtDiretorio.Text + vcnpj+'\nfse\pdf\'+ vmes+'\' ;
                        end
                        else
                        begin
                        danfeNFSe.PathPDF := ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfse\pdf\'+ vmes+'\';
                        end;
                        danfeNFSe.MostraStatus           := false;
                        ACBrNFSe1.NotasFiscais.ImprimirPDF;
                        {alterando o nome do arquivo pdf}
                        Memo1.Visible := true;
                        Memo1.Lines.Clear;

                        if CheckBox1.Checked = false then
                        begin
                          Memo1.Lines := GetFileList(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfse\pdf\'+ vmes+'\*.pdf');
                          for a := 0 to Memo1.Lines.Count - 1 do
                          begin
                          if vChave+'-nfe' = Memo1.Lines[a] then
                          begin
                          RenameFile(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfse\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                          ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\nfse\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                          end;
                          end;
                        end;

                        if CheckBox1.Checked = true then
                        begin
                          Memo1.Lines := GetFileList(edtDiretorio.Text + vcnpj+'\nfse\pdf\'+ vmes+'\*.pdf');
                          for a := 0 to Memo1.Lines.Count - 1 do
                          begin
                          if vChave+'-nfe' = Memo1.Lines[a] then
                          begin
                          RenameFile(edtDiretorio.Text + vcnpj+'\nfse\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                          edtDiretorio.Text + vcnpj+'\nfse\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                          end;
                          end;
                        end;

                      end;

                      4:
                      begin

                        vchave := Copy (ACBrCTe1.Conhecimentos.Items[0].CTe.infCTe.Id , 4, 44);

                        vmes   := '20'+Copy (vchave , 3, 4 ) ;


                        vcnpj  := ACBrCTe1.Conhecimentos.Items[0].CTe.emit.CNPJ;



                        if CheckBox1.Checked = false then
                        begin
                          if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\cte\pdf\'+ vmes) then
                          ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\cte\pdf\'+ vmes)   ;
                          if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\' + vcnpj+'\cte\xml\'+ vmes) then
                          ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj +'\cte\xml\'+ vmes)   ;
                        end
                        else
                        begin
                          if not DirectoryExists(edtDiretorio.Text + vcnpj+'\cte\pdf\'+ vmes) then
                          ForceDirectories(edtDiretorio.Text + vcnpj+'\cte\pdf\'+ vmes)   ;
                          if not DirectoryExists(edtDiretorio.Text + vcnpj+'\cte\xml\'+ vmes) then
                          ForceDirectories(edtDiretorio.Text + vcnpj+'\cte\xml\'+ vmes)   ;
                        end;


                        if (edtDiretorio.Text <> '') and (CheckBox1.Checked = true) then
                        begin
                        danfeCTe.PathPDF  := edtDiretorio.Text + vcnpj+'\cte\pdf\'+ vmes+'\' ;
                        end
                        else
                        begin
                        danfeCTe.PathPDF := ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\cte\pdf\'+ vmes+'\';
                        end;
                        danfeCTe.MostraStatus           := false;
                        ACBrCTe1.Conhecimentos.ImprimirPDF;
                        {alterando o nome do arquivo pdf}
                        Memo1.Visible := true;
                        Memo1.Lines.Clear;

                        if CheckBox1.Checked = false then
                        begin
                          Memo1.Lines := GetFileList(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\cte\pdf\'+ vmes+'\*.pdf');
                          for a := 0 to Memo1.Lines.Count - 1 do
                          begin
                          if vChave+'-nfe' = Memo1.Lines[a] then
                          begin
                          RenameFile(ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\cte\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                          ExtractFilePath(Application.ExeName) + '\files\'+ vcnpj+'\cte\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                          end;
                          end;
                        end;

                        if CheckBox1.Checked = true then
                        begin
                          Memo1.Lines := GetFileList(edtDiretorio.Text + vcnpj+'\cte\pdf\'+ vmes+'\*.pdf');
                          for a := 0 to Memo1.Lines.Count - 1 do
                          begin
                          if vChave+'-nfe' = Memo1.Lines[a] then
                          begin
                          RenameFile(edtDiretorio.Text + vcnpj+'\cte\pdf\'+ vmes+'\'+Memo1.Lines[a]+'.pdf',
                          edtDiretorio.Text + vcnpj+'\cte\pdf\'+ vmes+'\'+ 'Nº '+Copy (Memo1.Lines[a] , 27,8) +' - '+ Memo1.Lines[a]+'.pdf' ) ;
                          end;
                          end;
                        end;

                      end;

                      5:
                      begin
                        ACBrBPe1.Bilhetes.ImprimirPDF;
                      end;

                      6:
                        begin
                          if (edtDiretorio.Text <> '') and (CheckBox1.Checked = true) then
                          danfeGNRe.PathPDF  := edtDiretorio.Text
                          else
                          danfeGNRe.PathPDF :=  ExtractFilePath(Application.ExeName) + '\pdf\gnre\';

                          danfeGNRe.MostrarStatus := false;
                          ACBrGNRE1.GuiasRetorno.ImprimirPDF;
                        end;
                    end;

                    ProgressBar1.Position := ProgressBar1.Position + i ;
                    ProgressBar1.max      := ProgressBar1.max + i ;
                    Application.ProcessMessages;

                  end;

                  {destroy component}
                 {nfe}
                freeAndNil(ACBrNFe1);
                freeAndNil(danfenfe);
                freeAndNil(ACBrNFCe1);
                freeAndNil(danfeNFCe);
                freeAndNil(ACBrSAT1);
                freeAndNil(danfeSat);
                freeAndNil(ACBrMDFe1);
                freeAndNil(danfeMDFe);
                freeAndNil(ACBrCTe1);
                freeAndNil(danfeCTe);
                freeAndNil(ACBrNFSe1);
                freeAndNil(danfeNFSe);
                freeAndNil(ACBrGNRE1);
                freeAndNil(danfeGNRe);
                freeAndNil(ACBrBPe1);
                freeAndNil(danfeGNRe);

                memo1.Clear;
                Memo1.Lines.Clear;
                ListBox1.Clear;
                ListBox1.Items.Clear;

                btnExportar.Enabled := false;


                ProgressBar1.Position := 0 ;
                ProgressBar1.Visible := false;
                Application.MessageBox('Processo realizado com sucesso!',
                'XML to PDF', MB_OK + MB_ICONINFORMATION);

          except
            on E: Exception do
            begin
              btnExportar.Enabled := True;
              showmessage('erro de arquivo[s]:'+ e.Message);
            end;
          end
        finally
          {finalizando , seleciona o componente ed_num.text}
        end;
end;

procedure TfrmGerador.btnLimparAnexosClick(Sender: TObject);
begin
 case Application.MessageBox(PChar('Confirma limpar todos os anexos?'),
   PChar('Inovatechi Sistemas'), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) of
   IDYES:
     begin
        FreeAndNil(Arquivos);
        ListBox1.Clear;
        Arquivos := TStringList.Create;
     end;
   IDNO:
     begin
        //frmEmailMenssage.SetFocus;
     end;
 end;
end;


procedure TfrmGerador.chavesdeacessosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Verifica se Ctrl+A foi pressionado
  if (Key = Ord('A')) and (ssCtrl in Shift) then
  begin
    // Seleciona todo o texto no Memo
    chavesdeacessos.SelectAll;
    // Previne o processamento adicional da tecla
    Key := 0;
  end;
end;

procedure TfrmGerador.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    begin
      edtDiretorio.Enabled  := True  ;
      edtDiretorio.Text     :=  '';
      edtDiretorio.SetFocus;
      DirExporta            :=  '';
    end
  else
    begin
      edtDiretorio.Enabled  := false;
      edtDiretorio.Text     := '';
      DirExporta            :=  '';
    end;


  btnDir.Enabled :=  edtDiretorio.Enabled;
end;

{exporta dll caso nao exista no diretorio}
function FileDLL(ArqFile : string  ) : Boolean ;
var
 fs: TFileStream;
 rs: TResourceStream;
 s : string;

begin
 rs := TResourceStream.Create(hInstance, ArqFile, RT_RCDATA);
 s  := ExtractFilePath(Application.ExeName)+  ArqFile + '.dll';
 fs := TFileStream.Create(s,fmCreate);
 rs.SaveToStream(fs);
 fs.Free;
end;

procedure ExtractSchemasZip;
var
  lUnZipper: TZipFile;
  ExecutablePath: string;
  FileName, ExtractedFileName: string;
  ZipFilePath: string;
begin
    lUnZipper := TZipFile.Create;
    ExecutablePath := ExtractFilePath(Application.ExeName);
    ZipFilePath := ExecutablePath + 'schemas.zip';
    try
      lUnZipper.Open(ZipFilePath, zmRead);
      lUnZipper.ExtractAll(ExtractFilePath(ExecutablePath));
      lUnZipper.Close;
    finally
      FreeAndNil(lUnZipper);
    end;
end;

procedure TfrmGerador.FormCreate(Sender: TObject);
begin

  ExtractSchemasZip ;

  if not FileExists( ExtractFilePath(Application.ExeName) + 'libeay32.dll' ) then
  FileDLL('libeay32');

  if not FileExists( ExtractFilePath(Application.ExeName) + 'ssleay32.dll' ) then
  FileDLL('ssleay32');

  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\files\') then
  ForceDirectories(ExtractFilePath(Application.ExeName) + '\files\')  ;

  if ExtractFileName(Application.ExeName) <> 'XMLtoPDF.exe' then
  begin
    Application.MessageBox(PWideChar ('Aplicativo teve seu nome alterado.' + #13#10 +
    'Volte ao padrão ['+ExtractFileName(Application.ExeName)+'] e tente novamente.' ) , 'XML to PDF', MB_OK +
    MB_ICONWARNING);
    try
      WinExec(PAnsiChar('TaskKill -f -im '+ExtractFileName(Application.ExeName)), SW_HIDE);
      Application.Terminate;
    FINALLY
      WinExec(PAnsiChar('TaskKill -f -im '+ExtractFileName(Application.ExeName)), SW_HIDE);
      Application.Terminate;
    END;
  end;
end;

procedure TfrmGerador.FormShow(Sender: TObject);
begin
  Self.Caption := 'Exportador de XML para PDF - Documento fiscais' + ' | Desenvolvido por Aurino  | Revisão '+ VersaoExe
end;

end.
